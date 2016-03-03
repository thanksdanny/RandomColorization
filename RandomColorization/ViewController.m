//
//  ViewController.m
//  RandomColorization
//
//  Created by Danny Ho on 3/3/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic, strong) AVAudioPlayer *audioPlayer; // 设置成property之后就能播放了

@end

@implementation ViewController

//- (AVAudioPlayer *)audioPlayer {
//    if (!_audioPlayer) {
//        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: error:nil];
//    }
//    return _audioPlayer;
//}

- (void)randomColor {
    NSLog(@"%s", __func__);
    CGFloat redValue = drand48();
    CGFloat blueValue = drand48();
    CGFloat greenValue = drand48();
    
    self.view.backgroundColor = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
}

#pragma mark - action
- (IBAction)playMusciButtonDidTouch {
    // mp3
    NSURL *bgMusic = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Ecstasy" ofType:@"mp3"]];
    @try {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgMusic error:nil];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
    
    // gradient
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(randomColor) userInfo:nil repeats:true];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:0.5 alpha:0.2].CGColor,
                          (__bridge id)[UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.4].CGColor,
                          (__bridge id)[UIColor colorWithRed:0 green:1 blue:0 alpha:0.3].CGColor,
                          (__bridge id)[UIColor colorWithRed:0 green:0 blue:1 alpha:0.3].CGColor,
                          (__bridge id)[UIColor colorWithWhite:0.4 alpha:0.2].CGColor];
    gradientLayer.locations = @[@(0.10), @(0.30), @(0.50), @(0.70), @(0.90)]; // 颜色分割线
    gradientLayer.startPoint = CGPointMake(0, 0); // 起始点
    gradientLayer.endPoint = CGPointMake(1, 1); // 结束点
    [self.view.layer addSublayer:gradientLayer];
    
}


#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

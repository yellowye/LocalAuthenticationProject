//
//  ViewController.m
//  LocalAuthenticationProject
//
//  Created by lihao on 14-6-3.
//  Copyright (c) 2014年 OkCoin. All rights reserved.
//

#import "ViewController.h"

#import "PushViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIButton *restBtn;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    self.myContext = [[LAContext alloc] init];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)restBtnClickAction:(id)sender {
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Enter your password!";
    if ([_myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [_myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                   localizedReason:myLocalizedReasonString
                             reply:^(BOOL success, NSError *error) {
                                 if (success) {
                                     // User authenticated successfully, take appropriate action
                                     NSLog(@"success");
                                     PushViewController * pushVC = [[PushViewController alloc]init];
                                     [self presentViewController:pushVC animated:YES completion:^{
                                         
                                     }];
                                 } else {
                                     // User did not authenticate successfully, look at error and take appropriate action
                                     /*
                                     typedef NS_ENUM(NSInteger, LAError)
                                     {
                                         /// Authentication was not successful, because user failed to provide valid credentials.
                                         LAErrorAuthenticationFailed = kLAErrorAuthenticationFailed,
                                         
                                         /// Authentication was canceled by user (e.g. tapped Cancel button).
                                         LAErrorUserCancel           = kLAErrorUserCancel,
                                         
                                         /// Authentication was canceled, because the user tapped the fallback button (Enter Password).
                                         LAErrorUserFallback         = kLAErrorUserFallback,
                                         
                                         /// Authentication was canceled by system (e.g. another application went to foreground).
                                         LAErrorSystemCancel         = kLAErrorSystemCancel,
                                         
                                         /// Authentication could not start, because passcode is not set on the device.
                                         LAErrorPasscodeNotSet       = kLAErrorPasscodeNotSet,
                                         
                                         /// Authentication could not start, because Touch ID is not available on the device.
                                         LAErrorTouchIDNotAvailable  = kLAErrorTouchIDNotAvailable,
                                         
                                         /// Authentication could not start, because Touch ID has no enrolled fingers.
                                         LAErrorTouchIDNotEnrolled   = kLAErrorTouchIDNotEnrolled,
                                     } NS_ENUM_AVAILABLE(10_10, 8_0);
                                     */
                            
                                     switch (error.code) {
                                         case kLAErrorUserFallback:
                                             //在这里添加各种情况的处理
                                             break;
                                         case kLAErrorAuthenticationFailed:
                                             //指纹错误两次以后，执行此情况
                                             break;
                                         default:
                                             break;
                                     }
                                 }
                             }];
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        NSLog(@"Can't Open the LocalizedAuthentication");
    }
}

@end

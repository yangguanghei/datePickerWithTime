//
//  ViewController.m
//  时间选择器
//
//  Created by apple on 2020/9/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ViewController.h"

#import <BRPickerView.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor greenColor];
  
  
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  

  NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  NSDate *currentDate = [NSDate date];
  NSDateComponents *comps = [[NSDateComponents alloc] init];
  [comps setYear:10];//设置最大时间为：当前时间推后十年
  NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
  [comps setYear:-1];//设置最小时间为：当前时间前推十年
  NSDate *miniDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//  NSDate * miniDate = [NSDate date];
  
  NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString * miniDateStr = [dateFormatter stringFromDate:miniDate];
  NSString * maxDateStr = [dateFormatter stringFromDate:maxDate];
  NSString * currentDateStr = [dateFormatter stringFromDate:currentDate];
  NSInteger startIndex = [self getDayArrayLeftDate:miniDateStr rightDate:currentDateStr].count - 1;
  NSArray *datearr = [self getDayArrayLeftDate:miniDateStr rightDate:maxDateStr];
  NSArray * array = @[datearr, @[@"01:00-02:00", @"02:00-03:00", @"03:00-04:00", @"04:00-05:00", @"05:00-06:00", @"06:00-07:00", @"07:00-08:00", @"08:00-09:00", @"09:00-10:00", @"10:00-11:00", @"11:00-12:00", @"12:00-13:00", @"13:00-14:00", @"14:00-15:00", @"15:00-16:00", @"16:00-17:00", @"17:00-18:00", @"18:00-19:00", @"19:00-20:00", @"20:00-21:00", @"21:00-22:00", @"22:00-23:00", @"23:00-24:00"]];
  [BRStringPickerView showMultiPickerWithTitle:@"选择时间" dataSourceArr:array selectIndexs:@[@(startIndex), @8] resultBlock:^(NSArray<BRResultModel *> * _Nullable resultModelArr) {
    NSLog(@"%@", resultModelArr[0].value);
    NSLog(@"%@", resultModelArr[1].value);
  }];
}

//获取两个日期之间的所有日期，精确到天

- (NSArray *)getDayArrayLeftDate:(NSString *)aLeftDateStr rightDate:(NSString *)aRightDateStr{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *aLeftDate = [dateFormatter dateFromString:aLeftDateStr];
    NSDate *aRightDate = [dateFormatter dateFromString:aRightDateStr];
    if (aLeftDate == aRightDate) {
        NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday |NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:aLeftDate];
        NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
        NSDateFormatter *dateday = [[NSDateFormatter alloc]init];
        [dateday setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateday stringFromDate:beginningOfWeek];
        return @[currentDateStr];
    }

    NSMutableArray *dayArray = [NSMutableArray arrayWithCapacity:0];
    NSDate *currentDate = aLeftDate;
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday |NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:currentDate];
    while ([currentDate compare:aRightDate] == NSOrderedAscending) {
        NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
        currentDate = beginningOfWeek;
        NSDateFormatter *dateday = [[NSDateFormatter alloc]init];
        [dateday setDateFormat:@"yyyy-MM-dd"];
        NSString *currentDateStr = [dateday stringFromDate:beginningOfWeek];
        [dayArray addObject:currentDateStr];
        [components setDay:([components day]+1)];
    }
    return dayArray;
  
}

@end

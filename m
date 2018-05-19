Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeESV61 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 17:58:27 -0400
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:45078
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752564AbeESV6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 17:58:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] i2c-mux-pca954x: Force reset on probe if available
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
 <bc56d669-b02f-a017-844d-e095bbbcb7cd@axentia.se>
 <350e9638-1127-c0e5-290b-9d04725c1b8e@topic.nl>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <a97e3a9a-9c3a-a172-ba7d-1b393b12a2af@axentia.se>
Date: Sat, 19 May 2018 23:58:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <350e9638-1127-c0e5-290b-9d04725c1b8e@topic.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0386.eurprd05.prod.outlook.com
 (2603:10a6:7:94::45) To DB6PR0202MB2773.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;3:l1RmDrGFfM6C7Q8S6FqBcA5T+D8UO4IdNu185htreCVb6AkHk4e4F3f+49KceUAOwvefeXfMN8xfX4XuJCgCf4EbTPMsLwhpUkweoM4+uy5vSqvRUJDZagu7WLj7C7LO5/+6QaFOv04XGv4Ptir9cM/Mlbe2NudrK2F1mr9vlSE2JXM0cKGAIXDJKR0tXi3OszMGPyAqvu3XZSjXrb7B/PbGg6JPVrO412av6sQrUxFwMiIy1LW7ZyM15o2OgHHp;25:6CqiriW+H9eE6gfJ6LusTa+qrrUd5+q6AmTnze1M7FgCbksDeQ2E5vO5Q8v5C8yCRz8sAsRTrNjETjZmOoWUDmMSLp8arMuP4BkA0SYaOiIp6wjqD59l8A4lsB004xcwEcEZShbMxa4WMcyf5zVZYfLjpOviZuodsY/DRlAmgR/IiVkX++igVLv1rkaXyUuEcHYb7dFncgAe6xkkWwA+BbqzJV1mb6Zw0byeYfWHQWLlTSzLS7xpV3lWndBmFppYkT71X0FixK7MalVAGxkG6pAGmLPjEJlJqOCU6UwEaklMq2vkXuYUP63vh2M3dzLiuZ61nuGgnjuLjJ7gDGPWsA==;31:l+CFhAXtOB4WX59zPExgPcs4k/Yqx5P6TsuZcw+pdKGUtvWKbnGXEld+YTieJqz6aJwVpKmIQZaaQ7zBjMkowzBBX+H2Vps6CCx1hAIwnXKEs2ioTjcOYs0UuA9Q/ujD0MmYoghJ+kMqu7X+4jKAZPAdPana2BMNLyttcU6mjLv2sG6yxN9eh+KCXa4E0eoq7qOEzNT23vYXswD8pJwtZ0JRIEE5qxZXnrE7dTG6/Zk=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2773:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27738B9A00F72A56DB1C68FBBC970@DB6PR0202MB2773.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0202MB2773;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;4:Cxx0N4AvyGlj6cGgIViL47DnL+HEgxGBfyqcwENO12MPnQr9s5daDGJ3UlrBxrydhu0fzD3plgsE5Gk5qQyr27ZoUeQaPQ2WuLP75oCnzCeI5CpZjaLDNVo9+knx1ZAGtCH9gl45ubMMLcUBIeMnwV9cCTNZNjVOTf7Wfk1Nj9OyzKzOAlgFINlQc6A3zbVyUQXrB5Tj9HT0amtxd48vvvrbKMWuXMare/7KtMWBJ0N6rZsgBPr78O9af3ZDBhQk6CvFLpFsVEwHhoZH3JjjMA==
X-Forefront-PRVS: 0677FFABBF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(346002)(39380400002)(366004)(396003)(376002)(377424004)(199004)(189003)(252514010)(106356001)(105586002)(65826007)(7736002)(25786009)(47776003)(6486002)(2906002)(305945005)(81156014)(53546011)(31686004)(478600001)(77096007)(26005)(386003)(64126003)(76176011)(5660300001)(8676002)(81166006)(97736004)(186003)(16526019)(36756003)(68736007)(8936002)(2486003)(52146003)(229853002)(36916002)(23676004)(52116002)(551934003)(6246003)(4326008)(6666003)(3260700006)(53936002)(50466002)(59450400001)(2616005)(956004)(58126008)(117156002)(476003)(16576012)(86362001)(11346002)(316002)(230700001)(6116002)(446003)(66066001)(74482002)(486006)(65956001)(15974865002)(65806001)(31696002)(3846002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2773;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzM7MjM6UXUxdUQzZGNWSEVoNlN5SFBZck83Q0ls?=
 =?utf-8?B?K1Qza2I0TnVROWxqNkp1QmJYcHBqTVRJM1VnZFdxZHNoU2ZuUGE5Tlp5Yi9N?=
 =?utf-8?B?K2xCOVhtL29ZSWpxd3R6SzBES0lwWjV3d0Q3VTZ2dm8xME5vaUx0M29BeEdt?=
 =?utf-8?B?OUNPb21iYXVleUpSNnpRalFZM1U1ZXJLazFmSm9QYU4rNEd5Wmg1d3JUTVhQ?=
 =?utf-8?B?eUJ4REZNcDA0RXRtWlBBMGloN3Y2cHFFb0QxTTMrU1pIaEE2em9SRWQrTktj?=
 =?utf-8?B?bVdEZTV0SmpObkJxTjBkOTFLSG1nYmRqelhHdDJVZ3lEYUhkS3FvbnBZdkR3?=
 =?utf-8?B?VWJLZ1RQWlhHYWdZWElUUk84QnRNMGxzVSt4WjgxRUtWWUMwZEl2THNxQ1kr?=
 =?utf-8?B?UDFSVmxvNEJPa0MvQzZnWmR1dEo5c3pNNlcvcUk3eXE3YW80ajZRSjJZMlhk?=
 =?utf-8?B?dDhQWWUxd0JWc3ZkRGNIenRNM2s3aDFGWEMvNnFSRGNCYzYyeStxWTFsR0tm?=
 =?utf-8?B?WnkzdlU2OUpMM2krd1I4YW9aVGZCQVFndlY1amhzUHZvbTdKd2o3d0tKZ2Zt?=
 =?utf-8?B?dGROVnZwMjR5c1hCTE9mMGkvcklmSlNuM1crZ0NmK2UyNmxQanM5WDhQQWQ4?=
 =?utf-8?B?VzNjNzF6VHlUSG9iQmdMbjdhWWMyb2g0WkorUTVGaUJZd1Z6ek5vdlM4L2JL?=
 =?utf-8?B?b0UraW5WOWh5REZoRGRXeXNmbVFmNFpNcnBSb3hXanppcHRKZzJtOGFxWGtS?=
 =?utf-8?B?N3VDZEpiazJ0N3pyK3hVbGRNUmZiT2tnZEswejBxSnJYVEZDaXBHeElYandn?=
 =?utf-8?B?S1V4bkFOYlM4QkcwUzJqUm9FRXlnbVBSUEwrWEJKNllsd0VDL0VIOXZvMGo0?=
 =?utf-8?B?TnZ4TkdoMzhIMTNETXFLSGh2cmFhM3hZNm9Tc3c0alpUb2FkZjRjZWI2amVa?=
 =?utf-8?B?WUNRZ2gzTDhhRnh5bjd6LzNiSmpRN0hDcTU4aTNudnFNS1RoK3dLSmJzWVgz?=
 =?utf-8?B?aC9LWjZEdUJ1U0l2WGpUMWVEeWZjU0FHcjlaZmtlR3ZxdmxPei9kR0xCSURS?=
 =?utf-8?B?cU10enJjRit1Ujg2RUhWN08xYjNPc1FCTEk4UFF2d2QrbVk5bWR5bFZtQzFo?=
 =?utf-8?B?STU4WENEMGtEVUtES3dNVGtZQXc2MDZFbXJxQWJxZmFQWDhtR2FHZHRjV1Jh?=
 =?utf-8?B?MlVYWDZOYjljMlc2Tm54Q1FHbDZGSUNxS0d6NDZOZDhTNGxncnYxUzZEZW5G?=
 =?utf-8?B?eWpOaDhFbkhEZm9WbVJUL1pUU3JrRnVnQXZQM3NKRGJSblZ2dmJWenFuUGM4?=
 =?utf-8?B?a1YyemdhN2RlZ1NIQnpER2FKNXFvYjRFZGo5aXRJTUdxUHNFTUJWRjlMcUZG?=
 =?utf-8?B?WmY3K0VzajdIakkyT3NzVE55K1M4cG5KWWhKZTZyTlFXOTJoOGdoS0ZRQy9h?=
 =?utf-8?B?K3lYMGVaMEpPNytsZ2QrZHRBMGhWYVdvVXhYZUo4NUhyckE4NFNCVFcwbWFi?=
 =?utf-8?B?S2orK2pwMk9ZL2NHU1dHSmhEVHd5cW9ZL3ZnVmdVMEk3ZE9Kc2crY3lhUnkr?=
 =?utf-8?B?N3J6aEdPeWM2WUxDNGQzbTZ4cXdGNlBGNnBoTWdQRDJpNElpOUpJNFMvdWpn?=
 =?utf-8?B?bE1xQkhHeFdhem92cXJDZ25ER0E5djNkUm1nQVJ5Q3FkZzUzZm9CL0tRY2FD?=
 =?utf-8?B?dGVLOVBOa1NyNTc2QnFwOFlsV0FaTTBlbmZRcVBabThpakhiOTREaVkrZHhX?=
 =?utf-8?B?Rng1OUhWNGoyL2FNTGJVNlAxanZWVWtZRUxhOXlhYU9PQW9IWlNIRTYrNjkz?=
 =?utf-8?B?aVhIVkYzUloxSjU0NE5COS9VVDZ1dVZMWmt3NjQ3enNDRXp0bzRGWVh1UEZJ?=
 =?utf-8?B?TXpuLzFEcmtUa253RkJEbUc4NFR5QXlOeVNIaGpFYTJQbWF0aW5iM0Fyd3E1?=
 =?utf-8?B?d3Z2by9RZkRrWXdOZzhURHFRUmx2MStpWnJaUGtrOHdBaEprTUU0cHo5THRi?=
 =?utf-8?B?TmFDQ0tUVXBDZmFmNlh3Tktkb3l6YW9PRTc5WUp2bUdSckNCRDl3MlNIUXVq?=
 =?utf-8?B?TjgwOTJDa25sZloyd1NUY0JXYVArU2d4Q3hhK1VkVjB3ZUJWTkM5LzZZWkI3?=
 =?utf-8?B?Z1hiRndkbEN2UzZvL0NCalpqK1g3YjZpNFZoOVpWYU9lMWJSQ25NWnp1TXc5?=
 =?utf-8?Q?Awc/OZKCOlC49HZhwBiAR9I+rZh36eywR5ggTZDfuVAg=3D?=
X-Microsoft-Antispam-Message-Info: qQWPB0OO3or5ifzafPlVQS3IQN74GrZwxTDwTXe2eTO4pwXde1o5D0fTsr69CGWnSD5HA8J3swDFl4yLIN77ZgTgIAP16K87tCNwlMljKB5eXB0tYywbQF0VGieEWpI15dq+wxfGLTSsGLyoMWXfJ9xXjThc0ZQ+a0OWOPJRQ87wIA5Dd14XgF2hdNaaBYa4
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;6:R8jJ7QYa3QItzJGVwZgmpv2pXuAdYny5eMLkZnHWYFd+4dsVpgZhDyNnVTR4h0tHRVu1vpA+2R2Zx/rm55Z56K+2hTkBPlhfXI08NDJ62SAqZaWa7EHHwPxcqJHaOe+LRoJ8Jp3ufw0xc9A+JlmNPVHeIqpCPMLP8h8c7gKk4gfoKv0wXyYgFbTfVkio2bQjp+v4UTxNou4lFNdrX7oczYqkjGgZ19SpUUKXcb1IH8kMre3k83hmrwKnNz/NZi+IvCNQLgwI08xGckHOghD6u3nwPOSdSQw9qR/lzGgwett8//eEDzEUNUPzN0rWYzrTcUXaU8LHiSo16GTEeAbYVCqeToFVkKvX6uTrGvlIRXk3aVSNhuT0ijm1Fg6Mu4oIlIjJBc9wzZpdMm3fzkBmsIQkm9vu39rKzKda52wgJnZbYVwUdwOTfIOx76gw5/pq3a3ZMbqSM9jTvw2Qi5D2JQ==;5:AUQoTKjwQ42KcHzhzh4oFNmayKGvFTP3tF0Pwor9q0Irf+K1Av+06OoEZIp4nTPev/jQrUJAcAjmjg1Wyqx/cbx0QOxxdMuhPwV+hiIer2ImcCNgdFQTkqlI6uExynVsubIZPG9X50PjZi9SPAe4lOVwRc93tqPamFU6UL8Dun0=;24:VmZcTHLEQy6H8mt0RZIILZRtIUEIyat727V5ipm1mtssbOQUI/8zeV8ghBQsWq81z3WItGZE0quRzju7132EH4GYzIrcur0LygZHrVw3lk8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;7:zmXkigvmuU66Is/XRN82YNzMW8a86fb3Lf8ntquUcsP772JbdBt6/yZjE8M4sKkjZdhtcKf3O9+2rtc8UVe0bICO49NP5pBc10Kmz4J1jonkxkqS90GC2mNbmKBPd91zwK5R88uRDB2PoxFlfwJvwCAEchNz6f8aM7G7VCm8LbNGwVWIdIaqVc4aV8PJiZn8iU9o/pk5MQQ+LEd6RTN1hR4sGsZBbvF5wSm3KlLSmzcmO2RbQ8CO70raICZ7V7qs
X-MS-Office365-Filtering-Correlation-Id: 3efc3d83-2822-4cdc-5fe4-08d5bdd3a144
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2018 21:58:18.0561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efc3d83-2822-4cdc-5fe4-08d5bdd3a144
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2773
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 10:06, Mike Looijmans wrote:
> On 08-05-18 08:36, Peter Rosin wrote:
>> On 2018-05-01 13:42, Mike Looijmans wrote:
>>> Instead of just hogging the reset GPIO into deactivated state, activate and
>>> then de-activate the reset. This allows for better recovery if the CPU was
>>> reset halfway through an I2C transaction for example.
>>
>> I can't see any problems with this, and a reset at load time can certainly
>> be a benefit. Some questions below though...
>>
>> Cheers,
>> Peter
>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>   drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
>>> index 09bafd3..13e10d0 100644
>>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
>>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
>>> @@ -36,6 +36,7 @@
>>>    */
>>>   
>>>   #include <linux/device.h>
>>> +#include <linux/delay.h>
>>>   #include <linux/gpio/consumer.h>
>>>   #include <linux/i2c.h>
>>>   #include <linux/i2c-mux.h>
>>> @@ -389,10 +390,17 @@ static int pca954x_probe(struct i2c_client *client,
>>>   	i2c_set_clientdata(client, muxc);
>>>   	data->client = client;
>>>   
>>> -	/* Get the mux out of reset if a reset GPIO is specified. */
>>> -	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
>>> +	/* Reset the mux if a reset GPIO is specified. */
>>> +	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
>>>   	if (IS_ERR(gpio))
>>>   		return PTR_ERR(gpio);
>>> +	if (gpio) {
>>> +		/* Datasheet specifies a 4 ns reset-low time */
>>> +		udelay(1);
>>
>> ndelay(4) ?
>>
> 
> I have several reasons for making it much much longer:
> - A true 4ns pulse might not make it through the GPIO controller (on some 
> chips, the GPIO controller runs at 1/10th of the CPU speed or even less)
> - Board designers tend to treat RESET signals as "DC", so a 250MHz pulse might 
> not make it through. There may be level converters and open-drain drives in 
> the signal path as well.
> - I've only looked it op on a few chips, others may have different values
> 
> I think best is to just remove the comment line, it doesn't really help.
> 
>>> +		gpiod_set_value_cansleep(gpio, 0);
>>> +		/* Datasheet specifies a 500 ns reset recovery time */
>>> +		udelay(1);
>>
>> ndelay(500) ?
> 
> Similar reasons as above.

Agreed, sounds sane.

Applied to i2c-mux/for-next with minor tweaks to the subject and comments.

Cheers,
Peter

>>
>>> +	}
>>>   
>>>   	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
>>>   	if (match)
>>>
>>
> 
> 
> 
> Kind regards,
> 
> Mike Looijmans
> System Expert
> 
> TOPIC Products
> Materiaalweg 4, NL-5681 RJ Best
> Postbus 440, NL-5680 AK Best
> Telefoon: +31 (0) 499 33 69 79
> E-mail: mike.looijmans@topicproducts.com
> Website: www.topicproducts.com
> 
> Please consider the environment before printing this e-mail
> 
> 
> 

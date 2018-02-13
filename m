Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966163AbeBMXG4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:06:56 -0500
Received: from mail-by2nam03on0084.outbound.protection.outlook.com ([104.47.42.84]:24545
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966002AbeBMXGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:06:50 -0500
Subject: Re: [PATCH] rtc: isl12026: Add driver.
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Daney <david.daney@cavium.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180212185915.25041-1-david.daney@cavium.com>
 <CAHp75VeMhKvv0SdMgy+ZdLcK7+aOTyKweg9VKOTYcb84vsn+NA@mail.gmail.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <9df50a4c-c73f-e66a-d5ed-ab381d743c32@caviumnetworks.com>
Date: Tue, 13 Feb 2018 15:06:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAHp75VeMhKvv0SdMgy+ZdLcK7+aOTyKweg9VKOTYcb84vsn+NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CY1PR07CA0022.namprd07.prod.outlook.com (10.166.202.32) To
 MWHPR07MB3184.namprd07.prod.outlook.com (10.172.96.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 299c441a-1a8a-4560-9eb0-08d5733675e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:MWHPR07MB3184;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3184;3:ol3C61ajg2AIQZEBbqwrCgqlWhwniNBPH8vsRou/aYR+sioZDIT/fjWzXQ/KQEJjsK/vg5ecqsucUzhUgBGSOZtpuNZhaMMTaQdb3dMmx2ST0NABsKEMI41zvL+PKkFPag9mm2sWhwqJ/Oh/iG5ZvHZATNFJZy6X1uC+fTYEHb6uqswsM6z9VmOnOWpnDC4KXLdcnmW8Ppr5Z4LQpbSbY8yBiX2DLNyjPhBikp6Vl7jVhiV1oeEm+ufJNJrqU6OZ;25:uLED/BR8zj3yM+filKSEfJOhaBxDvnm5XVoTHwiys+/vj1w5zIvPvbshNAXQoMZmCwPArcgs/Dq5JOjzek48kNVgx1e5USMrPRhCioSRvMaVq2J5flnom5uJb7ssVgUd1GQ60QnhEvcFfCP0w+c59wd7J4JQanAtTNXJZL2vagpNgbm5UK7bucXfnX/VGEvAzbBfdbXUM99RQtPglLUEjTq3opTOtsDBWhLbtrtxxHOEJNCKPIKHOzW0SdtpX0V9kvh/QuvmM9FkHTjIfjZZLtHDKWIjvGpG1+23jnQYK8u9lNw0bCY5SDuhcqcY8m8wAi2fQQ/1Cx/sfWRLalZ9ow==;31:ebnhRYxZ2f1k1lmZ1WTKjuC7rBxiKdS7a+gZ/Ieks8OJonQXKCjvturVsPWGEXPiWgO2Xq+cHQSvWSD7VUGbTeqx3VZoBcCzbkLnYBuhSmA72BUSoUPEv27UeRCQHOcj1k4b5jXSIREsqEFSftIK4I4DAPokFfGgB/lqZIBoWOJIDLP0uKgZousm6kcWXa/UVw07kHQXZA3+kjmw8lOl6mvtvu71kjS+MUm5Cib4rTc=
X-MS-TrafficTypeDiagnostic: MWHPR07MB3184:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3184;20:ahjTVZQlb4thOB+tmHgootlOgc8RpoZF3KDJm2n1pdDNSJW74N7ZWMAsk3WKjF9jbZIQmjP6XP2zYdu9uA//HkMQ36f5ExRsKe15YlZLVO4xz737JYLojSXMJmABa4aECJ/3GGOz82K7YmqK2bobnT39E2o6AvlKCParR0eVnUE5+5cdO3vP615urNPNWSwk7YqQ+XCOvZvBgXEdK3thnoJ/A6j1H2QrOkcR/lX97ExidnOqGZz1I8EzNeX1Q7R1yD3KbyPM3xFSN6uSDZ31ut8YrHrdNLLihzhy5L3M9Qlfz4R8Gm70ROt5Eco+7uDpCmiYdLZDuvilp17tQKPhD+lQxxxYJ/eWky1bwCo3W+JMsfmk+2+xrK/mAecxlkTYlTnK3lHQ8beEjk5dXq1dPzAu0ml2PFrZJt8XS1kWrobQyJJ6TTKyTq7mUyGHeiNTvY+uzw3TagIz3RD9DfqhBcBqB7LZJVdpo8UsMTvbl9FFYUOST+KQc4PNHRcjMHlAWJbBZ+blOAqAwTxE9WnoCQIwiUfDXKqH7KjP9Dzag7wq7QMZHdR7wKtaCJpWQHwQUut7RzgcaeWjp9cebIFcjYjVsDS+lz30RPYPBvJGL8g=;4:jPBvHV4WPsTQrKDmTnEHwSWiNk24ojHQHfJqvbB+wy0VlpR4H8brWkXw3r8AtoZ0dl4XxGIcNr8qgL2vqDWvH/7gcrt+z9IO5kPSVm/pMEWZ5b38OK9hv55+ApTZ/Q+Wj1if1fD4A6CwpGN38158UMpAtIJWN9glW3qQl97ziJxU5oS7t/9lh27RU3GfsZFc50oMAXOcHuMdaTItDMdFvUhnZE7fLgUWaRYrIk8OSh5OT2Ysj9E5G3wGrMBhXSCG74A7gzl9PZ5fVyhc+vEPaA==
X-Microsoft-Antispam-PRVS: <MWHPR07MB31842A12BD17290FE9ABEC9897F60@MWHPR07MB3184.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR07MB3184;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB3184;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(376002)(39860400002)(396003)(51914003)(199004)(189003)(106356001)(16526019)(81166006)(81156014)(105586002)(305945005)(7736002)(39060400002)(59450400001)(69596002)(97736004)(4326008)(575784001)(186003)(386003)(6486002)(8676002)(6506007)(26005)(6346003)(2906002)(53546011)(25786009)(65956001)(58126008)(42882006)(6246003)(2950100002)(31686004)(68736007)(3846002)(65826007)(66066001)(83506002)(47776003)(53936002)(52116002)(110136005)(316002)(230700001)(53416004)(229853002)(478600001)(50466002)(64126003)(6512007)(2486003)(65806001)(5660300001)(76176011)(8936002)(23676004)(52146003)(72206003)(36756003)(54906003)(6116002)(31696002)(67846002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3184;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA3TUIzMTg0OzIzOjNtTThKakFBMjZBV2FxVnJKQ1ZRUXo1dFZV?=
 =?utf-8?B?QUlOVW0vSzdVZTU5d2hrcXVpZ0h4MkNrcFFWMjhycHloRFM5RGVrQ001S2ZL?=
 =?utf-8?B?dXBITGVkVDh0R01tNFllL0pmL0YzRUlUdzJCL25yT2NJR3ZFVXU1TDB0R21J?=
 =?utf-8?B?R1oyU0F4TU12UTRCaVRoSTlsc003Q0dRMUJhaUl5QkJiVzVaYVNMUU5HYXZu?=
 =?utf-8?B?ZTUrTnNJMkNLWksvcnliU0h3c1hZeUNoTGRZbXpzTGN1cHI5V09LYzRFT1dl?=
 =?utf-8?B?NmRLaEhPK0p3V09rczZIbFUxUWRHSjlmRUNzdmhRM3VGcHkzNjc5SkNXUHdC?=
 =?utf-8?B?UEY1dXVvRjZHV2pwQzRFWUNTUmUwb2w4Q1BjQjVUcXFyTWhxWjhQQjQyam5Z?=
 =?utf-8?B?WmM5MDRRS0k5VFppK1RaZkYxMXFlR0VIa093QnU4K2dsUHBacDdWZEhOUDZJ?=
 =?utf-8?B?dm1YaHF2Q3Zyb1g4NEYzcFZRNUZBUDgvM3pKUitRZ2o4UUk0ZUp2YVF6Zkd0?=
 =?utf-8?B?VW9Cb0J3aENZOUZKV0hFVHdhRm9iMjJ6SXBuSUJTdExDWmZ5dVRDWUphNFYy?=
 =?utf-8?B?VTB3Mm5EempYcmQxMll0eE05ODM0QnhPdko1cm0vTWx0Z3RyeEE5c000d0Z1?=
 =?utf-8?B?a0xqbFNuQUNxSm41QzdYdVRJcXZWMkVnWHRxM0swb1hHaUxvMmlRYXlQTUxI?=
 =?utf-8?B?SmtzdWlNVDZhODdqUldkS2lKenBzYTB1cUkrQTFqSVRtVEc4NFBEK2Z2eEU3?=
 =?utf-8?B?c1J0Rlh0MW1MUmRKUWNQTlpMZTBqSXlNNTduL3IwNVI1Y2RUZ2lvUmpJamhy?=
 =?utf-8?B?NzFQblNlaklCNVgwOVp5bTV4RU4xRHNJWENoamN5L0VwQ0ZPbERHK3h6TG1o?=
 =?utf-8?B?TWxENkhIWndHQ3hBVWZoa0F5WGRJaUFieHhzalZCak1HUlZuVFdiczR1NEdm?=
 =?utf-8?B?UTBaY0tYeExuMlc3S2dCUStBUTVlNmFjM2laTjFRcXFrNThXMURuUWVqUEpp?=
 =?utf-8?B?TnNPT0MyRjZJZmlVcGZ4UXV3TWZzdDl1ZTROU3pJMGU1aCtweW1FUGNZLzZm?=
 =?utf-8?B?cmUyOFVXZkdGeUhZaUpaYUNYTW5Eb1k0NmF2ZjNXVDQzUUwrV3BCVTNSY2tK?=
 =?utf-8?B?REtBcENTVjBxWFRUTktidWRFcVBldGpkL09ZVHFyei8wNlZqUFhuNXNTRVR3?=
 =?utf-8?B?UlAxNlFjK0hTcW9TNkRZcFNjSlRWY3RlaHovb2hBSXoyU3U2M0RtMTZPM3VD?=
 =?utf-8?B?cFl4aGFXTXN6clhqamVXc3VycWxvTDJvUHpmTE8veDVTZ1RUZ1U4VVVPRldC?=
 =?utf-8?B?NHRQS2V4SUdTSGo5K3pibjhKWVJ4dTlvdEVYOXNnR25WLzVjV0QxNnNxQUFT?=
 =?utf-8?B?c0V4N1J2eXNMU3AzOCtjSXJQbE9Ta1Z6TUhkTUNlSEZvTlR5RkZ3bGtlRUV2?=
 =?utf-8?B?NlA2WCtyS3hZSlYvOFB5ci9DUG9OelpxQWlDdUtuRWYwZEJaRktBQVpSRjUx?=
 =?utf-8?B?M2ZTWU9LWTFyZ3pObmprQTJ1KzRRU3pwWkdaWVlPejRyTDF2UzluTmcwNWV0?=
 =?utf-8?B?eDM1dUtYeWpvWSs4d2RkRkpQRUZYV1hxbjEvNUpYU2trMDcyRzhOZ1g5QUlO?=
 =?utf-8?B?aXdaUTNsN0JFR1hnQVhIVnJTdjhpOHBDdzdTanNyTmtaU09nYlYwVVVkRW1U?=
 =?utf-8?B?c05qVldXczJ0VzFwbElET1lVb2c2amtZS1lqaGQ5Tld2dGN2NGZEWi8vYlNs?=
 =?utf-8?B?ZG5naXZDbTZyYjJPeW5zUzZwUDE2b0trQXpxditoQXVDTzZOeFgzcmxlM2NW?=
 =?utf-8?B?VDg0ZEdydFFyNjBVMDIvWFBMYkRHbzI5UllOaGRiNVhJU0VRU3l6cEFoN1h6?=
 =?utf-8?B?NXpybHl0aUU1dzJjM0EvcjZSNzNqK3dCSlZFUGYxeXphL0RCelVPUnpXTDRq?=
 =?utf-8?B?SHRQdWhkSkhKNm50aVIxeGplbk51MDZWbW1UL0dVQ0NOTHVYVkp0Rk03d0tJ?=
 =?utf-8?B?WUtXYUN0RUxwZ2FCSFRSckdTQTN6dHlYWDRPU01nTGE1dk1rZXJESkdVYytp?=
 =?utf-8?B?emZwR1hQbDFxVGNWVjJ3MnRDN2hLMkdiTldRVnlFU05Kd201bThsWFhnb3J3?=
 =?utf-8?B?OHc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3184;6:n2iBWyM0mpkNXwxW066RTWD/DR0DLaCaSoU8i1je4IjKmOWjkNSr6+PjaeTTa/pCGgf7gz216qvM1Eu+YiK+04wtMFs3HlwgXeDMink+tpIXI4P5FsvU9aBt6J1pBFxvTJU+QV35NYe+FL2Fm00i9LRIIZCjbWAQlb0cwRDrOmWInPblrH4nGAzgHuxzifzpFNo4zKIOpskN3EQStp2NDvtMoDTijbqfNCt+oAtGtlt/GL8+Z41g3iOgXF7OBuY7jZ+9ipb3V+lQnSvdXFz2lD2jzppjSsdDZMmLN1/kyMYhQUjud6XtHF+uPYN5QBJG9oC6il6DdeXTdPVlZEbTGDrcOxL+msB8eNsA68C/1XA=;5:FCOllFScra21diuxR8lS6gaIE5gsA3Gkuq9QkRGgujCQl4yPREwNSGfE4cSoorNEYSyYn98L5vUIeZ7TF51H6hGSunx9GXSC7oX0f1izXUMFzoLsoev5OcSxyy7PWz9rzf+RfNu7rKKrsa6YLO+8h3aTc5rdkVNLArPLJ2Hsaqc=;24:E8NhBK/+ThzzQ708vzVCRMXVfF23zacLFjEqsMfwFpg9YjG7Oiilx8CqPzr3w3YbViFVHG8WnJV9fErTl8/Ty0TeVYaB5JlPQXgx+zV5mvk=;7:hZFDVCkYPmUsrd9jQCQH1iuGTIcF0X87yn6PZ/59PMy99IXtbBj47HQLvr0ey6QRNDVEsZ4rraU/1Za0lW8Q0sMrtX/LbiltiXWizi8P4ytVi4vUHY37Z1kbfK4lEleaOwAZhOlLxXQfjiUf11RgYhTzGFaVUhmLtJbdh7Im+q/gLQz/edL6g9sMdX3coh3XVpNWkn2oEb2Gv++x1sSTO0Z8lArc0jxiW1E3Uy3VkJ0/E9ThbhQ1hSj5cTFZ/8h+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 23:06:48.0528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299c441a-1a8a-4560-9eb0-08d5733675e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 07:54 AM, Andy Shevchenko wrote:
[...]
>> diff --git a/drivers/rtc/rtc-isl12026.c b/drivers/rtc/rtc-isl12026.c
>> new file mode 100644
>> index 000000000000..a5f04e0faceb
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-isl12026.c
>> @@ -0,0 +1,550 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * An I2C driver for the Intersil ISL 12026
>> + *
>> + * Copyright (c) 2018 Cavium, Inc.
>> + */
> 
>> +#include <linux/types.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/of_device.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/mutex.h>
>> +#include <linux/slab.h>
>> +#include <linux/bcd.h>
>> +#include <linux/i2c.h>
>> +#include <linux/rtc.h>
>> +#include <linux/of.h>
> 
> Perhaps in alphabetical order.

Done.

> 
>> +/* register offsets */
>> +#define ISL12026_REG_SC                0x30
>> +
>> +#define ISL12026_REG_SR                0x3f
>> +# define ISL12026_REG_SR_RTCF  BIT(0)
>> +# define ISL12026_REG_SR_WEL   BIT(1)
>> +# define ISL12026_REG_SR_RWEL  BIT(2)
>> +# define ISL12026_REG_SR_MBZ   BIT(3)
>> +# define ISL12026_REG_SR_OSCF  BIT(4)
>> +
>> +/* ISL register bits */
>> +#define ISL12026_HR_MIL                BIT(7)  /* military or 24 hour time */
>> +
> 
>> +#define ISL12026_REG_PWR       0x14
> 
> Perhaps keep it ordered? (0x14 < 0x30 obviously)

Done.

> 
>> +# define ISL12026_REG_PWR_BSW  BIT(6)
>> +# define ISL12026_REG_PWR_SBIB BIT(7)
> 
[...]
>> +
>> +static int isl12026_rtc_set_time(struct device *dev, struct rtc_time *tm)
>> +{
>> +       struct i2c_client *client = to_i2c_client(dev);
>> +       struct isl12026 *priv = i2c_get_clientdata(client);
> 
>> +       int rv = 0;
> 
>> +       u8 op[10];
>> +
>> +       struct i2c_msg msg = {
>> +               .addr   = client->addr,
>> +               .flags  = 0,
>> +               .len    = 1,
>> +               .buf    = op
>> +       };
> 
>> +
> 
> Redundant.
> 
>> +       int ret;
> 
> rv, ret, ... ???

I changed everything to use 'ret' to contain values returned from 
function calls, and 'rv' for the value the current function will return.

> 
>> +
>> +       mutex_lock(&priv->lock);
>> +
>> +       /* Set SR.WEL */
>> +       op[0] = 0;
>> +       op[1] = ISL12026_REG_SR;
>> +       op[2] = ISL12026_REG_SR_WEL;
>> +       msg.len = 3;
> 
>> +       ret = i2c_transfer(client->adapter, &msg, 1);
>> +       if (ret != 1) {
> 
> Can it return < 0? If so, why do you shadow the error code?

I think I fixed this driver wide.

> 
[...]
>> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +       if (ret != ARRAY_SIZE(msgs)) {
>> +               dev_err(&client->dev, "read error, ret=%d\n", ret);
>> +               rv = -EIO;
>> +               goto out;
>> +       }
>> +
> 
>> +       if (sr & ISL12026_REG_SR_RTCF)
>> +               dev_warn(&client->dev, "Real-Time Clock Failure on read\n");
>> +       if (sr & ISL12026_REG_SR_OSCF)
>> +               dev_warn(&client->dev, "Oscillator Failure on read\n");
> 
> Can you get them together?
> if not, perhaps consider 'else' keyword.

They are independent error indicators, I think it is best to test for 
them unconditionally like this.

> 
>> +
>> +       /* Second, CCR regs */
>> +       addr[0] = 0;
>> +       addr[1] = ISL12026_REG_SC;
>> +       msgs[1].len = sizeof(ccr);
>> +       msgs[1].buf = ccr;
>> +
>> +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>> +       if (ret != ARRAY_SIZE(msgs)) {
>> +               dev_err(&client->dev, "read error, ret=%d\n", ret);
>> +               rv = -EIO;
>> +               goto out;
>> +       }
>> +
> 
>> +       dev_dbg(&client->dev,
>> +               "raw data is sec=%02x, min=%02x, hr=%02x, mday=%02x, mon=%02x, year=%02x, wday=%02x, y2k=%02x\n",
>> +               ccr[0], ccr[1], ccr[2], ccr[3],
>> +               ccr[4], ccr[5], ccr[6], ccr[7]);
> 
> Ouch.
> 

Not essential, I removed it.


>> +
>> +       tm->tm_sec = bcd2bin(ccr[0] & 0x7F);
>> +       tm->tm_min = bcd2bin(ccr[1] & 0x7F);
>> +       if (ccr[2] & ISL12026_HR_MIL)
>> +               tm->tm_hour = bcd2bin(ccr[2] & 0x3F);
>> +       else
>> +               tm->tm_hour = bcd2bin(ccr[2] & 0x1F) +
>> +                       ((ccr[2] & 0x20) ? 12 : 0);
>> +       tm->tm_mday = bcd2bin(ccr[3] & 0x3F);
>> +       tm->tm_mon = bcd2bin(ccr[4] & 0x1F) - 1;
>> +       tm->tm_year = bcd2bin(ccr[5]);
>> +       if (bcd2bin(ccr[7]) == 20)
>> +               tm->tm_year += 100;
>> +       tm->tm_wday = ccr[6] & 0x07;
>> +
>> +       dev_dbg(&client->dev, "secs=%d, mins=%d, hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
>> +               tm->tm_sec, tm->tm_min, tm->tm_hour,
>> +               tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
>> +       rv = rtc_valid_tm(tm);
> 
>> +out:
>> +       mutex_unlock(&priv->lock);
> 
> Here one pattern, below another...
> 
> Hey, you have to learn being consistent.

I made them all like this one.  Single function exit point, with the 
unlock immediately before the return.


> 
>> +       return rv;
>> +}
>> +
>> +static const struct rtc_class_ops isl12026_rtc_ops = {
>> +       .read_time      = isl12026_rtc_read_time,
>> +       .set_time       = isl12026_rtc_set_time,
>> +};
>> +
>> +static int isl12026_nvm_read(void *p, unsigned int offset,
>> +                            void *val, size_t bytes)
>> +{
>> +       struct isl12026 *priv = p;
>> +       int r;
>> +       u8 addr[2];
>> +       struct i2c_msg msgs[] = {
>> +               {
>> +                       .addr   = priv->nvm_client->addr,
>> +                       .flags  = 0,
>> +                       .len    = sizeof(addr),
>> +                       .buf    = addr
>> +               },
>> +               {
>> +                       .addr   = priv->nvm_client->addr,
>> +                       .flags  = I2C_M_RD,
>> +                       .buf    = val
>> +               }
>> +       };
>> +
>> +       if (offset >= priv->nvm_cfg.size)
>> +               return 0; /* End-of-file */
>> +       if (offset + bytes > priv->nvm_cfg.size)
>> +               bytes = priv->nvm_cfg.size - offset;
>> +
> 
>> +       addr[0] = (offset >> 8) & 0xff;
>> +       addr[1] = offset & 0xff;
> 
> Useless & 0xff:s.

They may be redundant, but they clearly should the intention of shifting 
and masking the individual address component bytes out of the specified 
offset.  I would like to leave them in for clarity.

> 
> Isn't endianess handled by i2c core?


There is no concept of endianess in i2c, at the protocol level it it 
just an array of bytes transmitted to and from the device.  We have to 
put the bytes in the order expected by the target.

> 
>> +       msgs[1].len = bytes;
>> +       mutex_lock(&priv->lock);
> 
>> +       r = i2c_transfer(priv->nvm_client->adapter, msgs, ARRAY_SIZE(msgs));
>> +
>> +       mutex_unlock(&priv->lock);
>> +
>> +       if (r != ARRAY_SIZE(msgs)) {
> 
> A bit unusual pattern,
> 
> what about
> 
> mutex_lock();
> r = ...;
> if (r...) {
>   ...
>   mutex_unlock();
>   return -Exxx;
> }
> mutex_unlock();

Multiple exit points when using locks invites coding errors where you 
miss the unlock in some error path that is not tested.


> 
> ?
> 
>> +               dev_err(priv->nvm_cfg.dev, "nvmem read error, ret=%d\n", r);
>> +               return -EIO;
>> +       }
>> +
>> +       return bytes;
>> +}
>> +
>> +static int isl12026_nvm_write(void *p, unsigned int offset,
>> +                             void *val, size_t bytes)
>> +{
>> +       struct isl12026 *priv = p;
> 
>> +       int r;
> 
> Use consistent style, either r everywhere, or ret, or rc, or rval.

I hope it is better in the next version.

> 
>> +       u8 *v = val;
>> +       size_t chunk_size, num_written;
>> +       u8 payload[ISL12026_PAGESIZE + 2]; /* page + 2 address bytes */
>> +       struct i2c_msg msgs[] = {
>> +               {
>> +                       .addr   = priv->nvm_client->addr,
>> +                       .flags  = 0,
>> +                       .buf    = payload
>> +               }
>> +       };
>> +
>> +       if (offset >= priv->nvm_cfg.size)
>> +               return 0; /* End-of-file */
>> +       if (offset + bytes > priv->nvm_cfg.size)
>> +               bytes = priv->nvm_cfg.size - offset;
>> +
>> +       mutex_lock(&priv->lock);
>> +
>> +       num_written = 0;
>> +       while (bytes) {
>> +               chunk_size = round_down(offset, ISL12026_PAGESIZE) +
>> +                       ISL12026_PAGESIZE - offset;
>> +               chunk_size = min(bytes, chunk_size);
>> +               memcpy(payload + 2, v + num_written, chunk_size);
> 
>> +               payload[0] = (offset >> 8) & 0xff;
>> +               payload[1] = offset & 0xff;
> 
> Useless & 0xff:s.
> 
> Isn't endianess handled by i2c core?

See above.

> 
>> +               msgs[0].len = chunk_size + 2;
>> +               r = i2c_transfer(priv->nvm_client->adapter,
>> +                                msgs, ARRAY_SIZE(msgs));
>> +               if (r != ARRAY_SIZE(msgs)) {
>> +                       dev_err(priv->nvm_cfg.dev,
>> +                               "nvmem write error, ret=%d\n", r);
>> +                       break;
>> +               }
>> +               bytes -= chunk_size;
>> +               offset += chunk_size;
>> +               num_written += chunk_size;
>> +               msleep(ISL12026_NVMEM_WRITE_TIME);
>> +       }
>> +
>> +       mutex_unlock(&priv->lock);
>> +
>> +       return num_written > 0 ? num_written : -EIO;
>> +}
>> +
>> +static int isl12026_probe(struct i2c_client *client,
>> +                         const struct i2c_device_id *id)
>> +{
>> +       struct isl12026 *priv;
>> +       int pwr, requested_pwr;
>> +       int ret;
>> +       u32 bsw_val, sbib_val;
>> +       bool set_bsw, set_sbib;
> 
>> +       priv = devm_kzalloc(&client->dev, sizeof(struct isl12026), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
> 
> sizeof(*priv) ?

sure.

> 
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-bsw", &bsw_val);
>> +       set_bsw = (ret == 0);
>> +
>> +       ret = of_property_read_u32(client->dev.of_node,
>> +                                  "isil,pwr-sbib", &sbib_val);
>> +       set_sbib = (ret == 0);
>> +
>> +       /* Check if PWR.BSW and/or PWR.SBIB need specified values */
>> +
>> +       if (set_bsw || set_sbib) {
>> +               pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
>> +               if (pwr < 0)
>> +                       dev_err(&client->dev,
>> +                               "Error: Failed to read PWR %d\n", pwr);
> 
> ...and what? No recovery? No nothing except the message?

I will bail out of this setting or power handling if this happens, that 
seems like all that we could do.


> 
>> +
>> +               requested_pwr = pwr;
>> +
>> +               if (set_bsw) {
>> +                       if (bsw_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_BSW;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_BSW;
>> +               }
>> +               if (set_sbib) {
>> +                       if (sbib_val)
>> +                               requested_pwr |= ISL12026_REG_PWR_SBIB;
>> +                       else
>> +                               requested_pwr &= ~ISL12026_REG_PWR_SBIB;
>> +               }
>> +
>> +               if (pwr >= 0 && pwr != requested_pwr) {
>> +                       dev_info(&client->dev, "PWR: %02x\n", pwr);
>> +                       dev_info(&client->dev,
>> +                                "Updating PWR to: %02x\n", (u8)requested_pwr);
>> +                       isl12026_write_reg(client,
>> +                                          ISL12026_REG_PWR, requested_pwr);
>> +               }
>> +       }
> 
> Can you refactor above to a separate function?

Done.

> 
>> +       priv->rtc = devm_rtc_device_register(&client->dev, "rtc-isl12026",
>> +                                            &isl12026_rtc_ops, THIS_MODULE);
> 
>> +
> 
> Redundant empty line.
> 
>> +       ret = PTR_ERR_OR_ZERO(priv->rtc);
>> +       if (ret)
>> +               return ret;
> 
> 
>> +       if (IS_ENABLED(CONFIG_NVMEM)) {
> 
> I think you don't need this, see below.
> 
>> +               priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
>> +               if (!priv->nvm_client)
>> +                       return -ENOMEM;
> 
> i2c_new_secondary_device() ?
> 
>> +               priv->nvm_dev = nvmem_register(&priv->nvm_cfg);
>> +
> 
> Redundant empty line.
> 
>> +               if (!priv->nvm_dev)
> 
> Should it be IS_ERR() ?
> 
>> +                       return -ENOMEM;
> 
> After all rtc_nvmem_register() ?


Yes, I switched to using that.

> 
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int isl12026_remove(struct i2c_client *client)
>> +{
>> +       struct isl12026 *priv = i2c_get_clientdata(client);
>> +
> 
>> +       if (priv->nvm_dev)
> 
> How is it
> 
>> +               nvmem_unregister(priv->nvm_dev);
> 
> 
>> +       if (priv->nvm_client)
> 
> Check with v4.16-rc1. This is duplicate check.

Yes.


> 
>> +               i2c_unregister_device(priv->nvm_client);
>> +
>> +       return 0;
>> +}
> 
>> +#ifdef CONFIG_OF
> 
> Useless.
> 
>> +static const struct of_device_id isl12026_dt_match[] = {
>> +       { .compatible = "isil,isl12026" },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, isl12026_dt_match);
>> +#endif
>> +
> 
>> +static const struct i2c_device_id isl12026_id[] = {
>> +       { "isl12026", 0 },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, isl12026_id);
> 
> Useless. Use ->probe_new() approach.
> 
>> +#ifdef CONFIG_OF
> 
> Ugly and useless.
> 
>> +               .of_match_table = of_match_ptr(isl12026_dt_match),
>> +#endif
> 


Should be better in the next version.

Thanks for the review,
David Daney

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeCFOXt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:23:49 -0500
Received: from mail-co1nam03on0061.outbound.protection.outlook.com ([104.47.40.61]:30016
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750838AbeCFOXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:23:47 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH 3/3] i2c: xlp9xx: Add support for SMBAlert
To: Phil Reid <preid@electromag.com.au>, Jan Glauber <jglauber@cavium.com>,
        George Cherian <george.cherian@cavium.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de, Kamlakant Patel <kamlakant.patel@cavium.com>
References: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
 <1519737980-27997-3-git-send-email-george.cherian@cavium.com>
 <20180306083647.GA11729@wintermute>
 <b78f0a77-403d-a5e5-e274-8c4f08a2cd20@electromag.com.au>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <9885c24d-2212-62ac-f452-f37c51255df7@caviumnetworks.com>
Date: Tue, 6 Mar 2018 19:53:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b78f0a77-403d-a5e5-e274-8c4f08a2cd20@electromag.com.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BMXPR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::31) To BL2PR07MB2323.namprd07.prod.outlook.com
 (2a01:111:e400:c753::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cc18488-d0d6-40cd-4242-08d5836ddd88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:BL2PR07MB2323;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;3:H21W1hDHAkQfsyLrMKVFkiKAZC649fzp0pOJzyufl5mX8gI5lKjCgy3lgJmCk7SMCIjZG54Pespd5P5IfVPHvghataET0ynuYaROKILsZ0d9hZHB1IWIVAT5VBanUo9+EI4bRSCQTqRoCgpGip4fGl6nTXgX3T4GVAy6JAwHQv8V1JMqqSJtWFhJR6sjTep1f2uNVlUMYcwuFl5fzlNi83b7CzQa1OELvW2hlOxJ4LjBkZhHU2u2tmp4V9ZHrPmv;25:WSoUJppQv2dQc1CyeZPxnzUxWPhaSN0LQUvUHdhmI40pqJoCMu5uML2K97BeI+xH7QwhVbwlMmad9vgkN1ICydem07eP2YyF5WPVxRjQ9zNRqfw3S79R4L6/nJj4BXPHx7s24aSmVcm5rfJXUFQjolBWQPjZlm2hKBOIH62QkM4hZhzQwZKTQ+nwLrzX/T5R+MgP6tGe1MUU4df9ADZ6vxcQzEQ7K0gJ4/tbWeLZMcU2IYrThIiU5YigfO4QMVGxm86wMx1pM/s5kv3ZgCBiBcpjRyDJEn+VufJucKJEkj+iS2ye6xvZkTSo6N8MXohKafZsqEywIP4vuYW8+aTeoA==;31:B5cMcceDBTCDtirBeAlod+hiueTe3eToFoo8dcJgwxcMaXwzqTCPXJZIYSwFJoftl9S7TPG4S3XR2uErLGQs/ewcKtlPWORehSwZvyHZmBHad/u+mLY1RNBLymBCR55fGEVqESxQQwPjQ3J/EX9yKGYAiiZLfuB0vpo2uevboC2NWyLQ6bbdJjyrFATkdFjLbtCNfQvn0yGC++6tJVyVNbLAarWx3bhgqVYbTHo3tHA=
X-MS-TrafficTypeDiagnostic: BL2PR07MB2323:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;20:+CdHtIURtG94V96NghvI4r8o6A1euZ06jKzYWtFWNpzum0kymAuV8w+s99XalkWy07T/y+uIIZETt6uX+Q8yuHkTXpet0Ef173N8vPgRhMPU7XrnUWPDwS9F4xWbuFoDgdn9jpmhnuRhl6Nhdlkdjx1+gMrfQru/YEqBW7ggh7YbuEBLP+etNe6UNqS5u/S9QYUjJxyCesvQCqzZ7D2QY/VU0IJiY4dPT2cOZg+CyDcbSJKROAMUuzM1UMGB8/AzEs3aC3c5Jbrk8H/36KQJ2kZ7xJVKm5KRscfBmTiBXlmn8Yzi9p+27vg5dK/MNQSxGOEFGuJKLsQ2lcccDV4cFjt1J35iO/5eMohARWel+GQDnzl/vPrkTctxW92dmZ+ZYOkWJCMq+CyWXBnTcccdEkeXYPI32baEOvOLFT9L66hjy8UdaU/ukfWpkWE7zF/YFsxrLpT/6Sm2YA+hZaUS2CCoy4WRo2rJ8krBJPC0iAKCJIQ2KCqmkkHmogkwRjwiptqZEwpu6j7mlYehZY8yUNLqqiCnsl3KfF8imW6Wr2jI6dNf1FOWC/jM00SImXYsxSlcqlwUBPJCvQEZd4n9Imx69lqCs06sGNiVbJesZ48=;4:MHCUWGnGsYUzaOKRj30bJ86KUrIh/F0g/LRjS1i0g5126hQh1t0eImWeFlumZ2izZ/m4b8ItRTuhnLS/Lcf8TB85p0FXFVT7Ad8ndWLizM9pDNoKDDJa4DvSY69EyWa7DaeqOOiupbr8AQj93xPavR5ZI2ecWxmc7OSYkJOo3iFxIjpOuYqhR8iUmA++67+IET9RE4UoFS+Kis+ONejPB0dYFXocBIWjFXyKbhaS3PcQUIPqUSfy7KCtxWXqY4UlCV5Ox22U+wTu1PyN8hZd/Q==
X-Microsoft-Antispam-PRVS: <BL2PR07MB2323AE09F33EC0C7DAC05372F9D90@BL2PR07MB2323.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(6041288)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL2PR07MB2323;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2323;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(376002)(396003)(366004)(39380400002)(199004)(189003)(51914003)(106356001)(6116002)(3846002)(64126003)(72206003)(7736002)(26005)(6486002)(16526019)(76176011)(97736004)(31686004)(68736007)(77096007)(2906002)(6666003)(305945005)(8936002)(2870700001)(2950100002)(478600001)(8676002)(81166006)(5009440100003)(81156014)(58126008)(16576012)(316002)(110136005)(93886005)(4326008)(6246003)(67846002)(229853002)(31696002)(25786009)(53936002)(5660300001)(42882007)(105586002)(107886003)(36756003)(47776003)(50466002)(65826007)(23676004)(386003)(52116002)(52146003)(65806001)(66066001)(2486003)(65956001)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2323;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjA3TUIyMzIzOzIzOkNsNnJiajJjWDljaXZ2bFoxUHlTeStEVE95?=
 =?utf-8?B?MklYM0pCTHlQSllxeXNFKzFjUEFlejFDdEpWWkZBdFU4QkdIUndXZ1pNVWlN?=
 =?utf-8?B?ZmVGWFJUSXVlVWNVVytjcGdvNTVleHhMQkp5dm9lTWtuWndGTEQyV1k5NWtr?=
 =?utf-8?B?MmlDNlpsS1ROYmFvMmVmVFUyVkxzQjhzb2xjL1dOajRHdWM5aHlLL05vS3gz?=
 =?utf-8?B?dzRmVGJPZUVKblZCV1BITTY5R2laOExiSlp0Mkl1UnpHVEtDby9reUkzVzJp?=
 =?utf-8?B?Y3h6MkdVSzIvSVBaN1EydGZiQkJaY0pKYmh3emZqZ1FCSzN6WEFlUUlybzBO?=
 =?utf-8?B?ckF4RWZWT2ppVmhLMXN5QzI5dis5TFhBQnJqdkdUamo4OTBJZkpaRzQ2c3NW?=
 =?utf-8?B?d1RLZzY4VTVreUtGaGw0STFFcjVMYTNHdFBTYnY4blZ3cTFlZVVlcWJrVTky?=
 =?utf-8?B?YVA5enNQb3F6SVM2LzlsUE5peTlpSlhpZ2ZCaXoxMVlUWGFaUGlDS3k1MWtz?=
 =?utf-8?B?OHd2bDk4cktKWDZlVFhXNlRtN3lOeXAxL09MdzRoV2MySUd4Vmk2Y1g1NllW?=
 =?utf-8?B?ZTE4WEFXSDRMd3RVSXhlU3MxUjUxKzNYbjBNRlBMK2RJczFsaWR4UU5TVDlp?=
 =?utf-8?B?aDZYWkZvM0VFYWdkL2xoOExzUlFEK1ZwQlRXM0luVld2aWtpZDB6eCtzZGk0?=
 =?utf-8?B?UXJHZmxPcnVOR3F0U1VmbEhrTytXRExkYTBzYkJ4UUxicVUyY2d1R29yT2pB?=
 =?utf-8?B?bHJ0SVk2NXdCSlhCbmdrT2VzZC93ZWsyUWpRL0xsclhzZXc0Q0VwRlRPYjRI?=
 =?utf-8?B?L09FcEFrNndSbmFTMTIwU3BPRnU0bUlpT2VoRnFpWDRSbWh4Qk0wZ0k4Z1Rn?=
 =?utf-8?B?cUZMUTdvWG8xR0x2TnpGZEVEa280SVpHd2x2ZlBoQkpnbkdneVgvT2J0VE9W?=
 =?utf-8?B?OURVVjVSaWxRVUFmOFc1YTlyYUZ5ZFVOeTJxdmdCK1hJUzJYWENvU2Z2bjBK?=
 =?utf-8?B?cWkxV1l6aXRJVXFPVG56U2tYSFlVaFpBbmIvVmkrc3UzKzBobXZEeUZ2SVFU?=
 =?utf-8?B?V0owQjNTeitsUlVHSU1XL3hkZys2NHdicUlMUTYvNmFUTnRvZ0NEUlQzVFIx?=
 =?utf-8?B?SEltV3hHN3BRdnRaSE1Id2dLUWludlI3YmRiZmc3bzFWY1lKdWZLK0F1Ujd3?=
 =?utf-8?B?K1pFc1hRRGZQZGNDOWtkeUV2WUFvNWdHZ3M1R3Fxc0k4bldZdnpDRkVJbXZD?=
 =?utf-8?B?OFJoMWI4ZEtaNUdPUWs1cElGVEUvYkFwUXk1OHhNaktpa3oyWks2ZG1IcG9Q?=
 =?utf-8?B?bXBUanRpalgvZll0ZlNuYlh4d3VpQk9jSVd2bGhyRjlWY3p4d1Z3TjhyZW0v?=
 =?utf-8?B?YUsxbFpwU1pFWWU3SU9JQzFNaTVycERNN1ZwWUtWUXFMKzJvazNid05DZnFI?=
 =?utf-8?B?WmNuejA1RFJzVklYOFcwcmFlMjd0YWFGS0kzdjBlQ2JsTVE0cmRaMS9GYXgx?=
 =?utf-8?B?QnVMdzQ5dkpLd1RLdlliMFFEMU1Tbm8rR3NzYkVkVEhaNjQzNGJoNldOUGs1?=
 =?utf-8?B?T1RTa2U0eDRJYWxrbnR1VXhTMGJYSE92Uno5UXhJOVRVSWF3MkNxR203MHpq?=
 =?utf-8?B?cEdQdmY2ODV5SVFTZ05ORGZrZllHcy9OR3M2RFd0ZHRsRU0vZTBvZDBzUXNH?=
 =?utf-8?B?M0RCV0lreGhJWEMwa2xEeGlqSnh6QXJQYXVTdzNibzFUazh4MEczb29oTVRZ?=
 =?utf-8?B?WWRJbW8vaW8xYmxoUlA1d3VneDVBTm4zWnEvQmF4cWdRKzN2ZWVISTdEdFNt?=
 =?utf-8?B?dFlIUEJHb2JGRzRUQ1NFMllqU0pVbS94QmhkVXFGVEVnSG5jU0NSL2FmVVBY?=
 =?utf-8?B?WVNtcEM0MUJKTHBMUWkwZS82VENZazgwOG5jRm9udTZJMk5ZWmZ0MXk4TTNM?=
 =?utf-8?B?eS9nZzZlczRSU05KUzE5MVJJQkd4N0JNNzRxcmZhVGkwWGp2c1prcnNKeWds?=
 =?utf-8?Q?LLTNn5?=
X-Microsoft-Antispam-Message-Info: S6ZSdVNAzoy3VDC53Zu6TBMcgyEmfifzyBCDWD4HvtY9iv/5eYwgw21axhyeofoR9o9GDZ2c6Jl0TsLBIkR4ZwDO+GeNNGuyqQJNNveFS0R3/lHJwO8KJqU4QJA21UaIlOhmpbx+sBk2fomm4fq1mUdpAdNnq1z082tntsK6gxVn2Pj5dgF+CnJDzP1Tm6C7
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2323;6:Eq6pF6Mg9+gEfHeYjR2T1ln8J8vQrM+GeCDha40mg7BqApohYa5vGx3K8vkiFzb9ysMAQMr0QY/g9AYCHImquHfdOUnBwW2EtzFIgyhCTiWym7vA9EObMqahlgS7C6p3Bh386rTfem5HMvt8Xqpd/idhR6lF3pLB5QfW9MDMMDsHifAAn8NbiM+TieGqUTm96tXkN2hJnTkxzDwgVFh3cNDCZCRpufYTp8H/koddwFNKtky1G/8sLyghH8iVgRyGv4O3ajTiwO1a+yUgm4ti+nCuISpnUZtTAQA4dMp/UUoDg0QcOPko+HEHU81NRgvjTrTsm+QfgpFibgbvTINaKMaHMIxLA02MauIbbzQI9TU=;5:E+7zGyXxAs0rITDY5/l/mXolOB0uSzn7Is6nI9Af7PKDRaa1nvS/WLMpFHAWNVAFU3UH02UiMLIjj9p60LHKFiBX/2wIJ2onIitpIxFJLW4ec1aYyymcwMr4mYG0aPeqqi91nHdF0jMKL+hSC7jPk0rqurCr72InnmIDX3MJCaE=;24:efcwIm1pIW18TDlQ7kSRR/87GNFuIWzIbE6q8B16GT86g+MWKXpckc/iWaYGBfzALWar/qfwrRa9gsSEwmdwfW1HJoZPNet4Bq60LDbB9do=;7:mN7mMHzQrFett22UhMiDBKnmKlp9ZT7W8IaZwAAOi2SoHVUPOMd+DhYKbDvPC/t3Ha54bHJbhsqikjjy3vDXeWTfHl852eJtG22hYzXAyILNVdHZZ+TLWG+n9sF8/FKQb2axrLuPlG2upK3wKwiaQ2tDB0DxKR4LXwpvoUhc5Sc965IJ6kqqQuJl0vzUQ+8By0YvRKDnT9tzBIvlKx5VwKE7a8o9aZ08BczG6E8FL9MjlGFykXUGi1ryaltcK4Uk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 14:23:41.4317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc18488-d0d6-40cd-4242-08d5836ddd88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2018 02:48 PM, Phil Reid wrote:
> On 6/03/2018 16:36, Jan Glauber wrote:
>> On Tue, Feb 27, 2018 at 01:26:20PM +0000, George Cherian wrote:
>>> Add support for SMBus alert mechanism to i2c-xlp9xx driver.
>>> The second interrupt is parsed to use for SMBus alert.
>>> The first interrupt is the i2c controller main interrupt.
>>>
>>> Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>> ---
>>>   drivers/i2c/busses/i2c-xlp9xx.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c 
>>> b/drivers/i2c/busses/i2c-xlp9xx.c
>>> index eb8913e..9462eab 100644
>>> --- a/drivers/i2c/busses/i2c-xlp9xx.c
>>> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
>>> @@ -10,6 +10,7 @@
>>>   #include <linux/clk.h>
>>>   #include <linux/completion.h>
>>>   #include <linux/i2c.h>
>>> +#include <linux/i2c-smbus.h>
>>>   #include <linux/init.h>
>>>   #include <linux/interrupt.h>
>>>   #include <linux/io.h>
>>> @@ -84,6 +85,8 @@ struct xlp9xx_i2c_dev {
>>>       struct device *dev;
>>>       struct i2c_adapter adapter;
>>>       struct completion msg_complete;
>>> +    struct i2c_smbus_alert_setup alert_data;
>>> +    struct i2c_client *ara;
>>>       int irq;
>>>       bool msg_read;
>>>       bool len_recv;
>>> @@ -447,6 +450,21 @@ static int xlp9xx_i2c_get_frequency(struct 
>>> platform_device *pdev,
>>>       return 0;
>>>   }
>>> +static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
>>> +                  struct platform_device *pdev)
>>> +{
>>> +    if (!priv->alert_data.irq)
>>> +        return -EINVAL;
>>> +
>>> +    priv->alert_data.alert_edge_triggered = 0;
>>
>> Hi George,
>>
>> I think this is not needed anymore, see:
>> 9b9f2b8bc2ac i2c: i2c-smbus: Use threaded irq for smbalert
>>
>> --Jan
> 
> Yes.
> 
> And also all of this is not needed if named interrupts.
> - interrupt-names
>      "irq", "wakeup" and "smbus_alert" names are recognized by I2C core,
>      other names are    left to individual drivers.
> 
> presence of named irq smbus_alert should result in alert handler being
> created for that bus by the core
> 

Thanks for the comments I will send out a v2 for this patch.
>>
>>> +
>>> +    priv->ara = i2c_setup_smbus_alert(&priv->adapter, 
>>> &priv->alert_data);
>>> +    if (!priv->ara)
>>> +        return -ENODEV;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int xlp9xx_i2c_probe(struct platform_device *pdev)
>>>   {
>>>       struct xlp9xx_i2c_dev *priv;
>>> @@ -467,6 +485,10 @@ static int xlp9xx_i2c_probe(struct 
>>> platform_device *pdev)
>>>           dev_err(&pdev->dev, "invalid irq!\n");
>>>           return priv->irq;
>>>       }
>>> +    /* SMBAlert irq */
>>> +    priv->alert_data.irq = platform_get_irq(pdev, 1);
>>> +    if (priv->alert_data.irq <= 0)
>>> +        priv->alert_data.irq = 0;
>>>       xlp9xx_i2c_get_frequency(pdev, priv);
>>>       xlp9xx_i2c_init(priv);
>>> @@ -493,6 +515,10 @@ static int xlp9xx_i2c_probe(struct 
>>> platform_device *pdev)
>>>       if (err)
>>>           return err;
>>> +    err = xlp9xx_i2c_smbus_setup(priv, pdev);
>>> +    if (err)
>>> +        dev_info(&pdev->dev, "No active SMBus alert %d\n", err);
>>> +
>>>       platform_set_drvdata(pdev, priv);
>>>       dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
>>> -- 
>>> 2.1.4
>>
>>
> 
> 

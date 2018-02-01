Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbeBAOl2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:41:28 -0500
Received: from mail-ve1eur01on0094.outbound.protection.outlook.com ([104.47.1.94]:63053
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeBAOl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:41:26 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 0/2] check I2C device id for pca984x chips
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180122113657.32094-1-peda@axentia.se>
 <04535e9d-9ba4-2f27-e94c-12d877d26cda@cern.ch>
 <8549b310-ecfe-e60b-c7fc-fab7db2fd2f2@axentia.se>
 <318dc907-c091-a883-bf0c-346f32a66723@cern.ch>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <319e880e-8202-cb1c-fa59-b678eca3e847@axentia.se>
Date: Thu, 1 Feb 2018 15:41:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <318dc907-c091-a883-bf0c-346f32a66723@cern.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM5PR06CA0013.eurprd06.prod.outlook.com
 (2603:10a6:206:2::26) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c37187-4a60-4181-354e-08d56981dd6d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:KlandzZC0xR5OZSqPQLuWLq6XVWwXdYyxjn8F/gcKQo2uUIE6hDI8kvKNPy/rHf4zalqaoksqIf+MZrHsxQphX3OyHa9mBQYM4BEqJEN5oMxrDhQpUkvDswAlnXbkfIPlW9mKtj/bHINAu1FtIKb3LzP7p0Mzm6FXnJHuRHITsBlr2xyDK23Q0j+i51NztcPvjzh382byTXgI0mkr5+4M6MWhdIvgTrB0+BWc8BEema10fSRHQcW9kNfviIUSUEn;25:3bjaRgYxKg44C7CqfRa6/QdxHs2Hyf8ji8H1uuZRACYNSfnTSSGGyBWt2BQkqAKoTbz6Qv2Z0ec6nrwRlpCL/19HcWM3MIWlz7vQRb5bhxTyG/e54rSuiVIi4K/9VPlY0xqAxAjX28LZgkPIzafVOLEyusxnk2J+eS1GYluZadsjNkuRPGOkK0DOafGhEt4fx3muYULALDci1EQdA87fO3LrQqrHhH1QMGcUcPkeBqlUwilmynhipNJR61nYpP3e9t95IS/NqX/UBYu+BzGyt3g6EdSKNoNw4Brf+OKLhSSb2OLyC7c2RxKT2jTPlnzNOfl7z6YhIbaFZSd7rKdgNg==;31:wGr4zMyj+T5DWwBEEBSJJTbAdXbBqIqXsVWq03ACTlZ5GRvQfRC/EXDNmpL5KClBAoOjOEsw0lSP3VSY67XJH3TgSF43HNQYGOvQmCBvvSrRYmDQaH/esP2hDuJW6CA3XechDyH/wxwizYKO3z9m4LGtEfcnuU5iezoyFpLoCk92KGEb8I5ZX1ZSDPiWDqLBh7dElv6nw4cxycvI/J8W2Eaw/bzx/X811/ORrCX5XCE=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277876AD196AC441B47CF040BCFA0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6041288)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:1czKzoAAZjT5ccgEwhENqW8WwgChH8N3gWO9HZvjtXV34n5mXpeO1LS+igeqvgiaPIofFEDXOeDY920tRt4CcLep/L15jvYInZ/QDZgooPSdUM4zPpenQ+yzLccJpjXG96sVwZfTfUbMbloi6gN7Zc2ahHkCYHfs5G/UeMxd3RZb5twl5oAsPeiEzvR2adiqtiY5dpvL/WPHd/3ZB1MC5N5aohY2nWaosdGMVlXtSf0+4vPM+eihttE8l8rADWeHYJTSr+t+yK/8MtLxxz9rZw==
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(396003)(376002)(39830400003)(366004)(199004)(189003)(377424004)(65806001)(31686004)(106356001)(83506002)(6246003)(6916009)(36756003)(64126003)(93886005)(16526019)(229853002)(74482002)(53936002)(6486002)(5660300001)(105586002)(316002)(230700001)(6666003)(2906002)(86362001)(97736004)(77096007)(58126008)(16576012)(65826007)(6116002)(66066001)(52116002)(386003)(76176011)(81156014)(52146003)(81166006)(23676004)(186003)(68736007)(2486003)(3260700006)(8936002)(3846002)(117156002)(31696002)(4326008)(2950100002)(36916002)(8676002)(25786009)(7736002)(305945005)(47776003)(478600001)(53546011)(50466002)(26005)(59450400001)(65956001)(42262002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6V2RkWHMvdC83bUVtOEdmdXd3T2pjM1l4?=
 =?utf-8?B?ZzhndWJSYnpsRkRDTmlVaGk5aUpDd0w3ODZWM0lHRHRLOWxCUVk3WjBlK1Ex?=
 =?utf-8?B?eFpxWGM0ZDQ2bCt0dExnWWJsSHUrVFN1QjBZdHV0ZmcwSDdvbGFBWGw1bmkv?=
 =?utf-8?B?Tk5kRGxndDlXWnpNT1N0ZkJQdDVnTlJ5RXZtL3NiUERkQ1JNZzMrKzlWdEQ3?=
 =?utf-8?B?M000QWhxT001SENHR3NFVnR3bEVuVzFCMDg1VDdTTnFJZ2cvWXFMeldSdWRt?=
 =?utf-8?B?Qm85MHlrSUhmUzhlZ3RFcFRRTjB6Zm9INjBEUS92dHZiM3Voak9pdk1xSHdr?=
 =?utf-8?B?L2JrM1NTa3NTdmFZalZpMGZaVHJHVW90WGFmUDVLcENxdU51dU50MzI1R2t3?=
 =?utf-8?B?bGxrVU45TXpDUHV0UGduc0tNdVp0NVpFUlh3ZzM0T0RMT0NWNHU3cC90ZzhF?=
 =?utf-8?B?V0syNGNENFZyTmZFZEZJeXh5K1E4UUhSZ0lBNDZDSjh2RU0xM1MxcmRUU3FX?=
 =?utf-8?B?MTA5RlE4NmVxVXF1M0dQeVRLQjMvZ0g0M242TUVaemlLK08yTnVMOUZ1aDdl?=
 =?utf-8?B?NURDZTRMTWVPQWgxdVNFTTdLWFAyVGRRbHFEeTBMVlZsQ3BPVnc2VEtYZnA5?=
 =?utf-8?B?T1pvREF1aWZuYjVKNjFKNWpnZ1BYRG5Fd3F3cElUU2lFMDNtSzRDd0RseG5U?=
 =?utf-8?B?SEFLVEJuN05xcVhxQWZwbjVHV2NvYXhGTXZqUU5nV1MrTGxYNVpycnM3NXFh?=
 =?utf-8?B?UEcrWEg2MHRRSE9vOFFzQVJsRC9VWWl3dEZEQm9WZ1RlaDZFS3AvTEhhVTBJ?=
 =?utf-8?B?OEpHQ2NnUVQwZ3h4RjRqKzYrRGxmVGNrdHM2aXFLQlBseEtWNFZJUWM2WXlp?=
 =?utf-8?B?SjhrUVllMjNBamJYRitRaFJFVXBBUjAwNUhTR1dKcE1VbDcya2ZKVk80SzdJ?=
 =?utf-8?B?V1hDNlM4YkFMa3g2ZlJ5bDFDRUZYTThJVjZVMWNjdlJXYW9aTTB2MFFpNGg3?=
 =?utf-8?B?M2pCN2ZkOGc4NFdrcGlzWkNCZzdzbFhiWDRQdit6WXJ2NnMxQUlaczJHeHVT?=
 =?utf-8?B?RStLUmdqbmo3N2xYbnJXWHozOEZuM3pZd3pJRnBLQWRhUTd2UjkzRWJOUkh2?=
 =?utf-8?B?dHlOYkI4SVB4V0xKdGFjTDFTL3owZHJqLzdYc1VUZmlVWVlGcGR3OWhlSDlL?=
 =?utf-8?B?SFhkUFZQVHZEd29aNXYxWjJOZW5kUHhTVTRiQm9OZnV5UmVlaTVEdVF3Z1hQ?=
 =?utf-8?B?MXgzQm5Kcy9IcGhTcElOem1GSnI2eXQvQUU3OVRuSlBvUkhESjg0OFBQMCtQ?=
 =?utf-8?B?RFlnT1RNSWo4dmlqcVBFa29rT2k1RjBjUVRmeU1NcE5QUWMrdnpOS0FvMHpo?=
 =?utf-8?B?ejhTczlZTDBheFltc05DNzBQRDY5U0s2cWNidThNWEU4VFZXc01naUZ2Q1pl?=
 =?utf-8?B?NzRaVnFZUjRMQVZ6ZlIrMmRYYUxqaWN2WWRUYWw5QkE0Z0hoZ0dwWFl2dnBj?=
 =?utf-8?B?eFptUWdGQXYxSVEwQ0ljU1ZWNnlSL3ZJRjlCTEdxTVFpTklTalVyWWdiNUhZ?=
 =?utf-8?B?emRtRU1HamxFR0FRSUVzK3liamZVY1hUOHpCUFIyVngvWkQrVGFmUXRMSEN2?=
 =?utf-8?B?bEJka05Md3VVUi80cDNmNndWSjVBOGNJeWl2WmgxZ1lmMkZEcEkzbHJEVzRX?=
 =?utf-8?B?eEFuM1ErYzFPL0pNZ0xDVDFnOVNnNjRvU1IvZFI5dTVCcHJxekJqQlZJVHNk?=
 =?utf-8?B?WEhWN3BBRmljdE85cG9xZjZzcVdkQ0lYWUQzb05adjVLeDUyRU1KeU9LRC9v?=
 =?utf-8?B?THN3enhkOEZqdDlucExRUUZqczUxWHlTcjU0RHJ0SmlCcEFMSW1lQU80ZlpL?=
 =?utf-8?B?OS9mNHV4YmhsZ3QrT2NpZ2lNOFVhV2ZXbHV0aTk3Sitaa1pGQ3FaQS9Pb3oy?=
 =?utf-8?B?cGNIMGYzdHFqVHgvZGZ2N0tQeEkxUWlqWXRNbFRXTWkzb3JjVmluNWwxVzFU?=
 =?utf-8?B?KzMxUzJrRDNpTWtsRTg0bHRvV1RIalVFdDd6MGxFelhGSUxmaUd3RUl6QzBl?=
 =?utf-8?B?bjVQaFhYQ3I2ZVVoZVNuWVgrZDhqcG5KQkVGM0VUYlZiZVZrVTNKRjZ1bm5a?=
 =?utf-8?B?YitBZz09?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:VJuG/ibNxrJV7IpsH0G+E/zVV1kSLGDGQMFO9uVtbkWO8b8tdVPWheAtsRZ6DomiAD6Ewl9bqQLt9TgW/stvSdD2s4bRYTAO41o/F+wUECxl1BxCmqUU3040fAu2cuc+XFzLs57R8m5jhNMLqRkfdTNS3zXpwwW9srfPx0iPT0dgpWx2JRs7a0DTqzMF/D/S0SaqH7Et4Q0CxgmgEzYoCnoC6yxapAy833PX4k08F4eKjJEh1wFRc3UXSO9ijTjmLXW2lSICEPFMIAMEebFpCCS1eIyKMmgpdNb6Mt8ODCFuCkBzWFzKG5YhRZTy7nPBgbS3Vj1LKNqTzjJ8dvaRxYJyKjRG965cLOtxYMSBiGE=;5:ykz8HEw7ZXctrpRngMup3p7P8NYkVfiE/phR55gFv2QQwynG6IkHCb/Mg+ihYzYBSd/vWCMShJha7Cpqa5L0ujxxqlkPQfLC5ZgKSTxiSOHSxcH6YfborZ4ykgQkeVimlZx4ukuHimcYWPMJlyKyN1c+qjyggUw2EErGzovuL1A=;24:x9yVCHKcZp4Aad85L5+jmPCaQRUxAHvXx5ZevquX3EGTT/7Eg1S70BYJJitDxabAEFk7lHRsm13C/NQK14ZtphVt0soHLtIjfvsB5Pnd6OM=;7:LuwN5nmwDjc0Bf8mrKUSpA1aCl0IX3GdKxdPCZwFnFapW57+cjuFFTRu86yUE+0FbuCgZ/VbWhHq6/SUj1mpeqeSV8ALQUJve9ujsAFtmkz5VjIZUb8bM/D3sler4TZVMoen6IaB9rRQsMGeTpIdsQQEXCFypwX+fpxNZQAz96MZxZYPo9TjJC7xTwWk6xfjrN9gdMqyC3Yu6VpJ2Ln7Mjv1zDuCET0JcdcD5eSnyRIxivmDcf2QmOiS1E2mlbOp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 14:41:22.4413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c37187-4a60-4181-354e-08d56981dd6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-29 18:38, Adrian Fiergolski wrote:
>>> On 22.01.2018 at 12:36, Peter Rosin wrote:
>>>> This series tries to check the I2C device id, but instead of open
>>>> coding the check in the pca954x driver, I have a new function in
>>>> the core doing the work.
>>>>
>>>> The code is only compile-tested, hence the RFC, and I would really
>>>> like a Tested-by: tag from Adrian who presumably have one of these
>>>> chips.
>>>>
>>>> Also, I'm not sure if I should list all manufacturers that I know
>>>> about in the header, or if I should settle for the one that is
>>>> actually used and leave the others to be added by whomever needs
>>>> them...
>>>>
>>>> Cheers,
>>>> peda
>>>>
>>>> Peter Rosin (2):
>>>>   i2c: add i2c_get_device_id() to get the standard i2c device id
>>>>   i2c: mux: pca954x: verify the device id of the pca984x chips
>>>>
>>>>  drivers/i2c/i2c-core-base.c         | 33 ++++++++++++++++++++++++++++
>>>>  drivers/i2c/muxes/i2c-mux-pca954x.c | 43 +++++++++++++++++++++++++++++++++++++
>>>>  include/linux/i2c.h                 | 30 ++++++++++++++++++++++++++
>>>>  3 files changed, 106 insertions(+)
>>>>
> Hi Peter,
> 
> I have tested your patch with the pca9846 device and I confirm it works.
> Moreover, after short debugging, I can confirm that all read ids
> (manufacture, part and die) seem to be correct. Moreover, in case of
> misconfiguration, the probe function return a proper message and fails
> as expected.

Excellent, thanks!

I'll ping Wolfram later on for any input on the core changes (if needed),
but let's wait until the 4.16 merge-window closes and things settle down
a bit. This will land in 4.17 at the earliest.

Cheers,
Peter

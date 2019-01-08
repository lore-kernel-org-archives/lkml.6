Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA86DC43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52442089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfAHJNQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:13:16 -0500
Received: from [38.106.11.25] ([38.106.11.25]:47960 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727592AbfAHJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:13:15 -0500
X-ASG-Debug-ID: 1546938791-107606139f152b80001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda02.hxt-semitech.com with ESMTP id mdPmz4DGalF0DetK (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 08 Jan 2019 17:13:11 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 8 Jan 2019 17:13:05 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Tue, 8 Jan 2019 17:13:05 +0800
From:   "Liu, Xiaoting" <xiaoting.liu@hxt-semitech.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [PATCH v2 4/4] hwmon: (pmbus) add support for DPS-650AB
Thread-Topic: [PATCH v2 4/4] hwmon: (pmbus) add support for DPS-650AB
X-ASG-Orig-Subj: Re: [PATCH v2 4/4] hwmon: (pmbus) add support for DPS-650AB
Thread-Index: AQHUpnWQvB84NJ6vhUqklmqeqreTrQ==
Date:   Tue, 8 Jan 2019 09:13:04 +0000
Message-ID: <a05be53a7110480990bc3b2cf1d31dae@HXTBJIDCEMVIW02.hxtcorp.net>
References: <cover.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <2e94eb44c0acf6b90c1d9bbffd1c5c5cc2af59be.1546851856.git.xiaoting.liu@hxt-semitech.com>
 <af54e702-d384-4af8-0cbc-008a1e927b67@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.1.98]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1546938791
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1392
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4928 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65315
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter Roeck,

Thanks for your reply.

On 2019/1/7 22:04, Guenter Roeck wrote:
> On 1/7/19 3:06 AM, Xiaoting Liu wrote:
>> Provide support for PSU DPS-650AB from Delta Electronics, INC.
>>
> Where is patch 3/4 ?

Sorry for forgetting to send patch 3/4 to you, please refer to the
following link,

https://lore.kernel.org/patchwork/patch/1029475/

Thanks,

Xiaoting

>> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
>> ---
>> v2:
>>    Change the patch subject and commit message.
>>    Drop dps650ab.c file.
>>    Replace struct name dps650ab_pmbus_info with pmbus_info_one_skip.
>> ---
>>   drivers/hwmon/pmbus/pmbus.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
>> index e38dd97cc49a..f6b35f858db8 100644
>> --- a/drivers/hwmon/pmbus/pmbus.c
>> +++ b/drivers/hwmon/pmbus/pmbus.c
>> @@ -213,6 +213,7 @@ static int pmbus_probe(struct i2c_client *client,
>>          {"bmr453", (kernel_ulong_t)&pmbus_info_one},
>>          {"bmr454", (kernel_ulong_t)&pmbus_info_one},
>>          {"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
>> +       {"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
>>          {"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
>>          {"mdt040", (kernel_ulong_t)&pmbus_info_one},
>>          {"ncp4200", (kernel_ulong_t)&pmbus_info_one},
>> --
>> 1.8.3.1
>>
>>
>>
>


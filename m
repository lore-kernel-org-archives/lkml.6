Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C76BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBEB20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfAKI2C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:28:02 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:36815 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730210AbfAKI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:28:01 -0500
X-ASG-Debug-ID: 1547195275-093b7e40ef1c620001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id cjKeerqtLRgRdn0N (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 11 Jan 2019 16:27:56 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 11 Jan 2019 16:27:48 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Fri, 11 Jan 2019 16:27:48 +0800
From:   "Liu, Xiaoting" <xiaoting.liu@hxt-semitech.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Subject: Re: [PATCH v3 4/4] hwmon: (pmbus) add support for DPS-650AB
Thread-Topic: [PATCH v3 4/4] hwmon: (pmbus) add support for DPS-650AB
X-ASG-Orig-Subj: Re: [PATCH v3 4/4] hwmon: (pmbus) add support for DPS-650AB
Thread-Index: AQHUpyi01qEdFN+fSUeA9K9yyOiNHw==
Date:   Fri, 11 Jan 2019 08:27:47 +0000
Message-ID: <3cefef03a6c74580b443a278e12f7374@HXTBJIDCEMVIW02.hxtcorp.net>
References: <cover.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <625d047f0f42d30bb5ceb75ada529b5fa0c9a21a.1546918172.git.xiaoting.liu@hxt-semitech.com>
 <20190110184227.GB9010@roeck-us.net>
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
X-Barracuda-Start-Time: 1547195276
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65510
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/11 2:42, Guenter Roeck wrote:
> On Thu, Jan 10, 2019 at 10:31:44AM +0800, Xiaoting Liu wrote:
>> Provide support for PSU DPS-650AB from Delta Electronics, INC.
>>
>> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
> Applied to hwmon-next.
>
> Thanks,
> Guenter

Thanks for your reply!

Xiaoting

>> ---
>> v3:
>>   No change.
>> ---
>> v2:
>>   Change the patch subject and commit message.
>>   Drop dps650ab.c file.
>>   Replace struct name dps650ab_pmbus_info with pmbus_info_one_skip.
>> ---
>>  drivers/hwmon/pmbus/pmbus.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
>> index ef845a1310fa..e648ed8d926a 100644
>> --- a/drivers/hwmon/pmbus/pmbus.c
>> +++ b/drivers/hwmon/pmbus/pmbus.c
>> @@ -212,6 +212,7 @@ static int pmbus_probe(struct i2c_client *client,
>>  	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
>>  	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
>>  	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
>> +	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
>>  	{"dps800", (kernel_ulong_t)&pmbus_info_one_skip},
>>  	{"mdt040", (kernel_ulong_t)&pmbus_info_one},
>>  	{"ncp4200", (kernel_ulong_t)&pmbus_info_one},
>> -- 
>> 1.8.3.1
>>


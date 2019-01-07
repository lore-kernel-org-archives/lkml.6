Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA67B20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfAGCfl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:35:41 -0500
Received: from [38.106.11.25] ([38.106.11.25]:49112 "EHLO
        barracuda02.hxt-semitech.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbfAGCfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:35:40 -0500
X-ASG-Debug-ID: 1546828533-107606139f130b30001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda02.hxt-semitech.com with ESMTP id P8ON2kRhmPUePqyK (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 07 Jan 2019 10:35:33 +0800 (CST)
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 7 Jan 2019 10:35:28 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Mon, 7 Jan 2019 10:35:28 +0800
From:   "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Liu, Xiaoting" <xiaoting.liu@hxt-semitech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
 driver_data
Thread-Topic: [PATCH 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
 driver_data
X-ASG-Orig-Subj: Re: [PATCH 1/4] pmbus: associate PMBUS_SKIP_STATUS_CHECK with
 driver_data
Thread-Index: AQHUpAtN0XMGdiJXnEO7wZj7H+98nw==
Date:   Mon, 7 Jan 2019 02:35:28 +0000
Message-ID: <0d61e25645bf457ebb55e4c3f64bcb63@HXTBJIDCEMVIW02.hxtcorp.net>
References: <cover.1546591275.git.xiaoting.liu@hxt-semitech.com>
 <680b4d5659971cc4f6e1a6878837c2ce49962a7c.1546591275.git.xiaoting.liu@hxt-semitech.com>
 <b9548ce0-97d2-a3d4-d578-015fc5419967@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1546828533
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.102:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 6971
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4998 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65250
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guenter,
  Thanks for reply.

On 2019/1/4 22:54, Guenter Roeck wrote:
> On 1/4/19 12:55 AM, Xiaoting Liu wrote:
>> Current code compares device name with name in i2c_device_id to decide
>> whether PMBUS_SKIP_STATUS_CHECK should be set in pmbus_platform_data,
>> which makes adding new devices with PMBUS_SKIP_STATUS_CHECK should also
>> modify code in pmbus_probe().
>>
>> This patch adds pmbus_device_info to save pages and flags. Its pointer
>> is put in driver_data of i2c_device_id, which makes adding new device
>> more straightforward.
>>
> 
> Good idea, but I don't see at this time where the patch is needed.
> Maybe in patch 3/4 which is missing from the series ?

The reason we figure out this patch is that we want to add dps650ab to
pmbus_id[] in pmbus.c. As dps650ab has flag of PMBUS_SKIP_STATUS_CHECK
and we don't want to change pmbus_probe(), so make this patch as a
premise patch.
As you stated that adding both dps650ab in pmbus.c and adding a separate
dps650ab driver file is a conceptional mistake, I will work with
Xiaoting to decide which approach we should use.

> 
>> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
>> Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
>> ---
>>   drivers/hwmon/pmbus/pmbus.c | 54 +++++++++++++++++++++++++++------------------
>>   include/linux/pmbus.h       |  5 +++++
>>   2 files changed, 37 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
>> index 7688dab32f6e..aa4cf9636e99 100644
>> --- a/drivers/hwmon/pmbus/pmbus.c
>> +++ b/drivers/hwmon/pmbus/pmbus.c
>> @@ -172,13 +172,15 @@ static int pmbus_probe(struct i2c_client *client,
>>          struct pmbus_driver_info *info;
>>          struct pmbus_platform_data *pdata = NULL;
>>          struct device *dev = &client->dev;
>> +       struct pmbus_device_info *device_info;
>>
>>          info = devm_kzalloc(dev, sizeof(struct pmbus_driver_info), GFP_KERNEL);
>>          if (!info)
>>                  return -ENOMEM;
>>
>> -       if (!strcmp(id->name, "dps460") || !strcmp(id->name, "dps800") ||
>> -           !strcmp(id->name, "sgd009")) {
>> +       device_info = (struct pmbus_device_info *)id->driver_data;
>> +
>> +       if (device_info->flags & PMBUS_SKIP_STATUS_CHECK) {
>>                  pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
>>                                       GFP_KERNEL);
>>                  if (!pdata)
>> @@ -187,36 +189,44 @@ static int pmbus_probe(struct i2c_client *client,
>>                  pdata->flags = PMBUS_SKIP_STATUS_CHECK;
>>          }
>>
>> -       info->pages = id->driver_data;
>> +       info->pages = device_info->pages;
>>          info->identify = pmbus_identify;
>>          dev->platform_data = pdata;
>>
>>          return pmbus_do_probe(client, id, info);
>>   }
>>
>> +static const struct pmbus_device_info default_pmbus_info = {1, 0};
>> +static const struct pmbus_device_info dps460_pmbus_info = {
>> +                               1, PMBUS_SKIP_STATUS_CHECK};
>> +static const struct pmbus_device_info dps800_pmbus_info = {
>> +                               1, PMBUS_SKIP_STATUS_CHECK};
>> +static const struct pmbus_device_info sgd009_pmbus_info = {
>> +                               1, PMBUS_SKIP_STATUS_CHECK};
> 
> Three structures with exactly the same content does not add value.
> Please merge into one with a common name that reflects its use.
>

Thanks. we will following you suggestion to use common name as
pmbus_info_one_skip.

>> +static const struct pmbus_device_info pmbus_info = {0, 0};
> 
> default_pmbus_info and pmbus_info are badly named and ordered.
> The name should reflect that one sets one page and that the other
> leaves the number of pages unset.
> 
> I would suggest three structures and names, such as
> 
> pmbus_info_one
> pmbus_info_one_skip
> pmbus_info_zero
> 
> though I am open to better names.

Thanks. We will change.

> 
>>   /*
>>    * Use driver_data to set the number of pages supported by the chip.
>>    */
>>   static const struct i2c_device_id pmbus_id[] = {
>> -       {"adp4000", 1},
>> -       {"bmr453", 1},
>> -       {"bmr454", 1},
>> -       {"dps460", 1},
>> -       {"dps800", 1},
>> -       {"mdt040", 1},
>> -       {"ncp4200", 1},
>> -       {"ncp4208", 1},
>> -       {"pdt003", 1},
>> -       {"pdt006", 1},
>> -       {"pdt012", 1},
>> -       {"pmbus", 0},
>> -       {"sgd009", 1},
>> -       {"tps40400", 1},
>> -       {"tps544b20", 1},
>> -       {"tps544b25", 1},
>> -       {"tps544c20", 1},
>> -       {"tps544c25", 1},
>> -       {"udt020", 1},
>> +       {"adp4000", (kernel_ulong_t)&default_pmbus_info},
>> +       {"bmr453", (kernel_ulong_t)&default_pmbus_info},
>> +       {"bmr454", (kernel_ulong_t)&default_pmbus_info},
>> +       {"dps460", (kernel_ulong_t)&dps460_pmbus_info},
>> +       {"dps800", (kernel_ulong_t)&dps800_pmbus_info},
>> +       {"mdt040", (kernel_ulong_t)&default_pmbus_info},
>> +       {"ncp4200", (kernel_ulong_t)&default_pmbus_info},
>> +       {"ncp4208", (kernel_ulong_t)&default_pmbus_info},
>> +       {"pdt003", (kernel_ulong_t)&default_pmbus_info},
>> +       {"pdt006", (kernel_ulong_t)&default_pmbus_info},
>> +       {"pdt012", (kernel_ulong_t)&default_pmbus_info},
>> +       {"pmbus", (kernel_ulong_t)&pmbus_info},
>> +       {"sgd009", (kernel_ulong_t)&sgd009_pmbus_info},
>> +       {"tps40400", (kernel_ulong_t)&default_pmbus_info},
>> +       {"tps544b20", (kernel_ulong_t)&default_pmbus_info},
>> +       {"tps544b25", (kernel_ulong_t)&default_pmbus_info},
>> +       {"tps544c20", (kernel_ulong_t)&default_pmbus_info},
>> +       {"tps544c25", (kernel_ulong_t)&default_pmbus_info},
>> +       {"udt020", (kernel_ulong_t)&default_pmbus_info},
>>          {}
>>   };
>>
>> diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
>> index ee3c2aba2a8e..3c05edad7666 100644
>> --- a/include/linux/pmbus.h
>> +++ b/include/linux/pmbus.h
>> @@ -46,4 +46,9 @@ struct pmbus_platform_data {
>>          struct regulator_init_data *reg_init_data;
>>   };
>>
>> +struct pmbus_device_info {
>> +       int pages;
>> +       u32 flags;
>> +};
>> +
> 
> This should not be needed here. The structure can be declared locally
> in pmbus.c (its use in patch 4/4 is wrong).
>

OK. We will move the structure back to pmbus.c. And we will decide
whether we need 4/4.

Thanks.
Shunyong.


>>   #endif /* _PMBUS_H_ */
>> --
>> 1.8.3.1
>>
>>
>>
>>
>> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
>>
>>
>>
> 
> 


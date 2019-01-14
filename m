Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44974C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E58A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkqANXQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfANUCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:02:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38175 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfANUC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:02:29 -0500
Received: by mail-io1-f67.google.com with SMTP id l14so231127ioj.5;
        Mon, 14 Jan 2019 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2tW3xQg3wEt6J9y6OQD5MFGQ2I+uBPmHE80PtVYWtXY=;
        b=mkqANXQfcvP+3TaydkmNkP/TfeeVyAy5ZYQqsd/e08cItH1Xtli2ChokW0lQYCqBbf
         F2ljiAjjwqQyQ8HAyopNbWLBZBTLmSaVolyJYM83eoCCq63i1ODKT31qYWE2w0JXTAMC
         ZC2ALB7N6u4du8FgL7OE2Rvm3A2o+EMQVQjlzd6RPT/DkrMsN96v2R4yVIE8W2Tryb05
         kTQEOAYxPBd5PP5RJH3p6dG798V+XFToK6ch1U8H1QNZ3L4Qq23BsGIGiG0LWVzQfgEE
         EshwpAxS+bVmzrCGFEpry5PHm3LiBAjwskSbYbrj3R6dux4avRx7P1BO3vRF380ZrtQv
         dITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2tW3xQg3wEt6J9y6OQD5MFGQ2I+uBPmHE80PtVYWtXY=;
        b=iBFWFRemLzFmeqO4y0J+pJbTloEMXhIO7aWhDrQusKB2IhQFaaUbu/SIPdB8qma+KI
         EHJu23Kuh6QhWcZzlQCqEn45q8FX0SNYl2Kb0WzGZYDp6e/O9zHZC2hUn1C2/i0ccISn
         oltFo13PUE/P/QQoS9bbeN4leFdVc6OrjJLqxD5L9cv/Y48OoiEjrQOCbN+EMEtrZh73
         BI7ub7/x6DRTSOIuzHT9zBVYGTYAL+N12sDWj0yrLHbYuxbrk0Q/+yeAnR14zG+ThlB6
         fWgv8+I3AVKh5fuc7h/H3D1QAdYBBb9CiaoT1ivzvLniAzMOjsSxazI4K8iG2agLvLN6
         tooA==
X-Gm-Message-State: AJcUukeNJ5EJlPP98U8Bv3L1jk2CP7iKaMYz1px0Z2c30dpyNRUBaXVY
        7oGy3ZRBaWcoIijJoHNuwgjXXtpkdhw=
X-Google-Smtp-Source: ALg8bN47qoSib7Uh56ActNPNVZD9oFZX1vHIuNPtoNtXwoHikYVIDlb/QDBLYKleA7GGbpsm/M8YPw==
X-Received: by 2002:a6b:ca04:: with SMTP id a4mr110303iog.254.1547496148295;
        Mon, 14 Jan 2019 12:02:28 -0800 (PST)
Received: from [192.168.1.133] ([67.218.223.154])
        by smtp.gmail.com with ESMTPSA id x6sm562276iol.19.2019.01.14.12.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 12:02:27 -0800 (PST)
Subject: Re: [PATCH v2 1/2] iio: chemical: bme680: Add device-tree support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, himanshujha199640@gmail.com,
        mark.rutland@arm.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de
References: <20190111205359.14158-1-sebastien.bourdelin@gmail.com>
 <20190112182221.4765d287@archlinux>
From:   sebastien bourdelin <sebastien.bourdelin@gmail.com>
Message-ID: <44dd6866-07fa-83cb-19d8-e35a5aa989a0@gmail.com>
Date:   Mon, 14 Jan 2019 15:01:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190112182221.4765d287@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/12/19 1:22 PM, Jonathan Cameron wrote:
> On Fri, 11 Jan 2019 15:53:58 -0500
> Sebastien Bourdelin <sebastien.bourdelin@gmail.com> wrote:
>
>> This commit allow the driver to work with device-tree.
>>
>> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@gmail.com>
> Minor stuff inline.
>
> J
>> ---
>> v1 -> v2:
>>    - add missing of.h header in bme680_spi.c
>> ---
>>   drivers/iio/chemical/bme680_i2c.c | 7 +++++++
>>   drivers/iio/chemical/bme680_spi.c | 9 +++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/bme680_i2c.c
>> index 06d4be539d2e..94a36ebdf0b2 100644
>> --- a/drivers/iio/chemical/bme680_i2c.c
>> +++ b/drivers/iio/chemical/bme680_i2c.c
>> @@ -70,10 +70,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
>>   
>> +static const struct of_device_id bme680_of_i2c_match[] = {
>> +	{ .compatible = "bosch,bme680", },
>> +	{},
>> +}
>> +MODULE_DEVICE_TABLE(of, bme680_of_i2c_match);
>> +
>>   static struct i2c_driver bme680_i2c_driver = {
>>   	.driver = {
>>   		.name			= "bme680_i2c",
>>   		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
>> +		.of_match_table		= of_match_ptr(bme680_of_i2c_match),
> As below. just = bme680...
Got it, thanks!
>
>>   	},
>>   	.probe = bme680_i2c_probe,
>>   	.id_table = bme680_i2c_id,
>> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/bme680_spi.c
>> index c9fb05e8d0b9..caa57287a911 100644
>> --- a/drivers/iio/chemical/bme680_spi.c
>> +++ b/drivers/iio/chemical/bme680_spi.c
>> @@ -6,9 +6,11 @@
>>    */
>>   #include <linux/acpi.h>
>>   #include <linux/module.h>
>> +#include <linux/of.h>
>>   #include <linux/regmap.h>
>>   #include <linux/spi/spi.h>
>>   
>> +
> This white space change should not be here.
My bad.
>>   #include "bme680.h"
>>   
>>   static int bme680_regmap_spi_write(void *context, const void *data,
>> @@ -110,10 +112,17 @@ static const struct acpi_device_id bme680_acpi_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
>>   
>> +static const struct of_device_id bme680_of_spi_match[] = {
>> +	{ .compatible = "bosch,bme680", },
>> +	{},
>> +}
>> +MODULE_DEVICE_TABLE(of, bme680_of_spi_match);
>> +
>>   static struct spi_driver bme680_spi_driver = {
>>   	.driver = {
>>   		.name			= "bme680_spi",
>>   		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
>> +		.of_match_table		= of_match_ptr(bme680_of_spi_match),
> Please don't use of_match_ptr.  We actually want this entry to be there even
> if devicetree is not in use.  This is because there is a magic ACPI hid
> that can use this table even from ACPI.
>
Sure.
>>   	},
>>   	.probe = bme680_spi_probe,
>>   	.id_table = bme680_spi_id,

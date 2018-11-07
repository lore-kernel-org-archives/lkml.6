Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97193C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A29820837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhUqrH24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A29820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeKHFVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:21:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34866 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbeKHFVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so15875979ljb.2;
        Wed, 07 Nov 2018 11:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d5V1uW76Q0IAtGKD/dIufTon2hNFl+VbR+afaKecsCk=;
        b=fhUqrH24EtbKvagZWVfkbYbgepEVpgkNVwJebptjR9qTdGkmgzl2NUrYTMsUO5r6L0
         ATJiOD6BQu8SuuYLV4itxKlw0eAAJhO3LIKAuwI32X+97ttWSbPDfF++Y3ujP73ibSbg
         9c61rkk2CilWK+ePLEUnNDT/EbP/CJshWLsWBR5S3yLz8ppOvQcIPbteS629kbhsJcGs
         6QW4yYM9CL2ErY66oFEpQmLcCZsfCIadZmtH0mm2FPxZpUfcaDvpS3UQdAyygAVjBdgx
         XbaZRvhA3dczW8MI5xMAF7OhBVFDhiu84zdQRVK+vk2pWA52oJaLDZZkYsQxLUefEYha
         A42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5V1uW76Q0IAtGKD/dIufTon2hNFl+VbR+afaKecsCk=;
        b=k8wPeOULn90MSPMlwOfuAmcaesSNiZm1IBKuZHUEEimF+Q5yY1bLUGo5vJDH/MR7HD
         PZSuKS6B3kL6QHWTafdu76/TRqUM3IpzqMB1gWmdsTFNQe8U0oACEiPSPk44aR+2zSZj
         jY0XXW5XcYP30GMtnnrO+pjM7azc0yhmtbX9uoJpeoqL3cnU4a2lC1GSV8Ihq+lOv4DT
         9Cdf7V0T2FIsRRlysAZID2x4bW0TZIZ2rVET7MBdGMWKqL1B5aQT1rP8xnjskdYvniKS
         Jd+2AxD4F/GdwOkN1DebFHjAHXR4TyyFF9pwI5HLRBI4fpOcX5Mf7yVi/ggqjfkgvNP3
         WYgg==
X-Gm-Message-State: AGRZ1gIQ6auBSvLFqNq4oFjCS8Yb6z49ukHzOuo+Rve4MMDOLYvilLkV
        Is0212fyMHKKSMpN+pxRBaA=
X-Google-Smtp-Source: AJdET5dOuTKDLJ53RfgiP9i3iWECg6WiM4vIRF7KyZ63JRbNkriL4zJQVgDXZazhYrxO/8RAtFYZCw==
X-Received: by 2002:a2e:20c3:: with SMTP id g64-v6mr1048755lji.101.1541620183204;
        Wed, 07 Nov 2018 11:49:43 -0800 (PST)
Received: from [192.168.1.18] (dnl153.neoplus.adsl.tpnet.pl. [83.24.93.153])
        by smtp.gmail.com with ESMTPSA id p77-v6sm354759lja.0.2018.11.07.11.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 11:49:42 -0800 (PST)
Subject: Re: [PATCH 08/24] leds: lt3593: Use led_compose_name()
To:     Daniel Mack <daniel@zonque.org>, linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-9-git-send-email-jacek.anaszewski@gmail.com>
 <42d68eae-6905-e787-3797-f0f16b0dfb84@zonque.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <6666ef06-c19d-b0d8-a32b-44cecb8bc4b3@gmail.com>
Date:   Wed, 7 Nov 2018 20:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <42d68eae-6905-e787-3797-f0f16b0dfb84@zonque.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2018 08:37 PM, Daniel Mack wrote:
> On 6/11/2018 11:07 PM, Jacek Anaszewski wrote:
>> Switch to using generic LED support for composing LED class
>> device name.
> 
> Thanks for the rework!
> 
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> ---
>>   drivers/leds/leds-lt3593.c | 19 ++++++++-----------
>>   1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
>> index de3623e..d005abc 100644
>> --- a/drivers/leds/leds-lt3593.c
>> +++ b/drivers/leds/leds-lt3593.c
>> @@ -10,10 +10,10 @@
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> -#include <uapi/linux/uleds.h>
>> +
>> +#define LED_LT3593_NAME "lt3593"
>>     struct lt3593_led_data {
>> -    char name[LED_MAX_NAME_SIZE];
>>       struct led_classdev cdev;
>>       struct gpio_desc *gpiod;
>>   };
>> @@ -111,6 +111,7 @@ static int lt3593_led_probe(struct platform_device
>> *pdev)
>>       struct fwnode_handle *child;
>>       int ret, state = LEDS_GPIO_DEFSTATE_OFF;
>>       enum gpiod_flags flags = GPIOD_OUT_LOW;
>> +    struct led_init_data init_data;
>>       const char *tmp;
>>         if (dev_get_platdata(dev)) {
>> @@ -138,14 +139,11 @@ static int lt3593_led_probe(struct
>> platform_device *pdev)
>>           return PTR_ERR(led_data->gpiod);
>>         child = device_get_next_child_node(dev, NULL);
>> +    init_data.fwnode = child;
> 
> Not quite following. `fwnode' is the only member of that struct that is
> initialized?
> 
>>   -    ret = fwnode_property_read_string(child, "label", &tmp);
>> -    if (ret < 0)
>> -        snprintf(led_data->name, sizeof(led_data->name),
>> -             "lt3593::");
>> -    else
>> -        snprintf(led_data->name, sizeof(led_data->name),
>> -             "lt3593:%s", tmp);
>> +    ret = led_compose_name(child, LED_LT3593_NAME, ":", init_data.name);
> 
> ... and here, a member that wasn't written before is used? What am I
> missing?

init_data.name pointer is passed to led_compose_name(), which fills
this array with the composed name.

-- 
Best regards,
Jacek Anaszewski

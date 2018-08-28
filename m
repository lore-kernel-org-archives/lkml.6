Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81EF2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+nXpiqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81EF2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeH1Rsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:48:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36798 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbeH1Rsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:48:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so794984pgo.3;
        Tue, 28 Aug 2018 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMojAtRwudJSj7DiGIyX0w3/gxVENvX68gtXBn6PaQI=;
        b=G+nXpiqFb9bKepy9Hr7knocjMIdYAkzcbk5RGJ8xifwu8G3Jt3xAfRfHh6rHojhiK+
         0apbRRUHVJrusZXgyxElTXEOfP9NmtIT5biFEdjqprrGiNUGzIqwsrtVtxVtn7baFg1b
         dszYDpKdoHl+Gban08QNIJy9nhxoeB75Dce7xvLrz/FMx6EwjgiZ7qXN8ymi79raiJK9
         1E2WnUZm5GglSxDcv4BQna5uT8w0ffRnZh+WD+PJ6XB9sQeASVp/TxzQJv0GKHm4t6bB
         TrEX8gpeexzsPoVJ8q7LBZjr+qWwa7E2jaifZDycV+xi911XTgf5lwUInN77GvF7updu
         lREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMojAtRwudJSj7DiGIyX0w3/gxVENvX68gtXBn6PaQI=;
        b=iACkY3XqKnWpAYJzegR3eFqqdTH8sGWGCyRGgCvX/GC1Pmtc8VWYDVng0vYx1UanTE
         ssY+noA0Uqh04PTg1EsIDp9K0yKXLUGcKMtuicrjE7GIN0KY0YdGKROArmZgBHOJ6vpL
         +CZGX3gZnx3Aw4Px9dZkZJcAey9bI2BVhoxodb7zmyvy14JP9wMDtD1mrKjHZ2lPpu0u
         d9+jjEyf+P3+RIpe1N95aiG13afTAiDxlnyp6No5hvQkJ4xb1pI6ZRQzTEjMbTwKonpr
         5Lo3u2Px1MIdSDioINKLz6WmqyXImi2HFeIZ1uh0GGUS6MZ4xTEbh7yO7BiRszrRL6id
         xRvw==
X-Gm-Message-State: APzg51B6xKcZeQfkICyDlzS69cYxXp7QXOEnV1ROfegEKiiLVNC8PmzY
        p/Oiccg2PhLlY/JN7x9Euhi+kLze
X-Google-Smtp-Source: ANB0VdZFPfOR0V3h0arH3HG35f74fbcvp4v859NbAT2uSef33DffTFsVPrUbS1wnNU4fKw9gnFXKxA==
X-Received: by 2002:a63:5d4b:: with SMTP id o11-v6mr1643493pgm.349.1535464624655;
        Tue, 28 Aug 2018 06:57:04 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c1-v6sm5407460pfg.25.2018.08.28.06.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 06:57:03 -0700 (PDT)
Subject: Re: [PATCH] hwmon: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-20-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <aa9473ef-61f6-270f-ff7c-284a2789c0a9@roeck-us.net>
Date:   Tue, 28 Aug 2018 06:57:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-20-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 06:52 PM, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

The devm_kstrdup((..., "iio_hwmon") is getting a bit ridiculous and is asking
for a rewrite, but that can be done in a separate patch.

Other than that, do you want this taken through hwmon or as a series on its own ?

For the latter case,

Acked-by: Guenter Roeck <linux@roeck-us.net>

otherwise please let me know.

Guenter

> ---
>   drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
>   drivers/hwmon/ibmpowernv.c       | 4 ++--
>   drivers/hwmon/iio_hwmon.c        | 9 ++++-----
>   drivers/hwmon/npcm750-pwm-fan.c  | 2 +-
>   4 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 5e449eac788a..92de8139d398 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -852,7 +852,7 @@ static int aspeed_create_pwm_cooling(struct device *dev,
>   		dev_err(dev, "Property 'cooling-levels' cannot be read.\n");
>   		return ret;
>   	}
> -	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%s%d", child->name, pwm_port);
> +	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
>   
>   	cdev->tcdev = thermal_of_cooling_device_register(child,
>   							 cdev->name,
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 83472808c816..4935897f1527 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -603,8 +603,8 @@ static int create_device_attrs(struct platform_device *pdev)
>   		if (of_property_read_u32(np, "sensor-id", &sensor_id) &&
>   		    of_property_read_u32(np, "sensor-data", &sensor_id)) {
>   			dev_info(&pdev->dev,
> -				 "'sensor-id' missing in the node '%s'\n",
> -				 np->name);
> +				 "'sensor-id' missing in the node '%pOFn'\n",
> +				 np);
>   			continue;
>   		}
>   
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 2f3f875c06ac..7566991f1c04 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -65,13 +65,9 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>   	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
>   	enum iio_chan_type type;
>   	struct iio_channel *channels;
> -	const char *name = "iio_hwmon";
>   	struct device *hwmon_dev;
>   	char *sname;
>   
> -	if (dev->of_node && dev->of_node->name)
> -		name = dev->of_node->name;
> -
>   	channels = devm_iio_channel_get_all(dev);
>   	if (IS_ERR(channels)) {
>   		if (PTR_ERR(channels) == -ENODEV)
> @@ -141,7 +137,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>   	st->attr_group.attrs = st->attrs;
>   	st->groups[0] = &st->attr_group;
>   
> -	sname = devm_kstrdup(dev, name, GFP_KERNEL);
> +	if (dev->of_node)
> +		sname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
> +	else
> +		sname = devm_kstrdup(dev, "iio_hwmon", GFP_KERNEL);
>   	if (!sname)
>   		return -ENOMEM;
>   
> diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> index 8474d601aa63..96634fd54e0b 100644
> --- a/drivers/hwmon/npcm750-pwm-fan.c
> +++ b/drivers/hwmon/npcm750-pwm-fan.c
> @@ -861,7 +861,7 @@ static int npcm7xx_create_pwm_cooling(struct device *dev,
>   		dev_err(dev, "Property 'cooling-levels' cannot be read.\n");
>   		return ret;
>   	}
> -	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%s%d", child->name,
> +	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%pOFn%d", child,
>   		 pwm_port);
>   
>   	cdev->tcdev = thermal_of_cooling_device_register(child,
> 


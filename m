Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45B6C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49ECB2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuSjoxgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ECB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeH1Wgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 18:36:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32955 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1Wgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 18:36:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id t14-v6so1154863pgf.0;
        Tue, 28 Aug 2018 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+xtGKXEtu8OxwtAuKJizopAFyXkxeXcGAZZx3pnvgs=;
        b=RuSjoxgytbSxYMhTTGeOA0ig3Gg+lefYQeYbNL+NU9DKb3zrOQq7xcuLD7y9CV+mhS
         ZHVeiq1tHTbqUua5Vi9iJ8vIj2JXQrSFr7Fu4PxResTww1dBhmKhQnkaU0Pa33dCD0pg
         yn0wHIesznq1qIJYR8Om+CJliyswGBHupGQs7wveGx1rUQyNpfz58xZphLRAfDcVHIYx
         XaROf89P3UtZCmFxEiM9POXB78EUWuxrj9hWb+Rs+c2vf9O9Ibl/CtHDv2O2aHzYfLfT
         cB1ngfaNQo4i5GOe3EGeDgsQJ7TDdjMfPShmdOOASmuDkA9RFzDUn5Q3ig3DMEg3bbXB
         jyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+xtGKXEtu8OxwtAuKJizopAFyXkxeXcGAZZx3pnvgs=;
        b=N98HDz3TDk3Kblux0TpaeuEuI4j/VAc1jc2eAQdx1xxh2Unu8q9K4Mc2CogcKtyGJR
         NSHljkp2Q2cuiEYXoFx6Iu49yIDxO9ojcZudubPuQ8WPDPtWClbaMIzlknZWNKsVESZT
         WX99d7248uVPQ+IEJ0u+0UtCTi10pFR7S+fw9SSkUZv5zLLeetzc4UHzDn2rG9hf5dFb
         orlQY05czzKeX3QfuzLgr3O3yIy1+OQzZxZMbfrQrWQKAl8sHmNQOUK2fQVVZHjZ0oVo
         LD/+El/Ul04aHjNjSWP0I06K1Q/xmitHCMI47Y3/M+7iuqlm4OS1NRjcq8ZMLiyeYVa1
         sNDQ==
X-Gm-Message-State: APzg51D509PrMR5sIpEMsHma8t2sx7FBMkoYiPaNgvWpCuvGD+41HQjq
        9pijRuTnWZrC39tkCvVWl5/YrV36
X-Google-Smtp-Source: ANB0VdZF4li78So2Sl0JIIe0KfuChi0FTGrH9zwjFvlGRTjGVYnrp9XpyIWGC5ypnbuu1r+/ntl5kg==
X-Received: by 2002:a62:ce48:: with SMTP id y69-v6mr2750111pfg.91.1535481816039;
        Tue, 28 Aug 2018 11:43:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 5-v6sm2884670pgc.86.2018.08.28.11.43.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 11:43:34 -0700 (PDT)
Date:   Tue, 28 Aug 2018 11:43:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: Convert to using %pOFn instead of device_node.name
Message-ID: <20180828184333.GA27545@roeck-us.net>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-20-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-20-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:52:21PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
>  drivers/hwmon/ibmpowernv.c       | 4 ++--
>  drivers/hwmon/iio_hwmon.c        | 9 ++++-----
>  drivers/hwmon/npcm750-pwm-fan.c  | 2 +-
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 5e449eac788a..92de8139d398 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -852,7 +852,7 @@ static int aspeed_create_pwm_cooling(struct device *dev,
>  		dev_err(dev, "Property 'cooling-levels' cannot be read.\n");
>  		return ret;
>  	}
> -	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%s%d", child->name, pwm_port);
> +	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
>  
>  	cdev->tcdev = thermal_of_cooling_device_register(child,
>  							 cdev->name,
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 83472808c816..4935897f1527 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -603,8 +603,8 @@ static int create_device_attrs(struct platform_device *pdev)
>  		if (of_property_read_u32(np, "sensor-id", &sensor_id) &&
>  		    of_property_read_u32(np, "sensor-data", &sensor_id)) {
>  			dev_info(&pdev->dev,
> -				 "'sensor-id' missing in the node '%s'\n",
> -				 np->name);
> +				 "'sensor-id' missing in the node '%pOFn'\n",
> +				 np);
>  			continue;
>  		}
>  
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 2f3f875c06ac..7566991f1c04 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -65,13 +65,9 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
>  	enum iio_chan_type type;
>  	struct iio_channel *channels;
> -	const char *name = "iio_hwmon";
>  	struct device *hwmon_dev;
>  	char *sname;
>  
> -	if (dev->of_node && dev->of_node->name)
> -		name = dev->of_node->name;
> -
>  	channels = devm_iio_channel_get_all(dev);
>  	if (IS_ERR(channels)) {
>  		if (PTR_ERR(channels) == -ENODEV)
> @@ -141,7 +137,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  	st->attr_group.attrs = st->attrs;
>  	st->groups[0] = &st->attr_group;
>  
> -	sname = devm_kstrdup(dev, name, GFP_KERNEL);
> +	if (dev->of_node)
> +		sname = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
> +	else
> +		sname = devm_kstrdup(dev, "iio_hwmon", GFP_KERNEL);
>  	if (!sname)
>  		return -ENOMEM;
>  
> diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
> index 8474d601aa63..96634fd54e0b 100644
> --- a/drivers/hwmon/npcm750-pwm-fan.c
> +++ b/drivers/hwmon/npcm750-pwm-fan.c
> @@ -861,7 +861,7 @@ static int npcm7xx_create_pwm_cooling(struct device *dev,
>  		dev_err(dev, "Property 'cooling-levels' cannot be read.\n");
>  		return ret;
>  	}
> -	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%s%d", child->name,
> +	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%pOFn%d", child,
>  		 pwm_port);
>  
>  	cdev->tcdev = thermal_of_cooling_device_register(child,

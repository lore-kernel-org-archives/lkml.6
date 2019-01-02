Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DCC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60341218CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 19:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvCfL1oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfABTQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:16:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35659 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfABTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 14:16:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so21688222lfc.2;
        Wed, 02 Jan 2019 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cM2+TBM2dVvmh6DN0i3YpZhz++BwTNY/koRBmZDSw+o=;
        b=TvCfL1oipazv+qYLQvNQvj0R9M7QdRWgNeDMdBqE4PzhumNHPxhVJgoy71l/nwq2sz
         SOhb9446Pm64kPypXgmYY+PNWksTfk75rzGVqy3i/h0tG0wmLcmiRolauQxE0Zx2tN3U
         KJLPK63C/NuxKEeXFKns3x5w3E7YNP8a1dhLP5CM6wLdlxWRXkrgJ7BygmFMJBjCniaX
         Dva1ffq7RVQS70yqhpinZGHnfrdH9XrP9QStF5Bz1n3NlG+przN9cCfKlBxMKFcQt0Yz
         5WGT3FchXmGOLgub4Tpgpv9z8a9ymiJWHPKSPbZbwPiYRjTV6bqFDnwA+U01hoON88NP
         54eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cM2+TBM2dVvmh6DN0i3YpZhz++BwTNY/koRBmZDSw+o=;
        b=tCD3MTyu3bgqsflDhj2ljmvWQ66xUV3MBsFIv0/tsuDqcJeUNvY1aN/1XVcvrYyRTO
         Df5g7YIzuVg6sXofcWYx8MybK+14K7xmasgV+qcQmBzsWi670cMFNQ2wFyfSYEp0w8WI
         ZXd/pfMxaG3xkw6uTAwxDZkoFg0B47gJAnmoXdaVf8owRhj/y4O+lVniLUV1kLKuqTxH
         NtRgOhWGekwEg7mm2g0HG4e1BTfvRc8XmvLEz+Xrc9EOLg96kt/T4ourRSnvD4f/hR4b
         5+TlQteuEERQ4iSGScQ/lH4Dg5srmUakURuzaVjWu5AQCqY+ysle+9mpeTCYSR+2HPh6
         D2SQ==
X-Gm-Message-State: AJcUukcR0dlsuvlWqBIOfLkeCDvKWUmKh93d4vScEEdFoCzIgM5wUedo
        pdIhuqkaFdOaE9HM7P+RP0fE3QwA
X-Google-Smtp-Source: ALg8bN6xwJ1/dE4fD1snbIy6oZXraazmBOdTiUlW4RvLsNu1wKgN/Jl5bWk4K2robs61Gx1l2A9tVg==
X-Received: by 2002:a19:2906:: with SMTP id p6mr6025099lfp.17.1546456615305;
        Wed, 02 Jan 2019 11:16:55 -0800 (PST)
Received: from [192.168.1.18] (dqd74.neoplus.adsl.tpnet.pl. [83.24.163.74])
        by smtp.gmail.com with ESMTPSA id d24-v6sm11366362ljg.2.2019.01.02.11.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:16:54 -0800 (PST)
Subject: Re: [PATCH v5 2/5] leds: Add helper for getting default pattern from
 Device Tree
To:     Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20190101140717.13564-1-krzk@kernel.org>
 <20190101140717.13564-3-krzk@kernel.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <913204f7-93e7-95f1-c477-85359ea1d73c@gmail.com>
Date:   Wed, 2 Jan 2019 20:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190101140717.13564-3-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

You mentioned change of helper name in the cover
letter, but it still has "classdev" part.

On 1/1/19 3:07 PM, Krzysztof Kozlowski wrote:
> Multiple LED triggers might need to access default pattern so add a
> helper for that.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   drivers/leds/led-core.c | 43 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/leds.h    |  3 +++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index ede4fa0ac2cc..e4b6da73bc12 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -16,7 +16,9 @@
>   #include <linux/list.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/of.h>
>   #include <linux/rwsem.h>
> +#include <linux/slab.h>
>   #include "leds.h"
>   
>   DECLARE_RWSEM(leds_list_lock);
> @@ -310,6 +312,47 @@ int led_update_brightness(struct led_classdev *led_cdev)
>   }
>   EXPORT_SYMBOL_GPL(led_update_brightness);
>   
> +/**
> + * led_classdev_get_default_pattern - return default pattern

s/led_classdev/led/

> + *
> + * @led_cdev: the led_classdev structure for this device
> + * @size:     pointer for storing the number of elements in returned array,
> + *            modified only if return != NULL
> + *
> + * Return:    Allocated array of integers with default pattern from DeviceTree
> + *            or NULL.  Caller is responsible for kfree().
> + */
> +u32 *led_classdev_get_default_pattern(struct led_classdev *led_cdev,
> +				      unsigned int *size)

Ditto.

> +{
> +	struct device_node *np = dev_of_node(led_cdev->dev);
> +	u32 *pattern;
> +	int count;
> +
> +	if (!np)
> +		return NULL;
> +
> +	count = of_property_count_u32_elems(np, "led-pattern");
> +	if (count < 0)
> +		return NULL;
> +
> +	pattern = kcalloc(count, sizeof(*pattern), GFP_KERNEL);
> +	if (!pattern)
> +		return NULL;
> +
> +	if (of_property_read_u32_array(np, "led-pattern", pattern, count))
> +		goto err;
> +
> +	*size = count;
> +
> +	return pattern;
> +
> +err:
> +	kfree(pattern);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(led_classdev_get_default_pattern);

Ditto.

> +
>   /* Caller must ensure led_cdev->led_access held */
>   void led_sysfs_disable(struct led_classdev *led_cdev)
>   {
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 5263f87e1d2c..70edf574ba81 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -129,6 +129,9 @@ struct led_classdev {
>   	struct mutex		led_access;
>   };
>   
> +extern u32 *led_classdev_get_default_pattern(struct led_classdev *led_cdev,
> +					     unsigned int *size);
> +

Ditto.

>   extern int of_led_classdev_register(struct device *parent,
>   				    struct device_node *np,
>   				    struct led_classdev *led_cdev);
> 

-- 
Best regards,
Jacek Anaszewski

Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DB7C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C39E20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyKIIesq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbfA3T76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:59:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45289 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbfA3T7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:59:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so617689ljd.12;
        Wed, 30 Jan 2019 11:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=soWgSVtzCUMbistladgy42gO+8F6jxheWByJgJp8ogE=;
        b=ZyKIIesqeUO3rTZC9Bo3rHj2JVpnrWlHMQQcNj5BHpC+X5HVW+6RCRRf5maM6GdRBk
         M4BRoPX5pFV0Wb6YLl1lrECXs6DNKqgK5ekbkLRCZwm1i3uyFoz7c/gBjqSVYYdlKYuo
         8gzDKN9x5IPvTb2ZNtjXvIOFr+ChrBAe4BAS9oKpremJDEpyqweIh0cooumE2UwJy2z0
         jOJLRXdQlD7E3M0UPF6Ime8jStMhFOTMzMjRca6rGcdI+XvukPRmh8ya/SSnSz38rSqs
         maqnothmPyI4Wp0qv4pOYICiWzUP4J4FIkLwy4JcRjLenrfnGCKzSjBnv6GfNfXEwmWk
         rhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=soWgSVtzCUMbistladgy42gO+8F6jxheWByJgJp8ogE=;
        b=bAK4arHFzTSUDl0/uZPPlzRnd78X+7vxFBLDYrocrscPe7LN5kjFvUJp0IkMzwy5aU
         w6cj9DdKP6yROnHSIzsLnv9zCRfUKQvgmKCsGDBRpDSJnOpUY+sDeeKMG7Bx9VsBbAcL
         k5C+qwyxQPPpcGcqYMZDGg5v3DHiBuh5wn+32fy9Gof0xYGG0yiudFDBW7ozXM4dAUYu
         knDyJ2W73fbYV7sTF1g1z9FFdvHzcFWQe4ogKhWRSRR56xO/7dP6iFTVWg2AAyBISpOm
         9NupPCP3t0lGsmsi70EyxP5uTZhQfxRZj8oKNAQ83Zyx89EV8BlQlv1e73jq4yLzLGMY
         c4Eg==
X-Gm-Message-State: AJcUukfeVyxUw5kA8KrUhOGKxAlS6qsd9ylnxcm+Hyz1AfEb2GZpERZo
        o3JMhP2UGSHO+AyfKnZWBZg=
X-Google-Smtp-Source: ALg8bN5bTGNm+DC9/5RsfxDeg5HIQySTJF1ZIV9CiR6QUr5jPOuPUOHGfhM9fze48SRwGdQljOq3sw==
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr25906841ljj.120.1548878389790;
        Wed, 30 Jan 2019 11:59:49 -0800 (PST)
Received: from [192.168.1.18] (dks71.neoplus.adsl.tpnet.pl. [83.24.22.71])
        by smtp.gmail.com with ESMTPSA id d23sm442938lfc.11.2019.01.30.11.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:59:49 -0800 (PST)
Subject: Re: [PATCH v2 11/13] leds: max77650: add LEDs support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190129133545.1931-1-brgl@bgdev.pl>
 <20190129133545.1931-13-brgl@bgdev.pl>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <3cf54618-90f7-03f9-88e0-03df1c15d0bd@gmail.com>
Date:   Wed, 30 Jan 2019 20:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129133545.1931-13-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

Thank you for the update.

One more thing drew my attention, please refer below.

On 1/29/19 2:35 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This adds basic support for LEDs for the max77650 PMIC. The device has
> three current sinks for driving LEDs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/leds/Kconfig         |   6 ++
>   drivers/leds/Makefile        |   1 +
>   drivers/leds/leds-max77650.c | 152 +++++++++++++++++++++++++++++++++++
>   3 files changed, 159 insertions(+)
>   create mode 100644 drivers/leds/leds-max77650.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..6e7a8f51eccc 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -608,6 +608,12 @@ config LEDS_TLC591XX
>   	  This option enables support for Texas Instruments TLC59108
>   	  and TLC59116 LED controllers.
>   
> +config LEDS_MAX77650
> +	tristate "LED support for Maxim MAX77650 PMIC"
> +	depends on MFD_MAX77650
> +	help
> +	  LEDs driver for MAX77650 family of PMICs from Maxim Integrated."
> +
>   config LEDS_MAX77693
>   	tristate "LED support for MAX77693 Flash"
>   	depends on LEDS_CLASS_FLASH
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4c1b0054f379..f48b2404dbb7 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
>   obj-$(CONFIG_LEDS_NS2)			+= leds-ns2.o
>   obj-$(CONFIG_LEDS_NETXBIG)		+= leds-netxbig.o
>   obj-$(CONFIG_LEDS_ASIC3)		+= leds-asic3.o
> +obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
>   obj-$(CONFIG_LEDS_MAX77693)		+= leds-max77693.o
>   obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>   obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
> diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
> new file mode 100644
> index 000000000000..e3a3c0e79b7a
> --- /dev/null
> +++ b/drivers/leds/leds-max77650.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 BayLibre SAS
> +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> +//
> +// LED driver for MAXIM 77650/77651 charger/power-supply.
> +
> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/mfd/max77650.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define MAX77650_NUM_LEDS		3
> +
> +#define MAX77650_LED_A_BASE		0x40
> +#define MAX77650_LED_B_BASE		0x43
> +
> +#define MAX77650_LED_BR_MASK		GENMASK(4, 0)
> +#define MAX77650_LED_EN_MASK		GENMASK(7, 6)
> +
> +/* Enable EN_LED_MSTR. */
> +#define MAX77650_LED_TOP_DEFAULT	BIT(0)
> +
> +#define MAX77650_LED_ENABLE		GENMASK(7, 6)
> +#define MAX77650_LED_DISABLE		0x00
> +
> +#define MAX77650_LED_A_DEFAULT		MAX77650_LED_DISABLE
> +/* 100% on duty */
> +#define MAX77650_LED_B_DEFAULT		GENMASK(3, 0)
> +
> +struct max77650_led {
> +	struct led_classdev cdev;
> +	struct regmap *map;
> +	unsigned int regA;
> +	unsigned int regB;
> +};
> +
> +static struct max77650_led *max77650_to_led(struct led_classdev *cdev)
> +{
> +	return container_of(cdev, struct max77650_led, cdev);
> +}
> +
> +static int max77650_led_brightness_set(struct led_classdev *cdev,
> +				       enum led_brightness brightness)
> +{
> +	struct max77650_led *led = max77650_to_led(cdev);
> +	int val, mask;
> +
> +	mask = MAX77650_LED_BR_MASK | MAX77650_LED_EN_MASK;
> +
> +	if (brightness == LED_OFF) {
> +		val = MAX77650_LED_DISABLE;
> +	} else {
> +		val = MAX77650_LED_ENABLE;
> +		/*
> +		 * We can set the brightness with 5-bit resolution.
> +		 *
> +		 * For brightness == 1, the bits we're writing will be 0, but
> +		 * since we keep LED_FS0 set to 12.8mA full-scale range, the
> +		 * LED will be lit slightly.
> +		 */
> +		val |= brightness / 8;

We have max_brightness property and you seem not to use it.
With 5-bit brightness resolution it should be initialized
to 32 and then we will be able to avoid the division here.

> +	}
> +
> +	return regmap_update_bits(led->map, led->regA, mask, val);
> +}
> +
> +static int max77650_led_probe(struct platform_device *pdev)
> +{
> +	struct device_node *of_node, *child;
> +	struct max77650_led *leds, *led;
> +	struct device *parent;
> +	struct device *dev;
> +	struct regmap *map;
> +	const char *label;
> +	int rv, num_leds;
> +	u32 reg;
> +
> +	dev = &pdev->dev;
> +	parent = dev->parent;
> +	of_node = dev->of_node;
> +
> +	if (!of_node)
> +		return -ENODEV;
> +
> +	leds = devm_kcalloc(dev, sizeof(*leds), MAX77650_NUM_LEDS, GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	map = dev_get_regmap(dev->parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	num_leds = of_get_child_count(of_node);
> +	if (!num_leds || num_leds > MAX77650_NUM_LEDS)
> +		return -ENODEV;
> +
> +	for_each_child_of_node(of_node, child) {
> +		rv = of_property_read_u32(child, "reg", &reg);
> +		if (rv || reg >= MAX77650_NUM_LEDS)
> +			return -EINVAL;
> +
> +		led = &leds[reg];
> +		led->map = map;
> +		led->regA = MAX77650_LED_A_BASE + reg;
> +		led->regB = MAX77650_LED_B_BASE + reg;
> +		led->cdev.brightness_set_blocking = max77650_led_brightness_set;
> +
> +		label = of_get_property(child, "label", NULL);
> +		if (!label) {
> +			led->cdev.name = "max77650::";
> +		} else {
> +			led->cdev.name = devm_kasprintf(dev, GFP_KERNEL,
> +							"max77650:%s", label);
> +			if (!led->cdev.name)
> +				return -ENOMEM;
> +		}
> +
> +		of_property_read_string(child, "linux,default-trigger",
> +					&led->cdev.default_trigger);
> +
> +		rv = devm_of_led_classdev_register(dev, child, &led->cdev);
> +		if (rv)
> +			return rv;
> +
> +		rv = regmap_write(map, led->regA, MAX77650_LED_A_DEFAULT);
> +		if (rv)
> +			return rv;
> +
> +		rv = regmap_write(map, led->regB, MAX77650_LED_B_DEFAULT);
> +		if (rv)
> +			return rv;
> +	}
> +
> +	return regmap_write(map,
> +			    MAX77650_REG_CNFG_LED_TOP,
> +			    MAX77650_LED_TOP_DEFAULT);
> +}
> +
> +static struct platform_driver max77650_led_driver = {
> +	.driver = {
> +		.name = "max77650-led",
> +	},
> +	.probe = max77650_led_probe,
> +};
> +module_platform_driver(max77650_led_driver);
> +
> +MODULE_DESCRIPTION("MAXIM 77650/77651 LED driver");
> +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Best regards,
Jacek Anaszewski

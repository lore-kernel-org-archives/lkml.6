Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A030FC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8A0218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VG1rZmzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfBATqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:46:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34150 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfBATqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:46:05 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so6864337lje.1;
        Fri, 01 Feb 2019 11:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q8QkYJd0VRTrI//MUm6iKZz8cQy/TFG+JgJ0Q+SJFAM=;
        b=VG1rZmzsAfwSYIjavuZluZrjiGg0XojYpoSpYCnLDCL0gWK7+el9Or1b54srnt+fXC
         qVpVSpklk767dtf6Ak8OG6Nf0Vmc85iXN0oVeVYh/OeNkwVykPCWBwMo31Zj8LeIzrcY
         vbXOPZZh3/8kPIrb5AThYBQkvKtlA4MkMDpJIRtIUq42gdDUQyIFkQW7s5LcoLvmztK/
         yJeTOxt9DI8Fs9h9ongZnZb3hTYLgvfv7W2oJvUUQpepG9euq5C4PZuG3qXDT0jWK7Ek
         2JB1bH225g3CpizAduzktWKdSl+VnDAd3+306KaYqcuTzhqxAB7uqdEM4jfqabPcao8y
         2vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q8QkYJd0VRTrI//MUm6iKZz8cQy/TFG+JgJ0Q+SJFAM=;
        b=BNCNfoR9kFBmrnsDuwGj6aHF+nJA+OeLNu1f+kmSTsTynPTk4wDKK76TnWmRalWWRu
         Papgs2F9l1TYS+CPD+lvihfSO80ygsI5/CNK1lhXjlS6tmcAR7hk5WM5ZPeFK01h/tOY
         mnOE0wNsvXXdYUzbqohJfPfyLMavUNW0Xrud3NCHX9DitGY1KVd9b87Wyh0eTsNtGHzv
         SCW5T0VynCB7Lt9nuQ8lmLDAve0YV4gDObRFX5CdghIsd/e5CBf5dw5Y+dfjkFTYWQmb
         27vKinDBQFwxeKmenkm/6+Y8JZtM676kTW/9xpZiP8GaYmiSYO7tDzFubI5Q+UcRTav3
         h6wQ==
X-Gm-Message-State: AHQUAubcUfyEBHRdVckLpO5XrRrq3s4XMBuY52hTybb9OM1xnNNnjz0Y
        SjoidyYIJumA0JdZWRukkXbxIlX/
X-Google-Smtp-Source: AHgI3IYU16dX6xaDbOTQsE67bBq4JNBfCaXH4Z6P1r8qLf1avJqxRh3hENUQ1so3LSMiphAlz+uDsg==
X-Received: by 2002:a2e:a289:: with SMTP id k9-v6mr7468471lja.24.1549050361785;
        Fri, 01 Feb 2019 11:46:01 -0800 (PST)
Received: from [192.168.1.18] (chr31.neoplus.adsl.tpnet.pl. [83.31.15.31])
        by smtp.gmail.com with ESMTPSA id q67sm1542365lfe.19.2019.02.01.11.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:46:00 -0800 (PST)
Subject: Re: [PATCH v3 09/11] leds: max77650: add LEDs support
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190201094736.32057-1-brgl@bgdev.pl>
 <20190201094736.32057-10-brgl@bgdev.pl>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <78b99abb-f367-1533-0690-8da26957a664@gmail.com>
Date:   Fri, 1 Feb 2019 20:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201094736.32057-10-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

Thanks for the update.

On 2/1/19 10:47 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This adds basic support for LEDs for the max77650 PMIC. The device has
> three current sinks for driving LEDs.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/leds/Kconfig         |   6 ++
>   drivers/leds/Makefile        |   1 +
>   drivers/leds/leds-max77650.c | 147 +++++++++++++++++++++++++++++++++++
>   3 files changed, 154 insertions(+)
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
> index 000000000000..6b74ce9cac12
> --- /dev/null
> +++ b/drivers/leds/leds-max77650.c
> @@ -0,0 +1,147 @@
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
> +#define MAX77650_LED_NUM_LEDS		3
> +
> +#define MAX77650_LED_A_BASE		0x40
> +#define MAX77650_LED_B_BASE		0x43
> +
> +#define MAX77650_LED_BR_MASK		GENMASK(4, 0)
> +#define MAX77650_LED_EN_MASK		GENMASK(7, 6)
> +
> +#define MAX77650_LED_MAX_BRIGHTNESS	MAX77650_LED_BR_MASK
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
> +	if (brightness == LED_OFF)
> +		val = MAX77650_LED_DISABLE;
> +	else
> +		val = MAX77650_LED_ENABLE | brightness;
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
> +	leds = devm_kcalloc(dev, sizeof(*leds),
> +			    MAX77650_LED_NUM_LEDS, GFP_KERNEL);
> +	if (!leds)
> +		return -ENOMEM;
> +
> +	map = dev_get_regmap(dev->parent, NULL);
> +	if (!map)
> +		return -ENODEV;
> +
> +	num_leds = of_get_child_count(of_node);
> +	if (!num_leds || num_leds > MAX77650_LED_NUM_LEDS)
> +		return -ENODEV;
> +
> +	for_each_child_of_node(of_node, child) {
> +		rv = of_property_read_u32(child, "reg", &reg);
> +		if (rv || reg >= MAX77650_LED_NUM_LEDS)
> +			return -EINVAL;
> +
> +		led = &leds[reg];
> +		led->map = map;
> +		led->regA = MAX77650_LED_A_BASE + reg;
> +		led->regB = MAX77650_LED_B_BASE + reg;
> +		led->cdev.brightness_set_blocking = max77650_led_brightness_set;
> +		led->cdev.max_brightness = MAX77650_LED_MAX_BRIGHTNESS;
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

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski

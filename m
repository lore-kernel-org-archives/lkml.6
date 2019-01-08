Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B30C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893E7217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBCyIXYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfAHVKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:10:55 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40607 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfAHVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:10:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so4651434lji.7;
        Tue, 08 Jan 2019 13:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EPTfXHkvUWTGqdzBFnDSrkH6aLH86y5MuVrQnlJJ6k8=;
        b=UBCyIXYjnzO7EJJ1m6AfkZ2FVdPBYKgS8APRO/KVGHqiZB3HvF1RqCMANxc26kI/XR
         luG29PvsEJvQNWQYWSOJUnupmJP2MzyvZnog9DbOzf5oUtU9+ROwxZv+TQ/cn6X7frq/
         ZPAwH9wUOVynVjZRejOFKRpc4p0PIZa8GZOb/g5KwZbVBdrDBD4FwS6rC5NPNbztYF77
         Iux3hWo5HyrlhGeWjH0sdP+pise1rjS7g/kF+lKPUA6T3O+9hdtou43soIuGgUyWqm+M
         Uan9aIKkPlStfDbQZPz2AJ9eAWROUn71iy5WgS4YvyhEOIt6seRRkD2pIjGc/JB2C9ls
         +PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EPTfXHkvUWTGqdzBFnDSrkH6aLH86y5MuVrQnlJJ6k8=;
        b=jc9L0iyBisocORGocng9PfJR47F6d23ZIICVbARdn9oo20R9SgjP4nOfo7mvgLIrjU
         TiFEPnWc5mKJzXC2R6e6qmPlV1i2tzS+trkHvlrg8tBCTsOtDv5liiBCrNYbkRAz3u6B
         CtuL80zxyNxtrKBtjMqLb9mcs3haukkaBqC6OI32EO3rp1mYL5ViIGjn639ATbYWwzRi
         VEswCiVUvqeUtFyJnozB0dFqxCpq9xFia5KC1iN+bcVfCXWh29l+5t2sh5EYOpYBaNhg
         U+o9f0baWuvktlqEhsPjdOwtlv2X83MgwChMKjaoVpkfcbpgNmZTMChiWHJlXqoxvWOD
         H7VQ==
X-Gm-Message-State: AJcUukdGt2UFL6I6SyI83i6+PtJncvU2mDfM4+1oeLK0G6vQjmWL712Z
        VQYbpetAPuJ9NqVXbVsvLG2DJ9oF
X-Google-Smtp-Source: ALg8bN4MII2rD/skRM8Kt5Tqkatsqs6QIuZkypoDjtVob3ygYpxpyyDR5apO25l8pq7LAMwkhF+wpg==
X-Received: by 2002:a2e:45d:: with SMTP id 90-v6mr1967105lje.110.1546981851312;
        Tue, 08 Jan 2019 13:10:51 -0800 (PST)
Received: from [192.168.1.18] (dlx201.neoplus.adsl.tpnet.pl. [83.24.53.201])
        by smtp.gmail.com with ESMTPSA id b21sm13236450lfi.7.2019.01.08.13.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 13:10:50 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20181219162626.12297-3-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <f1eaa557-0651-f812-d02d-be9368138cde@gmail.com>
Date:   Tue, 8 Jan 2019 22:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181219162626.12297-3-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 12/19/18 5:26 PM, Dan Murphy wrote:
> Introduce the LP5024 and LP5018 RGB LED driver.
> The difference in these 2 parts are only in the number of
> LED outputs where the LP5024 can control 24 LEDs the LP5018
> can only control 18.
> 
> The device has the ability to group LED output into control banks
> so that multiple LED banks can be controlled with the same mixing and
> brightness.  Inversely the LEDs can also be controlled independently.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   drivers/leds/Kconfig       |   7 +
>   drivers/leds/Makefile      |   1 +
>   drivers/leds/leds-lp5024.c | 610 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 618 insertions(+)
>   create mode 100644 drivers/leds/leds-lp5024.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index a72f97fca57b..d306bedb00b7 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -326,6 +326,13 @@ config LEDS_LP3952
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called leds-lp3952.
>   
> +config LEDS_LP5024
> +	tristate "LED Support for TI LP5024/18 LED driver chip"
> +	depends on LEDS_CLASS && REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Texas Instruments
> +	  LP5024 and LP5018 LED driver.
> +
>   config LEDS_LP55XX_COMMON
>   	tristate "Common Driver for TI/National LP5521/5523/55231/5562/8501"
>   	depends on LEDS_LP5521 || LEDS_LP5523 || LEDS_LP5562 || LEDS_LP8501
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 4c1b0054f379..60b4e4ddd3ee 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_LEDS_GPIO_REGISTER)	+= leds-gpio-register.o
>   obj-$(CONFIG_LEDS_GPIO)			+= leds-gpio.o
>   obj-$(CONFIG_LEDS_LP3944)		+= leds-lp3944.o
>   obj-$(CONFIG_LEDS_LP3952)		+= leds-lp3952.o
> +obj-$(CONFIG_LEDS_LP5024)		+= leds-lp5024.o
>   obj-$(CONFIG_LEDS_LP55XX_COMMON)	+= leds-lp55xx-common.o
>   obj-$(CONFIG_LEDS_LP5521)		+= leds-lp5521.o
>   obj-$(CONFIG_LEDS_LP5523)		+= leds-lp5523.o
> diff --git a/drivers/leds/leds-lp5024.c b/drivers/leds/leds-lp5024.c
> new file mode 100644
> index 000000000000..90e8dca15609
> --- /dev/null
> +++ b/drivers/leds/leds-lp5024.c
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* TI LP50XX LED chip family driver
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <uapi/linux/uleds.h>
> +
> +#define LP5024_DEV_CFG0		0x00
> +#define LP5024_DEV_CFG1		0x01
> +#define LP5024_LED_CFG0		0x02
> +#define LP5024_BNK_BRT		0x03
> +#define LP5024_BNKA_CLR		0x04
> +#define LP5024_BNKB_CLR		0x05
> +#define LP5024_BNKC_CLR		0x06
> +#define LP5024_LED0_BRT		0x07
> +#define LP5024_LED1_BRT		0x08
> +#define LP5024_LED2_BRT		0x09
> +#define LP5024_LED3_BRT		0x0a
> +#define LP5024_LED4_BRT		0x0b
> +#define LP5024_LED5_BRT		0x0c
> +#define LP5024_LED6_BRT		0x0d
> +#define LP5024_LED7_BRT		0x0e
> +
> +#define LP5024_OUT0_CLR		0x0f
> +#define LP5024_OUT1_CLR		0x10
> +#define LP5024_OUT2_CLR		0x11
> +#define LP5024_OUT3_CLR		0x12
> +#define LP5024_OUT4_CLR		0x13
> +#define LP5024_OUT5_CLR		0x14
> +#define LP5024_OUT6_CLR		0x15
> +#define LP5024_OUT7_CLR		0x16
> +#define LP5024_OUT8_CLR		0x17
> +#define LP5024_OUT9_CLR		0x18
> +#define LP5024_OUT10_CLR	0x19
> +#define LP5024_OUT11_CLR	0x1a
> +#define LP5024_OUT12_CLR	0x1b
> +#define LP5024_OUT13_CLR	0x1c
> +#define LP5024_OUT14_CLR	0x1d
> +#define LP5024_OUT15_CLR	0x1e
> +#define LP5024_OUT16_CLR	0x1f
> +#define LP5024_OUT17_CLR	0x20
> +#define LP5024_OUT18_CLR	0x21
> +#define LP5024_OUT19_CLR	0x22
> +#define LP5024_OUT20_CLR	0x23
> +#define LP5024_OUT21_CLR	0x24
> +#define LP5024_OUT22_CLR	0x25
> +#define LP5024_OUT23_CLR	0x26
> +
> +#define LP5024_RESET		0x27
> +#define LP5024_SW_RESET		0xff
> +
> +#define LP5024_CHIP_EN		BIT(6)
> +
> +#define LP5024_CONTROL_A		0
> +#define LP5024_CONTROL_B		1
> +#define LP5024_CONTROL_C		2
> +#define LP5024_MAX_CONTROL_BANKS	3
> +
> +#define LP5018_MAX_LED_STRINGS	6
> +#define LP5024_MAX_LED_STRINGS	8
> +
> +enum lp5024_model {
> +	LP5018,
> +	LP5024,
> +};
> +
> +struct lp5024_led {
> +	u32 led_strings[LP5024_MAX_LED_STRINGS];
> +	char label[LED_MAX_NAME_SIZE];
> +	struct led_classdev led_dev;
> +	struct lp5024 *priv;
> +	int led_number;
> +	u8 ctrl_bank_enabled;
> +};
> +
> +/**
> + * struct lp5024 -
> + * @enable_gpio: Hardware enable gpio
> + * @regulator: LED supply regulator pointer
> + * @client: Pointer to the I2C client
> + * @regmap: Devices register map
> + * @dev: Pointer to the devices device struct
> + * @lock: Lock for reading/writing the device
> + * @model_id: ID of the device
> + * @leds: Array of LED strings
> + */
> +struct lp5024 {
> +	struct gpio_desc *enable_gpio;
> +	struct regulator *regulator;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +	int model_id;
> +	int max_leds;
> +	int num_of_leds;
> +
> +	/* This needs to be at the end of the struct */
> +	struct lp5024_led leds[];
> +};
> +
> +static const struct reg_default lp5024_reg_defs[] = {
> +	{LP5024_DEV_CFG0, 0x0},
> +	{LP5024_DEV_CFG1, 0x3c},
> +	{LP5024_BNK_BRT, 0xff},
> +	{LP5024_BNKA_CLR, 0x0f},
> +	{LP5024_BNKB_CLR, 0x0f},
> +	{LP5024_BNKC_CLR, 0x0f},
> +	{LP5024_LED0_BRT, 0x0f},
> +	{LP5024_LED1_BRT, 0xff},
> +	{LP5024_LED2_BRT, 0xff},
> +	{LP5024_LED3_BRT, 0xff},
> +	{LP5024_LED4_BRT, 0xff},
> +	{LP5024_LED5_BRT, 0xff},
> +	{LP5024_LED6_BRT, 0xff},
> +	{LP5024_LED7_BRT, 0xff},
> +	{LP5024_OUT0_CLR, 0x0f},
> +	{LP5024_OUT1_CLR, 0x00},
> +	{LP5024_OUT2_CLR, 0x00},
> +	{LP5024_OUT3_CLR, 0x00},
> +	{LP5024_OUT4_CLR, 0x00},
> +	{LP5024_OUT5_CLR, 0x00},
> +	{LP5024_OUT6_CLR, 0x00},
> +	{LP5024_OUT7_CLR, 0x00},
> +	{LP5024_OUT8_CLR, 0x00},
> +	{LP5024_OUT9_CLR, 0x00},
> +	{LP5024_OUT10_CLR, 0x00},
> +	{LP5024_OUT11_CLR, 0x00},
> +	{LP5024_OUT12_CLR, 0x00},
> +	{LP5024_OUT13_CLR, 0x00},
> +	{LP5024_OUT14_CLR, 0x00},
> +	{LP5024_OUT15_CLR, 0x00},
> +	{LP5024_OUT16_CLR, 0x00},
> +	{LP5024_OUT17_CLR, 0x00},
> +	{LP5024_OUT18_CLR, 0x00},
> +	{LP5024_OUT19_CLR, 0x00},
> +	{LP5024_OUT20_CLR, 0x00},
> +	{LP5024_OUT21_CLR, 0x00},
> +	{LP5024_OUT22_CLR, 0x00},
> +	{LP5024_OUT23_CLR, 0x00},
> +	{LP5024_RESET, 0x00}
> +};
> +
> +static const struct regmap_config lp5024_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = LP5024_RESET,
> +	.reg_defaults = lp5024_reg_defs,
> +	.num_reg_defaults = ARRAY_SIZE(lp5024_reg_defs),
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int lp5024_set_color_mix(struct lp5024_led *led, u8 color_reg,
> +				u8 color_val)
> +{
> +	return regmap_write(led->priv->regmap, color_reg, color_val);
> +}
> +
> +
> +static ssize_t ctrl_bank_a_mix_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	u8 mix_value;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &mix_value);
> +	if (ret)
> +		return ret;
> +
> +	lp5024_set_color_mix(led, LP5024_BNKA_CLR, mix_value);
> +
> +	return size;
> +}
> +static ssize_t ctrl_bank_b_mix_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	u8 mix_value;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &mix_value);
> +	if (ret)
> +		return ret;
> +
> +	lp5024_set_color_mix(led, LP5024_BNKB_CLR, mix_value);
> +
> +	return size;
> +}
> +static ssize_t ctrl_bank_c_mix_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	u8 mix_value;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &mix_value);
> +	if (ret)
> +		return ret;
> +
> +	lp5024_set_color_mix(led, LP5024_BNKC_CLR, mix_value);
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_WO(ctrl_bank_a_mix);
> +static DEVICE_ATTR_WO(ctrl_bank_b_mix);
> +static DEVICE_ATTR_WO(ctrl_bank_c_mix);

Why WO?

> +
> +static struct attribute *lp5024_ctrl_bank_attrs[] = {
> +	&dev_attr_ctrl_bank_a_mix.attr,
> +	&dev_attr_ctrl_bank_b_mix.attr,
> +	&dev_attr_ctrl_bank_c_mix.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(lp5024_ctrl_bank);
> +
> +static ssize_t led3_mix_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	u8 mix_value;
> +	u8 reg_value; > +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &mix_value);
> +	if (ret)
> +		return ret;
> +
> +	reg_value = (led->led_number * 3) + LP5024_OUT2_CLR;

It is more natural if constant goes first. Like BASE_ADDR + offset.

> +
> +	lp5024_set_color_mix(led, reg_value, mix_value);
> +
> +	return size;
> +}
> +
> +static ssize_t led2_mix_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	u8 mix_value;
> +	u8 reg_value;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &mix_value);
> +	if (ret)
> +		return ret;
> +
> +	reg_value = (led->led_number * 3) + LP5024_OUT1_CLR;
> +
> +	lp5024_set_color_mix(led, reg_value, mix_value);
> +
> +	return size;
> +}
> +
> +static ssize_t led1_mix_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t size)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	u8 mix_value;
> +	u8 reg_value;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 0, &mix_value);
> +	if (ret)
> +		return ret;
> +
> +	reg_value = (led->led_number * 3) + LP5024_OUT0_CLR;
> +
> +	lp5024_set_color_mix(led, reg_value, mix_value);
> +
> +	return size;
> +}
> +
> +static DEVICE_ATTR_WO(led1_mix);
> +static DEVICE_ATTR_WO(led2_mix);
> +static DEVICE_ATTR_WO(led3_mix);

Why WO?

> +static struct attribute *lp5024_led_independent_attrs[] = {
> +	&dev_attr_led1_mix.attr,
> +	&dev_attr_led2_mix.attr,
> +	&dev_attr_led3_mix.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(lp5024_led_independent);
> +
> +static int lp5024_brightness_set(struct led_classdev *led_cdev,
> +				enum led_brightness brt_val)
> +{
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	int ret = 0;
> +	u8 reg_val;
> +
> +	mutex_lock(&led->priv->lock);
> +
> +	if (led->ctrl_bank_enabled)
> +		reg_val = LP5024_BNK_BRT;
> +	else
> +		reg_val = led->led_number + LP5024_LED0_BRT;
> +
> +	ret = regmap_write(led->priv->regmap, reg_val, brt_val);
> +
> +	mutex_unlock(&led->priv->lock);
> +
> +	return ret;
> +}
> +
> +static enum led_brightness lp5024_brightness_get(struct led_classdev *led_cdev)
> +{
> +	struct lp5024_led *led = container_of(led_cdev, struct lp5024_led,
> +					      led_dev);
> +	unsigned int brt_val;
> +	u8 reg_val;
> +	int ret;
> +
> +	mutex_lock(&led->priv->lock);
> +
> +	if (led->ctrl_bank_enabled)
> +		reg_val = LP5024_BNK_BRT;
> +	else
> +		reg_val = led->led_number + LP5024_LED0_BRT;
> +
> +	ret = regmap_read(led->priv->regmap, reg_val, &brt_val);
> +
> +	mutex_unlock(&led->priv->lock);
> +
> +	return brt_val;
> +}
> +
> +static int lp5024_set_led_values(struct lp5024 *priv)
> +{
> +	struct lp5024_led *led;
> +	int i, j;
> +	u8 led_ctrl_enable = 0;
> +
> +	for (i = 0; i <= priv->num_of_leds; i++) {
> +		led = &priv->leds[i];
> +		if (led->ctrl_bank_enabled) {
> +			for (j = 0; j <= LP5024_MAX_LED_STRINGS - 1; j++)
> +				led_ctrl_enable |= (1 << led->led_strings[j]);
> +		}
> +	}
> +
> +	regmap_write(priv->regmap, LP5024_LED_CFG0, led_ctrl_enable);
> +
> +	return 0;
> +}
> +
> +static int lp5024_init(struct lp5024 *priv)
> +{
> +	int ret;
> +
> +	if (priv->enable_gpio) {
> +		gpiod_direction_output(priv->enable_gpio, 1);
> +	} else {
> +		ret = regmap_write(priv->regmap, LP5024_RESET, LP5024_SW_RESET);
> +		if (ret) {
> +			dev_err(&priv->client->dev,
> +				"Cannot reset the device\n");
> +			goto out;
> +		}
> +	}
> +
> +	ret = lp5024_set_led_values(priv);
> +	if (ret)
> +		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
> +
> +	ret = regmap_write(priv->regmap, LP5024_DEV_CFG0, LP5024_CHIP_EN);
> +	if (ret) {
> +		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
> +		goto out;
> +	}
> +out:
> +	return ret;
> +}
> +
> +static int lp5024_probe_dt(struct lp5024 *priv)
> +{
> +	struct fwnode_handle *child = NULL;
> +	struct lp5024_led *led;
> +	const char *name;
> +	int led_number;
> +	size_t i = 0;
> +	int ret;
> +
> +	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
> +						   "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->enable_gpio)) {
> +		ret = PTR_ERR(priv->enable_gpio);
> +		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
> +	if (IS_ERR(priv->regulator))
> +		priv->regulator = NULL;
> +
> +	if (priv->model_id == LP5018)
> +		priv->max_leds = LP5018_MAX_LED_STRINGS;
> +	else
> +		priv->max_leds = LP5024_MAX_LED_STRINGS;
> +
> +	device_for_each_child_node(&priv->client->dev, child) {
> +		led = &priv->leds[i];
> +
> +		if (fwnode_property_present(child, "ti,control-bank"))
> +			led->ctrl_bank_enabled = 1;
> +		else
> +			led->ctrl_bank_enabled = 0;
> +
> +		if (led->ctrl_bank_enabled) {
> +			ret = fwnode_property_read_u32_array(child,
> +							     "led-sources",
> +							     NULL, 0);
> +			ret = fwnode_property_read_u32_array(child,
> +							     "led-sources",
> +							     led->led_strings,
> +							     ret);
> +
> +			led->led_number = led->led_strings[0];
> +
> +		} else {
> +			ret = fwnode_property_read_u32(child, "led-sources",
> +					       &led_number);
> +
> +			led->led_number = led_number;
> +		}
> +		if (ret) {
> +			dev_err(&priv->client->dev,
> +				"led-sources property missing\n");
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		if (led_number > priv->max_leds) {
> +			dev_err(&priv->client->dev,
> +				"led-sources property is invalid\n");
> +			ret = -EINVAL;
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +
> +		ret = fwnode_property_read_string(child, "label", &name);
> +		if (ret)
> +			snprintf(led->label, sizeof(led->label),
> +				"%s::", priv->client->name);
> +		else
> +			snprintf(led->label, sizeof(led->label),
> +				 "%s:%s", priv->client->name, name);
> +
> +		fwnode_property_read_string(child, "linux,default-trigger",
> +				    &led->led_dev.default_trigger);
> +
> +		led->priv = priv;
> +		led->led_dev.name = led->label;
> +		led->led_dev.max_brightness = 255;
> +		led->led_dev.brightness_set_blocking = lp5024_brightness_set;
> +		led->led_dev.brightness_get = lp5024_brightness_get;
> +
> +		if (led->ctrl_bank_enabled)
> +			led->led_dev.groups = lp5024_ctrl_bank_groups;
> +		else
> +			led->led_dev.groups = lp5024_led_independent_groups;
> +
> +		ret = devm_led_classdev_register(&priv->client->dev,
> +						 &led->led_dev);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "led register err: %d\n",
> +				ret);
> +			fwnode_handle_put(child);
> +			goto child_out;
> +		}
> +		i++;
> +	}
> +	priv->num_of_leds = i;
> +
> +child_out:
> +	return ret;
> +}
> +
> +static int lp5024_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct lp5024 *led;
> +	int count;
> +	int ret;
> +
> +	count = device_get_child_node_count(&client->dev);
> +	if (!count) {
> +		dev_err(&client->dev, "LEDs are not defined in device tree!");
> +		return -ENODEV;
> +	}
> +
> +	led = devm_kzalloc(&client->dev, struct_size(led, leds, count),
> +			   GFP_KERNEL);
> +	if (!led)
> +		return -ENOMEM;
> +
> +	mutex_init(&led->lock);
> +	led->client = client;
> +	led->dev = &client->dev;
> +	led->model_id = id->driver_data;
> +	i2c_set_clientdata(client, led);
> +
> +	led->regmap = devm_regmap_init_i2c(client, &lp5024_regmap_config);
> +	if (IS_ERR(led->regmap)) {
> +		ret = PTR_ERR(led->regmap);
> +		dev_err(&client->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = lp5024_probe_dt(led);
> +	if (ret)
> +		return ret;
> +
> +	ret = lp5024_init(led);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int lp5024_remove(struct i2c_client *client)
> +{
> +	struct lp5024 *led = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = regmap_update_bits(led->regmap, LP5024_DEV_CFG0,
> +				 LP5024_CHIP_EN, 0);
> +	if (ret) {
> +		dev_err(&led->client->dev, "Failed to disable regulator\n");
> +		return ret;
> +	}
> +
> +	if (led->enable_gpio)
> +		gpiod_direction_output(led->enable_gpio, 0);
> +
> +	if (led->regulator) {
> +		ret = regulator_disable(led->regulator);
> +		if (ret)
> +			dev_err(&led->client->dev,
> +				"Failed to disable regulator\n");
> +	}
> +
> +	mutex_destroy(&led->lock);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id lp5024_id[] = {
> +	{ "lp5018", LP5018 },
> +	{ "lp5024", LP5024 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, lp5024_id);
> +
> +static const struct of_device_id of_lp5024_leds_match[] = {
> +	{ .compatible = "ti,lp5018", },
> +	{ .compatible = "ti,lp5024", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_lp5024_leds_match);
> +
> +static struct i2c_driver lp5024_driver = {
> +	.driver = {
> +		.name	= "lp5024",
> +		.of_match_table = of_lp5024_leds_match,
> +	},
> +	.probe		= lp5024_probe,
> +	.remove		= lp5024_remove,
> +	.id_table	= lp5024_id,
> +};
> +module_i2c_driver(lp5024_driver);
> +
> +MODULE_DESCRIPTION("Texas Instruments LP5024 LED driver");
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Best regards,
Jacek Anaszewski

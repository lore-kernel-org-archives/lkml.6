Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96177C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB54217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3a3mI/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB54217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeHDOO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:14:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34856 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHDOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:14:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id o18-v6so9277749wmc.0;
        Sat, 04 Aug 2018 05:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rde43BCqqY15V7lIYXYL+hXQeoL4Yas9zfy5x5LjoM=;
        b=m3a3mI/QKJOmsGdNRl0EHibbkG5jeTMR7i7EbJuQDtK9/GioGI3NCdL9e624puLZqg
         VN2+5CmqU36bjiWQqWNkzs4rQjfyP1BzDaStN+Xfqoc9a6/SPHImO+xDVp5JacQTq6MH
         We3r33LK2YD3phCngvJ0N05PcLCPzyy0/Ozal+xXgyDQ+wd7UVWbnN2AXjoYLzap6ymq
         cn/rt9796h456yUketmvWP/EO5jjQ5VbmLewBpnZHa6ZrlrEUrHq+gSbYYnOGGpET4kO
         3QkVpN8cSnce7FJlvc+KiIldDFMdT7fPrJHogeNj135/s+qVpcbT8AjeiFNwyoRT8T40
         8L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rde43BCqqY15V7lIYXYL+hXQeoL4Yas9zfy5x5LjoM=;
        b=Cg3dGYjxeFc27en8y1tPr+TYbuwYN9kSwUlXA107rcJArn10j83qX2EufOW5rND9FW
         hvldXOyAlypbs+44KutfYBDdld3frdcFnGE+5cyQ4krGRbnO5ableVYVW6vJBZ0sbTsC
         4y/VFqciQ89gBVGeRSEukYv3BnQafROKS9eUeVRoyy8LnMHfcFESwNrtC/nUT6/ce8X4
         jj9DdJfLBBusfu3N5pg0YDB9CSmQ4Yo2S3DnATVtTlj7QtAL6UsmiFgqAnf8aZ/VvE6P
         7CO2L/styxueAJ4zkND7f83aqIqP6qDtJl2qBevEuvbvEt9C55c9COEH31LIcBKuzlyr
         Uf8g==
X-Gm-Message-State: AOUpUlEWaL3AuNVYG8Y+BkrR/X82BzCVPBguQFqPFp/ntmqM3rhwXWAX
        fP/U37x5OiY1er5ix6QcEVO2Ftnv
X-Google-Smtp-Source: AAOMgpfHtmrfgvVkpNP412Tzxn5CbnO2z2B0QxN+bIDMKZ6EMJsqUGsejl1SFbUsXV4yaTTuJtvzCA==
X-Received: by 2002:a1c:80b:: with SMTP id 11-v6mr7727727wmi.125.1533384862299;
        Sat, 04 Aug 2018 05:14:22 -0700 (PDT)
Received: from [192.168.1.18] (bky33.neoplus.adsl.tpnet.pl. [83.28.192.33])
        by smtp.gmail.com with ESMTPSA id g10-v6sm5863736wrv.90.2018.08.04.05.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 05:14:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] leds: lm3697: Introduce the lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180803150231.7172-1-dmurphy@ti.com>
 <20180803150231.7172-2-dmurphy@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <99c16b47-5eb0-947f-3bdb-966d7c4b726d@gmail.com>
Date:   Sat, 4 Aug 2018 14:14:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180803150231.7172-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch. Please find my comments below.

On 08/03/2018 05:02 PM, Dan Murphy wrote:
> Introduce the lm3697 LED driver for
> backlighting and display.
> 
> Datasheet location:
> http://www.ti.com/lit/ds/symlink/lm3697.pdf
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  drivers/leds/Kconfig       |   9 +
>  drivers/leds/Makefile      |   1 +
>  drivers/leds/leds-lm3697.c | 375 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 385 insertions(+)
>  create mode 100644 drivers/leds/leds-lm3697.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6e3a998f3370..efa8be180934 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -150,6 +150,15 @@ config LEDS_LM3642
>  	  converter plus 1.5A constant current driver for a high-current
>  	  white LED.
>  
> +config LEDS_LM3697
> +	tristate "LED support for LM3697 Chip"
> +	depends on LEDS_CLASS && I2C
> +	select REGMAP_I2C
> +	help
> +	  This option enables support for LEDs connected to LM3697.
> +	  The LM3697 is an 11 bit high performance backlight driver for
> +	  keypad and display lighting.
> +
>  config LEDS_LM3692X
>  	tristate "LED support for LM3692x Chips"
>  	depends on LEDS_CLASS && I2C && OF
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 420b5d2cfa62..2813f089f3db 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
>  obj-$(CONFIG_LEDS_LM3530)		+= leds-lm3530.o
>  obj-$(CONFIG_LEDS_LM3533)		+= leds-lm3533.o
>  obj-$(CONFIG_LEDS_LM3642)		+= leds-lm3642.o
> +obj-$(CONFIG_LEDS_LM3697)		+= leds-lm3697.o
>  obj-$(CONFIG_LEDS_MIKROTIK_RB532)	+= leds-rb532.o
>  obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
>  obj-$(CONFIG_LEDS_NET48XX)		+= leds-net48xx.o
> diff --git a/drivers/leds/leds-lm3697.c b/drivers/leds/leds-lm3697.c
> new file mode 100644
> index 000000000000..332bde4af01a
> --- /dev/null
> +++ b/drivers/leds/leds-lm3697.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// TI LM3697 LED chip family driver
> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
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
> +#define LM3697_REV			0x0
> +#define LM3697_RESET			0x1
> +#define LM3697_OUTPUT_CONFIG		0x10
> +#define LM3697_CTRL_A_RAMP		0x11
> +#define LM3697_CTRL_B_RAMP		0x12
> +#define LM3697_CTRL_A_B_RT_RAMP		0x13
> +#define LM3697_CTRL_A_B_RAMP_CFG	0x14
> +#define LM3697_CTRL_A_B_BRT_CFG		0x16
> +#define LM3697_CTRL_A_FS_CURR_CFG	0x17
> +#define LM3697_CTRL_B_FS_CURR_CFG	0x18
> +#define LM3697_PWM_CFG			0x1c
> +#define LM3697_CTRL_A_BRT_LSB		0x20
> +#define LM3697_CTRL_A_BRT_MSB		0x21
> +#define LM3697_CTRL_B_BRT_LSB		0x22
> +#define LM3697_CTRL_B_BRT_MSB		0x23
> +#define LM3697_CTRL_ENABLE		0x24
> +
> +#define LM3697_SW_RESET		BIT(0)
> +
> +#define LM3697_CTRL_A_EN	BIT(0)
> +#define LM3697_CTRL_B_EN	BIT(1)
> +#define LM3697_CTRL_A_B_EN	(LM3697_CTRL_A_EN | LM3697_CTRL_B_EN)
> +
> +#define LM3697_CONTROL_A	0
> +#define LM3697_CONTROL_B	1
> +
> +#define LM3697_HVLED1_2_3_A		0
> +#define LM3697_HVLED1_B_HVLED2_3_A	1
> +#define LM3697_HVLED2_B_HVLED1_3_A	2
> +#define LM3697_HVLED1_2_B_HVLED3_A	3
> +#define LM3697_HVLED3_B_HVLED1_2_A	4
> +#define LM3697_HVLED1_3_B_HVLED2_A	5
> +#define LM3697_HVLED1_A_HVLED2_3_B	6
> +#define LM3697_HVLED1_2_3_B		7
> +
> +/**
> + * struct lm3697_led -
> + * @led_dev - LED class device pointer

This is not a pointer but static struct property,
i.e. it should be "LED class device".

> + * @priv - Pointer to the device struct
> + * @control_bank - Control bank the LED is associated to. 0 is control bank A
> + *		   1 is control bank B.
> + * @label - LED label
> + */
> +struct lm3697_led {
> +	struct led_classdev led_dev;
> +	struct lm3697 *priv;
> +	int control_bank;
> +	char label[LED_MAX_NAME_SIZE];
> +};
> +
> +/**
> + * struct lm3697 -
> + * @lock - Lock for reading/writing the device
> + * @client - Pointer to the I2C client
> + * @dev - Pointer to the devices device struct
> + * @regmap - Devices register map
> + * @enable_gpio - Hardware enable gpio
> + * @regulator - LED supply regulator pointer
> + * @control_bank_config - Control bank configuration
> + * @leds - Array of LED strings.
> + */
> +struct lm3697 {
> +	struct mutex lock;
> +	struct i2c_client *client;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct gpio_desc *enable_gpio;
> +	struct regulator *regulator;
> +	int control_bank_config;
> +	struct lm3697_led leds[];
> +};
> +
> +static const struct reg_default lm3697_reg_defs[] = {
> +	{LM3697_OUTPUT_CONFIG, 0x6},
> +	{LM3697_CTRL_A_RAMP, 0x0},
> +	{LM3697_CTRL_B_RAMP, 0x0},
> +	{LM3697_CTRL_A_B_RT_RAMP, 0x0},
> +	{LM3697_CTRL_A_B_RAMP_CFG, 0x0},
> +	{LM3697_CTRL_A_B_BRT_CFG, 0x0},
> +	{LM3697_CTRL_A_FS_CURR_CFG, 0x13},
> +	{LM3697_CTRL_B_FS_CURR_CFG, 0x13},
> +	{LM3697_PWM_CFG, 0xc},
> +	{LM3697_CTRL_A_BRT_LSB, 0x0},
> +	{LM3697_CTRL_A_BRT_MSB, 0x0},
> +	{LM3697_CTRL_B_BRT_LSB, 0x0},
> +	{LM3697_CTRL_B_BRT_MSB, 0x0},
> +	{LM3697_CTRL_ENABLE, 0x0},
> +};
> +
> +static const struct regmap_config lm3697_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = LM3697_CTRL_ENABLE,
> +	.reg_defaults = lm3697_reg_defs,
> +	.num_reg_defaults = ARRAY_SIZE(lm3697_reg_defs),
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int lm3697_brightness_set(struct led_classdev *led_cdev,
> +				enum led_brightness brt_val)
> +{
> +	struct lm3697_led *led = container_of(led_cdev, struct lm3697_led,
> +					      led_dev);
> +	int brt_msb_reg, brt_lsb_reg, ctrl_en_val;
> +	int led_brightness_lsb = (brt_val >> 5);
> +	int ret;
> +
> +	mutex_lock(&led->priv->lock);
> +
> +	if (led->control_bank == LM3697_CONTROL_A) {
> +		brt_msb_reg = LM3697_CTRL_A_BRT_MSB;
> +		brt_lsb_reg = LM3697_CTRL_A_BRT_LSB;
> +		ctrl_en_val = LM3697_CTRL_A_EN;
> +	} else {
> +		brt_msb_reg = LM3697_CTRL_B_BRT_MSB;
> +		brt_lsb_reg = LM3697_CTRL_B_BRT_LSB;
> +		ctrl_en_val = LM3697_CTRL_B_EN;
> +	}
> +
> +	if (brt_val == LED_OFF)
> +		ret = regmap_update_bits(led->priv->regmap, LM3697_CTRL_ENABLE,
> +					 ctrl_en_val, ~ctrl_en_val);
> +	else
> +		ret = regmap_update_bits(led->priv->regmap, LM3697_CTRL_ENABLE,
> +					 ctrl_en_val, ctrl_en_val);
> +	

checkpatch.pl reports trailing whitespace here.

> +	if (ret) {
> +		dev_err(&led->priv->client->dev, "Cannot write CTRL enable\n");
> +		goto out;
> +	}
> +> +	ret = regmap_write(led->priv->regmap, brt_lsb_reg, led_brightness_lsb);
> +	if (ret) {
> +		dev_err(&led->priv->client->dev, "Cannot write LSB\n");
> +		goto out;
> +	}
> +
> +	ret = regmap_write(led->priv->regmap, brt_msb_reg, brt_val);
> +	if (ret) {
> +		dev_err(&led->priv->client->dev, "Cannot write MSB\n");
> +		goto out;
> +	}
> +out:
> +	mutex_unlock(&led->priv->lock);
> +	return ret;
> +}
> +
> +static int lm3697_init(struct lm3697 *priv)
> +{
> +	int ret;
> +
> +	if (priv->enable_gpio)
> +		gpiod_direction_output(priv->enable_gpio, 1);
> +	else
> +		regmap_write(priv->regmap, LM3697_RESET, LM3697_SW_RESET);
> +
> +	ret = regmap_write(priv->regmap, LM3697_OUTPUT_CONFIG,
> +			   priv->control_bank_config);
> +	if (ret) {
> +		dev_err(&priv->client->dev, "Cannot write MSB\n");
> +		goto out;
> +	}
> +
> +	ret = regmap_write(priv->regmap, LM3697_CTRL_ENABLE, 0x0);
> +	if (ret) {
> +		dev_err(&priv->client->dev, "Cannot write LSB\n");
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static int lm3697_probe_dt(struct lm3697 *priv)
> +{
> +	struct fwnode_handle *child = NULL;
> +	struct fwnode_handle *fwnode;
> +	struct device_node *np;
> +	struct lm3697_led *led;
> +	const char *name;
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
> +	fwnode = of_fwnode_handle(priv->client->dev.of_node);

To remain OF agnostic here, you could use
dev_fwnode(&priv->client->dev) here.

> +	ret = fwnode_property_read_u32(fwnode, "control-bank-cfg",
> +				       &priv->control_bank_config);
> +	if (ret) {
> +		dev_err(&priv->client->dev, "reg DT property missing\n");
> +		goto out;
> +	}
> +
> +	if (priv->control_bank_config < LM3697_HVLED1_2_3_A ||
> +	    priv->control_bank_config > LM3697_HVLED1_2_3_B) {
> +		dev_err(&priv->client->dev, "Control bank configuration is \
> +			out of range\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +

Please remove one empty line here.

> +
> +	device_for_each_child_node(priv->dev, child) {
> +		np = to_of_node(child);

This is not needed really.

> +		led = &priv->leds[i];
> +
> +		ret = fwnode_property_read_u32(child, "reg", &led->control_bank);
> +		if (ret) {
> +			dev_err(&priv->client->dev, "reg DT property missing\n");
> +			goto child_out;
> +		}
> +
> +		fwnode_property_read_string(child, "linux,default-trigger",
> +					    &led->led_dev.default_trigger);
> +
> +		ret = fwnode_property_read_string(child, "label", &name);
> +		if (ret)
> +			snprintf(led->label, sizeof(led->label),
> +				"%s::", priv->client->name);
> +		else
> +			snprintf(led->label, sizeof(led->label),
> +				 "%s:%s", priv->client->name, name);
> +
> +
> +		led->priv = priv;
> +		led->led_dev.name = led->label;
> +		led->led_dev.brightness_set_blocking = lm3697_brightness_set;
> +
> +		ret = devm_of_led_classdev_register(priv->dev, np,
> +						    &led->led_dev);

Please use devm_led_classdev_register() wrapper.
devm_of_led_classdev_register() was introduced to enable parsing trigger
related DT properties, but the support hasn't been finalized.

> +		if (ret) {
> +			dev_err(&priv->client->dev, "led register err: %d\n", ret);
> +			goto child_out;
> +		}
> +
> +		led->led_dev.dev->of_node = to_of_node(child);

of_led_classdev_register() does this assignment already, but you don't
need it either way.

> +
> +		if (priv->control_bank_config == LM3697_HVLED1_2_3_A ||
> +		    priv->control_bank_config == LM3697_HVLED1_2_3_B)
> +			goto child_out;
> +
> +		i++;
> +		fwnode_handle_put(child);
> +	}
> +
> +child_out:
> +	fwnode_handle_put(child);
> +out:
> +	return ret;
> +}
> +
> +static int lm3697_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct lm3697 *led;
> +	int count;
> +	int ret;
> +
> +	count = device_get_child_node_count(&client->dev);
> +	if (!count) {
> +		dev_err(&client->dev, "LEDs are not defined in device tree!");
> +		return -ENODEV;
> +	}
> +
> +	led = devm_kzalloc(&client->dev, struct_size(led, leds, count), GFP_KERNEL);
> +	if (!led)
> +		return -ENOMEM;
> +
> +	mutex_init(&led->lock);
> +	i2c_set_clientdata(client, led);
> +
> +	led->client = client;
> +	led->dev = &client->dev;
> +	led->regmap = devm_regmap_init_i2c(client, &lm3697_regmap_config);
> +	if (IS_ERR(led->regmap)) {
> +		ret = PTR_ERR(led->regmap);
> +		dev_err(&client->dev, "Failed to allocate register map: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = lm3697_probe_dt(led);
> +	if (ret)
> +		return ret;
> +
> +	ret = lm3697_init(led);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
> +}
> +
> +static int lm3697_remove(struct i2c_client *client)
> +{
> +	struct lm3697 *led = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = regmap_update_bits(led->regmap, LM3697_CTRL_ENABLE,
> +				 LM3697_CTRL_A_B_EN, 0);
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
> +static const struct i2c_device_id lm3697_id[] = {
> +	{ "lm3697", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, lm3697_id);
> +
> +static const struct of_device_id of_lm3697_leds_match[] = {
> +	{ .compatible = "ti,lm3697", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_lm3697_leds_match);
> +
> +static struct i2c_driver lm3697_driver = {
> +	.driver = {
> +		.name	= "lm3697",
> +		.of_match_table = of_lm3697_leds_match,
> +	},
> +	.probe		= lm3697_probe,
> +	.remove		= lm3697_remove,
> +	.id_table	= lm3697_id,
> +};
> +module_i2c_driver(lm3697_driver);
> +
> +MODULE_DESCRIPTION("Texas Instruments LM3697 LED driver");
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Best regards,
Jacek Anaszewski

Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D61C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4DD215EC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BMoKg8Lu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4DD215EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeI0SW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:22:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46354 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeI0SW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:22:59 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8RC4sXO105503;
        Thu, 27 Sep 2018 07:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538049894;
        bh=hoVtLQHqOQEELAktfPfLef5C6n7sG4q3XSwI03xkTEI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BMoKg8Lu9UvG6JYRCg2jJolp5eH3azTnPKFAZ2yVlbjw87TmIc70GngGZ22kJ0jyE
         +4k/f0F+QzjtZ19CrNb2daqYuM6rsrgXxoRJQ08SWNJrAYYii9uo+VpAxSN+vab4p3
         vfKKuCaDauiyAmSCfmEjDFUlJ8I00OomaLzmiPIE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8RC4sA8025926;
        Thu, 27 Sep 2018 07:04:54 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 27
 Sep 2018 07:04:53 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 27 Sep 2018 07:04:53 -0500
Received: from [172.22.134.40] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8RC4rPo027863;
        Thu, 27 Sep 2018 07:04:53 -0500
Subject: Re: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
To:     Pavel Machek <pavel@ucw.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lee.jones@linaro.org>, <linux-omap@vger.kernel.org>,
        <linux-leds@vger.kernel.org>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-8-dmurphy@ti.com> <20180926223612.GA32286@amd>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com>
Date:   Thu, 27 Sep 2018 07:04:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926223612.GA32286@amd>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

Thanks for the review

On 09/26/2018 05:36 PM, Pavel Machek wrote:
> Hi!
> 
>> Introduce the LED LM3633 driver.  This LED
>> driver has 9 total LED outputs with runtime
>> internal ramp configurations.
>>
>> Data sheet:
>> http://www.ti.com/lit/ds/symlink/lm3633.pdf
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> I did some editing... and this code looks very similar to 3697 code.
> 

Ok I will review each one.  Keep in mind these drivers are by no means complete
I anticipate this driver to look different then the 3697 code.

But I do expect a certain level of duplication of code as we see across all drivers.

>> diff --git a/drivers/leds/leds-lm3633.c b/drivers/leds/leds-lm3633.c
>> new file mode 100644
>> index 000000000000..3d29b0ed67d3
>> --- /dev/null
>> +++ b/drivers/leds/leds-lm3633.c
>> @@ -0,0 +1,430 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// TI LM3633 LED chip family driver
>> +// Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
>> +
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slab.h>
>> +#include <uapi/linux/uleds.h>
>> +
>> +#include "ti-lmu-led-common.h"
> 
> You might want to move includes to ti-lmu-led-common.h, so these are
> not repeated?
> 

Sounds good

>> +/**
>> + * struct lm3633 -
>> + * @enable_gpio - Hardware enable gpio
>> + * @regulator - LED supply regulator pointer
>> + * @client - Pointer to the I2C client
>> + * @regmap - Devices register map
>> + * @dev - Pointer to the devices device struct
>> + * @lock - Lock for reading/writing the device
>> + * @leds - Array of LED strings
>> + */
>> +struct lm3633 {
>> +	struct gpio_desc *enable_gpio;
>> +	struct regulator *regulator;
>> +	struct i2c_client *client;
>> +	struct regmap *regmap;
>> +	struct device *dev;
>> +	struct mutex lock;
>> +	struct lm3633_led leds[];
>> +};
> 
> Exactly same structure is used for 3697. Worth sharing?

But it is not the same structure for the 3632.  I anticipate this to change
as I debug the code and add pwm support.

> 
>> +static const struct regmap_config lm3633_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.max_register = LM3633_CTRL_ENABLE,
>> +	.reg_defaults = lm3633_reg_defs,
>> +	.num_reg_defaults = ARRAY_SIZE(lm3633_reg_defs),
>> +	.cache_type = REGCACHE_FLAT,
>> +};
> 
> Same regmap config. Maybe difficult to share.

Agreed.

> 
>> +static int lm3633_brightness_set(struct led_classdev *led_cdev,
>> +				enum led_brightness brt_val)
>> +{
>> +	struct lm3633_led *led = container_of(led_cdev, struct lm3633_led,
>> +					      led_dev);
>> +	int ctrl_en_val;
>> +	int ret;
>> +
>> +	mutex_lock(&led->priv->lock);
>> +
>> +	if (led->control_bank == LM3633_CONTROL_A) {
>> +		led->lmu_data.msb_brightness_reg = LM3633_CTRL_A_BRT_MSB;
>> +		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_A_BRT_LSB;
>> +		ctrl_en_val = LM3633_CTRL_A_EN;
>> +	} else {
>> +		led->lmu_data.msb_brightness_reg = LM3633_CTRL_B_BRT_MSB;
>> +		led->lmu_data.lsb_brightness_reg = LM3633_CTRL_B_BRT_LSB;
>> +		ctrl_en_val = LM3633_CTRL_B_EN;
>> +	}
>> +
>> +	if (brt_val == LED_OFF)
>> +		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
>> +					 ctrl_en_val, ~ctrl_en_val);
>> +	else
>> +		ret = regmap_update_bits(led->priv->regmap, LM3633_CTRL_ENABLE,
>> +					 ctrl_en_val, ctrl_en_val);
>> +
>> +	ret = ti_lmu_common_set_brightness(&led->lmu_data, brt_val);
>> +	if (ret)
>> +		dev_err(&led->priv->client->dev, "Cannot write brightness\n");
>> +
>> +	mutex_unlock(&led->priv->lock);
>> +	return ret;
>> +}
> 
> Duplicate of 3697 function with different constants.

This will change to support all the control banks.

> 
>> +static int lm3633_set_control_bank(struct lm3633 *priv)
>> +{
>> +	u8 control_bank_config = 0;
>> +	struct lm3633_led *led;
>> +	int ret, i;
>> +
>> +	led = &priv->leds[0];
>> +	if (led->control_bank == LM3633_CONTROL_A)
>> +		led = &priv->leds[1];
>> +
>> +	for (i = 0; i < LM3633_MAX_HVLED_STRINGS; i++)
>> +		if (led->hvled_strings[i] == LM3633_HVLED_ASSIGNMENT)
>> +			control_bank_config |= 1 << i;
>> +
>> +	ret = regmap_write(priv->regmap, LM3633_HVLED_OUTPUT_CONFIG,
>> +			   control_bank_config);
>> +	if (ret)
>> +		dev_err(&priv->client->dev, "Cannot write OUTPUT config\n");
>> +
>> +	return ret;
>> +}
> 
> Duplicate of 3697 function.

This will change to support all the control banks.

> 
>> +static int lm3633_init(struct lm3633 *priv)
>> +{
>> +	struct lm3633_led *led;
>> +	int i, ret;
>> +
>> +	if (priv->enable_gpio) {
>> +		gpiod_direction_output(priv->enable_gpio, 1);
>> +	} else {
>> +		ret = regmap_write(priv->regmap, LM3633_RESET, LM3633_SW_RESET);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "Cannot reset the device\n");
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, LM3633_CTRL_ENABLE, 0x0);
>> +	if (ret) {
>> +		dev_err(&priv->client->dev, "Cannot write ctrl enable\n");
>> +		goto out;
>> +	}
>> +
>> +	ret = lm3633_set_control_bank(priv);
>> +	if (ret)
>> +		dev_err(&priv->client->dev, "Setting the CRTL bank failed\n");
>> +
>> +	for (i = 0; i < LM3633_MAX_CONTROL_BANKS; i++) {
>> +		led = &priv->leds[i];
>> +		ti_lmu_common_set_ramp(&led->lmu_data);
>> +		if (ret)
>> +			dev_err(&priv->client->dev, "Setting the ramp rate failed\n");
>> +	}
>> +out:
>> +	return ret;
>> +}
> 
> Duplicate of 3697 function.


This will change to support all the control banks.

> 
>> +static int lm3633_probe_dt(struct lm3633 *priv)
>> +{
>> +	struct fwnode_handle *child = NULL;
>> +	struct lm3633_led *led;
>> +	const char *name;
>> +	int control_bank;
>> +	size_t i = 0;
>> +	int ret;
>> +
>> +	priv->enable_gpio = devm_gpiod_get_optional(&priv->client->dev,
>> +						   "enable", GPIOD_OUT_LOW);
>> +	if (IS_ERR(priv->enable_gpio)) {
>> +		ret = PTR_ERR(priv->enable_gpio);
>> +		dev_err(&priv->client->dev, "Failed to get enable gpio: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	priv->regulator = devm_regulator_get(&priv->client->dev, "vled");
>> +	if (IS_ERR(priv->regulator))
>> +		priv->regulator = NULL;
>> +
>> +	device_for_each_child_node(priv->dev, child) {
>> +		ret = fwnode_property_read_u32(child, "reg", &control_bank);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "reg property missing\n");
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		if (control_bank > LM3633_CONTROL_B) {
>> +			dev_err(&priv->client->dev, "reg property is invalid\n");
>> +			ret = -EINVAL;
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		led = &priv->leds[i];
>> +
>> +		led->control_bank = control_bank;
>> +		led->lmu_data.bank_id = control_bank;
>> +		led->lmu_data.enable_reg = LM3633_CTRL_ENABLE;
>> +		led->lmu_data.regmap = priv->regmap;
>> +		if (control_bank == LM3633_CONTROL_A)
>> +			led->lmu_data.runtime_ramp_reg = LM3633_CTRL_A_RAMP;
>> +		else
>> +			led->lmu_data.runtime_ramp_reg = LM3633_CTRL_B_RAMP;
>> +
>> +		if (control_bank <= LM3633_CONTROL_B)
>> +			ret = fwnode_property_read_u32_array(child, "led-sources",
>> +						    led->hvled_strings,
>> +						    LM3633_MAX_HVLED_STRINGS);
>> +		else
>> +			ret = fwnode_property_read_u32_array(child, "led-sources",
>> +						    led->lvled_strings,
>> +						    LM3633_MAX_LVLED_STRINGS);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "led-sources property missing\n");
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		ret = ti_lmu_common_get_ramp_params(&priv->client->dev, child, &led->lmu_data);
>> +		if (ret)
>> +			dev_warn(&priv->client->dev, "runtime-ramp properties missing\n");
>> +
>> +		fwnode_property_read_string(child, "linux,default-trigger",
>> +					    &led->led_dev.default_trigger);
>> +
>> +		ret = fwnode_property_read_string(child, "label", &name);
>> +		if (ret)
>> +			snprintf(led->label, sizeof(led->label),
>> +				"%s::", priv->client->name);
>> +		else
>> +			snprintf(led->label, sizeof(led->label),
>> +				 "%s:%s", priv->client->name, name);
>> +
>> +		led->priv = priv;
>> +		led->led_dev.name = led->label;
>> +		led->led_dev.brightness_set_blocking = lm3633_brightness_set;
>> +
>> +		ret = devm_led_classdev_register(priv->dev, &led->led_dev);
>> +		if (ret) {
>> +			dev_err(&priv->client->dev, "led register err: %d\n",
>> +				ret);
>> +			fwnode_handle_put(child);
>> +			goto child_out;
>> +		}
>> +
>> +		i++;
>> +	}
>> +
>> +child_out:
>> +	return ret;
>> +}
> 
> Very similar, but not quite same.

I know this function will definitely change to support the LVLED control bank setting.
The main difference here is that the HVLED has a simple control bank configuration and the
LVLED is highly configurable with multiple permutations.

As well as maybe the PWM support

> 
>> +static int lm3633_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct lm3633 *led;
>> +	int count;
>> +	int ret;
>> +
>> +	count = device_get_child_node_count(&client->dev);
>> +	if (!count) {
>> +		dev_err(&client->dev, "LEDs are not defined in device tree!");
>> +		return -ENODEV;
>> +	}
>> +
>> +	led = devm_kzalloc(&client->dev, struct_size(led, leds, count),
>> +			   GFP_KERNEL);
>> +	if (!led)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&led->lock);
>> +	i2c_set_clientdata(client, led);
>> +
>> +	led->client = client;
>> +	led->dev = &client->dev;
>> +	led->regmap = devm_regmap_init_i2c(client, &lm3633_regmap_config);
>> +	if (IS_ERR(led->regmap)) {
>> +		ret = PTR_ERR(led->regmap);
>> +		dev_err(&client->dev, "Failed to allocate register map: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = lm3633_probe_dt(led);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return lm3633_init(led);
>> +}
> 
> Duplicate.

I do expect the probes to be the same as in most cases.

> 
>> +static int lm3633_remove(struct i2c_client *client)
>> +{
>> +	struct lm3633 *led = i2c_get_clientdata(client);
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(led->regmap, LM3633_CTRL_ENABLE,
>> +				 LM3633_CTRL_A_B_EN, 0);
>> +	if (ret) {
>> +		dev_err(&led->client->dev, "Failed to disable the device\n");
>> +		return ret;
>> +	}
>> +
>> +	if (led->enable_gpio)
>> +		gpiod_direction_output(led->enable_gpio, 0);
>> +
>> +	if (led->regulator) {
>> +		ret = regulator_disable(led->regulator);
>> +		if (ret)
>> +			dev_err(&led->client->dev,
>> +				"Failed to disable regulator\n");
>> +	}
>> +
>> +	mutex_destroy(&led->lock);
>> +
>> +	return 0;
>> +}
> 
> Duplicate.
> 
> Can we get some more sharing? One way would be to have struct with
> all the constants (instead of #defines) use that...?

I will look at the adding common constants to but they should be common across
more then just 2 devices.  As you can see the LM3632 code is quite different
when you add in the flash/torch support.

I am trying to keep the common as light weight as possible and not add code that
cannot be used across multiple devices.

Dan

> 
> Thanks,
> 
> 									Pavel
> 


-- 
------------------
Dan Murphy

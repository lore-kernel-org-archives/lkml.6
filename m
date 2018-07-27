Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB2AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3990620842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 20:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oof0k3C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3990620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbeG0Vb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:31:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52428 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389206AbeG0Vb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:31:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so6418676wmh.2;
        Fri, 27 Jul 2018 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ViFzqoxvIPsN7CPUBjc57gNTpcDb276iFtS6WCBZDdM=;
        b=Oof0k3C4UTnk/y4CufQ9dM/8V/SXt3Qd+Z6S/98afF/t8V9lDd82D8/XPtslf/EE4y
         azOhIRKdkHnQu5/zxLNVvi7FyRUsLTlp9JbstHSSqOgLO3JToD9AfFPVbXOMzqVz9tZz
         tVmZlYHg1TXWn0PH+dnn3pLpSvzKenpkepUm3cuck8J4oSTOtrFEH4H608sixxvCkQv9
         yiqlgZ9sX8qHCkG6k3a+0p/MzROF10Ja5O9h7y+VGC2ggUwAnXxuWXsm35wtkFPmN4Hq
         gkt9Ifont+h2qX1CF4jOwbwrkhN9PM1zGZSr9Uvxrjx0VLkJLMi9Of64ogjEj5LbQSKu
         byeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ViFzqoxvIPsN7CPUBjc57gNTpcDb276iFtS6WCBZDdM=;
        b=J07oI+VKwTpDV2A9qXQ8fBtIpZ/cintdmqI/B+CZypGsBTsXg36lUyDkZDlxTJU2lR
         NsR+CMnGhy8RuEqKEzC3CSXEofXNiLJMaizkMyYya9Vt93WiXUsME53PVgYu091JgMbC
         BQmTRBKsBwhYbEJQ1UNChnUdHnWswWFWB+4Bh9cNAfi4mm9nBNPVSVlMs+cxsHZ6TIRp
         1BWU3A9PAqeOxNlKIfNX/zjV/tXkeeo9e1R9LHg/sxObegSiwjoK7B+HrW3j+Z8ZHPIX
         cYi9DO7JBYPrYqVGGZwmjUJXe5ccvjo18kK2tFszEuLwScQCtg9g5K9HpyPRTOXrLBTe
         C8Ew==
X-Gm-Message-State: AOUpUlFc/Wn3a7l2yQ3YGXF6Lq1rYNR4J3aLaUs1wbyk5j4rTlpgnJg9
        Ev/xfQAG2gfPSPOgbbzS/cfSvz7i
X-Google-Smtp-Source: AAOMgpckzT9D486T8wQllA7MPNIlmzp34dq8DxZ+uAKUjvF5yYByHON9yyoqrbgj7s8wkDvOt2R/Kg==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr5931371wmt.31.1532722107075;
        Fri, 27 Jul 2018 13:08:27 -0700 (PDT)
Received: from [192.168.1.18] (dku38.neoplus.adsl.tpnet.pl. [83.24.24.38])
        by smtp.gmail.com with ESMTPSA id g17-v6sm4520374wmh.19.2018.07.27.13.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 13:08:26 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] leds: add Panasonic AN30259A support
To:     Simon Shields <simon@lineageos.org>, linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180721141228.2283-1-simon@lineageos.org>
 <20180721141228.2283-3-simon@lineageos.org>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <ba747c6d-c8a6-438b-efcf-95e24db0a09c@gmail.com>
Date:   Fri, 27 Jul 2018 22:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180721141228.2283-3-simon@lineageos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Thank you for the updated patch. It looks good in general, with
one reservation, please refer below.

On 07/21/2018 04:12 PM, Simon Shields wrote:
> AN30259A is a 3-channel LED driver which uses I2C. It supports timed
> operation via an internal PWM clock, and variable brightness. This
> driver offers support for basic hardware-based blinking and brightness
> control.
> 
> The datasheet is freely available:
> https://www.alliedelec.com/m/d/a9d2b3ee87c2d1a535a41dd747b1c247.pdf
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> ---
>   drivers/leds/Kconfig         |  11 ++
>   drivers/leds/Makefile        |   1 +
>   drivers/leds/leds-an30259a.c | 365 +++++++++++++++++++++++++++++++++++
>   3 files changed, 377 insertions(+)
>   create mode 100644 drivers/leds/leds-an30259a.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 6e3a998f3370..1567882fd039 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -57,6 +57,17 @@ config LEDS_AAT1290
>   	depends on PINCTRL
>   	help
>   	 This option enables support for the LEDs on the AAT1290.
> +
> +config LEDS_AN30259A
> +	tristate "LED support for Panasonic AN30259A"
> +	depends on LEDS_CLASS && I2C && OF
> +	help
> +	  This option enables support for the AN30259A 3-channel
> +	  LED driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-an30259a.
> +
>   config LEDS_APU
>   	tristate "Front panel LED support for PC Engines APU/APU2 boards"
>   	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 420b5d2cfa62..4c1b0054f379 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_LEDS_88PM860X)		+= leds-88pm860x.o
>   obj-$(CONFIG_LEDS_AAT1290)		+= leds-aat1290.o
>   obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
>   obj-$(CONFIG_LEDS_AS3645A)		+= leds-as3645a.o
> +obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
>   obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
>   obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
>   obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
> diff --git a/drivers/leds/leds-an30259a.c b/drivers/leds/leds-an30259a.c
> new file mode 100644
> index 000000000000..c7b900b388ac
> --- /dev/null
> +++ b/drivers/leds/leds-an30259a.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Driver for Panasonic AN30259A 3-channel LED driver
> +//
> +// Copyright (c) 2018 Simon Shields <simon@lineageos.org>
> +//
> +// Datasheet:
> +// https://www.alliedelec.com/m/d/a9d2b3ee87c2d1a535a41dd747b1c247.pdf
> +
> +#include <linux/i2c.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <uapi/linux/uleds.h>
> +
> +#define MAX_LEDS 3
> +
> +#define REG_SRESET 0x00
> +#define LED_SRESET BIT(0)
> +
> +/* LED power registers */
> +#define REG_LED_ON 0x01
> +#define LED_EN(x) BIT((x) - 1)
> +#define LED_SLOPE(x) BIT(((x) - 1) + 4)
> +
> +#define REG_LEDCC(x) (0x03 + ((x) - 1))
> +
> +/* slope control registers */
> +#define REG_SLOPE(x) (0x06 + ((x) - 1))
> +#define LED_SLOPETIME1(x) (x)
> +#define LED_SLOPETIME2(x) ((x) << 4)
> +
> +#define REG_LEDCNT1(x) (0x09 + (4 * ((x) - 1)))
> +#define LED_DUTYMAX(x) ((x) << 4)
> +#define LED_DUTYMID(x) (x)
> +
> +#define REG_LEDCNT2(x) (0x0A + (4 * ((x) - 1)))
> +#define LED_DELAY(x) ((x) << 4)
> +#define LED_DUTYMIN(x) (x)
> +
> +/* detention time control (length of each slope step) */
> +#define REG_LEDCNT3(x) (0x0B + (4 * ((x) - 1)))
> +#define LED_DT1(x) (x)
> +#define LED_DT2(x) ((x) << 4)
> +
> +#define REG_LEDCNT4(x) (0x0C + (4 * ((x) - 1)))
> +#define LED_DT3(x) (x)
> +#define LED_DT4(x) ((x) << 4)
> +
> +#define REG_MAX 0x14
> +
> +#define BLINK_MAX_TIME 7500 /* ms */
> +#define SLOPE_RESOLUTION 500 /* ms */
> +
> +#define STATE_OFF 0
> +#define STATE_KEEP 1
> +#define STATE_ON 2

Please add AN30259A_ namespacing prefix to all the above macro
definitions.

> +
> +struct an30259a;
> +
> +struct an30259a_led {
> +	struct an30259a *chip;
> +	struct led_classdev cdev;
> +	u32 num;
> +	u32 default_state;
> +	bool sloping;
> +	char label[LED_MAX_NAME_SIZE];
> +};
> +
> +struct an30259a {
> +	struct mutex mutex; /* held when writing to registers */
> +	struct i2c_client *client;
> +	struct an30259a_led leds[MAX_LEDS];
> +	struct regmap *regmap;
> +	int num_leds;
> +};
> +
> +static int an30259a_brightness_set(struct led_classdev *cdev,
> +				   enum led_brightness brightness)
> +{
> +	struct an30259a_led *led;
> +	int ret;
> +	unsigned int led_on;
> +
> +	led = container_of(cdev, struct an30259a_led, cdev);
> +	mutex_lock(&led->chip->mutex);
> +
> +	ret = regmap_read(led->chip->regmap, REG_LED_ON, &led_on);
> +	if (ret)
> +		goto error;
> +
> +	switch (brightness) {
> +	case LED_OFF:
> +		led_on &= ~LED_EN(led->num);
> +		led_on &= ~LED_SLOPE(led->num);
> +		led->sloping = false;
> +		break;
> +	default:
> +		led_on |= LED_EN(led->num);
> +		if (led->sloping)
> +			led_on |= LED_SLOPE(led->num);
> +		ret = regmap_write(led->chip->regmap, REG_LEDCNT1(led->num),
> +				   LED_DUTYMAX(0xf) | LED_DUTYMID(0xf));
> +		if (ret)
> +			goto error;
> +		break;
> +	}
> +
> +	ret = regmap_write(led->chip->regmap, REG_LED_ON, led_on);
> +	if (ret)
> +		goto error;
> +
> +	ret = regmap_write(led->chip->regmap, REG_LEDCC(led->num),
> +			   brightness);
> +
> +error:
> +	mutex_unlock(&led->chip->mutex);
> +
> +	return ret;
> +}
> +
> +static int an30259a_blink_set(struct led_classdev *cdev,
> +			      unsigned long *delay_off, unsigned long *delay_on)
> +{
> +	struct an30259a_led *led;
> +	int ret, num;
> +	unsigned int led_on, duty;
> +	unsigned long off = *delay_off, on = *delay_on;
> +
> +	led = container_of(cdev, struct an30259a_led, cdev);
> +
> +	mutex_lock(&led->chip->mutex);
> +	num = led->num;
> +
> +	/* slope time can only be a multiple of 500ms. */
> +	if (off % SLOPE_RESOLUTION || on % SLOPE_RESOLUTION) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	/* up to a maximum of 7500ms. */
> +	if (off > BLINK_MAX_TIME || on > BLINK_MAX_TIME) {
> +		ret = -EINVAL;
> +		goto error;
> +	}
> +
> +	/* if no blink specified, default to 1 Hz. */
> +	if (!off && !on) {
> +		*delay_off = off = 500;
> +		*delay_on = on = 500;
> +	}
> +
> +	/* convert into values the HW will understand. */
> +	off /= SLOPE_RESOLUTION;
> +	on /= SLOPE_RESOLUTION;
> +
> +	/* duty min should be zero (=off), delay should be zero. */
> +	ret = regmap_write(led->chip->regmap, REG_LEDCNT2(num),
> +			   LED_DELAY(0) | LED_DUTYMIN(0));
> +	if (ret)
> +		goto error;
> +
> +	/* reset detention time (no "breathing" effect). */
> +	ret = regmap_write(led->chip->regmap, REG_LEDCNT3(num),
> +			   LED_DT1(0) | LED_DT2(0));
> +	if (ret)
> +		goto error;
> +	ret = regmap_write(led->chip->regmap, REG_LEDCNT4(num),
> +			   LED_DT3(0) | LED_DT4(0));
> +	if (ret)
> +		goto error;
> +
> +	/* slope time controls on/off cycle length. */
> +	ret = regmap_write(led->chip->regmap, REG_SLOPE(num),
> +			   LED_SLOPETIME1(off) | LED_SLOPETIME2(on));
> +	if (ret)
> +		goto error;
> +
> +	/* Finally, enable slope mode. */
> +	ret = regmap_read(led->chip->regmap, REG_LED_ON, &led_on);
> +	if (ret)
> +		goto error;
> +
> +	led_on |= LED_SLOPE(num) | LED_EN(led->num);
> +
> +	ret = regmap_write(led->chip->regmap, REG_LED_ON, led_on);
> +
> +	if (!ret)
> +		led->sloping = true;
> +error:
> +	mutex_unlock(&led->chip->mutex);
> +
> +	return ret;
> +}
> +
> +static int an30259a_dt_init(struct i2c_client *client,
> +			    struct an30259a *chip)
> +{
> +	struct device_node *np = client->dev.of_node, *child;
> +	int count, ret;
> +	int i = 0;
> +	const char *str;
> +	struct an30259a_led *led;
> +
> +	count = of_get_child_count(np);
> +	if (!count || count > MAX_LEDS)
> +		return -EINVAL;
> +
> +	for_each_available_child_of_node(np, child) {
> +		u32 source;
> +
> +		ret = of_property_read_u32(child, "reg", &source);
> +		if (ret != 0 || !source || source > MAX_LEDS) {
> +			dev_err(&client->dev, "Couldn't read LED address: %d\n",
> +				ret);
> +			count--;
> +			continue;
> +		}
> +
> +		led = &chip->leds[i];
> +
> +		led->num = source;
> +		led->chip = chip;
> +
> +		if (of_property_read_string(child, "label", &str))
> +			snprintf(led->label, sizeof(led->label), "an30259a::");
> +		else
> +			snprintf(led->label, sizeof(led->label), "an30259a:%s",
> +				 str);
> +
> +		led->cdev.name = led->label;
> +
> +		if (!of_property_read_string(child, "default-state", &str)) {
> +			if (!strcmp(str, "on"))
> +				led->default_state = STATE_ON;
> +			else if (!strcmp(str, "keep"))
> +				led->default_state = STATE_KEEP;
> +			else
> +				led->default_state = STATE_OFF;
> +		}
> +
> +		of_property_read_string(child, "linux,default-trigger",
> +					&led->cdev.default_trigger);
> +
> +		i++;
> +	}
> +
> +	if (!count)
> +		return -EINVAL;
> +
> +	chip->num_leds = i;
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config an30259a_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = REG_MAX,
> +};
> +
> +static void an30259a_init_default_state(struct an30259a_led *led)
> +{
> +	struct an30259a *chip = led->chip;
> +	int led_on, err;
> +
> +	switch (led->default_state) {
> +	case STATE_ON:
> +		led->cdev.brightness = LED_FULL;
> +		break;
> +	case STATE_KEEP:
> +		err = regmap_read(chip->regmap, REG_LED_ON, &led_on);
> +		if (err)
> +			break;
> +
> +		if (!(led_on & LED_EN(led->num))) {
> +			led->cdev.brightness = LED_OFF;
> +			break;
> +		}
> +		regmap_read(chip->regmap, REG_LEDCC(led->num),
> +			    &led->cdev.brightness);
> +		break;
> +	default:
> +		led->cdev.brightness = LED_OFF;
> +	}
> +
> +	an30259a_brightness_set(&led->cdev, led->cdev.brightness);
> +}
> +
> +static int an30259a_probe(struct i2c_client *client)
> +{
> +	struct an30259a *chip;
> +	int i, err;
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	err = an30259a_dt_init(client, chip);
> +	if (err < 0)
> +		return err;
> +
> +	mutex_init(&chip->mutex);
> +	chip->client = client;
> +	i2c_set_clientdata(client, chip);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &an30259a_regmap_config);
> +
> +	for (i = 0; i < chip->num_leds; i++) {
> +		an30259a_init_default_state(&chip->leds[i]);
> +		chip->leds[i].cdev.brightness_set_blocking =
> +			an30259a_brightness_set;
> +		chip->leds[i].cdev.blink_set = an30259a_blink_set;
> +
> +		err = devm_led_classdev_register(&client->dev,
> +						 &chip->leds[i].cdev);
> +		if (err < 0)
> +			goto exit;
> +	}
> +	return 0;
> +
> +exit:
> +	mutex_destroy(&chip->mutex);
> +	return err;
> +}
> +
> +static int an30259a_remove(struct i2c_client *client)
> +{
> +	struct an30259a *chip = i2c_get_clientdata(client);
> +
> +	mutex_destroy(&chip->mutex);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id an30259a_match_table[] = {
> +	{ .compatible = "panasonic,an30259a", },
> +	{ /* sentinel */ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, an30259a_match_table);
> +
> +static const struct i2c_device_id an30259a_id[] = {
> +	{ "an30259a", 0 },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i2c, an30259a_id);
> +
> +static struct i2c_driver an30259a_driver = {
> +	.driver = {
> +		.name = "leds-an32059a",
> +		.of_match_table = of_match_ptr(an30259a_match_table),
> +	},
> +	.probe_new = an30259a_probe,
> +	.remove = an30259a_remove,
> +	.id_table = an30259a_id,
> +};
> +
> +module_i2c_driver(an30259a_driver);
> +
> +MODULE_AUTHOR("Simon Shields <simon@lineageos.org>");
> +MODULE_DESCRIPTION("AN32059A LED driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 
Best regards,
Jacek Anaszewski

Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFA1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE6C20647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCsv+x7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE6C20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbeGTS5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:57:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45957 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbeGTS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:57:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id t13-v6so2649774wrv.12;
        Fri, 20 Jul 2018 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZhWX1BkKqNkXFoUyR2pIYpaendnDFyAPNROyd0t9OZ8=;
        b=mCsv+x7ooGtw7V4U8kS9z4jJvmIFQxfiG15HHlEZbIGO665nC9nKnX7pXMHQabn6rr
         eU4J74395ody5MFZ7TMMjabEuyvkN0eDR4+lefB5xyLvLZ4zdlrRmJz+0765rZ1NoY1/
         gAdJSZqXWyHWKvqKwbuOWtrwIWF2nuTmMrREbrBIMRCN+tPYmkHo9JXv9oFWC9iFbpn3
         Y1sdLfq2L6vAVxFK1m11IMpAveIfYRFDssKFjEEnbJu/3widZfNUiFVVrE7E+9w3Y05g
         odfRDyiF/DOfBjbq7k8Z0FPRATFoL0ieYG7IxLT9hYoZ0G7SBM13ZwSFONzVVzFG9qbp
         yoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZhWX1BkKqNkXFoUyR2pIYpaendnDFyAPNROyd0t9OZ8=;
        b=jt4jHWU7/xDukrgZk4QJkQii0Spzfrg7U+sxrvplQdJZq5Emgr4WFh57py1GnJAXkb
         QnF3bgFImcSaJU9nRrHkxnZB8M4oDmOPDHXdfuGQTds0uQnxUyWViiqSsX4azZUOwDd+
         EZ7KbiTTg9xNYrMzakbWGTLoy2A3edao88cVkkbiDUoTpbeqrFIrYs9zVSGIY98PB4ie
         Ext61c4aGEuaRk0FR7PXbU+D3MTCb92KRvBMAftI4nxvv8ep2UpkFHmMdIVdJB7UohJ9
         ThN3jJv/DSKnLjkYSQODapAOmkShMjMEsUfY0D1MEgWLeGr631O8ODs9DmihZS0wpSGH
         9EvQ==
X-Gm-Message-State: AOUpUlGJJXqimzU+xVTV2Q4u++/+i4eN+VR3WsEtnF7she96wPPs3PXV
        QXCeWVkUDM+nyP6Gn8oZYH93tTk5
X-Google-Smtp-Source: AAOMgpdvWBrZUGsDADMCU0sUa4poUw1/dl1yeikFraSHpXyS5YNejar7SgsrAr8pTHV1weXDCNJzgg==
X-Received: by 2002:adf:b69c:: with SMTP id j28-v6mr2250954wre.200.1532110106094;
        Fri, 20 Jul 2018 11:08:26 -0700 (PDT)
Received: from [192.168.1.18] (chg252.neoplus.adsl.tpnet.pl. [83.31.4.252])
        by smtp.gmail.com with ESMTPSA id 2-v6sm3117783wmi.17.2018.07.20.11.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 11:08:25 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     David Lechner <david@lechnology.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <00fa2693-9308-8d74-0124-04066a76c35a@gmail.com>
 <20180714222924.GA2776@amd> <20180714223907.GB2776@amd>
 <1138f834-e805-6076-bb5b-aa1fdc1f2606@gmail.com>
 <2c3a8911-150a-9b25-2a66-a9432047f96b@lechnology.com>
 <68996338-a902-2b57-0bb9-df274a496b06@gmail.com> <20180718075637.GA10279@amd>
 <913151e4-c19f-9a22-697c-52a9fb48cb32@gmail.com>
 <0e0cd8f7-dc73-6733-65f2-9a14506b0f0e@gmail.com> <20180718221717.GA5451@amd>
 <20180719202005.GA7763@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8a4e4a8f-1fb0-0af2-a397-82bb1bb462bc@gmail.com>
Date:   Fri, 20 Jul 2018 20:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180719202005.GA7763@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 07/19/2018 10:20 PM, Pavel Machek wrote:
> Hi!
> 
>>>> Please keep in mind that this is ABI documentation for the pattern file
>>>> to be exposed by LED core, and not by the pattern trigger, that, as we
>>>> agreed, will be implemented later. In this case, I'd go for
>>>
>>> Gosh, I got completely distracted by the recent discussion about
>>> pattern synchronization.
>>>
>>> So, to recap, we need to decide if we are taking Baolin's solution
>>> or we're opting for implementing pattern trigger.
>>>
>>> If we choose the latter, then we will also need some software
>>> pattern engine in the trigger, to be applied as a software pattern
>>> fallback for the devices without hardware pattern support.
>>> It will certainly delay the contribution process, provided that Baolin
>>> would find time for this work at all.
>>
>> I'd recommend the latter. Yes, software pattern as a fallback would be
>> nice, but I have that code already... let me get it back to running
>> state, and figure out where to add interface for "hardware
>> acceleration". I'd like to have same interface to userland, whether
>> pattern can be done by hardware or by software.
> 
> For the record, I'd like something like this. (Software pattern should
> work. Hardware pattern... needs more work).

Thank you for the patch. I'll be able to comment on it in two weeks.
I'll be offline during that time.

Best regards,
Jacek Anaszewski

> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index ede4fa0..8cf5962 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -51,6 +51,8 @@ static void led_timer_function(struct timer_list *t)
>   	unsigned long brightness;
>   	unsigned long delay;
>   
> +	/* FIXME spin_lock(led_cdev->lock); protecting led_cdev->flags? */
> +
>   	if (!led_cdev->blink_delay_on || !led_cdev->blink_delay_off) {
>   		led_set_brightness_nosleep(led_cdev, LED_OFF);
>   		clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
> diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
> index 9d9b7aa..898f92d 100644
> --- a/drivers/leds/leds-sc27xx-bltc.c
> +++ b/drivers/leds/leds-sc27xx-bltc.c
> @@ -6,6 +6,7 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
> +#include <linux/slab.h>
>   #include <uapi/linux/uleds.h>
>   
>   /* PMIC global control register definition */
> @@ -32,8 +33,13 @@
>   #define SC27XX_DUTY_MASK	GENMASK(15, 0)
>   #define SC27XX_MOD_MASK		GENMASK(7, 0)
>   
> +#define SC27XX_CURVE_SHIFT	8
> +#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
> +#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
> +
>   #define SC27XX_LEDS_OFFSET	0x10
>   #define SC27XX_LEDS_MAX		3
> +#define SC27XX_LEDS_PATTERN_CNT	4
>   
>   struct sc27xx_led {
>   	char name[LED_MAX_NAME_SIZE];
> @@ -122,6 +128,157 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
>   	return err;
>   }
>   
> +static int sc27xx_led_pattern_clear(struct led_classdev *ldev)
> +{
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	struct regmap *regmap = leds->priv->regmap;
> +	u32 base = sc27xx_led_get_offset(leds);
> +	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
> +	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
> +	int err;
> +
> +	mutex_lock(&leds->priv->lock);
> +
> +	/* Reset the rise, high, fall and low time to zero. */
> +	regmap_write(regmap, base + SC27XX_LEDS_CURVE0, 0);
> +	regmap_write(regmap, base + SC27XX_LEDS_CURVE1, 0);
> +
> +	err = regmap_update_bits(regmap, ctrl_base,
> +			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
> +
> +	mutex_unlock(&leds->priv->lock);
> +
> +	return err;
> +}
> +
> +static int sc27xx_led_pattern_set(struct led_classdev *ldev,
> +				  struct led_pattern *pattern,
> +				  int len)
> +{
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	u32 base = sc27xx_led_get_offset(leds);
> +	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
> +	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
> +	struct regmap *regmap = leds->priv->regmap;
> +	int err;
> +
> +	/*
> +	 * Must contain 4 patterns to configure the rise time, high time, fall
> +	 * time and low time to enable the breathing mode.
> +	 */
> +	if (len != SC27XX_LEDS_PATTERN_CNT)
> +		return -EINVAL;
> +
> +	mutex_lock(&leds->priv->lock);
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +				 SC27XX_CURVE_L_MASK, pattern[0].delta_t);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +				 SC27XX_CURVE_L_MASK, pattern[1].delta_t);
> +	if (err)
> +		goto out;
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
> +				 SC27XX_CURVE_H_MASK,
> +				 pattern[2].delta_t << SC27XX_CURVE_SHIFT);
> +	if (err)
> +		goto out;
> +
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
> +				 SC27XX_CURVE_H_MASK,
> +				 pattern[3].delta_t << SC27XX_CURVE_SHIFT);
> +	if (err)
> +		goto out;
> +
> +
> +	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
> +				 SC27XX_DUTY_MASK,
> +				 (pattern[0].brightness << SC27XX_DUTY_SHIFT) |
> +				 SC27XX_MOD_MASK);
> +	if (err)
> +		goto out;
> +
> +	/* Enable the LED breathing mode */
> +	err = regmap_update_bits(regmap, ctrl_base,
> +				 SC27XX_LED_RUN << ctrl_shift,
> +				 SC27XX_LED_RUN << ctrl_shift);
> +
> +out:
> +	mutex_unlock(&leds->priv->lock);
> +
> +	return err;
> +}
> +
> +static struct led_pattern *sc27xx_led_pattern_get(struct led_classdev *ldev,
> +						  int *len)
> +{
> +	struct sc27xx_led *leds = to_sc27xx_led(ldev);
> +	u32 base = sc27xx_led_get_offset(leds);
> +	struct regmap *regmap = leds->priv->regmap;
> +	struct led_pattern *pattern;
> +	int i, err;
> +	u32 val;
> +
> +	/*
> +	 * Must allocate 4 patterns to show the rise time, high time, fall time
> +	 * and low time.
> +	 */
> +	pattern = kcalloc(SC27XX_LEDS_PATTERN_CNT, sizeof(*pattern),
> +			  GFP_KERNEL);
> +	if (!pattern)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&leds->priv->lock);
> +
> +	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE0, &val);
> +	if (err)
> +		goto out;
> +
> +	pattern[0].delta_t = val & SC27XX_CURVE_L_MASK;
> +
> +	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE1, &val);
> +	if (err)
> +		goto out;
> +
> +	pattern[1].delta_t = val & SC27XX_CURVE_L_MASK;
> +
> +	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE0, &val);
> +	if (err)
> +		goto out;
> +
> +	pattern[2].delta_t = (val & SC27XX_CURVE_H_MASK) >> SC27XX_CURVE_SHIFT;
> +
> +	err = regmap_read(regmap, base + SC27XX_LEDS_CURVE1, &val);
> +	if (err)
> +		goto out;
> +
> +	pattern[3].delta_t = (val & SC27XX_CURVE_H_MASK) >> SC27XX_CURVE_SHIFT;
> +
> +	err = regmap_read(regmap, base + SC27XX_LEDS_DUTY, &val);
> +	if (err)
> +		goto out;
> +
> +	mutex_unlock(&leds->priv->lock);
> +
> +	val = (val & SC27XX_DUTY_MASK) >> SC27XX_DUTY_SHIFT;
> +	for (i = 0; i < SC27XX_LEDS_PATTERN_CNT; i++)
> +		pattern[i].brightness = val;
> +
> +	*len = SC27XX_LEDS_PATTERN_CNT;
> +
> +	return pattern;
> +
> +out:
> +	mutex_unlock(&leds->priv->lock);
> +	kfree(pattern);
> +
> +	return ERR_PTR(err);
> +}
> +
>   static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
>   {
>   	int i, err;
> @@ -140,6 +297,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
>   		led->priv = priv;
>   		led->ldev.name = led->name;
>   		led->ldev.brightness_set_blocking = sc27xx_led_set;
> +		led->ldev.pattern_set = sc27xx_led_pattern_set;
> +		led->ldev.pattern_get = sc27xx_led_pattern_get;
> +		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
>   
>   		err = devm_led_classdev_register(dev, &led->ldev);
>   		if (err)
> diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
> index a2559b4..91ae5b0 100644
> --- a/drivers/leds/trigger/Kconfig
> +++ b/drivers/leds/trigger/Kconfig
> @@ -125,6 +125,16 @@ config LEDS_TRIGGER_CAMERA
>   	  This enables direct flash/torch on/off by the driver, kernel space.
>   	  If unsure, say Y.
>   
> +config LEDS_TRIGGER_PATTERN
> +	tristate "LED Pattern Trigger"
> +	depends on LEDS_TRIGGERS
> +	help
> +	  This allows LEDs blinking with an arbitrary pattern. Can be useful
> +	  on embedded systems with no screen to give out a status code to
> +	  a human.
> +
> +	  If unsure, say N
> +
>   config LEDS_TRIGGER_PANIC
>   	bool "LED Panic Trigger"
>   	depends on LEDS_TRIGGERS
> diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
> index f3cfe19..ba6f3b9 100644
> --- a/drivers/leds/trigger/Makefile
> +++ b/drivers/leds/trigger/Makefile
> @@ -11,5 +11,6 @@ obj-$(CONFIG_LEDS_TRIGGER_ACTIVITY)	+= ledtrig-activity.o
>   obj-$(CONFIG_LEDS_TRIGGER_DEFAULT_ON)	+= ledtrig-default-on.o
>   obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+= ledtrig-transient.o
>   obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+= ledtrig-camera.o
> +obj-$(CONFIG_LEDS_TRIGGER_PATTERN)	+= ledtrig-pattern.o
>   obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+= ledtrig-panic.o
>   obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> new file mode 100644
> index 0000000..d31808d
> --- /dev/null
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -0,0 +1,400 @@
> +/*
> + * Arbitrary pattern trigger
> + *
> + * Copyright 2015, Epsiline
> + *
> + * Author : Raphaël Teysseyre <rteysseyre@gmail.com>
> + *
> + * Idea discussed with Pavel Machek <pavel@ucw.cz> on
> + * <linux-leds@vger.kernel.org> (march 2015, thread title
> + * [PATCH RFC] leds: Add status code trigger)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/timer.h>
> +#include "../leds.h"
> +
> +struct pattern_step {
> +	int brightness;
> +	int time_ms;
> +};
> +
> +struct pattern_trig_data {
> +	struct led_classdev *led_cdev;
> +
> +	struct pattern_step *steps; /* Array describing the pattern */
> +	struct mutex lock;
> +	char is_sane;
> +	struct pattern_step *curr;
> +	struct pattern_step *next;
> +	int time_ms; /* Time in current step */
> +	int nsteps;  /* Number of steps */
> +	int repeat;  /* < 0 means repeat indefinitely */
> +	struct timer_list timer;
> +};
> +
> +#define MAX_NSTEPS (PAGE_SIZE/4)
> +/* The "pattern" attribute contains at most PAGE_SIZE characters.
> +   Each line in this attribute is at least 4 characters long
> +   (a 1-digit number for the led brighntess, a space,
> +   a 1-digit number for the time, a semi-colon).
> +   Therefore, there is at most PAGE_SIZE/4 steps. */
> +
> +#define UPDATE_INTERVAL 50
> +/* When doing gradual dimming, the led brightness
> +   will be updated every UPDATE_INTERVAL milliseconds */
> +
> +#define PATTERN_SEPARATOR ","
> +
> +static int pattern_trig_initialize_data(struct pattern_trig_data *data)
> +{
> +	mutex_init(&data->lock);
> +	mutex_lock(&data->lock);
> +
> +	data->is_sane = 0;
> +	data->steps = kzalloc(MAX_NSTEPS*sizeof(struct pattern_step),
> +			GFP_KERNEL);
> +	if (!data->steps)
> +		return -ENOMEM;
> +
> +	data->curr = NULL;
> +	data->next = NULL;
> +	data->time_ms = 0;
> +	data->nsteps = 0;
> +	data->repeat = -1;
> +	//data->timer = __TIMER_INITIALIZER(NULL, 0);
> +
> +	mutex_unlock(&data->lock);
> +	return 0;
> +}
> +
> +static void pattern_trig_clear_data(struct pattern_trig_data *data)
> +{
> +	data->is_sane = 0;
> +	kfree(data->steps);
> +}
> +
> +/*
> + *  is_sane : pattern checking.
> + *  A pattern satisfying these three conditions is reported as sane :
> + *    - At least two steps
> + *    - At least one step with time >= UPDATE_INTERVAL
> + *    - At least two steps with differing brightnesses
> + *  When @data isn't sane, a sensible brightness
> + *  default is suggested in @brightness
> + *
> + * DO NOT call pattern_trig_update on a not-sane pattern,
> + * you'll be punished with an infinite loop in the kernel.
> + */
> +static int is_sane(struct pattern_trig_data *data, int *brightness)
> +{
> +	int i;
> +	char stept_ok = 0;
> +	char stepb_ok = 0;
> +
> +	*brightness = 0;
> +	if (data->nsteps < 1)
> +		return 0;
> +
> +	*brightness = data->steps[0].brightness;
> +	if (data->nsteps < 2)
> +		return 0;
> +
> +	for (i = 0; i < data->nsteps; i++) {
> +		if (data->steps[i].time_ms >= UPDATE_INTERVAL) {
> +			/* FIXME: this is wrong */
> +			if (stepb_ok)
> +				return 1;
> +			stept_ok = 1;
> +		}
> +		if (data->steps[i].brightness != data->steps[0].brightness) {
> +			if (stept_ok)
> +				return 1;
> +			stepb_ok = 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void reset_pattern(struct pattern_trig_data *data,
> +			struct led_classdev *led_cdev)
> +{
> +	int brightness;
> +
> +	if (led_cdev->pattern_clear) {
> +		led_cdev->pattern_clear(led_cdev);
> +	}
> +
> +	del_timer_sync(&data->timer);
> +
> +	if (led_cdev->pattern_set && led_cdev->pattern_set(led_cdev, data->steps, data->nsteps)) {
> +		return;
> +	}
> +		
> +	if (!is_sane(data, &brightness)) {
> +		led_set_brightness(led_cdev, brightness);
> +		return;
> +	}
> +
> +	data->curr = data->steps;
> +	data->next = data->steps + 1;
> +	data->time_ms = 0;
> +	data->is_sane = 1;
> +
> +	data->timer.expires = jiffies;
> +	add_timer(&data->timer);
> +}
> +
> +/* --- Sysfs handling --- */
> +
> +static ssize_t pattern_trig_show_repeat(
> +	struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", data->repeat);
> +}
> +
> +static ssize_t pattern_trig_store_repeat(
> +	struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	long res;
> +	int err;
> +
> +	err = kstrtol(buf, 10, &res);
> +	if (err)
> +		return err;
> +
> +	data->repeat = res < 0 ? -1 : res;
> +	reset_pattern(data, led_cdev);
> +
> +	return count;
> +}
> +
> +DEVICE_ATTR(repeat, S_IRUGO | S_IWUSR,
> +	pattern_trig_show_repeat, pattern_trig_store_repeat);
> +
> +static ssize_t pattern_trig_show_pattern(
> +	struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	ssize_t count = 0;
> +	int i;
> +
> +	if (!data->steps || !data->nsteps)
> +		return 0;
> +
> +	for (i = 0; i < data->nsteps; i++)
> +		count += scnprintf(buf + count, PAGE_SIZE - count,
> +				"%d %d" PATTERN_SEPARATOR,
> +				data->steps[i].brightness,
> +				data->steps[i].time_ms);
> +	buf[count - 1] = '\n';
> +	buf[count] = '\0';
> +
> +	return count + 1;
> +}
> +
> +static ssize_t pattern_trig_store_pattern(
> +	struct device *dev, struct device_attribute *attr,
> +	const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +	int cr = 0; /* Characters read on one conversion */
> +	int tcr = 0; /* Total characters read */
> +	int ccount; /* Number of successful conversions */
> +
> +	mutex_lock(&data->lock);
> +	data->is_sane = 0;
> +
> +	for (data->nsteps = 0; data->nsteps < MAX_NSTEPS; data->nsteps++) {
> +		cr = 0;
> +		ccount = sscanf(buf + tcr, "%d %d " PATTERN_SEPARATOR "%n",
> +			&data->steps[data->nsteps].brightness,
> +			&data->steps[data->nsteps].time_ms, &cr);
> +
> +		if (!cr) { /* Invalid syntax or end of pattern */
> +			if (ccount == 2)
> +				data->nsteps++;
> +			mutex_unlock(&data->lock);
> +			reset_pattern(data, led_cdev);
> +			return count;
> +		}
> +
> +		tcr += cr;
> +	}
> +
> +	/* Shouldn't reach that */
> +	WARN(1, "MAX_NSTEP too small. Please report\n");
> +	mutex_unlock(&data->lock);
> +	return count;
> +}
> +
> +DEVICE_ATTR(pattern, S_IRUGO | S_IWUSR,
> +	pattern_trig_show_pattern, pattern_trig_store_pattern);
> +
> +static int pattern_trig_create_sysfs_files(struct device *dev)
> +{
> +	int err;
> +
> +	err = device_create_file(dev, &dev_attr_repeat);
> +	if (err)
> +		return err;
> +
> +	err = device_create_file(dev, &dev_attr_pattern);
> +	if (err)
> +		device_remove_file(dev, &dev_attr_repeat);
> +
> +	return err;
> +}
> +
> +static void pattern_trig_remove_sysfs_files(struct device *dev)
> +{
> +	device_remove_file(dev, &dev_attr_pattern);
> +	device_remove_file(dev, &dev_attr_repeat);
> +}
> +
> +/* --- Led intensity updating --- */
> +
> +static int compute_brightness(struct pattern_trig_data *data)
> +{
> +	if (data->time_ms == 0)
> +		return data->curr->brightness;
> +
> +	if (data->curr->time_ms == 0)
> +		return data->next->brightness;
> +
> +	return data->curr->brightness + data->time_ms
> +		* (data->next->brightness - data->curr->brightness)
> +		/ data->curr->time_ms;
> +}
> +
> +static void update_to_next_step(struct pattern_trig_data *data)
> +{
> +	data->curr = data->next;
> +	if (data->curr == data->steps)
> +		data->repeat--;
> +
> +	if (data->next == data->steps + data->nsteps - 1)
> +		data->next = data->steps;
> +	else
> +		data->next++;
> +
> +	data->time_ms = 0;
> +}
> +
> +static void pattern_trig_update(struct timer_list *t)
> +{
> +	struct pattern_trig_data *data = from_timer(data, t, timer);
> +
> +	mutex_lock(&data->lock);
> +
> +	if (!data->is_sane || !data->repeat) {
> +		mutex_unlock(&data->lock);
> +		return;
> +	}
> +
> +	if (data->time_ms > data->curr->time_ms)
> +		update_to_next_step(data);
> +
> +	/* is_sane() checked that there is at least
> +	   one step with time_ms >= UPDATE_INTERVAL
> +	   so we won't go in an infinite loop */
> +	while (data->curr->time_ms < UPDATE_INTERVAL)
> +		update_to_next_step(data);
> +
> +	if (data->next->brightness == data->curr->brightness) {
> +		/* Constant brightness for this step */
> +		led_set_brightness(data->led_cdev, data->curr->brightness);
> +		mod_timer(&data->timer, jiffies
> +			+ msecs_to_jiffies(data->curr->time_ms));
> +		update_to_next_step(data);
> +	} else {
> +		/* Gradual dimming */
> +		led_set_brightness(data->led_cdev, compute_brightness(data));
> +		data->time_ms += UPDATE_INTERVAL;
> +		mod_timer(&data->timer, jiffies
> +			+ msecs_to_jiffies(UPDATE_INTERVAL));
> +	}
> +
> +	mutex_unlock(&data->lock);
> +}
> +
> +/* --- Trigger activation --- */
> +
> +static void pattern_trig_activate(struct led_classdev *led_cdev)
> +{
> +	struct pattern_trig_data *data = NULL;
> +	int err;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return;
> +
> +	err = pattern_trig_initialize_data(data);
> +	if (err) {
> +		kfree(data);
> +		return;
> +	}
> +
> +	data->led_cdev = led_cdev;
> +	led_cdev->trigger_data = data;
> +	timer_setup(&data->timer, pattern_trig_update, 0);
> +	pattern_trig_create_sysfs_files(led_cdev->dev);
> +}
> +
> +static void pattern_trig_deactivate(struct led_classdev *led_cdev)
> +{
> +	struct pattern_trig_data *data = led_cdev->trigger_data;
> +
> +	if (data) {
> +		pattern_trig_remove_sysfs_files(led_cdev->dev);
> +		del_timer_sync(&data->timer);
> +		led_set_brightness(led_cdev, LED_OFF);
> +		pattern_trig_clear_data(data);
> +		kfree(data);
> +		led_cdev->trigger_data = NULL;
> +	}
> +}
> +
> +static struct led_trigger pattern_led_trigger = {
> +	.name = "pattern",
> +	.activate = pattern_trig_activate,
> +	.deactivate = pattern_trig_deactivate,
> +};
> +
> +/* --- Module loading/unloading --- */
> +
> +static int __init pattern_trig_init(void)
> +{
> +	return led_trigger_register(&pattern_led_trigger);
> +}
> +
> +static void __exit pattern_trig_exit(void)
> +{
> +	led_trigger_unregister(&pattern_led_trigger);
> +}
> +
> +module_init(pattern_trig_init);
> +module_exit(pattern_trig_exit);
> +
> +MODULE_AUTHOR("Raphael Teysseyre <rteysseyre@gmail.com");
> +MODULE_DESCRIPTION("Pattern LED trigger");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index b7e8255..6940ee2 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -22,6 +22,7 @@
>   #include <linux/workqueue.h>
>   
>   struct device;
> +struct led_pattern;
>   /*
>    * LED Core
>    */
> @@ -88,6 +89,14 @@ struct led_classdev {
>   				     unsigned long *delay_on,
>   				     unsigned long *delay_off);
>   
> +	int (*pattern_set)(struct led_classdev *led_cdev,
> +			   struct led_pattern *pattern, int len);
> +
> +	int (*pattern_clear)(struct led_classdev *led_cdev);
> +
> +	struct led_pattern *(*pattern_get)(struct led_classdev *led_cdev,
> +					   int *len);
> +
>   	struct device		*dev;
>   	const struct attribute_group	**groups;
>   
> @@ -101,7 +110,7 @@ struct led_classdev {
>   	void			(*flash_resume)(struct led_classdev *led_cdev);
>   
>   	struct work_struct	set_brightness_work;
> -	int			delayed_set_value;
> +	enum led_brightness     delayed_set_value;
>   
>   #ifdef CONFIG_LEDS_TRIGGERS
>   	/* Protects the trigger data below */
> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>   	struct led_classdev *led_cdev, enum led_brightness brightness) { }
>   #endif
>   
> +/**
> + * struct led_pattern - brightness value in a pattern
> + * @delta_t: delay until next entry, in milliseconds
> + * @brightness: brightness at time = 0
> + */
> +struct led_pattern {
> +	int delta_t;
> +	int brightness;
> +};
> +
>   #endif		/* __LINUX_LEDS_H_INCLUDED */
> 
> 
> 
> 
> 


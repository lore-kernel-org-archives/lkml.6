Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF252C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940A321A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0ubsuq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940A321A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbeHGA65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:58:57 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38385 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbeHGA65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:58:57 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so6241063plq.5;
        Mon, 06 Aug 2018 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=of+uwfjksBQHd5wvYHVILWxWMmd1B2zTLvTn3V020gI=;
        b=n0ubsuq0oVV/bKEVNXM1hN2QzsJkoQHwYA5MkVIwucLjrADrn+avv6iSzUV6Sc2msN
         UsW3snUezk974YjfTyo3MotiiR1w1r54m+eu/T34Iu969NnNLVHk4wzxKp+zz+NMs3a0
         B7saUvTwEWaKkSIkVtqoykpYznkLSlOkJyh1V0jXEdMhIiz7GOyfxDvjB714J0abxSYn
         bwtfrL8C4leJbxjuOlzbwuhrVb4dbOTYWHIKo2OQuLCMOao3Od5bWK/Npu/+mCpVkqE6
         SvdT3Z++xd2ntc80q/7gyPvNWASMrJzayPHfTM9gYl4TeB7EnydwDaXZN3+qeAC68nmU
         SjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=of+uwfjksBQHd5wvYHVILWxWMmd1B2zTLvTn3V020gI=;
        b=LUS965wwVbcOl2C+g966OvwyLK/dJeg6k0Th4YesomPALlEvp5WD8I2OlkdCV7YLH4
         KpCUQlGYW3lqjrNtGem7xoyS8AolkyW6IleR4YhWg3h730rVrE2samQ4MioqO331r99M
         XbUGPu3mAuhxgTQH9P/A7H+L+PYNynPdl2EsR+5vheSTIdXshrM56nZ+7ZOKPcWJPsSQ
         d+MdlMWW2fssnqRGeIWBctevAEXTwfGrcKCGodcd/h7qeGmMrwAsTh2/jqhknmeOC22o
         CsVsQHQuHaA/N3WGZCbQ+A6EyfaSQBln1S0FcleSqwqqZMiWvRQD47HhmmpfQPl+iwbx
         ihxA==
X-Gm-Message-State: AOUpUlHBYr5N5F245t4AfpT/V6zThvxPllelFhn0kmKGr3nJMzfdya/V
        Yys4YgPQOMOeDF6C/6UMfTo=
X-Google-Smtp-Source: AAOMgpdXNfy7BTWApIVISJorroIi5jmrY3GnLFpa4YYtf0isa49mVTQ8e2yzOTkl19eMtzNNPOJX0Q==
X-Received: by 2002:a17:902:b112:: with SMTP id q18-v6mr15240332plr.284.1533595660899;
        Mon, 06 Aug 2018 15:47:40 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o10-v6sm2180601pfk.76.2018.08.06.15.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 15:47:39 -0700 (PDT)
Date:   Mon, 6 Aug 2018 15:47:37 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH 6/8] input: stpmu1: add stpmu1 onkey driver
Message-ID: <20180806224737.GC141444@dtor-ws>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
 <1530803657-17684-7-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530803657-17684-7-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal,

On Thu, Jul 05, 2018 at 03:14:24PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmu1 pmic is able to manage an onkey button. This driver exposes
> the stpmu1 onkey as an input device. It can also be configured to
> shut-down the power supplies on a long key-press with an adjustable
> duration.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  drivers/input/misc/Kconfig        |  11 ++
>  drivers/input/misc/Makefile       |   2 +
>  drivers/input/misc/stpmu1_onkey.c | 321 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/input/misc/stpmu1_onkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index c25606e..d020971 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -841,4 +841,15 @@ config INPUT_RAVE_SP_PWRBUTTON
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rave-sp-pwrbutton.
>  
> +config INPUT_STPMU1_ONKEY
> +	tristate "STPMU1 PMIC Onkey support"
> +	depends on MFD_STPMU1
> +	help
> +	  Say Y to enable support of onkey embedded into STPMU1 PMIC. onkey
> +	  can be used to wakeup from low power modes and force a shut-down on
> +	  long press.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stpmu1_onkey.
> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 72cde28..cc60dc1 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
>  obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
>  obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
>  obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
> +obj-$(CONFIG_INPUT_STPMU1_ONKEY)  	+= stpmu1_onkey.o
>  obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
>  obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
>  obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
> @@ -80,3 +81,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
>  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
>  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
>  obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
> +
> diff --git a/drivers/input/misc/stpmu1_onkey.c b/drivers/input/misc/stpmu1_onkey.c
> new file mode 100644
> index 0000000..084a31f
> --- /dev/null
> +++ b/drivers/input/misc/stpmu1_onkey.c
> @@ -0,0 +1,321 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> + * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + */
> +
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/stpmu1.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/**
> + * struct stpmu1_onkey - OnKey data
> + * @pmic:		pointer to STPMU1 PMIC device
> + * @input_dev:		pointer to input device
> + * @irq_falling:	irq that we are hooked on to
> + * @irq_rising:		irq that we are hooked on to
> + */
> +struct stpmu1_onkey {
> +	struct stpmu1_dev *pmic;
> +	struct input_dev *input_dev;
> +	int irq_falling;
> +	int irq_rising;
> +};
> +
> +/**
> + * struct pmic_onkey_config - configuration of pmic PONKEYn
> + * @turnoff_enabled:		value to enable turnoff condition
> + * @cc_flag_clear:		value to clear CC flag in case of PowerOff
> + * trigger by longkey press
> + * @onkey_pullup_val:		value of PONKEY PullUp (active or inactive)
> + * @long_press_time_val:	value for long press h/w shutdown event
> + */
> +struct pmic_onkey_config {
> +	bool turnoff_enabled;
> +	bool cc_flag_clear;
> +	u8 onkey_pullup_val;
> +	u8 long_press_time_val;
> +};
> +
> +/**
> + * onkey_falling_irq() - button press isr
> + * @irq:		irq
> + * @pmic_onkey:		onkey device
> + *
> + * Return: IRQ_HANDLED
> + */

This is internal driver functions, I do not see the need for kernel-doc
style comments (or any comments for this one to be honest).

> +static irqreturn_t onkey_falling_irq(int irq, void *ponkey)
> +{
> +	struct stpmu1_onkey *onkey = ponkey;
> +	struct input_dev *input_dev = onkey->input_dev;
> +
> +	input_report_key(input_dev, KEY_POWER, 1);
> +	pm_wakeup_event(input_dev->dev.parent, 0);
> +	input_sync(input_dev);
> +
> +	dev_dbg(&input_dev->dev, "Pwr Onkey Falling Interrupt received\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * onkey_rising_irq() - button released isr
> + * @irq:		irq
> + * @pmic_onkey:		onkey device
> + *
> + * Return: IRQ_HANDLED
> + */
> +static irqreturn_t onkey_rising_irq(int irq, void *ponkey)
> +{
> +	struct stpmu1_onkey *onkey = ponkey;
> +	struct input_dev *input_dev = onkey->input_dev;
> +
> +	input_report_key(input_dev, KEY_POWER, 0);
> +	pm_wakeup_event(input_dev->dev.parent, 0);
> +	input_sync(input_dev);
> +
> +	dev_dbg(&input_dev->dev, "Pwr Onkey Rising Interrupt received\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * stpmu1_onkey_dt_params() - device tree parameter parser
> + * @pdev:	platform device for the PONKEY
> + * @onkey:	pointer to onkey driver data
> + * @config:	configuration params to be filled up
> + */
> +static int stpmu1_onkey_dt_params(struct platform_device *pdev,
> +				  struct stpmu1_onkey *onkey,
> +				  struct pmic_onkey_config *config)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np;
> +	u32 val;
> +
> +	np = dev->of_node;
> +	if (!np)
> +		return -EINVAL;

Is this possible?

> +
> +	onkey->irq_falling = platform_get_irq_byname(pdev, "onkey-falling");
> +	if (onkey->irq_falling < 0) {
> +		dev_err(dev, "failed: request IRQ onkey-falling %d",

Some of your messages use \n, some don't. I'd rather they all did.

> +			onkey->irq_falling);
> +		return onkey->irq_falling;
> +	}
> +
> +	onkey->irq_rising = platform_get_irq_byname(pdev, "onkey-rising");
> +	if (onkey->irq_rising < 0) {
> +		dev_err(dev, "failed: request IRQ onkey-rising %d",
> +			onkey->irq_rising);
> +		return onkey->irq_rising;
> +	}
> +
> +	if (!of_property_read_u32(np, "st,onkey-long-press-seconds", &val)) {
> +		if (val >= 1 && val <= 16) {
> +			config->long_press_time_val = (16 - val);
> +		} else {
> +			dev_warn(dev,
> +				 "Invalid range of long key pressed timer %d (<16)\n\r",

Why \n\r?

> +				 val);
> +		}
> +	}
> +	if (of_get_property(np, "st,onkey-pwroff-enabled", NULL))
> +		config->turnoff_enabled = true;
> +
> +	if (of_get_property(np, "st,onkey-clear-cc-flag", NULL))
> +		config->cc_flag_clear = true;
> +
> +	if (of_get_property(np, "st,onkey-pu-inactive", NULL))
> +		config->onkey_pullup_val = PONKEY_PU_ACTIVE;

Even though the driver is only used in OF systems, I wonder if we should
not be using generic device property API.

> +
> +	dev_dbg(dev, "onkey-switch-off duration=%d seconds\n",
> +		config->long_press_time_val);
> +
> +	return 0;
> +}
> +
> +/**
> + * stpmu1_onkey_probe() - probe
> + * @pdev:	platform device for the PONKEY
> + *
> + * Return: 0 for successful probe else appropriate error
> + */
> +static int stpmu1_onkey_probe(struct platform_device *pdev)
> +{
> +	struct stpmu1_dev *pmic = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input_dev;
> +	struct stpmu1_onkey *onkey;
> +	struct pmic_onkey_config config;
> +	unsigned int val = 0;
> +	int ret;

Call this variable "error" please.

> +
> +	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	memset(&config, 0, sizeof(struct pmic_onkey_config));
> +	ret = stpmu1_onkey_dt_params(pdev, onkey, &config);
> +	if (ret < 0)

stpmu1_onkey_dt_params() does not return positives (good) so:

	if (error)
		return error;

> +		goto err;
> +
> +	input_dev = devm_input_allocate_device(dev);
> +	if (!input_dev) {
> +		dev_err(dev, "Can't allocate Pwr Onkey Input Device\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	input_dev->name = "pmic_onkey";
> +	input_dev->phys = "pmic_onkey/input0";
> +	input_dev->dev.parent = dev;

This is already set by devm_input_allocate_device().

> +
> +	input_set_capability(input_dev, EV_KEY, KEY_POWER);
> +
> +	/* Setup Power Onkey Hardware parameters (long key press)*/
> +	val = (config.long_press_time_val & PONKEY_TURNOFF_TIMER_MASK);
> +	if (config.turnoff_enabled)
> +		val |= PONKEY_PWR_OFF;
> +	if (config.cc_flag_clear)
> +		val |= PONKEY_CC_FLAG_CLEAR;
> +	ret = regmap_update_bits(pmic->regmap, PKEY_TURNOFF_CR,
> +				 PONKEY_TURNOFF_MASK, val);
> +	if (ret) {
> +		dev_err(dev, "LONG_PRESS_KEY_UPDATE failed: %d\n", ret);
> +		goto err;

You are using all managed resources, so "return error" directly, no need
to just to error unwinding path.

> +	}
> +
> +	ret = regmap_update_bits(pmic->regmap, PADS_PULL_CR,
> +				 PONKEY_PU_ACTIVE,
> +				 config.onkey_pullup_val);
> +
> +	if (ret) {
> +		dev_err(dev, "ONKEY Pads configuration failed: %d\n", ret);
> +		goto err;
> +	}
> +
> +	onkey->pmic = pmic;
> +	onkey->input_dev = input_dev;
> +
> +	ret = devm_request_threaded_irq(dev, onkey->irq_falling, NULL,

Why does this need to be threaded? The isr does not seem to be calling
any APIs that may wait.

> +					onkey_falling_irq,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					dev_name(dev), onkey);
> +	if (ret) {
> +		dev_err(dev, "Can't get IRQ for Onkey Falling edge: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, onkey->irq_rising, NULL,
> +					onkey_rising_irq,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					dev_name(dev), onkey);
> +	if (ret) {
> +		dev_err(dev, "Can't get IRQ for Onkey Rising edge: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = input_register_device(input_dev);
> +	if (ret) {
> +		dev_err(dev, "Can't register power button: %d\n", ret);
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, onkey);
> +	device_init_wakeup(dev, true);
> +
> +	dev_dbg(dev, "PMIC Pwr Onkey driver probed\n");

I'd rather dropped this. Input core will print when registering device
already.

> +
> +err:
> +	return ret;
> +}
> +
> +/**
> + * stpmu1_onkey_remove() - Cleanup on removal
> + * @pdev:	platform device for the button
> + *
> + * Return: 0
> + */
> +static int stpmu1_onkey_remove(struct platform_device *pdev)
> +{
> +	struct stpmu1_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	input_unregister_device(onkey->input_dev);

You are using managed input device, so this call is not needed. You
should be able to remove entire stpmu1_onkey_remove().

> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP

You annotated suspend/resume methods with __maybe_unused, so this guard
is not needed.

> +
> +/**
> + * pmic_onkey_suspend() - suspend handler
> + * @dev:	power button device
> + *
> + * Cancel all pending work items for the power button, setup irq for wakeup
> + *
> + * Return: 0
> + */
> +static int __maybe_unused stpmu1_onkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct stpmu1_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(onkey->irq_falling);
> +		enable_irq_wake(onkey->irq_rising);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pmic_onkey_resume() - resume handler
> + * @dev:	power button device
> + *
> + * Just disable the wakeup capability of irq here.
> + *
> + * Return: 0
> + */
> +static int __maybe_unused stpmu1_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct stpmu1_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(onkey->irq_falling);
> +		disable_irq_wake(onkey->irq_rising);
> +	}
> +	return 0;
> +}
> +
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stpmu1_onkey_pm,
> +			 stpmu1_onkey_suspend,
> +			 stpmu1_onkey_resume);
> +
> +static const struct of_device_id of_stpmu1_onkey_match[] = {
> +	{ .compatible = "st,stpmu1-onkey" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_stpmu1_onkey_match);
> +
> +static struct platform_driver stpmu1_onkey_driver = {
> +	.probe	= stpmu1_onkey_probe,
> +	.remove	= stpmu1_onkey_remove,
> +	.driver	= {
> +		.name	= "stpmu1_onkey",
> +		.of_match_table = of_match_ptr(of_stpmu1_onkey_match),
> +		.pm	= &stpmu1_onkey_pm,
> +	},
> +};
> +module_platform_driver(stpmu1_onkey_driver);
> +
> +MODULE_DESCRIPTION("Onkey driver for STPMU1");
> +MODULE_LICENSE("GPL");

To match your SPDX notice this should be MODULE_LICENSE("GPL v2").

> +MODULE_AUTHOR("philippe.peurichard@st.com>");
> -- 
> 1.9.1

Thanks.

-- 
Dmitry

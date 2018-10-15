Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1819DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9348208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDGxlzeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9348208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeJPGUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:20:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43701 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeJPGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:20:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id 30-v6so9957035plb.10;
        Mon, 15 Oct 2018 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDmJg6sZtRTvV5LdsTt53xCyWDII+Z2+my0aL5eR/c8=;
        b=aDGxlzeMcKGt4HTWWI1A4shCDKgwOvQvY/Zz+ubk1D2zx1dAyJtJN+EQvpSqk1cVPj
         QgvHo9gjPg1k9gnx8L7PwQ7IYF3SC3mWjvzxGcLCfDdZ8nz7LdxhQvLTDjfS8NrL6E4U
         OnkH0lmpWoGBGoSWBoJpLT9K3fVoL1vrTCrcuz7SHAsOfPs8yEcSySSUxkjwiNUVbrn2
         RaiNQHGBLVM+0nTeQnQnFiqqLNZ2cTnDN05/dw/yKyCkznQxN3bIsJ4yKgv99lnap0RB
         HqP5jr4ipXK1OQPIaOZ8smwX4RQsQPekpTTgfsnxnXeG6Ktaq7mArZN2auJeJ6fBsvWd
         rLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDmJg6sZtRTvV5LdsTt53xCyWDII+Z2+my0aL5eR/c8=;
        b=c997/WmORNCsF3UXpcCpMmx227Yx0ulEVQr4HLi1m9QBpjmDgj66A4dw2ZG6j0f+Zx
         TqDK6Nq/1mApkGfdzC6L90Ci21aUYayGdj2ZA73HQdHKq3rWM5ixCX/QQ0Sw9Y2tv63c
         AmGw/1N83RWlFICgTAbywlyl/BudYj4oiXlWL3TdJYpLnaRMHVng2cnd2RLjdq9+Y85f
         m7Gi/3aePsQkEgL2RxLu90b4a9763g+GoMrnZFOpQ+8S9+XOumidICPG9yDx9MC6r9Ct
         pmsC/X5EhvuGTxOmNAa1yN9GdXfrAXr+SY1VQ3vgfryt97YJfkwNLAGIbCFVY6Ls+399
         24bQ==
X-Gm-Message-State: ABuFfojoOfTsIvoXdw+gJ/nRl68LDQdzuE7dgCUiWEJtsig33NHxhxbL
        msu5pgSWQBXdTJImOQpgvtY=
X-Google-Smtp-Source: ACcGV61PbBWdC0IoO0A1UC1YJYjHZ5QhOzE5FTWgw5IhFbHCEfbjzLftmW1FLwCJ565PWf33Qsfx9A==
X-Received: by 2002:a17:902:7203:: with SMTP id ba3-v6mr8818274plb.321.1539642776634;
        Mon, 15 Oct 2018 15:32:56 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6-v6sm13865423pgl.6.2018.10.15.15.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:32:55 -0700 (PDT)
Date:   Mon, 15 Oct 2018 15:32:52 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
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
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "eballetbo@gmail.com" <eballetbo@gmail.com>
Subject: Re: [PATCH v3 6/8] input: stpmic1: add stpmic1 onkey driver
Message-ID: <20181015223252.GE127224@dtor-ws>
References: <1539016176-4072-1-git-send-email-p.paillet@st.com>
 <1539016176-4072-7-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539016176-4072-7-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal,

On Mon, Oct 08, 2018 at 04:29:41PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 pmic is able to manage an onkey button. This driver exposes
> the stpmic1 onkey as an input device. It can also be configured to
> shut-down the power supplies on a long key-press with an adjustable
> duration.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v3:
> * Rename struct stpmic1_dev by struct stpmic1.
> * Replace of_property_ by device_property.
> * Remove log in IRQ handler.
> * Add email address in MODULE_AUTHOR.
> 
>  drivers/input/misc/Kconfig         |  11 ++
>  drivers/input/misc/Makefile        |   2 +
>  drivers/input/misc/stpmic1_onkey.c | 248 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 261 insertions(+)
>  create mode 100644 drivers/input/misc/stpmic1_onkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index ca59a2b..279fb02 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -851,4 +851,15 @@ config INPUT_SC27XX_VIBRA
>  	  To compile this driver as a module, choose M here. The module will
>  	  be called sc27xx_vibra.
>  
> +config INPUT_STPMIC1_ONKEY
> +	tristate "STPMIC1 PMIC Onkey support"
> +	depends on MFD_STPMIC1
> +	help
> +	  Say Y to enable support of onkey embedded into STPMIC1 PMIC. onkey
> +	  can be used to wakeup from low power modes and force a shut-down on
> +	  long press.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called stpmic1_onkey.
> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 9d0f9d1..1b44202 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
>  obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
>  obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
>  obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
> +obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
>  obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
>  obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
>  obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
> @@ -81,3 +82,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
>  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
>  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
>  obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
> +
> diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
> new file mode 100644
> index 0000000..871a087
> --- /dev/null
> +++ b/drivers/input/misc/stpmic1_onkey.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) STMicroelectronics 2018
> +// Author: Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> +
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/stpmic1.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +/**
> + * struct stpmic1_onkey - OnKey data
> + * @pmic:		pointer to STPMIC1 PMIC device
> + * @input_dev:		pointer to input device
> + * @irq_falling:	irq that we are hooked on to
> + * @irq_rising:		irq that we are hooked on to
> + */
> +struct stpmic1_onkey {
> +	struct stpmic1 *pmic;
> +	struct input_dev *input_dev;
> +	int irq_falling;
> +	int irq_rising;
> +};
> +
> +/**
> + * struct pmic_onkey_config - configuration of pmic PONKEYn
> + * @cc_flag_clear:		value to clear CC flag in case of PowerOff
> + * trigger by longkey press
> + * @onkey_pullup_val:		value of PONKEY PullUp (active or inactive)
> + * @power_off_time_sec:		value for long press h/w shutdown event
> + */
> +struct pmic_onkey_config {
> +	bool cc_flag_clear;
> +	u8 onkey_pullup_val;
> +	u8 power_off_time_sec;
> +};
> +
> +static irqreturn_t onkey_falling_irq(int irq, void *ponkey)
> +{
> +	struct stpmic1_onkey *onkey = ponkey;
> +	struct input_dev *input_dev = onkey->input_dev;
> +
> +	input_report_key(input_dev, KEY_POWER, 1);
> +	pm_wakeup_event(input_dev->dev.parent, 0);
> +	input_sync(input_dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t onkey_rising_irq(int irq, void *ponkey)
> +{
> +	struct stpmic1_onkey *onkey = ponkey;
> +	struct input_dev *input_dev = onkey->input_dev;
> +
> +	input_report_key(input_dev, KEY_POWER, 0);
> +	pm_wakeup_event(input_dev->dev.parent, 0);
> +	input_sync(input_dev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int stpmic1_onkey_dt_params(struct platform_device *pdev,
> +				   struct stpmic1_onkey *onkey,
> +				   struct pmic_onkey_config *config)
> +{
> +	struct device *dev = &pdev->dev;
> +	u32 val;
> +
> +	onkey->irq_falling = platform_get_irq_byname(pdev, "onkey-falling");
> +	if (onkey->irq_falling < 0) {
> +		dev_err(dev, "failed: request IRQ onkey-falling %d\n",
> +			onkey->irq_falling);
> +		return onkey->irq_falling;
> +	}
> +
> +	onkey->irq_rising = platform_get_irq_byname(pdev, "onkey-rising");
> +	if (onkey->irq_rising < 0) {
> +		dev_err(dev, "failed: request IRQ onkey-rising %d\n",
> +			onkey->irq_rising);
> +		return onkey->irq_rising;
> +	}
> +
> +	if (!device_property_read_u32(dev, "power-off-time-sec", &val)) {
> +		if ((val > 0) && (val <= 16)) {
> +			config->power_off_time_sec = val;
> +		} else {
> +			dev_err(dev, "power-off-time-sec out of range\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (device_property_present(dev, "st,onkey-clear-cc-flag"))
> +		config->cc_flag_clear = true;
> +
> +	if (device_property_present(dev, "st,onkey-pu-inactive"))
> +		config->onkey_pullup_val = PONKEY_PU_ACTIVE;
> +
> +	dev_dbg(dev, "onkey-switch-off duration=%d seconds\n",
> +		config->power_off_time_sec);
> +
> +	return 0;
> +}
> +
> +static int stpmic1_onkey_probe(struct platform_device *pdev)
> +{
> +	struct stpmic1 *pmic = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input_dev;
> +	struct stpmic1_onkey *onkey;
> +	struct pmic_onkey_config config;
> +	unsigned int val = 0;
> +	int error;
> +
> +	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
> +
> +	memset(&config, 0, sizeof(struct pmic_onkey_config));
> +	error = stpmic1_onkey_dt_params(pdev, onkey, &config);
> +	if (error)
> +		return error;
> +
> +	input_dev = devm_input_allocate_device(dev);
> +	if (!input_dev) {
> +		dev_err(dev, "Can't allocate Pwr Onkey Input Device\n");
> +		return -ENOMEM;
> +	}
> +
> +	input_dev->name = "pmic_onkey";
> +	input_dev->phys = "pmic_onkey/input0";
> +
> +	input_set_capability(input_dev, EV_KEY, KEY_POWER);
> +
> +	/* Setup Power Onkey Hardware parameters (long key press)*/
> +	if (config.power_off_time_sec > 0) {
> +		val |= PONKEY_PWR_OFF;
> +		val |= ((16 - config.power_off_time_sec) &
> +			PONKEY_TURNOFF_TIMER_MASK);
> +	}
> +	if (config.cc_flag_clear)

How about doing:

	if (device_property_present(dev, "st,onkey-clear-cc-flag"))
> +		val |= PONKEY_CC_FLAG_CLEAR;

and similarly handle other properties?  Then you would not really need
the "config" structure/variable nor stpmic1_onkey_dt_params() and I do
not think you'd lose any readability.

> +	error = regmap_update_bits(pmic->regmap, PKEY_TURNOFF_CR,
> +				   PONKEY_TURNOFF_MASK, val);
> +	if (error) {
> +		dev_err(dev, "LONG_PRESS_KEY_UPDATE failed: %d\n", error);
> +		return error;
> +	}
> +
> +	error = regmap_update_bits(pmic->regmap, PADS_PULL_CR,
> +				   PONKEY_PU_ACTIVE,
> +				   config.onkey_pullup_val);
> +	if (error) {
> +		dev_err(dev, "ONKEY Pads configuration failed: %d\n", error);
> +		return error;
> +	}
> +
> +	onkey->pmic = pmic;
> +	onkey->input_dev = input_dev;
> +
> +	/* interrupt is nested in a thread */
> +	error = devm_request_threaded_irq(dev, onkey->irq_falling, NULL,
> +					  onkey_falling_irq, IRQF_ONESHOT,
> +					  dev_name(dev), onkey);
> +	if (error) {
> +		dev_err(dev, "Can't get IRQ Onkey Falling: %d\n", error);
> +		return error;
> +	}
> +
> +	error = devm_request_threaded_irq(dev, onkey->irq_rising, NULL,
> +					  onkey_rising_irq, IRQF_ONESHOT,
> +					  dev_name(dev), onkey);
> +	if (error) {
> +		dev_err(dev, "Can't get IRQ Onkey Rising: %d\n", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(dev, "Can't register power button: %d\n", error);
> +		return error;
> +	}
> +
> +	platform_set_drvdata(pdev, onkey);
> +	device_init_wakeup(dev, true);
> +
> +	return 0;
> +}
> +
> +static int stpmic1_onkey_remove(struct platform_device *pdev)
> +{
> +	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	input_unregister_device(onkey->input_dev);

Input device is devm-managed, it doe snot have to be unregistered
manually. You can remove stpmic1_onkey_remove altogether.

> +	return 0;
> +}
> +
> +static int __maybe_unused stpmic1_onkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(dev)) {
> +		enable_irq_wake(onkey->irq_falling);
> +		enable_irq_wake(onkey->irq_rising);
> +	}
> +	return 0;
> +}
> +
> +static int __maybe_unused stpmic1_onkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct stpmic1_onkey *onkey = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(dev)) {
> +		disable_irq_wake(onkey->irq_falling);
> +		disable_irq_wake(onkey->irq_rising);
> +	}
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(stpmic1_onkey_pm,
> +			 stpmic1_onkey_suspend,
> +			 stpmic1_onkey_resume);
> +
> +static const struct of_device_id of_stpmic1_onkey_match[] = {
> +	{ .compatible = "st,stpmic1-onkey" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, of_stpmic1_onkey_match);
> +
> +static struct platform_driver stpmic1_onkey_driver = {
> +	.probe	= stpmic1_onkey_probe,
> +	.remove	= stpmic1_onkey_remove,
> +	.driver	= {
> +		.name	= "stpmic1_onkey",
> +		.of_match_table = of_match_ptr(of_stpmic1_onkey_match),
> +		.pm	= &stpmic1_onkey_pm,
> +	},
> +};
> +module_platform_driver(stpmic1_onkey_driver);
> +
> +MODULE_DESCRIPTION("Onkey driver for STPMIC1");
> +MODULE_AUTHOR("Pascal Paillet <p.paillet@st.com>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1

-- 
Dmitry

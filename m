Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C52C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAC72075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc8XlPd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAC72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeIGWUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:20:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35291 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeIGWUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:20:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2-v6so5940500plo.2;
        Fri, 07 Sep 2018 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5nW3c/pZv3/umU6oc6P12NO0oqY6yFm68KVgJkv9gtc=;
        b=Uc8XlPd+eyXKV9RNAT6FxNHJENcHbXFuD/HDsNifC88DDqCQVs9i9WnyzcIaW6NSxb
         ueN4ELtYltMboNqs1I3DEJslxWHAzSzQQnU8K8pRr4ElaaZNYWkPxMIObMTs3vx1Ga3z
         V0eJxu/iYE6b/JFocttuDZ3TBy2coA7UQwWCzGoh6fqYFG+0pLqykVmMrTpMaaexfdLw
         5Xq4BcXj/U8s/OsjdZHQl7hYpyZ9f1MK7foa1b/fF9HUgA/T6+VoqgV1Db1iIBmaHKjZ
         F+MSTx9GkembXDguJ9sNvWdIRQZdQ1V/ipDWX/FrqC9ZnectyXtKP5tZr1G7TTDIMQum
         KbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nW3c/pZv3/umU6oc6P12NO0oqY6yFm68KVgJkv9gtc=;
        b=AkhwrGBFhWZAOlT73bt6u7pqCtJf+epJgGsn2hBasZ3gTrJvnOIHWMBdRqHuBtRerp
         6B2zMMkxiptCbI5S2+QqR1Q/cAqPp8LFXHTErNJztF5lBxJ72VfgyMs3SfcCd1BjMFQz
         2IW7dLVt9SeG051pJ2k3BncrZwmA1x60irW+jj1BKyImv1kQ7FbfsDjh4nzeSXvXhKEV
         7b6wA86plCTWfTCiNNr2HZ1n++YNEHKB0Dj1plppAOXobca3kIV8GIJ4vQoP+s9/QqEQ
         9PXlpODkno3gd9Z45p5j08SpSL+ARye1Za7HZQdWWiRvkfxyJG8rFHSA6/u/aHjFYgkz
         s7Ug==
X-Gm-Message-State: APzg51A6faDulChypU4Myuk3eLlS2rJHwNxIW58nszYpLxYnLPzbsJ84
        NDY12o9ahHjJObBtfMr6Aw4=
X-Google-Smtp-Source: ANB0VdaHUmihiOExAvrWp+lSfhmeqMIV1iJT+krjDxvPbm1i3CwoVuiwdfWfjUtUg+L3dnM71w4faA==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr9083357plh.135.1536341914099;
        Fri, 07 Sep 2018 10:38:34 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l79-v6sm14001703pfb.111.2018.09.07.10.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 10:38:33 -0700 (PDT)
Date:   Fri, 7 Sep 2018 10:38:31 -0700
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
Subject: Re: [PATCH V2 6/8] input: stpmic1: add stpmic1 onkey driver
Message-ID: <20180907173831.GB261528@dtor-ws>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-7-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536325173-16617-7-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal,

On Fri, Sep 07, 2018 at 12:59:45PM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 pmic is able to manage an onkey button. This driver exposes
> the stpmic1 onkey as an input device. It can also be configured to
> shut-down the power supplies on a long key-press with an adjustable
> duration.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
> changes in v2:
> * the hardware component has been renamed from stpmu1 to stpmic1 !
> * change headers
> * handle remarks from Dmitry
> * the irq is threaded because is is nested in a thread; I have added a comment.
> Dmitry, I'm sorry, but I did not catch your comment regarding usage of 
> "generic device property API.". could you tell more ? 

You basically do

s/of_property_/device_property_/

and that's it.

> 
>  drivers/input/misc/Kconfig         |  11 ++
>  drivers/input/misc/Makefile        |   2 +
>  drivers/input/misc/stpmic1_onkey.c | 257 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 270 insertions(+)
>  create mode 100644 drivers/input/misc/stpmic1_onkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index c25606e..cc82dad 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -841,4 +841,15 @@ config INPUT_RAVE_SP_PWRBUTTON
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rave-sp-pwrbutton.
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
> index 72cde28..f0e11b0 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
>  obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc-onkey.o
>  obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
>  obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
> +obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
>  obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
>  obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
>  obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
> @@ -80,3 +81,4 @@ obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
>  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
>  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
>  obj-$(CONFIG_INPUT_IDEAPAD_SLIDEBAR)	+= ideapad_slidebar.o
> +
> diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
> new file mode 100644
> index 0000000..170d879
> --- /dev/null
> +++ b/drivers/input/misc/stpmic1_onkey.c
> @@ -0,0 +1,257 @@
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
> +	struct stpmic1_dev *pmic;
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
> +static irqreturn_t onkey_falling_irq(int irq, void *ponkey)
> +{
> +	struct stpmic1_onkey *onkey = ponkey;
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
> +static irqreturn_t onkey_rising_irq(int irq, void *ponkey)
> +{
> +	struct stpmic1_onkey *onkey = ponkey;
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
> +static int stpmic1_onkey_dt_params(struct platform_device *pdev,
> +				   struct stpmic1_onkey *onkey,
> +				   struct pmic_onkey_config *config)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np;
> +	u32 val;
> +
> +	np = dev->of_node;
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
> +	if (!of_property_read_u32(np, "st,onkey-long-press-seconds", &val)) {
> +		if (val >= 1 && val <= 16) {
> +			config->long_press_time_val = (16 - val);
> +		} else {
> +			dev_warn(dev,
> +				 "Invalid range of long key pressed timer %d (<16)\n",
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
> +
> +	dev_dbg(dev, "onkey-switch-off duration=%d seconds\n",
> +		config->long_press_time_val);
> +
> +	return 0;
> +}
> +
> +static int stpmic1_onkey_probe(struct platform_device *pdev)
> +{
> +	struct stpmic1_dev *pmic = dev_get_drvdata(pdev->dev.parent);
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
> +	val = (config.long_press_time_val & PONKEY_TURNOFF_TIMER_MASK);
> +	if (config.turnoff_enabled)
> +		val |= PONKEY_PWR_OFF;
> +	if (config.cc_flag_clear)
> +		val |= PONKEY_CC_FLAG_CLEAR;
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
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Pascal Paillet");
> -- 
> 1.9.1

-- 
Dmitry

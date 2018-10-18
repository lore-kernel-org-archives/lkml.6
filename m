Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B861C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41D1204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6cBIowO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41D1204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeJSCPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:15:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42733 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeJSCPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:15:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so14546692pgq.9;
        Thu, 18 Oct 2018 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+nM1xkEKe7FPa2uXvMUtgf0QQIoSbTHnAt7Y8WGErBo=;
        b=c6cBIowOCIv61hv5ldmaOmfqrkALAA6gqPxZQT8/zlolp0ZQmjhWUBV3zj4inYNxzX
         vYRc+Q+OxwnaFqa0174CXZ0u3FIuwrHoJe7QrhH+iKdyBcLXF4ss1gt11KPDMW8M6BM6
         PWyLApz1nzE+DwXrhaUENFHyZKwptG4A4VGVTlhjoR2bkZ/Vk6NyPCQ1FJD/xRMZ4BRp
         AI5Brp3PoBm+N02HdV9x/qE2lMjW+9PgTB/Z2Zbmt3JI1hC5w2XcJZEirnPSx8eyHhlP
         1lL5N/hnsMaTbRfgWUZFGoD0j35hhA4n/9UkwI2sf3zlz4Q/5pkFUoTWHIuUUODsdSdP
         IC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+nM1xkEKe7FPa2uXvMUtgf0QQIoSbTHnAt7Y8WGErBo=;
        b=sHUBVbV48vac61fQ8GkkPhnR/b5WqESahv5oyePKLI9G6Uuuy7+ZFm1d46mjINryDZ
         UNXKfkGIJEBOgrlI5FVN0R8yv9IIr9yNS7TLfweh8JRnz8QBSqHRzZ9D80QUpw0iM7je
         wUEuMn31snv/oMYepBmC99HTDE2vbo5Z4GFqBuhkhohDs/KybX/1KQno8EEevCcPYMpm
         3cf3bX2mTJ4jdwtNOF216jezfLRmH1JpvE2M5l+X/yzKjXayYUcyWr1UboLHoj2xGbhS
         9ka9M96iJqKifnSYxIoE/QL7LT16mTLvu9e35kYATZVKlIhdHOVKu9tMnKIc9EjK6Ry6
         TzEg==
X-Gm-Message-State: ABuFfoj3MejtQ/GvIdkCLQarelkuoR/+AGygF4S9jOCDv3ZRsP1TBADK
        SJetAjOvaj+hMS5C1i6inxg=
X-Google-Smtp-Source: ACcGV61s2p/bqrZ9DLf6ul/Nkg5OMypl7OdLgdhoXkDq4dndgzN3hcyCk6xbXy5J+V6MZKfSC0ckXg==
X-Received: by 2002:a62:808c:: with SMTP id j134-v6mr31112237pfd.47.1539886377672;
        Thu, 18 Oct 2018 11:12:57 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id n82-v6sm31361648pfg.21.2018.10.18.11.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:12:56 -0700 (PDT)
Date:   Thu, 18 Oct 2018 11:12:54 -0700
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Pascal PAILLET-LME <p.paillet@st.com>, lee.jones@linaro.org
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v4 6/8] input: stpmic1: add stpmic1 onkey driver
Message-ID: <20181018181254.GB210757@dtor-ws>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-7-git-send-email-p.paillet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539853324-29051-7-git-send-email-p.paillet@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:02:13AM +0000, Pascal PAILLET-LME wrote:
> From: pascal paillet <p.paillet@st.com>
> 
> The stpmic1 pmic is able to manage an onkey button. This driver exposes
> the stpmic1 onkey as an input device. It can also be configured to
> shut-down the power supplies on a long key-press with an adjustable
> duration.
> 
> Signed-off-by: pascal paillet <p.paillet@st.com>

OK, so this has dependency on linux/mfd/stpmic1.h and therefore I expect
it will go in through Lee's tree.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> changes in v4:
> * remove remove function
> * merge stpmic1_onkey_dt_params() in probe function
> * suppresse struct pmic_onkey_config
> * rename PONKEY_PU_ACTIVE to PONKEY_PU_INACTIVE
> 
>  drivers/input/misc/Kconfig         |  11 +++
>  drivers/input/misc/Makefile        |   2 +
>  drivers/input/misc/stpmic1_onkey.c | 197 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+)
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
> index 0000000..6a7f08b
> --- /dev/null
> +++ b/drivers/input/misc/stpmic1_onkey.c
> @@ -0,0 +1,197 @@
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
> + * @input_dev:		pointer to input device
> + * @irq_falling:	irq that we are hooked on to
> + * @irq_rising:		irq that we are hooked on to
> + */
> +struct stpmic1_onkey {
> +	struct input_dev *input_dev;
> +	int irq_falling;
> +	int irq_rising;
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
> +static int stpmic1_onkey_probe(struct platform_device *pdev)
> +{
> +	struct stpmic1 *pmic = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input_dev;
> +	struct stpmic1_onkey *onkey;
> +	unsigned int val, reg = 0;
> +	int error;
> +
> +	onkey = devm_kzalloc(dev, sizeof(*onkey), GFP_KERNEL);
> +	if (!onkey)
> +		return -ENOMEM;
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
> +			dev_dbg(dev, "power-off-time=%d seconds\n", val);
> +			reg |= PONKEY_PWR_OFF;
> +			reg |= ((16 - val) & PONKEY_TURNOFF_TIMER_MASK);
> +		} else {
> +			dev_err(dev, "power-off-time-sec out of range\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (device_property_present(dev, "st,onkey-clear-cc-flag"))
> +		reg |= PONKEY_CC_FLAG_CLEAR;
> +
> +	error = regmap_update_bits(pmic->regmap, PKEY_TURNOFF_CR,
> +				   PONKEY_TURNOFF_MASK, reg);
> +	if (error) {
> +		dev_err(dev, "PKEY_TURNOFF_CR write failed: %d\n", error);
> +		return error;
> +	}
> +
> +	if (device_property_present(dev, "st,onkey-pu-inactive")) {
> +		error = regmap_update_bits(pmic->regmap, PADS_PULL_CR,
> +					   PONKEY_PU_INACTIVE,
> +					   PONKEY_PU_INACTIVE);
> +		if (error) {
> +			dev_err(dev, "ONKEY Pads configuration failed: %d\n", error);
> +			return error;
> +		}
> +	}
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

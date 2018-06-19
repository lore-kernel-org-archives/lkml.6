Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B107AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB9F2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbWHnDJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB9F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030406AbeFSRuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:50:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36465 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSRud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:50:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so209622pgd.3;
        Tue, 19 Jun 2018 10:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OD7U1q+3RSQ4vSuEQndgynz1Jr6R5Zs9e+0GU4A3gbk=;
        b=EbWHnDJSIAKFsEoUUlfVb1KIcUmFpiAsVSLpsfdiUg0mMQL6W9lKVezoC3ORKRbIsK
         rlxe3vUlvKwOZ+J/YFjSarK3n+6CofnPRgwn5ZQzT7XZipyZm8XNWVSzaONGgJT+WXH6
         OC0YdoAcWF6pjC0XzitE5GFcFYA9ciay7ymsWUWpMPSxu0aNBbEse7OV/xznBknYjnhE
         fJ4qC/MxIhv2A2KaSfkDnw6mcBkiWb5fmUEMUQg4luhmAxT78cUTxzhIXV70pryOoPGd
         DUhmk8Hxlz39cMwrg99s6UrcuRlpFyzQVGI/5kXtaTjLC1XfHLV4J4PXUDrlOYEevg84
         WlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OD7U1q+3RSQ4vSuEQndgynz1Jr6R5Zs9e+0GU4A3gbk=;
        b=tvSvka92Y59Uk2ipjjUixwMKr4DwoQ2h1OpwqBZFEFriggFG86/RobvHIcFwmfEb1L
         AgEXF72tS5Cq93zN1keIh3ika7/fU1KJAnZ61/fa7nLK/9nSrrXMCF7PP1DdgVLofd9f
         D+yC+22zoERLV3YbrapGWPIZ1mQ6TGAr8EIFBbhKfzS5iDNXMXIr07kg1KXt0y/mo2Uu
         dqu2c1I/BfbUsPajl+cCdgN5fk9KPO4kyFWV3iaHggmQM7sAAfUvJvp4ilvcYYWiZrCE
         8yyhigMY/bgrsMVhE6U4J1524Tc2QmAMP7mC9CTx+bD+kg6eKxtsRotYKHv2q5jb0kdF
         fyRw==
X-Gm-Message-State: APt69E05wPWQeYIk/rea5mw1NKzX/Hjoxjt7Pzw59W+zqJKMeJci6Wgp
        mwSi/rkVVyWcpCGW5X8Swuc=
X-Google-Smtp-Source: ADUXVKIIEJ+HfDb/iym8HE4VGkPGeYU/ND3iijuk0AyNw7Z1FM50kt9hxuyvVpFX62F5M1DnycEWrA==
X-Received: by 2002:a63:444:: with SMTP id 65-v6mr16256203pge.101.1529430632482;
        Tue, 19 Jun 2018 10:50:32 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id t3-v6sm240171pgs.91.2018.06.19.10.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 10:50:31 -0700 (PDT)
Date:   Tue, 19 Jun 2018 10:50:28 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 4/4] input/power: Add driver for BD71837/BD71847 PMIC
 power button
Message-ID: <20180619175028.GA71788@dtor-ws>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <af60857c6db5fcf14fbf0112f74719d898952459.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af60857c6db5fcf14fbf0112f74719d898952459.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Tue, Jun 19, 2018 at 01:57:09PM +0300, Matti Vaittinen wrote:
> ROHM BD71837 PMIC power button driver providing power-key press
> information to user-space.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/input/misc/Kconfig          | 10 +++++
>  drivers/input/misc/Makefile         |  1 +
>  drivers/input/misc/bd718xx-pwrkey.c | 90 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+)
>  create mode 100644 drivers/input/misc/bd718xx-pwrkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 572b15fa18c2..694c05d3f9fb 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -96,6 +96,16 @@ config INPUT_ATMEL_CAPTOUCH
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called atmel_captouch.
>  
> +config INPUT_BD718XX_PWRKEY
> +	tristate "ROHM BD71837/BD71847 power key support"
> +	depends on MFD_BD71837
> +	help
> +	  Say Y here if you want support for the power key usually found
> +	  on boards using a ROHM BD71837/BD71847 compatible PMIC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called bd718xx-pwrkey.
> +
>  config INPUT_BMA150
>  	tristate "BMA150/SMB380 acceleration sensor support"
>  	depends on I2C
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index 72cde28649e2..ea5b81cbf2bf 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
>  obj-$(CONFIG_INPUT_ATLAS_BTNS)		+= atlas_btns.o
>  obj-$(CONFIG_INPUT_ATMEL_CAPTOUCH)	+= atmel_captouch.o
>  obj-$(CONFIG_INPUT_BMA150)		+= bma150.o
> +obj-$(CONFIG_INPUT_BD718XX_PWRKEY)	+= bd718xx-pwrkey.o
>  obj-$(CONFIG_INPUT_CM109)		+= cm109.o
>  obj-$(CONFIG_INPUT_CMA3000)		+= cma3000_d0x.o
>  obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
> diff --git a/drivers/input/misc/bd718xx-pwrkey.c b/drivers/input/misc/bd718xx-pwrkey.c
> new file mode 100644
> index 000000000000..e8ac9475c3cf
> --- /dev/null
> +++ b/drivers/input/misc/bd718xx-pwrkey.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 ROHM Semiconductors
> +// bd718xx-pwrkey.c -- ROHM BD71837MWV and BD71847 power button driver
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/mfd/bd71837.h>
> +
> +struct bd718xx_pwrkey {
> +	struct input_dev *idev;
> +	struct bd71837 *mfd;
> +	int irq;
> +};
> +
> +static irqreturn_t button_irq(int irq, void *_priv)
> +{
> +	struct input_dev *idev = (struct input_dev *)_priv;
> +
> +	input_report_key(idev, KEY_POWER, 1);
> +	input_sync(idev);
> +	input_report_key(idev, KEY_POWER, 0);
> +	input_sync(idev);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int bd718xx_pwr_btn_probe(struct platform_device *pdev)
> +{
> +	int err = -ENOMEM;
> +	struct bd718xx_pwrkey *pk;
> +
> +	pk = devm_kzalloc(&pdev->dev, sizeof(*pk), GFP_KERNEL);
> +	if (!pk)
> +		goto err_out;
> +
> +	pk->mfd = dev_get_drvdata(pdev->dev.parent);
> +
> +	pk->idev = devm_input_allocate_device(&pdev->dev);
> +	if (!pk->idev)
> +		goto err_out;
> +
> +	pk->idev->name = "bd718xx-pwrkey";
> +	pk->idev->phys = "bd718xx-pwrkey/input0";
> +	pk->idev->dev.parent = &pdev->dev;
> +
> +	input_set_capability(pk->idev, EV_KEY, KEY_POWER);
> +
> +	err = platform_get_irq_byname(pdev, "pwr-btn-s");
> +	if (err < 0) {
> +		dev_err(&pdev->dev, "could not get power key interrupt\n");
> +		goto err_out;
> +	}
> +
> +	pk->irq = err;
> +	err = devm_request_threaded_irq(&pdev->dev, pk->irq, NULL, &button_irq,
> +					0, "bd718xx-pwrkey", pk);
> +	if (err)
> +		goto err_out;
> +
> +	platform_set_drvdata(pdev, pk);
> +	err = regmap_update_bits(pk->mfd->regmap,
> +				 BD71837_REG_PWRONCONFIG0,
> +				 BD718XX_PWRBTN_SHORT_PRESS_MASK,
> +				 BD718XX_PWRBTN_SHORT_PRESS_10MS);

This seems to be the only custom bit of set up in the driver, the rest I
think can easily be handled by gpio-keys.c in interrupt-only mode. Maybe
we could move this into MFD piece and drop this driver?

> +	if (err)
> +		goto err_out;
> +
> +	err = input_register_device(pk->idev);
> +
> +err_out:
> +
> +	return err;
> +}
> +
> +static struct platform_driver bd718xx_pwr_btn_driver = {
> +	.probe	= bd718xx_pwr_btn_probe,
> +	.driver = {
> +		.name	= "bd718xx-pwrkey",
> +	},
> +};
> +module_platform_driver(bd718xx_pwr_btn_driver);
> +MODULE_DESCRIPTION("Power button driver for buttons connected to ROHM bd71837/bd71847 PMIC");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +
> -- 
> 2.14.3
> 

Thanks.

-- 
Dmitry

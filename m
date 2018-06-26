Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C03C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312C5269C6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312C5269C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934544AbeFZLZD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:25:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34490 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeFZLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:25:01 -0400
Received: by mail-lf0-f65.google.com with SMTP id n96-v6so4982793lfi.1;
        Tue, 26 Jun 2018 04:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nVS4zsmUcHVS+5we8Rc/paBB+aF/715Tf7b/PUY853E=;
        b=K6BMvcvogja/6nYSjqOk+m/O+ge/F87CDJco0vvLAxtvrICKmEQ1JFSihGZeCWNSzP
         4UBIz6bGSRJe7c2APw2WcbnLQBc98esOp/iCwSpO8c4b+ewvqR/i8xcZpiG2DeUdbIp/
         3+unlySo3b/BGrPDmt0ASNRt/69s+DuGsk1l8itEMsgOHVcXJKQ/erZU6lYSlvWEVutk
         XkwDb/1xrQV1f9KEGvRs17Eatxt7Sj87oqDRSKkPAs+FOcONCwSFEgzgoCfqA5Hts6wP
         tuuYdMoo5CCth5+r5jD89aSGZy2l1CyQF0MoniKaVIG8gvnBEz9kyxHjKyU5/D82nIf1
         MibQ==
X-Gm-Message-State: APt69E0o9tZ5qXf59HGrW/jnD+y49QEmuqPoSlc63c9me+ZWXWOLf3DH
        FkneZR+1QYHu4f+hPHwtE6XBYRTF
X-Google-Smtp-Source: AAOMgpeRWCa73qMc1ZcCMhVOrcr9fguGFss0wJ1GDBmkEH3gRSaYz1KdPsEeGfn49DdpSklXxKa33g==
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr979954lfh.19.1530012298934;
        Tue, 26 Jun 2018 04:24:58 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 4-v6sm215870ljc.1.2018.06.26.04.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 04:24:58 -0700 (PDT)
Date:   Tue, 26 Jun 2018 14:24:55 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-clk@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180626112455.GC2118@localhost.localdomain>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

Thanks for the comments! I'll be addressing these in patch series v8
- except the regmap wrapper one which will be taken care of by another
patch set.

On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> Hi Matti,
> 
> Thanks for the patch, a few comments below, some are feedback I
> received when I sent some patches to this subsystem.
> 
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dt., 19 de juny 2018 a les 12:57:
> >
> > ROHM BD71837 PMIC MFD driver providing interrupts and support
> > for two subsystems:
> > - clk
> > - Regulators
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/mfd/Kconfig         |  13 ++
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/bd71837.c       | 221 ++++++++++++++++++++++++++
> >  include/linux/mfd/bd71837.h | 367 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 602 insertions(+)
> >  create mode 100644 drivers/mfd/bd71837.c
> >  create mode 100644 include/linux/mfd/bd71837.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index b860eb5aa194..7aa05fc9ed8e 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1787,6 +1787,19 @@ config MFD_STW481X
> >           in various ST Microelectronics and ST-Ericsson embedded
> >           Nomadik series.
> >
> > +config MFD_BD71837
> > +       bool "BD71837 Power Management chip"
> 
> I know that some drivers need to be built-in, is this really a
> requirement for this driver? Or should work as a module too.
> 

I have been writing power/reset driver for this PMIC. I thought that the
modules would be unload before reset hook is ran - which seems to be
not true on platform where I tested this. So you are correct, at least
on cases where reset is not used via PMIC - or where the platform is not
unloading modules prior reset - these drivers can indeed be modules. So
it is fair to allow building them as modules. Users who want to build
this in kernel can still do so. => I'll change this.

> > +       depends on I2C=y
> > +       depends on OF
> > +       select REGMAP_I2C
> > +       select REGMAP_IRQ
> > +       select MFD_CORE
> > +       help
> > +         Select this option to get support for the ROHM BD71837
> > +         Power Management chips. BD71837 is designed to power processors like
> > +         NXP i.MX8. It contains 8 BUCK outputs and 7 LDOs, voltage monitoring
> > +         and emergency shut down as well as 32,768KHz clock output.
> > +
> >  config MFD_STM32_LPTIMER
> >         tristate "Support for STM32 Low-Power Timer"
> >         depends on (ARCH_STM32 && OF) || COMPILE_TEST
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index e9fd20dba18d..09dc9eb3782c 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -227,4 +227,5 @@ obj-$(CONFIG_MFD_STM32_TIMERS)      += stm32-timers.o
> >  obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
> >  obj-$(CONFIG_MFD_SC27XX_PMIC)  += sprd-sc27xx-spi.o
> >  obj-$(CONFIG_RAVE_SP_CORE)     += rave-sp.o
> > +obj-$(CONFIG_MFD_BD71837)      += bd71837.o
> >
> > diff --git a/drivers/mfd/bd71837.c b/drivers/mfd/bd71837.c
> > new file mode 100644
> > index 000000000000..0f0361d6cad6
> > --- /dev/null
> > +++ b/drivers/mfd/bd71837.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> There is a mismatch between what SPDX says and MODULE_LICENSE says.
> 
> GPL-2.0 = GPL v2 only
> MODULE_LICENSE(GPL) = GPL v2 or later.
> 
>  You'd like to change the SPDX identifier to GPL-2.0-or-later or set
> module license to "GPL v2".

Right. Thanks for pointing that out.

> 
> > +// Copyright (C) 2018 ROHM Semiconductors
> > +// bd71837.c -- ROHM BD71837MWV mfd driver
> > +//
> > +// Datasheet available from
> > +// https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> > +
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> This include is not required.
> 
> > +#include <linux/init.h>
> > +#include <linux/slab.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> ditto
> 
> > +#include <linux/irqdomain.h>
> ditto
> 
> > +#include <linux/gpio.h>
> ditto
> 
> > +#include <linux/regmap.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> ditto
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/bd71837.h>
> > +
> 
> Please review the needed includes.

I'll do that, thanks.

> > +static const struct resource irqs[] = {
> > +       {
> > +               .start = BD71837_INT_PWRBTN,
> > +               .end = BD71837_INT_PWRBTN,
> > +               .flags = IORESOURCE_IRQ,
> > +               .name = "pwr-btn",
> > +       }, {
> > +               .start = BD71837_INT_PWRBTN_L,
> > +               .end = BD71837_INT_PWRBTN_L,
> > +               .flags = IORESOURCE_IRQ,
> > +               .name = "pwr-btn-l",
> > +       }, {
> > +               .start = BD71837_INT_PWRBTN_S,
> > +               .end = BD71837_INT_PWRBTN_S,
> > +               .flags = IORESOURCE_IRQ,
> > +               .name = "pwr-btn-s",
> > +       },
> 
> nit: no comma at the end

Whole struct will be removed. I will use gpio-keys and remove the
bd718xx-pwrkey driver as suggested by Dmitry Torokhov.

> > +};
> > +
> > +/* bd71837 multi function cells */
> > +static struct mfd_cell bd71837_mfd_cells[] = {
> > +       {
> > +               .name = "bd71837-clk",
> > +       }, {
> > +               .name = "bd718xx-pwrkey",
> > +               .resources = &irqs[0],
> > +               .num_resources = ARRAY_SIZE(irqs),
> > +       }, {
> > +               .name = "bd71837-pmic",
> > +       },
> nit: no comma at the end

Ok.

> > +};
> > +
> > +static const struct regmap_irq bd71837_irqs[] = {
> > +       REGMAP_IRQ_REG(BD71837_INT_SWRST, 0, BD71837_INT_SWRST_MASK),
> > +       REGMAP_IRQ_REG(BD71837_INT_PWRBTN_S, 0, BD71837_INT_PWRBTN_S_MASK),
> > +       REGMAP_IRQ_REG(BD71837_INT_PWRBTN_L, 0, BD71837_INT_PWRBTN_L_MASK),
> > +       REGMAP_IRQ_REG(BD71837_INT_PWRBTN, 0, BD71837_INT_PWRBTN_MASK),
> > +       REGMAP_IRQ_REG(BD71837_INT_WDOG, 0, BD71837_INT_WDOG_MASK),
> > +       REGMAP_IRQ_REG(BD71837_INT_ON_REQ, 0, BD71837_INT_ON_REQ_MASK),
> > +       REGMAP_IRQ_REG(BD71837_INT_STBY_REQ, 0, BD71837_INT_STBY_REQ_MASK),
> > +};
> > +
> > +static struct regmap_irq_chip bd71837_irq_chip = {
> > +       .name = "bd71837-irq",
> > +       .irqs = bd71837_irqs,
> > +       .num_irqs = ARRAY_SIZE(bd71837_irqs),
> > +       .num_regs = 1,
> > +       .irq_reg_stride = 1,
> > +       .status_base = BD71837_REG_IRQ,
> > +       .mask_base = BD71837_REG_MIRQ,
> > +       .ack_base = BD71837_REG_IRQ,
> > +       .init_ack_masked = true,
> > +       .mask_invert = false,
> > +};
> > +
> > +static int bd71837_irq_exit(struct bd71837 *bd71837)
> > +{
> > +       if (bd71837->chip_irq > 0)
> > +               regmap_del_irq_chip(bd71837->chip_irq, bd71837->irq_data);
> > +       return 0;
> > +}
> > +
> > +static const struct regmap_range pmic_status_range = {
> > +       .range_min = BD71837_REG_IRQ,
> > +       .range_max = BD71837_REG_POW_STATE,
> > +};
> > +
> > +static const struct regmap_access_table volatile_regs = {
> > +       .yes_ranges = &pmic_status_range,
> > +       .n_yes_ranges = 1,
> > +};
> > +
> > +static const struct regmap_config bd71837_regmap_config = {
> > +       .reg_bits = 8,
> > +       .val_bits = 8,
> > +       .volatile_table = &volatile_regs,
> > +       .max_register = BD71837_MAX_REGISTER - 1,
> > +       .cache_type = REGCACHE_RBTREE,
> > +};
> > +
> > +#ifdef CONFIG_OF
 
> The driver is DT-only and depends on OF so you don't need to protect this.
True. I'll remove this

> > +static const struct of_device_id bd71837_of_match[] = {
> > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > +       { },
> 
> nit: { /* sentinel */ }

I am sorry but I didn't quite get the point here. Could you please
explain what did you expect to be added here?

> > +};
> > +MODULE_DEVICE_TABLE(of, bd71837_of_match);
> > +#endif //CONFIG_OF
> > +
> > +static int bd71837_i2c_probe(struct i2c_client *i2c,
> > +                           const struct i2c_device_id *id)
> > +{
> > +       struct bd71837 *bd71837;
> > +       struct bd71837_board *board_info;
> > +       int ret = -EINVAL;
> > +
> > +       board_info = dev_get_platdata(&i2c->dev);
> > +
> > +       if (!board_info) {
> > +               board_info = devm_kzalloc(&i2c->dev, sizeof(*board_info),
> > +                                         GFP_KERNEL);
> > +               if (!board_info) {
> > +                       ret = -ENOMEM;
> > +                       goto err_out;
> > +               } else if (i2c->irq) {
> > +                       board_info->gpio_intr = i2c->irq;
> > +               } else {
> > +                       ret = -ENOENT;
> > +                       goto err_out;
> > +               }
> > +       }
> > +
> > +       if (!board_info)
> > +               goto err_out;
> > +
> > +       bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
> > +       if (bd71837 == NULL)
> > +               return -ENOMEM;
> > +
> > +       i2c_set_clientdata(i2c, bd71837);
> > +       bd71837->dev = &i2c->dev;
> > +       bd71837->i2c_client = i2c;
> > +       bd71837->chip_irq = board_info->gpio_intr;
> > +
> > +       bd71837->regmap = devm_regmap_init_i2c(i2c, &bd71837_regmap_config);
> > +       if (IS_ERR(bd71837->regmap)) {
> > +               ret = PTR_ERR(bd71837->regmap);
> > +               dev_err(&i2c->dev, "regmap initialization failed: %d\n", ret);
> > +               goto err_out;
> > +       }
> > +
> > +       ret = bd71837_reg_read(bd71837, BD71837_REG_REV);
> > +       if (ret < 0) {
> > +               dev_err(bd71837->dev,
> > +                       "%s(): Read BD71837_REG_DEVICE failed!\n", __func__);
> > +               goto err_out;
> > +       }
> > +
> > +       ret = regmap_add_irq_chip(bd71837->regmap, bd71837->chip_irq,
> > +               IRQF_ONESHOT, 0,
> > +               &bd71837_irq_chip, &bd71837->irq_data);
> 
> I think that you can use 'devm_regmap_add_irq_chip' here and remove
> the code to delete the irq chip

Right. Good point. Makes this lot leaner and cleaner.

> > +       if (ret < 0) {
> > +               dev_err(bd71837->dev, "Failed to add irq_chip %d\n", ret);
> > +               goto err_out;
> > +       }
> > +
> > +       ret = mfd_add_devices(bd71837->dev, PLATFORM_DEVID_AUTO,
> > +                             bd71837_mfd_cells, ARRAY_SIZE(bd71837_mfd_cells),
> > +                             NULL, 0,
> > +                             regmap_irq_get_domain(bd71837->irq_data));
> 
> Same here, I think you can use the devm_mfd_add_devices.

Right. Good point. Makes this lot leaner and cleaner.

> > +
> > +       return 0;
> > +}
> > +
> > +static const struct i2c_device_id bd71837_i2c_id[] = {
> > +       { .name = "bd71837", },
> > +       { }
> 
> nit: { /* sentinel */ }

I am sorry but I didn't quite get the point here. Could you please
explain what did you expect to be added here?
 
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bd71837_i2c_id);
> > +
> > +static struct i2c_driver bd71837_i2c_driver = {
> > +       .driver = {
> > +               .name = "bd71837-mfd",
> > +               .owner = THIS_MODULE,
> 
> Remove this, it is not needed, the core does it for you.

True. Thanks.

> > +               .of_match_table = of_match_ptr(bd71837_of_match),
>
> The driver is DT-only, don't need to call of_match_ptr.

Ok.

> > +       },
> > +       .probe = bd71837_i2c_probe,
> > +       .remove = bd71837_i2c_remove,
> > +       .id_table = bd71837_i2c_id,
> > +};
> > +
> > +static int __init bd71837_i2c_init(void)
> > +{
> > +       return i2c_add_driver(&bd71837_i2c_driver);
> > +}
> > +/* init early so consumer devices can complete system boot */
> > +subsys_initcall(bd71837_i2c_init);
> > +
> > +static void __exit bd71837_i2c_exit(void)
> > +{
> > +       i2c_del_driver(&bd71837_i2c_driver);
> > +}
> > +module_exit(bd71837_i2c_exit);
> > +
> 
> Can't you use module_i2c_driver here and get rid of init/exit calls?

I did this because of subsys_initcall() and how other drivers had used
that.

> > +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> > +MODULE_DESCRIPTION("BD71837 chip multi-function driver");
> > +MODULE_LICENSE("GPL");
> 
> License mismatch.

Thanks again

> > diff --git a/include/linux/mfd/bd71837.h b/include/linux/mfd/bd71837.h
> > new file mode 100644
> > index 000000000000..125c7478ec29
> > --- /dev/null
> > +++ b/include/linux/mfd/bd71837.h
> > @@ -0,0 +1,367 @@
> > +
> > +/* register write induced reset settings */
> 
> /* Register ...

Ok.

> > +
> > +/* even though the bit zero is not SWRESET type we still want to write zero
> 
> /*
>  * Even

Ok.

> > + * to it when changing type. Biz zero is 'SWRESET' trigger bit and if we
> 
> s/Biz/Bit/

Ok.

> > +/*
> > + * bd71837 sub-driver chip access routines
> > + */
> > +
> 
> All these access routines only hide the regmap_* calls, so why not use
> the regmap calls directly in the driver and remove all this?
 
This was also discussed with Stephen during the review for clk patches:
https://lore.kernel.org/lkml/152997029783.143105.16692843405899913246@swboyd.mtv.corp.google.com/

I will later send a new patch set which only removes these wrappers from
this MFD and also the submodules. I like to introduce that as a separate
change set after the whole driver is applied as it impacts to some already
applied parts. I don't want any mismatches which jump out as compile errors
when MFD gets applied and config dependencies get solved.

But yes, you are correct - the write/read to BD71837 is plain regmap access
and same simple access seems to be working with the BD71847 when it comes.
So these are not needed and will be removed.

Br,
	Matti Vaittinen

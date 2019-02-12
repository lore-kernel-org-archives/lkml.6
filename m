Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD27C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B9C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1ggGNRya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfBLIxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:53:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34093 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfBLIxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:53:09 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so1104797itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 00:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G0nU90RwDsfWZmCoy18n45kYZJGISsIrZa6kbcFKYl8=;
        b=1ggGNRyaAIkavmCpur87BqcTWA18z70wpaEzSs30Bv8UUOjLo9C6m5Tnl2sDQu6B2Y
         9RgkgasT7AcIDwx8z16SCt2I3hxNpmf8svFqyXb3LFJ7ptj/3L1qxU7K3UwXBLkF/d+Z
         l7+FWfaLhWuXDWo4jaNXRHytqOy6TGyZnmqe8siKIwPbzU+f7ndn8fhg/vnrpeR20R5O
         PvfiROA6+7IgdsJ7GdHy/vOEdHXoWZjWtnkswznzgr4cxho/O3BxbPrisgryYg5xPYQ9
         xaaiOWpSUwDNYncoJQETVChzP7q8jlkYzH00ygIPzSuXdcyCloLLBn2UqUtImEVY1eXm
         dCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G0nU90RwDsfWZmCoy18n45kYZJGISsIrZa6kbcFKYl8=;
        b=REmA336bwhDSBfy0H6y31R1jGcaGISB14bIjsv5r2M0s5I6EczzMXsLuLFnjfmePu6
         QJ50xplMLgDfzRpu/OzpFWfa996jl3JSIBKtQ4p9yEFTddDIHEpLgxjFrWTUIcUiYsBT
         x0HV2TU1KGI7+T1nH0KR9UynQaNFYrRZhz7dI2SUN/l6nZ97JlxM10yfyOXlOHv3LKCq
         hoOVNPBHrR0Ei2LyMPshvmSlCO5U0jQYGnCPBalM59xfU6tUgXtMJA6Wz/PnISkcANkW
         /t3636f8WZjBYV8TWs1c9yfUuskgAm89SHxWa3x9yw6pxCZz/rWOGtbW1j4LL2Z7Tllp
         HWSw==
X-Gm-Message-State: AHQUAubUoW5Q/xZcK1+iZKTXVmox2Gi1PW3NkDw8rUBmPZuyn6Zon59g
        4be/O5pkXhahmrLk3VsUAKGYkFa8GO2UR7RM0PUl0Q==
X-Google-Smtp-Source: AHgI3IZIs+W+zi233E6237eEtaPtZVV9hCS8qyjd7JuBpNdjNg03OdADmmrx8VyeluRCgP1wkNIWLe9l8GefmGvgJ9c=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr1407169ior.258.1549961587336;
 Tue, 12 Feb 2019 00:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20190205091237.6448-1-brgl@bgdev.pl> <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell>
In-Reply-To: <20190212083642.GT20638@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 09:52:56 +0100
Message-ID: <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 12 lut 2019 o 09:36 Lee Jones <lee.jones@linaro.org> napisa=C5=82(a):
>
> On Tue, 05 Feb 2019, Bartosz Golaszewski wrote:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the core mfd driver for max77650 PMIC. We define five sub-devices
> > for which the drivers will be added in subsequent patches.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/mfd/Kconfig          |  11 ++
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/max77650.c       | 342 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/max77650.h |  59 ++++++
> >  4 files changed, 413 insertions(+)
> >  create mode 100644 drivers/mfd/max77650.c
> >  create mode 100644 include/linux/mfd/max77650.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 76f9909cf396..a80c3fe80fbe 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -734,6 +734,17 @@ config MFD_MAX77620
> >         provides common support for accessing the device; additional dr=
ivers
> >         must be enabled in order to use the functionality of the device=
.
> >
> > +config MFD_MAX77650
> > +     tristate "Maxim MAX77650/77651 PMIC Support"
> > +     depends on I2C
> > +     depends on OF || COMPILE_TEST
> > +     select MFD_CORE
> > +     select REGMAP_I2C
> > +     help
> > +       Say yes here to add support for Maxim Semiconductor MAX77650 an=
d
> > +       MAX77651 Power Management ICs. This is the core multifunction
> > +       driver for interacting with the device.
> > +
> >  config MFD_MAX77686
> >       tristate "Maxim Semiconductor MAX77686/802 PMIC Support"
> >       depends on I2C
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 12980a4ad460..3b912a4015d1 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -151,6 +151,7 @@ obj-$(CONFIG_MFD_DA9150)  +=3D da9150-core.o
> >
> >  obj-$(CONFIG_MFD_MAX14577)   +=3D max14577.o
> >  obj-$(CONFIG_MFD_MAX77620)   +=3D max77620.o
> > +obj-$(CONFIG_MFD_MAX77650)   +=3D max77650.o
> >  obj-$(CONFIG_MFD_MAX77686)   +=3D max77686.o
> >  obj-$(CONFIG_MFD_MAX77693)   +=3D max77693.o
> >  obj-$(CONFIG_MFD_MAX77843)   +=3D max77843.o
> > diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
> > new file mode 100644
> > index 000000000000..7c6164f1fde4
> > --- /dev/null
> > +++ b/drivers/mfd/max77650.c
> > @@ -0,0 +1,342 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (C) 2018 BayLibre SAS
> > +// Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > +//
> > +// Core MFD driver for MAXIM 77650/77651 charger/power-supply.
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/max77650.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#define MAX77650_INT_GPI_F_MSK               BIT(0)
> > +#define MAX77650_INT_GPI_R_MSK               BIT(1)
> > +#define MAX77650_INT_GPI_MSK \
> > +                     (MAX77650_INT_GPI_F_MSK | MAX77650_INT_GPI_R_MSK)
> > +#define MAX77650_INT_nEN_F_MSK               BIT(2)
> > +#define MAX77650_INT_nEN_R_MSK               BIT(3)
> > +#define MAX77650_INT_TJAL1_R_MSK     BIT(4)
> > +#define MAX77650_INT_TJAL2_R_MSK     BIT(5)
> > +#define MAX77650_INT_DOD_R_MSK               BIT(6)
> > +
> > +#define MAX77650_INT_THM_MSK         BIT(0)
> > +#define MAX77650_INT_CHG_MSK         BIT(1)
> > +#define MAX77650_INT_CHGIN_MSK               BIT(2)
> > +#define MAX77650_INT_TJ_REG_MSK              BIT(3)
> > +#define MAX77650_INT_CHGIN_CTRL_MSK  BIT(4)
> > +#define MAX77650_INT_SYS_CTRL_MSK    BIT(5)
> > +#define MAX77650_INT_SYS_CNFG_MSK    BIT(6)
> > +
> > +#define MAX77650_INT_GLBL_OFFSET     0
> > +#define MAX77650_INT_CHG_OFFSET              1
> > +
> > +#define MAX77650_SBIA_LPM_MASK               BIT(5)
> > +#define MAX77650_SBIA_LPM_DISABLED   0x00
> > +
> > +enum {
> > +     MAX77650_INT_GPI =3D 0,
> > +     MAX77650_INT_nEN_F,
> > +     MAX77650_INT_nEN_R,
> > +     MAX77650_INT_TJAL1_R,
> > +     MAX77650_INT_TJAL2_R,
> > +     MAX77650_INT_DOD_R,
> > +     MAX77650_INT_THM,
> > +     MAX77650_INT_CHG,
> > +     MAX77650_INT_CHGIN,
> > +     MAX77650_INT_TJ_REG,
> > +     MAX77650_INT_CHGIN_CTRL,
> > +     MAX77650_INT_SYS_CTRL,
> > +     MAX77650_INT_SYS_CNFG,
> > +};
> > +
> > +enum {
> > +     MAX77650_CELL_REGULATOR =3D 0,
> > +     MAX77650_CELL_CHARGER,
> > +     MAX77650_CELL_GPIO,
> > +     MAX77650_CELL_LED,
> > +     MAX77650_CELL_ONKEY,
> > +     MAX77650_NUM_CELLS,
> > +};
> > +
> > +struct max77650_irq_mapping {
> > +     int cell_num;
> > +     const int *irqs;
> > +     const char *const *irq_names;
> > +     unsigned int num_irqs;
> > +};
> > +
> > +static const int max77650_charger_irqs[] =3D {
> > +     MAX77650_INT_CHG,
> > +     MAX77650_INT_CHGIN,
> > +};
> > +
> > +static const int max77650_gpio_irqs[] =3D {
> > +     MAX77650_INT_GPI,
> > +};
> > +
> > +static const int max77650_onkey_irqs[] =3D {
> > +     MAX77650_INT_nEN_F,
> > +     MAX77650_INT_nEN_R,
> > +};
> > +
> > +static const char *const max77650_charger_irq_names[] =3D {
> > +     "CHG",
> > +     "CHGIN",
> > +};
> > +
> > +static const char *const max77650_gpio_irq_names[] =3D {
> > +     "GPI",
> > +};
> > +
> > +static const char *const max77650_onkey_irq_names[] =3D {
> > +     "nEN_F",
> > +     "nEN_R",
> > +};
> > +
> > +static const struct max77650_irq_mapping max77650_irq_mapping_table[] =
=3D {
> > +     {
> > +             .cell_num       =3D MAX77650_CELL_CHARGER,
> > +             .irqs           =3D max77650_charger_irqs,
> > +             .irq_names      =3D max77650_charger_irq_names,
> > +             .num_irqs       =3D ARRAY_SIZE(max77650_charger_irqs),
> > +     },
> > +     {
> > +             .cell_num       =3D MAX77650_CELL_GPIO,
> > +             .irqs           =3D max77650_gpio_irqs,
> > +             .irq_names      =3D max77650_gpio_irq_names,
> > +             .num_irqs       =3D ARRAY_SIZE(max77650_gpio_irqs),
> > +     },
> > +     {
> > +             .cell_num       =3D MAX77650_CELL_ONKEY,
> > +             .irqs           =3D max77650_onkey_irqs,
> > +             .irq_names      =3D max77650_onkey_irq_names,
> > +             .num_irqs       =3D ARRAY_SIZE(max77650_onkey_irqs),
> > +     },
> > +};
>
> This is all a bit convoluted and nasty TBH.
>
> > +static const struct mfd_cell max77650_cells[] =3D {
> > +     [MAX77650_CELL_REGULATOR] =3D {
> > +             .name           =3D "max77650-regulator",
> > +             .of_compatible  =3D "maxim,max77650-regulator",
> > +     },
> > +     [MAX77650_CELL_CHARGER] =3D {
> > +             .name           =3D "max77650-charger",
> > +             .of_compatible  =3D "maxim,max77650-charger",
> > +     },
> > +     [MAX77650_CELL_GPIO] =3D {
> > +             .name           =3D "max77650-gpio",
> > +             .of_compatible  =3D "maxim,max77650-gpio",
> > +     },
> > +     [MAX77650_CELL_LED] =3D {
> > +             .name           =3D "max77650-led",
> > +             .of_compatible  =3D "maxim,max77650-led",
> > +     },
> > +     [MAX77650_CELL_ONKEY] =3D {
> > +             .name           =3D "max77650-onkey",
> > +             .of_compatible  =3D "maxim,max77650-onkey",
> > +     },
> > +};
>
> Why are you numbering the cells?  There is no need to do this.
>

Just for better readability. It makes sense to me coupled with
MAX77650_NUM_CELLS.

> > +static const struct regmap_irq max77650_irqs[] =3D {
> > +     [MAX77650_INT_GPI] =3D {
> > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > +             .mask                   =3D MAX77650_INT_GPI_MSK,
> > +             .type =3D {
> > +                     .type_falling_val       =3D MAX77650_INT_GPI_F_MS=
K,
> > +                     .type_rising_val        =3D MAX77650_INT_GPI_R_MS=
K,
> > +                     .types_supported        =3D IRQ_TYPE_EDGE_BOTH,
> > +             },
> > +     },
> > +     [MAX77650_INT_nEN_F] =3D {
> > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > +             .mask                   =3D MAX77650_INT_nEN_F_MSK,
> > +     },
> > +     [MAX77650_INT_nEN_R] =3D {
> > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > +             .mask                   =3D MAX77650_INT_nEN_R_MSK,
> > +     },
> > +     [MAX77650_INT_TJAL1_R] =3D {
> > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > +             .mask                   =3D MAX77650_INT_TJAL1_R_MSK,
> > +     },
> > +     [MAX77650_INT_TJAL2_R] =3D {
> > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > +             .mask                   =3D MAX77650_INT_TJAL2_R_MSK,
> > +     },
> > +     [MAX77650_INT_DOD_R] =3D {
> > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > +             .mask                   =3D MAX77650_INT_DOD_R_MSK,
> > +     },
> > +     [MAX77650_INT_THM] =3D {
> > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > +             .mask                   =3D MAX77650_INT_THM_MSK,
> > +     },
> > +     [MAX77650_INT_CHG] =3D {
> > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > +             .mask                   =3D MAX77650_INT_CHG_MSK,
> > +     },
> > +     [MAX77650_INT_CHGIN] =3D {
> > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > +             .mask                   =3D MAX77650_INT_CHGIN_MSK,
> > +     },
> > +     [MAX77650_INT_TJ_REG] =3D {
> > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > +             .mask                   =3D MAX77650_INT_TJ_REG_MSK,
> > +     },
> > +     [MAX77650_INT_CHGIN_CTRL] =3D {
> > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > +             .mask                   =3D MAX77650_INT_CHGIN_CTRL_MSK,
> > +     },
> > +     [MAX77650_INT_SYS_CTRL] =3D {
> > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > +             .mask                   =3D MAX77650_INT_SYS_CTRL_MSK,
> > +     },
> > +     [MAX77650_INT_SYS_CNFG] =3D {
> > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > +             .mask                   =3D MAX77650_INT_SYS_CNFG_MSK,
> > +     },
> > +};
>
> If you get rid of all of the horrible hoop jumping in *_setup_irqs(),
> you can use REGMAP_IRQ_REG() like everyone else does.
>

I could even use it now - except for the first interrupt. I decided to
not use it everywhere as it looks much better that way than having
REGMAP_IRQ_REG() for all definitions and then the first one sticking
out like that. It just looks better.

> > +static const struct regmap_irq_chip max77650_irq_chip =3D {
> > +     .name                   =3D "max77650-irq",
> > +     .irqs                   =3D max77650_irqs,
> > +     .num_irqs               =3D ARRAY_SIZE(max77650_irqs),
> > +     .num_regs               =3D 2,
> > +     .status_base            =3D MAX77650_REG_INT_GLBL,
> > +     .mask_base              =3D MAX77650_REG_INTM_GLBL,
> > +     .type_in_mask           =3D true,
> > +     .type_invert            =3D true,
> > +     .init_ack_masked        =3D true,
> > +     .clear_on_unmask        =3D true,
> > +};
> > +
> > +static const struct regmap_config max77650_regmap_config =3D {
> > +     .name           =3D "max77650",
> > +     .reg_bits       =3D 8,
> > +     .val_bits       =3D 8,
> > +};
> > +
> > +static int max77650_setup_irqs(struct device *dev, struct mfd_cell *ce=
lls)
> > +{
> > +     const struct max77650_irq_mapping *mapping;
> > +     struct regmap_irq_chip_data *irq_data;
> > +     struct i2c_client *i2c;
> > +     struct mfd_cell *cell;
> > +     struct resource *res;
> > +     struct regmap *map;
> > +     int i, j, irq, rv;
> > +
> > +     i2c =3D to_i2c_client(dev);
> > +
> > +     map =3D dev_get_regmap(dev, NULL);
> > +     if (!map)
> > +             return -ENODEV;
> > +
> > +     rv =3D devm_regmap_add_irq_chip(dev, map, i2c->irq,
> > +                                   IRQF_ONESHOT | IRQF_SHARED, -1,
>
> What is -1?  Are you sure this isn't defined somewhere?
>

I don't see any define for negative irq_base argument. I can add that
in a separate series and convert the users, but for now I'd stick with
-1.

> > +                                   &max77650_irq_chip, &irq_data);
> > +     if (rv)
> > +             return rv;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(max77650_irq_mapping_table); i++) {
> > +             mapping =3D &max77650_irq_mapping_table[i];
> > +             cell =3D &cells[mapping->cell_num];
> > +
> > +             res =3D devm_kcalloc(dev, sizeof(*res),
> > +                                mapping->num_irqs, GFP_KERNEL);
> > +             if (!res)
> > +                     return -ENOMEM;
> > +
> > +             cell->resources =3D res;
> > +             cell->num_resources =3D mapping->num_irqs;
> > +
> > +             for (j =3D 0; j < mapping->num_irqs; j++) {
> > +                     irq =3D regmap_irq_get_virq(irq_data, mapping->ir=
qs[j]);
> > +                     if (irq < 0)
> > +                             return irq;
> > +
> > +                     res[j].start =3D res[j].end =3D irq;
> > +                     res[j].flags =3D IORESOURCE_IRQ;
> > +                     res[j].name =3D mapping->irq_names[j];
> > +             }
> > +     }
>
> This is the first time I've seen it done like this (and I hate it).
>
> Why are you storing the virqs in resources?
>
> I think this is highly irregular.
>

I initially just passed the regmap_irq_chip_data over i2c clientdata
and sub-drivers would look up virq numbers from it but was advised by
Dmitry Torokhov to use resources instead. After implementing it this
way I too think it's more elegant in sub-drivers who can simply do
platform_get_irq_byname(). Do you have a different idea? What exactly
don't you like about this?

> > +     return 0;
> > +}
> > +
> > +static int max77650_i2c_probe(struct i2c_client *i2c)
> > +{
> > +     struct device *dev =3D &i2c->dev;
> > +     struct mfd_cell *cells;
> > +     struct regmap *map;
> > +     unsigned int val;
> > +     int rv;
> > +
> > +     map =3D devm_regmap_init_i2c(i2c, &max77650_regmap_config);
> > +     if (IS_ERR(map))
>
> What error messages does devm_regmap_init_i2c() report?  Does it print
> out its own error messages internally?  If not it would be better to
> provide a suitable error message here.
>
> > +             return PTR_ERR(map);
> > +
> > +     rv =3D regmap_read(map, MAX77650_REG_CID, &val);
> > +     if (rv)
>
> Better to provide a suitable error message here.
>
> > +             return rv;
> > +
> > +     switch (MAX77650_CID_BITS(val)) {
> > +     case MAX77650_CID_77650A:
> > +     case MAX77650_CID_77650C:
> > +     case MAX77650_CID_77651A:
> > +     case MAX77650_CID_77651B:
> > +             break;
> > +     default:
>
> Better to provide a suitable error message here.
>
> > +             return -ENODEV;
> > +     }
> > +
> > +     /*
> > +      * This IC has a low-power mode which reduces the quiescent curre=
nt
> > +      * consumption to ~5.6uA but is only suitable for systems consumi=
ng
> > +      * less than ~2mA. Since this is not likely the case even on
> > +      * linux-based wearables - keep the chip in normal power mode.
> > +      */
> > +     rv =3D regmap_update_bits(map,
> > +                             MAX77650_REG_CNFG_GLBL,
> > +                             MAX77650_SBIA_LPM_MASK,
> > +                             MAX77650_SBIA_LPM_DISABLED);
> > +     if (rv)
>
> Better to provide a suitable error message here.
>
> > +             return rv;
> > +
> > +     cells =3D devm_kmemdup(dev, max77650_cells,
> > +                          sizeof(max77650_cells), GFP_KERNEL);
> > +     if (!cells)
> > +             return -ENOMEM;
> > +
> > +     rv =3D max77650_setup_irqs(dev, cells);
> > +     if (rv)
> > +             return rv;
> > +
> > +     return devm_mfd_add_devices(dev, -1, cells,
>
> Use the correct defines instead of -1.
>

Will do that and add the error messages.

Bart

> `git grep mfd_add_devices`
>
> > +                                 MAX77650_NUM_CELLS, NULL, 0, NULL);
> > +}
> > +
> > +static const struct of_device_id max77650_of_match[] =3D {
> > +     { .compatible =3D "maxim,max77650" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, max77650_of_match);
> > +
> > +static struct i2c_driver max77650_i2c_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "max77650",
> > +             .of_match_table =3D of_match_ptr(max77650_of_match),
> > +     },
> > +     .probe_new =3D max77650_i2c_probe,
> > +};
> > +module_i2c_driver(max77650_i2c_driver);
> > +
> > +MODULE_DESCRIPTION("MAXIM 77650/77651 multi-function core driver");
> > +MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/linux/mfd/max77650.h b/include/linux/mfd/max77650.=
h
> > new file mode 100644
> > index 000000000000..c809e211a8cd
> > --- /dev/null
> > +++ b/include/linux/mfd/max77650.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2018 BayLibre SAS
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + *
> > + * Common definitions for MAXIM 77650/77651 charger/power-supply.
> > + */
> > +
> > +#ifndef MAX77650_H
> > +#define MAX77650_H
> > +
> > +#include <linux/bits.h>
> > +
> > +#define MAX77650_REG_INT_GLBL                0x00
> > +#define MAX77650_REG_INT_CHG         0x01
> > +#define MAX77650_REG_STAT_CHG_A              0x02
> > +#define MAX77650_REG_STAT_CHG_B              0x03
> > +#define MAX77650_REG_ERCFLAG         0x04
> > +#define MAX77650_REG_STAT_GLBL               0x05
> > +#define MAX77650_REG_INTM_GLBL               0x06
> > +#define MAX77650_REG_INTM_CHG                0x07
> > +#define MAX77650_REG_CNFG_GLBL               0x10
> > +#define MAX77650_REG_CID             0x11
> > +#define MAX77650_REG_CNFG_GPIO               0x12
> > +#define MAX77650_REG_CNFG_CHG_A              0x18
> > +#define MAX77650_REG_CNFG_CHG_B              0x19
> > +#define MAX77650_REG_CNFG_CHG_C              0x1a
> > +#define MAX77650_REG_CNFG_CHG_D              0x1b
> > +#define MAX77650_REG_CNFG_CHG_E              0x1c
> > +#define MAX77650_REG_CNFG_CHG_F              0x1d
> > +#define MAX77650_REG_CNFG_CHG_G              0x1e
> > +#define MAX77650_REG_CNFG_CHG_H              0x1f
> > +#define MAX77650_REG_CNFG_CHG_I              0x20
> > +#define MAX77650_REG_CNFG_SBB_TOP    0x28
> > +#define MAX77650_REG_CNFG_SBB0_A     0x29
> > +#define MAX77650_REG_CNFG_SBB0_B     0x2a
> > +#define MAX77650_REG_CNFG_SBB1_A     0x2b
> > +#define MAX77650_REG_CNFG_SBB1_B     0x2c
> > +#define MAX77650_REG_CNFG_SBB2_A     0x2d
> > +#define MAX77650_REG_CNFG_SBB2_B     0x2e
> > +#define MAX77650_REG_CNFG_LDO_A              0x38
> > +#define MAX77650_REG_CNFG_LDO_B              0x39
> > +#define MAX77650_REG_CNFG_LED0_A     0x40
> > +#define MAX77650_REG_CNFG_LED1_A     0x41
> > +#define MAX77650_REG_CNFG_LED2_A     0x42
> > +#define MAX77650_REG_CNFG_LED0_B     0x43
> > +#define MAX77650_REG_CNFG_LED1_B     0x44
> > +#define MAX77650_REG_CNFG_LED2_B     0x45
> > +#define MAX77650_REG_CNFG_LED_TOP    0x46
> > +
> > +#define MAX77650_CID_MASK            GENMASK(3, 0)
> > +#define MAX77650_CID_BITS(_reg)              (_reg & MAX77650_CID_MASK=
)
> > +
> > +#define MAX77650_CID_77650A          0x03
> > +#define MAX77650_CID_77650C          0x0a
> > +#define MAX77650_CID_77651A          0x06
> > +#define MAX77650_CID_77651B          0x08
> > +
> > +#endif /* MAX77650_H */
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

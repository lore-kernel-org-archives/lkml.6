Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2057FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D498A2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nhDy/PSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfBLKMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:12:16 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39208 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfBLKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:12:15 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so6111344itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DY0RmzdwwJFYb2isGEJCNGhBwpK4eMqsvncOB02fpeA=;
        b=nhDy/PSUBZ6ES5h7kSCQlqQL5iQ3G/sgsVAA6ciEHIOxnkskT7Q9wNET6+0BNsoXww
         bVpBZuAKTmVcP7PuVDjeuR3KYbyWlV6TKxojKJDc6tbIsXcoK2koYt1+877yGXj/6YE1
         RJeIxvt+naC0nFBD4RoT0go9MaaxEVhupSKbHUFhk4WKLiUNj+lTkVQKuteiXI03YgGd
         1+9WatJes7T9x73+3j6a2nOdaecChhSaE2ZVFcNbSQvrieQVMoYXS7qyZeXQ+3ByMsvj
         IwG3OQOBgX/TbZjl81hGAkQwpQfZZ9I/KNp0jj40traT8t1gTLi44MgZb5mntErXLokG
         6Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DY0RmzdwwJFYb2isGEJCNGhBwpK4eMqsvncOB02fpeA=;
        b=YUmRehJ8lwqCGVtEX9ALwKyyxP7I6zZJ/o3bij6OBgh0ncRD7Lqny549QkgTWJMubl
         HfliyMQlrbk9J/+/7bBvoJYNfemMGjdL7o91pH9bsiENCL+jhZLHPfa7k3ZNkos3MR0y
         cp0EXlaRntkNeF5IV9w3nSzw+hw/1TdOe//CIYGqmZKdFEt4JFoACrQZglCCLRUHFNih
         UueHLSHxjIz4yfNpY6AWwaoWXMmVItEd2nBGzqKQ7NgqTyyvmH84Jir18LMcEdG8GUkN
         CwfmZeDfV+GRQ3c46fYpvs6r25KlG8oDTaKnBNXKXfD5L9m6smQtHXVOzhppjHKvLE2Y
         klZg==
X-Gm-Message-State: AHQUAuarlotyMu6l/4POf2CbTyY4PJorRQbxgIoGOE8mJwjZbN6KrXNT
        aCpgXLHKl4t0fo3VDHgKgTBkwA8hk1mgBQ2q6cx8Cg==
X-Google-Smtp-Source: AHgI3IaYEuCqR2vp/A0SsVxgZ8XuMSvX9RAyCYh75NEUrj0bAeDc713A8ayGV+qPEpMFGw0gc3lOlyfHtJIyLru48uE=
X-Received: by 2002:a02:a901:: with SMTP id n1mr1615706jam.136.1549966332883;
 Tue, 12 Feb 2019 02:12:12 -0800 (PST)
MIME-Version: 1.0
References: <20190205091237.6448-1-brgl@bgdev.pl> <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell> <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell>
In-Reply-To: <20190212095457.GA20638@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Feb 2019 11:12:02 +0100
Message-ID: <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
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

wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisa=C5=82(a):
>
> On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
>
> > wt., 12 lut 2019 o 09:36 Lee Jones <lee.jones@linaro.org> napisa=C5=82(=
a):
> > >
> > > On Tue, 05 Feb 2019, Bartosz Golaszewski wrote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Add the core mfd driver for max77650 PMIC. We define five sub-devic=
es
> > > > for which the drivers will be added in subsequent patches.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  drivers/mfd/Kconfig          |  11 ++
> > > >  drivers/mfd/Makefile         |   1 +
> > > >  drivers/mfd/max77650.c       | 342 +++++++++++++++++++++++++++++++=
++++
> > > >  include/linux/mfd/max77650.h |  59 ++++++
> > > >  4 files changed, 413 insertions(+)
> > > >  create mode 100644 drivers/mfd/max77650.c
> > > >  create mode 100644 include/linux/mfd/max77650.h
>
> [...]
>
> > > > +static const struct max77650_irq_mapping max77650_irq_mapping_tabl=
e[] =3D {
> > > > +     {
> > > > +             .cell_num       =3D MAX77650_CELL_CHARGER,
> > > > +             .irqs           =3D max77650_charger_irqs,
> > > > +             .irq_names      =3D max77650_charger_irq_names,
> > > > +             .num_irqs       =3D ARRAY_SIZE(max77650_charger_irqs)=
,
> > > > +     },
> > > > +     {
> > > > +             .cell_num       =3D MAX77650_CELL_GPIO,
> > > > +             .irqs           =3D max77650_gpio_irqs,
> > > > +             .irq_names      =3D max77650_gpio_irq_names,
> > > > +             .num_irqs       =3D ARRAY_SIZE(max77650_gpio_irqs),
> > > > +     },
> > > > +     {
> > > > +             .cell_num       =3D MAX77650_CELL_ONKEY,
> > > > +             .irqs           =3D max77650_onkey_irqs,
> > > > +             .irq_names      =3D max77650_onkey_irq_names,
> > > > +             .num_irqs       =3D ARRAY_SIZE(max77650_onkey_irqs),
> > > > +     },
> > > > +};
> > >
> > > This is all a bit convoluted and nasty TBH.
> > >
> > > > +static const struct mfd_cell max77650_cells[] =3D {
> > > > +     [MAX77650_CELL_REGULATOR] =3D {
> > > > +             .name           =3D "max77650-regulator",
> > > > +             .of_compatible  =3D "maxim,max77650-regulator",
> > > > +     },
> > > > +     [MAX77650_CELL_CHARGER] =3D {
> > > > +             .name           =3D "max77650-charger",
> > > > +             .of_compatible  =3D "maxim,max77650-charger",
> > > > +     },
> > > > +     [MAX77650_CELL_GPIO] =3D {
> > > > +             .name           =3D "max77650-gpio",
> > > > +             .of_compatible  =3D "maxim,max77650-gpio",
> > > > +     },
> > > > +     [MAX77650_CELL_LED] =3D {
> > > > +             .name           =3D "max77650-led",
> > > > +             .of_compatible  =3D "maxim,max77650-led",
> > > > +     },
> > > > +     [MAX77650_CELL_ONKEY] =3D {
> > > > +             .name           =3D "max77650-onkey",
> > > > +             .of_compatible  =3D "maxim,max77650-onkey",
> > > > +     },
> > > > +};
> > >
> > > Why are you numbering the cells?  There is no need to do this.
> > >
> >
> > Just for better readability. It makes sense to me coupled with
> > MAX77650_NUM_CELLS.
>
> You have it the wrong way around.  You define the cell data, then
> provide the number of them using ARRAY_SIZE().  The enum containing
> MAX77650_NUM_CELLS should not exist.
>
> > > > +static const struct regmap_irq max77650_irqs[] =3D {
> > > > +     [MAX77650_INT_GPI] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_GPI_MSK,
> > > > +             .type =3D {
> > > > +                     .type_falling_val       =3D MAX77650_INT_GPI_=
F_MSK,
> > > > +                     .type_rising_val        =3D MAX77650_INT_GPI_=
R_MSK,
> > > > +                     .types_supported        =3D IRQ_TYPE_EDGE_BOT=
H,
> > > > +             },
> > > > +     },
> > > > +     [MAX77650_INT_nEN_F] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_nEN_F_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_nEN_R] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_nEN_R_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_TJAL1_R] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_TJAL1_R_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_TJAL2_R] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_TJAL2_R_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_DOD_R] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_GLBL_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_DOD_R_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_THM] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_THM_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_CHG] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_CHG_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_CHGIN] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_CHGIN_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_TJ_REG] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_TJ_REG_MSK,
> > > > +     },
> > > > +     [MAX77650_INT_CHGIN_CTRL] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_CHGIN_CTRL_M=
SK,
> > > > +     },
> > > > +     [MAX77650_INT_SYS_CTRL] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_SYS_CTRL_MSK=
,
> > > > +     },
> > > > +     [MAX77650_INT_SYS_CNFG] =3D {
> > > > +             .reg_offset             =3D MAX77650_INT_CHG_OFFSET,
> > > > +             .mask                   =3D MAX77650_INT_SYS_CNFG_MSK=
,
> > > > +     },
> > > > +};
> > >
> > > If you get rid of all of the horrible hoop jumping in *_setup_irqs(),
> > > you can use REGMAP_IRQ_REG() like everyone else does.
> > >
> >
> > I could even use it now - except for the first interrupt. I decided to
> > not use it everywhere as it looks much better that way than having
> > REGMAP_IRQ_REG() for all definitions and then the first one sticking
> > out like that. It just looks better.
>
> The way it's done at the moment looks terrible.
>
> Please use the MACROs to simplify as much of the code as possible.
>
> > > > +static const struct regmap_irq_chip max77650_irq_chip =3D {
> > > > +     .name                   =3D "max77650-irq",
> > > > +     .irqs                   =3D max77650_irqs,
> > > > +     .num_irqs               =3D ARRAY_SIZE(max77650_irqs),
> > > > +     .num_regs               =3D 2,
> > > > +     .status_base            =3D MAX77650_REG_INT_GLBL,
> > > > +     .mask_base              =3D MAX77650_REG_INTM_GLBL,
> > > > +     .type_in_mask           =3D true,
> > > > +     .type_invert            =3D true,
> > > > +     .init_ack_masked        =3D true,
> > > > +     .clear_on_unmask        =3D true,
> > > > +};
> > > > +
> > > > +static const struct regmap_config max77650_regmap_config =3D {
> > > > +     .name           =3D "max77650",
> > > > +     .reg_bits       =3D 8,
> > > > +     .val_bits       =3D 8,
> > > > +};
> > > > +
> > > > +static int max77650_setup_irqs(struct device *dev, struct mfd_cell=
 *cells)
> > > > +{
> > > > +     const struct max77650_irq_mapping *mapping;
> > > > +     struct regmap_irq_chip_data *irq_data;
> > > > +     struct i2c_client *i2c;
> > > > +     struct mfd_cell *cell;
> > > > +     struct resource *res;
> > > > +     struct regmap *map;
> > > > +     int i, j, irq, rv;
> > > > +
> > > > +     i2c =3D to_i2c_client(dev);
> > > > +
> > > > +     map =3D dev_get_regmap(dev, NULL);
> > > > +     if (!map)
> > > > +             return -ENODEV;
> > > > +
> > > > +     rv =3D devm_regmap_add_irq_chip(dev, map, i2c->irq,
> > > > +                                   IRQF_ONESHOT | IRQF_SHARED, -1,
> > >
> > > What is -1?  Are you sure this isn't defined somewhere?
> > >
> >
> > I don't see any define for negative irq_base argument. I can add that
> > in a separate series and convert the users, but for now I'd stick with
> > -1.
>
> IMO it should be defined.  You can define it locally for now.
>
> > > > +                                   &max77650_irq_chip, &irq_data);
> > > > +     if (rv)
> > > > +             return rv;
> > > > +
> > > > +     for (i =3D 0; i < ARRAY_SIZE(max77650_irq_mapping_table); i++=
) {
> > > > +             mapping =3D &max77650_irq_mapping_table[i];
> > > > +             cell =3D &cells[mapping->cell_num];
> > > > +
> > > > +             res =3D devm_kcalloc(dev, sizeof(*res),
> > > > +                                mapping->num_irqs, GFP_KERNEL);
> > > > +             if (!res)
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             cell->resources =3D res;
> > > > +             cell->num_resources =3D mapping->num_irqs;
> > > > +
> > > > +             for (j =3D 0; j < mapping->num_irqs; j++) {
> > > > +                     irq =3D regmap_irq_get_virq(irq_data, mapping=
->irqs[j]);
> > > > +                     if (irq < 0)
> > > > +                             return irq;
> > > > +
> > > > +                     res[j].start =3D res[j].end =3D irq;
> > > > +                     res[j].flags =3D IORESOURCE_IRQ;
> > > > +                     res[j].name =3D mapping->irq_names[j];
> > > > +             }
> > > > +     }
> > >
> > > This is the first time I've seen it done like this (and I hate it).
> > >
> > > Why are you storing the virqs in resources?
> > >
> > > I think this is highly irregular.
> > >
> >
> > I initially just passed the regmap_irq_chip_data over i2c clientdata
> > and sub-drivers would look up virq numbers from it but was advised by
> > Dmitry Torokhov to use resources instead. After implementing it this
> > way I too think it's more elegant in sub-drivers who can simply do
> > platform_get_irq_byname(). Do you have a different idea?
>
> > What exactly don't you like about this?
>
>  * The declaration of a superfluous struct
>  * 100 lines of additional/avoidable code
>  * Hacky hoop jumping trying to fudge VIRQs into resources
>  * Resources were designed for HWIRQs (unless a domain is present)
>  * Loads of additional/avoidable CPU cycles setting all this up

While the above may be right, this one is negligible and you know it. :)

>
> Need I go on? :)
>
> Surely the fact that you are using both sides of an API
> (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> set some alarm bells ringing?
>
> This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
>
> And for what?  To avoid passing IRQ data to a child driver?
>

What do you propose? Should I go back to the approach in v1 and pass
the regmap_irq_chip_data to child drivers?

@Dmitry: what do you think?

Bart

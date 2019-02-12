Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A960C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3035D20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7NEBR1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfBLJzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:55:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37692 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbfBLJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:55:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so2266858wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9/JJ9ae0d5/YczKxgYKSREDE8DEXAJJcn7ck/lIO3Rk=;
        b=A7NEBR1QQCi+mYN7u99VCeqUAe47AluO4mslEDVIkjtP4/T7JJu5nkKOf8MU1TWqD1
         62Kah/edNsYtw3SourR2wYFlJZm+FTybS7hDgq4IdkZPugVeyVrFgJwj+gIhLvCD8+E9
         TtQhWcqrJ6N/5NqGpBWxhGFKOLz8Ujf14e3H4/a3rBqzvnNKVn0Xq8hE7cjbdSYvj9jO
         GgR0Q7sQYxswS1unAsNZRuft2MbGPzAHLm5K0mkwg9ZpY6W0J1qUeHpcEIu09PgMie00
         XmUUiOsz2ixyxVfkzxEsLKy4GlG+JdqrtK0JPR0mAFA+/sj83MGMjM0XhbGS6OwSSRSY
         tlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9/JJ9ae0d5/YczKxgYKSREDE8DEXAJJcn7ck/lIO3Rk=;
        b=tj0H/PN6Rj2yxLFoWyDt++2f6ldS/USQOmHmdW7lC4H9k4U07teaHhvgGwJS/ofnZ3
         7vO/oTNvh32e1FGsKzjfRMlUUsyNasx9LvLFbrw5AMDBIaNe03AgI5JKRxN3XzN3A3Pr
         Jv+jTII+KoRwYxvMJR8P4orlHlb5Mkr2l3/CBS2Ob6HoEEM5MqGphGFg0Xec7YFrBxHL
         ddxoGqV35E/XTTRCPJtTm/g362Y8fqUDUDzRx+u8GpY01c66rsOYD592JyX/a8uoocjM
         XS2Zifi3JievUOdkGL15pyyrWPQkYH68qPmYegiSMBFSdxh/btfxVMEk4x5XXfC2sfga
         mspw==
X-Gm-Message-State: AHQUAuZE55z4hyl9TwSM5qOspuQ+p47IemxcEmY+33/H1wv2zF5O5SVb
        YkPHIcpNV56WNgVaT4j0NPEdcw==
X-Google-Smtp-Source: AHgI3IbLZ0ZcSY7ng7VlY/HYeLh/qRzevQurjgOFI8n9C/PckixJdGvmv9m4aQO2X1K7x9iqImF6Iw==
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr2114072wmh.30.1549965299902;
        Tue, 12 Feb 2019 01:54:59 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id n26sm401028wmk.29.2019.02.12.01.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:54:59 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:54:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Message-ID: <20190212095457.GA20638@dell>
References: <20190205091237.6448-1-brgl@bgdev.pl>
 <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell>
 <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:

> wt., 12 lut 2019 o 09:36 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Tue, 05 Feb 2019, Bartosz Golaszewski wrote:
> >
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Add the core mfd driver for max77650 PMIC. We define five sub-devices
> > > for which the drivers will be added in subsequent patches.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  drivers/mfd/Kconfig          |  11 ++
> > >  drivers/mfd/Makefile         |   1 +
> > >  drivers/mfd/max77650.c       | 342 +++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/max77650.h |  59 ++++++
> > >  4 files changed, 413 insertions(+)
> > >  create mode 100644 drivers/mfd/max77650.c
> > >  create mode 100644 include/linux/mfd/max77650.h

[...]

> > > +static const struct max77650_irq_mapping max77650_irq_mapping_table[] = {
> > > +     {
> > > +             .cell_num       = MAX77650_CELL_CHARGER,
> > > +             .irqs           = max77650_charger_irqs,
> > > +             .irq_names      = max77650_charger_irq_names,
> > > +             .num_irqs       = ARRAY_SIZE(max77650_charger_irqs),
> > > +     },
> > > +     {
> > > +             .cell_num       = MAX77650_CELL_GPIO,
> > > +             .irqs           = max77650_gpio_irqs,
> > > +             .irq_names      = max77650_gpio_irq_names,
> > > +             .num_irqs       = ARRAY_SIZE(max77650_gpio_irqs),
> > > +     },
> > > +     {
> > > +             .cell_num       = MAX77650_CELL_ONKEY,
> > > +             .irqs           = max77650_onkey_irqs,
> > > +             .irq_names      = max77650_onkey_irq_names,
> > > +             .num_irqs       = ARRAY_SIZE(max77650_onkey_irqs),
> > > +     },
> > > +};
> >
> > This is all a bit convoluted and nasty TBH.
> >
> > > +static const struct mfd_cell max77650_cells[] = {
> > > +     [MAX77650_CELL_REGULATOR] = {
> > > +             .name           = "max77650-regulator",
> > > +             .of_compatible  = "maxim,max77650-regulator",
> > > +     },
> > > +     [MAX77650_CELL_CHARGER] = {
> > > +             .name           = "max77650-charger",
> > > +             .of_compatible  = "maxim,max77650-charger",
> > > +     },
> > > +     [MAX77650_CELL_GPIO] = {
> > > +             .name           = "max77650-gpio",
> > > +             .of_compatible  = "maxim,max77650-gpio",
> > > +     },
> > > +     [MAX77650_CELL_LED] = {
> > > +             .name           = "max77650-led",
> > > +             .of_compatible  = "maxim,max77650-led",
> > > +     },
> > > +     [MAX77650_CELL_ONKEY] = {
> > > +             .name           = "max77650-onkey",
> > > +             .of_compatible  = "maxim,max77650-onkey",
> > > +     },
> > > +};
> >
> > Why are you numbering the cells?  There is no need to do this.
> >
> 
> Just for better readability. It makes sense to me coupled with
> MAX77650_NUM_CELLS.

You have it the wrong way around.  You define the cell data, then
provide the number of them using ARRAY_SIZE().  The enum containing
MAX77650_NUM_CELLS should not exist.

> > > +static const struct regmap_irq max77650_irqs[] = {
> > > +     [MAX77650_INT_GPI] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_GPI_MSK,
> > > +             .type = {
> > > +                     .type_falling_val       = MAX77650_INT_GPI_F_MSK,
> > > +                     .type_rising_val        = MAX77650_INT_GPI_R_MSK,
> > > +                     .types_supported        = IRQ_TYPE_EDGE_BOTH,
> > > +             },
> > > +     },
> > > +     [MAX77650_INT_nEN_F] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_nEN_F_MSK,
> > > +     },
> > > +     [MAX77650_INT_nEN_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_nEN_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_TJAL1_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_TJAL1_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_TJAL2_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_TJAL2_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_DOD_R] = {
> > > +             .reg_offset             = MAX77650_INT_GLBL_OFFSET,
> > > +             .mask                   = MAX77650_INT_DOD_R_MSK,
> > > +     },
> > > +     [MAX77650_INT_THM] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_THM_MSK,
> > > +     },
> > > +     [MAX77650_INT_CHG] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_CHG_MSK,
> > > +     },
> > > +     [MAX77650_INT_CHGIN] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_CHGIN_MSK,
> > > +     },
> > > +     [MAX77650_INT_TJ_REG] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_TJ_REG_MSK,
> > > +     },
> > > +     [MAX77650_INT_CHGIN_CTRL] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_CHGIN_CTRL_MSK,
> > > +     },
> > > +     [MAX77650_INT_SYS_CTRL] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_SYS_CTRL_MSK,
> > > +     },
> > > +     [MAX77650_INT_SYS_CNFG] = {
> > > +             .reg_offset             = MAX77650_INT_CHG_OFFSET,
> > > +             .mask                   = MAX77650_INT_SYS_CNFG_MSK,
> > > +     },
> > > +};
> >
> > If you get rid of all of the horrible hoop jumping in *_setup_irqs(),
> > you can use REGMAP_IRQ_REG() like everyone else does.
> >
> 
> I could even use it now - except for the first interrupt. I decided to
> not use it everywhere as it looks much better that way than having
> REGMAP_IRQ_REG() for all definitions and then the first one sticking
> out like that. It just looks better.

The way it's done at the moment looks terrible.

Please use the MACROs to simplify as much of the code as possible.

> > > +static const struct regmap_irq_chip max77650_irq_chip = {
> > > +     .name                   = "max77650-irq",
> > > +     .irqs                   = max77650_irqs,
> > > +     .num_irqs               = ARRAY_SIZE(max77650_irqs),
> > > +     .num_regs               = 2,
> > > +     .status_base            = MAX77650_REG_INT_GLBL,
> > > +     .mask_base              = MAX77650_REG_INTM_GLBL,
> > > +     .type_in_mask           = true,
> > > +     .type_invert            = true,
> > > +     .init_ack_masked        = true,
> > > +     .clear_on_unmask        = true,
> > > +};
> > > +
> > > +static const struct regmap_config max77650_regmap_config = {
> > > +     .name           = "max77650",
> > > +     .reg_bits       = 8,
> > > +     .val_bits       = 8,
> > > +};
> > > +
> > > +static int max77650_setup_irqs(struct device *dev, struct mfd_cell *cells)
> > > +{
> > > +     const struct max77650_irq_mapping *mapping;
> > > +     struct regmap_irq_chip_data *irq_data;
> > > +     struct i2c_client *i2c;
> > > +     struct mfd_cell *cell;
> > > +     struct resource *res;
> > > +     struct regmap *map;
> > > +     int i, j, irq, rv;
> > > +
> > > +     i2c = to_i2c_client(dev);
> > > +
> > > +     map = dev_get_regmap(dev, NULL);
> > > +     if (!map)
> > > +             return -ENODEV;
> > > +
> > > +     rv = devm_regmap_add_irq_chip(dev, map, i2c->irq,
> > > +                                   IRQF_ONESHOT | IRQF_SHARED, -1,
> >
> > What is -1?  Are you sure this isn't defined somewhere?
> >
> 
> I don't see any define for negative irq_base argument. I can add that
> in a separate series and convert the users, but for now I'd stick with
> -1.

IMO it should be defined.  You can define it locally for now.

> > > +                                   &max77650_irq_chip, &irq_data);
> > > +     if (rv)
> > > +             return rv;
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(max77650_irq_mapping_table); i++) {
> > > +             mapping = &max77650_irq_mapping_table[i];
> > > +             cell = &cells[mapping->cell_num];
> > > +
> > > +             res = devm_kcalloc(dev, sizeof(*res),
> > > +                                mapping->num_irqs, GFP_KERNEL);
> > > +             if (!res)
> > > +                     return -ENOMEM;
> > > +
> > > +             cell->resources = res;
> > > +             cell->num_resources = mapping->num_irqs;
> > > +
> > > +             for (j = 0; j < mapping->num_irqs; j++) {
> > > +                     irq = regmap_irq_get_virq(irq_data, mapping->irqs[j]);
> > > +                     if (irq < 0)
> > > +                             return irq;
> > > +
> > > +                     res[j].start = res[j].end = irq;
> > > +                     res[j].flags = IORESOURCE_IRQ;
> > > +                     res[j].name = mapping->irq_names[j];
> > > +             }
> > > +     }
> >
> > This is the first time I've seen it done like this (and I hate it).
> >
> > Why are you storing the virqs in resources?
> >
> > I think this is highly irregular.
> >
> 
> I initially just passed the regmap_irq_chip_data over i2c clientdata
> and sub-drivers would look up virq numbers from it but was advised by
> Dmitry Torokhov to use resources instead. After implementing it this
> way I too think it's more elegant in sub-drivers who can simply do
> platform_get_irq_byname(). Do you have a different idea?

> What exactly don't you like about this?

 * The declaration of a superfluous struct
 * 100 lines of additional/avoidable code
 * Hacky hoop jumping trying to fudge VIRQs into resources
 * Resources were designed for HWIRQs (unless a domain is present)
 * Loads of additional/avoidable CPU cycles setting all this up

Need I go on? :)

Surely the fact that you are using both sides of an API
(devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
set some alarm bells ringing?

This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.

And for what?  To avoid passing IRQ data to a child driver?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

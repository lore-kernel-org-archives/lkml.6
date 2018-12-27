Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD607C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC49520856
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeL0Hfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:35:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41349 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeL0Hfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:35:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so15529678ljc.8;
        Wed, 26 Dec 2018 23:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lVxPBtZR3MMqABoYYyHRGwJeNgvyZAQK9YlrC6g6ARM=;
        b=KGiD8APfwfe2hTZIC/fuv7QFAl/WtM6ocjy5278xS98RFZfq6ONfS9qOIQ2zAPzLJo
         SyxCYM4o7kjiFX5ZbsKwfyTm2+eBbtwkSsopUJ8x20gT1DtUfGPqUDRPWA1mZtqauUJw
         inMcZDjQXswyzCv3hppy5qy0luxA2U42zuVnbUEaNyCSfUh4aYERiNdcw/J5QDlAuVUN
         04fn1t1vqkvefiRSpDM03WMQn9RKsE2sDg/Aa5vB3IPQaP9K+eCvmII5nj6/8jFmpLq3
         mImGzKxB6qAvYSnAwDoY/NuTgAbCcjQcRheDtbK4dArdOzwjvhMzIJ/K1TRHd/NrQPlK
         0mvA==
X-Gm-Message-State: AJcUukffqJVybvCDqpR1Xypf/qmnDKOfcZJcVlKLpSBzhFbHBS5fH3kQ
        L/MTxZbIDUSy8Eh+LLwy8ig=
X-Google-Smtp-Source: ALg8bN4fDPKEQg+x0B+Nym2AiD1fxNXQ8SDVCcNGArJgo8Wns5BKTRQCt+nMS4ZD2sr7SnYqkCcQtA==
X-Received: by 2002:a2e:9457:: with SMTP id o23-v6mr14148876ljh.7.1545896137827;
        Wed, 26 Dec 2018 23:35:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v19sm7464327lfe.69.2018.12.26.23.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 23:35:37 -0800 (PST)
Date:   Thu, 27 Dec 2018 09:35:31 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq
 support
Message-ID: <20181227073531.GA2461@localhost.localdomain>
References: <20181218115931.GA21253@localhost.localdomain>
 <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

Sorry for waiting - I just opened my computer after the holidays.

On Wed, Dec 26, 2018 at 12:39:17PM +0100, Geert Uytterhoeven wrote:
> Hi Matti,
> 
> On Tue, Dec 18, 2018 at 1:00 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> > Add level active IRQ support to regmap-irq irqchip. Change breaks
> > existing regmap-irq type setting. Convert the existing drivers which
> 
> Indeed it does.
> 
> > use regmap-irq with trigger type setting (gpio-max77620) to work
> > with this new approach. So we do not magically support level-active
> > IRQs on gpio-max77620 - but add support to the regmap-irq for chips
> > which support them =)
> >
> > We do not support distinguishing situation where HW supports rising
> > and falling edge detection but not both. Separating this would require
> > inventing yet another flags for IRQ types.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> This is now upstream as commit 1c2928e3e3212252 ("regmap:
> regmap-irq/gpio-max77620: add level-irq support"), and breaks da9063-rtc
> on the Renesas Koelsch board:
> 
>     genirq: Setting trigger mode 8 for irq 157 failed
> (regmap_irq_set_type+0x0/0x140)
>     da9063-rtc da9063-rtc: Failed to request ALARM IRQ 157: -524
>     da9063-rtc: probe of da9063-rtc failed with error -524

This is strange as I do not see any type setting support code in
drivers/mfd/da9063-irq.c. The type setting registers are neither
specified in static const struct regmap_irq_chip da9063l_irq_chip nor
in static const struct regmap_irq_chip da9063_irq_chip. Hence I don't
understand how the da9063 could have been supporting IRQ type setting in
first place.

> > ---
> >
> > Version 3 of this patch is intended to be functionally identical to v2.
> > This patch is rebased on top of a tree which contains changes:
> > "regmap: irq: handle HW using separate rising/falling edge interrupts"
> > from Bartosz Golaszewski and the change
> > "regmap: regmap-irq: Remove default irq type setting from core"
> > (proposed here):
> > https://lore.kernel.org/lkml/20181218105813.GA6957@localhost.localdomain/
> >
> > There should not be direct dependency to "regmap: regmap-irq: Remove
> > default irq type setting from core" though. Patch was also tested to
> > apply cleany on regmap-tree.
> >
> > Same statement regarding testing applies - gpio-max77620 are only
> > tested to compile. All real testing would be _HIGHLY_ appreciated.
> >
> >  drivers/base/regmap/regmap-irq.c | 35 ++++++++++-----
> >  drivers/gpio/gpio-max77620.c     | 96 ++++++++++++++++++++++++++--------------
> >  include/linux/regmap.h           | 27 ++++++++---
> >  3 files changed, 110 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> > index 8b216b2e2c19..31d23c9a5ae7 100644
> > --- a/drivers/base/regmap/regmap-irq.c
> > +++ b/drivers/base/regmap/regmap-irq.c
> > @@ -199,7 +199,7 @@ static void regmap_irq_enable(struct irq_data *data)
> >         const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
> >         unsigned int mask, type;
> >
> > -       type = irq_data->type_falling_mask | irq_data->type_rising_mask;
> > +       type = irq_data->type.type_falling_val | irq_data->type.type_rising_val;
> >
> >         /*
> >          * The type_in_mask flag means that the underlying hardware uses
> > @@ -234,27 +234,42 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
> >         struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
> >         struct regmap *map = d->map;
> >         const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
> > -       int reg = irq_data->type_reg_offset / map->reg_stride;
> > +       int reg;
> > +       const struct regmap_irq_type *t = &irq_data->type;
> >
> > -       if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
> > -               return 0;
> > +       if ((t->types_supported & type) != type)
> > +               return -ENOTSUPP;
> 
> Given types_supported defaults to zero, I think this breaks every existing
> setup using REGMAP_IRQ_REG().

Not really. The type setting support is not too old or widely used in
regmap_irq. If the type_base and num_type_reg in struct regmap_irq_chip
have not been given the type setting has not been supported. And the
macro REGMAP_IRQ_REG() has not been initializing those fields - they
must have been explicitly set by the driver. Only in-tree driver which
really used the regmap_irq type-setting was gpio-max77620 (if my
grepping did not go totally wrong). Is your version of
drivers/mfd/da9063-irq.c same I can see in
https://elixir.bootlin.com/linux/v4.20/source/drivers/mfd/da9063-irq.c ?

I will try to see if the regmap_irq code has just silently ignored irq
type setting requests if type setting information has not been populated
by driver. May that has been changed by my patch. I wonder what would be
the correct action if there is no type-setting information in
struct regmap_irq_chip - and if type setting irq callbacks are called.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD20C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6C7218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeL1IFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:05:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42318 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbeL1IFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:05:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so18063632lja.9;
        Fri, 28 Dec 2018 00:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUuOMXiAveNS6pMX+WJG4oevliLdJmLbcbPk2PdcfTo=;
        b=ueAafLHIs0v4NlZVn3fiLftHdzdTp2dt4+xxleS8M6Fcg9ixPTjdgMP6pHItuEdAsb
         pIrnwaI8Hlka7/6Zu3TPsAomIQ8qofgIpErstVuGgr7zoS+C1MfAqDUSfClM5WW50tJ9
         4jUy5APZyUBHOMJXGF1IbhVz+cW6Ch7311t707xusUFKSNC8J0wdB4pJ0nHY8qWiVqSe
         4dmNIYaXtko9qrr/3V5S5Nq+SPjANRwmPHwP7qGvr7HViQ9ah8Nl+nGYtI/5cp/4uMAO
         ebw6w7aoIOvQ5HpBbebFaHbrglfoyC1Tfog18ti7KSU85ImhX3bms1wrNmcgUTzWc7qJ
         0Bww==
X-Gm-Message-State: AA+aEWYKyHdInL1p5ES72Jky1Qo3BTd6/RBEOkGmGJTA7ajvvS5H4X0+
        OfGgt3pQjMCbBfT2tAwIvbk=
X-Google-Smtp-Source: ALg8bN4eqVUhMDGmwphsxT0yqOzfZ5ma8mZZ+tTjbCVPxLTaeeWe4sZwLKsT3eXgCDhxa6/wS0HMCQ==
X-Received: by 2002:a2e:84ca:: with SMTP id q10-v6mr14873052ljh.65.1545984337279;
        Fri, 28 Dec 2018 00:05:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h12-v6sm8409276ljb.80.2018.12.28.00.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 00:05:36 -0800 (PST)
Date:   Fri, 28 Dec 2018 10:05:33 +0200
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
Message-ID: <20181228080533.GC2461@localhost.localdomain>
References: <20181218115931.GA21253@localhost.localdomain>
 <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
 <20181227073531.GA2461@localhost.localdomain>
 <20181227075648.GB2461@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227075648.GB2461@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 09:56:48AM +0200, Matti Vaittinen wrote:
> Hello All,
> 
> On Thu, Dec 27, 2018 at 09:35:31AM +0200, Matti Vaittinen wrote:
> > On Wed, Dec 26, 2018 at 12:39:17PM +0100, Geert Uytterhoeven wrote:
> > > Hi Matti,
> > > 
> > > On Tue, Dec 18, 2018 at 1:00 PM Matti Vaittinen
> > > <matti.vaittinen@fi.rohmeurope.com> wrote:
> > > > Add level active IRQ support to regmap-irq irqchip. Change breaks
> > > > existing regmap-irq type setting. Convert the existing drivers which
> > > 
> > > Indeed it does.
> > > 
> > > This is now upstream as commit 1c2928e3e3212252 ("regmap:
> > > regmap-irq/gpio-max77620: add level-irq support"), and breaks da9063-rtc
> > > on the Renesas Koelsch board:
> > > 
> > >     genirq: Setting trigger mode 8 for irq 157 failed
> > > (regmap_irq_set_type+0x0/0x140)
> > >     da9063-rtc da9063-rtc: Failed to request ALARM IRQ 157: -524
> > >     da9063-rtc: probe of da9063-rtc failed with error -524
> > 
> > This is strange as I do not see any type setting support code in
> > drivers/mfd/da9063-irq.c. The type setting registers are neither
> > specified in static const struct regmap_irq_chip da9063l_irq_chip nor
> > in static const struct regmap_irq_chip da9063_irq_chip. Hence I don't
> > understand how the da9063 could have been supporting IRQ type setting in
> > first place.
> > 
> > > > @@ -234,27 +234,42 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
> > > >         struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
> > > >         struct regmap *map = d->map;
> > > >         const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
> > > > -       int reg = irq_data->type_reg_offset / map->reg_stride;
> > > > +       int reg;
> > > > +       const struct regmap_irq_type *t = &irq_data->type;
> > > >
> > > > -       if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
> > > > -               return 0;
> > > > +       if ((t->types_supported & type) != type)
> > > > +               return -ENOTSUPP;
> > > 
> > > Given types_supported defaults to zero, I think this breaks every existing
> > > setup using REGMAP_IRQ_REG().
> 
> Right. Now I see what you mean. Original code did:
> 
> 	if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
> 		return 0;
> 
> Eg, even when the driver was not able to perform the type-setting this
> failure was silently ignored, right. So doing:
>        if ((t->types_supported & type) != type)
>                return 0;
> would be functionally equal. It feels like utterly wrong thing to do
> (to me) - if driver is written to work with edge or level active
> interrupts - and if the irq controller is not supporting this - then we
> should warn the user. Just silently ignoring this sounds like asking for
> irq storm or missed interrupts - but maybe I just don't get this =)
> 
> I'll send a patch with 
> 	if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
> 		return 0;
> in order to not break existing functionality - but it feels plain wrong
> to me.

Geert, I did send this patch yesterday. It's here if you wish to try it:
https://lore.kernel.org/patchwork/patch/1027963/

Last night - just when I was about to get some sleep - it stroke me. I
think the correct thing to do would be leaving the irq_set_type to NULL
for those IRQ chips which do not support type setting. If we do that,
then the irq core will take care of situations where user requests type
setting but the chip does not support it. Which means the regmap-irq
would be no different from any other irq chip where type setting is not
supported.

/// irrelevant ///
I guess you know the moment of "Hypnagogia" when you are comfortably at
bed your head feels all dizzy and world is starting to faint away...
And just a second later you are fully awake thinking of a possible
solution - and definitely not able to sleep anymore :/

https://www.reddit.com/r/ProgrammerHumor/comments/93eq0e/everytime/
/// irrelevant ends ///

I just took a peek in 
kernel/irq/manage.c - and found following:

int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
{
	struct irq_chip *chip = desc->irq_data.chip;
	int ret, unmask = 0;

	if (!chip || !chip->irq_set_type) {
		/*
		 * IRQF_TRIGGER_* but the PIC does not support multiple
		 * flow-types?
		 */
		pr_debug("No set_type function for IRQ %d (%s)\n",
			 irq_desc_get_irq(desc),
			 chip ? (chip->name ? : "unknown") : "unknown");
		return 0;
	}

...

so at the moment the IRQ core is also just spilling out the warning and
then returning zero. But at least we would get the warning from core if
the irq-chip does not support type config.

So at the cost of removing "const" from regmap_irq_chip we could do:

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 2a031743f31f..b6aef50ab378 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -298,12 +298,11 @@ static int regmap_irq_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
-static const struct irq_chip regmap_irq_chip = {
+static struct irq_chip regmap_irq_chip = {
 	.irq_bus_lock		= regmap_irq_lock,
 	.irq_bus_sync_unlock	= regmap_irq_sync_unlock,
 	.irq_disable		= regmap_irq_disable,
 	.irq_enable		= regmap_irq_enable,
-	.irq_set_type		= regmap_irq_set_type,
 	.irq_set_wake		= regmap_irq_set_wake,
 };
 
@@ -610,6 +609,7 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
 
 	num_type_reg = chip->type_in_mask ? chip->num_regs : chip->num_type_reg;
 	if (num_type_reg) {
+		regmap_irq_chip.irq_set_type = regmap_irq_set_type;
 		d->type_buf_def = kcalloc(num_type_reg,
 					  sizeof(unsigned int), GFP_KERNEL);
 		if (!d->type_buf_def)



Mark, Geert, what do you think? (And maybe same for the .irq_set_wake -
but I did omit this as I have never looked at the wake functionality
before).

Br,
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

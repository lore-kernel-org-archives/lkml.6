Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129DD2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ur2YTWoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129DD2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbeISDuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:50:01 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36926 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbeISDuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:50:01 -0400
Received: by mail-yw1-f65.google.com with SMTP id x83-v6so1481034ywd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfwuwhmxbJlrrx0bWbZoR0NtxwFYxpx4oeExxW4MvlI=;
        b=ur2YTWoz9l8cPZiWnlGuEj4/NXAE4joWorgVE8AEWZOvWXgdai3lAOXhptZmxALbuF
         HasmKhwDL0szJKBbaDpeTkBY7mnQVboRKmvj7uGKWdbc2Pfya4dn+K4k8KDg7sRFq5Bf
         V6YPFs+adYUqx1WSRVhHJNqoql3fBB57oO7SYVy1do1NLkqutuW5zRPuSZte8+PvE152
         Zc+dFmtYIKgOtyh5N3iUeONfYXX5fGZQWW0y0F2HagwtGB78qxzj8UjOotER+n8Wr+yu
         Y6AXvPrDnqLnmly5qSsTPIF9p2PKKAIIWD3ZI1yGjHCHr1R7NwVPuQt9qE4ebUhutGE4
         iTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfwuwhmxbJlrrx0bWbZoR0NtxwFYxpx4oeExxW4MvlI=;
        b=E5dD724IHTu5u3Ehy/hXo9lUNHm0BSt0t6spbqDl+iOoh5g3OFA8bXmN5FLj2T3paV
         cu854prFDxHXidt+6LhrZa8NKuXf/0B45/JzzKwcUINQJLC7t/cc7tRXOXCWnRdCBc0E
         wpNmW7onjeDCOb0crMx6+d8DLMqZ7Q6JufiS5gi89euLW43ppt0TEbYkFj3PUYvU3JO1
         26ZxYj0e5obn8G1HCqmQEu2GYEsYCOqtx3ENp7Yr2XnjVzs95ipjSWhNnTp/7CX0m27Q
         1twcksD/8qusjwix0Swl/rwpYglo39eR7jy9L8lvtL7pXid//uDyijsLLQpyIAJpKkpK
         70ZA==
X-Gm-Message-State: APzg51BNJQzQIyxUoQkphEDIj3A3DDCUbIgos7zys9KcUW2jiSBWkrZ+
        x8PzM/D1R6T/yMqUlUMCvwa+yeVheSzRXtel4DZEYg==
X-Google-Smtp-Source: ANB0VdaTSdcraoSAh/bA4lxAMhWoRH2mD241hmaeOZGep23LebSKqa3C3ZzVwatq7Bc35vhkR/RKOYKDvMj0Gmw59L4=
X-Received: by 2002:a81:2b82:: with SMTP id r124-v6mr9331759ywr.249.1537308920709;
 Tue, 18 Sep 2018 15:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180918153621.71984-1-mika.westerberg@linux.intel.com> <CACK8Z6F4+N1paQTSWcomnwLpLEHoospSOT3M9bqFQZHHfWmahA@mail.gmail.com>
In-Reply-To: <CACK8Z6F4+N1paQTSWcomnwLpLEHoospSOT3M9bqFQZHHfWmahA@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 18 Sep 2018 15:14:44 -0700
Message-ID: <CACK8Z6GfeJQSMN=m9hrFE2DFwpCNjNb57PqGiXFDD19Y=SXgnQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Do pin translation in other GPIO
 operations as well
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        casey.g.bowman@intel.com,
        "Atwood, Matthew S" <matthew.s.atwood@intel.com>,
        linux-gpio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 3:04 PM Rajat Jain <rajatja@google.com> wrote:
>
> On Tue, Sep 18, 2018 at 8:36 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > For some reason I thought GPIOLIB handles translation from GPIO ranges
> > to pinctrl pins but it turns out not to be the case. This means that
> > when GPIOs operations are performed for a pin controller having a custom
> > GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
> > used internally.
> >
> > Fix this in the same way we did for lock/unlock IRQ operations and
> > translate the GPIO number to pin before using it.
> >
> > Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
> > Reported-by: Rajat Jain <rajatja@google.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Tested-by: Rajat Jain <rajatja@google.com>
>
> This has fixed the issue for me.
>
> One question, may not be related: I see this line in my logs everytime
> I export a pin (GPIO40 = pin 16 in this case). Is that an indication
> of a problem?
>
> "gpio gpiochip0: Persistence not supported for GPIO 40"
>


Also consider fixing the checkpatch warning:

        Errors:
            * checkpatch.pl errors/warnings

            WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
            #48: FILE: drivers/pinctrl/intel/pinctrl-intel.c:764:
            +static int intel_gpio_to_pin(struct intel_pinctrl *pctrl,
unsigned offset,



> Thanks,
>
> Rajat
>
> On Tue, Sep 18, 2018 at 8:36 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > For some reason I thought GPIOLIB handles translation from GPIO ranges
> > to pinctrl pins but it turns out not to be the case. This means that
> > when GPIOs operations are performed for a pin controller having a custom
> > GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
> > used internally.
> >
> > Fix this in the same way we did for lock/unlock IRQ operations and
> > translate the GPIO number to pin before using it.
> >
> > Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
> > Reported-by: Rajat Jain <rajatja@google.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pinctrl/intel/pinctrl-intel.c | 111 +++++++++++++++-----------
> >  1 file changed, 63 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> > index 62b009b27eda..ec8dafc94694 100644
> > --- a/drivers/pinctrl/intel/pinctrl-intel.c
> > +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> > @@ -747,13 +747,63 @@ static const struct pinctrl_desc intel_pinctrl_desc = {
> >         .owner = THIS_MODULE,
> >  };
> >
> > +/**
> > + * intel_gpio_to_pin() - Translate from GPIO offset to pin number
> > + * @pctrl: Pinctrl structure
> > + * @offset: GPIO offset from gpiolib
> > + * @commmunity: Community is filled here if not %NULL
> > + * @padgrp: Pad group is filled here if not %NULL
> > + *
> > + * When coming through gpiolib irqchip, the GPIO offset is not
> > + * automatically translated to pinctrl pin number. This function can be
> > + * used to find out the corresponding pinctrl pin.
> > + */
> > +static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned offset,
> > +                            const struct intel_community **community,
> > +                            const struct intel_padgroup **padgrp)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < pctrl->ncommunities; i++) {
> > +               const struct intel_community *comm = &pctrl->communities[i];
> > +               int j;
> > +
> > +               for (j = 0; j < comm->ngpps; j++) {
> > +                       const struct intel_padgroup *pgrp = &comm->gpps[j];
> > +
> > +                       if (pgrp->gpio_base < 0)
> > +                               continue;
> > +
> > +                       if (offset >= pgrp->gpio_base &&
> > +                           offset < pgrp->gpio_base + pgrp->size) {
> > +                               int pin;
> > +
> > +                               pin = pgrp->base + offset - pgrp->gpio_base;
> > +                               if (community)
> > +                                       *community = comm;
> > +                               if (padgrp)
> > +                                       *padgrp = pgrp;
> > +
> > +                               return pin;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> >  static int intel_gpio_get(struct gpio_chip *chip, unsigned offset)
> >  {
> >         struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
> >         void __iomem *reg;
> >         u32 padcfg0;
> > +       int pin;
> > +
> > +       pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
> > +       if (pin < 0)
> > +               return -EINVAL;
> >
> > -       reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> > +       reg = intel_get_padcfg(pctrl, pin, PADCFG0);
> >         if (!reg)
> >                 return -EINVAL;
> >
> > @@ -770,8 +820,13 @@ static void intel_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> >         unsigned long flags;
> >         void __iomem *reg;
> >         u32 padcfg0;
> > +       int pin;
> > +
> > +       pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
> > +       if (pin < 0)
> > +               return;
> >
> > -       reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> > +       reg = intel_get_padcfg(pctrl, pin, PADCFG0);
> >         if (!reg)
> >                 return;
> >
> > @@ -790,8 +845,13 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> >         struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
> >         void __iomem *reg;
> >         u32 padcfg0;
> > +       int pin;
> >
> > -       reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> > +       pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
> > +       if (pin < 0)
> > +               return -EINVAL;
> > +
> > +       reg = intel_get_padcfg(pctrl, pin, PADCFG0);
> >         if (!reg)
> >                 return -EINVAL;
> >
> > @@ -827,51 +887,6 @@ static const struct gpio_chip intel_gpio_chip = {
> >         .set_config = gpiochip_generic_config,
> >  };
> >
> > -/**
> > - * intel_gpio_to_pin() - Translate from GPIO offset to pin number
> > - * @pctrl: Pinctrl structure
> > - * @offset: GPIO offset from gpiolib
> > - * @commmunity: Community is filled here if not %NULL
> > - * @padgrp: Pad group is filled here if not %NULL
> > - *
> > - * When coming through gpiolib irqchip, the GPIO offset is not
> > - * automatically translated to pinctrl pin number. This function can be
> > - * used to find out the corresponding pinctrl pin.
> > - */
> > -static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned offset,
> > -                            const struct intel_community **community,
> > -                            const struct intel_padgroup **padgrp)
> > -{
> > -       int i;
> > -
> > -       for (i = 0; i < pctrl->ncommunities; i++) {
> > -               const struct intel_community *comm = &pctrl->communities[i];
> > -               int j;
> > -
> > -               for (j = 0; j < comm->ngpps; j++) {
> > -                       const struct intel_padgroup *pgrp = &comm->gpps[j];
> > -
> > -                       if (pgrp->gpio_base < 0)
> > -                               continue;
> > -
> > -                       if (offset >= pgrp->gpio_base &&
> > -                           offset < pgrp->gpio_base + pgrp->size) {
> > -                               int pin;
> > -
> > -                               pin = pgrp->base + offset - pgrp->gpio_base;
> > -                               if (community)
> > -                                       *community = comm;
> > -                               if (padgrp)
> > -                                       *padgrp = pgrp;
> > -
> > -                               return pin;
> > -                       }
> > -               }
> > -       }
> > -
> > -       return -EINVAL;
> > -}
> > -
> >  static int intel_gpio_irq_reqres(struct irq_data *d)
> >  {
> >         struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > --
> > 2.18.0
> >

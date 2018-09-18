Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F29FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D894C2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrC4yddq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D894C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbeISDjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:39:39 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37553 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730325AbeISDji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:39:38 -0400
Received: by mail-yw1-f66.google.com with SMTP id x83-v6so1471003ywd.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onBv8jOsJww8mZri3+GK2RMUTnB79jejjYDs7sycejk=;
        b=SrC4yddqj+gFUIYXLaZGzi4fSoiSJMk7tlBfBwPd2wdRgo3EC/2E20dnUAVwrHHoXR
         +G+77Z+SFMsAeBnAJMb7tv2KldF3Xc1oWQWmJsscgM7w6GeYce4n+gZbMZSgi77YSCXs
         UWeaFn0mqQJOwzyO97pdqh1zIgDTObg3HfwPowDwFngIMUcEYbnEQY79EIGlZibfja/L
         91jmtgKgqHMCVC9LaDZUWQSiGRGaIkOAcJAp9sjLydn/sr5VS6fTD+sH2CHh5DE3wRum
         PH37UIIWk/UvPEEpGUKLdX+bsqmLKrePSsSvaHqGxsGclpa/CgC5vy96n9y/zmmtl9Yi
         KMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onBv8jOsJww8mZri3+GK2RMUTnB79jejjYDs7sycejk=;
        b=Aq3edhEoQc9hphk7LiJiaJXcBRNSSc6HQcafx0hOEeSprfjl5uBDDDxmcVNyBREX6m
         Rh1x/OwzGG7Xk66RWyoc4sOtRjSZLCCPaA8zWhhyLsmRnLU/119AqOHTlU/VZhoj0gbu
         waOYMbSGaW5MVHkN5CS5p94wV9eyLxyXnSR85tuAbQr+Z7NqPQvOOYw0i7cwVLXyxs53
         5hrxC7sRsYLRA+/Au+JPFX498rdSzMvT3o8IOdgBobnX7qR2gq46/00ubZimcxLlNgdg
         WDQU7TCiJRJa4Y10ZKmwYksqUYhLyD97k0frp0iG7IdJPgid66Wxqvu9r2vc/V6qiBLt
         A25w==
X-Gm-Message-State: APzg51AQkXHG/U+d1wP/s+TIppN6aFJMJlS8doK2OhQV3sYBscswsZ6a
        abRBguNGly3+ZqxwH4Qd5xUicsru5f7Hb743lum6yg==
X-Google-Smtp-Source: ANB0Vda81FVhNvRi/QOQXccvZsAhPtdeb43HgVXWzcu6aeJ86fxEAy8uzWuS3HtmA6zYP5JP9Z+0hu+mKkRKLurW6p0=
X-Received: by 2002:a81:78d5:: with SMTP id t204-v6mr13882240ywc.340.1537308299665;
 Tue, 18 Sep 2018 15:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20180918153621.71984-1-mika.westerberg@linux.intel.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 18 Sep 2018 15:04:23 -0700
Message-ID: <CACK8Z6F4+N1paQTSWcomnwLpLEHoospSOT3M9bqFQZHHfWmahA@mail.gmail.com>
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

On Tue, Sep 18, 2018 at 8:36 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> For some reason I thought GPIOLIB handles translation from GPIO ranges
> to pinctrl pins but it turns out not to be the case. This means that
> when GPIOs operations are performed for a pin controller having a custom
> GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
> used internally.
>
> Fix this in the same way we did for lock/unlock IRQ operations and
> translate the GPIO number to pin before using it.
>
> Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
> Reported-by: Rajat Jain <rajatja@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Tested-by: Rajat Jain <rajatja@google.com>

This has fixed the issue for me.

One question, may not be related: I see this line in my logs everytime
I export a pin (GPIO40 = pin 16 in this case). Is that an indication
of a problem?

"gpio gpiochip0: Persistence not supported for GPIO 40"

Thanks,

Rajat

On Tue, Sep 18, 2018 at 8:36 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> For some reason I thought GPIOLIB handles translation from GPIO ranges
> to pinctrl pins but it turns out not to be the case. This means that
> when GPIOs operations are performed for a pin controller having a custom
> GPIO base such as Cannon Lake and Ice Lake incorrect pin number gets
> used internally.
>
> Fix this in the same way we did for lock/unlock IRQ operations and
> translate the GPIO number to pin before using it.
>
> Fixes: a60eac3239f0 ("pinctrl: intel: Allow custom GPIO base for pad groups")
> Reported-by: Rajat Jain <rajatja@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-intel.c | 111 +++++++++++++++-----------
>  1 file changed, 63 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index 62b009b27eda..ec8dafc94694 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -747,13 +747,63 @@ static const struct pinctrl_desc intel_pinctrl_desc = {
>         .owner = THIS_MODULE,
>  };
>
> +/**
> + * intel_gpio_to_pin() - Translate from GPIO offset to pin number
> + * @pctrl: Pinctrl structure
> + * @offset: GPIO offset from gpiolib
> + * @commmunity: Community is filled here if not %NULL
> + * @padgrp: Pad group is filled here if not %NULL
> + *
> + * When coming through gpiolib irqchip, the GPIO offset is not
> + * automatically translated to pinctrl pin number. This function can be
> + * used to find out the corresponding pinctrl pin.
> + */
> +static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned offset,
> +                            const struct intel_community **community,
> +                            const struct intel_padgroup **padgrp)
> +{
> +       int i;
> +
> +       for (i = 0; i < pctrl->ncommunities; i++) {
> +               const struct intel_community *comm = &pctrl->communities[i];
> +               int j;
> +
> +               for (j = 0; j < comm->ngpps; j++) {
> +                       const struct intel_padgroup *pgrp = &comm->gpps[j];
> +
> +                       if (pgrp->gpio_base < 0)
> +                               continue;
> +
> +                       if (offset >= pgrp->gpio_base &&
> +                           offset < pgrp->gpio_base + pgrp->size) {
> +                               int pin;
> +
> +                               pin = pgrp->base + offset - pgrp->gpio_base;
> +                               if (community)
> +                                       *community = comm;
> +                               if (padgrp)
> +                                       *padgrp = pgrp;
> +
> +                               return pin;
> +                       }
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
>  static int intel_gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
>         struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
>         void __iomem *reg;
>         u32 padcfg0;
> +       int pin;
> +
> +       pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
> +       if (pin < 0)
> +               return -EINVAL;
>
> -       reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> +       reg = intel_get_padcfg(pctrl, pin, PADCFG0);
>         if (!reg)
>                 return -EINVAL;
>
> @@ -770,8 +820,13 @@ static void intel_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>         unsigned long flags;
>         void __iomem *reg;
>         u32 padcfg0;
> +       int pin;
> +
> +       pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
> +       if (pin < 0)
> +               return;
>
> -       reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> +       reg = intel_get_padcfg(pctrl, pin, PADCFG0);
>         if (!reg)
>                 return;
>
> @@ -790,8 +845,13 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
>         struct intel_pinctrl *pctrl = gpiochip_get_data(chip);
>         void __iomem *reg;
>         u32 padcfg0;
> +       int pin;
>
> -       reg = intel_get_padcfg(pctrl, offset, PADCFG0);
> +       pin = intel_gpio_to_pin(pctrl, offset, NULL, NULL);
> +       if (pin < 0)
> +               return -EINVAL;
> +
> +       reg = intel_get_padcfg(pctrl, pin, PADCFG0);
>         if (!reg)
>                 return -EINVAL;
>
> @@ -827,51 +887,6 @@ static const struct gpio_chip intel_gpio_chip = {
>         .set_config = gpiochip_generic_config,
>  };
>
> -/**
> - * intel_gpio_to_pin() - Translate from GPIO offset to pin number
> - * @pctrl: Pinctrl structure
> - * @offset: GPIO offset from gpiolib
> - * @commmunity: Community is filled here if not %NULL
> - * @padgrp: Pad group is filled here if not %NULL
> - *
> - * When coming through gpiolib irqchip, the GPIO offset is not
> - * automatically translated to pinctrl pin number. This function can be
> - * used to find out the corresponding pinctrl pin.
> - */
> -static int intel_gpio_to_pin(struct intel_pinctrl *pctrl, unsigned offset,
> -                            const struct intel_community **community,
> -                            const struct intel_padgroup **padgrp)
> -{
> -       int i;
> -
> -       for (i = 0; i < pctrl->ncommunities; i++) {
> -               const struct intel_community *comm = &pctrl->communities[i];
> -               int j;
> -
> -               for (j = 0; j < comm->ngpps; j++) {
> -                       const struct intel_padgroup *pgrp = &comm->gpps[j];
> -
> -                       if (pgrp->gpio_base < 0)
> -                               continue;
> -
> -                       if (offset >= pgrp->gpio_base &&
> -                           offset < pgrp->gpio_base + pgrp->size) {
> -                               int pin;
> -
> -                               pin = pgrp->base + offset - pgrp->gpio_base;
> -                               if (community)
> -                                       *community = comm;
> -                               if (padgrp)
> -                                       *padgrp = pgrp;
> -
> -                               return pin;
> -                       }
> -               }
> -       }
> -
> -       return -EINVAL;
> -}
> -
>  static int intel_gpio_irq_reqres(struct irq_data *d)
>  {
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> --
> 2.18.0
>

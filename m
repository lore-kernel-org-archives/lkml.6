Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55895C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2275D20989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfA1OEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:04:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36209 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfA1OEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:04:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id a16so11921005lfg.3;
        Mon, 28 Jan 2019 06:04:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2DnoYUTPil3lnC/tr8LJXrq2BP9a/vq0o37VypGxF5o=;
        b=e7TkWSlUzOZy0cf9HihHuhYRuDlr4OHhuhj+uPm02FiT7YGngqAYoWtjCU91gsVhmj
         GuMEuDsu2FiT3DzNwLt5RzpOvQ2A3NOAYUbpb2dn27Got88wtoHKpuNI1/Clz5BuKinP
         JpMsdtgBvl1SpmmLKw1NPnUQGH7d93gpEz9+dZdUy3xKWtUvxv3MnzJNoBO223r2fQWu
         HRzqtDb0wQaAZGmWtvFib2Fst6xgKhS3uz9YsAdTOvWCWTYLQf1dajf+kk158k+BSSER
         Sfqo9xNed1uL5jfitqi4DlYra+oy57ecMzkrUCOPTqeraOcxygS+x8FGgw0dPJG/0TKq
         3kcg==
X-Gm-Message-State: AJcUukdM5SkEP3f+Z2KGy088CRhXDhfDNrUCYkBU8fVFCnmAY3zI7Vbj
        KaFK2xzVrvY5p5yXfOFttUQ=
X-Google-Smtp-Source: ALg8bN457TwXGKT2k6IVkN+A0kr8Fz+QSImc8YOiO7nviNcYHIWxCzON9Mq8v9YidFhl3sv9v1oo+w==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr15989118lfh.159.1548684290499;
        Mon, 28 Jan 2019 06:04:50 -0800 (PST)
Received: from localhost.localdomain (mobile-access-bcee00-77.dhcp.inet.fi. [188.238.0.77])
        by smtp.gmail.com with ESMTPSA id w4sm2889858lfk.83.2019.01.28.06.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 06:04:49 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:04:45 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Subject: Re: [RFC PATCH v2 07/10] gpio: Initial support for ROHM bd70528 GPIO
 block
Message-ID: <20190128140445.GB4156@localhost.localdomain>
References: <20190125110509.GA29310@localhost.localdomain>
 <CACRpkdYTUB8vPiCF=s5-TARhv=DsPDQHVyCwP7fMc27gyDvKSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYTUB8vPiCF=s5-TARhv=DsPDQHVyCwP7fMc27gyDvKSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 01:55:48PM +0100, Linus Walleij wrote:
> Hi Matti!
> 
> Thanks for your patch!

No, thank you for the review =)

> On Fri, Jan 25, 2019 at 12:05 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> 
> > ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> > controlled by GPIO framework.
> >
> > IRQs are handled by regmap-irq and GPIO driver is not
> > aware of the irq usage.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> This is overall a very nicely written driver.
> 
> Just small comments:
> 
> > +#include <linux/gpio/driver.h>
> > +#include <linux/interrupt.h>
> 
> Why interrupt? You do not use it.

Right, I'd better to drop it.

> 
> > +static int bd70528_get_direction(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> > +       int val, ret;
> > +
> > +       /* Do we need to do something to IRQs here? */
> 
> Well you don't support IRQs yet so no problem as long as they're masked?

I may have not worded this correctly. These pins can be used for IRQs.
HW supports it and I added the irq registers in regmap-irq controller
(please see the MFD part). It's just that this GPIO driver is currently not
aware of that. This comment here is a reminder for me to figure out if
we should look whether the pin is used for I/O or for irqs here - and
what should we return if pin is configured to be used for IRQs.

> > +       ret = regmap_read(bdgpio->chip.regmap, GPIO_OUT_REG(offset), &val);
> > +       if (ret) {
> > +               dev_err(bdgpio->chip.dev, "Could not read gpio direction\n");
> > +               return ret;
> > +       }
> > +
> > +       return !(val & BD70528_GPIO_OUT_EN_MASK);
> > +}
> > +
> > +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> > +                                  unsigned long config)
> 
> This is very nice. With Thomas Petazzoni's ongoing work you will be
> able to also support pull up/down if you need it.
> 
> > +static int bd70528_direction_input(struct gpio_chip *chip, unsigned int offset)
> > +{
> > +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> > +
> > +       /* Do we need to do something to IRQs here? */
> 
> Hmmm?

Same thing as with the get_direction. Should we allow setting the
direction if pin is already configured as an irq source? Should we
somehow try to warn user if it seems the pin is tried to be used for
both irqs and I/O?

> 
> Apart from that it looks good. Feel free to add:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> on the next iteration.

I will need to do some further testing on this before submitting next
version. I will gladly maintain your Reviewed-by if I don't do any
bigger changes to the driver - but if I do I'll drop your tag and ask
for re-review :)

Br,
	Matti Vaittinen

Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353C5C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF6C21920
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfBNI3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:29:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33273 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfBNI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:29:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id q12so3927631lfm.0;
        Thu, 14 Feb 2019 00:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3iPjx8/UulQY/uFgVYx/0xPLNC8wW7LuIjtNQrjzbA=;
        b=qKBtKSzWGcmw0HcWqhB/ZBFP69KZeCqZAKgEpO6KgyK4vWZJ1L9R6n3OWNZOrOGppx
         dbNtR1gyXuEuNbZhhvRsbWzzsN/PTaU86+Tbyk3DW7csmKPozfaOWu/yY6w0k+3hPMSb
         mZwAJLYMlpmY8Vo+/MMwTPEvnpnjakfPAmaixyvKhIyRmLosTpzQLUwh0KBmwRuQe4AC
         XIpD+EcTFQdSYdC9/lhp1nwMjI2zx9SwEezGgwK5ilnLSFVkHHGl2/5U0g70qsdqLMfz
         TWdQo4slNL1Oq1ACPASncMUOkezOvYYU+ZkvAgvgxBW00OOEl0xih8giVPH2yDVGeBi1
         m8pw==
X-Gm-Message-State: AHQUAuZOqn2bAYzwlfu79sfTawxfkPjKuR8tQFdrtnMgswXQOBDKWT8s
        mGsq0kBb16qtrMz4HIBcNYk=
X-Google-Smtp-Source: AHgI3Ib5E6CfTUEUsUuHzYD/Fci7mf30jTD0K5kMjZvuyKajQ927KSa+qo15OUXlDP6Lcjl1/J4w8Q==
X-Received: by 2002:a19:a211:: with SMTP id l17mr1477474lfe.144.1550132944800;
        Thu, 14 Feb 2019 00:29:04 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y17-v6sm302082lja.94.2019.02.14.00.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 00:29:03 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:29:01 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v9 5/8] gpio: Initial support for ROHM bd70528 GPIO block
Message-ID: <20190214082901.GG12247@localhost.localdomain>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a bunch Linus,

On Thu, Feb 14, 2019 at 09:00:33AM +0100, Linus Walleij wrote:
> On Wed, Feb 13, 2019 at 2:34 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> 
> > ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> > controlled by GPIO framework.
> >
> > IRQs are handled by regmap-irq and GPIO driver is not
> > aware of the irq usage.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> (...)
> 
> Just spotted this:
> 
> > +#include <linux/gpio/driver.h>
> > +#include <linux/gpio.h>
> 
> A driver should only need <linux/gpio/driver.h>
> the <linux/gpio.h> should not be used at all in new code,
> it is a legacy header.

Allright. I'll do v10 and drop the header. Thanks for pointing this out

> > +static int bd70528_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
> > +                                  unsigned long config)
> > +{
> > +       struct bd70528_gpio *bdgpio = gpiochip_get_data(chip);
> > +
> > +       switch (pinconf_to_config_param(config)) {
> > +       case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > +               return regmap_update_bits(bdgpio->chip.regmap,
> > +                                         GPIO_OUT_REG(offset),
> > +                                         BD70528_GPIO_DRIVE_MASK,
> > +                                         BD70528_GPIO_OPEN_DRAIN);
> > +               break;
> > +       case PIN_CONFIG_DRIVE_PUSH_PULL:
> > +               return regmap_update_bits(bdgpio->chip.regmap,
> > +                                         GPIO_OUT_REG(offset),
> > +                                         BD70528_GPIO_DRIVE_MASK,
> > +                                         BD70528_GPIO_PUSH_PULL);
> > +               break;
> > +       case PIN_CONFIG_INPUT_DEBOUNCE:
> > +               return bd70528_set_debounce(bdgpio, offset,
> > +                                           pinconf_to_config_argument(config));
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +       return -ENOTSUPP;
> > +}
> 
> BTW I just merged code from Thomas Petazzoni that make it possible to
> also support pull-up and pull-down from GPIO here if you want to enable
> it.

Thanks for heads up Linus! I'll check it out although I don't want to
add up more changes in this series... But my initial feeling is that
this will deserve another patch (set) when initial support for BD70528
is available. (This answer is not locked, it may be I will fit the
change in this series if I am not buried under other duties ;] )

Br,
	Matti Vaittinen


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

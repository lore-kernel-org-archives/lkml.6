Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94142082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBDMZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:25:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44433 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfBDMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:25:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id z13so10155424lfe.11;
        Mon, 04 Feb 2019 04:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ESopPEv/8vslS0BJSYdv66QBL1idUE45V1McnV2zN9E=;
        b=IkU3Jr19ayqWgsjVEVB9fZo/liR9DVh9fyrqt6r1GOzlZ59z7ccwbZbBdvqCaFYLwQ
         HaiPYa8hQ8h35F5q1y+GDb5kHLOLTjV6aB4qaC3AKqayyU/ircYwQJPnf0ppifDMOQV3
         EB1Xyf2YSAidTuLYLvh+Hv0QYpPuYBvlXlsyaCS5oDKJTmFnm0WZq88cVr8Y06GLuyYQ
         mQWtMmgtH93ncdPpTgmFkPteCORKosfAI2UHSv4EpLB/IQ5qhpu8B2SXv2MlmRzTsu3M
         kY202bgrHCkMLplkoA2AJIK4SSjoKZvKZL3nxQ0s2sTC6838u17yYoSCnyg2pLeGUNJV
         3ZKA==
X-Gm-Message-State: AJcUukfVDcXDkTLIuZ7WanQ3GAux3l1wRSEDMacZphDfr+r+2VLopO/R
        027cdJWTiyLCU6W4M2Vs2iQ=
X-Google-Smtp-Source: ALg8bN6rYqILgNlKBMKoz656m/uGSY+mCcw1J59LKe+BBYtraLWCHvwE6d5vVPaqVT0a2DnI2fQzGg==
X-Received: by 2002:a19:4dd0:: with SMTP id a199mr41334933lfb.42.1549283114982;
        Mon, 04 Feb 2019 04:25:14 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t22sm3294025lfb.0.2019.02.04.04.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 04:25:14 -0800 (PST)
Date:   Mon, 4 Feb 2019 14:25:11 +0200
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
Subject: Re: [RFC PATCH v4 07/10] gpio: Initial support for ROHM bd70528 GPIO
 block
Message-ID: <20190204122511.GG23791@localhost.localdomain>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <5f63684b62c7a320c514088bcf9091ed7efbd2cc.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdauoQ=qcFUi7wTUKu22ZHeq=g0grWqvZz1gfOt0=dXrbw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:29:53PM +0100, Linus Walleij wrote:
> On Thu, Jan 31, 2019 at 1:08 PM Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com> wrote:
> 
> > ROHM BD70528 PMIC has 4 GPIO pins. Allow them to be
> > controlled by GPIO framework.
> >
> > IRQs are handled by regmap-irq and GPIO driver is not
> > aware of the irq usage.
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> (...)
> > I dropped the review-by from Linus Walleij because I would like to
> > get a comment on if locking is required when we check the direction
> > in order to detect the correct register for getting the pin state.
> 
> I don't know that. You isn't regmap locking inherently?

This direction fetching and then the value reading are two separate
operations at regmap-level. I guess the regmap can't be holding any
locks during two indpendent operations.

> 
> > My initial feeling is that locking makes no sense.
> 
> Mine too.

Yep. I change the comment to explain why I think this race condition
is Ok. We can fix it if it ever turns out to be an issue.

> 
> > +       bdgpio->gpio.get_direction = &bd70528_get_direction;
> > +       bdgpio->gpio.direction_input = &bd70528_direction_input;
> > +       bdgpio->gpio.direction_output = &bd70528_direction_output;
> > +       bdgpio->gpio.set_config = &bd70528_gpio_set_config;
> > +       bdgpio->gpio.can_sleep = true;
> > +       bdgpio->gpio.get = &bd70528_gpio_get;
> > +       bdgpio->gpio.set = &bd70528_gpio_set;
> 
> Drop the &ampersand in from of the functions. All functions
> are pointers.

Yes they are. This & in front of functions when initializing a pointer
with their addresss is my old habit. I liked to consistently use & when
taking address of any beast, whether it was a variable or function.
Getting rid of old habits is not so easy :/ I'll clean thisi at v5 and
put back your Reviewed-by =) Thanks
> 
> With that:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

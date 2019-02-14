Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31268C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090522229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438530AbfBNMiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:38:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45209 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfBNMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:38:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so5053129ljd.12;
        Thu, 14 Feb 2019 04:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W7aBDHpLqwsbXg+46EthmQ9h22ytdhiUY0yaqmEe9BA=;
        b=bWBLTGlme3rBpCi51TUhISqTQhLK9ZyPypZfJZsiaGDZrazlZArtdiwdjfAZU1WV30
         AJIaKdE45JlsEh4TYGvpf8DgxIuHbl+OD0Zbc8PXqUaNV3F6TxxAXFlmtBAhVnOyufaj
         plpSFHVxZS7RbsphWNz74KXnFwo70Vnkz40MC0+wcey+0YJBxET7lCJztrsWSipuvxLs
         WJWAKwMf8AfOHvd9VeWSxm5fLBruCpjtun6FmNWsbLljUJ3/J/6U4BvBeRVV/XQQdnP1
         zIXeLQnb9C6DCyeEy/0BNLBy8S375r6sJwYqCROefMUzUFDnYAkdRiT0wn8ZNyXy0sYz
         iXHg==
X-Gm-Message-State: AHQUAuYJbHKQgwsxxM5rseOi7i4ovD0N3YDWIp+SvHEnaKK0DR3FIev0
        V/U6JNolwQVvGmcCFM3tL2I=
X-Google-Smtp-Source: AHgI3IYIh801P++iA4l884EA/xSXWe5smqeKoHsp6NeITNkh2cyJUVSzj+WgwIItSAhkljQRwj+3cQ==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr2291653ljk.139.1550147890300;
        Thu, 14 Feb 2019 04:38:10 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id u24sm438649lfu.68.2019.02.14.04.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 04:38:09 -0800 (PST)
Date:   Thu, 14 Feb 2019 14:38:06 +0200
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
Message-ID: <20190214123806.GH12247@localhost.localdomain>
References: <cover.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <8334d6064575249e871e88aa6057b134795232e3.1550063882.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdYqSyWGSy6OKukE_SQWi1r0uOQD91JwpqUgrbJq28gbUQ@mail.gmail.com>
 <20190214082901.GG12247@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214082901.GG12247@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Thu, Feb 14, 2019 at 10:29:01AM +0200, Matti Vaittinen wrote:
> Thanks a bunch Linus,
> 
> On Thu, Feb 14, 2019 at 09:00:33AM +0100, Linus Walleij wrote:
> > On Wed, Feb 13, 2019 at 2:34 PM Matti Vaittinen
> > <matti.vaittinen@fi.rohmeurope.com> wrote:
> > 
> > Just spotted this:
> > 
> > > +#include <linux/gpio/driver.h>
> > > +#include <linux/gpio.h>
> > 
> > A driver should only need <linux/gpio/driver.h>
> > the <linux/gpio.h> should not be used at all in new code,
> > it is a legacy header.
> 
> Allright. I'll do v10 and drop the header. Thanks for pointing this out

It seems to me the GPIOF_DIR_XXX are defined in linux/gpio.h. It would
be nice to refer to these flags when interpreting the return value
from the bd70528_get_direction (used in bd70528_gpio_get) - and actually
it might be nice to use those as a return value from bd70528_get_direction.

But I'll go with raw values for now and leave possible definition
moving/header refactoring to you who know the direction of code better :)

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

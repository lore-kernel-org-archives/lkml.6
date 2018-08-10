Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC7C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AFF2240A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDK9R/7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AFF2240A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeHJNY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:24:59 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35548 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeHJNY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:24:59 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so2088629itf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crTen5KtIiDHqe+SK5UwT4YMhgKjSFxGKpkmJOya2oQ=;
        b=hDK9R/7GqzcqWXeDW2vLYlHtu9mkny2+bkApW3EOA3DYcwWqK2CCViBfuBj/4V6P1H
         RPTYFn7YQL6jyKB3fRGxUmISPjZJYftJ5REFdWuJSKlTQxvu7Ej1an5auT8Emi+M4qa2
         jOa+7IxaIzjY+TaSDcb8/CM9tEkXDCR5rBGJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crTen5KtIiDHqe+SK5UwT4YMhgKjSFxGKpkmJOya2oQ=;
        b=Nj6/XkPk36i08+o9PjfTtjpeGi7ix6NtOkLps9zgHjyChdh76mM5+GwA7sRK1m3e3T
         hj9MX0QQ+J417uGqisY9KiQznXVufpJOYvYYzZulwPuNmFcQ4a70DVIfBOTF1O9YV/UF
         hlafodus14uHliCoxvWiQ5ZTMNbBgDwhNyPu46gt3oTjNiDO2oKjQeOXz1IFwhAGI3tu
         WN7+j8p4nob9Eicgjf/+oE2ixiTFAd0QLMkpxbiUAVU/wogunlqWQcxsQ2+hjl29q7Dk
         w8Kl4Jgyn0lpBxNc63yQSPPDp13a8Df/h4c5aeA+rFisJNFJVH80FtlRUfzF7cI296XY
         2WAw==
X-Gm-Message-State: AOUpUlHSyDwkGuevK7EX7YZ0g/5RThrkPaWNSEEtrTpVdAbpdimmor1N
        qtcfIxPMEJMfIp9VW3je0S03WsbuZv86LpHwRB4a+Q==
X-Google-Smtp-Source: AA+uWPzpYKqjhDE6ezJCSWGM6VQ0uRal69MXN8+GcjQaLCyU6oDwAncxIaQcdFxBUyQsDODu/uN4KB7wd9r3J3zPVw4=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr1684651iti.135.1533898535334;
 Fri, 10 Aug 2018 03:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180806222918.12644-13-jmkrzyszt@gmail.com>
 <CACRpkdYHqFOFSv-erCzx8_u-mVUgGPdDH0ts-+DNAvjP3Qxb9w@mail.gmail.com>
 <11711552.OvaP4pOjBH@z50> <20180807194722.5aabb6da@bbrezillon>
In-Reply-To: <20180807194722.5aabb6da@bbrezillon>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 12:55:22 +0200
Message-ID: <CACRpkdbxSd+3jzFrs0+Ty-F4xHaDbPQOAR3TjRc0QChK=VsKxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap
 API functions
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Mark Vasut <marek.vasut@gmail.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 7:47 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
>
> > On Tuesday, August 7, 2018 1:43:56 AM CEST Linus Walleij wrote:
> > > On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > wrote:
> > >
> > > Hi Janusz!
> > >
> > > > Certain GPIO descriptor arrays returned by gpio_get_array() may contain
> > > > information on a single GPIO chip driving array member pins in hardware
> > > > order.  In such cases, bitmaps of values can be passed directly to the
> > > > chip callback functions without wasting time on iterations.
> > > >
> > > > Add respective code to gpiod_get/set_array_bitmap_complex() functions.
> > > >
> > > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > >
> > > I think it would be disappointing to leave all the users of the old
> > > array API without the performance improvement. I think we need to
> > > deal with this in a way such that everyone can benefit from it.
>
> I agree with Linus on that one. When I initially proposed the gpio
> bitbanging API I had something more advanced in mind where the GPIO
> framework would be responsible for toggling the GPIOs on its own when
> it's given an array of bytes to transmit (this way you avoid going
> back and forth between the GPIO user and the GPIO framework). But this
> approach would clearly be more invasive than what you propose
> here (turning the int array into a bitmap and optimizing). So, if we go
> for the "int array -> bitmap" approach I think all users should be
> converted so that we end up with a single API.

I thought about this the recent days and something must have gone
wrong in the development process of the array API because this
was the (mine atleast) intention all the time.

If we look at the GPIOchip driver API it looks like this:

        int                     (*get_multiple)(struct gpio_chip *chip,
                                                unsigned long *mask,
                                                unsigned long *bits);
        void                    (*set_multiple)(struct gpio_chip *chip,
                                                unsigned long *mask,
                                                unsigned long *bits);

So there is nothing hindering the drivers from optimizing a call
here into a single register write, which is what e.g. the gpio-mmio.c
driver does: if the hardware has a dedicated register for clearing
and setting lines, it will simply just write the register with
whatever is passed in, also cache the current value so it doesn't
need to read back the register every time.

When an array comes down to gpiod_set_array_value_complex()
it loops over the descriptors in order to handle e.g. open drain
settings separately. Then the remainder (lines that should just
be set 1/0) is pushed to the .set_multiple() callback if they
are on the same chip.

This is assuming:

1. The CPU is not the bottleneck so we can do a bit
  of complex looping over structs etc in each write.

2. We want to perform as much in a single register write
  as possible to avoid I/O and glitches as all lines (e.g.
  clock and data) get written at the same time, if possible.
  (No skew.)

It seems Janusz has problems with assumption (1) and therefore
is trying to optimize the read/write path. This can be done if all
descs are on the same chip and none of them is using open drain
or open source.

To keep track of "quick path" the array needs to have a state.
So a magic "cookie" or something like that needs to be passed
to the array API.

I would suggest that struct gpiod_descs contain a magic cookie
returned from [devm_]gpiod_get_array[_optional]()  that can be
passed along to get/set array operations or left as NULL to just
fall back to the default:

void gpiod_set_array_value(unsigned int array_size,
                           struct gpio_desc **desc_array, int *value_array,
                           struct gpiod_array_cookie *cookie);

Cookie is just a dummy name, I don't know what makes most
sense. It reflects a state for the entire array.

If this cookie exist in some struct gpio_chip state variable, it
informs gpiolib that this array:

- Has all descriptors in the same gpiochip
- Has no open drain or open source-flagged lines

It can thenbypass the complex check and just write the values
directly by calling down into .set_multiple().

Maybe this cookie could just be a bool that is true when the above
is fulfilled. But it's best if that is hidden from the consumers
I guess, they shouldn't try to half-guess if the criteria is true,
gpiolib should do that.

The current users would have to be augmented to store the
cookie and pass it along when getting/setting arrays, but it would
be pretty simple and straight-forward compared to adding a new
API.

Yours,
Linus Walleij

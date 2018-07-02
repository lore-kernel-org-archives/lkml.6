Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABC921A56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EjFblqB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABC921A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeGBR4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:56:54 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44356 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeGBR4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:56:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so8292452pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=NLpximiZkdzVulWqgLF8cYHSckBWxujlk9+VukWVlO8=;
        b=EjFblqB9TC8FEeG9bAWn08gkkDiEB5fTbkgjP5giaQ2vuzKUF4RioRnMmsKh+Fk2eK
         wFXPAHv8ANUG6nnUSB0mnga4Tnv9aXCjOlFTJKEP7D0A9t9qFiY5AVHV5+jp2HZq5TVI
         fphztaqwh2JDUFmg0HDvyWqgXcpObREMQnu78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=NLpximiZkdzVulWqgLF8cYHSckBWxujlk9+VukWVlO8=;
        b=sN/NjU7eTwgBtHlYBItNw2Fwm/FyAvKHF+NuI385VEt+2keMTVM2s3Xq5zpxpwtZyV
         dW/zKUgMlqLh2V7XfoBNJ6KZxcdHRYmIt8GmodsOl37tvIEQlgCjKLzO4dzs5G1exw08
         M5EUmFzoakrxuZzgRZ3/q3AjNGKltufFNBUcc4WA96FReZjaROTzj7uZSB5zBTsPRttY
         PVkCmTlZPNyoC8e+uNX7ei/YlxRZc8hM8vln3XWEAsQA/vpxtjcphLgLrPQhdLZYWvJp
         lSztbKn0iddvzqDW+3FBUWNcZ480GLDeJHXtL/kAcUWkxHV0e01mdu26zwPZq/nqp4Zu
         Zzeg==
X-Gm-Message-State: APt69E3Fsc+6uXfZ7Q8BjbDw2QBGvoaRVsP7jiauZkmIMTgoTl8Txz4A
        jBh48gXk+/nnxuLkd4EWvkRh+w==
X-Google-Smtp-Source: AAOMgpe6XkZj1z7idTMmRjYs7g+FylXVZeT5nc2vl9q9gNf+Ex0g2rqbv8EtKsqczLmXKpoL+Ee/xg==
X-Received: by 2002:a17:902:7888:: with SMTP id q8-v6mr21765077pll.79.1530554211271;
        Mon, 02 Jul 2018 10:56:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id b1-v6sm704738pff.141.2018.07.02.10.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 10:56:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Doug Anderson <dianders@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAD=FV=Xmo4p7DbOReO02JVKnykoAOz7PtnkbdwryxvpsgZCgWw@mail.gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20180618205255.246104-1-swboyd@chromium.org>
 <20180618205255.246104-3-swboyd@chromium.org>
 <20180622175836.GC3402@tuxbook-pro> <20180622183129.GD3402@tuxbook-pro>
 <CACRpkdZr5tKCjyO6Eq2vPPE8Lg+m+Ky_f24wYBSiLjdZuQ4WwA@mail.gmail.com>
 <153020606866.143105.1849265284764230975@swboyd.mtv.corp.google.com>
 <CAD=FV=Xmo4p7DbOReO02JVKnykoAOz7PtnkbdwryxvpsgZCgWw@mail.gmail.com>
Message-ID: <153055420964.143105.3738779882090053054@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
Date:   Mon, 02 Jul 2018 10:56:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2018-06-28 11:45:30)
> Hi,
> =

> On Thu, Jun 28, 2018 at 10:14 AM, Stephen Boyd <swboyd@chromium.org> wrot=
e:
> > Quoting Linus Walleij (2018-06-28 07:25:46)
> >> On Fri, Jun 22, 2018 at 8:29 PM Bjorn Andersson
> >> <bjorn.andersson@linaro.org> wrote:
> >> > On Fri 22 Jun 10:58 PDT 2018, Bjorn Andersson wrote:
> >> > > On Mon 18 Jun 13:52 PDT 2018, Stephen Boyd wrote:
> >> > >
> >> > > > We rely on devices to use pinmuxing configurations in DT to sele=
ct the
> >> > > > GPIO function (function 0) if they're going to use the gpio in G=
PIO
> >> > > > mode. Let's simplify things for driver authors by implementing
> >> > > > gpio_request_enable() for this pinctrl driver to mux out the GPIO
> >> > > > function when the gpio is use from gpiolib.
> >> > > >
> >> > > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> > >
> >> > > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> (...)
> >> > While both patch 2 and 3 are convenient ways to get around the annoy=
ance
> >> > of having to specify a pinmux state both patches then ends up relyin=
g on
> >> > some default pinconf state; which I think is bad.
> >
> > What default state are we relying on? The reset state of the pins? I'm
> > very confused by this statement. These last two patches are making sure
> > that when a GPIO is requested as a GPIO or IRQ, it's really in GPIO
> > mode. If this code is not in place, then we'll allow drivers to request
> > a GPIO but pinmuxing won't be called to actually mux that pin to GPIO
> > mode unless they have a DT conf for function =3D "gpio". That seems
> > entirely unexpected and easy to mess up.
> >
> >>
> >> Nothing stops you from setting up a default conf in
> >> this callback though.
> >>
> >> But admittedly this call was added for simpler hardware.
> >>
> >> > Further more in situations like i2c-qup (downstream), where the pins=
 are
> >> > requested as gpios in order to "bitbang" a reset this would mean that
> >> > the driver has to counter the convenience; by either switching in the
> >> > default pinmux at the end of probe or postponing the gpio_request() =
to
> >> > the invocation of reset and then, after issuing the gpio_release,
> >> > switching in the default pinmux explicitly again.
> >>
> >> That's a bigger problem. If the system is using device and GPIO
> >> mode orthogonally, it'd be good to leave like this.
> >>
> >
> > Doesn't that driver need to explicitly mux GPIO mode vs. device mode
> > right now? So having gpio_request() do the muxing to GPIO mode and then
> > explicit muxing of the pin to device mode would be what we have after
> > this patch, while before this patch we would have mux to GPIO, request
> > GPIO (nop), mux to device. We saved an explicit pinmux call?
> =

> After reading these replies I'm slightly worried about some of the
> stuff Bjorn is worried about too.  In Bjorn's example I think that the
> "default" state of the pins is probably i2c-mode and that it might
> switch to GPIO mode only when it needs to do the special unwedge of
> the i2c port.
> =

> So maybe the i2c driver does this:
> =

> 1. "Default" pinmux state of i2c is i2c-mode, "unwedge" pinmux state
> is gpio-mode.
> =

> 2. In probe, request the GPIOs for use later in case we need to
> unwedge.  Don't use them right now since we don't need to unwedge.
> Assumes pinmux state stays as "default".
> =

> 3. When you decide you need to unwedge the bus, pinmux to the special
> i2c mode and drive the pins you requested in probe.  Then pinmux back.
> =

> =

> ...I think your patch will break this because when you request the
> GPIOs you'll have an implicit (and unexpected?) pinmux transition.
> =

> What do you think?
> =

> =


I could do with some more clarity from Linus in the "Drivers needing
both pin control and GPIOs" section of
Documentation/driver-api/pinctl.rst but I read that section as stating
that the GPIO driver needs to mux the pin as a GPIO by requesting the
pinctrl backend to do so, unless the hardware overrides the muxed
function selection when the GPIO is used, without involving pinctrl
software.


Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1693EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DF62084C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="VbZ7i8wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfA2LAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:00:44 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39515 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfA2LAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:00:44 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so3794813itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RUhiqz4SSJvClvoKJtvEprWVdTxMEENIWrFPE2V5Wco=;
        b=VbZ7i8wn0xOREAaSogH6XaZ5OCyHGog0zMGxnf8c/oBY6XyAIlhKzN7L/XmBLfSiUb
         0ZqEClfawpWhM5DwfPA38ggerSE1DzdBB91C+xaMSD8Nb1q2gy6bBJuZWmHF92svGwjk
         Ppygdk9RW0VUni4POPXaQ2+M+v6A7ufPdvvUMEii4wzX2v2VxO4EU3PJMH4vZYUJm0qh
         WvNcAWlb9V7iB4tPpsUqzQNZuaNxYZ+woLBUvpzpNr+WKtEK3XcEg8auyfkFWQkgDItO
         tuhRMzWm6z6lo04gx2aS4Q8d+/Bn+SkxDN0BKMSBdeI3348dIas+3S//A4YeY1RxRKiD
         QBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RUhiqz4SSJvClvoKJtvEprWVdTxMEENIWrFPE2V5Wco=;
        b=UbFUxhtDiFrUQixgamt0wZMMnGS12OpUtm+XcuyEC2HPmkwWAwnVRgOCtOHYhFB7Bw
         GNy5rNJ1x+58dXkpOBEksuFBSPHUCqehqIccTgqajePpRCdTm9YnYqg2et/l7+Bg/xN6
         BpRwlPCWrkPiRtdotVheXbDPb+MyGwonWPNUCYu/lRDdIB7BVuHt5eFS+GI8Kcdonxlr
         B89jdG2Z/8nVh7iQHgAeAMJxw1mOR3nZixIoseRiL2jGkyxDG1P00an2mOU9F+q5x6NN
         llZBp4wOWSGUewNnATZsu8Lz/2ddOg2VJvEJiPmvDLKQ8X5D5K0OkGZqymU8GgMRdzJ5
         KbqQ==
X-Gm-Message-State: AJcUukcUOUHP/0LxGTsKHRoHoGhQoeiD0pd1gk+pWu0U71W/pzi2g/QY
        0YP+qXXHhpHRGiwrNq1pnPnp/fOi4W9AN6QeAaSAvA==
X-Google-Smtp-Source: ALg8bN6sALdqSFvYQxhElFpDQCWb0vmTyG38La3/qOeHz8xFShhRRbDST0Rwkk+aHqfsdxVpuMgmMlTJKff0XMJvpVE=
X-Received: by 2002:a24:7284:: with SMTP id x126mr13802895itc.96.1548759643091;
 Tue, 29 Jan 2019 03:00:43 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
 <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
 <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com> <CACRpkdacfOLSs1GPew4gMtL_BX0OTXqBQNWzWZMwAkk+Ah2ETQ@mail.gmail.com>
In-Reply-To: <CACRpkdacfOLSs1GPew4gMtL_BX0OTXqBQNWzWZMwAkk+Ah2ETQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Jan 2019 12:00:32 +0100
Message-ID: <CAMRc=MftwsuooC8vLmnGYiiKj2rVShXeuekTrho8JRihjiBJ+w@mail.gmail.com>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 24 sty 2019 o 11:30 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Mon, Jan 21, 2019 at 6:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > Thank you for your review. While I think you're right about the issue
> > being present in this driver, I'm not sure it's really a problem. Do
> > we actually require every gpio-controller to also be a stand-alone
> > interrupt-controller?
>
> Absolutely not :D
>
> Just GPIO is fine.
>
> > The binding document for the GPIO module doesn't
> > mention this - it only requires the gpio-controller property. Without
> > the "interrupt-controller" property dtc will bail-out if anyone uses
> > this node as the interrupt parent.
> >
> > If I'm wrong and we do require it, then I think we need to update
> > Documentation/devicetree/bindings/gpio/gpio.txt.
>
> What is weird is if a driver with DT bindings not mentioning IRQ
> and only probing from DT start implementing IRQ support, that
> becomes quite inconsistent. So then max77650_gpio_to_irq()
> should just return -ENOTSUPP
> or something for now, then it's fine.
>

I don't see it as weird at all. I see the need to define the register
and interrupt resources in DT for SoC peripherals becaue SoCs often
reuse IPs. But in the case of a self-contained i2c PMIC - the modules
such as GPIO are tightly coupled with the core functionality. In the
case of this device for example: there isn't even a separate set of
mask/status registers for GPIO interrupts.

Most mfd devices setup the resources in a hard-coded manner.

> We can add the (complicated) IRQ handling later.
>
> I am trying to eat my own dogfood here, I was sweating all
> last night trying to implement a hierarchical IRQ controller.
> There is no running away from that now. :/
>
> Apparently doing hierarchical IRQs demand that all irq
> controllers up to the top-level SoC IRQ controller support
> hierarchical interrupts using the v2 version of the irqdomain
> API, and currently it seems like the ARM
> GIC seems like the only top level IRQ controller that can
> do that.
>

Yep, and for that reason I can't use the regmap irq_chip abstraction
for now because it doesn't implement support for hierarchical
interrupts either.

How about the cascaded gpiochip irq_chip?

Best regards,
Bartosz

Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4E6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A232147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tGImw29C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfA2NWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:22:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34582 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfA2NWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:22:12 -0500
Received: by mail-io1-f67.google.com with SMTP id b16so16309034ior.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wIWaIsd4IeVKGOT8ZDYtQy2OZmbN9N7gWb6nl2/X1VM=;
        b=tGImw29C2M+KMBY5gUuCCc0gudm2/UI05RC+KTfwOSAiqJbUJnlEHFSdM6NGci/AEU
         2dX0IpY4mmHk/ruN2hAYDGz7rbYppooKfiKlAbN/xfoQYr2e+dzJX1nS1qAIGHPQJvfo
         SDoBuX9c/NRj12n9Vj/Z4oVRdWfx/hnndsxEAaVau8nhtPU0NTEBviVRUTfe7u79cnOy
         i0iQ70Rr3pw9vagjmXOmUY1UL9EThpdxnSjNOfB4jEPOHWm707P6c5wGIZRRNfiW15Bh
         dOcvMOjDnStTPUUxbOefFFS/Dq1k/8Sh+HQVeul4RS/AbewaIt0ZXcWSRUldBCmsW89S
         UvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wIWaIsd4IeVKGOT8ZDYtQy2OZmbN9N7gWb6nl2/X1VM=;
        b=JVp0gEJVHzeegpwefUNZo0c7pTbgDETUOk7OsuWG/s0cxtnc9/7o0ojvujZWs2IleZ
         RFO6H9REXRDHNuik6JIjK+bBFPclkSh4w+BqQPNbz36aK8YxHwQv4/z/NT9GzWCHYoLZ
         okqiq5vKxW5MKEe6+3JO7Un5Eexj7LiooO9kMNScGvQ82VHvTavtNB+ahQG/JJ6pRtdB
         nOX3yEyBXsGMEFFnURSdIjKHlUcZIoh4wsOZ/EeM6k5auSUNnJlDpKLE8YtPAbHcJdgu
         d+O8c/pejejT8K//LNJCFIsBoloDfL2Ce3cGtf5gddeJrIEhdvqlBJf/lLjW+yEh47wl
         Fugw==
X-Gm-Message-State: AHQUAualf4QQEveg/UhaCLnlntVQ1Dj5gRfiavt7d8VyYawav1zE+4jd
        6tA4F210F87wywJhUCo9zkEit/kUgSV5vxzVZHsW9g==
X-Google-Smtp-Source: AHgI3IaYfdrBpk5y5tbB8WBKnaMVl+zh6L0cXPmhizdPTs1kj8hkCSuAemXcKZ8QN5HZ5bftBCBEgtF8SI5bX+Vt9Eo=
X-Received: by 2002:a5d:928b:: with SMTP id s11mr16387362iom.111.1548768131091;
 Tue, 29 Jan 2019 05:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
 <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
 <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
 <CACRpkdacfOLSs1GPew4gMtL_BX0OTXqBQNWzWZMwAkk+Ah2ETQ@mail.gmail.com> <CAMRc=MftwsuooC8vLmnGYiiKj2rVShXeuekTrho8JRihjiBJ+w@mail.gmail.com>
In-Reply-To: <CAMRc=MftwsuooC8vLmnGYiiKj2rVShXeuekTrho8JRihjiBJ+w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Jan 2019 14:22:00 +0100
Message-ID: <CAMRc=Mewf0p1v+afVKDhg8FJHip09ipt3_uO5uYtJP75HyuCSQ@mail.gmail.com>
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

wt., 29 sty 2019 o 12:00 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> czw., 24 sty 2019 o 11:30 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
> >
> > On Mon, Jan 21, 2019 at 6:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> >
> > > Thank you for your review. While I think you're right about the issue
> > > being present in this driver, I'm not sure it's really a problem. Do
> > > we actually require every gpio-controller to also be a stand-alone
> > > interrupt-controller?
> >
> > Absolutely not :D
> >
> > Just GPIO is fine.
> >
> > > The binding document for the GPIO module doesn't
> > > mention this - it only requires the gpio-controller property. Without
> > > the "interrupt-controller" property dtc will bail-out if anyone uses
> > > this node as the interrupt parent.
> > >
> > > If I'm wrong and we do require it, then I think we need to update
> > > Documentation/devicetree/bindings/gpio/gpio.txt.
> >
> > What is weird is if a driver with DT bindings not mentioning IRQ
> > and only probing from DT start implementing IRQ support, that
> > becomes quite inconsistent. So then max77650_gpio_to_irq()
> > should just return -ENOTSUPP
> > or something for now, then it's fine.
> >
>
> I don't see it as weird at all. I see the need to define the register
> and interrupt resources in DT for SoC peripherals becaue SoCs often
> reuse IPs. But in the case of a self-contained i2c PMIC - the modules
> such as GPIO are tightly coupled with the core functionality. In the
> case of this device for example: there isn't even a separate set of
> mask/status registers for GPIO interrupts.
>
> Most mfd devices setup the resources in a hard-coded manner.
>
> > We can add the (complicated) IRQ handling later.
> >
> > I am trying to eat my own dogfood here, I was sweating all
> > last night trying to implement a hierarchical IRQ controller.
> > There is no running away from that now. :/
> >
> > Apparently doing hierarchical IRQs demand that all irq
> > controllers up to the top-level SoC IRQ controller support
> > hierarchical interrupts using the v2 version of the irqdomain
> > API, and currently it seems like the ARM
> > GIC seems like the only top level IRQ controller that can
> > do that.
> >
>
> Yep, and for that reason I can't use the regmap irq_chip abstraction
> for now because it doesn't implement support for hierarchical
> interrupts either.
>
> How about the cascaded gpiochip irq_chip?
>
> Best regards,
> Bartosz

Nah that won't work either without a proper hierarchy...

In that case, let's leave out the irq support for now. I'll send v2.

Bart

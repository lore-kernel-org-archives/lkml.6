Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42999ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28EC20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28EC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbeGXQXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:23:05 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36961 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388298AbeGXQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:23:04 -0400
Received: by mail-vk0-f67.google.com with SMTP id v72-v6so2211424vkd.4;
        Tue, 24 Jul 2018 08:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/XpYZ9gPWMhLH10ZDNqCIR0cUhfKNwuqICAPldKfQc=;
        b=CZ/T/GghEH/XmsuNedu4bapwu3UXIrCMtQ6vOJV7/YigbA0QNluv3knc72/som9iiB
         kxU2cV13BSO96tRsYCttZet3lzd7q2BEG8XXW9W//3J3QF0teOi29w+8oXrqS/uvSzIg
         0C2a/yD9tzboRQDLj44wwseXOxvicX5HLHk2RfE+JjpAm7blMaU1tLIwAAKMj/KW+DR6
         lD+wFbdBh4ZJ30f1lGyP+/6QV1FNapkBtms/ZwE6lhGZd4aYbxCZMA0OuJENkTTMXXu0
         lg0sFt/liTWfjcqWO3wIK96RNVcBv0AMKLq/Os1zFTsFHG38sj0jW7rR2YwQypjhdnde
         JtmQ==
X-Gm-Message-State: AOUpUlHmoLRvTemxTlizyegSlq8oW68lInykt4ZHlzEExX7Cc7tJ5K4d
        oLRhH6KR1uNMW68jwE3vYDtoOGEG66owNIMCsJZd6g==
X-Google-Smtp-Source: AAOMgpdzt4LUPOI6OKrE2FznymXpfBLRxNe8CqMzsld+sdnDoultkVTLoSj5SSFoLZbXHWYB+nyoaLrhe4oS22app4w=
X-Received: by 2002:a1f:420d:: with SMTP id p13-v6mr10715856vka.10.1532445366167;
 Tue, 24 Jul 2018 08:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
In-Reply-To: <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jul 2018 17:15:53 +0200
Message-ID: <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, pgaj@cadence.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jul 24, 2018 at 5:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 24, 2018 at 4:28 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Tue, 24 Jul 2018 16:03:38 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Fri, Jul 20, 2018 at 3:17 PM, Boris Brezillon
> >> <boris.brezillon@bootlin.com> wrote:
> >> > On Fri, 20 Jul 2018 13:28:10 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> On Fri, Jul 20, 2018 at 1:13 PM, Peter Rosin <peda@axentia.se> wrote:
> >> >> > On 2018-07-20 12:57, Arnd Bergmann wrote:
> >> >> >> * What I understand from reading i2c-demux-pinctrl.c, a slave device
> >> >> >>   will only ever be observable from one master at a time, when you
> >> >> >>   switch over, all children get removed on one master and added to
> >> >> >>   the other one, to be probed again by their respective drivers.
> >> >> >>   I can see this as a useful feature on i3c as well, in particular to
> >> >> >>   deal with the situation where we have i2c slaves connected to a
> >> >> >>   pinmux that can switch them between an i3c master and an
> >> >> >>   i2c-only master (possibly a gpio based one). That particular use
> >> >> >>   case however doesn't seem to fix well in the current code, which
> >> >> >>   is structure around i3c buses.
> >> >> >
> >> >> > It's pretty easy to come up with examples where this reprobing is
> >> >> > not desirable at all. E.g. if one of the involved I2C devices is
> >> >> > a HDMI encoder (I have a TDA19988 here) sitting in the middle of the
> >> >> > graphics pipeline. Blink-blink on the screen because some *other*
> >> >> > unrelated device needed to be accessed by an alternative master. Not
> >> >> > pretty.
> >> >>
> >> >> Agreed, we definitely don't want to reprobe all devices during normal
> >> >> operation for i3c master handover.
> >> >>
> >> >
> >> > Re-probing would not happen, no matter the solution we choose. It's
> >> > that, in one case, you would have X virtual/linux devices representing
> >> > the same physical device and in the other case, you would just have
> >> > one, and everytime a transfer is requested by the driver, the core
> >> > would pick the appropriate master to do it (most likely the one in
> >> > control of the bus at that time)
> >>
> >> I think this is one of the cases I'd want to avoid: controlling multiple
> >> masters that are active at the same time without going through
> >> the handover.
> >
> > That's simply not possible, the I3C protocol forbids it. There can only
> > be one active master on the bus at any point in time.
>
> Ok, it sounded like that's what you wanted to do here.
>
> >> If we have an actual pinmux between two masters and only one
> >> of them can even see the bus, I think we should go through a
> >> complete remove/probe cycle the way that the i2c-demux-pinctrl
> >> does today. If OTOH we a primary/secondary master pair with
> >> handover capability, I would prefer to not see one slave on
> >> both devices at the same time, or (ideally) only use one of the
> >> two masters and disable the other one completely.
> >
> > Again, you don't have a choice because it's part of the protocol. At
> > any time, you only have one active master on the bus, and other masters
> > are acting as slaves until they gain bus ownership (if they ever do).
> > Say that device A wants to do an HDR transfer on the bus, and HDR is
> > only supported by master X, but master Y is currently owning the bus.
> > Master X will first have to request bus ownership before doing the
> > transfer requested by device A.
> >
> > Now, imagine that device A wants to do an SDR transfer which is
> > supported by both master X and master Y, and master Y is in control.
> > Instead of requesting a bus handover, the framework would just
> > automatically decide to do the transfer through master Y. That's the
> > sort of things this separate bus/master representation allows.
>
> That's not the case I was describing here, I was thinking of what
> Wolfram described with the Renesas SoC that has two i2c masters
> multiplexed through the pinmux layer. I would assume that we
> can still do the same thing in i3c by shutting down the current
> master without a handover, and reprobing everything from scratch.

The major disadvantage of reprobing is that it may cause visual disturbances
when i2c slaves are involved with e.g. the display pipeline (think HDMI encoders
etc.).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

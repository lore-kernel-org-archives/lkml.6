Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB79ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CE420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CE420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbeGXSBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:01:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41270 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbeGXSBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:01:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E1B8D2072C; Tue, 24 Jul 2018 18:54:16 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 20107206A6;
        Tue, 24 Jul 2018 18:54:16 +0200 (CEST)
Date:   Tue, 24 Jul 2018 18:54:15 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
Message-ID: <20180724185415.6126751e@bbrezillon>
In-Reply-To: <CAK8P3a0wcmeFKvRf7=FTNvePayc2AxniHoNkLOuzQQCt=MiLjQ@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
        <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
        <20180720101206.tv7nsoanwo5ftnia@ninjato>
        <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
        <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se>
        <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
        <20180720151751.242d4809@bbrezillon>
        <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
        <20180724162806.318a92c6@bbrezillon>
        <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
        <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
        <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
        <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
        <CAK8P3a17t=_o04GsowS2RnTwKKVxt8KuJtT36N=Ea-SOq7fTow@mail.gmail.com>
        <20180724181437.1d1b27a8@bbrezillon>
        <CAK8P3a0wcmeFKvRf7=FTNvePayc2AxniHoNkLOuzQQCt=MiLjQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 18:25:22 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Tue, Jul 24, 2018 at 6:14 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> > On Tue, 24 Jul 2018 17:58:29 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  
> >> On Tue, Jul 24, 2018 at 5:46 PM, Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:  
> >> > On Tue, Jul 24, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:  
> >> >> On Tue, Jul 24, 2018 at 5:15 PM, Geert Uytterhoeven
> >> >> <geert@linux-m68k.org> wrote:  
> >> >> > On Tue, Jul 24, 2018 at 5:05 PM Arnd Bergmann <arnd@arndb.de> wrote:  
> >> The second case is the one that started the discussion, and
> >> this is where I said I'd prefer to associate each slave with at
> >> most one master at boot time, while the current v6 patch
> >> is prepared for having one slave be accessed alternatingly
> >> by multiple masters using the master handover, though so
> >> far nobody has been able to describe exactly how we'd pick
> >> which master is active at what point,  
> >
> > Even if it's not yet implemented, I have everything in place to figure
> > this out (see the ->cur_master field in the i3c_bus object). Now,
> > what's missing is a list of possible masters attached to an i3c device
> > so that the framework can pick the most appropriate one at runtime and
> > initiate mastership handover if required (if the selected master is not
> > the currently active one).
> >
> > The selection logic should look like this:
> >
> >         if (active_master supports requested feature)
> >                 use active master
> >         else
> >                 pick an inactive one that has relevant caps and initiate
> >                 mastership handover (+ update bus->cur_master)  
> 
> How would you deal with soft requirements like performance?
> E.g. if you have one master that can do large transfers faster
> through a special DMA engine, and other master that can
> be faster for small transfers, but both support all capabilities
> for that device, won't you need some complex logic to avoid
> being stuck with a slow master indefinitely?

True.

> 
> >> or what specific scenario
> >> would require it.  
> >
> > I think I described a scenario (masters having different
> > capabilities all connected to the same bus), though I don't know how
> > likely this use case is :-/.  
> 
> I was looking for something more specific here. What (lack of)
> capabilities could two i3c controllers have that require you to
> use both of them for the same device, rather than picking
> a master for each slave with the right feature set?

Hehe, if I had a clear answer to this question we wouldn't have this
discussion :-). I gave you an example:

- master A supporting IBIs but not HDR transactions
- master B supporting HDR modes but not IBIs

but as I said, I'm not sure how likely this example is...

The question is more, should we design things so that we can at some
point implement a solution to support those funky setups, or should we
just ignore it and risk breaking sysfs/DT ABI when/if we have to support
that?

This is really an open question. I initially went for the former, but
have no objection switching to the latter.

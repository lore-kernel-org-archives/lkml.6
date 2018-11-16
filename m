Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B6EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4FC2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB4FC2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbeKPX3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:29:23 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48093 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeKPX3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:29:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B7B8D20742; Fri, 16 Nov 2018 14:16:59 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id B78B120D72;
        Fri, 16 Nov 2018 14:16:39 +0100 (CET)
Date:   Fri, 16 Nov 2018 14:16:39 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        "Cyprian Wronka" <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "Rafal Ciepiela" <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Message-ID: <20181116141639.31074113@bbrezillon>
In-Reply-To: <5f946406-a205-3802-aefd-ebd8b5a72b0b@synopsys.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
        <20181115135731.25f60990@bbrezillon>
        <20181115150137.GB4169@kunai>
        <20181115162826.42b54776@bbrezillon>
        <1d64f21a-ad24-94e0-2c17-25729ef59a31@synopsys.com>
        <20181115200058.1869afdb@bbrezillon>
        <5f946406-a205-3802-aefd-ebd8b5a72b0b@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 12:31:42 +0000
vitor <vitor.soares@synopsys.com> wrote:

> Hi Boris,
> 
> 
> On 15/11/18 19:00, Boris Brezillon wrote:
> > On Thu, 15 Nov 2018 18:03:47 +0000
> > vitor <vitor.soares@synopsys.com> wrote:
> >  
> >> Hi Boris,
> >>
> >>
> >> On 15/11/18 15:28, Boris Brezillon wrote:  
> >>> On Thu, 15 Nov 2018 16:01:37 +0100
> >>> Wolfram Sang <wsa@the-dreams.de> wrote:
> >>>     
> >>>> Hi Boris,
> >>>>     
> >>>>> What we could do though, is expose I3C devices that do not have a
> >>>>> driver in kernel space, like spidev does.  
> >>>> ...
> >>>>     
> >>>>> Mark, Wolfram, Arnd, Greg, any opinion?  
> >>>> Is there a benefit for having drivers in userspace? My gut feeling is to
> >>>> encourage people to write kernel drivers. If this is, for some reason,
> >>>> not possible for some driver, then we have a use case at hand to test
> >>>> the then-to-be-developed userspace interface against. Until then, I
> >>>> personally wouldn't waste effort on designing it without a user in
> >>>> sight.  
> >>> I kind of agree with that. Vitor, do you have a use case in mind for
> >>> such userspace drivers? I don't think it's worth designing an API for
> >>> something we don't need (yet).  
> >> My use case is a tool for tests, lets say like the i2c tools.  
> > What would you like to test exactly?
> >  
> >> There is
> >> other subsystems, some of them mentioned on this thread, that have and
> >> ioctl system call or other method to change parameters or send data.  
> > I don't think they added the /dev interface before having a real use
> > case for it.
> >  
> >>
> >> I rise this topic because I really think it worth to define now how this
> >> should be design (and for me how to do the things right) to avoid future
> >> issues.  
> > Actually it should be done the other way around: you should have a real
> > need and the /dev interface should be designed to fulfill this need.
> > Based on this real use case we can discuss other potential usage that
> > might appear in the future and try to design something more
> > future-proof, but clearly, this userspace interface should be driven by
> > a real/well-defined use case.
> >
> > Also, exposing things to userspace is way more risky than adding a new
> > in-kernel subsystem/framework, because it then becomes part of the
> > stable ABI.
> >
> > To make things clearer, I'm not against the idea of exposing I3C
> > devices (or I3C buses) to userspace, but I'd like to understand what you
> > plan to do with that. If this is about testing, what kind of tests
> > you'd like to run. If this is about developing drivers in userspace,
> > why can't these be done in kernel space (license issues?), and what
> > would those drivers be allowed to do?  
> 
> 
> Basically I need a tool that help me during the development and to avoid 
> me to write a dummy driver for each device that I test.

But we want I3C device drivers to be upstreamed, so why not developing a
real driver everytime you test a new device and submitting it upstream?

> 
> For instances do some read/write,

Doing SDR/DDR transfers is probably acceptable, but I still think we
should push hard to have kernel drivers when that's possible.

> get/set ccc commands,

Exposing CCC commands is definitely not a good idea, since they're not
even exposed to kernel drivers.

> if something 
> goes wrong during the bus initialization have a to debug etc...

Can't we add such a debug infrastructure in the kernel. Maybe we can
expose debugfs files too if that helps, though if those debugfs files
are actually used by userspace libs/tools, it's not any better than
ioctls or sysfs files, since they will anyway become a stable ABI.

> 
> 
> For me this is a valid use case and I imagine when people start to 
> develop in i3c this interface will help everyone.

How about you propose an i3cdev driver that allow users to do SDR
transfers throuh an ioctl?

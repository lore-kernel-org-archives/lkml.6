Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A16CC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEBE20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfAUPLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:11:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60765 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfAUPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:11:13 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glbE9-0002GD-2R; Mon, 21 Jan 2019 16:11:05 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1glbE7-0006A3-W5; Mon, 21 Jan 2019 16:11:03 +0100
Date:   Mon, 21 Jan 2019 16:11:03 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190121151103.vdwkgte4a5ybyrid@pengutronix.de>
References: <1547194964-16718-1-git-send-email-yash.shah@sifive.com>
 <1547194964-16718-3-git-send-email-yash.shah@sifive.com>
 <20190115220046.etgbno6ymsux75dk@pengutronix.de>
 <CAJ2_jOEuU_=bpbVmdsq7FFEKEm_wHza-h7Hu8QmZ3BgsGgi-ng@mail.gmail.com>
 <20190116164640.mi3zjbhbhc6k5v7p@pengutronix.de>
 <alpine.DEB.2.21.9999.1901160909540.19681@viisi.sifive.com>
 <20190116172849.h5qdfa5wc3vaprbn@pengutronix.de>
 <alpine.DEB.2.21.9999.1901161015400.19681@viisi.sifive.com>
 <20190117081956.hpj4ewdihpwuoonz@pengutronix.de>
 <20190121115455.GJ16756@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190121115455.GJ16756@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thierry,

On Mon, Jan 21, 2019 at 12:54:55PM +0100, Thierry Reding wrote:
> On Thu, Jan 17, 2019 at 09:19:56AM +0100, Uwe Kleine-König wrote:
> > On Wed, Jan 16, 2019 at 11:29:35AM -0800, Paul Walmsley wrote:
> > > COMPILE_TEST made slightly more sense before the broad availability of 
> > > open-source soft cores, SoC integration, and IP; and before powerful, 
> > > inexpensive FPGAs and SoCs with FPGA fabrics were common.
> > > 
> > > Even back then, COMPILE_TEST was starting to look questionable.  IP blocks 
> > > from CPU- and SoC vendor-independent libraries, like DesignWare and the 
> > > Cadence IP libraries, were integrated on SoCs across varying CPU 
> > > architectures.  (Fortunately, looking at the tree, subsystem maintainers 
> > > with DesignWare drivers seem to have largely avoided adding architecture 
> > > or SoC-specific Kconfig restrictions there - and thus have also avoided 
> > > the need for COMPILE_TEST.)  If an unnecessary architecture Kconfig 
> > > dependency was added for a leaf driver, that Kconfig line would either 
> > > need to be patched out by hand, or if present, COMPILE_TEST would need to 
> > > be enabled.
> > > 
> > > This was less of a problem then.  There were very few FPGA Linux users, 
> > > and they were mostly working on internal proprietary projects. FPGAs that 
> > > could run Linux at a reasonable speed, including MMUs and FPUs, were 
> > > expensive or were missing good tool support.  So most FPGA Linux 
> > > development was restricted to ASIC vendors - the Samsungs, Qualcomms, 
> > > NVIDIAs of the world - for prototyping, and those FPGA platforms never 
> > > made it outside those companies.
> > > 
> > > The situation is different now.  The major FPGA vendors have inexpensive 
> > > FPGA SoCs with full-featured CPU hard macros.  The development boards can 
> > > be quite affordable (< USD 300 for the Xilinx Ultra96).  There are also 
> > > now open-source SoC HDL implementations - including MMUs, FPUs, and 
> > > peripherals like PWM and UART - for the conventional FPGA market.  These 
> > > can run at mid-1990's clock rates - slow by modern standards but still 
> > > quite usable.
> > 
> > In my eyes it's better to make a driver not possible to enable out of
> > the box than offering to enable it while it most probably won't be used.
> 
> This might sound like a good idea in general, but it's also something
> that is pretty much impossible to do. There's just no heuristic that
> would allow you to determine with a sufficient degree of probability
> that a driver won't be needed. Most of the PCI drivers that are
> installed on my workstation aren't used, and I would venture to say
> there are a lot of drivers that aren't used in, say, 95% of
> installations. That doesn't mean that we should somehow make these
> drivers difficult to install, or require someone to patch the kernel
> to build them.

If there is a PCI card that can be plugged into your machine, the
corresponding driver should be selectable for the matching kernel.

The case here is different though. We're talking about a piece of
hardware that up to now only exists in a riscv machine (IIUC). Yes, I'm
aware that the design is publicly available, still I think this driver
should not be available for a person configuring a kernel for their x86
machine. When you (or someone else) comes around claiming that they have
a real use for this driver on a non-riscv architecture I support
expanding the dependency accordingly.

What I want to make aware of is that being able to enable a driver comes
at a (small) cost. Using a too broad dependency is quite usual because
the person who introduces a given symbol usually doesn't have to think
long if it should be enabled for a given kernel config or not; so it's
"only" other people's time that is wasted.

> > People who configure their own kernel and distribution kernel
> > maintainers will thank you. (Well ok, they won't notice, so they won't
> > actually tell you, but anyhow.) I'm a member of the Debian kernel team
> > and I see how many config items there are that are not explicitly
> > handled for the various different kernel images. If they were restricted
> > using COMPILE_TEST to just be possible to enable on machines where it is
> > known (or at least likely) to make sense that would help. Also when I do
> > a kernel version bump for a machine with a tailored kernel running (say)
> > on an ARM/i.MX SoC, I could more easily be careful about the relevant
> > changes when doing oldconfig if I were not asked about a whole bunch of
> > drivers that are sure to be irrelevant.
> 
> I think the important thing here is that the driver is "default n". If
> you're a developer and build your own kernels, you're pretty likely to
> know already if a new kernel that you're installing contains that new
> driver that you've been working on or waiting for.

If you are a developer waiting for your driver you also would not miss
it because it was only selectable for riscv but you're the first who
synthesized it for an arm machine. So there is only little damage.

> In that case you can easily just enable it manually rather than go
> through make oldconfig and wait for it to show up.
> 
> As for distribution kernel maintainers, are they really still building a
> lot of different kernels?

In the Debian kernel there are as of now 39 kernel images. Some of them
only differ by stuff that is irrelevant for driver selection (like rt).
But apart from these there is still mostly only a single image available
for a given machine because multi-platform efforts are not good enough
to allow cross-architecture kernels. Or kernels that can handle both big
and little endian.

> If so, it sounds like most of the multi-platform efforts have been in
> vain. I would imagine that if, as a distribution kernel team, you'd
> want to carefully evaluate for every driver whether or not you'd want
> to include it.

The Debian distro kernel I'm running has a .config file with 7317 config
items (grep CONFIG /boot/config-$(uname -r) | wc -l). 1922 of them are
disabled (grep is\ not\ set /boot/config-$(uname -r) | wc -l). If you
find the time to only go through the 1922 options that are disabled for
this amd64 kernel, tell me, I provide you the config file.

> I would also imagine that you'd want to provide your users with the
> most flexible kernel possible, so that if they do have a system with
> an FPGA that you'd make it possible for them to use pwm-sifive if they
> choose to synthesize it.

I would today probably choose to not enable pwm-sifive for Debian on a
non-riscv arch kernel because nobody told to have a use for it and the
cost of enabling the driver is that it takes hard disk space for several
thousand machines without any use.

And given that we here have the knowledge that up to now PWM_SIFIVE=[ym]
is only usable on riscv, I think we should put that into the
condition that makes the driver selectable. It's not hard for a distro
maintainer to find the same information; say it takes 5 minutes (that
works here because the driver under discussion has a link to the
reference manual in the header). Multiply that by the count of drivers.

> If you really want to create custom builds tailored to a single chip or
> board, it's going to be a fair amount of work anyway.

Ah right, this is a hard job, so it doesn't make a difference when we
make it a little bit harder?

> I've occasionally done that in the past and usually just resorted to
> starting from an allnoconfig configuration and then working my way up
> from there.
> 
> As for daily work as a developer, when I transition between kernel
> versions, or from one linux-next to another, I typically end up doing
> the manual equivalent of:
> 
> 	$ yes '' | make oldconfig

I usually start with $(make oldconfig) without the yes part. But when I
get 10th question in a row that is completely irrelevant for my target
machine because it doesn't have the graphics core that is found only on
Samsung ARM SoCs or the nand controllers that can only be found on some
powerpc machines I'm annoyed and I press and hold the Enter key.
I'm well aware that I'm missing some interesting stuff then, though,
which is sad.

> if I know that I'm not interested in any new features. But I also often
> just look at what's new because it's interesting to see what's been
> going on elsewhere.

The kernel config as a way to see what is going on elsewhere is a use
case that is broken by my preferred approach. Be warned that you already
miss stuff today if you only look there.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

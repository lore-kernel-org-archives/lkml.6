Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB445C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AAA208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IXcBuGW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AAA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbeHAMYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:24:15 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38030 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbeHAMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0YB9BThmTaCFlel0HY9fVRZLeFRXFWo0RKnRV1XJ12g=; b=IXcBuGW2Wilj0MECm8kSoR1mn
        uzC42SCeqGdwP4ws+cNy0LnCmXESwULNj42toPDWBYFrKsbI9X8mec4JgkaTmOU+7rR6Pbbd7+KSE
        EEXm4jcrCkUSr6QrM6wwJGi1S1NM8UzMWdAIY7E/aix/uW0jPMd47iY1cGDZ87FM7+QN4=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:59574)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkoWx-00036r-QG; Wed, 01 Aug 2018 11:38:59 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkoWu-0002ZE-MI; Wed, 01 Aug 2018 11:38:56 +0100
Date:   Wed, 1 Aug 2018 11:38:55 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Alex Bounine <alex.bou9@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, John Paul Walters <jwalters@isi.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Colin <acolin@isi.edu>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180801103855.GD30658@n2100.armlinux.org.uk>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
 <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <20180731155228.GN17271@n2100.armlinux.org.uk>
 <044af717-3883-a7a6-c346-18fa8cebce76@gmail.com>
 <20180731181834.GA30658@n2100.armlinux.org.uk>
 <570ad147-3c58-8911-0111-29e21087ca7a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570ad147-3c58-8911-0111-29e21087ca7a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 04:01:27PM -0400, Alex Bounine wrote:
> On 2018-07-31 02:18 PM, Russell King - ARM Linux wrote:
> >On Tue, Jul 31, 2018 at 01:59:27PM -0400, Alex Bounine wrote:
> >>On 2018-07-31 11:52 AM, Russell King - ARM Linux wrote:
> >>>On Tue, Jul 31, 2018 at 08:54:14AM -0400, Alex Bounine wrote:
> >>>>On 2018-07-31 04:41 AM, Will Deacon wrote:
> >>>>>On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
> >>>>>>Platforms with a PCI bus will be offered the RapidIO menu since they may
> >>>>>>be want support for a RapidIO PCI device. Platforms without a PCI bus
> >>>>>>that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >>>>>>in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>>>>>
> >>>>>>Tested that kernel builds for arm64 with RapidIO subsystem and
> >>>>>>switch drivers enabled, also that the modules load successfully
> >>>>>>on a custom Aarch64 Qemu model.
> >>>>>>
> >>>>>>Cc: Andrew Morton <akpm@linux-foundation.org>
> >>>>>>Cc: Russell King <linux@armlinux.org.uk>
> >>>>>>Cc: John Paul Walters <jwalters@isi.edu>
> >>>>>>Cc: linux-arm-kernel@lists.infradead.org
> >>>>>>Cc: linux-kernel@vger.kernel.org,
> >>>>>>Signed-off-by: Alexei Colin <acolin@isi.edu>
> >>>>>>---
> >>>>>>  arch/arm64/Kconfig | 2 ++
> >>>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>>Thanks, this looks much cleaner than before:
> >>>>>
> >>>>>Acked-by: Will Deacon <will.deacon@arm.com>
> >>>>>
> >>>>>The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> >>>>>unconditionally in the arm64 Kconfig. Does selecting only that option
> >>>>>actually pull in new code to the build?
> >>>>>
> >>>>HAS_RAPIDIO option is intended for SOCs that have built in SRIO controllers,
> >>>>like TI KeyStoneII or FPGAs. Because RapidIO subsystem core is required
> >>>>during RapidIO port driver initialization, having separate option allows us
> >>>>to control available build options for RapidIO core and port driver (bool
> >>>>vs. tristate) and disable module option if port driver is configured as
> >>>>built-in.
> >>>
> >>>Your explanation doesn't make much sense to me.
> >>>
> >>>RAPIDIO is the bus-level support, right?  So drivers that depend on
> >>>the bus-level support should depend on RAPIDIO, and so, if RAPIDIO
> >>>is configured as a module, they will also be allowed to be disabled
> >>>or a module, but not built-in if tristate.  If it is boolean, and
> >>>causes the driver to be built-in to the kernel, then you need to use
> >>>"RAPIDIO=y" so that it's dependency is only satisfied when the core
> >>>is built-in.
> >>>
> >>
> >>RapidIO host controllers (on local bus like SoC internal or PCIe) are
> >>serviced by MPORT device drivers that are subsystem specific and communicate
> >>with RapidIO core using set of callbacks. Depending on HW architecture these
> >>drivers may be defined as built-in or module.
> >
> >Why does hardware architecture define whether something has to be built
> >in or can be modular?
> >
> >It is the case today that (eg) on-SoC hardware _can_ be built as a module
> >if desired - just because it's on the SoC does not mean it has to be
> >built in to the kernel.  Why is RapidIO any different?
> >
> 
> Not HW architecture - legacy can be blamed as well. Freescale's FSL_RIO
> driver still exist as built-in so far. Intent of this patch set is to allow
> RapidIO support in more architectures without reworking old stuff.
> I do not think that anyone will be updating FSL_RIO driver soon.

Sorry, but I'm even more confused.  If it's not hardware architecture,
then why did you say previously "Depending on HW architecture these
drivers may be defined as built-in or module." ?

If it's that the driver isn't written to be a module, then that is not
"HW architecture".  Are you just trying to muddy the water?

> Also we cannot dictate to developers of future drivers which method to use -
> they may have built-in option only for the first release.

How is that any different from all the other drivers that we have?

If a driver can only be built-in, then we do this in the Kconfig:

config DRIVERFOO
	bool "Support driverfoo"
	depends on SUBSYSTEM=y

which ensures that the driver can only be built when it's dependent
subsystem is also built-in.

There is another alternative way, which is:

config SUBSYSTEM
	tristate

config DRIVERFOO
	bool "Support driverfoo"
	select SUBSYSTEM

config DRIVERBAR
	tristate "Support driverbar"
	select SUBSYSTEM

and "SUBSYSTEM" will automatically adopt either 'm' or 'y' correctly
depending on whether any drivers are built-in or not.

> Unfortunately we have on hands dependency between mport driver build mode
> and  RapidIO core which we need to respect.

How is that any different from (eg) hundreds of network drivers and the
networking core code that we already have?  That doesn't have such a
convoluted configuration system, and what you have is much simpler.

> >For example, can you point out why my idea I present below would not
> >work?
> 
> See below.
> 
> >
> >>For peripheral devices attached to the RapidIO fabric such dependency on
> >>local mport implementation does not exist and therefore they all can be
> >>treated as tristate.
> >>
> >>>HAS_RAPIDIO gives the impression that it defines whether or not
> >>>the rapidio core code is allowable or not - it doesn't suggest that
> >>>it has anything to do with drivers. However, reading the PowerPC
> >>>Kconfig files, it seems to be used that way.  That's confusing, and
> >>>ought to be fixed.  From what I can tell, it's only used for FSL_RIO,
> >>>so I suggest that gets converted to:
> >>>
> >>>config HAS_RAPIDIO
> >>>	bool PCI
> 
> PCI and RAPIDIO can be mutually exclusive.

Please explain this in light of your patches which contain:

config RAPIDIO
	tristate "RapidIO support"
	depends on HAS_RAPIDIO || PCI

This allows RAPIDIO can be selected when PCI is enabled.  Therefore,
PCI and RAPIDIO *are not* mutually exclusive as your comment above
states, therefore, I have to assume that your comment is wrong.

> >>>
> >>>config RAPIDIO
> >>>	tristate "RapidIO support"
> >>>	depends on HAS_RAPIDIO
> >>>
> >>>config HAS_FSL_RIO
> >>>	bool
> >>>	select HAS_RAPIDIO
> 
> Introducing new variable HAS_FSL_RIO here. Do you suggest having one for
> each ARM-based board that has on-chip RIO?

No, I'm suggesting a solution for what I see in the kernel tree today,
which is frankly a mess for the reasons I've already outlined.

HAS_FSL_RIO is based on the _only_ SoC driver apparently in the tree
based on what I could find in the arch/*/Kconfig files.  If you don't
think having individual HAS_* options in this way is appropriate,
then maybe instead having per-SoC hidden HAS_* config options are
more appropriate.

> >>>
> >>>config FSL_RIO
> >>>	bool "Freescale Embedded SRIO Controller support"
> >>>	depends on RAPIDIO = y && HAS_FSL_RIO
> >>>
> >>>This frees up HAS_RAPIDIO to operate as one would expect - to define
> >>>whether or not RAPIDIO should be offered.  This also allows:
> >>>
> >>>config ARM
> >>>	select HAS_RAPIDIO if PCI
> 
> Some SOCs can be configured without PCI. We have confusing action here - we
> have to enable PCI on platform that does not have it.

Again, you said above "PCI and RAPIDIO can be mutually exclusive."  This
comment self-conflicts with your previous comment.

What you now seem to be saying goes against the patches and the current
Kconfig.  You seem to be saying that RAPIDIO _requires_ PCI.

So, we now have three completely different statements from you:
- "we have to enable PCI on platform that does not have it."
- "PCI and RAPIDIO can be mutually exclusive."
- RAPIDIO does not require PCI (since HAS_RAPIDIO=y RAPIDIO=y PCI=n is
  a permissible configuration as things stand with PowerPC.)

Which is it?

It seems to be that your replies are just muddying the water - I can
only assume that this is to make us give up.  Please don't do that,
it's not in your interest.

> Why we cannot use "select HAS_RAPIDIO" HW-specific Kconfig file
> (mach-*/Kconfig)? And have on-chip port selection in the same board-specific
> place.

As I've already explained, HAS_RAPIDIO has the expectation that it
controls the availability of the RAPIDIO option, not of drivers.
It is HAS_*RAPIDIO*, the clue is in the name.  Using it as you are
(basically, to mean that on-SoC rapidio hardware is present) and
allowing such configurations as HAS_RAPIDIO=n RAPIDIO=y PCI=y is
completely counter-intuitive.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

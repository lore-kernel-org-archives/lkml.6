Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB2AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B1620844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="US75g5OM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B1620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732478AbeGaRdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:33:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53406 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732401AbeGaRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wNI9i8IzBCIMhdLmy/FeBfWFchv2a1Npr8+VwOKPHSA=; b=US75g5OMQJy7shwlPHPY9mZvN
        939aaE8nz8VILLr8jFsmV+dDPs17BFY143L46Ud2qQH46LEAFPytNiATltsLCosZIU6Zg6i4XAalE
        6G26oI4V8FK7kks3bTNEgaOnNcNw4ksl3+AFNbQ0IlXxBQI/Zicy5XFLpXtScGrQmfMNk=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:56062)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkWwq-00070L-KY; Tue, 31 Jul 2018 16:52:32 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkWwo-0007c2-0A; Tue, 31 Jul 2018 16:52:30 +0100
Date:   Tue, 31 Jul 2018 16:52:28 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Alex Bounine <alex.bou9@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>, Alexei Colin <acolin@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180731155228.GN17271@n2100.armlinux.org.uk>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
 <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 08:54:14AM -0400, Alex Bounine wrote:
> On 2018-07-31 04:41 AM, Will Deacon wrote:
> >On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
> >>Platforms with a PCI bus will be offered the RapidIO menu since they may
> >>be want support for a RapidIO PCI device. Platforms without a PCI bus
> >>that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> >>in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> >>
> >>Tested that kernel builds for arm64 with RapidIO subsystem and
> >>switch drivers enabled, also that the modules load successfully
> >>on a custom Aarch64 Qemu model.
> >>
> >>Cc: Andrew Morton <akpm@linux-foundation.org>
> >>Cc: Russell King <linux@armlinux.org.uk>
> >>Cc: John Paul Walters <jwalters@isi.edu>
> >>Cc: linux-arm-kernel@lists.infradead.org
> >>Cc: linux-kernel@vger.kernel.org,
> >>Signed-off-by: Alexei Colin <acolin@isi.edu>
> >>---
> >>  arch/arm64/Kconfig | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> >Thanks, this looks much cleaner than before:
> >
> >Acked-by: Will Deacon <will.deacon@arm.com>
> >
> >The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> >unconditionally in the arm64 Kconfig. Does selecting only that option
> >actually pull in new code to the build?
> >
> HAS_RAPIDIO option is intended for SOCs that have built in SRIO controllers,
> like TI KeyStoneII or FPGAs. Because RapidIO subsystem core is required
> during RapidIO port driver initialization, having separate option allows us
> to control available build options for RapidIO core and port driver (bool
> vs. tristate) and disable module option if port driver is configured as
> built-in.

Your explanation doesn't make much sense to me.

RAPIDIO is the bus-level support, right?  So drivers that depend on
the bus-level support should depend on RAPIDIO, and so, if RAPIDIO
is configured as a module, they will also be allowed to be disabled
or a module, but not built-in if tristate.  If it is boolean, and
causes the driver to be built-in to the kernel, then you need to use
"RAPIDIO=y" so that it's dependency is only satisfied when the core
is built-in.

HAS_RAPIDIO gives the impression that it defines whether or not
the rapidio core code is allowable or not - it doesn't suggest that
it has anything to do with drivers.  However, reading the PowerPC
Kconfig files, it seems to be used that way.  That's confusing, and
ought to be fixed.  From what I can tell, it's only used for FSL_RIO,
so I suggest that gets converted to:

config HAS_RAPIDIO
	bool PCI

config RAPIDIO
	tristate "RapidIO support"
	depends on HAS_RAPIDIO

config HAS_FSL_RIO
	bool
	select HAS_RAPIDIO

config FSL_RIO
	bool "Freescale Embedded SRIO Controller support"
	depends on RAPIDIO = y && HAS_FSL_RIO

This frees up HAS_RAPIDIO to operate as one would expect - to define
whether or not RAPIDIO should be offered.  This also allows:

config ARM
	select HAS_RAPIDIO if PCI

to be added to arch/arm/Kconfig if appropriate.  However, I'm not yet
convinced that _just because_ we have PCI does not mean that RAPIDIO
should be offered.  I stated a series of questions about that last
Tuesday in response to an individual patch adding rapidio to arch/arm,
and that email seems to have been ignored - at least as far as the
questions go.

Please ensure that you respond to your reviewers questions, otherwise
you will start receiving plain NAKs to your patches instead (since
it becomes a waste of time for reviewers to put any further effort
in to explain why they don't like the patch.)

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

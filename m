Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA37C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C18E241DE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EWPHepUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C18E241DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932973AbeFVMcS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:32:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41330 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeFVMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/oYwQ9CasCR6MYO2ydiGhVpwnMsP1qStB6wlXLe4uKU=; b=EWPHepUv0SSiHReKW/4wh/FMl
        mwQmYoiCqbeijoBH6R5K7QWLkRNVQca+7rbBgSep7lPtkop80ZDNEKlmbLJ74BcTqsxBXpdoKyPTS
        Hv1l5849Vx26MrGHF2VVizQ5puiswJXrpEsV2rcfmPikFMLPUGKXExKG4NYoZE53Omoes=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:39928)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fWLEJ-0001Qm-Gd; Fri, 22 Jun 2018 13:31:55 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fWLEG-0002mP-Gt; Fri, 22 Jun 2018 13:31:52 +0100
Date:   Fri, 22 Jun 2018 13:31:50 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
Message-ID: <20180622123150.GV17671@n2100.armlinux.org.uk>
References: <20180621155906.12821-1-geert+renesas@glider.be>
 <20180622092305.GS17671@n2100.armlinux.org.uk>
 <CAMuHMdUqBhR4Ra=hF0TZKxgQHaE_KBUYh04ZTTmg1pRWtjveoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUqBhR4Ra=hF0TZKxgQHaE_KBUYh04ZTTmg1pRWtjveoQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:41:37PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> Thanks for your comments!
> 
> On Fri, Jun 22, 2018 at 11:23 AM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Thu, Jun 21, 2018 at 05:59:06PM +0200, Geert Uytterhoeven wrote:
> > > "ARM multiplatform" has actually two meanings:
> > >   1. It groups platforms that follow the "ARM multiplatform" software
> > >      framework,
> > >   2. It allows to build a single kernel that can be booted on multiple
> > >      platforms.
> > >
> > > Currently support for XIP and/or NOMMU cannot be enabled on platforms
> > > that follow the "ARM multiplatform" framework, without duplicating their
> > > machine selection logic under a new Kconfig symbol.  As (in theory) all
> > > platforms can be used with XIP and/or NOMMU, this is not sustainable.
> >
> > The reason for that has nothing to do with the way this option is named,
> > and even after reading your commit message, I can't come up with any
> > reason for this change other than "personally don't like the existing
> > wording" which IMHO is not a good enough reason to randomly go around
> > rewording stuff in the kernel.
> >
> > The reason that XIP and NOMMU can't be enabled with a multi-platform
> > kernel is that there are often issues with different layouts of the
> > physical memory space which can not be taken into account.
> >
> > Multi-platform works around that by (a) using the MMU to abstract
> > away the differences on RAM, and (b) modifying the kernel text to
> > adjust the virtual to physical translations.  The latter is not
> > possible with XIP, and the former should not be used with NOMMU.
> > That means the kernel must be built to accomodate the physical
> > layout on the target platform, and so building a kernel supporting
> > multiple platforms with differing memory layouts makes no sense.
> >
> > This is exactly why I really don't like the idea of ARCH_MULTIPLATFORM
> > being hijacked for NOMMU/XIP support.
> 
> That's multiplatform meaning #2.
> 
> But as long as MMU=y and XIP_KERNEL=n, nothing would change.
> 
> > We've worked around the issues with "multi-platform" XIP/NOMMU by
> > using things such as "ARM_SINGLE_V7M" to cover all V7M platforms
> > (which must, by definition) have compatible physical layouts.
> > Exactly the same approach should be adopted for other XIP/NOMMU
> > platforms, and _not_ reusing ARCH_MULTIPLATFORM, which will lead
> > to lots of non-bootable kernels.
> 
> So we need ARM_SINGLE_ARMV7A, and let all subarchitectures depend on
> ARCH_MULTIPLATFORM || ARM_SINGLE_ARMV7M, to avoid duplicating
> their SoC entry?
> 
> I had a quick look. So we have e.g. MACH_STM32F746 under ARM_SINGLE_ARMV7M,
> and MACH_STM32MP157 under ARCH_MULTI_V7.
> But according to stm32mp157c-ed1.dts and stm32746g-eval.dts both have
> memory at the same address, so it should be possible to run the same nommu
> kernel on the STM32MP157?
> 
> MACH_STM32F469 is also under ARM_SINGLE_ARMV7M, but according to
> stm32f469-disco.dts, memory may be at a completely different address?
> Doesn't that lead to unbootable kernels, too?

It's probably an error in the dts.  Cortex M7, like previous Cortex M
CPUs, has a CPU defined memory layout.  This is documented in the
Cortex M7 processor reference manual, figure 2.1.

As you point out, stm32746g-eval.dts specifies a memory region.  This
memory region is:

        memory {
                reg = <0xc0000000 0x2000000>;
        };

However, this conflicts with the Cortex M7 processor reference manual,
which states that physical addresses between 0xa0000000 and 0xe0000000
are "external device" (that is, they are treated as "device" accesses
not "memory" accesses).  So, it is highly unlikely that there is memory
at the location specified in the DTS.

NOMMU kernels are linked at PAGE_OFFSET + TEXT_OFFSET in the same way
as MMU kernels are linked, where PAGE_OFFSET comes from
CONFIG_PAGE_OFFSET.  The difference for NOMMU is that CONFIG_PAGE_OFFSET
is the same as CONFIG_PHYS_OFFSET, which is the same as CONFIG_DRAM_BASE.

stm32 as a whole defines CONFIG_DRAM_BASE as 0x90000000 which is common
to all.

It does not appear that we have defconfigs for the V7M AT91 nor iMX
kernels, so we can't draw any conclusions about what value this
configuration takes, but as 0x90000000 is defined to be "external
memory" by the Cortex M7 processor reference manual, I'd expect these
to be the same.

> > Another problems for NOMMU is that the kernel has to be linked for
> > a specific _physical_ address.  When you have ARCH_MULTIPLATFORM
> > enabled, there is no facility to select that address.
> 
> That can be easily solved with Kconfig symbols that depend on !MMU,
> can't it?

Given that (as I've illustrated above) modern MMU-less ARM CPUs have
well defined memory layouts, how is this any different from our
current approach.

Yes, we might not be saying "ARM_MACHINES_WITH_DRAM_BASE_90000000" -
such a thing would be meaningless to the guy configuring the kernel
(could you guess before I sent this email that Cortex M7 should
have RAM at that address? - probably not.)  So, Kconfig symbols based
on RAM addresses don't work.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

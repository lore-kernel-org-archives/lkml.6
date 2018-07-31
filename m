Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D198C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A9020862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="O94uiA2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A9020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbeGaRkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:40:42 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:53538 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbeGaRkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YArAK94z9j5FazqKnwnMMcSQsW2kq4dCAZK97+iATZs=; b=O94uiA2Uv/FtnFRrHi4TsCo1i
        DzOY4cHAdnQouWGzNrlkbck7kjOEprUyIOSDjDpKKx7EeCRObVV9VjPCNk30QzzTJaGva33/CjUtS
        M9M2Yoqcq5jxjldvObNBwCJCkJtvnrqvYmdhMJc47G/78CoRMmUxZFnjCXjmZqGr17mqI=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:45942)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkX3Q-00072T-H8; Tue, 31 Jul 2018 16:59:20 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkX3J-0007hB-RC; Tue, 31 Jul 2018 16:59:14 +0100
Date:   Tue, 31 Jul 2018 16:59:09 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Alexei Colin <acolin@isi.edu>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Matt Porter <mporter@kernel.crashing.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/6] rapidio: move Kconfig menu definition to
 subsystem
Message-ID: <20180731155909.GO17271@n2100.armlinux.org.uk>
References: <20180731142954.30345-1-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731142954.30345-1-acolin@isi.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the thread associated with this patch set, a review of a previous
patch for ARM posted last Tuesday on this subject asked a series of
questions about the PCI-nature of this.  The review has not been
responded to.

If it is inappropriate to offer RapidIO for any architecture that
happens to has PCI, then it is inappropriate to offer it for any
ARM machine that happens to have PCI.

In light of the lack of explanation on this point so far, I'm naking
the ARM part of this series for now.

I also think that the HAS_RAPIDIO thing is misleading and needs
sorting out (as I've mentioned in other emails, including the one
I refer to above) before rapidio becomes available more widely.

On Tue, Jul 31, 2018 at 10:29:48AM -0400, Alexei Colin wrote:
> Resending the patchset from prior submission:
> https://lkml.org/lkml/2018/7/30/911
> 
> The only change are the Cc tags in all patches now include the mailing
> lists for all affected architectures, and patch 1/6 (which adds the menu
> item to RapdidIO subsystem Kconfig) is CCed to all maintainers who are
> getting this cover letter. The cover letter has been updated with
> explanations to points raised in the feedback.
> 
> 
> 
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfig files. This set of
> patches does two things:
> 
> 1. Move the Kconfig menu definition into the RapidIO subsystem and
> remove the duplicate definitions from arch Kconfig files.
> 
> 2. Enable RapidIO Kconfig menu entry for arm and arm64 architectures,
> where it was not enabled before. I tested that subsystem and drivers
> build successfully for both architectures, and tested that the modules
> load on a custom arm64 Qemu model.
> 
> For all architectures, RapidIO menu should be offered when either:
> (1) The platform has a PCI bus (which host a RapidIO module on the bus).
> (2) The platform has a RapidIO IP block (connected to a system bus, e.g.
> AXI on ARM). In this case, 'select HAS_RAPIDIO' should be added to the
> 'config ARCH_*' menu entry for the SoCs that offer the IP block.
> 
> Prior to this patchset, different architectures used different criteria:
> * powerpc: (1) and (2)
> * mips: (1) and (2) after recent commit into next that added (2):
>   https://www.linux-mips.org/archives/linux-mips/2018-07/msg00596.html
>   fc5d988878942e9b42a4de5204bdd452f3f1ce47
>   491ec1553e0075f345fbe476a93775eabcbc40b6
> * x86: (1)
> * arm,arm64: none (RapidIO menus never offered)
> 
> This set of architectures are the ones that implement support for
> RapidIO as system bus. On some platforms RapidIO can be the only system
> bus available replacing PCI/PCIe.  As it is done now, RapidIO is
> configured in "Bus Options" (x86/PPC) or "Bus Support" (ARMs) sub-menu
> and from system configuration option it should be kept this way.
> Current location of RAPIDIO configuration option is familiar to users of
> PowerPC and x86 platforms, and is similarly available in some ARM
> manufacturers kernel code trees. (Alex Bounine)
> 
> HAS_RAPIDIO is not enabled unconditionally, because HAS_RAPIDIO option
> is intended for SOCs that have built in SRIO controllers, like TI
> KeyStoneII or FPGAs. Because RapidIO subsystem core is required during
> RapidIO port driver initialization, having separate option allows us to
> control available build options for RapidIO core and port driver (bool
> vs.  tristate) and disable module option if port driver is configured as
> built-in. (Alex Bounine)
> 
> Responses to feedback from prior submission (thanks for the reviews!):
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593347.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593349.html
> 
> Changelog:
>   * Moved Kconfig entry into RapidIO subsystem instead of duplicating
> 
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.
> 
> We appreciate the suggestion for also selecting the RapdiIO subsystem for
> compilation with COMPILE_TEST, but hope to address it in a separate
> patchset, localized to the subsystem, since it will need to change
> depends on all drivers, not just on the top level, and since this
> patch now spans multiple architectures.
> 
> Alexei Colin (6):
>   rapidio: define top Kconfig menu in driver subtree
>   x86: factor out RapidIO Kconfig menu
>   powerpc: factor out RapidIO Kconfig menu entry
>   mips: factor out RapidIO Kconfig entry
>   arm: enable RapidIO menu in Kconfig
>   arm64: enable RapidIO menu in Kconfig
> 
>  arch/arm/Kconfig        |  2 ++
>  arch/arm64/Kconfig      |  2 ++
>  arch/mips/Kconfig       | 11 -----------
>  arch/powerpc/Kconfig    | 13 +------------
>  arch/x86/Kconfig        |  8 --------
>  drivers/rapidio/Kconfig | 15 +++++++++++++++
>  6 files changed, 20 insertions(+), 31 deletions(-)
> 
> -- 
> 2.18.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

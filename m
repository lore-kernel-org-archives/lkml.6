Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC6C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9493F20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZKPHQyKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9493F20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJYSX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:23:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57416 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeJYSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DMYUfrzGm67RQwAYb+Dc7BRuNsrESyqorLWObdoCMoU=; b=ZKPHQyKcMinQF8nTFQOsHNQ1F
        BSmqvxTgmRJ5mU25+jB7J1Rb5qDYn1EAWyXpOfuy9jogo1jEdKT51bw9M57W4TA3fwEbFwmdWAVWs
        DdLVmkVSpdSB3x3yV+XUtfLpmlsDDgWrDZGcYPmME/k+zfecASxYewOJKQc/gba53gulw=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:43699)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFcIo-0006y6-5K; Thu, 25 Oct 2018 10:51:42 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFcIj-0004rh-Kl; Thu, 25 Oct 2018 10:51:37 +0100
Date:   Thu, 25 Oct 2018 10:51:34 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
        Openrisc <openrisc@lists.librecores.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-parisc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
Message-ID: <20181025095134.GX30658@n2100.armlinux.org.uk>
References: <20181024193256.23734-1-f.fainelli@gmail.com>
 <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
 <20181025093833.GA23607@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025093833.GA23607@rapoport-lnx>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:38:34AM +0100, Mike Rapoport wrote:
> On Wed, Oct 24, 2018 at 02:55:17PM -0500, Rob Herring wrote:
> > On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > > Hi all,
> > >
> > > While investigating why ARM64 required a ton of objects to be rebuilt
> > > when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> > > because we define __early_init_dt_declare_initrd() differently and we do
> > > that in arch/arm64/include/asm/memory.h which gets included by a fair
> > > amount of other header files, and translation units as well.
> > 
> > I scratch my head sometimes as to why some config options rebuild so
> > much stuff. One down, ? to go. :)
> > 
> > > Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
> > > systems that generate two kernels: one with the initramfs and one
> > > without. buildroot is one of these build systems, OpenWrt is also
> > > another one that does this.
> > >
> > > This patch series proposes adding an empty initrd.h to satisfy the need
> > > for drivers/of/fdt.c to unconditionally include that file, and moves the
> > > custom __early_init_dt_declare_initrd() definition away from
> > > asm/memory.h
> > >
> > > This cuts the number of objects rebuilds from 1920 down to 26, so a
> > > factor 73 approximately.
> > >
> > > Apologies for the long CC list, please let me know how you would go
> > > about merging that and if another approach would be preferable, e.g:
> > > introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
> > > something like that.
> > 
> > There may be a better way as of 4.20 because bootmem is now gone and
> > only memblock is used. This should unify what each arch needs to do
> > with initrd early. We need the physical address early for memblock
> > reserving. Then later on we need the virtual address to access the
> > initrd. Perhaps we should just change initrd_start and initrd_end to
> > physical addresses (or add 2 new variables would be less invasive and
> > allow for different translation than __va()). The sanity checks and
> > memblock reserve could also perhaps be moved to a common location.
> >
> > Alternatively, given arm64 is the only oddball, I'd be fine with an
> > "if (IS_ENABLED(CONFIG_ARM64))" condition in the default
> > __early_init_dt_declare_initrd as long as we have a path to removing
> > it like the above option.
> 
> I think arm64 does not have to redefine __early_init_dt_declare_initrd().
> Something like this might be just all we need (completely untested,
> probably it won't even compile):

The alternative solution would be to replace initrd_start/initrd_end
with physical address versions of these everywhere - that's what
we're passed from DT, it's what 32-bit ARM would prefer, and seemingly
what 64-bit ARM would also like as well.

Grepping for initrd_start in arch/*/mm shows that there's lots of
architectures that have virtual/physical conversions on these, and
a number that have obviously been derived from 32-bit ARM's approach
(with maintaining a phys_initrd_start variable to simplify things).

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

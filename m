Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29761C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D532083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mbKKc5uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4D532083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbeGaO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:28:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51144 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729723AbeGaO2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0+dPhruWmjmb8JDzovbVp/84Ly/vN48kd3FHBzISaxA=; b=mbKKc5uKyrSVu9iKSXCpAILrN
        nR+BcJmv5X5qjKON0fiep7B678lipcpmMlAaVywwSpqjBe8LaukZF8BNY5TNZ8kBs9oN6SmitT6FS
        M49WQGbwb8jHXI9OARKtXoJng8Q2fu2HpX0Hc0yQgfdqBc7iG/Q+XEe3OIQqJ657muD0A=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:53746)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fkU4b-0006Fi-7Z; Tue, 31 Jul 2018 13:48:21 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fkU4Y-0005YX-Kt; Tue, 31 Jul 2018 13:48:18 +0100
Date:   Tue, 31 Jul 2018 13:48:17 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Alex Bounine <alex.bou9@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexei Colin <acolin@isi.edu>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] arm: enable RapidIO menu in Kconfig
Message-ID: <20180731124815.GK17271@n2100.armlinux.org.uk>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-6-acolin@isi.edu>
 <20180731120428.GA5696@infradead.org>
 <3784698f-bd9d-6d02-6fa4-2f6057e4c93f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3784698f-bd9d-6d02-6fa4-2f6057e4c93f@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 08:43:02AM -0400, Alex Bounine wrote:
> On 2018-07-31 08:04 AM, Christoph Hellwig wrote:
> >On Mon, Jul 30, 2018 at 06:50:33PM -0400, Alexei Colin wrote:
> >>diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>index afe350e5e3d9..602a61324890 100644
> >>--- a/arch/arm/Kconfig
> >>+++ b/arch/arm/Kconfig
> >>@@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
> >>  source "drivers/pci/Kconfig"
> >>+source "drivers/rapidio/Kconfig"
> >
> >Please include this from drivers/Kconfig instead of enabling it
> >for a completely random set of architectures.
> >
> This is not a random set of architectures but only ones that implement
> support for RapidIO as system bus.
> 
> On some platforms RapidIO can be the only system bus available replacing
> PCI/PCIe.
> 
> As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or "Bus
> Support" (ARMs) sub-menu and from system configuration option it should be
> kept this way.
> 
> Current location of RAPIDIO configuration option is familiar to users of
> PowerPC and x86 platforms, and is similarly available in some ARM
> manufacturers kernel code trees.

... which is why you have a HAS_RAPIDIO thing and select it from
arch/*/Kconfig as I suggested in my original review of your patch
set.

As I've also said, I'm unable to review what you've sent this time
around because I don't have all your patches.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

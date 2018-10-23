Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB9FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272E320671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TYWtVl1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272E320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeJWRO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:14:57 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52754 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeJWRO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zmUXFEV6IkLnfea5ZbMTFeqbY20LU3a2Qil9JcHTH6k=; b=TYWtVl1DXUfFtNbkWwI2ITjlY
        o5gnsUcJxyFBret4Ho6wiPZa9P3yAMf5B+sTlROWv5SMeTXhdRvvvDSPIiXmVt+CUAa4zZJjbuHoJ
        qpaNc7FvUXikbRfJqgaWT9IMSOdpZw7GQ2afxmaUVwt28Gn5MxHtSkEwam1i7dl9SWCXs=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:39521)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gEsQL-0003dW-Lh; Tue, 23 Oct 2018 09:52:25 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gEsQA-0001JK-Cg; Tue, 23 Oct 2018 09:52:14 +0100
Date:   Tue, 23 Oct 2018 09:52:09 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: socfpga: Clean unused functions
Message-ID: <20181023085208.GL30658@n2100.armlinux.org.uk>
References: <20181009112021.756-1-peron.clem@gmail.com>
 <CAJiuCceqyPY+dYr+1xdSyUh5x1Fr=M_p1nsMF9h52v5CXt1uYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCceqyPY+dYr+1xdSyUh5x1Fr=M_p1nsMF9h52v5CXt1uYw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:47:05AM +0200, Clément Péron wrote:
> Hi Dinh / Russell,
> 
> Could you have a look at these patchs please ?

Nothing to do with me - it's up to the socfpga maintainer and arm-soc
maintainers.

> Thanks,
> Clement
> 
> On Tue, 9 Oct 2018 at 13:20, Clément Péron <peron.clem@gmail.com> wrote:
> >
> > These functions are unused externally, removed them and declare
> > the one used locally as static.
> >
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > ---
> >  arch/arm/mach-socfpga/core.h    | 2 --
> >  arch/arm/mach-socfpga/socfpga.c | 2 +-
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> > index 65e1817d8afe..92cae0a9213f 100644
> > --- a/arch/arm/mach-socfpga/core.h
> > +++ b/arch/arm/mach-socfpga/core.h
> > @@ -34,8 +34,6 @@
> >
> >  #define RSTMGR_MPUMODRST_CPU1          0x2     /* CPU1 Reset */
> >
> > -extern void socfpga_init_clocks(void);
> > -extern void socfpga_sysmgr_init(void);
> >  void socfpga_init_l2_ecc(void);
> >  void socfpga_init_ocram_ecc(void);
> >  void socfpga_init_arria10_l2_ecc(void);
> > diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> > index dde14f7bf2c3..5fb6f79059a8 100644
> > --- a/arch/arm/mach-socfpga/socfpga.c
> > +++ b/arch/arm/mach-socfpga/socfpga.c
> > @@ -32,7 +32,7 @@ void __iomem *rst_manager_base_addr;
> >  void __iomem *sdr_ctl_base_addr;
> >  unsigned long socfpga_cpu1start_addr;
> >
> > -void __init socfpga_sysmgr_init(void)
> > +static void __init socfpga_sysmgr_init(void)
> >  {
> >         struct device_node *np;
> >
> > --
> > 2.17.1
> >

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

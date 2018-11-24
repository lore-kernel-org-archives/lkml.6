Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B30CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4378620868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 20:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e3aBn87g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4378620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeKYG7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 01:59:10 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43488 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeKYG7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 01:59:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FdGqo3cC/VpmpjM13+E2Bs/k7k9atBHPHKhA454la/Y=; b=e3aBn87ggYtQTSbyOsPs/7THM
        tI1Dyrm1mXU4GnkKAhi9J4RYZE+I6Zx/Aw4ZSV9Pt30dLJKKTwj2cgJbuoSOuZkHQaUql8voPLL/T
        IB21s7BISc9H/9RS4fxKdvPWLC3+VqM0qMxLEvT5baDk2pS1Qbd4QHi9c99tKZ8+R0/Yo=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:32989)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gQeFO-0006kW-M8; Sat, 24 Nov 2018 20:09:46 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gQeFM-0007Hs-0F; Sat, 24 Nov 2018 20:09:44 +0000
Date:   Sat, 24 Nov 2018 20:09:42 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>, tony@atomide.com
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181124200942.GS6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 08:52:15PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Nov 23, 2018 at 02:35:04PM +0200, Peter Ujfalusi wrote:
> > On 22/11/2018 17.12, Russell King - ARM Linux wrote:
> > > I'm also not sure about this:
> > > 
> > >         if (cpu_is_omap15xx())
> > >                 end++;
> > > 
> > > in dma_dest_len() - is that missing from the omap-dma driver?  It looks
> > > like a work-around for some problem on OMAP15xx, but I can't make sense
> > > about why it's in the UDC driver rather than the legacy DMA driver.
> > 
> > afaik no other legacy drivers were doing similar thing, this must be
> > something which is needed for the omap_udc driver to fix up something?
> 
> Here's the patch that added it: https://marc.info/?l=linux-omap&m=119634396324221&w=2
> 
> "Make DMA-OUT behave on the 1510 ... the 1510 CPC register was just
> off-by-one with respect to the 1611 CDAC"

... which suggests that's a problem with the CPC register itself, and
we should fix that in the DMAengine driver rather than the USB gadget
driver.

Tony, any input on this?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

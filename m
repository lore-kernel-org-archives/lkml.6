Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E82FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CD220813
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ciRAm0bY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CD220813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439174AbeKWLIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 06:08:02 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42792 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405050AbeKWLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 06:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P8eN/TfoExd2pqRphUlEH0sS3BJPdvFIkq5RPGepous=; b=ciRAm0bY97OyZirsVNQmeQZDj
        89cpwSWWHIwkUlBfCHE6+rpLTnPzVyCg3OfzyijC1EkaPSzgvkJYLYsGIQ7hItN2iU8YyIUH5agXb
        3joPjCO7ZnfrCZIpGCYa87HxfeyZ+kBYUZ5CJzv6wrMLTHwqNrvknQ0beaETi0B0/kDQo=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:45848)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gPzIB-0004t7-Hx; Fri, 23 Nov 2018 00:25:55 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gPzI7-0007xU-Oz; Fri, 23 Nov 2018 00:25:51 +0000
Date:   Fri, 23 Nov 2018 00:25:49 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony@atomide.com,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Message-ID: <20181123002549.GO6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 12:24:26AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 22, 2018 at 10:29:48AM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
> > > > I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> > > > API were too annoying and flooding the console. And now that I tried
> > > > using DMA again with g_ether, it doesn't work anymore. The device get's
> > > > recognized on host side, but no traffic goes through. Switching back to
> > > > PIO makes it to work again.
> > > 
> > > A solution to that would be to do what the warning message says, and
> > > update the driver to the DMAengine API.
> 
> Fully agreed, but I was busy debugging other more serious issues, and
> just wanted to get a reliable ssh or USB serial access to the device
> without any extra noise, so switching to PIO using a module parameter
> is probably what most users do in such situations.
> 
> > Here's a partial conversion (not even build tested) - it only supports
> > OUT transfers with dmaengine at the moment.
> 
> Thanks, I'll take a closer look and try to do some testing hopefully
> during the weekend.

The patch was more for Peter to take a peek at - there's definitely
some bits missing in the dmaengine driver (like the write to the
LCH_CTRL register) that would need to be fixed somehow.

However, it's worth noting that there is exactly one user of
omap_set_dma_channel_mode(), which is omap-udc, which means any DMA
channel made use of by omap-udc will have the LCH_CTRL register
modified to LCH_P, and it will remain that way even if someone else
subsequently makes use of the same channel.  That's rather suspicious
to me... maybe we can just initialise all LCH_CTRL registers to LCH_P
in the dmaengine driver in that case!  If not, then there's a bug
right there.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

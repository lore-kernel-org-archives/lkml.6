Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA817C65BD1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79085214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SkXQ2Lfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79085214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJJEmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:42:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37896 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJEmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=51XTrruwT6Zk4jQmCrFDDypXOWKMNqzH2FZ+M5ceMCs=; b=SkXQ2LfveGeaL7fhRg9p6SvAf
        iy2y5LgSW1zgkhgYBvczJ94GsFilrvqyDhJJmxDFixDjfNlhFlRvm/ybEOJDumfvkj3LpALjbljh/
        aS/7TXkFptgW0q1bZJEafITIqX005BN9ra8AX5SUrnA+jFtprQ1AII4CByuUwfmCdM1Xc=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:60057)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g9zTj-00036f-89; Tue, 09 Oct 2018 22:23:43 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g9zTg-0001ow-0u; Tue, 09 Oct 2018 22:23:40 +0100
Date:   Tue, 9 Oct 2018 22:23:37 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree <devicetree@vger.kernel.org>, jernej.skrabec@siol.net,
        Andrzej Hajda <a.hajda@samsung.com>, maxime.ripard@bootlin.com,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, sboyd@kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi: Enable workaround
 for v2.12a
Message-ID: <20181009212337.GL30658@n2100.armlinux.org.uk>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-16-jernej.skrabec@siol.net>
 <3616158.EzHeIcd69b@avalon>
 <CAKb7Uvgmv4-t0g=b-Xsimn9AiRL1L4sQ51vu5xMTFKNdDC9bLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7Uvgmv4-t0g=b-Xsimn9AiRL1L4sQ51vu5xMTFKNdDC9bLw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 01:56:04PM -0400, Ilia Mirkin wrote:
> On Tue, Oct 9, 2018 at 1:40 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > commit 9c305eb442f3b371fc722ade827bbf673514123e
> > Author: Neil Armstrong <narmstrong@baylibre.com>
> > Date:   Fri Feb 23 12:44:37 2018 +0100
> >
> >     drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
> >
> > I haven't paid too much attention to the patch back then, and have now double-
> > checked the HDMI output on R-Car Gen3. Enabling the workaround doesn't cause
> > any regression, and reverting the commit doesn't cause any issue either. I
> > thus wonder whether we shouldn't enable the workaround with count = 1 in the
> > default case instead of adding new IP core versions to the list. It would be
> > nice if someone from Synopsys could comment on this.
> 
> I hope this comment isn't *incredibly* off-topic, but we encountered a
> similar issue with NVIDIA (and I believe AMD) hardware a while back,
> related to HDMI. This was due to infoframes not being sent, but
> (perhaps) HDMI Audio being enabled.

You're probably right about the infoframes.  The errata documentation
for this workaround on iMX6 states:

 Each time one writes to some FC registers, and depending on the clock relation of sfr clk and tmds
 clk, some of these train of pulses (when these registers are configured in sequence), may not be
 caught by the arithmetic unit while it is busy processing/updating the first ones, so, it gets wrong
 video timing values, although the registers FC_* hold correct values. Even a soft reset will not
 make the arithmetic unit update correctly. Video will still pass correctly to the HDMI, but packets
 would not because the frame composer is holding internally incorrect video timing and this will
 quickly build up and overflow the packet FIFOs.

So, the workaround is about kicking the frame composer so that the
packets (iow, non-video data) are passed through correctly.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

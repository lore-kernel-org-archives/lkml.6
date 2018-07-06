Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24687C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB65021A0E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IurJPnzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB65021A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeGFO6E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:58:04 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44178 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeGFO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lhc6Nk9FUUXXAMEhha3TKscaU8ZzwSt4eWspiq8LAUs=; b=IurJPnzCFbTYNF1Mff0JwbxYJ
        UxeH7dn4qOUUDvvdgrwhgZE/gYY3yXNmDRt9DQJHodQvwnU4PLu9v80RcOF/HMwZfKqNwsiuoNHUU
        XhZVlEknIWg220INyfhmnK9sAkufla384gT9nieT5RgcPYk85xa9RPFBM6R5rtC5QOKO4=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:55783)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fbSBF-0006N8-36; Fri, 06 Jul 2018 15:57:53 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fbSBC-0003Lk-0i; Fri, 06 Jul 2018 15:57:50 +0100
Date:   Fri, 6 Jul 2018 15:57:48 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Peter Rosin <peda@axentia.se>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] drm/i2c: tda998x: register as a drm bridge
Message-ID: <20180706145748.GA17271@n2100.armlinux.org.uk>
References: <20180523093122.27859-1-peda@axentia.se>
 <20180523093122.27859-8-peda@axentia.se>
 <20180706133637.GZ17271@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706133637.GZ17271@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:36:37PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 23, 2018 at 11:31:22AM +0200, Peter Rosin wrote:
> > This makes this driver work with all(?) drivers that are not
> > componentized and instead expect to connect to a panel/bridge. That
> > said, the only one tested is atmel-hlcdc.
> > 
> > This hooks the relevant work function previously called by the encoder
> > and the component also to the bridge, since the encoder goes away when
> > connecting to the bridge interface of the driver and the equivalent of
> > bind/unbind of the component is handled by bridge attach/detach.
> > 
> > The lifetime requirements of a bridge and a component are slightly
> > different, which is the reason for struct tda998x_bridge.
> 
> Why not do this conversion similarly to other "bridge" drivers that have
> this same problem (eg, dw-hdmi, dw-mipi-dsi) and always create the
> bridge device, but optionally create the encoder and bind the bridge
> to the encoder?
> 
> That way we don't end up with the veneer functions for bridge-only vs
> encoder-only, and we have just one control path to care about - that
> being the bridge interface.

So what I'm proposing is something along the lines of the following
(untested) patch series - I haven't gone to the extent of creating
just the bridge device, but as you will see, it's not that far away.

With the addition of the component helper into drm_bridge code, we
could probably push both armada and tilcdc to use bridges and create
their own encoders for the bridges rather trivially and make tda998x
encoderless, without sacrificing the existing ability to be able to
safely unload these components.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up

Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F5C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECCF2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pvT9DcMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfAURxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:53:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51940 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAURxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e5E0JWbw3ciLcpwcmyTPHHFGe3zmNQaSG+kI7O84tt4=; b=pvT9DcMmqM2x7sJAoIINi+eUl
        cQEgQ10orXcX/V60QKNVoClyPFZAAT0kX5Vcb4lFTKCqvPH878Iu5hxSGJomCLW41kjUObXo8EfEd
        NSvRLHhF0r4CPBQ+nQfD9mCKQM6or8hCvghscwU2K4JfNPNquEZF0z3bA3KMK0OWJhDfE=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:59646 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gldks-0005kH-Gn; Mon, 21 Jan 2019 17:53:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gldkr-00013I-Hu; Mon, 21 Jan 2019 17:53:01 +0000
Date:   Mon, 21 Jan 2019 17:53:01 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem
 binding
Message-ID: <20190121175301.lremzw6dul7dyff4@e5254000004ec.dyn.armlinux.org.uk>
References: <20190120172534.24617-1-lkundrak@v3.sk>
 <20190120172534.24617-5-lkundrak@v3.sk>
 <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
 <3191cdde84978adf98d200a9db6f3c18e0a46390.camel@v3.sk>
 <CAL_JsqJBh9=J+m-eCFXvKw62Fj1Y9aFCNY=Vqo0LfyKoXKSXow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJBh9=J+m-eCFXvKw62Fj1Y9aFCNY=Vqo0LfyKoXKSXow@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:07:11AM -0600, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 9:46 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > On Mon, 2019-01-21 at 09:35 -0600, Rob Herring wrote:
> > > On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > > The Marvell Armada DRM master device is a virtual device needed to list all
> > > > nodes that comprise the graphics subsystem.
> > > >
> > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > ---
> > > >  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
> > > >  1 file changed, 24 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > index de4cca9432c8..3dbfa8047f0b 100644
> > > > --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > @@ -1,3 +1,27 @@
> > > > +Marvell Armada DRM master device
> > > > +================================
> > > > +
> > > > +The Marvell Armada DRM master device is a virtual device needed to list all
> > > > +nodes that comprise the graphics subsystem.
> > > > +
> > > > +Required properties:
> > > > +
> > > > + - compatible: value should be "marvell,dove-display-subsystem",
> > > > +   "marvell,armada-display-subsystem"
> > > > + - ports: a list of phandles pointing to display interface ports of CRTC
> > > > +   devices
> > > > + - memory-region: phandle to a node describing memory to be used for the
> > > > +   framebuffer
> > > > +
> > > > +Example:
> > > > +
> > > > +       display-subsystem {
> > > > +               compatible = "marvell,dove-display-subsystem",
> > > > +                            "marvell,armada-display-subsystem";
> > > > +               memory-region = <&display_reserved>;
> > > > +               ports = <&lcd0_port>;
> > >
> > > If there is only one device, you don't need this virtual node.
> >
> > By "one device" you mean one LCD controller (CRTC)?
> 
> Yes.

How does that work (as far as the Linux implementation) ?  I can't see
a way that could work, while allowing the flexibility that Armada DRM
allows (two completely independent LCD controllers as two separate DRM
devices vs one DRM device containing both LCD controllers.)

> > I suppose in the (single CRTC) example case, the display-subsystem node
> > used to associate it with the memory region reserved for allocating the
> > frame buffers from. Could that be done differently?
> 
> Move memory-region to the LCD controller node.

That doesn't work - it would appear in the wrong part of the driver.

> > Also, if the node is indeed made optional, then it's going to
> > complicate things on the DRM side. Currently the driver that binds to
> > the node creates the DRM device once it sees all the components
> > connected to the ports appear. If we loose it, then the LCD controller
> > driver would somehow need to find out that it's alone and create the
> > DRM device itself.
> 
> DT is not the only way to create devices. The DRM driver can bind to
> the LCDC node and then create a child CRTC device (or even multiple
> ones for h/w with multiple pipelines).

That seems completely upside down and rediculous to me - are you
really suggesting that we should have some kind of virtual device
in DT, and omit the _real_ physical devices for that, having the
driver create the device with all the appropriate SoC resources?

> You'll also notice that there are only 3 cases of this virtual node in
> the tree: STi, i.MX IPU, and Rockchip. That's because we've deprecated
> doing these virtual nodes for some time now. IOW, there are several
> examples of how to do this without a virtual node.

This driver has been in-tree with this setup for some time, although
the documentation has been missing (we actually have a _lot_ of
instances of that.)  However, we have no in-tree DT using it.

I don't really see how to satisfy your comments without totally
restructuring the driver, which is going to be quite a big chunk
of work.  I'm not sure I have the motivation to do that right now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

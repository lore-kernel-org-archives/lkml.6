Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C4FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816D720879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kOjEmGAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfAVK6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:58:54 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35208 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAVK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a6bym608hIJ9SVvjatXXKExOED6G2/6CTtQ/Xl8LgOg=; b=kOjEmGAE+GnZl8mOoy6HO72Ug
        T2JNr3szdKyAVkbvYK9EgrDjKmK/oL4aQHlnLfPB0FEZ3ZH+CkT+xBCdzQiXcxhgs7EdZ1m57hWc3
        riqFIxmNCaxjI+dxtcFNIIF5QJLv/iwKoaJ+Wy48bDLrfBAttKhT+pkwOSlNFXRLtkTN8=;
Received: from e5254000004ec.dyn.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46178 helo=shell.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gltlU-0002z9-2H; Tue, 22 Jan 2019 10:58:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gltlT-0001eY-FS; Tue, 22 Jan 2019 10:58:43 +0000
Date:   Tue, 22 Jan 2019 10:58:43 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem
 binding
Message-ID: <20190122105843.cqtzit2adfoungku@e5254000004ec.dyn.armlinux.org.uk>
References: <20190120172534.24617-1-lkundrak@v3.sk>
 <20190120172534.24617-5-lkundrak@v3.sk>
 <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
 <3191cdde84978adf98d200a9db6f3c18e0a46390.camel@v3.sk>
 <CAL_JsqJBh9=J+m-eCFXvKw62Fj1Y9aFCNY=Vqo0LfyKoXKSXow@mail.gmail.com>
 <20190121175301.lremzw6dul7dyff4@e5254000004ec.dyn.armlinux.org.uk>
 <CAL_Jsq+6N6y=2ZmXL37G9o=w1wcP_qnCt=g6HJot=CwrJc0zNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+6N6y=2ZmXL37G9o=w1wcP_qnCt=g6HJot=CwrJc0zNw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 05:58:50PM -0600, Rob Herring wrote:
> On Mon, Jan 21, 2019 at 11:53 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Mon, Jan 21, 2019 at 10:07:11AM -0600, Rob Herring wrote:
> > > On Mon, Jan 21, 2019 at 9:46 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > >
> > > > On Mon, 2019-01-21 at 09:35 -0600, Rob Herring wrote:
> > > > > On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > > > > The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > > nodes that comprise the graphics subsystem.
> > > > > >
> > > > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > > > ---
> > > > > >  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
> > > > > >  1 file changed, 24 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > > index de4cca9432c8..3dbfa8047f0b 100644
> > > > > > --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > > +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > > @@ -1,3 +1,27 @@
> > > > > > +Marvell Armada DRM master device
> > > > > > +================================
> > > > > > +
> > > > > > +The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > > +nodes that comprise the graphics subsystem.
> > > > > > +
> > > > > > +Required properties:
> > > > > > +
> > > > > > + - compatible: value should be "marvell,dove-display-subsystem",
> > > > > > +   "marvell,armada-display-subsystem"
> > > > > > + - ports: a list of phandles pointing to display interface ports of CRTC
> > > > > > +   devices
> > > > > > + - memory-region: phandle to a node describing memory to be used for the
> > > > > > +   framebuffer
> > > > > > +
> > > > > > +Example:
> > > > > > +
> > > > > > +       display-subsystem {
> > > > > > +               compatible = "marvell,dove-display-subsystem",
> > > > > > +                            "marvell,armada-display-subsystem";
> > > > > > +               memory-region = <&display_reserved>;
> > > > > > +               ports = <&lcd0_port>;
> > > > >
> > > > > If there is only one device, you don't need this virtual node.
> > > >
> > > > By "one device" you mean one LCD controller (CRTC)?
> > >
> > > Yes.
> >
> > How does that work (as far as the Linux implementation) ?  I can't see
> > a way that could work, while allowing the flexibility that Armada DRM
> > allows (two completely independent LCD controllers as two separate DRM
> > devices vs one DRM device containing both LCD controllers.)
> >
> > > > I suppose in the (single CRTC) example case, the display-subsystem node
> > > > used to associate it with the memory region reserved for allocating the
> > > > frame buffers from. Could that be done differently?
> > >
> > > Move memory-region to the LCD controller node.
> >
> > That doesn't work - it would appear in the wrong part of the driver.
> 
> Why? You can fetch properties from other nodes.
> 
> If you have 2 CRTCs, do you have 1 or 2 reserved memory regions? I'd
> think 2 with each one in the corresponding LCDC that uses them would
> be more flexible.

There would still be one reserved memory region, since it is shared
between both LCDCs.

> Or just get the data out of the /reserved-memory node directly. Surely
> it has a compatible that you can find it with.

I see that the DT reserved memory support has progressed since I wrote
the armada code to deal with it, and it's now possible to make use of
reserved memory via of_reserved_mem_lookup() rather than using the
RESERVEDMEM_OF_DECLARE() and so forth.

> > > > Also, if the node is indeed made optional, then it's going to
> > > > complicate things on the DRM side. Currently the driver that binds to
> > > > the node creates the DRM device once it sees all the components
> > > > connected to the ports appear. If we loose it, then the LCD controller
> > > > driver would somehow need to find out that it's alone and create the
> > > > DRM device itself.
> > >
> > > DT is not the only way to create devices. The DRM driver can bind to
> > > the LCDC node and then create a child CRTC device (or even multiple
> > > ones for h/w with multiple pipelines).
> >
> > That seems completely upside down and rediculous to me - are you
> > really suggesting that we should have some kind of virtual device
> > in DT, and omit the _real_ physical devices for that, having the
> > driver create the device with all the appropriate SoC resources?
> 
> We create child platform devices that inherit from the parent in DT
> all the time. MFD child drivers are a common case. Sometime the child
> devices have DT nodes and sometimes they don't.

I still don't think what you're saying is the right way to go about
this.

You _appear_ to be saying to group _both_ LCD controllers into one
DT node, despite the fact that they are two separate devices with
different mmio resources, interrupts etc, and have code in the
kernel to split the DT device up into sub-devices.  IOW:

                        lcd-controllers@810000 {
                                compatible = "marvell,dove-lcd-subsystem";
                                reg = <0x810000 0x1000>, <0x820000 0x1000>;
                                interrupts = <46>, <47>;
                                status = "disabled";
                        };

rather than:

                        lcd1: lcd-controller@810000 {
                                compatible = "marvell,dove-lcd";
                                reg = <0x810000 0x1000>;
                                interrupts = <46>;
                                status = "disabled";
                        };

                        lcd0: lcd-controller@820000 {
                                compatible = "marvell,dove-lcd";
                                reg = <0x820000 0x1000>;
                                interrupts = <47>;
                                status = "disabled";
                        };

Why do we need all that extra complexity, when DT can perfectly well
describe each individual LCD controller as a separate node?

How do we then do stuff such as:

&lcd0 {
        status = "okay";
        clocks = <&si5351 0>;
        clock-names = "ext_ref_clk1";
        lcd0_port: port {
                lcd0_rgb: endpoint {
                        remote-endpoint = <&tda998x_video>;
                };
        };
};

&lcd1 {
        status = "okay";
        clocks = <&divider_clk 3>;
        clock-names = "plldivider";
        lcd1_port: port {
                lcd1_rgb: endpoint {
                        remote-endpoint = <&vga_bridge_in>;
                };
        };
};

in board files - we seem to lose a way to reference each individual
LCD controller using this method.  This is why I say your suggestion
is upside down and rather rediculous - it doesn't really fit the
hardware at all, and to me just seems to be an exercise in making
things unnecessarily difficult.

> Otherwise, do it the other way around. Create a virtual DRM device
> conditioned on the SoC:
> 
> if (of_machine_is_compatible("foo,bar"))
>   platform_device_register_simple(...)

I guess that's possible at the expense of losing the flexibility - my
original idea was to allow a case where you could have two DRM devices,
one per LCD controller if you wanted, rather than having a binding that
forces one DRM device optionally containing both LCD controllers.

This is the flexibility I talk about above, that you seem to have
skipped over in your reply.

> > > You'll also notice that there are only 3 cases of this virtual node in
> > > the tree: STi, i.MX IPU, and Rockchip. That's because we've deprecated
> > > doing these virtual nodes for some time now. IOW, there are several
> > > examples of how to do this without a virtual node.
> >
> > This driver has been in-tree with this setup for some time, although
> > the documentation has been missing (we actually have a _lot_ of
> > instances of that.)  However, we have no in-tree DT using it.
> 
> The current Armada DRM driver has no binding to DT at all, so no, it
> is not just missing documentation or a dts file.
> 
> > I don't really see how to satisfy your comments without totally
> > restructuring the driver, which is going to be quite a big chunk
> > of work.  I'm not sure I have the motivation to do that right now.
> 
> It's not a big chunk of work. Look at commit 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node") for an
> example.
> 
> Rob
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

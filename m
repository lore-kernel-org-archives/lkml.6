Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC45C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1372089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfAUUpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 15:45:34 -0500
Received: from shell.v3.sk ([90.176.6.54]:52209 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfAUUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 15:45:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 460CDCC076;
        Mon, 21 Jan 2019 21:45:29 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w-dLlgeTGokR; Mon, 21 Jan 2019 21:45:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 18EDDCC311;
        Mon, 21 Jan 2019 21:45:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b2yX_s3a3uiy; Mon, 21 Jan 2019 21:45:24 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2AEA8CC076;
        Mon, 21 Jan 2019 21:45:24 +0100 (CET)
Message-ID: <4c21727d9753d4c0de667566972f2229dc9f1304.camel@v3.sk>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem
 binding
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Jan 2019 21:45:22 +0100
In-Reply-To: <20190121175301.lremzw6dul7dyff4@e5254000004ec.dyn.armlinux.org.uk>
References: <20190120172534.24617-1-lkundrak@v3.sk>
         <20190120172534.24617-5-lkundrak@v3.sk>
         <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
         <3191cdde84978adf98d200a9db6f3c18e0a46390.camel@v3.sk>
         <CAL_JsqJBh9=J+m-eCFXvKw62Fj1Y9aFCNY=Vqo0LfyKoXKSXow@mail.gmail.com>
         <20190121175301.lremzw6dul7dyff4@e5254000004ec.dyn.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 17:53 +0000, Russell King - ARM Linux admin
wrote:
> On Mon, Jan 21, 2019 at 10:07:11AM -0600, Rob Herring wrote:
> > On Mon, Jan 21, 2019 at 9:46 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > On Mon, 2019-01-21 at 09:35 -0600, Rob Herring wrote:
> > > > On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > > > The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > nodes that comprise the graphics subsystem.
> > > > > 
> > > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > > ---
> > > > >  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
> > > > >  1 file changed, 24 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > index de4cca9432c8..3dbfa8047f0b 100644
> > > > > --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > @@ -1,3 +1,27 @@
> > > > > +Marvell Armada DRM master device
> > > > > +================================
> > > > > +
> > > > > +The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > +nodes that comprise the graphics subsystem.
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > + - compatible: value should be "marvell,dove-display-subsystem",
> > > > > +   "marvell,armada-display-subsystem"
> > > > > + - ports: a list of phandles pointing to display interface ports of CRTC
> > > > > +   devices
> > > > > + - memory-region: phandle to a node describing memory to be used for the
> > > > > +   framebuffer
> > > > > +
> > > > > +Example:
> > > > > +
> > > > > +       display-subsystem {
> > > > > +               compatible = "marvell,dove-display-subsystem",
> > > > > +                            "marvell,armada-display-subsystem";
> > > > > +               memory-region = <&display_reserved>;
> > > > > +               ports = <&lcd0_port>;
> > > > 
> > > > If there is only one device, you don't need this virtual node.
> > > 
> > > By "one device" you mean one LCD controller (CRTC)?
> > 
> > Yes.
> 
> How does that work (as far as the Linux implementation) ?  I can't see
> a way that could work, while allowing the flexibility that Armada DRM
> allows (two completely independent LCD controllers as two separate DRM
> devices vs one DRM device containing both LCD controllers.)
> 
> > > I suppose in the (single CRTC) example case, the display-subsystem node
> > > used to associate it with the memory region reserved for allocating the
> > > frame buffers from. Could that be done differently?
> > 
> > Move memory-region to the LCD controller node.
> 
> That doesn't work - it would appear in the wrong part of the driver.
> 
> > > Also, if the node is indeed made optional, then it's going to
> > > complicate things on the DRM side. Currently the driver that binds to
> > > the node creates the DRM device once it sees all the components
> > > connected to the ports appear. If we loose it, then the LCD controller
> > > driver would somehow need to find out that it's alone and create the
> > > DRM device itself.
> > 
> > DT is not the only way to create devices. The DRM driver can bind to
> > the LCDC node and then create a child CRTC device (or even multiple
> > ones for h/w with multiple pipelines).
> 
> That seems completely upside down and rediculous to me - are you
> really suggesting that we should have some kind of virtual device
> in DT, and omit the _real_ physical devices for that, having the
> driver create the device with all the appropriate SoC resources?

Hmm, that's not how I read that. My understanding (putting aside
practicality of the solution) is that Rob was merely suggesting that
for the single LCDC case there would be just a single LCDC node in DT
and the driver that binds to it would create the DRM device & CRTC
device pair.

> > You'll also notice that there are only 3 cases of this virtual node in
> > the tree: STi, i.MX IPU, and Rockchip. That's because we've deprecated
> > doing these virtual nodes for some time now. IOW, there are several
> > examples of how to do this without a virtual node.
> 
> This driver has been in-tree with this setup for some time, although
> the documentation has been missing (we actually have a _lot_ of
> instances of that.)  However, we have no in-tree DT using it.
> 
> I don't really see how to satisfy your comments without totally
> restructuring the driver, which is going to be quite a big chunk
> of work.  I'm not sure I have the motivation to do that right now.

Note that the initial objection was against the display-subsystem node
being mandatory if "there is only one [LCDC] device".

My understanding is that need to include the display-subsystem node for
the multiple LCDC setup (on Dove platform) anyways. Is that correct?

Rob, I'm wondering if there would be a possibility of finding some
middle groud? Perhaps documenting, that the display-subsystem node
would ideally be optional for single LCDC setups, but indicating that
the Armada DRM driver actually requires is?

Note that this is not a new driver -- it has been around since 2013,
though, without useful DT bindings. Maybe it would do just well in
company of the other three drivers you mentioned that use similar
bindings.

(Also, there seem to have substantial discussion regarding the bindings
design back in '13, shedding some light into why the display-subsystem
node was deemed useful: [1])

[1] https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg40358.html

Thanks,
Lubo


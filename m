Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EB9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6F020823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548173188;
	bh=PX122dXlfAYGf/2qvoEwBQMZd2Rg2KJEaN3SLt8o620=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X60eFd37BKTugCnxY7i38TUGeNDm6Iw9Qwq91xGURFSl9FhL07e2SGmYfHK7AnPCF
	 XAT0iWkl6AfGOCrglYEC/DuLpvdnIbQBio23vKnmq7uqeF+cRabet7UJqd3SZ/+6QG
	 JOqzCEPAsAU2hHnz0t0G2fjalfoZnGOSR3N+H8tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfAVQG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:06:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbfAVQG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:06:26 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B1F21726;
        Tue, 22 Jan 2019 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548173185;
        bh=PX122dXlfAYGf/2qvoEwBQMZd2Rg2KJEaN3SLt8o620=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GbrRUp2aAvGt9IGJMA0ftZQ8l9DtKvP4OGsUN1f5erJySkcotRPHOCL2wHF+M6MSm
         fmPefpCwDTEcruI1dBzaA/sgA6Y2rxKy67AoV2oRuFOnN/dnScIgBfk6AlcJU7iPLn
         3N80yPB5E6K9aiM3T4UZWtl9EJqgBaAwboYAxl1c=
Received: by mail-qt1-f170.google.com with SMTP id e5so28077586qtr.12;
        Tue, 22 Jan 2019 08:06:25 -0800 (PST)
X-Gm-Message-State: AJcUukcC+wk7CafP25dzF8OsCD0d+ehyEP+cNVzVQLPgXuq4rtaeQFt6
        8qv/5Ojmq8ceNXCuFrfDJvUoKXDYhV1RVvlbLA==
X-Google-Smtp-Source: ALg8bN46CcijmZXV+eFRAnraKQQciuh9SQtO1Szt5Qf/ZexTY04ifZdg5SkTdmQwvJ4jvQyDC2w5U3RFjLQy9V5CA9c=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr30769267qta.38.1548173184264;
 Tue, 22 Jan 2019 08:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20190120172534.24617-1-lkundrak@v3.sk> <20190120172534.24617-5-lkundrak@v3.sk>
 <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
 <3191cdde84978adf98d200a9db6f3c18e0a46390.camel@v3.sk> <CAL_JsqJBh9=J+m-eCFXvKw62Fj1Y9aFCNY=Vqo0LfyKoXKSXow@mail.gmail.com>
 <20190121175301.lremzw6dul7dyff4@e5254000004ec.dyn.armlinux.org.uk>
 <CAL_Jsq+6N6y=2ZmXL37G9o=w1wcP_qnCt=g6HJot=CwrJc0zNw@mail.gmail.com> <20190122105843.cqtzit2adfoungku@e5254000004ec.dyn.armlinux.org.uk>
In-Reply-To: <20190122105843.cqtzit2adfoungku@e5254000004ec.dyn.armlinux.org.uk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Jan 2019 10:06:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLB+jsWxnXO9f-yFfY=1JPibV_4pNLxJNPwRE9CeePyg@mail.gmail.com>
Message-ID: <CAL_JsqJLB+jsWxnXO9f-yFfY=1JPibV_4pNLxJNPwRE9CeePyg@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem binding
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 4:58 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 21, 2019 at 05:58:50PM -0600, Rob Herring wrote:
> > On Mon, Jan 21, 2019 at 11:53 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Mon, Jan 21, 2019 at 10:07:11AM -0600, Rob Herring wrote:
> > > > On Mon, Jan 21, 2019 at 9:46 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > > >
> > > > > On Mon, 2019-01-21 at 09:35 -0600, Rob Herring wrote:
> > > > > > On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > > > > > The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > > > nodes that comprise the graphics subsystem.
> > > > > > >
> > > > > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > > > > ---
> > > > > > >  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
> > > > > > >  1 file changed, 24 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > > > index de4cca9432c8..3dbfa8047f0b 100644
> > > > > > > --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > > > +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > > > @@ -1,3 +1,27 @@
> > > > > > > +Marvell Armada DRM master device
> > > > > > > +================================
> > > > > > > +
> > > > > > > +The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > > > +nodes that comprise the graphics subsystem.
> > > > > > > +
> > > > > > > +Required properties:
> > > > > > > +
> > > > > > > + - compatible: value should be "marvell,dove-display-subsystem",
> > > > > > > +   "marvell,armada-display-subsystem"
> > > > > > > + - ports: a list of phandles pointing to display interface ports of CRTC
> > > > > > > +   devices
> > > > > > > + - memory-region: phandle to a node describing memory to be used for the
> > > > > > > +   framebuffer
> > > > > > > +
> > > > > > > +Example:
> > > > > > > +
> > > > > > > +       display-subsystem {
> > > > > > > +               compatible = "marvell,dove-display-subsystem",
> > > > > > > +                            "marvell,armada-display-subsystem";
> > > > > > > +               memory-region = <&display_reserved>;
> > > > > > > +               ports = <&lcd0_port>;
> > > > > >
> > > > > > If there is only one device, you don't need this virtual node.
> > > > >
> > > > > By "one device" you mean one LCD controller (CRTC)?
> > > >
> > > > Yes.
> > >
> > > How does that work (as far as the Linux implementation) ?  I can't see
> > > a way that could work, while allowing the flexibility that Armada DRM
> > > allows (two completely independent LCD controllers as two separate DRM
> > > devices vs one DRM device containing both LCD controllers.)
> > >
> > > > > I suppose in the (single CRTC) example case, the display-subsystem node
> > > > > used to associate it with the memory region reserved for allocating the
> > > > > frame buffers from. Could that be done differently?
> > > >
> > > > Move memory-region to the LCD controller node.
> > >
> > > That doesn't work - it would appear in the wrong part of the driver.
> >
> > Why? You can fetch properties from other nodes.
> >
> > If you have 2 CRTCs, do you have 1 or 2 reserved memory regions? I'd
> > think 2 with each one in the corresponding LCDC that uses them would
> > be more flexible.
>
> There would still be one reserved memory region, since it is shared
> between both LCDCs.
>
> > Or just get the data out of the /reserved-memory node directly. Surely
> > it has a compatible that you can find it with.
>
> I see that the DT reserved memory support has progressed since I wrote
> the armada code to deal with it, and it's now possible to make use of
> reserved memory via of_reserved_mem_lookup() rather than using the
> RESERVEDMEM_OF_DECLARE() and so forth.
>
> > > > > Also, if the node is indeed made optional, then it's going to
> > > > > complicate things on the DRM side. Currently the driver that binds to
> > > > > the node creates the DRM device once it sees all the components
> > > > > connected to the ports appear. If we loose it, then the LCD controller
> > > > > driver would somehow need to find out that it's alone and create the
> > > > > DRM device itself.
> > > >
> > > > DT is not the only way to create devices. The DRM driver can bind to
> > > > the LCDC node and then create a child CRTC device (or even multiple
> > > > ones for h/w with multiple pipelines).
> > >
> > > That seems completely upside down and rediculous to me - are you
> > > really suggesting that we should have some kind of virtual device
> > > in DT, and omit the _real_ physical devices for that, having the
> > > driver create the device with all the appropriate SoC resources?
> >
> > We create child platform devices that inherit from the parent in DT
> > all the time. MFD child drivers are a common case. Sometime the child
> > devices have DT nodes and sometimes they don't.
>
> I still don't think what you're saying is the right way to go about
> this.
>
> You _appear_ to be saying to group _both_ LCD controllers into one
> DT node, despite the fact that they are two separate devices with
> different mmio resources, interrupts etc, and have code in the
> kernel to split the DT device up into sub-devices.  IOW:

No, not at all. That was just an example of a h/w device having
virtual child platform devices. If you want to have 1 DRM device with
2 CRTCs, you have to do as described below.

I certainly want this to reflect the h/w. That's why we're having this
discussion.

[...]

> > Otherwise, do it the other way around. Create a virtual DRM device
> > conditioned on the SoC:
> >
> > if (of_machine_is_compatible("foo,bar"))
> >   platform_device_register_simple(...)
>
> I guess that's possible at the expense of losing the flexibility - my
> original idea was to allow a case where you could have two DRM devices,
> one per LCD controller if you wanted, rather than having a binding that
> forces one DRM device optionally containing both LCD controllers.

Sure, but that's an OS decision that has nothing to do with the
hardware and DT. You'll just have to pass some flag to the DRM device
platform driver and decide whether to create 1 device or 2. That
decision could be based on either evolving DRM architecture or on the
platform. That is more flexible than fixing it in DT.

Rob

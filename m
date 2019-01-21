Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E432C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2581720870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfAUPqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:46:30 -0500
Received: from shell.v3.sk ([90.176.6.54]:51352 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbfAUPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:46:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 33AAECBB94;
        Mon, 21 Jan 2019 16:46:25 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fHmK3xe5jFKl; Mon, 21 Jan 2019 16:46:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BEE71CBC59;
        Mon, 21 Jan 2019 16:46:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pg_xdQdXOeYc; Mon, 21 Jan 2019 16:46:21 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0317ACBB94;
        Mon, 21 Jan 2019 16:46:20 +0100 (CET)
Message-ID: <3191cdde84978adf98d200a9db6f3c18e0a46390.camel@v3.sk>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem
 binding
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 21 Jan 2019 16:46:19 +0100
In-Reply-To: <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
References: <20190120172534.24617-1-lkundrak@v3.sk>
         <20190120172534.24617-5-lkundrak@v3.sk>
         <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-21 at 09:35 -0600, Rob Herring wrote:
> On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > The Marvell Armada DRM master device is a virtual device needed to list all
> > nodes that comprise the graphics subsystem.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > index de4cca9432c8..3dbfa8047f0b 100644
> > --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > @@ -1,3 +1,27 @@
> > +Marvell Armada DRM master device
> > +================================
> > +
> > +The Marvell Armada DRM master device is a virtual device needed to list all
> > +nodes that comprise the graphics subsystem.
> > +
> > +Required properties:
> > +
> > + - compatible: value should be "marvell,dove-display-subsystem",
> > +   "marvell,armada-display-subsystem"
> > + - ports: a list of phandles pointing to display interface ports of CRTC
> > +   devices
> > + - memory-region: phandle to a node describing memory to be used for the
> > +   framebuffer
> > +
> > +Example:
> > +
> > +       display-subsystem {
> > +               compatible = "marvell,dove-display-subsystem",
> > +                            "marvell,armada-display-subsystem";
> > +               memory-region = <&display_reserved>;
> > +               ports = <&lcd0_port>;
> 
> If there is only one device, you don't need this virtual node.

By "one device" you mean one LCD controller (CRTC)?

I suppose in the (single CRTC) example case, the display-subsystem node
used to associate it with the memory region reserved for allocating the
frame buffers from. Could that be done differently?

Also, if the node is indeed made optional, then it's going to
complicate things on the DRM side. Currently the driver that binds to
the node creates the DRM device once it sees all the components
connected to the ports appear. If we loose it, then the LCD controller
driver would somehow need to find out that it's alone and create the
DRM device itself.

Thank you
Lubo

> 
> 
> > +       };
> > +
> >  Marvell Armada LCD controller
> >  =============================
> > 
> > --
> > 2.20.1
> > 


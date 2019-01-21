Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EDAC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EBB20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548086847;
	bh=GgvDX/gbDQMh9WASZ8PRZRz3Cxat2XSdxRLsHrCs2rM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zxnJ0cNodSALLawr7qe39mZafm7sTrKTAs94jOwyQIDFHzXDBIVls9Y6CqkJxYF0n
	 I62ZlgKsvjjINF3oy+RdOUDgrzzKEGn9OkZH+5FU4Pd2sHyrIPRs9oXohRjRNUEI0V
	 HyQpsYmf5Apebk7UcVQq0WA4ChTZ8wX97WSu9/k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfAUQHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfAUQHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:07:24 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C0A2089F;
        Mon, 21 Jan 2019 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548086843;
        bh=GgvDX/gbDQMh9WASZ8PRZRz3Cxat2XSdxRLsHrCs2rM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1K2ocIG7lMGrcGt/zZz64tWSWRDozNUZN5WE8WaSgZQqoqgT3lXWYd/RYskTXew2B
         ubjzbLXaeXCwYW27O4r+TH0wSaJwMynWb+Q0ha4iX4uAchXce64LIzdYhCdmWc1GwY
         5EmhU1ZhsRTdIV/L96pbXq2mdmEUxH7CyLX+ypaM=
Received: by mail-qt1-f177.google.com with SMTP id i7so24051617qtj.10;
        Mon, 21 Jan 2019 08:07:23 -0800 (PST)
X-Gm-Message-State: AJcUukce06qzFDLmO0bx7OxXYQ+QM6PuIehdWBLKWv87f7PNz3Dg0d2b
        N2YTCvYcOSye2L0zhBxIiL03SHf2Fs9F/u28oQ==
X-Google-Smtp-Source: ALg8bN6oDDi6y/p/N/VIKEeEI9VkowQIX6voUk+RxSCW6rEJtD71dr5oFBXDHcOGt7l9g9svpe4aR+mH24cEkb7uJqk=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr26546049qta.38.1548086842396;
 Mon, 21 Jan 2019 08:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20190120172534.24617-1-lkundrak@v3.sk> <20190120172534.24617-5-lkundrak@v3.sk>
 <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com> <3191cdde84978adf98d200a9db6f3c18e0a46390.camel@v3.sk>
In-Reply-To: <3191cdde84978adf98d200a9db6f3c18e0a46390.camel@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jan 2019 10:07:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJBh9=J+m-eCFXvKw62Fj1Y9aFCNY=Vqo0LfyKoXKSXow@mail.gmail.com>
Message-ID: <CAL_JsqJBh9=J+m-eCFXvKw62Fj1Y9aFCNY=Vqo0LfyKoXKSXow@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem binding
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 9:46 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Mon, 2019-01-21 at 09:35 -0600, Rob Herring wrote:
> > On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > The Marvell Armada DRM master device is a virtual device needed to list all
> > > nodes that comprise the graphics subsystem.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > ---
> > >  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > index de4cca9432c8..3dbfa8047f0b 100644
> > > --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > @@ -1,3 +1,27 @@
> > > +Marvell Armada DRM master device
> > > +================================
> > > +
> > > +The Marvell Armada DRM master device is a virtual device needed to list all
> > > +nodes that comprise the graphics subsystem.
> > > +
> > > +Required properties:
> > > +
> > > + - compatible: value should be "marvell,dove-display-subsystem",
> > > +   "marvell,armada-display-subsystem"
> > > + - ports: a list of phandles pointing to display interface ports of CRTC
> > > +   devices
> > > + - memory-region: phandle to a node describing memory to be used for the
> > > +   framebuffer
> > > +
> > > +Example:
> > > +
> > > +       display-subsystem {
> > > +               compatible = "marvell,dove-display-subsystem",
> > > +                            "marvell,armada-display-subsystem";
> > > +               memory-region = <&display_reserved>;
> > > +               ports = <&lcd0_port>;
> >
> > If there is only one device, you don't need this virtual node.
>
> By "one device" you mean one LCD controller (CRTC)?

Yes.

> I suppose in the (single CRTC) example case, the display-subsystem node
> used to associate it with the memory region reserved for allocating the
> frame buffers from. Could that be done differently?

Move memory-region to the LCD controller node.

> Also, if the node is indeed made optional, then it's going to
> complicate things on the DRM side. Currently the driver that binds to
> the node creates the DRM device once it sees all the components
> connected to the ports appear. If we loose it, then the LCD controller
> driver would somehow need to find out that it's alone and create the
> DRM device itself.

DT is not the only way to create devices. The DRM driver can bind to
the LCDC node and then create a child CRTC device (or even multiple
ones for h/w with multiple pipelines).

You'll also notice that there are only 3 cases of this virtual node in
the tree: STi, i.MX IPU, and Rockchip. That's because we've deprecated
doing these virtual nodes for some time now. IOW, there are several
examples of how to do this without a virtual node.

Rob

Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846CDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B122086A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550867034;
	bh=MQNg600yltEQ3omzkZ4cEVWIZ3wPLnF7b89pQb26PFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bTVATnpbvlcPczRVJLNiY8dDIwtQT5W+yOTDKiI48iA5OmSMGY7aXyLtk5ergTlXs
	 UIX5S7ThhUZyDEp6mhnieHeOS4q8wcCw5pLWTEjTlug8V0NnERMfAteKILHobFeyfL
	 9nqFzkSrML8HnDKvsUBJmylI9qviRkj7e311GBJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfBVUXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:23:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfBVUXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:23:52 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F3162086D;
        Fri, 22 Feb 2019 20:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550867031;
        bh=MQNg600yltEQ3omzkZ4cEVWIZ3wPLnF7b89pQb26PFg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJapi6X9+h7osgT6AOi95uoqH0JntEQfmgGLlEm9fH08P+4Ovv89eewVpOn2s8LFz
         jUBV+ZuaEMGPNkCSnJQ+7Xp38G7/LapyCmogh5F9ULonpS7jX/ft6pmEyHbQFBYhQq
         Qh1kDnvlFM8Jy9XhipB+1eQPArrTETat/a13ttF8=
Received: by mail-qt1-f170.google.com with SMTP id z39so4044072qtz.0;
        Fri, 22 Feb 2019 12:23:51 -0800 (PST)
X-Gm-Message-State: AHQUAuY4HFuIytnB9+tQjtlIrMAvz3LALExMEFSxww4UkFZtGa+2/yI+
        FUkexFM2zPoJJjkmRevLlxLBTqw9g3oK3ps5Nw==
X-Google-Smtp-Source: AHgI3IbNFwJ4k/VXAT+e9Zj09+F4TqF4Pom3htuqcF/FQUCsC6x5l8bm7Ylb0YsAQMJ61Y9RreXlU/fefY864hiJ3J0=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr4547080qve.246.1550867030224;
 Fri, 22 Feb 2019 12:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20190120172534.24617-1-lkundrak@v3.sk> <20190120172534.24617-5-lkundrak@v3.sk>
 <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com> <b92426e9f5c50c71fa89ea5b53396c1885cc396f.camel@v3.sk>
In-Reply-To: <b92426e9f5c50c71fa89ea5b53396c1885cc396f.camel@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Feb 2019 14:23:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJsfwC4fAJaVEvKwtZkZwapu5jojEFn6Ddx34a6jZ_dSQ@mail.gmail.com>
Message-ID: <CAL_JsqJsfwC4fAJaVEvKwtZkZwapu5jojEFn6Ddx34a6jZ_dSQ@mail.gmail.com>
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

On Wed, Feb 13, 2019 at 4:37 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
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
> Before I follow up on this and submit a version without the virtual
> node, I'm wondering: is it okay that the bindings for the LCDC and the
> framebuffer are in the same file, or would it be preferrable if they
> were separate? Both styles seem to be used for the display bindings.

framebuffer as in the kernel fbdev? Really, that should be the same
binding. It's the same h/w after all. However, there have been cases
where things deviated. So I don't have a good answer.

Rob

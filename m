Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEDC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9727420663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfBXQPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:15:39 -0500
Received: from shell.v3.sk ([90.176.6.54]:50752 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfBXQPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:15:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BC08A100588;
        Sun, 24 Feb 2019 17:15:35 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id bzMlmubDcem7; Sun, 24 Feb 2019 17:15:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 760DF1021C6;
        Sun, 24 Feb 2019 17:15:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yP3elijAZ64b; Sun, 24 Feb 2019 17:15:31 +0100 (CET)
Received: from nedofet.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6A1E1100588;
        Sun, 24 Feb 2019 17:15:31 +0100 (CET)
Message-ID: <4e89406842c4821d590dc6518076cfe6f19cc6b9.camel@v3.sk>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem
 binding
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Sun, 24 Feb 2019 17:15:30 +0100
In-Reply-To: <CAL_JsqJsfwC4fAJaVEvKwtZkZwapu5jojEFn6Ddx34a6jZ_dSQ@mail.gmail.com>
References: <20190120172534.24617-1-lkundrak@v3.sk>
         <20190120172534.24617-5-lkundrak@v3.sk>
         <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
         <b92426e9f5c50c71fa89ea5b53396c1885cc396f.camel@v3.sk>
         <CAL_JsqJsfwC4fAJaVEvKwtZkZwapu5jojEFn6Ddx34a6jZ_dSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-22 at 14:23 -0600, Rob Herring wrote:
> On Wed, Feb 13, 2019 at 4:37 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
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
> > Before I follow up on this and submit a version without the virtual
> > node, I'm wondering: is it okay that the bindings for the LCDC and the
> > framebuffer are in the same file, or would it be preferrable if they
> > were separate? Both styles seem to be used for the display bindings.
> 
> framebuffer as in the kernel fbdev? Really, that should be the same
> binding. It's the same h/w after all. However, there have been cases
> where things deviated. So I don't have a good answer.

No, not the fbdev device, that one is managed by drmfb and is not
expressed in DT. I meant the reserved-memory node that sets aside
memory for the framebuffers.

See patch "[RFC 03/16] dt-bindings: display: armada: Add framebuffer
reserved-mem binding". Perhaps that part should even go to
Documentation/devicetree/bindings/reserved-memory/.

Lubo


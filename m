Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CC9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFB722360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFB722360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeKNPR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:17:29 -0500
Received: from hermes.aosc.io ([199.195.250.187]:55863 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbeKNPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:17:29 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id A0766A2871;
        Wed, 14 Nov 2018 05:15:45 +0000 (UTC)
Message-ID: <fcba25b0035060006a750dfbacabf2bfcbd50eff.camel@aosc.io>
Subject: Re: [PATCH v4 07/10] dt-bindings: phy: add binding for Allwinner
 USB3 PHY
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 14 Nov 2018 13:15:40 +0800
In-Reply-To: <CAL_JsqL=YY2K0KPK-fN1O-a3R4o5GwYUZr9wyA2DOaXc29Hh3g@mail.gmail.com>
References: <20181004122855.22981-1-icenowy@aosc.io>
         <20181004122855.22981-8-icenowy@aosc.io> <20181005205855.GA2458@bogus>
         <92e92f817d4df753d654124514e89c62f40d52eb.camel@aosc.io>
         <CAL_JsqL=YY2K0KPK-fN1O-a3R4o5GwYUZr9wyA2DOaXc29Hh3g@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-10-18四的 08:58 -0500，Rob Herring写道：
> On Sat, Oct 13, 2018 at 9:42 PM Icenowy Zheng <icenowy@aosc.io>
> wrote:
> > 
> > 在 2018-10-05五的 15:58 -0500，Rob Herring写道：
> > > On Thu, Oct 04, 2018 at 08:28:52PM +0800, Icenowy Zheng wrote:
> > > > The new Allwinner H6 SoC contains a USB3 PHY that is wired to
> > > > the
> > > > external USB3 pins of the SoC.
> > > > 
> > > > Add a device tree binding for the PHY.
> > > > 
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > > ---
> > > > Changes in v4:
> > > > - Changed Vbus regulator property to vbus-supply.
> > > > 
> > > > Changes in v3:
> > > > - Added Chen-Yu's Review tag.
> > > > 
> > > > No changes in v2, v1.
> > > > 
> > > >  .../bindings/phy/sun50i-usb3-phy.txt          | 23
> > > > +++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/phy/sun50i-
> > > > usb3-phy.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-
> > > > phy.txt b/Documentation/devicetree/bindings/phy/sun50i-usb3-
> > > > phy.txt
> > > > new file mode 100644
> > > > index 000000000000..9f49c6b8c7e7
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
> > > > @@ -0,0 +1,23 @@
> > > > +Allwinner sun50i USB3 PHY
> > > > +-----------------------
> > > > +
> > > > +Required properties:
> > > > +- compatible : should be one of
> > > > +  * allwinner,sun60i-h6-usb3-phy
> > > > +- reg : a list of offset + length pairs
> > > > +- #phy-cells : from the generic phy bindings, must be 0
> > > > +- clocks : phandle + clock specifier for the phy clock
> > > > +- resets : phandle + reset specifier for the phy reset
> > > > +
> > > > +Optional Properties:
> > > > +- vbus-supply : a phandle to a regulator that provides power
> > > > to
> > > > VBUS.
> > > 
> > > This belongs in a connector node as it is part of the connector
> > > unless
> > > the phy physically needs Vbus for power.
> > > 
> > > But others have done this, so all the phys can just be wrong...
> > 
> > How should we reference the connector?
> > 
> > Via OF graph or simply a property in PHY node?
> 
> The connector is either a child of the controller or an OF graph from
> the controller to the connector. The phy driver needs the controller
> node and then it can walk the tree or graph to get the connector
> node.

By reading the binding, it says the connector should be a child of the
"interface controller", not the USB controller. In this case I think
the interface controller is the PHY rather than the USB controller.

In addition, the connector is a passive component, and power management
should be done by the "interface controller", either directly by the
PHY or make a dummy interface controller driver that only controls the
Vbus.

> 
> Rob
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


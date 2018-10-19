Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4801EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029E821477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029E821477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeJSN6y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:58:54 -0400
Received: from hermes.aosc.io ([199.195.250.187]:50236 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbeJSN6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:58:54 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id A4D9715D27F;
        Fri, 19 Oct 2018 05:54:16 +0000 (UTC)
Date:   Fri, 19 Oct 2018 13:54:10 +0800
In-Reply-To: <CAL_JsqL=YY2K0KPK-fN1O-a3R4o5GwYUZr9wyA2DOaXc29Hh3g@mail.gmail.com>
References: <20181004122855.22981-1-icenowy@aosc.io> <20181004122855.22981-8-icenowy@aosc.io> <20181005205855.GA2458@bogus> <92e92f817d4df753d654124514e89c62f40d52eb.camel@aosc.io> <CAL_JsqL=YY2K0KPK-fN1O-a3R4o5GwYUZr9wyA2DOaXc29Hh3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH v4 07/10] dt-bindings: phy: add binding for Allwinner USB3 PHY
To:     robh@kernel.org, Rob Herring <robh@kernel.org>
CC:     devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <6A511BD2-AF0F-40E5-B1B4-F37BC8D7263E@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年10月18日 GMT+08:00 下午9:58:25, Rob Herring <robh@kernel.org> 写到:
>On Sat, Oct 13, 2018 at 9:42 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>>
>> 在 2018-10-05五的 15:58 -0500，Rob Herring写道：
>> > On Thu, Oct 04, 2018 at 08:28:52PM +0800, Icenowy Zheng wrote:
>> > > The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
>> > > external USB3 pins of the SoC.
>> > >
>> > > Add a device tree binding for the PHY.
>> > >
>> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> > > ---
>> > > Changes in v4:
>> > > - Changed Vbus regulator property to vbus-supply.
>> > >
>> > > Changes in v3:
>> > > - Added Chen-Yu's Review tag.
>> > >
>> > > No changes in v2, v1.
>> > >
>> > >  .../bindings/phy/sun50i-usb3-phy.txt          | 23
>> > > +++++++++++++++++++
>> > >  1 file changed, 23 insertions(+)
>> > >  create mode 100644 Documentation/devicetree/bindings/phy/sun50i-
>> > > usb3-phy.txt
>> > >
>> > > diff --git a/Documentation/devicetree/bindings/phy/sun50i-usb3-
>> > > phy.txt
>b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> > > new file mode 100644
>> > > index 000000000000..9f49c6b8c7e7
>> > > --- /dev/null
>> > > +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> > > @@ -0,0 +1,23 @@
>> > > +Allwinner sun50i USB3 PHY
>> > > +-----------------------
>> > > +
>> > > +Required properties:
>> > > +- compatible : should be one of
>> > > +  * allwinner,sun60i-h6-usb3-phy
>> > > +- reg : a list of offset + length pairs
>> > > +- #phy-cells : from the generic phy bindings, must be 0
>> > > +- clocks : phandle + clock specifier for the phy clock
>> > > +- resets : phandle + reset specifier for the phy reset
>> > > +
>> > > +Optional Properties:
>> > > +- vbus-supply : a phandle to a regulator that provides power to
>> > > VBUS.
>> >
>> > This belongs in a connector node as it is part of the connector
>> > unless
>> > the phy physically needs Vbus for power.
>> >
>> > But others have done this, so all the phys can just be wrong...
>>
>> How should we reference the connector?
>>
>> Via OF graph or simply a property in PHY node?
>
>The connector is either a child of the controller or an OF graph from
>the controller to the connector. The phy driver needs the controller
>node and then it can walk the tree or graph to get the connector node.

Why is it a child of the controller?

I think on hardware the connector is connected to the PHY via USB, and PHY is
connected to the controller via ULPI/UTMI and PIPE, so the connector node
should link to PHY in some way, not to controller.

For Allwinner USB3 PHY I prefer to use child node now, as it's a simple
single-port PHY, and there seems to be no reserved space for multi-port.

>
>Rob

Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104B5C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF612087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ctBthBsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF612087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeJRTYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:24:16 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33210 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeJRTYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:24:16 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79F5C1277;
        Thu, 18 Oct 2018 13:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1539861820;
        bh=Ua5VvH5u+egpbUIXpxDSJvUMBkDLZAMSnks4J3fHYQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctBthBsYTcfxQ4g5G2bKpm3eYy1MAkSvRP3YZGaIYloc/2ie/bn7WKSWs+k5V+g7Y
         nJJYvpVizFO4003sC/NmMv8uoewFHifb+0HI20Do+H867wp4GD6bThCxypNVUoIjRa
         FtdlmW7k1dNjhZDhc5od8kEY+Y+aXzFczULhvfkM=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/9] dt-bindings: Add ANX6345 DP/eDP transmitter binding
Date:   Thu, 18 Oct 2018 14:23:50 +0300
Message-ID: <2778638.na8ndVNUfi@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <c68f0da9607805e1f6673a9a16a7dcfff4d8fe91.camel@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io> <1886367.eljNk7jKYl@avalon> <c68f0da9607805e1f6673a9a16a7dcfff4d8fe91.camel@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Thursday, 18 October 2018 13:00:05 EEST Icenowy Zheng wrote:
> =E5=9C=A8 2018-10-18=E5=9B=9B=E7=9A=84 11:53 +0300=EF=BC=8CLaurent Pincha=
rt=E5=86=99=E9=81=93=EF=BC=9A
> > On Thursday, 18 October 2018 10:33:22 EEST Icenowy Zheng wrote:
> >> The ANX6345 is an ultra-low power DisplayPort/eDP transmitter
> >> designed
> >> for portable devices.
> >>=20
> >> Add a binding document for it.
> >>=20
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>=20
> >>  .../bindings/display/bridge/anx6345.txt       | 39 +++++++++++++++++++
> >>=20
> >>  1 file changed, 39 insertions(+)
> >>  create mode 100644
> >>=20
> >> Documentation/devicetree/bindings/display/bridge/anx6345.txt
> >>=20
> >> diff --git
> >> a/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> >> b/Documentation/devicetree/bindings/display/bridge/anx6345.txt new
> >> file
> >> mode 100644
> >> index 000000000000..0689d4eb5f65
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/bridge/anx6345.txt
> >> @@ -0,0 +1,39 @@
> >> +Analogix ANX6345 eDP Transmitter
> >> +--------------------------------
> >> +
> >> +The ANX6345 is an ultra-low power Full-HD eDP transmitter designed
> >> for
> >> +portable devices.
> >> +
> >> +Required properties:
> >> +
> >> + - compatible		: "analogix,anx6345"
> >> + - reg			: I2C address of the device
> >> + - reset-gpios		: Which GPIO to use for reset
> >> +
> >> +Optional properties:
> >> +
> >> + - dvdd12-supply	: Regulator for 1.2V digital core power.
> >> + - dvdd25-supply	: Regulator for 2.5V digital core power.
> >=20
> > Shouldn't these to supplies be mandatory ?
>=20
> Yes they should.
>=20
> >> + - panel-supply		: Regulator for the power of the panel.
> >=20
> > Shouldn't the panel supply for specified in the DT node of the panel
> > ?
>=20
> However, eDP panel can be probed, may vary on the same device, and we
> don't have a generic binding for it...

Shouldn't we fix that ? :-)

> >> + - edid			: verbatim EDID data block describing
> >> attached
> >> +			  panel, only used when the panel has no EDID
> >> info.
> >=20
> > This should also be specified in the panel DT node.
> >=20
> > > + - Video port for RGB input, using the DT bindings defined in [1].
> >=20
> > I think you should also add a port for the output.
>=20
> What will it point to?

The panel DT node ?

> >> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> >> +
> >> +Example:
> >> +
> >> +anx6345: anx6345@38 {
> >> +	compatible =3D "analogix,anx6345";
> >> +	reg =3D <0x38>;
> >> +	reset-gpios =3D <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> >> +	panel-supply =3D <&reg_dc1sw>;
> >> +	dvdd25-supply =3D <&reg_dldo2>;
> >> +	dvdd12-supply =3D <&reg_fldo1>;
> >> +
> >> +	port {
> >> +		anx6345_in: endpoint {
> >> +			remote-endpoint =3D <&tcon0_out_anx6345>;
> >> +		};
> >> +	};
> >> +};

=2D-=20
Regards,

Laurent Pinchart




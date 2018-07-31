Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861DFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3412B208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3412B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbeGaKvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:51:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58036 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbeGaKvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:51:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 444B720756; Tue, 31 Jul 2018 11:11:52 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id F1F06206A8;
        Tue, 31 Jul 2018 11:11:51 +0200 (CEST)
Date:   Tue, 31 Jul 2018 11:11:51 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     f.fainelli@gmail.com, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 3/4] dt-bindings: net: phy: mscc: vsc8531: fix missing
 "/bits/ 8" in example
Message-ID: <20180731091151.mfgxxnz6kye4cvfv@qschulz>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
 <20180730130236.3837-3-quentin.schulz@bootlin.com>
 <20180730135813.GH13198@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vwalimjjmzvj7stw"
Content-Disposition: inline
In-Reply-To: <20180730135813.GH13198@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vwalimjjmzvj7stw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Jul 30, 2018 at 03:58:13PM +0200, Andrew Lunn wrote:
> On Mon, Jul 30, 2018 at 03:02:35PM +0200, Quentin Schulz wrote:
> > The "vsc8531,led-N-mode" property is read as a u8 in the driver and
> > there aren't a lot of modes anyway.
> >=20
> > Without the "/bits/ 8" in front of the value of the property, the
> > value is stored as an u32 resulting in of_read_property_u8 to always
> > return 0.
>=20
> Hi Quentin
>=20
> on big endian systems. I'm expect this worked on little endian ARM. I
> think the development work was done on a hacked RPi, if i remember
> correctly.
>=20
> >=20
> > Fix the example so that people using the property can actually use it.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt=
 b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > index 664d9d0543fc..4c7d1d384df0 100644
> > --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> > @@ -63,6 +63,6 @@ Example:
> >                  compatible =3D "ethernet-phy-id0007.0570";
> >                  vsc8531,vddmac		=3D <3300>;
> >                  vsc8531,edge-slowdown	=3D <7>;
> > -                vsc8531,led-0-mode	=3D <LINK_1000_ACTIVITY>;
> > -                vsc8531,led-1-mode	=3D <LINK_100_ACTIVITY>;
> > +                vsc8531,led-0-mode	=3D /bits/ 8 <LINK_1000_ACTIVITY>;
> > +                vsc8531,led-1-mode	=3D /bits/ 8 <LINK_100_ACTIVITY>;
>=20
> I don't know the device tree language well enough...
>=20
> Would this work?
>=20
> vsc8531,led-1-mode	=3D < /bits/ 8  LINK_100_ACTIVITY>;
>=20
> If so, you can make it part of the #define.

It does not compile unfortunately. According to the documentation of
DTC[1], /bits/ 8 should prefix the value/array so I guess we're out of
luck for using the same define in the kernel and DTS if we want to
abstract this prefix.

Quentin

[1] https://git.kernel.org/pub/scm/utils/dtc/dtc.git/tree/Documentation/dts=
-format.txt#n46

--vwalimjjmzvj7stw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAltgJ9cACgkQhLiadT7g
8aNRxQ//W8xcDndtBdAN0lAb2dm2Cfqk/37IFbAPMJdPLvQCzoOU3lZjfjFJhj+/
f07+JU4zrrZd84Vg7b1398L7pi1leB2XQa3HtHFhHu0V9OZ+95VkjIdpU5cBCcdM
Obd757fXFhC5ekPBxffdm9FLpIWDYZv7s9KdhgjSjJHe5B9v3V5GMiW0wcVFWu/3
Ut4Mebuf8POqvtLjp0IUZcdaNwEfpaLAmHjtibyUfMp7SRFl2JQ+ELV/TtPAwB5E
KmBv+a1E6em3qfNETg7mCzKScXD7m0+RDHin/mf6zgi/bYKD9/94qrNIFJvLqgCU
FrO/zwE/aY1NW5jG35GprpFrl0xBQVf0WcIUpX9Y9CyXglLM4PUPQqyWDItBjZ9H
q3+LKH0tOp3cHM1VQcZZO5KWAyrwWadmuohcONNDj2XzA0xySzIq47f6aAkmoUBO
aq/1f8V7DtkJo2GWrrziChgcMd/SZzB7WSa1QqpVZ5UDFPc2rFgA6GXMgDnWUVOS
5lW/Stms2YT+SwnFOxZlbadrwp/jNwTHGOinz/GWFQRo6iiNoLdWT1/AkZBf2KEh
59TFhlM7XiSiKZTsFsEoQ+umNI5XPFCrFodlSthQWZJYDS7EZEq69824FOUh8Rx6
/eYB17PHZHy/FwCpCGZrdpvOrC/Rg5IEvs89Xi/SWpEuIukxN48=
=eird
-----END PGP SIGNATURE-----

--vwalimjjmzvj7stw--

Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF951C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A9A20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A9A20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbeHAKAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:00:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33511 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387719AbeHAKAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:00:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A1F832074F; Wed,  1 Aug 2018 10:15:40 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id DF70220740;
        Wed,  1 Aug 2018 10:15:39 +0200 (CEST)
Date:   Wed, 1 Aug 2018 10:15:39 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 07/10] dt-bindings: phy: add DT binding for Microsemi
 Ocelot SerDes muxing
Message-ID: <20180801081539.gxkviv6rnpwzoyxb@qschulz>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <cd75c96640cc7fe306ee355acb1db85adb5b796f.1532954208.git-series.quentin.schulz@bootlin.com>
 <bcea7c75-e5a6-4533-aee0-65c893e8a422@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ttyslgyn422axldo"
Content-Disposition: inline
In-Reply-To: <bcea7c75-e5a6-4533-aee0-65c893e8a422@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ttyslgyn422axldo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, Jul 30, 2018 at 02:39:35PM -0700, Florian Fainelli wrote:
> On 07/30/2018 05:43 AM, Quentin Schulz wrote:
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt | 42 +++++=
++-
> >  1 file changed, 42 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-se=
rdes.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.tx=
t b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > new file mode 100644
> > index 0000000..25b102d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> > @@ -0,0 +1,42 @@
> > +Microsemi Ocelot SerDes muxing driver
> > +-------------------------------------
> > +
> > +On Microsemi Ocelot, there is a handful of registers in HSIO address
> > +space for setting up the SerDes to switch port muxing.
> > +
> > +A SerDes X can be "muxed" to work with switch port Y or Z for example.
> > +One specific SerDes can also be used as a PCIe interface.
> > +
> > +Hence, a SerDes represents an interface, be it an Ethernet or a PCIe o=
ne.
> > +
> > +There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
> > +half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G suppo=
rts
> > +10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
> > +
> > +Also, SERDES6G number (aka "macro") 0 is the only interface supporting
> > +QSGMII.
> > +
> > +Required properties:
> > +
> > +- compatible: should be "mscc,vsc7514-serdes"
> > +- #phy-cells : from the generic phy bindings, must be 3. The first num=
ber
> > +               defines the kind of Serdes (1 for SERDES1G_X, 6 for
> > +	       SERDES6G_X), the second defines the macros in the specified
> > +	       kind of Serdes (X for SERDES1G_X or SERDES6G_X) and the
> > +	       last one defines the input port to use for a given SerDes
> > +	       macro,
>=20
> It would probably be more natural to reverse some of this and have the
> 1st cell be the input port, while the 2nd and 3rd cell are the serdes
> kind and the serdes macro type. Same comment as Andrew, can you please
> define the 2nd and 3rd cells possible values in a header file that you
> can include from both the DTS and the driver making use of that?

OK for a define for the DeviceTree part.

You want one set of defines for the values in the 2nd cell and one other
set of defines for the 3rd cell?

I'm fine with a define for the second value (which is basically the enum
serdes_type I've defined at the beginning of the serdes driver) but I
don't see the point of defining the index of the SerDes. What would it
look like?

enum serdes_type {
	SERDES1G =3D 1,
	SERDES6G =3D 6,
}

#define SERDES1G_0	0
#define SERDES1G_1	1
#define SERDES1G_2	2
#define SERDES6G_0	0
#define SERDES6G_1	1

Then, e.g.:

&port5 {
	phys =3D <&serdes 5 SERDES1G SERDES1G_0>
};

If you want a define for the pair (serdes_type, serdes_index), I don't
see how I could re-use it on the driver side but it makes more sense on the
DeviceTree side:

#define SERDES1G_0	1 0
#define SERDES1G_1	1 1
#define SERDES1G_2	1 2
#define SERDES6G_0	6 0
#define SERDES6G_1	6 1

Quentin

--ttyslgyn422axldo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlthbCsACgkQhLiadT7g
8aMn1Q//flSQjNEklNYgfyaq/ZlLriC4wdz8c11wAMiMT+ibj2YHlO8+4Ty7Q9Lx
7XHG9/pabDr1uYkMW1LGtwHvJjrKpfYURKXEycH9GkjWYISClviwF+DLzIFaCKzk
YvTcBlTh/oAbIq0auau3JTe/FOSx//uOn5la7vdzjluNNZz+NW9Y4ZA94ZZCthLd
N40uR+5HIf/DSFll/Vf/5ivGh+F5jUT8mTdeDgJpZ7X5RJo+a/FqiGruurMavFMC
ljldSwDDBmK3UfXxygIpp2nW0K0umaGzF8eshizEPoYB4UHb4a6TCRnuR4PHfvKA
O+8K1Kuc4dGAO8liD5kCG/x1T/t3ZlK4hrqKzS62XtsF3F05WpaMzC4CT43jTjq9
qcqDeMZPjoGFNVYzpgTbYRn4+xdU//qpguvnV/tnvgx38+Hqy/fygB9cBJqOzb8h
WcAe/IaZxeXNOuHrRGhfTea0N6vRNUJhXqLCb7rhlWsIgwn4yw+cN+8vfq5ZHkj7
GYbFdPtFlIR37ulVtO9W5Rhz1jUqfH7sO5Ij14Z08v/0y3qTcIbadFQCp4APg1yH
/qj4RTXPSTC/uzCFRaHFZI2MeNuz7vqEzpgeDu4yQmUYmxeAAhAGctvlhsJc7pWH
moip7728lCPTtAUbjzraThUv9+mV/PYt714TDfjbj2vLYIythM4=
=UbLu
-----END PGP SIGNATURE-----

--ttyslgyn422axldo--

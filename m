Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D23C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B4E20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B4E20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeHaO1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:27:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36399 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeHaO1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:27:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C0AB6207B1; Fri, 31 Aug 2018 12:20:22 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8483320618;
        Fri, 31 Aug 2018 12:20:22 +0200 (CEST)
From:   maxime.ripard@bootlin.com
Date:   Fri, 31 Aug 2018 12:20:21 +0200
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Message-ID: <20180831102021.idz42sfgldihpkrp@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
 <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iuyup6akl4fzegyw"
Content-Disposition: inline
In-Reply-To: <20180831075631.GB16301@Red>
11;rgb: 00000/2b2b/3636From: Maxime Ripard <maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iuyup6akl4fzegyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 09:56:31AM +0200, Corentin Labbe wrote:
> On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > R40 have a sata controller which is the same as A20.
> > > This patch adds a DT node for it.
> > >=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun=
8i-r40.dtsi
> > > index 852c2ccc3268..d6b5820da850 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > @@ -550,6 +550,29 @@
> > >  			#size-cells =3D <0>;
> > >  		};
> > > =20
> > > +		ahci: sata@1c18000 {
> > > +			compatible =3D "allwinner,sun8i-r40-ahci";
> > > +			reg =3D <0x01c18000 0x1000>;
> > > +			interrupts =3D <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > +			clocks =3D <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > +			resets =3D <&ccu RST_BUS_SATA>;
> > > +			resets-name =3D "ahci";
> > > +			#address-cells =3D <1>;
> > > +			#size-cells =3D <0>;
> > > +			status =3D "disabled";
> > > +
> > > +			sata_port: sata-port@0 {
> > > +				reg =3D <0>;
> > > +				phys =3D <&sata_phy>;
> > > +			};
> > > +		};
> > > +
> > > +		sata_phy: sata-phy@1c180c0  {
> > > +			compatible =3D "allwinner,sun8i-r40-sata-phy";
> > > +			reg =3D <0x1c180c0 0x200>;
> >=20
> > Overlapping devices in the DTS is not ok.
> >=20
>=20
> I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000
> phy@e900a0)
>
> But since it is not a good justification, it seems that regmap is my
> only solution ?

I'm not even sure why you are moving the phy out of its original node
(and driver).

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iuyup6akl4fzegyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJFmQACgkQ0rTAlCFN
r3RwrQ//U3Gb2LBuRwsQ9GNqECkI8F5YsbFtURvA4Z2SVb0CZosWBJhZSq8HH2E2
ZTUQ3IlVWIYIvhHd/hj7gMOjXq2o7QtU+RCLCBa21yRsuk0begIAomOlY9WiHPBa
dV1iGk8deiPV+sNGhUZeOZTkkiurAKmXk0mkMpNBibnchv6PMoDrU8SpsfXoot4y
gGV6OLwdi/VDkU3QYiQEhJjgcgGSPr4ZDfbupapNfIK0jMFTNy/g/RwdfCdE7yMl
Ur8KckrXIML3zPuUU3UNRnrtkjvBn3jekB7sNftgN3mWE3E53sAIVJj7yfTyMhNH
2F1jWmE+iXkoC/b7Z27xNcGzGpMlfRCP/c72cYSJHCEr3+sno6JNzyf8ouwEBvur
FL3GV23N4DpAFCZbav+UjjI+kpbcDfDUg3QPfrkQZwHTSLDo1zALQUmwH5JH02ji
IDNczbOFc+fRdqCmckMgg0CZ4eS9oAIvklea0y65hvBDWcdFr0fDzwPBuY2m/TIf
5mipSj+nu9mjFmVNOFl43YvykB4EscTu1o6GH8Ah6RbuRy/qke4EUqZX+Iiq9zn8
OP5OnluhPSfe4qB/BU7e83zeNJ9e38U/3QwPtmidrET32nVQSY5EXsIIHlHYIC2O
N9gbGTW+0bsTWtkJpBLPyJRq0agptVXIEKO0dzI9V419lT2uqf0=
=1DZb
-----END PGP SIGNATURE-----

--iuyup6akl4fzegyw--

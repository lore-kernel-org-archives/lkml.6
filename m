Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DCAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2C020645
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2C020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeHaO2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:28:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36485 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbeHaO2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:28:00 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8FCCA207B1; Fri, 31 Aug 2018 12:21:11 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 63AEE20618;
        Fri, 31 Aug 2018 12:21:11 +0200 (CEST)
Date:   Fri, 31 Aug 2018 12:21:10 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 12/13] ARM: dts: sun4i: a10: add sata-port/sata-phy
 nodes
Message-ID: <20180831102110.pskz6jy47elwxguw@flea>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-13-clabbe.montjoie@gmail.com>
 <20180831073724.kuw5tb6yypb4pmkp@flea>
 <20180831075350.GA16301@Red>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbw4hb77urw3z3wt"
Content-Disposition: inline
In-Reply-To: <20180831075350.GA16301@Red>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lbw4hb77urw3z3wt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 09:53:50AM +0200, Corentin Labbe wrote:
> On Fri, Aug 31, 2018 at 09:37:24AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 30, 2018 at 09:01:19PM +0200, Corentin Labbe wrote:
> > > This patch convert sun4i-a10 sata to the new binding which use a sata
> > > phy node.
> > >=20
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun=
4i-a10.dtsi
> > > index 3d62a8950720..52d5c2e79499 100644
> > > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > > @@ -556,7 +556,20 @@
> > >  			reg =3D <0x01c18000 0x1000>;
> > >  			interrupts =3D <56>;
> > >  			clocks =3D <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
> > > +			#address-cells =3D <1>;
> > > +			#size-cells =3D <0>;
> > >  			status =3D "disabled";
> > > +
> > > +			sata_port: sata-port@0 {
> > > +				reg =3D <0>;
> > > +				phys =3D <&sata_phy>;
> > > +			};
> > > +		};
> > > +
> > > +		sata_phy: sata_phy@1c180c0 {
> > > +			compatible =3D "allwinner,sun4i-a10-sata-phy";
> > > +			reg =3D <0x01c180c0 0x200>;
> > > +			#phy-cells =3D <0>;
> > >  		};
> >=20
> > This patch, together with the following one, breaks the DT ABI, this
> > isn't something we can do anymore.
>=20
> So what can I do ?

Well, you always have the option of not doing anything.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lbw4hb77urw3z3wt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluJFpUACgkQ0rTAlCFN
r3Q4Rw/9FsPh2Z91dcW/GsyST/EP4FWw4oMBcjdLriuk0bS45uKWbTvcMqcKcxHQ
iFsx+2uSauuyC0Evr8hLv3iUEOkXPFoTXJXv+ZVx7q8mWC9Y6H21topTZHj3ZOz3
WmLZBXdSPclkdESx1TvH8jFlC5NB7VGnYHGK6Tc4mvYxtb3xTVPIRFRfl93kqhYl
TfFKeDNJlFHPjOpGSggiPxy885AZkwBebafqlrnYBsiscd5PlHsRPNqXDXdUGPLC
NedflWCf1pb50OR1LSPjT0pFn6IhgzHZuLgEtV6yhrMeb9F8R71be8esfRxQHlt+
AuAl90mQ/hwf4I2N4NtHMEGpbKVcezSLhSxVUbEBxP43QAwzlbD+Lx8a56hjs/RK
g++D+sp9/UdESHMJZ6LEeapLtfML6SMBD+rw3fkf7Sp86CvCkVzZR2kcpHh21tlN
uPu65HaXhuLzBoKme6EYVOqrwSAz/Okm15JpyUzy5LY8b+p15PF7/aiWgSm2QgVC
YbWUBJm6PN7PJzIRLkzn0fMoRpD8Fya4qjGKA4uUbIAvpf5gxJoOhgAN8/gm609i
3RZgZKNeDFFPqlGjG9jkinfpNKczZhHcpYYZJzwYvHDtXgSpXG5TfAGyiPK3io0p
ZTTUiLfdERWTeDKLs9lLKfvEesfupwuZKyKLG92rH/CKFntIlXc=
=W4wO
-----END PGP SIGNATURE-----

--lbw4hb77urw3z3wt--

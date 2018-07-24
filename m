Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2328C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747EA20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747EA20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbeGXPtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:49:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36159 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbeGXPtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:49:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 03E0220935; Tue, 24 Jul 2018 16:42:28 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id CB14420730;
        Tue, 24 Jul 2018 16:42:17 +0200 (CEST)
Date:   Tue, 24 Jul 2018 16:42:18 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emmanuel Vadot <manu@bidouilliste.com>
Cc:     Emmanuel Vadot <manu@freebsd.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org, wens@csie.org,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/5] arm64: dts: allwinner: h5: Add SID for H5
Message-ID: <20180724144218.jdvgrcqkz2kmohqx@flea>
References: <20180724101522.68165-1-manu@freebsd.org>
 <20180724101522.68165-5-manu@freebsd.org>
 <20180724130004.ynaiabshexrrbvo4@flea>
 <20180724153432.e398bddfe63e51e8dcebfc46@bidouilliste.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brs6vm3kqygfnudn"
Content-Disposition: inline
In-Reply-To: <20180724153432.e398bddfe63e51e8dcebfc46@bidouilliste.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--brs6vm3kqygfnudn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 24, 2018 at 03:34:32PM +0200, Emmanuel Vadot wrote:
> On Tue, 24 Jul 2018 15:00:04 +0200
> Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>=20
> > On Tue, Jul 24, 2018 at 12:15:22PM +0200, Emmanuel Vadot wrote:
> > > The SID controller on H5 look the same as the one present in the A64.
> > > But in case we find some difference one day at a compatible string
> > > of it's own and a fallback to the A64 one.
> > >=20
> > > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm6=
4/boot/dts/allwinner/sun50i-h5.dtsi
> > > index 62d646baac3c..28183bf77164 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
> > > @@ -129,3 +129,8 @@
> > >  		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> > >  	compatible =3D "allwinner,sun50i-h5-pinctrl";
> > >  };
> > > +
> > > +&sid {
> > > +	compatible =3D "allwinner,sun50i-h5-sid",
> > > +		     "allwinner,sun50i-a64-sid";
> > > +};
> >=20
> > This is still a bit pointless, please remove the common node.
>=20
>  You mean directly declare sid controller in the SoC dtsi and not
> have a common node in sunxi-h3-h5.dtsi ?

Yep

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--brs6vm3kqygfnudn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAltXOskACgkQ0rTAlCFN
r3S92A/7BqeShOU5I3OcS+OPLhKF42tICmDuPhTESquJZmySeJtbX18zY8prwi86
oYsBlOzJm4pcYCQnUJnVlLbQmraIAJfRTqdg6U5gmC39y2QoFzvKKzByoSNJOESC
GLkhYfNyjz+0UGnkDo3fsS2rvn4XcPvPddDpWgZLP62kSowxbf2xOr0iD+/HcI4Z
wcnLKQMa3Uuz/0czpF0FRvhakpQ8HeiiecRkfVsy6AaJEtnqVrj6CET/aR+E0wGo
XnNWnSr0TNldIfsmf0SSvEeQ5q3PaScqdQ+3pgwpmVo5taA/h/0plMfGTRFlE4Ob
Ofhxs7IgL9qxHkDB4r0iwxKXvEmA36Bxcropk66YgNPLi9PoNluZsyd/bmGsvst4
uvCEDyZ0MKoqvgBwmSMiv/KRcQ3fJKK4iJE1kIeCWHychG+pMV+L8S7CZOwQn05+
eSLN5lQqh1p/N0OCoEMFQlArnAun1AcUjVtJlOJhrebjZvAKFsX8Imz1i6nqOEze
VtU5385ED4Xvhig9VDn8Tlb9q1CwRS/6KF/LXqNxWvPcB98Bpa/81YLefPC/VRWc
20hTdeKzMJe/Tqez7jxjp7owit3UXoPGtvebE7JSjPx6IJ/FNG0LwoQYM56dI8Dl
sJJZsl6ld6szaNhwMuSktma1SMBEvYHwJjqKql8F+t4F2a5R/pg=
=8aZK
-----END PGP SIGNATURE-----

--brs6vm3kqygfnudn--

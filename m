Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936412AbeE2PK7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:10:59 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40962 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeE2PKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:10:53 -0400
X-Auth-Info: yPcEJVVU3W1kWaCrMz8sbEOrYh1/OjK/PfZCeeXiFDk=
Date: Tue, 29 May 2018 17:09:39 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
Message-ID: <20180529170939.68419862@jawa>
In-Reply-To: <CAOMZO5AU8PDEErHeU1yb9mwgNLJUvWipTrDsY8csXSHiNro-7w@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
 <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
 <20180519140202.3449e3c1@jawa>
 <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
 <20180529155736.275e27b1@jawa>
 <CAOMZO5AU8PDEErHeU1yb9mwgNLJUvWipTrDsY8csXSHiNro-7w@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9A6/bDTizbW5tMTtRq96JlK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9A6/bDTizbW5tMTtRq96JlK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Tue, May 29, 2018 at 10:58 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
>=20
> > Sorry for "small" delay on this.
> >
> > Ok, so I've investigated the issue:
> >
> > 1. The code, which you pasted:
> > http://code.bulix.org/ik01yu-339697
> >
> > works correctly as imx53-qsb-common.dtsi directly includes
> > "imx53.dtsi" in which iomuxc label is defined.
> >
> > In my case though,
> >
> > 2. I do include imx53-tqma53.dtsi [1], in which the iomuxc" label
> > is extended:
> >
> > &iomuxc {
> >         pinctrl-names =3D "default";
> >         pinctrl-0 =3D <&pinctrl_hog>;
> >
> >         imx53-tqma53 {
> >                 pinctrl_hog: hoggrp {
> >
> > .......
> >
> > };
> >
> > The imx53-tqma53.dtsi then includes imx53.dtsi.
> >
> > Moreover, my file -> imx53-kp.dtsi as it includes [1], it extends
> > further the &iomuxc label:
> >
> > &iomuxc {
> >         pinctrl-names =3D "default";
> >         pinctrl-0 =3D <&pinctrl_kp_common>;
> >
> >         imx53-kp-common {
> >                 pinctrl_buzzer: buzzergrp {
> > .......
> > };
> >
> > So, when I remove imx53-kp-common I will have mismatch with [1]
> > iomuxc structure.
> >
> > The code works as expected when I do remove imx53-tqma53 in [1].
> >
> > However, I would prefer to not touch this imx53-tqma53.dtsi file.
> > It is also included in: imx53-mba53.dts, which extends iomux in
> > following way:
> >
> > &iomuxc {
> >         lvds1 {
> >                 pinctrl_lvds1_1: lvds1-grp1 {
> >
> >
> > Here I would need to remove lvds1, disp1 and tve to make it working.
> > However, it will not break during build, but at run time.
> >
> > Considering the above, I would prefer to leave the code in [1] as is
> > and use imx53-kp-common as well (as in v2 of this patch).
> >
> > Fabio, what do you think? =20
>=20
> Ok, thanks for the clarification. I just wanted to make sure we did
> not have some kind of iomux bug there.
>=20
> I think your proposed patch is fine then.

Would you be so kind and add your Reviwed-by or Acked-by tag to second
version of this patch?

[PATCH v2] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards from
K+P

>=20
> Thanks




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/9A6/bDTizbW5tMTtRq96JlK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsNbTMACgkQAR8vZIA0
zr2fXQgAtao4u1y4JaUYLUoJuzAWSdvQn0A0d07vW15djS4lP30UuO2Oy1jl7Ab/
ByPwMgoo4IV2l+g/mHDjftkYFLaYoKwjXbJthPx0kKW0AcnheXE0or0nvulJdVwT
HipsnUmKCOknKot/5Xrkt7kCJsdclh9+qIY6JjxCV7VWCJQO6fd8X7PMtmUCz7wF
SNQ7aFZmk8I/3o/gvkHPmXulMwkxK6O66UqzrLrmKtHg1ld5E0RUnTPgwHyybzVt
3zWfJusDITJuYbSn/ibSqTjF+zgRJB9YFPkNruCz8+/Scm8WY+5XeqxxN9xUD5Qd
cm03ykLr50HWaDbc+8C2GjdeFkZpRg==
=rmrB
-----END PGP SIGNATURE-----

--Sig_/9A6/bDTizbW5tMTtRq96JlK--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeESMDC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:03:02 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51127 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeESMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:02:57 -0400
X-Auth-Info: z5GT91cWXU3lXgwzijGniK2UK2LHrufrUfITFoEesWQ=
Date: Sat, 19 May 2018 14:02:02 +0200
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
Message-ID: <20180519140202.3449e3c1@jawa>
In-Reply-To: <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
        <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JiPSsZOYOlL9J=a1XM0m/MN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JiPSsZOYOlL9J=a1XM0m/MN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

Thanks for your feedback.

> Hi Lukasz,
>=20
> On Wed, May 9, 2018 at 12:34 PM, Lukasz Majewski <lukma@denx.de>
> wrote:
>=20
> > +&iomuxc {
> > +       imx53-kp-ddc { =20
>=20
> No need for keeping this imx53-kp-ddc.
>=20
> > diff --git a/arch/arm/boot/dts/imx53-kp-hsc.dts
> > b/arch/arm/boot/dts/imx53-kp-hsc.dts new file mode 100644
> > index 000000000000..fff358395c9d
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx53-kp-hsc.dts
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
> > + */
> > +
> > +/dts-v1/;
> > +#include "imx53-kp.dtsi"
> > +
> > +/ {
> > +       model =3D "K+P imx53 HSC";
> > +       compatible =3D "kiebackpeter,imx53-hsc", "fsl,imx53";
> > + =20
>=20
> No need for this blank line.
>=20
> > +};
> > +
> > +&fec {
> > +       status =3D "okay"; =20
>=20
> We usually put the status in the last line.

After moving status property to the end:

Error: arch/arm/boot/dts/imx53-kp-hsc.dts:21.2-18 Properties must
precede subnodes FATAL ERROR: Unable to parse input tree

So I opt for leaving it as it was.

>=20
> > +       gpio_buttons {
> > +               compatible =3D "gpio-keys";
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <0>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pinctrl_gpiobuttons>;
> > +
> > +               button@1 { =20
>=20
> You pass @1 without a reg property. This triggers a warning when
> building with W=3D1.
>=20
> You could remove the @1.
>=20
> Please make sure this patch does not introduce any W=3D1 dtc warning.
>=20
> > +&iomuxc {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_kp_common>;
> > +
> > +       imx53-kp-common { =20
>=20
> No need for this  imx53-kp-common

After removing imx53-kp-ddc and imx53-kp-common iomux subnodes I do see
following errors in the dmesg (v4.17-rc5):

imx53-pinctrl 53fa8000.iomuxc: function 'iomuxc' not supported
imx53-pinctrl 53fa8000.iomuxc: invalid function iomuxc in map table

Above statements are not visible when I use the v1 code of this patch.

>=20
> > +&uart4 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_uart4>;
> > + =20
>=20
> No need for this blank line.


I will sent fixed version in v2.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/JiPSsZOYOlL9J=a1XM0m/MN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsAEjoACgkQAR8vZIA0
zr1WPAf9FltjR0GYAkrvt9dY4X9+IhtC7+F9UHQEApuPSJEgDLJGmihT7/ExuAuy
Opt0k7YyTb7WmpzKBslCzOU1MW79r0BUgxNjThbPPQdM/x1PmnwlWjbjBkbyRaA4
fRK79QDXzozJQJwi9Nf8wDCk4g/UX9LO1rcuU+3dUqxuFjT5KXcmPIyr5BcBbIlX
UVCi0An6XQCtUK1dymlA14eQhgGkVdOcw1VhK+uInGC4xI/sxqInrDR3EarevBJx
h5ZuhI0p0j0cVsmbEStBqglS87MHTkOhNIXRZz1259bQnKgeG97QHHIxTihX5Lss
42BOLBO8TWuXZMDmobJBR0SZ4A+nrA==
=wEn3
-----END PGP SIGNATURE-----

--Sig_/JiPSsZOYOlL9J=a1XM0m/MN--

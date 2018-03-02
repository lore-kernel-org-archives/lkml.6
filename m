Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428151AbeCBNZx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:25:53 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:32772 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425249AbeCBNZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:25:51 -0500
X-Auth-Info: tvtoVWAiRXWT9gq0fxjudQnnBQzv1Xp4oe0GwlspXws=
Date: Fri, 2 Mar 2018 14:25:37 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: tpc: Device tree description of the TPC board
Message-ID: <20180302142537.25764c8e@jawa>
In-Reply-To: <20180302125159.gufvhyy4ipyunmil@pengutronix.de>
References: <20180302121750.12865-1-lukma@denx.de>
        <20180302125159.gufvhyy4ipyunmil@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/h.BJlyA/0KeqW92nKq8/ngG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h.BJlyA/0KeqW92nKq8/ngG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sascha,

> Hi Lukasz,
>=20
> On Fri, Mar 02, 2018 at 01:17:50PM +0100, Lukasz Majewski wrote:
> > This commit adds device tree description of K+P's TPC board. =20
>=20
> Can we get a hint what this board is? I assume this one:
>=20
> Technologic Systems' Full i.MX6 Portfolio Including SBC, COM, and
> Touch Panel PCs

I just took other imx6q boards as an example - e.g.=20

420127e5a5b53ff2cb5effaa781aed93709b09bb

Generally, descriptions of DTSes are rather short and simple.

>=20
> Anyway, future developers are thankful if they have the information
> around when they have to work on that file or have to decide if it is
> to be removed.

IMHO, there is plenty of information around (iMX6 Quad SoC, with
components described in dts).

>=20
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/Makefile         |   1 +
> >  arch/arm/boot/dts/imx6q-kp-tpc.dts |  84 +++++++
> >  arch/arm/boot/dts/imx6q-kp.dtsi    | 468
> > +++++++++++++++++++++++++++++++++++++ 3 files changed, 553
> > insertions(+) create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
> >  create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index ade7a38543dc..c148c4cf28f2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) +=3D \
> >  	imx6q-icore-ofcap10.dtb \
> >  	imx6q-icore-ofcap12.dtb \
> >  	imx6q-icore-rqs.dtb \
> > +	imx6q-kp-tpc.dtb \
> >  	imx6q-marsboard.dtb \
> >  	imx6q-mccmon6.dtb \
> >  	imx6q-nitrogen6x.dtb \
> > diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > b/arch/arm/boot/dts/imx6q-kp-tpc.dts new file mode 100644
> > index 000000000000..955462e778c9
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > +/dts-v1/;
> > +
> > +#include "imx6q-kp.dtsi"
> > +
> > +/ {
> > +	model =3D "Freescale i.MX6 Quad K+P TPC Board";
> > +	compatible =3D "fsl,imx6q-tpc", "fsl,imx6q"; =20
>=20
> If it is what I think it is the vendor is not fsl.

Yes. It is not from fsl.

>=20
> > +};
> > +
> > +&lcd_display {
> > +	display-timings {
> > +		800x480x60 {
> > +			clock-frequency =3D <34209000>;
> > +			hactive =3D <800>;
> > +			vactive =3D <480>;
> > +			hback-porch =3D <85>;
> > +			hfront-porch =3D <15>;
> > +			vback-porch =3D <34>;
> > +			vfront-porch =3D <10>;
> > +			hsync-len =3D <28>;
> > +			vsync-len =3D <1>;
> > +			hsync-active =3D <1>;
> > +			vsync-active =3D <1>;
> > +			de-active =3D <1>;
> > +		};
> > +	};
> > +};
> > +
> > +&ipu1_di0_disp0 {
> > +	remote-endpoint =3D <&lcd_display_in>;
> > +};
> > +
> > +&can1 {
> > +	status =3D "disabled";
> > +};
> > +
> > +&can2 {
> > +	status =3D "disabled";
> > +}; =20
>=20
> These are not enabled in your base dtsi, so no need to disabled it
> here.

But they can be enabled if needed.

>=20
> > +
> > +&uart1 {
> > +	status =3D "okay";
> > +}; =20
>=20
> This is already enabled in your base dtsi.
>=20
> > +
> > +&uart2 {
> > +	status =3D "disabled";
> > +}; =20
>=20
> This is still disabled, no need to enable.

The goal here is to group those buses in one "logical" item - to allow
easy enabling if needed.

>=20
> > diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi
> > b/arch/arm/boot/dts/imx6q-kp.dtsi new file mode 100644
> > index 000000000000..47a10fb1d46b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> > +
> > +	memory: memory {
> > +		reg =3D <0x10000000 0x40000000>;
> > +	};
> > +
> > +	pwm-buzzer {
> > +		compatible =3D "pwm-backlight"; =20
>=20
> What is it? A backlight or a buzzer?

It is a buzzer, which is controlled by PWM.

>=20
> > +		pwms =3D <&pwm2 0 500000>; //2kHz
> > +		brightness-levels =3D <
> > +			0   7  8  9
> > +			10 11 12 13 14 15 16 17 18 19
> > +			20 21 22 23 24 25 26 27 28 29
> > +			30 31 32 33 34 35 36 37 38 39
> > +			40 41 42 43 44 45 46 47 48 49
> > +			50 51 52 53 54 55 56 57 58 59
> > +			60 61 62 63 64 65 66 67 68 69
> > +			70 71 72 73 74 75 76 77 78 79
> > +			80 81 82 83 84 85 86 87 88 89
> > +			90 91 92 93 94 95 96 97 98 99
> > +			100
> > +			>;
> > +		default-brightness-level =3D <0>;
> > +	};
> > +
> > +	regulators { =20
>=20
> AFAIK regulators shall no longer be in a separate subnode.
>=20
> > +		compatible =3D "simple-bus";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		reg_usb_h1_vbus: regulator@1 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <1>; =20
>=20
> drop the reg property and also the @1 in the name.
>=20
> > +			regulator-name =3D "usb_h1_vbus";
> > +			regulator-min-microvolt =3D <5000000>;
> > +			regulator-max-microvolt =3D <5000000>;
> > +			enable-active-high;
> > +		};
> > +
> > +		reg_audio: regulator@2 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <2>; =20
>=20
> ditto

Ok.

>=20
> > +			regulator-name =3D "sgtl5000-supply";
> > +			gpio =3D <&gpio6 31 GPIO_ACTIVE_HIGH>;
> > +			enable-active-high;
> > +			regulator-always-on;
> > +		};
> > +
> > +		reg_3p3v: regulator@3 {
> > +			compatible =3D "regulator-fixed";
> > +			reg =3D <4>; =20
>=20
> ditto.
>=20
> (You have to change the node names of course to make them unique
> again)

Yes. correct.

Thanks for your review.

>=20
>=20
> Sascha
>=20
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/h.BJlyA/0KeqW92nKq8/ngG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlqZUNEACgkQAR8vZIA0
zr0DmQgAtwo+bLVkFqZJ9EZFJZ7GboWPJdVODX3umayG8Td8YbU55Slsu/kYQuAO
wphZ57yCKuHi6lQRhK34q03kaWtmWqiPn1AFZY9pBCs6yMUWux9DpcLFL7Krxb0/
YDfUEIT9DVKCBSqNTTrKXRsLxQkIw5dcUmJCigu0IgEq/+aIVqLSI3INPq5Esi7C
8pJrGgLaxrBhmoMB9BkvOcxI1iuQ5d1kBskw3Y/UcmxbRJuQVwBgarACUsmKbtns
0L/QZqh0we1Q6cvAVBxQhFSLsWL/ru38hjclUOz2uODaYFbNUBVgBbYS+DoEiPQN
KryjDz3eSPnR5P/9y9bzfpzg2g/UlA==
=Fpld
-----END PGP SIGNATURE-----

--Sig_/h.BJlyA/0KeqW92nKq8/ngG--

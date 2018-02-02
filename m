Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754039AbeBBTtq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:49:46 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:51042 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeBBTtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:49:36 -0500
Date: Fri, 2 Feb 2018 20:49:35 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/3] ARM: dts: sun8i: add audio codec support into V3s
 DTSI
Message-ID: <20180202194935.vdqkgch6mowqi2px@flea.lan>
References: <20180202140153.21549-1-icenowy@aosc.io>
 <20180202140153.21549-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="esaw3md4zvp67dni"
Content-Disposition: inline
In-Reply-To: <20180202140153.21549-3-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--esaw3md4zvp67dni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 10:01:52PM +0800, Icenowy Zheng wrote:
> Allwinner V3s SoC features an internal audio codec like the one in H3,
> and a analog codec like the one in H3/A23 (but much simpler).
>=20
> Add them in the DTSI file.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v=
3s.dtsi
> index 20edebd983f0..f6c534efaef9 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -354,6 +354,25 @@
>  			status =3D "disabled";
>  		};
> =20
> +		codec: codec@01c22c00 {
> +			#sound-dai-cells =3D <0>;
> +			compatible =3D "allwinner,sun8i-v3s-codec";
> +			reg =3D <0x01c22c00 0x400>;
> +			interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
> +			clock-names =3D "apb", "codec";
> +			resets =3D <&ccu RST_BUS_CODEC>;
> +			dmas =3D <&dma 15>, <&dma 15>;
> +			dma-names =3D "rx", "tx";
> +			allwinner,codec-analog-controls =3D <&codec_analog>;
> +			status =3D "disabled";
> +		};
> +
> +		codec_analog: codec-analog@01c23000 {
> +			compatible =3D "allwinner,sun8i-v3s-codec-analog";
> +			reg =3D <0x01c23000 0x4>;

This should be the whole size of the memory region.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--esaw3md4zvp67dni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp0wM4ACgkQ0rTAlCFN
r3Tlxg//TCjPGvAz4ePGihqk06mbEPkHOcsi0o17VPyPG7izW2qAawGf0sYJ/gpR
f4O0E/D1U3fCSykPn9PVJJtiFHa8B94Ni2I6G6KFWo0MkBJw2Q6uciGiTUYb2+EN
2iNG52L9dhNDI2VvPi3V8T922Y+LiC8Ctq1P7OzjKCdOycRKF/RqK+Nyn3F0yTO6
vMf9zZcPqLbbqE+E+VNYkyoov6UbkedFRkEjvKNmTTwawJqu5ioKjX9gbHEMTmD0
Q7NM6Cpy6eaVZzfVfnrC9x6/Wfig+CDQLoCCjcITOUqlTPdouMPydoAbhFvcXOMb
PTQiiKon6Jaf/Lq0N700xqaNJmczPHDP5Csc8Dt9Nk2Iy+eYNbgBN6Lfw4fgyc6L
gtHObdOQ01aehxQrqEc1uX2qQvOk3ie4uABz8cY2W1qwN1CJJNvBHFckRBqksUJA
aVqVCEf3eQQd0SN+kh59NybgiaOVAlFflgNFAiaucrstRCKzAoVJ02J8CZIsE/dg
Y3wEZXyIQtkvxeIHFeRfwdJXU9O0/vndBniCtrRG03qO5PJxDiY4kp8gqyxIAaAu
JuXsoU/kbgCOxJYatDI1HVkN2bqSP3kh57EKJL/AJ+QS3weJEmhuja+eh6bZQoNp
+XSeF9ibRbRYqzoSR3SyCd43Oei6wplSImriNppqww/n6eCo5/Q=
=dqx9
-----END PGP SIGNATURE-----

--esaw3md4zvp67dni--

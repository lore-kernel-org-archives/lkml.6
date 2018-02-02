Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbeBBTs4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:48:56 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:50955 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeBBTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:48:48 -0500
Date: Fri, 2 Feb 2018 20:48:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/3] ARM: dts: sun8i: add DMA engine in V3s DTSI
Message-ID: <20180202194846.eb7vm4t2cy4kwdfo@flea.lan>
References: <20180202140153.21549-1-icenowy@aosc.io>
 <20180202140153.21549-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yjl4as2vkfhvu7dd"
Content-Disposition: inline
In-Reply-To: <20180202140153.21549-2-icenowy@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yjl4as2vkfhvu7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 02, 2018 at 10:01:51PM +0800, Icenowy Zheng wrote:
> Allwinner V3s SoC features a DMA engine.
>=20
> Add it in the DTSI file.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v=
3s.dtsi
> index 443b083c6adc..20edebd983f0 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -178,6 +178,15 @@
>  		};
> =20
>

You have on extra line here

> +		dma: dma-controller@01c02000 {

The leading 0 will generate a DT warning

> +			compatible =3D "allwinner,sun8i-v3s-dma";
> +			reg =3D <0x01c02000 0x1000>;
> +			interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_DMA>;
> +			resets =3D <&ccu RST_BUS_DMA>;
> +			#dma-cells =3D <1>;
> +		};
> +

Since you have that extra line above, you can just drop this new line
here.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--yjl4as2vkfhvu7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp0wJ0ACgkQ0rTAlCFN
r3QHXg//WRyGPbIo6OQuhZJ+AvAGFRaaFEg30BtNLsIgBrACn16mqczakTLNptV7
rMhclhQD3lkPVVbxypEG99Ilyo6vAeV0XkHiPuiHw/NIrCvnCwXX5wpapje/GgxO
B5U/YfGKezxawNAxkVVSaudylrkj6CEMImcR/rslgd2C69JVRGEgg2iidBjhWes+
xYAT/TLBkpTL9N+AZMSDn10lj/c38tak069VlDy2fgjbtjkH4H0GqiObxKIQ0E+V
zFXfE3MnXORkK8xDtZC2z2MFkE7sn+4ZuFtLK/O1Rz3LIrg8JLPJkLHnRk0lt/+G
qzbdoY5IUHoTeOcOCiUTwkP59szdmhBSz9EnQerNSzUScF8UIiU+wHMl7NNAAVJr
ucJO7fVr1tM/T5hBCtqIEMKFTi2mZjp/8oFsgththVfxL0v0WGokE44wMxNcfokS
Z3UD+OooV5yX1gFpnauOIPfF5X2bvD64cyQObnB5nxg7VlHmIZxBPlqCgYg2nWPF
J9A43fUOD5iQF9w2ltZl/OmoPK/WQ609sMv5i/NCn1zewRN0PECSs1HuFqF7625P
I4HNZmPm9OpeBnxptu49R+L4c9CsEXU0U9gevAdq65DL7t3mki2XcTce2g6K+TEw
+sZPmgz3s+81MtBZY9rjb9clhPjVP9qLX6DTGNfF+2qD7GgPnO0=
=TZTS
-----END PGP SIGNATURE-----

--yjl4as2vkfhvu7dd--

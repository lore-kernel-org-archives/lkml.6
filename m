Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeDLO6V (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:58:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57243 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752918AbeDLO6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:58:18 -0400
Date: Thu, 12 Apr 2018 16:58:06 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 5/5] arm64: allwinner: a64: add SRAM controller device
 tree node
Message-ID: <20180412145806.hsvxomh6vousrhq5@flea>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-6-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="evvv32nlsy5xv6f6"
Content-Disposition: inline
In-Reply-To: <20180411141641.14675-6-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--evvv32nlsy5xv6f6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 11, 2018 at 10:16:41PM +0800, Icenowy Zheng wrote:
> Allwinner A64 has a SRAM controller, and in the device tree currently
> we have a syscon node to enable EMAC driver to access the EMAC clock
> register. As SRAM controller driver can now export regmap for this
> register, replace the syscon node to the SRAM controller device node,
> and let EMAC driver to acquire its EMAC clock regmap.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++--=
--
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 1b2ef28c42bd..1c37659d9d41 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -168,10 +168,25 @@
>  		#size-cells =3D <1>;
>  		ranges;
> =20
> -		syscon: syscon@1c00000 {
> -			compatible =3D "allwinner,sun50i-a64-system-controller",
> -				"syscon";
> +		sram_controller: sram-controller@1c00000 {
> +			compatible =3D "allwinner,sun50i-a64-sram-controller";
>  			reg =3D <0x01c00000 0x1000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			sram_c: sram@18000 {
> +				compatible =3D "mmio-sram";
> +				reg =3D <0x00018000 0x28000>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				ranges =3D <0 0x00018000 0x28000>;
> +
> +				de2_sram: sram-section@0 {
> +					compatible =3D "allwinner,sun50i-a64-sram-c";
> +					reg =3D <0x0000 0x28000>;
> +				};
> +			};

That doesn't look related at all to what's being discussed here, so
you'd rather add it as part of your DE2-enablement serie (or amend
your commit log to say why this is important to do it in this patch).

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--evvv32nlsy5xv6f6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrPc/0ACgkQ0rTAlCFN
r3TrHBAAlGqDDoMf+8nx0kwLHtmuEz29Bgkhid/dvZw0aOu7CTa4ySizpdy2Bx+N
9eE5A8ygGyvAlR+pJE6r66IpSGh6xc4ApE3FUR/saRLctQMgCGAo/3msTGlKgbIJ
FZDoFkliZZDS1pKY5Fz3Airkd28x8jaTZBpHLwiAjayjDKX1tseiG0DtifB9/MJN
mC/4/YT9VQQbdOVwAHoyKASkE6YGgyu4TVVAKdlHIT/r9RGcRhxVOQcrPMpvv0RZ
sWObQUjpyINwTEPkRWsI0kDGMCCKCjDStYp7AkIBqP5/HY3SYEl1AGbvw3alwsKj
fHqEp45mWRFYEWM+oZjg4qSVO1YYEUonRw4aasRRw9EUrwxx5Im7KkiywFVYjQbW
DS/oFSNhP8tzuh7F6ufbDy0sTpHmzfVLHv/xkGY8Vrifaydjng3SoLzaiORViIh0
zTh1l2SD/5GMs4dYbfN30phXl4+GafhiVgVN8W3eM888k+m2L3PyzwOW3iw9bRar
oMPywN5B+kPB7Z0u5aFn5WRsCUCA5mr19GAshScPo9RePdiFV3NCAr1W6KJP46lQ
jGwDrDp0yVk/kCipUI2e0j3IseUiQttzRdYqxw8mZxk8vUiLe8ZrDeuao9Sa7pLJ
QffezQtUr+OYXurE4Rl6SNw8zsKP0VsPrJ1XANeHN3XCdaCxR+I=
=Qml+
-----END PGP SIGNATURE-----

--evvv32nlsy5xv6f6--

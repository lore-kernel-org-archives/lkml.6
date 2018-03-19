Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970536AbeCSV1C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:27:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50396 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970441AbeCSV04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:26:56 -0400
Date: Mon, 19 Mar 2018 22:26:38 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] clk: sunxi-ng: add missing hdmi-slow clock for H6 CCU
Message-ID: <20180319212638.4zi2wk76kusemqkh@flea>
References: <20180319081108.23496-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ayikdluu3d7sqex"
Content-Disposition: inline
In-Reply-To: <20180319081108.23496-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ayikdluu3d7sqex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 04:11:07PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 CCU has a "HDMI Slow Clock", which is currently missing
> in the ccu-sun50i-h6 driver.
>=20
> Add this missing clock to the driver.
>=20
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c      | 4 ++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.h      | 2 +-
>  include/dt-bindings/clock/sun50i-h6-ccu.h | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.c
> index d5eab49e6350..bdbfe78fe133 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -643,6 +643,8 @@ static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hd=
mi_parents, 0xb00,
>  				 BIT(31),	/* gate */
>  				 0);
> =20
> +static SUNXI_CCU_GATE(hdmi_slow_clk, "hdmi-slow", "osc24M", 0xb04, BIT(3=
1), 0);
> +
>  static const char * const hdmi_cec_parents[] =3D { "osc32k", "pll-periph=
0-2x" };
>  static const struct ccu_mux_fixed_prediv hdmi_cec_predivs[] =3D {
>  	{ .index =3D 1, .div =3D 36621 },
> @@ -876,6 +878,7 @@ static struct ccu_common *sun50i_h6_ccu_clks[] =3D {
>  	&pcie_aux_clk.common,
>  	&bus_pcie_clk.common,
>  	&hdmi_clk.common,
> +	&hdmi_slow_clk.common,
>  	&hdmi_cec_clk.common,
>  	&bus_hdmi_clk.common,
>  	&bus_tcon_top_clk.common,
> @@ -1017,6 +1020,7 @@ static struct clk_hw_onecell_data sun50i_h6_hw_clks=
 =3D {
>  		[CLK_PCIE_AUX]		=3D &pcie_aux_clk.common.hw,
>  		[CLK_BUS_PCIE]		=3D &bus_pcie_clk.common.hw,
>  		[CLK_HDMI]		=3D &hdmi_clk.common.hw,
> +		[CLK_HDMI_SLOW]		=3D &hdmi_slow_clk.common.hw,
>  		[CLK_HDMI_CEC]		=3D &hdmi_cec_clk.common.hw,
>  		[CLK_BUS_HDMI]		=3D &bus_hdmi_clk.common.hw,
>  		[CLK_BUS_TCON_TOP]	=3D &bus_tcon_top_clk.common.hw,
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h b/drivers/clk/sunxi-ng/=
ccu-sun50i-h6.h
> index ad6da4aa733c..ef499a7d45f2 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.h
> @@ -51,6 +51,6 @@
> =20
>  #define CLK_BUS_DRAM		60
> =20
> -#define CLK_NUMBER		137
> +#define CLK_NUMBER		(CLK_HDMI_SLOW + 1)
> =20
>  #endif /* _CCU_SUN50I_H6_H_ */
> diff --git a/include/dt-bindings/clock/sun50i-h6-ccu.h b/include/dt-bindi=
ngs/clock/sun50i-h6-ccu.h
> index 6045735a2821..205d09d3dc72 100644
> --- a/include/dt-bindings/clock/sun50i-h6-ccu.h
> +++ b/include/dt-bindings/clock/sun50i-h6-ccu.h
> @@ -107,6 +107,7 @@
>  #define CLK_PCIE_AUX		121
>  #define CLK_BUS_PCIE		122
>  #define CLK_HDMI		123
> +#define CLK_HDMI_SLOW		137

It's not been in a release yet, so we can just change the other IDs.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--3ayikdluu3d7sqex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqwKw0ACgkQ0rTAlCFN
r3QaVA/+K3Hv4xvTsYu8Hva+kKJMTT2KTCzQMQVbijy2JAR3ZUabtkpXWNQmjrxb
TAeh9oYxp4wFyeLDvrhzx1jw4EtiRvCLr/HiyEe2Sv6XYbn8QBBFOSMWlnD46LFF
gzHgWkD87xcJv9XGHYjkYnrtBerS5+Miy+3PE03ZWr93KsnqH1MF5sjk3YmcS/WH
auHTtEHNcYFtFORqsTqWD5VpOSFnDNvh/jzgKyxBY2uvSs7pOW7O2ZfRGfoHCQHN
WW65S59f+IFxdTv5irEA/wZJOv7wNNEyWXqqsGzvUj93LeaxMygyN3n47K3pmZ86
Dbo9oReM5CSzUPgOzWAe2RnA3H27kncZC6Q7yk0/FW83xK6frbw+JRs9Ww0Umm4m
owIS8S4lTkDRmHsu8dKbQYgkSmchwn0lF+pbQnsDlbG8YpWWxLB/eDGtGWtCRGP0
k+kpRT1peXpYZNcLv7ieYi3ciB6BxIN3NuH4UVZQXumgV7ncWF1y17xOhVaQFTTQ
w/0UjyJDpzTNqoTtefAajH5QRVLsjJ7KnzY8YHlasxUHibC/G110rwt1LbAT/SMM
XjAV9yovwGd/s4II41fMdqJV4HNwcNnhH8oEuAAo3FXrFx/tukSVq6BFonjmKc7V
VSk7PTt+DAIDyvbUhMcc6cYy23ZkB9kcG/44tfM2jyZYsAxqHqU=
=i7nW
-----END PGP SIGNATURE-----

--3ayikdluu3d7sqex--

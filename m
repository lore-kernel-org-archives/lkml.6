Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeDLO4n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:56:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57125 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbeDLO4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:56:42 -0400
Date: Thu, 12 Apr 2018 16:56:28 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/5] net: stmmac: dwmac-sun8i: Allow getting syscon
 regmap from device
Message-ID: <20180412145628.iaaeue2imiijwx5d@flea>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rlwjjthzx46dcgln"
Content-Disposition: inline
In-Reply-To: <20180411141641.14675-4-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rlwjjthzx46dcgln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 10:16:39PM +0800, Icenowy Zheng wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> On the Allwinner R40 SoC, the "GMAC clock" register is in the CCU
> address space; on the A64 SoC this register is in the SRAM controller
> address space, and with a different offset.
>=20
> To access the register from another device and hide the internal
> difference between the device, let it register a regmap named
> "emac-clock". We can then get the device from the phandle, and
> retrieve the regmap with dev_get_regmap(); in this situation the
> regmap_field will be set up to access the only register in the regmap.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> [Icenowy: change to use regmaps with single register, change commit
>  message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 48 +++++++++++++++++=
+++++-
>  1 file changed, 46 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 1037f6c78bca..b61210c0d415 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -85,6 +85,13 @@ const struct reg_field old_syscon_reg_field =3D {
>  	.msb =3D 31,
>  };
> =20
> +/* Specially exported regmap which contains only EMAC register */
> +const struct reg_field single_reg_field =3D {
> +	.reg =3D 0,
> +	.lsb =3D 0,
> +	.msb =3D 31,
> +};
> +

I'm not sure this would be wise. If we ever need some other register
exported through the regmap, will have to change all the calling sites
everywhere in the kernel, which will be a pain and will break
bisectability.

Chen-Yu's (or was it yours?) initial solution with a custom writeable
hook only allowing a single register seemed like a better one.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--rlwjjthzx46dcgln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrPc5sACgkQ0rTAlCFN
r3Sfbg//cOLG/DT3g2+ze/UD63phm0FdBQpF9binOv9/geLQNTBfvMHYuxnrDv2p
j1o3+rssM01VnQmA3D3xPfT+Q53j23l78X4E+5EZF2ow1nLrJ2Yw/VbnLquKclLn
waQySC66t5eYqvgowgzfLJ0KOmv6W31olmMHimRu0axD55zbfL+6t33DVM4SBE8L
U2aRL6NX3QF4K0bk+0fN8bWaeNbCtc0wlMh1gxqzDBxQO0XO4aTFkLdbQojwU9Xn
NFAncEZYdUBjUVPtny+QTBp2NaGGEtKsysIItownueB8O8RvVnn0pCKsTToKgQZx
7zUy6QjP7yl5B1fSyGclDOi1O6+dUF3F/YgMhZNhhjpkRu3DcuHhy+3nDu/4ZH6l
D1qi0Hnlc/asYl3rwyOwc1LYAzz5SVdLdjzJNaJeCxZrS7yTPsBUO82K9wy1+S0M
/CeGQIAn9xHkgIilZLtzAexQGlSlo5n52OKK5xgeocoJd60GzGuJFLLSXYFX4y2G
C9cI7C9Gbmh0bWPBbVHUJbRp26udKiBtpyvhCHE5Eo+C0y0BqFGtwyncmyglhwEv
insJihyCqPF88XluhLUMdm8SEHLqpqhHsiDBcpPEItwCsGLu8mUF7whqecyfGESb
FxcO4qaPpVLG165EDC0aZLgz/CBCa7cD0qIXWLXvpQfn5lwQGzk=
=XQMc
-----END PGP SIGNATURE-----

--rlwjjthzx46dcgln--

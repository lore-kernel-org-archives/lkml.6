Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDYVPb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbeDYVP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:15:29 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF9E21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sre@kernel.org
Date: Wed, 25 Apr 2018 23:15:23 +0200
From: Sebastian Reichel <sre@kernel.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: Add support for BQ27426
Message-ID: <20180425211523.4lyca24whor4txjg@earth.universe>
References: <20180421231249.9517-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="55uyg4qhihze6uzj"
Content-Disposition: inline
In-Reply-To: <20180421231249.9517-1-afd@ti.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55uyg4qhihze6uzj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Apr 21, 2018 at 06:12:49PM -0500, Andrew F. Davis wrote:
> This device is software similar to the BQ27426 except it has
> different data memory offsets. Add support here.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---

Thanks, queued.

-- Sebastian

>  .../devicetree/bindings/power/supply/bq27xxx.txt         | 1 +
>  drivers/power/supply/bq27xxx_battery.c                   | 9 +++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c               | 2 ++
>  include/linux/power/bq27xxx_battery.h                    | 3 ++-
>  4 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b=
/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> index 615c1cb6889f..37994fdb18ca 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> @@ -25,6 +25,7 @@ Required properties:
>   * "ti,bq27545" - BQ27545
>   * "ti,bq27421" - BQ27421
>   * "ti,bq27425" - BQ27425
> + * "ti,bq27426" - BQ27426
>   * "ti,bq27441" - BQ27441
>   * "ti,bq27621" - BQ27621
>  - reg: integer, I2C address of the fuel gauge.
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 7ce60519b1bc..d44ed8e17c47 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -432,6 +432,7 @@ static u8
>  		BQ27XXX_DM_REG_ROWS,
>  	};
>  #define bq27425_regs bq27421_regs
> +#define bq27426_regs bq27421_regs
>  #define bq27441_regs bq27421_regs
>  #define bq27621_regs bq27421_regs
> =20
> @@ -664,6 +665,7 @@ static enum power_supply_property bq27421_props[] =3D=
 {
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
>  #define bq27425_props bq27421_props
> +#define bq27426_props bq27421_props
>  #define bq27441_props bq27421_props
>  #define bq27621_props bq27421_props
> =20
> @@ -734,6 +736,12 @@ static struct bq27xxx_dm_reg bq27425_dm_regs[] =3D {
>  	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 18, 2, 2800,  3700 },
>  };
> =20
> +static struct bq27xxx_dm_reg bq27426_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82,  6, 2,    0,  8000 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82,  8, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 10, 2, 2500,  3700 },
> +};
> +
>  #if 0 /* not yet tested */
>  #define bq27441_dm_regs bq27421_dm_regs
>  #else
> @@ -795,6 +803,7 @@ static struct {
>  	[BQ27545]   =3D BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
>  	[BQ27421]   =3D BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27425]   =3D BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP),
> +	[BQ27426]   =3D BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27441]   =3D BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27621]   =3D BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  };
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index 6b25e5f2337e..40069128ad44 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -249,6 +249,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_tabl=
e[] =3D {
>  	{ "bq27545", BQ27545 },
>  	{ "bq27421", BQ27421 },
>  	{ "bq27425", BQ27425 },
> +	{ "bq27426", BQ27426 },
>  	{ "bq27441", BQ27441 },
>  	{ "bq27621", BQ27621 },
>  	{},
> @@ -280,6 +281,7 @@ static const struct of_device_id bq27xxx_battery_i2c_=
of_match_table[] =3D {
>  	{ .compatible =3D "ti,bq27545" },
>  	{ .compatible =3D "ti,bq27421" },
>  	{ .compatible =3D "ti,bq27425" },
> +	{ .compatible =3D "ti,bq27426" },
>  	{ .compatible =3D "ti,bq27441" },
>  	{ .compatible =3D "ti,bq27621" },
>  	{},
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index 01fbf1b16258..d6355f49fbae 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -24,8 +24,9 @@ enum bq27xxx_chip {
>  	BQ27546,
>  	BQ27742,
>  	BQ27545, /* bq27545 */
> -	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +	BQ27421, /* bq27421, bq27441, bq27621 */
>  	BQ27425,
> +	BQ27426,
>  	BQ27441,
>  	BQ27621,
>  };
> --=20
> 2.17.0
>=20

--55uyg4qhihze6uzj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrg7+sACgkQ2O7X88g7
+poHuw/+NrMhPDwydsYAuoWk035kaSweGuPQUzHQq8a0ihAnh6W5OaS5UTwPuDfz
60leErza4s/RSpXf6NzcSCvtKMrArFt3IvR5Swpp+n0eyH5l2u2x8tBGTApsd8BQ
K0D+YzD+DPOiLQTAp+COZgFzO88wMdqelzue6GkbGTi1b10PHH1uhsTDryEYmepj
pIZCEe5kqf29sMl3nAVGg59S023UZ5qDIlJWnTDLm8Y3FzqndDSdPb2ZAa6a46WR
LrXJronoQOElFfg3oLNFrlGoABvtGPCBR8KnhOzvfMsay/JfaLcyWqMVrKt7IiUf
amnD+OiKTl2hpRtCSX5AQa1gI3i0kRERfPnU7x05GmSPNphKfAJwIa4SBx3Hi2yi
nQsiLu+PZhj+DSUr0dgbPU6r/GpNQUG5ptpIcGFbo033K2Ef3ARZFBFmhhXJPosO
wKJhJbqvGTM3zAZ/w2tT4K4q8Mpr/0FnT5xKhmWuz0QStpk6e/ZJDjaOnN/02AAU
GF195Rh2/Jp14zSZqEb96u4Aw1QOORHRDRqGVnQXsIGVIednL6zCgDLWK0GZ10Av
bomsT2ndkvHmU2yc2cow2L2SyTd550WKjXVG1jm1qIZukKMH0MwX33lzWC+xVQ8+
RgtqlgvCw+8qzOr5AaLvp6NKIVL/xVphtCh3DYDizOCh4O8GGSk=
=Ziyi
-----END PGP SIGNATURE-----

--55uyg4qhihze6uzj--

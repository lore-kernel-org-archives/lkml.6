Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbeDVIHp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 04:07:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42999 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeDVIHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 04:07:43 -0400
X-Google-Smtp-Source: AIpwx4+YpFUb5LMC2mklSgfJiki4JvDXcSUnxuPTpcFPOwWHhEEhxJJuOCNRVCPL4IHNthCFXicSew==
Date: Sun, 22 Apr 2018 10:07:40 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: Add support for BQ27426
Message-ID: <20180422080740.uwd5tock6ztsaa6l@pali>
References: <20180421231249.9517-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z2y5zluhf67einid"
Content-Disposition: inline
In-Reply-To: <20180421231249.9517-1-afd@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z2y5zluhf67einid
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 21 April 2018 18:12:49 Andrew F. Davis wrote:
> This device is software similar to the BQ27426 except it has
> different data memory offsets. Add support here.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> ---
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

In future I would propose to put such changes into separate patches...
as it is not relevant for BQ27426.

>  	BQ27425,
> +	BQ27426,
>  	BQ27441,
>  	BQ27621,
>  };

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--z2y5zluhf67einid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWtxCygAKCRCL8Mk9A+RD
UrflAJ96PudqYDYIHifCFw337UsxglLhtQCeIghbagsTv3BMj8vJ6iKUN1d93ks=
=ia2Q
-----END PGP SIGNATURE-----

--z2y5zluhf67einid--

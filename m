Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeA3Swm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:52:42 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44158 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeA3Swk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:52:40 -0500
X-Google-Smtp-Source: AH8x227BICEJHEcsWAlil4mbrYr56mAmz5dPcnw0y2fYgoLtNC2L/uKLZMXNRJEVCje3RyOgcNjv4g==
Date: Tue, 30 Jan 2018 19:52:37 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Liu Xiang <liu.xiang6@zte.com.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org,
        afd@ti.com
Subject: Re: [PATCH] power: supply: bq27xxx: Add bq27411 support
Message-ID: <20180130185237.mguuclb4t5th7fcq@pali>
References: <1517063136-23210-1-git-send-email-liu.xiang6@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3lqdsanpnwr5q5ef"
Content-Disposition: inline
In-Reply-To: <1517063136-23210-1-git-send-email-liu.xiang6@zte.com.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lqdsanpnwr5q5ef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Saturday 27 January 2018 22:25:36 Liu Xiang wrote:
> According to the datasheet, bq27411 is similar to bq27421.
>=20
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 14 ++++++++++++++
>  include/linux/power/bq27xxx_battery.h  |  3 ++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 51f0961..2de378a 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -410,6 +410,7 @@ enum bq27xxx_reg_index {
>  #define bq27425_regs bq27421_regs
>  #define bq27441_regs bq27421_regs
>  #define bq27621_regs bq27421_regs
> +#define bq27411_regs bq27421_regs
> =20
>  static enum power_supply_property bq27000_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
> @@ -633,6 +634,7 @@ enum bq27xxx_reg_index {
>  #define bq27425_props bq27421_props
>  #define bq27441_props bq27421_props
>  #define bq27621_props bq27421_props
> +#define bq27411_props bq27421_props
> =20
>  struct bq27xxx_dm_reg {
>  	u8 subclass_id;
> @@ -716,6 +718,17 @@ enum bq27xxx_dm_reg_id {
>  #define bq27621_dm_regs 0
>  #endif
> =20
> +#if 0 /* not yet tested */
> +static struct bq27xxx_dm_reg bq27411_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 10, 2,    0, 32767 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 12, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 16, 2, 2800,  3700 },
> +};
> +#else
> +#define bq27411_dm_regs 0
> +#endif

Can you test it?

I do not think it is a good idea to add dead code into mainline kernel.

> +
> +
>  #define BQ27XXX_O_ZERO	0x00000001
>  #define BQ27XXX_O_OTDC	0x00000002
>  #define BQ27XXX_O_UTOT  0x00000004
> @@ -762,6 +775,7 @@ enum bq27xxx_dm_reg_id {
>  	[BQ27425]   =3D BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP),
>  	[BQ27441]   =3D BQ27XXX_DATA(bq27441,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27621]   =3D BQ27XXX_DATA(bq27621,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
> +	[BQ27411]   =3D BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  };
> =20
>  static DEFINE_MUTEX(bq27xxx_list_lock);
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index e6187f5..5f48eb0 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -23,10 +23,11 @@ enum bq27xxx_chip {
>  	BQ27546,
>  	BQ27742,
>  	BQ27545, /* bq27545 */
> -	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
> +	BQ27421, /* bq27421, bq27425, bq27441, bq27621, bq27411 */
>  	BQ27425,
>  	BQ27441,
>  	BQ27621,
> +	BQ27411,
>  };
> =20
>  struct bq27xxx_device_info;

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--3lqdsanpnwr5q5ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnC+8QAKCRCL8Mk9A+RD
UqaOAJ9oliRhLbx12jInQv7sm2zJVyE1CACfUr4jFo6fCEmfy5G7yNLXtU8Oafs=
=VsNL
-----END PGP SIGNATURE-----

--3lqdsanpnwr5q5ef--

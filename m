Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40060ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73C42087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 20:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E73C42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbeIQB1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 21:27:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47066 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbeIQB0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 21:26:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 863F527DAE8
Received: by earth.universe (Postfix, from userid 1000)
        id 5B58B3C0C4A; Sun, 16 Sep 2018 13:35:23 +0200 (CEST)
Date:   Sun, 16 Sep 2018 13:35:23 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Liu Xiang <liu.xiang6@zte.com.cn>, afd@ti.com
Cc:     pali.rohar@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com
Subject: Re: [PATCH] power: supply: bq27xxx: Add support for BQ27411
Message-ID: <20180916113523.fq4n7nsasigy3wyg@earth.universe>
References: <1532266436-20182-1-git-send-email-liu.xiang6@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yik6uv2as35w4qcj"
Content-Disposition: inline
In-Reply-To: <1532266436-20182-1-git-send-email-liu.xiang6@zte.com.cn>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yik6uv2as35w4qcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 22, 2018 at 09:33:56PM +0800, Liu Xiang wrote:
> According to the datasheet, bq27411 is similar to bq27421.
>=20
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---

Looks good to me. Do you plan to test/review this Andrew, or
should I proceed with merging this patch?

-- Sebastian

>  Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 1 +
>  drivers/power/supply/bq27xxx_battery.c                     | 9 +++++++++
>  drivers/power/supply/bq27xxx_battery_i2c.c                 | 2 ++
>  include/linux/power/bq27xxx_battery.h                      | 1 +
>  4 files changed, 13 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b=
/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> index 37994fd..4fa8e08 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
> @@ -23,6 +23,7 @@ Required properties:
>   * "ti,bq27546" - BQ27546
>   * "ti,bq27742" - BQ27742
>   * "ti,bq27545" - BQ27545
> + * "ti,bq27411" - BQ27411
>   * "ti,bq27421" - BQ27421
>   * "ti,bq27425" - BQ27425
>   * "ti,bq27426" - BQ27426
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index f022e1b..6dbbe95 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -432,6 +432,7 @@ enum bq27xxx_reg_index {
>  		[BQ27XXX_REG_AP] =3D 0x18,
>  		BQ27XXX_DM_REG_ROWS,
>  	};
> +#define bq27411_regs bq27421_regs
>  #define bq27425_regs bq27421_regs
>  #define bq27426_regs bq27421_regs
>  #define bq27441_regs bq27421_regs
> @@ -665,6 +666,7 @@ enum bq27xxx_reg_index {
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_MANUFACTURER,
>  };
> +#define bq27411_props bq27421_props
>  #define bq27425_props bq27421_props
>  #define bq27426_props bq27421_props
>  #define bq27441_props bq27421_props
> @@ -725,6 +727,12 @@ enum bq27xxx_dm_reg_id {
>  #define bq27545_dm_regs 0
>  #endif
> =20
> +static struct bq27xxx_dm_reg bq27411_dm_regs[] =3D {
> +	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 10, 2,    0, 32767 },
> +	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 12, 2,    0, 32767 },
> +	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 16, 2, 2800,  3700 },
> +};
> +
>  static struct bq27xxx_dm_reg bq27421_dm_regs[] =3D {
>  	[BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 82, 10, 2,    0,  8000 },
>  	[BQ27XXX_DM_DESIGN_ENERGY]     =3D { 82, 12, 2,    0, 32767 },
> @@ -802,6 +810,7 @@ enum bq27xxx_dm_reg_id {
>  	[BQ27546]   =3D BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
>  	[BQ27742]   =3D BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
>  	[BQ27545]   =3D BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
> +	[BQ27411]   =3D BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27421]   =3D BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
>  	[BQ27425]   =3D BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP),
>  	[BQ27426]   =3D BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ=
27XXX_O_CFGUP | BQ27XXX_O_RAM),
> diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/s=
upply/bq27xxx_battery_i2c.c
> index 4006912..2677c38 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -247,6 +247,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_clie=
nt *client)
>  	{ "bq27546", BQ27546 },
>  	{ "bq27742", BQ27742 },
>  	{ "bq27545", BQ27545 },
> +	{ "bq27411", BQ27411 },
>  	{ "bq27421", BQ27421 },
>  	{ "bq27425", BQ27425 },
>  	{ "bq27426", BQ27426 },
> @@ -279,6 +280,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_clie=
nt *client)
>  	{ .compatible =3D "ti,bq27546" },
>  	{ .compatible =3D "ti,bq27742" },
>  	{ .compatible =3D "ti,bq27545" },
> +	{ .compatible =3D "ti,bq27411" },
>  	{ .compatible =3D "ti,bq27421" },
>  	{ .compatible =3D "ti,bq27425" },
>  	{ .compatible =3D "ti,bq27426" },
> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/=
bq27xxx_battery.h
> index d6355f4..507c5e2 100644
> --- a/include/linux/power/bq27xxx_battery.h
> +++ b/include/linux/power/bq27xxx_battery.h
> @@ -24,6 +24,7 @@ enum bq27xxx_chip {
>  	BQ27546,
>  	BQ27742,
>  	BQ27545, /* bq27545 */
> +	BQ27411,
>  	BQ27421, /* bq27421, bq27441, bq27621 */
>  	BQ27425,
>  	BQ27426,
> --=20
> 1.9.1
>=20

--yik6uv2as35w4qcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlueP/sACgkQ2O7X88g7
+poJPRAAm5T5jutsFWPF4ILbtnWmPX0hQxKaqZUuBn+0ig2UoeFa1OmP7y4bkKQm
I0fQnVNw5LC/WGqC/gtH3p93sNbnHUSY5zELMKs+W0jfIsx4AIhkB4T3vtBG3+77
p6VDUozo9LeYCIQiiLaYeYRaFHlbfeev1K/gCuPw9/LsBVA1QdHU+yX5azTKcnac
rnMmqC1AkU3w9LSmnWiMFtfbXSw+/1/uNZSjeFTuYLq/G4nZPMHkq1DwvQQnbiVx
1qjChgGdUEPF5ak1VxcgVEXMvd2g/Z6QKOU2GrbteIq1TQCx4pVr0ACPfPHRVVjp
ju12cnkbNkjq7dPU36rTctcPf5g6NuyPAWRrM49To0YjXCw5xvzW4ydrzbMMC+jC
YYEYzXdkNLdm/sk/hG6IoJp/rwjYhg3OISCdznd0hbNRgZs2DKcvJqdSRtuoNhbj
sfN7RzGV3AH+G6S+Usb0ZuvZ10+u8YdQQgcCHapqSrEcp60ExWqkdYtg1rAScOaB
tC31qLNX39+Ux7W/NFtoP5WioDQD8TDUNQwlOgttVEn6lR/FBOETQdSUvimfPJMm
9LIeaRhErUSzIJfVUAxTdLaAsyDuFRW0HF45XG+E9Wy2efdW32JADTMYkIM1XXW8
E3Z2XxoH5FWFzsB8PE7Y2beFTr4jK6E+mmHODFuxDieo5xAIaHE=
=RyYx
-----END PGP SIGNATURE-----

--yik6uv2as35w4qcj--

Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B44C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240932184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323919;
	bh=EHHU92lvcyF3zRY2GTvHxpwgqXZyeDlMIx2iSpj7nds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kpUwqvf6iEB6TGvplqbSdw9jxondZDZPI3ZtgG748Qu+eDY77qHM1j1O0UVAxDJD0
	 0z064UBxfuO9GxXXlPx75l/L2xjrecboshpd0b86Kj8of6Vp7HsmqxDzkH4EoJFdlL
	 3nMYO+k5/cKURsQtgEomdU0ddzAYTnt7yBzHLMsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfAXJ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfAXJ6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:11 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 072292184C;
        Thu, 24 Jan 2019 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323890;
        bh=EHHU92lvcyF3zRY2GTvHxpwgqXZyeDlMIx2iSpj7nds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJoyhioxUinZTxnEJByszoAml57C1aAaegUZzPa9b+veO2lIoTnnDEgYMSG9cIB0g
         IgmXXL7JzGiB1qokCSxgdR52z5mCRoTsevkt8FeKng/GUYgzrabn1sAZdr2pE5xDPx
         uEKC5Zvhg4usodOWiHlHMkh29dKsr5uvUn96ry60=
Received: by earth.universe (Postfix, from userid 1000)
        id C8B193C08E9; Wed, 23 Jan 2019 21:49:11 +0100 (CET)
Date:   Wed, 23 Jan 2019 21:49:11 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 7/7] power: supply: olpc_battery: Add OLPC XO 1.75
 support
Message-ID: <20190123204911.wqoigxoti7synf3m@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-8-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fa72vh7u3yatc4vm"
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-8-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fa72vh7u3yatc4vm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:05PM +0100, Lubomir Rintel wrote:
> The battery and the protocol are essentially the same as OLPC XO 1.5,
> but the responses from the EC are LSB first.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---
> Changes since v2:
> - Fix the version conditional
>=20
> Changes since v1:
> - s/s16 ecword_to_cpu/u16 ecword_to_cpu/
> - s/u16 ec_byte/u16 ec_word/
>=20
>  drivers/power/supply/olpc_battery.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index a6c89d002d5d..52de90049980 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -57,6 +57,7 @@ struct olpc_battery_data {
>  	struct power_supply *olpc_bat;
>  	char bat_serial[17];
>  	int new_proto;
> +	int little_endian;

bool?

Looks good otherwise.

-- Sebastian

>  };
> =20
>  /*********************************************************************
> @@ -322,6 +323,14 @@ static int olpc_bat_get_voltage_max_design(union pow=
er_supply_propval *val)
>  	return ret;
>  }
> =20
> +static u16 ecword_to_cpu(struct olpc_battery_data *data, u16 ec_word)
> +{
> +	if (data->little_endian)
> +		return le16_to_cpu(ec_word);
> +	else
> +		return be16_to_cpu(ec_word);
> +}
> +
>  /*********************************************************************
>   *		Battery properties
>   *********************************************************************/
> @@ -394,7 +403,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 9760L / 32;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 9760L / 32;
>  		break;
>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
> @@ -402,7 +411,7 @@ static int olpc_bat_get_property(struct power_supply =
*psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 15625L / 120;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 15625L / 120;
>  		break;
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		ret =3D olpc_ec_cmd(EC_BAT_SOC, NULL, 0, &ec_byte, 1);
> @@ -433,21 +442,21 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>  		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
> +		val->intval =3D (int)ecword_to_cpu(data, ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 6250 / 15;
> +		val->intval =3D ecword_to_cpu(data, ec_word) * 6250 / 15;
>  		break;
>  	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
>  		ret =3D olpc_ec_cmd(EC_BAT_SERIAL, NULL, 0, (void *)&ser_buf, 8);
> @@ -621,7 +630,11 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	if (ecver > 0x44) {
> +	if (of_find_compatible_node(NULL, NULL, "olpc,xo1.75-ec")) {
> +		/* XO 1.75 */
> +		data->new_proto =3D 1;
> +		data->little_endian =3D 1;
> +	} else if (ecver > 0x44) {
>  		/* XO 1 or 1.5 with a new EC firmware. */
>  		data->new_proto =3D 1;
>  	} else if (ecver < 0x44) {
> --=20
> 2.20.1
>=20

--fa72vh7u3yatc4vm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI00cACgkQ2O7X88g7
+ppP9g//dV51nPbcmlaI/769itgOMkyh3CJcYjPe/Dw5ts5N1KxD2EHHDQ67smjo
xdreqRx+nJ7iq5/KJA+9ofad6j7ip95x2UKziqBCgdFfqPgzHH43P3x+GZaUvv/m
q7NpXe+X2gBW8GQpJsONyITTaM2pxvgu/GMJAx/skIMvgfcMI945ho12DKwvu5+K
NeufeePC05wem+iwNZOpttYO8aVCuuMeh/bYShzDxhVdGZk0cMVvvQqN+95SDme0
AKZ5cKmFxVjqz9NVEc7hUzLjeljFd3TeblQog1xoaDIe2f+QEKNDg4gGBMD6peIx
2FzrlHUX1KxRlc05QJ/aMXvqXQoFjq8Qt25p7Q54Qb7Eo5hGsh4JTOwgtVyA0aaI
d6kJN8TPcH4axznG2IwHvgS/cEPJ98Q5OPHzW2EWmYKMQgeKJ+PHoOVWaB3zGGlq
jRWCKf5Aaf4MmXmKvPTUGaiz87S8G8UbLRqwQuLEMcKok3zovO0iw5mhrXUqVvBs
UOVsLqcqeCKCPaJ6b4TXKZ0NLZrNOANoWMGSNkjAWUCO20KAqWLTMJOkSXS1hztI
yFrKISQ9X5u0ksuuNXRyycXZic2L3T608mjs3hnC+kBr3nRGwuvWejZSBtWzebmG
FMGAlhJiFdGbOTwkCPnSB+nLn5H7Gm9blrUAf80oHayWyTq3Yvc=
=cyBc
-----END PGP SIGNATURE-----

--fa72vh7u3yatc4vm--

Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E777FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56CE20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56CE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeLEVFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:05:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLEVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:05:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E15C8263BF7
Received: by earth.universe (Postfix, from userid 1000)
        id B103C3C08D6; Wed,  5 Dec 2018 22:05:19 +0100 (CET)
Date:   Wed, 5 Dec 2018 22:05:19 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Cameron <quozl@laptop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/17] power: supply: olpc_battery: correct the
 temperature units
Message-ID: <20181205210519.gqxbr4c26p3v5i6l@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f765d3e3bg5xlwkb"
Content-Disposition: inline
In-Reply-To: <20181116162403.49854-2-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f765d3e3bg5xlwkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:23:47PM +0100, Lubomir Rintel wrote:
> According to [1] and [2], the temperature values are in tenths of degree
> Celsius. Exposing the Celsius value makes the battery appear on fire:
>=20
>   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
>   ...
>       temperature:         236.9 degrees C
>=20
> Tested on OLPC XO-1 and OLPC XO-1.75 laptops.
>=20
> [1] include/linux/power_supply.h
> [2] Documentation/power/power_supply_class.txt
>=20
> Fixes: fb972873a767 ("[BATTERY] One Laptop Per Child power/battery driver=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

This is queued to next.

-- Sebastian

> Changes since v1:
> - Add Fixes tag and an Ack
>=20
>  drivers/power/supply/olpc_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 6da79ae14860..5a97e42a3547 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>  		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (int)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
> --=20
> 2.19.1
>=20

--f765d3e3bg5xlwkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIPY8ACgkQ2O7X88g7
+pokYg/+KNB9FZdw0Zt4viGGjHf6+serXADkjfh1W6AW1trDUe7OysxSIOrPxLmo
TNUyyqfXBjrymOAJfqP1fZ7Uo9UEcxK7max53lxZk0sA8p1SxSEfuN6tCEGkBZeJ
5E4/JvT+MO7/o5oboJMa6j16JGOSXXmLRHXbUxkU9bG1CLd5ZN7EkZvYzIuq5hY1
uL9ze2rjM8nKf8UCsFci89Ny4+Lar66SAnDKIWpur6a035vm43u7rj+zVTGlCBGe
tsKXFEiMyCF03okVpWbNpKcJUHSS4yZhITAw/NJ822QrLTYPJzjC01P2gYqtTKb9
9K46AxAawNxT4WSovv0KmVYCslyHmbyLN1S65lJRHOdD53746XL5NHQ90PMnM2YK
hv7SYZV/OezWVob5YpO0VS8czxVsVIZCp7INIcwjgmCwKa0p3OZoh9IkugHR2US2
SEFVlQDJedAChP4Cxw26aV7XhKwdrGI7QHk/67iANTLzVkBdJnsBI9VklwWDZrol
/du9th3tBSpM5fjOZGj7i2RDKF7aGlg+kAe371rWyZqgXk3Hawax8VWkCkpNafjI
KrZHc5Trop22eYlM8cGBdOXCYj4ES8AwoTmMOLHsbTNFwqUq27HIk/LY1BDCe5UT
yLElmtirf7AAyF1leHRlVXwF5ZHUDtAg+t9YsHwGaeXXARc+56Y=
=f8nw
-----END PGP SIGNATURE-----

--f765d3e3bg5xlwkb--

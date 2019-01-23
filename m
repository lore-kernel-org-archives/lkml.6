Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D93BC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074212184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323897;
	bh=7vJhNOo9WeoNi5SvZ9WE8EQrmWCSIPJ7mQtL79ati9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ostVIdFy5zRv4WiPKFcnMv7w7l8Jw5PfvGpMDBDqheKKTRbEXUf/up38eQ/mxltox
	 LCdUjCLJmVUJNjFudeuiRHZqVp5Z3azkZ7XvKrUb0H5ir5nHcmJsL1EIAHGPNC88kG
	 4gLqTEkxdg1X7kD5oovL/y3dCqXqHkPJ2qiW3AgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfAXJ6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:58:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfAXJ6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:58:11 -0500
Received: from earth.universe (dyndsl-037-138-185-084.ewe-ip-backbone.de [37.138.185.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09AC1218AE;
        Thu, 24 Jan 2019 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323890;
        bh=7vJhNOo9WeoNi5SvZ9WE8EQrmWCSIPJ7mQtL79ati9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bdh12aqIw4N84mHDVhnkgQcrTzmhD3wpIvcKgnM4b8x7HZt/M1Y33gmjzAk3vNDXK
         hELlSr7Dpo8qAw7cGQ0HqqHHobxAi5QHWyW7JlzVgkhugtkyYnrCGytcvHnx/fWVjF
         2hLAdjLZy3gcHIiZckJn4loEqpFHYEnLzTXvQU/k=
Received: by earth.universe (Postfix, from userid 1000)
        id 38DA93C08E5; Wed, 23 Jan 2019 21:38:05 +0100 (CET)
Date:   Wed, 23 Jan 2019 21:38:05 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 3/7] power: supply: olpc_battery: Use DT to get
 battery version
Message-ID: <20190123203805.qhmilqqozkgrchoy@earth.universe>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6h6uhi6mqvm2kbpb"
Content-Disposition: inline
In-Reply-To: <20190110174005.1202564-4-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6h6uhi6mqvm2kbpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 06:40:01PM +0100, Lubomir Rintel wrote:
> Avoid using the x86 OLPC platform specific call to get the board
> version. That wouldn't work on FDT-based ARM MMP2 platform.
>=20
> Add the XO 1.5 compatible string too. This is actually not completely
> necessary as the battery nodes on XO 1.5 claim to be compatible with
> "olpc,xo1-battery", but there are, in fact, differencies.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> ---
> Changes since v2:
> - Clarify the XO 1 compatibility in the commit message.
>=20
> Changes since v1:
> - Sort the new include a bit higher
>=20
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 5a97e42a3547..5323987d9284 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/jiffies.h>
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>  	if (IS_ERR(olpc_ac))
>  		return PTR_ERR(olpc_ac);
> -
> -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> +					"olpc,xo1.5-battery") >=3D 0) {

of_device_is_compatible(...)

-- Sebastian

> +		/* XO-1.5 */
>  		olpc_bat_desc.properties =3D olpc_xo15_bat_props;
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo15_bat_props);
> -	} else { /* XO-1 */
> +	} else {
> +		/* XO-1 */
>  		olpc_bat_desc.properties =3D olpc_xo1_bat_props;
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
> =20
>  static const struct of_device_id olpc_battery_ids[] =3D {
>  	{ .compatible =3D "olpc,xo1-battery" },
> +	{ .compatible =3D "olpc,xo1.5-battery" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> --=20
> 2.20.1
>=20

--6h6uhi6mqvm2kbpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlxI0KoACgkQ2O7X88g7
+pqb9g//Sl82KeYO3saUbSr7qshHZkKLWKj+rS928qqwf3eBjclKlSPzV1gHHJAD
P5Y3IOSNKyMT5do0rSeDJYF82z9cOQbJnC3IGz6tHC8Lak6aC1eEVBBAPRf098e3
ihrzgbF9OLINhCh5I8J1Zz7DaEv9bZpbxEWKnAO8zJaI37UhhYKA/LVoMIM9/3pT
3+06zdmL5GdrOvC2xak45En0Lst+pmUpn2OtXoakzZ4SgMMvDInj0PIlg078pURp
tjQhSlMZLFns7Wvf1AJxzTCtSNVp3Mz1wDa38u1smn0dB4EyFwC5ccv2FaiE7yp1
iuTM2G1x7pTBzdjBqr7SY6qhfBji9Pr2lvrLywdVdTHc5krGSqIAiMxF18iIIzT+
z9lqm5i6sNenGdOjDoS1ho1j7ttYKnyxaTVgCO+zLajaPjwOTzO+bPcEtwIKeooZ
sdpa86bf9dfitMHafwpE0JdN0OOx6WiQx4N2YYUIPt4sxQcICWQmjkm6SqyfmM9h
Xaht1qnBX6nYaDheRrsnKQeKsUu6K1lV0xCHDhJlxRaC9SwhtVfovawsZhJB0LE0
mPVzPOaNQcU7gGAQIPwZ3quA4oNbWaobnm2K5wByIfZu54I+nXbxDqoucvdI8wmm
LpWQW73C7pB5b7/wrjW+kD2qUpIsLjZOG108LEegWcZT3pFx3kE=
=vWen
-----END PGP SIGNATURE-----

--6h6uhi6mqvm2kbpb--

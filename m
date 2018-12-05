Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCA5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF35520879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF35520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeLEV4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:56:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:56:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id EBD5026A028
Received: by earth.universe (Postfix, from userid 1000)
        id 620EB3C08D6; Wed,  5 Dec 2018 22:56:04 +0100 (CET)
Date:   Wed, 5 Dec 2018 22:56:04 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org, jonathan@marek.ca
Subject: Re: [PATCH v2 2/7] power: supply: bq24190_charger: add support for
 bq24192 variant
Message-ID: <20181205215604.pkb37fubehwznmvs@earth.universe>
References: <20181101001149.13453-1-masneyb@onstation.org>
 <20181101001149.13453-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qot673k4pt267uj6"
Content-Disposition: inline
In-Reply-To: <20181101001149.13453-3-masneyb@onstation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qot673k4pt267uj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 31, 2018 at 08:11:44PM -0400, Brian Masney wrote:
> From: Jonathan Marek <jonathan@marek.ca>
>=20
> This patch adds support for the bq24192 variant to bq24190_charger.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> [masneyb@onstation.org: Changed if statement to a switch based on
> feedback from Sebastian Reichel.]
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index b58df04d03b3..44d3aff32885 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1637,8 +1637,12 @@ static int bq24190_hw_init(struct bq24190_dev_info=
 *bdi)
>  	if (ret < 0)
>  		return ret;
> =20
> -	if (v !=3D BQ24190_REG_VPRS_PN_24190 &&
> -	    v !=3D BQ24190_REG_VPRS_PN_24192I) {
> +	switch (v) {
> +	case BQ24190_REG_VPRS_PN_24190:
> +	case BQ24190_REG_VPRS_PN_24192:
> +	case BQ24190_REG_VPRS_PN_24192I:
> +		break;
> +	default:
>  		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
>  		return -ENODEV;
>  	}
> @@ -1931,6 +1935,7 @@ static const struct dev_pm_ops bq24190_pm_ops =3D {
> =20
>  static const struct i2c_device_id bq24190_i2c_ids[] =3D {
>  	{ "bq24190" },
> +	{ "bq24192" },
>  	{ "bq24192i" },
>  	{ },
>  };
> @@ -1939,6 +1944,7 @@ MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
>  #ifdef CONFIG_OF
>  static const struct of_device_id bq24190_of_match[] =3D {
>  	{ .compatible =3D "ti,bq24190", },
> +	{ .compatible =3D "ti,bq24192", },
>  	{ .compatible =3D "ti,bq24192i", },
>  	{ },
>  };
> --=20
> 2.17.2
>=20

--qot673k4pt267uj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwISXQACgkQ2O7X88g7
+prFcxAAn4qPU8EfG9TgIMOtko/7wWFoZFkZ738KpnNBRuwzDvZ8XA9GN1NZIKwM
lhHggQHAh+pdu5QpR/D6+o+xYpIKMRN8dEzN5ZGd7+7L0raKSeQm46Z+llMGg4ik
EHbVURcNY4rh6uAW76nklQcnSlnc+2JyRZd9JGqE9wT2UzhoLtvLpsq+mEdz+WeX
lCrfP5BpOMWFkYsm1gENWUMoZ5QAOqi2o6Os8zSo/dH9Ycv8jNaC6M1w1R8T7qfi
YEhMiEGzjuTNelGPbPwZ2XRaH85HrPJKYEqO6dWuBKLx8n1i5mak+QKxfk7dS6SW
2pvLmr02g54bexbCc9tWZKsmpLtLkX2Nrrahy7qWc4i1/Zl7sTVxg5fn0zUr+Sgy
gelxouUDGTVySIgPKC4W3mE7+U47p4xWMLfcOiB/pQSOj+D14bjCdf/+lRsxiZOn
KMeZcRVsJSelQu7M4AL5WaPzpeRvO4cWY3OCEpGX77ej3JaIr25CJjZE0hTuxArV
QiFfs+ilNBGWJUCVJOqvgZhpen99y+3G/mC8oFpZ0GJFlIHSJlFSOvTPshFOeMmo
6YKEWG4KRp4jKkneBg5H9x7rePVRHChSz05hpiISKw6ZSmJQaksXh7rLjO9t7QkU
gfkdJlmrkxC9gpMCRxaFiejU9DY7xWAgGKeeYoWntr9ivhzuKUo=
=F981
-----END PGP SIGNATURE-----

--qot673k4pt267uj6--

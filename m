Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA83C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E8A2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E8A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbeGVXAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:00:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52560 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGVXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:00:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9C9D327DF4F
Date:   Mon, 23 Jul 2018 00:02:35 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     David Lechner <david@lechnology.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: lego_ev3_battery: fix Vce offset
Message-ID: <20180722220235.3cjpvsufswcqu53g@earth.universe>
References: <20180720201944.20503-1-david@lechnology.com>
 <20180720201944.20503-3-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="go7ejspxnjzluymo"
Content-Disposition: inline
In-Reply-To: <20180720201944.20503-3-david@lechnology.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--go7ejspxnjzluymo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 20, 2018 at 03:19:44PM -0500, David Lechner wrote:
> This fixes the value that accounts for the Vce of a transistor in the
> LEGO MINDSTORMS EV3 power supply driver. The old value (200mV) was the
> max value from the data sheet. After testing, the actual value has been
> found to be 50mV. By using 50mV we get a more accurate voltage
> indication.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Thanks, queued to power-supply's for-next branch.

-- Sebastian

>  drivers/power/supply/lego_ev3_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/lego_ev3_battery.c b/drivers/power/supp=
ly/lego_ev3_battery.c
> index 6e3b3e384172..1ae3710909b7 100644
> --- a/drivers/power/supply/lego_ev3_battery.c
> +++ b/drivers/power/supply/lego_ev3_battery.c
> @@ -52,7 +52,7 @@ static int lego_ev3_battery_get_property(struct power_s=
upply *psy,
>  			return ret;
> =20
>  		val->intval *=3D 2000;
> -		val->intval +=3D 200000;
> +		val->intval +=3D 50000;
> =20
>  		/* plus adjust for shunt resistor drop */
>  		ret =3D iio_read_channel_processed(batt->iio_i, &val2);
> --=20
> 2.17.1
>=20

--go7ejspxnjzluymo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAltU/vsACgkQ2O7X88g7
+ppESQ/+OmbigC+YZtUAiBrpp5Iwop3jBTPxRVqRQfJK26gpGKLgPiXQs9e/739m
IBjvvpwYdqiHCjg2kcjwkHyDqG1YYyJu4nTmKABU3yW80xtfR4tI5scHmqZJVjMk
2C8r3iyw2LGTVhIBA2QBEXQ+3bSM8mEHQ8EW2zjuzUPyZ45JmALi7h2Bqx0g1G9d
3tepiVnVCnyWvF5CjbfjX9Z0gNskTd/rbc3uEa1WAvGOSTJPfZ76Ko6jEC3Uz9mn
Mp6F3+5emE96BDh0wlxAo29rsmOVGZ2ZeZ9KRA2WfJn+d/idYs+eOt3N4dZ0mQKD
R9YUOZH9t9ogAFd1SH5bbxHMFuBlCOL0LJeemjm/iWLmIHi5pEWhPO1HKOnPIwgV
sBIpOs9nohr23iUcz31xbIxxL8BbLbrGwPzZc5DnpoWAuI9+xvz/vSHi/rnLQ09u
OhS7ue5SyF4HZ12Y5+GisLkoSbETeZsfazkcUzYsyB48RB6UTxNwqGFsqOiWDfxW
e/hO8Yz2wxdx8huHNj4cc1aZAX2HMaL/HDObP+itJuYE9O9eBm1SMdJ+Crgduz22
wG7rIh4+OxSd9tnpT1nkdvBS8YxA3szUn2za+VHWO5KZWSKGlunCCsv84VMVhmbS
Sl3OUXiL9miIC1HZXh/UpEOgMsYQgCB3c2y06IAWT+uwMRtla2w=
=kGWU
-----END PGP SIGNATURE-----

--go7ejspxnjzluymo--

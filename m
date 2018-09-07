Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904B1206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904B1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeIGOUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:20:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48338 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeIGOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:20:03 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9653580656; Fri,  7 Sep 2018 11:39:54 +0200 (CEST)
Date:   Fri, 7 Sep 2018 11:39:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        lee.jones@linaro.org
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Message-ID: <20180907093954.GA26364@amd>
References: <20180829093108.GB22065@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20180829093108.GB22065@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-29 11:31:08, Pavel Machek wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> mfd: ti-lmu: constify mfd_cell tables
>    =20
> Add const attribute to all mfd_cell structures.
>    =20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Lee, I guess this is for you to apply. Any news there?

There are more patches ready,

https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?=
h=3Ddroid4-pending-v4.19

and it would be good to get them in. (Alternatively, you can just
cherry-pick them from droid4-pending-v4.19).

Thanks,
							Pavel
						=09

> diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
> index cfb411c..990437e 100644
> --- a/drivers/mfd/ti-lmu.c
> +++ b/drivers/mfd/ti-lmu.c
> @@ -25,7 +25,7 @@
>  #include <linux/slab.h>
> =20
>  struct ti_lmu_data {
> -	struct mfd_cell *cells;
> +	const struct mfd_cell *cells;
>  	int num_cells;
>  	unsigned int max_register;
>  };
> @@ -63,7 +63,7 @@ static void ti_lmu_disable_hw(struct ti_lmu *lmu)
>  		gpio_set_value(lmu->en_gpio, 0);
>  }
> =20
> -static struct mfd_cell lm3532_devices[] =3D {
> +static const struct mfd_cell lm3532_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3532,
> @@ -78,7 +78,7 @@ static struct mfd_cell lm3532_devices[] =3D {
>  	.of_compatible =3D "ti,lm363x-regulator",	\
>  }						\
> =20
> -static struct mfd_cell lm3631_devices[] =3D {
> +static const struct mfd_cell lm3631_devices[] =3D {
>  	LM363X_REGULATOR(LM3631_BOOST),
>  	LM363X_REGULATOR(LM3631_LDO_CONT),
>  	LM363X_REGULATOR(LM3631_LDO_OREF),
> @@ -91,7 +91,7 @@ static struct mfd_cell lm3631_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3632_devices[] =3D {
> +static const struct mfd_cell lm3632_devices[] =3D {
>  	LM363X_REGULATOR(LM3632_BOOST),
>  	LM363X_REGULATOR(LM3632_LDO_POS),
>  	LM363X_REGULATOR(LM3632_LDO_NEG),
> @@ -102,7 +102,7 @@ static struct mfd_cell lm3632_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3633_devices[] =3D {
> +static const struct mfd_cell lm3633_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3633,
> @@ -120,7 +120,7 @@ static struct mfd_cell lm3633_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3695_devices[] =3D {
> +static const struct mfd_cell lm3695_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3695,
> @@ -128,7 +128,7 @@ static struct mfd_cell lm3695_devices[] =3D {
>  	},
>  };
> =20
> -static struct mfd_cell lm3697_devices[] =3D {
> +static const struct mfd_cell lm3697_devices[] =3D {
>  	{
>  		.name          =3D "ti-lmu-backlight",
>  		.id            =3D LM3697,
>=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluSR2oACgkQMOfwapXb+vJc9gCeJhEmRkDU4AdGI802/qa9KRTN
fJsAoLPQds2zvCk12tH5nNicLUlbMjq/
=ncb4
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

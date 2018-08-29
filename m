Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF419C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E3D20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E3D20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbeH3CoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:44:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60248 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeH3CoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:44:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B05C42723A7
Date:   Thu, 30 Aug 2018 00:44:56 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: piix4-poweroff: Replace mdelay() with
 msleep() and usleep_range() in piix4_poweroff()
Message-ID: <20180829224456.3iadf2hnv5pxlms4@earth.universe>
References: <20180730134838.9124-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e6z24ml27j33bwcs"
Content-Disposition: inline
In-Reply-To: <20180730134838.9124-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e6z24ml27j33bwcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 30, 2018 at 09:48:38PM +0800, Jia-Ju Bai wrote:
> piix4_poweroff() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep() and usleep_range().
>=20
> This is found by a static analysis tool named DCNS written by myself.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---

This is a shutdown driver, so busy waiting is ok.

-- Sebastian

>  drivers/power/reset/piix4-poweroff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/p=
iix4-poweroff.c
> index 20ce3ff5e039..5d4c72992d2c 100644
> --- a/drivers/power/reset/piix4-poweroff.c
> +++ b/drivers/power/reset/piix4-poweroff.c
> @@ -47,7 +47,7 @@ static void piix4_poweroff(void)
>  	     io_offset + PIIX4_FUNC3IO_PMCNTRL);
> =20
>  	/* If the special cycle occurs too soon this doesn't work... */
> -	mdelay(10);
> +	usleep_range(10000, 11000);
> =20
>  	/*
>  	 * The PIIX4 will enter the suspend state only after seeing a special
> @@ -59,7 +59,7 @@ static void piix4_poweroff(void)
>  				   PIIX4_SUSPEND_MAGIC);
> =20
>  	/* Give the system some time to power down, then error */
> -	mdelay(1000);
> +	msleep(1000);
>  	pr_emerg("Unable to poweroff system\n");
>  }
> =20
> --=20
> 2.17.0
>=20

--e6z24ml27j33bwcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluHIegACgkQ2O7X88g7
+prmXg/7B8AukUKPN9HKBpe0p6+SVWU8sgcHbz/vQEl9PbMI1ZFx5r75LljtlnVH
rOZLa3T4sko945gfrC07aG8a3BJS/V7ozVGWnfde5/Xsn2AtTiVO8UZPEIktnYgi
ELvJVwUkCziMd8O64K2Y3eiyUJEJVrdbCitPvIKbYINuH8XpCdnWT9GkAfsjAYkn
9Gxq7zlIf/DXjX8wUor/xlXILyW08KvKe4UxjHY8q5CWTdUo/CAUBfwJ6v1Jx8Bk
VrqHwZPCGPUIaY769BTy3tpUyltO8tsAjx0DOfLz0rlME6qZ76fSDtv9gMOqmXZf
CJ8KaD8KfD6mzW973/Sq3Pxy1UynZ0OXaml9gEEPiY/srQnCD9+SbyY5aRiRVFOy
sIO7RPsLrQaaqlqhfyqrZL7RTiaaykpX7pR40JxOKvuzCkw2/IzZK+EdsAhA5v0g
KdBxnu+ltUioSt7tVcCSVK53b2eCb4Hhu9A9Id/bVvCnH8IsKv5qjMaGqpjLhMzE
KzlwRRGxwEV7O7pYDwfBlYpTyIIIKtysdg+OT5ob+bo04vkMzmsCl6GOHJ8+Uf4V
JK13LnRBn34kFeqN1bq+LKJPVgrFBZGt/C3HDGxwR9Xu8X6naBkecTUl9jTt7hkq
H7ZFc10wxqUjTNbriFIOowyy1NCtPVCfrOmayVydZyl1x0P5zNg=
=VUEm
-----END PGP SIGNATURE-----

--e6z24ml27j33bwcs--

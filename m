Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2431214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2431214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeLEUmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:42:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEUmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:42:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B3618263BF7
Received: by earth.universe (Postfix, from userid 1000)
        id E3B313C08D6; Wed,  5 Dec 2018 21:36:34 +0100 (CET)
Date:   Wed, 5 Dec 2018 21:36:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, broonie@kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 3/6] power: supply: charger-manager: Fix incorrect return
 value
Message-ID: <20181205203634.f6u2yo7v3gonv2cm@earth.universe>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
 <edef76d756eeae2708f5a23f4d8f1f742fac76a7.1542362262.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4k54tp3efjptzhvg"
Content-Disposition: inline
In-Reply-To: <edef76d756eeae2708f5a23f4d8f1f742fac76a7.1542362262.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4k54tp3efjptzhvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 07:01:10PM +0800, Baolin Wang wrote:
> Fix incorrect return value.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/charger-manager.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/suppl=
y/charger-manager.c
> index bd6c450..a52bc77 100644
> --- a/drivers/power/supply/charger-manager.c
> +++ b/drivers/power/supply/charger-manager.c
> @@ -1212,7 +1212,6 @@ static int charger_extcon_init(struct charger_manag=
er *cm,
>  	if (ret < 0) {
>  		pr_info("Cannot register extcon_dev for %s(cable: %s)\n",
>  			cable->extcon_name, cable->name);
> -		ret =3D -EINVAL;
>  	}
> =20
>  	return ret;
> @@ -1633,7 +1632,7 @@ static int charger_manager_probe(struct platform_de=
vice *pdev)
> =20
>  	if (IS_ERR(desc)) {
>  		dev_err(&pdev->dev, "No platform data (desc) found\n");
> -		return -ENODEV;
> +		return PTR_ERR(desc);
>  	}
> =20
>  	cm =3D devm_kzalloc(&pdev->dev, sizeof(*cm), GFP_KERNEL);
> --=20
> 1.7.9.5
>=20

--4k54tp3efjptzhvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwINtIACgkQ2O7X88g7
+prn7g//SmzLat8wABBr5Pe64cyPtuFqBq29DMkaowLjuLJSdjI29GGpA6OKn5AO
sHT26tZA88SMB23WDwPVpubaMwrQdATNvNQtcS1zjdXdyk8F6RcUBJ0cCeP5IAXc
QlX211xAKByDHie1tjHbJk73cn32WvhpwBMbV8EO2V3r0NaSBE327C/YmdksTVXt
t1KmdHHJm9B2e8vYGGCblI0+saVPZxcXLbxsOh12Eo/puqnrrzpmxm2N0ThdcMuR
8aWZhA0kXgDmoiS3cYtMoUTDuBoO3BMY3fOmiJdawFQwNkF4OWiBrj+4XiCbzKRR
6Ej/bPXLOJsqkR/iySFdrsZC+7+jjByDVRhL0X/fpcNVW9LMI7slYcjd1FmN5B/2
Qm1AEloya8/aXvdqxd7C76zCmXTLcLWg2OQsvxyMNbrdqHm/YWtMRoRM2IVTyi0s
9wcLwCpjPYLrbAlRaT8UIq07u/dj83uTzI4YwXZ5ScjKddA0I1oTjk7sn38JrzGm
Zc+YSU/VsytB2bOHALpcDwZ3n9sNfxzgW9xOq/eYFtBDjr7Cd8Yhn2U9YXAfY4Nw
6NyGgOKU/ZDs2iIpDktX4XwOet8Xc8rbLKKbI+zqzseJbLFodAYg5ixQOctk0z7u
jKsJ7q1GuzVtOHB60hnVVfQdatUV0hSgR18+0psiQ2wXj/RJdzE=
=3iHH
-----END PGP SIGNATURE-----

--4k54tp3efjptzhvg--

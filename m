Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6AEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC3821BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vdCNdyET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC3821BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbeHIPLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:11:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32847 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730664AbeHIPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:11:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so5062277wrp.0;
        Thu, 09 Aug 2018 05:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzA4odwTs2y+Akxng79BIPj6j3Dz0eYAt5pdKBWJiI4=;
        b=vdCNdyETKjHsIUmCi+aWec4Y2LNq3RooNqaE97NDF7vf/xmehYkNsJGW8baEhfSMPZ
         J5uv9udQdHIealKqD1ipTgglrtjZC+ligZ8JhhW/kWHZ3D4GXQTfKcE5iuTHxUE8QsTw
         R1y3FvVnHDT/ZNC5Zwttq3tP1mhRo/DdZqPpsuzNdo2rO8iISGCfrAgAwjc+F/e7N5Ky
         7sICEClPMuVarYD8VDZmLxHv7lyoANzOSJiBQIm0wa352CsF3keGHpW2BTES8wqqaHNU
         pBg5OZbVwI6CBl00lRkgVgqqnSrO+NE/xFscivoXyMf7AaziwINIqu7vdrIFyAiXqpm6
         9ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzA4odwTs2y+Akxng79BIPj6j3Dz0eYAt5pdKBWJiI4=;
        b=fK/L/8//wn2N2awrFgnZ1/9RQnu2Ufgg1b+qj3qq6oSH+8oGuUw20kTqs1XZlcEWir
         qf2Ljx3owpSJXOrzjGB164WZG2EcirMiT1GcjgiTe5T59APdYkI6fUcve0dRiwjs0p1A
         mvb0ItOTZqATohTXyrAcguajN9vy7fmyeUFpJtl8gd2bD26k5ngF2/t0WCkjuJSGYZc5
         9X5ulBWNOwgVmh7kp5FFrmB/1gO7zHDAeDl0XQK2loEqbBrAodNnzlxtDbGuhdVUeJsU
         m572jP+RcBD49klRT4CQKyyt3M9gKcp69XzeS2q3PxUDQMkeIojQmXVmXTkOCQmYUaX/
         R4RA==
X-Gm-Message-State: AOUpUlHcO1BJ7z3BAPVUODJ/CjgyNUC6ad4xXp3hjpec18F2V8HznFp4
        iTk1sFTKhzX/D70AF13l2+8=
X-Google-Smtp-Source: AA+uWPzcKCnu2/nyDShWv8mqAj9uvvunNkwCIdSpm4flyIjZGRUw2537+67piMuJo6C4fqsBG3/BGQ==
X-Received: by 2002:adf:9443:: with SMTP id 61-v6mr1281035wrq.193.1533818778064;
        Thu, 09 Aug 2018 05:46:18 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id t13-v6sm5119569wrr.74.2018.08.09.05.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:46:16 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:46:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 13/40] mmc: tegra: Poll for calibration completion
Message-ID: <20180809124616.GV21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ln+iIw7POnzHEEo5"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-14-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:03PM +0300, Aapo Vienamo wrote:
> Implement polling with 10 ms timeout for automatic pad drive strength
> calibration.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7d98455..c8ff267 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -16,6 +16,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/iopoll.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> @@ -50,6 +51,9 @@
>  #define SDHCI_AUTO_CAL_START			BIT(31)
>  #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
> =20
> +#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
> +#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
> +
>  #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
>  #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
>  #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
> @@ -228,13 +232,20 @@ static void tegra_sdhci_reset(struct sdhci_host *ho=
st, u8 mask)
> =20
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
> -	u32 val;
> +	u32 reg;
> +	int ret;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	reg |=3D SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> =20

I know this is preexisting, but I want to make sure we cover this so we
don't run into this down the road: do these bits automatically clear on
calibration completion? Can we run these multiple times and get
everything properly calibrated?

Thierry

> -	mdelay(1);
> +	/* 10 ms timeout */
> +	ret =3D readl_poll_timeout(host->ioaddr + SDHCI_TEGRA_AUTO_CAL_STATUS,
> +				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
> +				 1, 10000);
> =20
> -	val =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> -	val |=3D SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
> -	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> +	if (ret)
> +		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>  }
> =20
>  static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> --=20
> 2.7.4
>=20

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsN5cACgkQ3SOs138+
s6GYHRAAhnIxTqOFS5JCDqKLbQXPIDN9Wv4B49j5P9LXKghw8CzwpvVa4UY51zeX
J5vOocxd29RgKSSE0nKeh4/4/PBtjSSvArLsrn4S866NX7Dib5kO5SOxYKaP6nBu
kOWWkbn9lFwhMAV0ocS+XJSsJaDKRpT7piCXNZPkwHyXQCk4Uevdhcog2S4gI31u
TC9d7G2KZHxtl9Vs49XrIRS0MSIZ5EmgLG9bFGYwqRihu1N+scS3fCFO1RNch9ls
Qz1sm5j5F0nu+1PzSFcJaxZIS/r0ooNg3ru49x/ZLh+sKI3wPSxRPGslk7rUFOJt
catDb4HfdQNuaNzEkSfmv4NiXz/fJthwwru4XVUoY/uTmGj8IO9D+cVLO985ZR4S
FJXSD61T5CS2K5oJF35sCB0I52DaaT8rfTKLL+6HN2IvORg03OhH++hBjwAsIa24
eqZrWQjzwLEJdFAR2I+e3Dmc3FirXckcD9dT8B372QfLzO5t6geVq8donIdO38Vr
eP0ci67ldBmCyzryePiZxaSXPYtzw0wRAAw2UkoQ2MJBaYf0mRZ1CRx7mABwbDL+
GGxQ4Gg4YVbB+hkjU9jzG2LScReLiTJA7sUicMu6aqa2SlZsl3d3BuJhDfC7QIsE
RSCuZmWdbMz4PGgHVCI8/qCmelANORzTw8Y+8jECvE68aj6l79s=
=6oib
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--

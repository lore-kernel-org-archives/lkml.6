Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF21C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F9121C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORlOG+xv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F9121C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbeHIPW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:22:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45714 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIPW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:22:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so5039428wrv.12;
        Thu, 09 Aug 2018 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+UjceBmexJ6zdmXBM/5IweZvSe/Ff50FXBJl1isMHFw=;
        b=ORlOG+xvghRKwNzvPHCjQ8jkbD1R+wN9ORBoV0IraTLDmKWu4bgUjSLj6b3sX5o0Gv
         EjaO8SQvOz0YdnKyds2QfRMA5Xeipl7omevgqrzcoTWV8EVNcqIKv+Hu9xOaNx03u/So
         Vrf7vbq4gcgdsmVhUd4uZRDK701KfA57xgCkhThVSLUaU6PxYXUffHSFRnVh69oxI59u
         JAeYEaVMgnhqMpdpmptxSR9Gmuuh+TBcfIxWm97cbKVOgNzPeZaMiVKM+G8dhB7zNivW
         ZB3Jzz3eFrfgrnGfuRh8Sc5+ZUjGZwAIYoykTGRjrI2GlztnzxJJ/I/rLOosuLNi4fQ/
         WiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+UjceBmexJ6zdmXBM/5IweZvSe/Ff50FXBJl1isMHFw=;
        b=ei0/zhoYZvdayKgeGKkyQb4dN/A5kMjl4Sj9gm8Fge80/m57sH3huwbnmn8rDvgD1f
         WoYr8FrnVpRsG/+pKlTgw5hJazgt8RJ4piroTfyW7ytLtxDLmB6Kbq7YKFnzABO7SW8Q
         xhaz6JN3iMxkyqiRZE1aGNgSK261jE/FTsQzvFBrC875ljtW9x6Q9JC+LFXG74aGw3+v
         heBx2eeK1c97gx74M2NgUztOP1NiE0b8Ko3LIGeJMnDAT1N/z1PUE+wf2ShAx4SELm5n
         smOmrZV3MbXznt7lyWkMMmLs36rpG9aKJTuI4BayzVbxYJWYHl9NS0VYfI5Yfq7VG84e
         oB0g==
X-Gm-Message-State: AOUpUlGrto4U15m6ZgMx2X0Mu1+ZdJLJxc7GYc4HlEHkf9adcYxK/HDd
        capJ1pkdv908t4Dk0r7cfls=
X-Google-Smtp-Source: AA+uWPw3Ym4gzuUVBf2SG+g6ur1UW6Rj7xYZAXuhPuEhBZLJdB8gNYyuWp/KwgnJ664+P13KKU+hJg==
X-Received: by 2002:adf:fe8f:: with SMTP id l15-v6mr1430952wrr.165.1533819486102;
        Thu, 09 Aug 2018 05:58:06 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id p25-v6sm4354538wmc.29.2018.08.09.05.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:58:04 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:58:04 +0200
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
Subject: Re: [PATCH 20/40] mmc: tegra: Add a workaround for tap value change
 glitch
Message-ID: <20180809125804.GY21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-21-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B7FF+pnjRCrp0ISR"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-21-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B7FF+pnjRCrp0ISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:10PM +0300, Aapo Vienamo wrote:
> Add quirk to disable the card clock during configuration of the tap
> value in tegra_sdhci_set_tap() and issue sdhci_reset() after value
> change. This is a workaround to avoid propagation of a potential
> glitch caused by setting the tap value.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 3c10451..a2375ad 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -47,6 +47,9 @@
>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
>  #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
> =20
> +#define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
> +#define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
> +
>  #define SDHCI_TEGRA_AUTO_CAL_CONFIG			0x1e4
>  #define SDHCI_AUTO_CAL_START				BIT(31)
>  #define SDHCI_AUTO_CAL_ENABLE				BIT(29)
> @@ -68,6 +71,7 @@
>  #define NVQUIRK_ENABLE_DDR50				BIT(5)
>  #define NVQUIRK_HAS_PADCALIB				BIT(6)
>  #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
> +#define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
> =20
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
> @@ -499,12 +503,32 @@ static unsigned int tegra_sdhci_get_max_clock(struc=
t sdhci_host *host)
> =20
>  static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int ta=
p)
>  {
> +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_tegra_soc_data *soc_data =3D tegra_host->soc_data;
> +	bool card_clk_enabled =3D false;
>  	u32 reg;
> =20
> +	/*
> +	 * Touching the tap values is a bit tricky on some SoC generations.
> +	 * The quirk enables a workaround for a glitch that sometimes occurs if
> +	 * the tap values are changed.
> +	 */
> +
> +	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP)
> +		card_clk_enabled =3D tegra_sdhci_configure_card_clk(host, false);
> +
>  	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
>  	reg &=3D ~SDHCI_CLOCK_CTRL_TAP_MASK;
>  	reg |=3D tap << SDHCI_CLOCK_CTRL_TAP_SHIFT;
>  	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
> +
> +	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP &&
> +		    card_clk_enabled) {

This is weirdly aligned.

> +		udelay(1);

Can this also become a usleep_range()? I may be too paranoid about
this...

Thierry

> +		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +		tegra_sdhci_configure_card_clk(host, card_clk_enabled);
> +	}
>  }
> =20
>  static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcod=
e)
> @@ -758,7 +782,8 @@ static const struct sdhci_pltfm_data sdhci_tegra210_p=
data =3D {
>  static const struct sdhci_tegra_soc_data soc_data_tegra210 =3D {
>  	.pdata =3D &sdhci_tegra210_pdata,
>  	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL |
> -		    NVQUIRK_HAS_PADCALIB,
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
>  };
> =20
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata =3D {
> @@ -783,7 +808,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_p=
data =3D {
>  static const struct sdhci_tegra_soc_data soc_data_tegra186 =3D {
>  	.pdata =3D &sdhci_tegra186_pdata,
>  	.nvquirks =3D NVQUIRK_NEEDS_PAD_CONTROL |
> -		    NVQUIRK_HAS_PADCALIB,
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
>  };
> =20
>  static const struct of_device_id sdhci_tegra_dt_match[] =3D {
> --=20
> 2.7.4
>=20

--B7FF+pnjRCrp0ISR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsOlwACgkQ3SOs138+
s6F0BBAAoaIQAqFlshNymfiyhxa0gQPgVnTkQbJtwzhZGZqYkjfpQNUWWOKzH44l
902s3VSsRE6E0vIPjL3l1P16g/msr6YBCPHcx7M0uICxAdDpYn33RtuxUdsSSysq
6DrGPt4p3iE9+Zigxtl65CdDXKiU9neZOsiJ/SgmdTMIlFAy9hKxjT4EIRspdIYq
pa2oLL2b5teaBzvWd0Fshmg7gkDSIEmfrbD/iT+KkMUiOW0wJX4D98f80YSujSwB
cel3raQiwOmYo4IcVrO4JV6NKhmrJ60cZTBz/xaIGTm/RzmlR3huoilYGNu4xMpG
HCT9IrQa3YkBi07qN+qzPNCzU1gzj+bwdgA5RGv3wd65m0wOWJyxrZOwzc3EbJwo
VwqPrxqJqoVorvF42pOHvunPhEGGV6ZqQapvIZBP1ERrG2mOyIZ1sqpBDl78RuKn
/HCxpT5Tk55HcJo6S9bkINlNwQs8CSVOostuZUW4WUpp+AI4xCUAkUEFuMY2ZKG3
vzsE2GBwIVHI+Pcd5jQLY1ylecXOoYlTvdmZHk9KHwe+l+pVlnrPRcqDdYFwI/7J
ntsVgvIXBT3oqZZgfHpwGirvMvdpjh5Nmx9dnafoaWUvW8ijQqd/sZchHqV2jk3n
eHYo41aNTq5EAAdmnyeTxYpOIr5E428edqDUVWx9q2hvPebF610=
=b49y
-----END PGP SIGNATURE-----

--B7FF+pnjRCrp0ISR--

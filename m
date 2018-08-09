Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719F3C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2097F21D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvpqJYFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2097F21D68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbeHIOFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:05:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36681 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbeHIOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:05:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so4887807wro.3;
        Thu, 09 Aug 2018 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SppKGBElEAqyAZVMKpCOVnzc2nlf3kBDc5nzyqSivBo=;
        b=UvpqJYFjv7NIX1Ddt5dSmRGpzcpcybYnAYtwTNfIxPCQT7c0snZp9FRLWHiUutHgFr
         ix9XV3WcSmzP1lCwvLkmQZfTKUfmwwuXFridqkMNrJdbH8G2ayN/hssTAJvux/5tRSQ+
         946Fpa/zqsXnZDgUpFMOBG6cO5MEZnTu+igU5cBg9HEYNMRklhtpXqeVs4h2aRUJMY+v
         ntEoALc7vvoH+QRAxOP61dZakAUTCCm26rmgYQ9qrz8YeQGBHv8BsOaOWJke3UFz70Tl
         rdup/eI2mzbq4MSUVRUe61hU8hWZ4hJtJ3Z6O+yi8c8Xr49Qquka3qMypufPGwyWDK+E
         DjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SppKGBElEAqyAZVMKpCOVnzc2nlf3kBDc5nzyqSivBo=;
        b=ubjzMlWW/Pq8Dn8zItPfC98ypCzotBIW2GuS0ft9z0kb74syHH3ouN9peWfC/I66ue
         1rCU07uiCiPJCI36ZebJDy0ozVqPc4xMXbnN08MowoI6xo8/Uzy7yXK1aTiGRtpBaKck
         RS1Ub7XR1nnMyHcObLhiWij4QkIMaMPBie1Qx47QPKszoRg5mtducDCuIAwRonMF4RDC
         DJjh4qbeXSAz/U+oldtxSiS7bGa/ldCI4P4X9VRA8vnjlY2mtjAF7OmxuDQqC9MRpJ9M
         79/gEs3YsE57RqfIKTu1jY7RNLe/t98BjwGpt9B3HlrAnASrHSKk9Am970u7R7ojlPtK
         O9Yw==
X-Gm-Message-State: AOUpUlFxKei4OxrLWegMpyD45DZvkDfXkqU2Lf5hd7epW4wNfWyYpR+v
        cE87OVd57li5mlIZVf1+Qh0=
X-Google-Smtp-Source: AA+uWPxuN0vDWxqearWI2XW4fiSaNfi2gzgc9xy94Y22wtRnD2+pu55JJa5H9H5qEcbTDxmFccPkxg==
X-Received: by 2002:adf:8bd4:: with SMTP id w20-v6mr1210471wra.110.1533814847816;
        Thu, 09 Aug 2018 04:40:47 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id j8-v6sm7096667wrp.11.2018.08.09.04.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:40:46 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:40:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aapo Vienamo <avienamo@nvidia.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mmc: tegra: Parse and program DQS trim value
Message-ID: <20180809114046.GJ21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Content-Disposition: inline
In-Reply-To: <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 04:59:58PM +0300, Aapo Vienamo wrote:
> Parse and program the HS400 DQS trim value from dt. Program a fallback
> value in case the property is missing.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7f1ac4a..426f7ea 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -43,6 +43,10 @@
>  #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
>  #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
> =20
> +#define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
> +#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
> +#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
> +
>  #define SDHCI_TEGRA_VENDOR_MISC_CTRL			0x120
>  #define SDHCI_MISC_CTRL_ENABLE_SDR104			0x8
>  #define SDHCI_MISC_CTRL_ENABLE_SDR50			0x10
> @@ -112,6 +116,7 @@ struct sdhci_tegra {
> =20
>  	u32 default_tap;
>  	u32 default_trim;
> +	u32 dqs_trim;
>  };
> =20
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -500,7 +505,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct s=
dhci_host *host)
>  		autocal->pull_down_hs400 =3D autocal->pull_down_1v8;
>  }
> =20
> -static void tegra_sdhci_parse_default_tap_and_trim(struct sdhci_host *ho=
st)
> +static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>  	struct sdhci_tegra *tegra_host =3D sdhci_pltfm_priv(pltfm_host);
> @@ -515,6 +520,11 @@ static void tegra_sdhci_parse_default_tap_and_trim(s=
truct sdhci_host *host)
>  				       &tegra_host->default_trim);
>  	if (err)
>  		tegra_host->default_trim =3D 0;
> +
> +	err =3D device_property_read_u32(host->mmc->parent, "nvidia,dqs-trim",
> +				       &tegra_host->dqs_trim);
> +	if (err)
> +		tegra_host->dqs_trim =3D 0x11;

Okay, so there's only one value. I think that should be clarified in the
bindings documentation. It should mention that a single cell is used for
this. Also, I assume there are lower and upper limits for the valid
range of DQS trim values. Might make sense to specify those in the DT
bindings as well.

>  }
> =20
>  static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> @@ -545,20 +555,33 @@ static unsigned int tegra_sdhci_get_max_clock(struc=
t sdhci_host *host)
>  	return clk_round_rate(pltfm_host->clk, UINT_MAX);
>  }
> =20
> +static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
> +{
> +	u32 reg;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> +	reg &=3D ~SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK;
> +	reg |=3D val<<SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
> +}

Nit: I dislike using "reg" as a variable representing a register value
because I keep interpreting it as designating a register offset. Hence
I tend to use more explicit "offset" for actual register offsets and
"value" for register values.

But maybe that's just me.

Thierry

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKD0ACgkQ3SOs138+
s6FmkQ/9F0beuA1UTQrpplGHi+FBskWP++XGlYwBOXM4LFWV+zGE21JLLcyC3S42
xVjbSPLhPk6NGak5cCQ+uJuVfdSJpNXZRdW5x+tMqO7WsPjINfL44VDTmg2mUdfF
0Dud5Kyv9lI5RrMKKsJiFnia7gyUyrB/eaoh4gmOklD7iv4D8PdjoD8CCawPjvCo
GK7mF3GxUo01I7x5gVByC/VjKbmG6if5IhiYhHml80OiPOcOtqhAsiuUAnTCSb1B
IiWuDZXnjwWR6uVe0c3/vNAPoaOUvJZdt9TVdntIr6Ib0bOYVCF/i5OF4wQgJGa2
rMZBdY1b6EtWL8/twMenlFXNN09g7c5+j8D+ScrZplLVO4gunOETy9mCqUP/lnLM
iqD9TtyzD8FW7yxYPoMyYJNv3Byl6g1uxt1xjBzb/N8a5NLgIijGt6ETMed3jZTD
5nk0rC5j7tQ0902GlvTAkkUXe6vemIMWXne+Dq+fEphDMPH6XmbW24UuZs+BKwfq
oteAddY+d+QkMl/q7DjbYDFajWTQczyqVo05cy7YcjJMUZEdHQTdjkXbJZZOyQE7
EgoDS033AczK7R3HMs2nDNTP+i0d7LR8ilgvf4aHETXv1EGMqGTz7LzSkb4Y34fv
1OYbSxz1V9YYqPLt2ISHD5ppPJcuWLH0Z+8CkSBuBBrXOSj+Vv8=
=Hq+P
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--

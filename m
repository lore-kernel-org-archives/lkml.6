Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76684C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D73A21D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6guX016"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D73A21D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeHIPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:19:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34724 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHIPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:19:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so5087677wrt.1;
        Thu, 09 Aug 2018 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAaUJkTDjivVrB3Lu7VoMRp8c10Md/y1FmRIMQ+/2xQ=;
        b=l6guX016cMDkDk4ez8vtGr0UyKX8HW0TxyPZ+AacggDXuBq2+BysPsnRkfSoSotJTZ
         saWsfPauqVifNIcdo7LD9581yvAslvxYE73b5AEovDIZK3sVEsh8BxVtlbp7oKl2kb06
         Ew7i0vEGsvghUk5xWvwgVfi38gvg3wwvdT15wE3j+6LtGZeLczcFjnPaksDMf5Rbs/+L
         7HPz75nImCcxjEJaIJBjkM2Tef2wI1gdS6KxuCLCThuXT2hcrOY6VXalH7gU2YpT3yMg
         xKZSNwsc1f285aBiMfqUMovJaGiDMIfNi1++iv+LSDQgCsfsjIaqYIY4s1BRQDvmY2PM
         5DCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAaUJkTDjivVrB3Lu7VoMRp8c10Md/y1FmRIMQ+/2xQ=;
        b=LM4kkkwpowhUb1LegODSbmtiPaRPX8gqrheNrqpSIfKnhKJIegMRRwMEFefzsvOt0+
         G1fmUqBWx9hXFh52so3x2khWIGWwcE+1oIzd5K+bFWmgc/QGwa1TAjdrZlh6vlTsBdIa
         tdAfReRW0+c2ukSUxAOit6ZoJ9FQA1+0u0WFHeO/lQV9jpAk0o/rxD+J75LSQaBEdoTA
         dStMgD8l3IKluhqRO/lRK/fZa5g34bLt7+RxVx5cfcXdglqCcPFWSTdLDoSBiPyOvayl
         kcQLfz4lmiiObuF5sZ6/38r+6FgxIZLYwbHH/FsUNdxCFapr2jULnsOlE5ePuAuZXI5p
         H+qA==
X-Gm-Message-State: AOUpUlHxsJzfaCkonZmA24uGenLPbYLT9Macg07zFD8y5VZp7IrhaP0o
        lgBB+VMB6iItUsbwGToOMjs=
X-Google-Smtp-Source: AA+uWPxl7DpoArDKa6NSy8jH6bax1ExhP8K0XhBAMDqiG+HoXbr3wDpl8Vlu4GuBBXO5hasQDNiJqw==
X-Received: by 2002:adf:ef03:: with SMTP id e3-v6mr1309944wro.182.1533819264589;
        Thu, 09 Aug 2018 05:54:24 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id i23-v6sm11071280wmf.24.2018.08.09.05.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:54:23 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:54:22 +0200
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
Subject: Re: [PATCH 16/40] mmc: tegra: Disable card clock during pad
 calibration
Message-ID: <20180809125422.GX21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-17-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Weqbz6OltVu8XOAh"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-17-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Weqbz6OltVu8XOAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:32:06PM +0300, Aapo Vienamo wrote:
> Disable the card clock during automatic pad drive strength calibration
> and re-enable it afterwards.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 9e22fec..c2b388b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -260,11 +260,35 @@ static void tegra_sdhci_configure_cal_pad(struct sd=
hci_host *host, bool enable)
>  	}
>  }
> =20
> +static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool=
 enable)
> +{
> +	bool orig_enabled;

I don't see a need for the orig_ prefix. If you're concerned that
"enable" and "enabled" might clash, perhaps "status" would be a better
name?

Thierry

> +	u32 reg;
> +
> +	reg =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	orig_enabled =3D !!(reg & SDHCI_CLOCK_CARD_EN);
> +
> +	if (orig_enabled =3D=3D enable)
> +		return orig_enabled;
> +
> +	if (enable)
> +		reg |=3D SDHCI_CLOCK_CARD_EN;
> +	else
> +		reg &=3D ~SDHCI_CLOCK_CARD_EN;
> +
> +	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
> +
> +	return orig_enabled;
> +}
> +
>  static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
>  {
> +	bool card_clk_enabled;
>  	u32 reg;
>  	int ret;
> =20
> +	card_clk_enabled =3D tegra_sdhci_configure_card_clk(host, false);
> +
>  	tegra_sdhci_configure_cal_pad(host, true);
> =20
>  	reg =3D sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
> @@ -278,6 +302,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_ho=
st *host)
> =20
>  	tegra_sdhci_configure_cal_pad(host, false);
> =20
> +	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
> +
>  	if (ret)
>  		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
>  }
> --=20
> 2.7.4
>=20

--Weqbz6OltVu8XOAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsOX4ACgkQ3SOs138+
s6GWGBAAuqsUpd7Kr2tZ77UbLE2xA3bjaLkR6HPsuzzz1NPp07QsIAy+r0hOwmE6
TY8qahazQ0p1nHYkbHQ1F6gmzakv/cxSF9rXCH/BavR4RaMYYX+hkghFb18iLgZf
rFGNvzLL5WfDHzmxoO6955RZYndlbM1wsqs/Ck4ZA0mTKW5G1UoA8daSaM1ndc9N
m/QnaC9wTo84u6ezRT7NhQDB06r1wQgRermFCF/GzrjbyfLy0u5jwI8ESGYeVa/B
h4onjxr0eTBEg/EqdUjbn12s8n/to7MrTkZuWQjnMrg4ZlXVo4dkm1fIusXFbtss
rzxcc+J0QIyOw0MRoxQyvasTKaU4lhwOwUQWcUavC8M7S/KsV4eVi8ThwKtjlnW5
2V6F50eTsvaQ0UZ5cL8LUJOr2MCsyhHazTIx25fF9NsVuvMU/o2vOSOpImKp76hR
B2QqnudO2NIvS4d4qM7byiNLA/gZ6/QSzAItMQYzKQMCybl7mPtCpwzjhYcAfaJs
nEyfLFFnrC9lNFC7PHZyMg5x987iDiqWGZH/t0JquMTcikMksfnBfsmkYMbeAGu9
2MykVLmldDEmMNw+GhagVW4ryXOqtvI1QCuv1SfqeLVRjrgXtES4YlJrO5XYjxva
8j2lAIZC978gYvYjgTfBFYuKqtE1eM28H8qh32QAb+DZQ5u2u/M=
=eKZr
-----END PGP SIGNATURE-----

--Weqbz6OltVu8XOAh--

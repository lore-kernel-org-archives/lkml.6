Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E309C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC4021D6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrUIZSkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC4021D6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeHIOp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:45:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45595 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:45:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so2754149edq.12;
        Thu, 09 Aug 2018 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z1IU1lVrSq+lWl9KIGA9uCBI/ahPc+7pGzb56LPuxgM=;
        b=GrUIZSkN/1MF/RK27jpQeQ/mcJ0Wl9kBQ8bciwSHHbnJqJk7Ivjxq5bTl2X9PzAjfc
         YHxZdumSBmi4oa1jcwXePNeCk1C4UxlwUpbOivzFkykyVGZ6tFc0UXY9NrnVvJwqlRG0
         DBgM7Ytt58OH0BKMN4tKiCGdD8KMG96rzIjnSz/SG+oTzCd9rwHmLcbTAVupniVmRx7p
         +FlGQYL42HbgBnEXkWiC4kSrz13NxGWlvOJ1PuWRgBftAuFowoeSS8QDfoJf3TVYG2Xk
         1tM0rar9CdP+4RPQ/lfcmrNHpxKbwywoD+oLY/KFGQdWb+0exU4LrspZ57KrU+PIG6Lv
         kPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z1IU1lVrSq+lWl9KIGA9uCBI/ahPc+7pGzb56LPuxgM=;
        b=IFoEEfuQndktRfFN84aEprSz57woo7TnPFEDHMuGbBcorHPuIXpkrr6HQMP/pUsmGg
         otx0Fla3ZoRxiy5QEpTIVsl+m/QWgx0qUDZdiVFtfyHoCjWALFm3m+TKy4LnLYUWVD2b
         1O+xtkKKZ1EHiHjZMwCawhbExdGyPkX0iioVK7H3Yvey4RjEEQlhuNRl7Ny8oxHpJLak
         Gd1J3tmAkndDfNd0SRtADDyxfIULZ8buvY7L5qcsKRc0GWtfA2up7y4y0rJPfIkbksW1
         9WBsHL6yF3W4+0woxdlzF61GTC569C/BDHYhBuJ5LApgAxNXIF608RKaWYtx9c22oF/Q
         oclA==
X-Gm-Message-State: AOUpUlGzpNnZaj0W8+W/suy1SLKvg3YWbCmTEyHGiy0RNALd4ORegm8x
        /o8paowqs6fsyv8TxhaJ5jo=
X-Google-Smtp-Source: AA+uWPzC9PH5SZYT6568n2YHOptwMsml1PdWBDaMrpfkh9Z6wuTsz4ur+ULhGmiV3M8peafolabLcQ==
X-Received: by 2002:a50:91da:: with SMTP id h26-v6mr2893138eda.87.1533817247576;
        Thu, 09 Aug 2018 05:20:47 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id x33-v6sm5406364eda.81.2018.08.09.05.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:20:46 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:20:45 +0200
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
Subject: Re: [PATCH 05/40] soc/tegra: pmc: Fix pad voltage configuration for
 Tegra186
Message-ID: <20180809122045.GR21639@ulmo>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
 <1533141150-10511-6-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OiITrshLgfui8fEl"
Content-Disposition: inline
In-Reply-To: <1533141150-10511-6-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OiITrshLgfui8fEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 07:31:55PM +0300, Aapo Vienamo wrote:
> Implement support for the PMC_IMPL_E_33V_PWR register which replaces
> PMC_PWR_DET register interface of the SoC generations preceding
> Tegra186. Also add the voltage bit offsets to the tegra186_io_pads[]
> table and the AO_HV pad.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 55 ++++++++++++++++++++++++++++++++++---------=
------
>  include/soc/tegra/pmc.h |  1 +
>  2 files changed, 39 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 2d6f3fc..f926332 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -65,6 +65,8 @@
> =20
>  #define PWRGATE_STATUS			0x38
> =20
> +#define PMC_IMPL_E_33V_PWR		0x40
> +
>  #define PMC_PWR_DET			0x48
> =20
>  #define PMC_SCRATCH0_MODE_RECOVERY	BIT(31)
> @@ -154,6 +156,7 @@ struct tegra_pmc_soc {
>  	bool has_tsense_reset;
>  	bool has_gpu_clamps;
>  	bool needs_mbist_war;
> +	bool has_impl_33v_pwr;
> =20
>  	const struct tegra_io_pad_soc *io_pads;
>  	unsigned int num_io_pads;
> @@ -1073,20 +1076,29 @@ int tegra_io_pad_set_voltage(enum tegra_io_pad id,
> =20
>  	mutex_lock(&pmc->powergates_lock);
> =20
> -	/* write-enable PMC_PWR_DET_VALUE[pad->voltage] */
> -	value =3D tegra_pmc_readl(PMC_PWR_DET);
> -	value |=3D BIT(pad->voltage);
> -	tegra_pmc_writel(value, PMC_PWR_DET);
> +	if (pmc->soc->has_impl_33v_pwr) {
> +		value =3D tegra_pmc_readl(PMC_IMPL_E_33V_PWR);
> +		if (voltage =3D=3D TEGRA_IO_PAD_1800000UV)
> +			value &=3D ~BIT(pad->voltage);
> +		else
> +			value |=3D BIT(pad->voltage);

Nit: blank lines surrounding the if ... else ... block might improve
readability of this a little.

Thierry

--OiITrshLgfui8fEl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsMZ0ACgkQ3SOs138+
s6FWNw/+OAM3l/QWbf2RLvaGYH+1pFSK3IB/yN1mQPefXKHM6vQtEsXTBqO07MMx
2XKoA7oZ7EfSb6HJLR3Ns7LtaH7uP7+5qWRsuMzU4Ep2xKnY3s+gxb4Ngm14tzi9
8pS/FNrhLqvaNtSmUtYdedGElifLRvbonzdSmSKbyX6asjibFiJA7T40nWBokgxH
qIow1tkIdNbocj/ifspmz8rKPxPAwUKsE8su/nvZ5+WJPA+BDhe8i+/ADSH55XOo
Oc0yTHNMAT7DbCqqrHxwbgmljTeN8ESbwHhFfLWTabwpw2X25Fav5p4KHy89ICnM
zzRtJ+XiHCPZ4ue8GEDgJ97LOSxCrtqyzDXIQ+AcMp1hLcMP4NNST8drd9dSu0Bx
COTlEmtweN4Y22AeNRHxQaTOFwWxdw4IqGK8isDAq66c45EZIAqigYmmXEj7E7fb
nD/3fuJAUjXSoAKusqiEL5WDl6WBhkTRPYGzfVQdLTkjRJvE07Opqscq0L7xJRh2
TPoagtVIAdK4wx/OrJ/Hw6w5ve9hQVpqYdJQUUQqZFAm1xIaJ6KUzVLxTmXuMIrS
FaVsnxCbO1nTRGVL4r3uGwjcNt3N+tFMLDHmsJcQ9EKGIZ1Vr7ctz8DvsktoK31P
WkxJWpl6kAhjgAyHj4zfoBpR3AzTeNVefcOOIBpH1AxDkuYJsG0=
=NXuf
-----END PGP SIGNATURE-----

--OiITrshLgfui8fEl--

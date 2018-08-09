Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68881C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D58521D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6t4OONq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D58521D68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeHIOMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:12:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37495 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:12:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so4887385wrr.4;
        Thu, 09 Aug 2018 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKFXJ6E1WYzDuuN/JoitFYZICIJaXUklrpODlayrIkA=;
        b=j6t4OONq0WJry5MnT6C3rCfhOCLpwlAfq5ciJWDkkSF73pyl2TxOQcVWvHQweClisK
         d8sonSsDpknH6cnPyb4fwNTCB74jNPl4zmpETHau/+6FhTDE0JwasDFG6gB2JSKRDRf/
         GgYfOKLUfnrFXgq12IiSeOWTEfbiLExqIj/B4eP9yovRye05HBUqcCbS0+CDbNOmYix7
         LiVSt94KjDveUVcH0gFG1IQ+BVWRHQlNhiDdShNg1c+SR2S6XcFp6iFlxqoQERQkUelM
         VQiPvcHqUyTXET1hMaPD0Qm76BnNuc8eYl6FEd9nzHfvcBO8vlYHtdUEhgDmMygB9V5p
         pP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKFXJ6E1WYzDuuN/JoitFYZICIJaXUklrpODlayrIkA=;
        b=ehPgnyzPDuqPbkii6arHnf3mQTLs9ZxL6APmu5cWKq4RVINwwV530pkhcnrSgcrEp4
         w5zHyfNu3nIeV9v+WA2c5ikpfkib30AdWtnww4FszUFjfN7iLjKKZFaoQvIcaOBhxJue
         mY4l002XAPzr0zEKnJZDdr7+pcRbqHNw+cJRi5swbkL1bDm/Yuagip4WSdhdHgZZ0HPf
         eRxFZsRoMrqStoS4BuDOZ4scdDW9+oYeh5VfIFdTbbrAaxdxol8Ui0LBuPJ59EBN1ybs
         8YhRc0K3yz9J171ap7thDJZQfWLs3pkjDpnarhddPZge4Eebshc2w4vnscXxyT/1imF4
         UtSw==
X-Gm-Message-State: AOUpUlGo9rfCLH1gMExNfSObCoi5j+5ZUreRUtfcDAbTigtUTcz7EGe3
        IkPHOnLmL2/LNZbGzIZ5o3PszoIE
X-Google-Smtp-Source: AA+uWPw1jo7Kx7qrUNSN9lS+LkA3/vdMJscBp5AeDk2yyU2EEG3rytV00HvWJL9fBw+viBOraKIzxw==
X-Received: by 2002:adf:a907:: with SMTP id u7-v6mr1229158wrc.175.1533815287111;
        Thu, 09 Aug 2018 04:48:07 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id f8-v6sm8286447wrj.9.2018.08.09.04.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 04:48:06 -0700 (PDT)
Date:   Thu, 9 Aug 2018 13:48:05 +0200
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
Subject: Re: [PATCH 4/8] mmc: tegra: Implement HS400 delay line calibration
Message-ID: <20180809114805.GM21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-5-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
In-Reply-To: <1533650404-18125-5-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 05:00:00PM +0300, Aapo Vienamo wrote:
> Implement HS400 specific delay line calibration procedure.
>=20
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Should this be before the previous patch in order to make sure the
calibration is performed as soon as the feature is available. This is
counting beans I guess, but it is technically possible for someone to
get everything up to patch 3/8 and then get the corresponding changes
in the DTS files to enable the mode and then have HS400 enabled without
this calibration.

Thierry

>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index d81143b..d0b68b7 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -56,6 +56,12 @@
>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
>  #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
> =20
> +#define SDHCI_TEGRA_VENDOR_DLLCAL_CFG			0x1b0
> +#define SDHCI_TEGRA_DLLCAL_CALIBRATE			BIT(31)
> +
> +#define SDHCI_TEGRA_VENDOR_DLLCAL_STA			0x1bc
> +#define SDHCI_TEGRA_DLLCAL_STA_ACTIVE			BIT(31)
> +
>  #define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
>  #define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
> =20
> @@ -584,6 +590,24 @@ static void tegra_sdhci_set_dqs_trim(struct sdhci_ho=
st *host, u8 val)
>  	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
>  }
> =20
> +static void tegra_sdhci_hs400_dll_cal(struct sdhci_host *host)
> +{
> +	u32 reg;
> +	int err;
> +
> +	reg =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
> +	reg |=3D SDHCI_TEGRA_DLLCAL_CALIBRATE;
> +	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);

Is this self-clearing? Or do we need to clear it manually in order for
a subsequent calibration procedure to succeed?

Thierry

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsKfUACgkQ3SOs138+
s6G9MQ//QdjtfxfjkrmCbxq8Dr3mrsjX03o7Ttvkc5lnKy8OEFDf39wCEsM3ftEY
ibBbCDxaEy72T4324+oPhQnHDBeT8Is6yNiKRfeA0Zp1zkyruPZW9B2wbSQ575tB
mGq6oX6ePd0+C7Ok0NGL14wmZV1EL0ZPTQpZLmGEwUjXn6MyHG3jY5VuUGmedPyl
ExpMQ0EE8Nw+HECTdJlZYaIntjTkhDTrPGO4xDLA0VOXrlF8zCihsZf7UiRsHxP8
2dmmL9u1ul9iPwpKrbhD7ycfnKfDtwGoCNRLzvgN1Xx8vKYuUv527HmmBaGOJiYb
eu6AaiUXQtZ+8V6hqurK0p9/CZvukLXdbNji4EuNdgJHbXy9BBTNYlaCiMCnBzoq
4dfmQHxO/vDDNx8EPlSvNBOblAkfanI7p24LWDcl+BDXT5RzJvmpeYZKTAx46vQ0
+tJHrZYOO9axSo9xgKNXUKa1YOUSgqHUmSJXL0MqwjcHFjJYxdrwF/crf3ksmdqG
hjd0wwnw1Mdc36sXYQjQDQCtl08qhjkQzzDxvRtd7k4oe0TF23Y1LezJ/Zc4oR/G
r72ubrAmPjvajsExNo+MLY+mczYEfc+clFqfbjoR9UezxSQfihSQQIcWZku6ZDRY
fNkXCXTg/eWkJYbZmS+1H3mmyJeJdgWyAxX/hSa4RCsXa+Zp9Eo=
=t5sc
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--

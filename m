Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0356320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiURJuWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0356320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeHaSKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:10:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51716 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbeHaSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:10:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so5381413wma.1;
        Fri, 31 Aug 2018 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sB4fWB0w96aNY0DLkKjnOv/zNNU2pgh1Er3JUbFmsis=;
        b=OiURJuWcqfZ/TbGwJg5KgNWgpUCRsOIB7YQMPbl71sC67lpVIBAGNrgQa1QRc8zlGl
         sE6SzedtMVnSxey8fRD6ttbMhzDHAbyXxyr9vm0jfHkWAdwuxOqgTV/aoNCEazsCVHQU
         IklLFQICr1iku923RTsI1dNQzf9TwbVwwHye3JVJFU+k69ZTxUONsbPVWkj+pdvl6CEu
         TLiY/rzt+uO7C4ovNRJs8OS6qOWfVRY4LAIri3pxCN7M6ISuNAzzblrCMqM26LZt78wm
         hkZkpWqQWldhmkPhZLCpFTKkLoxPRcIuxCJYr2ANs9ioBR2+OjgpS1HaicGdSc4K1x5O
         fR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sB4fWB0w96aNY0DLkKjnOv/zNNU2pgh1Er3JUbFmsis=;
        b=IFnXd0UMQMc145MAQhqEJO/PUllgxTxipo6wECaQVPkczD4pjoPp7JTW784EW/PBwl
         2kdJE2X/oGjwM6kiFkxJhcm2Wuh1X2X+rHvU9FZdXy5XGrBY4LExiZA9oFvSq4SvU+Td
         EEP5PQnWuea70+FUbbjldGEaUKviv9Sfn+Jolox7LccQOcaih4mDb6F1FtuQA+ZPeE04
         6INkX5hYemAZUZAiqlfuC59jamt4VaWkjUX+5wEblYt49nIBl75AnhFT17w1l9WmRK9L
         dJwEragxqZ71GR5jPp9BXNpIFQU4hMxk7Yy/yy9kZ8yPoWlouDLgs61GYK9r1AM0T1Vx
         ZEew==
X-Gm-Message-State: APzg51C+w3zUJkWcVTyUh/UEhwLyJx99pYA63qEvq6zBJtCqMDFmpsi7
        azOgC2FvMwGqfbSn7Ywq9dc=
X-Google-Smtp-Source: ANB0VdYx+S0VRFUzen2BOv6yoRdMLa9L7ieweyOQ+BGe4GJRTtQ/kt334Co/QF8emkd4T+CMjTKtVg==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr5178888wmc.27.1535724143768;
        Fri, 31 Aug 2018 07:02:23 -0700 (PDT)
Received: from localhost (pD9E51F49.dip0.t-ipconnect.de. [217.229.31.73])
        by smtp.gmail.com with ESMTPSA id h8-v6sm9999034wre.15.2018.08.31.07.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 07:02:22 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:02:21 +0200
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
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Message-ID: <20180831140221.GC7926@ulmo>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 09:13:57PM +0300, Aapo Vienamo wrote:
> Hi all,
> This series implements support for HS400 signaling on Tegra210 and
> Tegra186. This includes programming the DQS trimmer values, implementing
> enhanced strobe and HS400 delay line calibration.
>=20
> This series depends on the "Tegra SDHCI add support for HS200 and UHS
> signaling" series.
>=20
> Changelog:
> v2:
> 	- Document in dt-bindings which controllers support HS400
> 	- Use val instead of reg in tegra_sdhci_set_dqs_trim()
> 	- Change "dt" to "DT" in "mmc: tegra: Parse and program DQS trim
> 	  value" commit message
> 	- Add spaces around << in tegra_sdhci_set_dqs_trim()
> 	- Make the "mmc: tegra: Implement HS400 enhanced strobe" commit
> 	  message more detailed
> 	- Remove a debug print from tegra_sdhci_hs400_enhanced_strobe()
> 	- Add blank lines around if-else-block in
> 	  tegra_sdhci_hs400_enhanced_strobe()
> 	- Use val instead of reg in tegra_sdhci_hs400_enhanced_strobe()
> 	- Make commit message of "mmc: tegra: Implement HS400 delay line
> 	  calibration" more detailed
>=20
> Aapo Vienamo (8):
>   dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
>   mmc: tegra: Parse and program DQS trim value
>   mmc: tegra: Implement HS400 enhanced strobe
>   mmc: tegra: Implement HS400 delay line calibration
>   arm64: dts: tegra186: Add SDMMC4 DQS trim value
>   arm64: dts: tegra210: Add SDMMC4 DQS trim value
>   arm64: dts: tegra186: Enable HS400
>   arm64: dts: tegra210: Enable HS400
>=20
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  4 ++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  2 +
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  2 +
>  drivers/mmc/host/sdhci-tegra.c                     | 84 ++++++++++++++++=
+++++-
>  4 files changed, 89 insertions(+), 3 deletions(-)

For patches 1-4:

Acked-by: Thierry Reding <treding@nvidia.com>

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluJSm0ACgkQ3SOs138+
s6G42w/9FFECWR0d1VfPjK22NxVRpLNi0S8yD9l63nPrfpgape2cpCFscZPIs6m/
DsbobOqn/5MDiRDeG5NAcYtYyjeiedCXDFcP42q3qw2HRuxtHew9MoX0JAa0VhtO
dCGy1uueuOjmoPJNh2S3JWNbCrRipyXmRPbb4sAGWPoXEh5+qqxfbC8A+NFXwfTZ
5VgdnJJOuIAWpw60iV9Lpn+RroIOUCY3mQL0rbGcctT6afWtGdzCh5JHQosCQhIg
Ijc2a2g97MyUjhP64BSKrrQ1XueVoC3tvrz8sj7JUo6iwZwscNMuEAny+V5omCkh
7BgPTlDpH2bJ+7tgRjjulvvuzNsAmOWxCojTpPwOBpM32GdL+BWPTjYPYKh7o4H9
0Fjn7G2Oq1HZPgxpGwLgn9XYUhCt0kE2XYgRdaObGiLBlUH04ubrtfHiYC2yo60P
Pq/b8FATrwe7twgOn7vDTQABNZuJ8lkN3F1iFgkfRvymoR1K6hPb4RWiMijffH8i
vSXushblghKfZRqUiARC6g0hSVnMd/A9T87aFPcymumlgWGtt/mR7MoYP89fgT7W
X7asGvLlEWMgQGimnJ9shxAEEzVRWsF09/u1PmM3i2g7BuhuRQhBR9XHxmQH/kMy
2mmo+SmTM4l9zQdtJLY3hP6Vt5LdqLYNuPUpMSigiAa8EPsaQ5w=
=/mTD
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--

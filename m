Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDCC20891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9S1aa0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDCC20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH0Nya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:54:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36411 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0Nya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:54:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id m27-v6so13072191wrf.3;
        Mon, 27 Aug 2018 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4xgDO+/FTBBOMviU+hR99ZTDXPK5aMLk4QITUPViKYE=;
        b=S9S1aa0B6ZC2ejdmiEEh9buwm/pVHDzogbrdm+ZPkNynoG5liz4jEUlwvPdE03tMVR
         SbuTyS5objZsFgVWCEWf+HsCoYfBGqTaGP0RXMw6IvE+rCvAveSf3OKFNxbZOPeiPPXB
         PJFxGBTsqGffa5cd6mZM/T8MkIq/YfjURQslwKZRxtNVQLn/qebeM+pa6UWAmVjAyX9m
         Xxtz+AJYhtTvkeWPYQe1JJEPplD9vxheGHE81MvH85THJPqMt0ZDSuo5DvWt7UdAlZW+
         YcEbMpB0w6z5XGrObUuSJaYFfiN8TaNwJ8EctVBKgMSfG8DgSbGV82c6ISLZrWVw9UpC
         G1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4xgDO+/FTBBOMviU+hR99ZTDXPK5aMLk4QITUPViKYE=;
        b=Sq01uM4JE72OZX+0b+iC+7l3ZoD8lWMNy4bKjFXnkn3HRYgHip/fkBYAWGHW/+csTL
         DkF5HW17cg7r/p5qsZnkdA/5u5gVGxc7d+7OeaeJ/KtFJTpRaqC6Na36lU6PNrkOkvIZ
         OIel4tstfgvCbiUjfojEqRmi4uxzuyBa3407+3khyiD+/ymM5d+IZXk1lT1zdb2ehQLk
         do2vJ3E3yapEO7xHhsLQZpNIB0jkVKYCHH8ldkEnLlIaJjtxU/7GDbp6HyvaIC+oR8tP
         U73i9Bx3rosa7pGJG5vH/x6REuOEHHevyu7Dw8trGwsgK5QYvJxfZ+VjR8+zwp4uJ1uQ
         Y0uQ==
X-Gm-Message-State: APzg51A0IVs2Fzv3K4snKSNhnH0P2+zl5rgA3Z38tUeUOfg9ehHH1AT7
        5z+XPzfBfmo2M6qKb+afoOI=
X-Google-Smtp-Source: ANB0VdaVnXQy0tC3CSkHaBx/D4RMOwWk5Cxsm1Ok+LzMpjK7esDLZhEG6611B14H+0AQHolCoJu4Dg==
X-Received: by 2002:adf:b3d7:: with SMTP id x23-v6mr8073864wrd.253.1535364508643;
        Mon, 27 Aug 2018 03:08:28 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id r6-v6sm11073718wrt.92.2018.08.27.03.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 03:08:27 -0700 (PDT)
Date:   Mon, 27 Aug 2018 12:08:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Tegra SDHCI support HS400 on Tegra210 and Tegra186
Message-ID: <20180827100826.GA18542@ulmo>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
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

Adrian,

any chance you could take a brief look at these? They are a prerequisite
for the 2-patch series ("[PATCH 0/2] Tegra SDHCI rerun pad calibration
periodically") that you already acked.

Thanks,
Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluDzZgACgkQ3SOs138+
s6H3hw/9HaeWCaPSJbgLBGq7COZn7QIwSefhS9Y6LS+y2WLqTHEG2BP2egIac67T
U8oUBCJXRQMUgoxVD2xppMS7jATTSo+DtMJ3kmIKoPfu0PNj42Cq55aOmZkxUlGc
N7PgbmFvrZm0/3jIRvJWUgQpplQsanqeFrY718rja9FwjEsArFmWhTg6QIEslfP6
+s18OrV3iYnj2ULr+DxIRua53LoGy2w90KhXvUmCLncTG9EZ49NyDlJB0cYWdVHX
x1yQDW6FHD6BgZGqjO8CqQ38H1fyLFzW66nkewSPvrJGTC7ySZS4HB/GQzkPher3
xb8ETt6LMgXV497wr/acnF65L3dnV85szaVCO9Xuqy7ugf8TmcpyvkA8mZ8FWrea
Nmhvuz1QSGIvGG5QytJxoOxe4Smmjuc4Zw3AidkLbaNMq280LVOkj0kkFaGbXHxm
rX6Q3fNm+jIu0gI0Pqojoj7RX9J3I/LeWC2yvSGZDZ0l39IbVR2aedDyRwFM/Jj7
YiCK7vkqMofsq5NZ2luhSFIb3YCDsXK/1hTfTzl/YB+u0Ff7KbwDa2ArD88FGAxu
5Om0Npyb0D2AYfnLBMHfQX3Lp3B1e3p1SmIXtJLG0U0BIqIccjlAO8SLD8j9xrrY
O3c0SxJNMijN6EJwi6J1TAbxttEGWTFsolHhLUL/R9o8GQPeegA=
=1iCJ
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

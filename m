Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6361C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CD9208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQYhUFXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CD9208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeH0N4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:56:42 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51752 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0N4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:56:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so7524311wma.1;
        Mon, 27 Aug 2018 03:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WPhHWamVBPkKTj96NIAS1/6NaEowmCOS1qtw5kD2dH0=;
        b=nQYhUFXJt1fp/u/6D88OgdUmWN99LM2tfQ5VPlHTQ4wppw/wYazUsAq6D2GoVF9Mm4
         jBr3VWXj6ix4Wnlb4Mtk4tmDx8FLRwkAKAJ+bhBY94Vr2TjnuCOWZXsBKwzo3MaXxGlc
         ht3cLySbxrKij3m2ou0GUClZk1yvM1DpWCKQDJlfSNh8Lg4ld+borPEqTWtC8PDjDSVp
         X6cFl8zgrhZn04O4zp+XLq7zS9tBv82ClQ6jLQZZhTHOLc/XKJswGKOJ3wm2viO4XnXK
         Cq1G16mCq5Ba1Zx94kwFpD4umTeEO9l8oVlf+TwjhP5xODYpGoD/fiWLB7pj8sICw4+x
         QVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WPhHWamVBPkKTj96NIAS1/6NaEowmCOS1qtw5kD2dH0=;
        b=Dg7LeUGDOsrAOCha2glnlqLp/qs3dTiAvyAhJda802t1IRHon7Tb9B9PD+lzfdXRUt
         0hlFCDlBFdJa3GGpa2HLPgiJ9NTsaLK2BDv0RN1yzCFmM8oM8QOYpT8TKZmAq9pRJGtx
         KLZXooGWxY/ubL3G64UsEGcAyanOBtKlyNON3frSNokG5rKSYs28Gb8MKEbxWi27/9JL
         fHjEMUwGJpvi31o8EtRTjkfSsloDHnPhYiYd2PezxBJws2w39l6IzjLaBclV0qnoj/nu
         r40gWT+n6bWZHAptIw+CD83GwTi9YVO4iJynx1bejEm+MMwLup5CD+1+wbopqLjvlkqi
         /9Xw==
X-Gm-Message-State: APzg51CXIILIXqBfiNIpGs950biMD7Lljcqfx45Um8gfE53CmZ94tK2H
        +unwtTUtu795CZbYXP/m6c0=
X-Google-Smtp-Source: ANB0VdYLXMSUSPc+nrp8FsTSpwfqFFVWGcDkWjmaoqzKgVuglmRkLxARKRuScZBxlKsWEwTDyjapzw==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr5612481wmf.114.1535364638040;
        Mon, 27 Aug 2018 03:10:38 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id o19-v6sm13348355wro.50.2018.08.27.03.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 03:10:36 -0700 (PDT)
Date:   Mon, 27 Aug 2018 12:10:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS
 signaling
Message-ID: <20180827101036.GB18542@ulmo>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 09:08:02PM +0300, Aapo Vienamo wrote:
> Hi all,
>=20
> This series implements support for faster signaling modes on Tegra
> SDHCI controllers. This series consist of several parts: changes
> requried for 1.8 V signaling and pad control, pad calibration, and
> tuning. Following earlies patch sets have been merged into this
> larger set: "Tegra PMC pinctrl pad configuration", "Tegra SDHCI enable
> 1.8 V signaling on Tegar210 and Tegra186", "Tegra SDHCI update the
> padautocal procedure". Also the patches for enabling SDHCI tuning
> are added.
>=20
> Changelog:
> v2:
> 	- Fix grammar in PMC device tree bindings docs
> 	- Remove a stray line from tegra sdhci bindings
> 	- Cosmetic changes to PMC pinctrl driver
> 	- Fix a typo in "soc/tegra: pmc: Implement
> 	  tegra_io_pad_is_powered()" commit message
> 	- Declare mask and value on the same line in
> 	  tegra_io_pad_is_powered()
> 	- Move the call to tegra_sdhci_is_pad_and_regulator_valid() to
> 	  inside the if condition in tegra_sdhci_reset()
> 	- Use usleep_range() in tegra_sdhci_configure_cal_pad()
> 	- Move sdhci_writel() out of the enable if-else body in
> 	  tegra_sdhci_configure_cal_pad()
> 	- Add a delay before starting polling in
> 	  tegra_sdhci_pad_autocalib()
> 	- Use usleep_range() in tegra_sdhci_set_tap()
> 	- Rename orig_enabled to status in
> 	  tegra_sdhci_configure_card_clk()
> 	- Fix if condition wrapping alignment in tegra_sdhci_set_tap()
>=20
> v1:
> 	- Probe the regulator voltage capabilities to determine whether pinctrl
> 	  is needed in tegra_sdhci_r eset
> 	- Don't remove tegra_sdhci_voltage_switch()
> 	- Use dev_warn() in tegra_sdhci_init_pinctrl_info()
> 	- Don't change start_signal_voltage_switch callback if pinctrl info
> 	  invalid
> 	- Only call udelay(1) on enable in tegra_sdhci_configure_cal_pad()
> 	- Add nvidia, prefix to pad autocal offset dt props in the example
>=20
> See the original patch sets for earlier changelogs.
>=20
> Aapo Vienamo (40):
>   dt-bindings: Add Tegra PMC pad configuration bindings
>   dt-bindings: mmc: tegra: Add pad voltage control properties
>   dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
>   dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
>   soc/tegra: pmc: Fix pad voltage configuration for Tegra186
>   soc/tegra: pmc: Factor out DPD register bit calculation
>   soc/tegra: pmc: Implement tegra_io_pad_is_powered()
>   soc/tegra: pmc: Use X macro to generate IO pad tables
>   soc/tegra: pmc: Remove public pad voltage APIs
>   soc/tegra: pmc: Implement pad configuration via pinctrl
>   mmc: sdhci: Add a quirk to skip clearing the transfer mode register on
>     tuning
>   mmc: tegra: Reconfigure pad voltages during voltage switching
>   mmc: tegra: Poll for calibration completion
>   mmc: tegra: Set calibration pad voltage reference
>   mmc: tegra: Power on the calibration pad
>   mmc: tegra: Disable card clock during pad calibration
>   mmc: tegra: Program pad autocal offsets from dt
>   mmc: tegra: Perform pad calibration after voltage switch
>   mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
>   mmc: tegra: Add a workaround for tap value change glitch
>   mmc: tegra: Parse default trim and tap from dt
>   mmc: tegra: Configure default tap values
>   mmc: tegra: Configure default trim value on reset
>   mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
>   mmc: sdhci: Add a quirk to disable card clock during tuning
>   mmc: tegra: Enable workaround for tuning transfer mode bug
>   mmc: tegra: Set SDHCI_QUIRK2_TUNE_DIS_CARD_CLK on Tegra210
>   mmc: tegra: Enable UHS and HS200 modes for Tegra210
>   mmc: tegra: Enable UHS and HS200 modes for Tegra186
>   arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
>   arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
>   arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
>   arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
>   arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
>   arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
>   arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
>   arm64: dts: tegra210: Add SDHCI tap and trim values
>   arm64: dts: tegra186: Add SDHCI tap and trim values
>   arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
>   arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
>=20
>  .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |  93 ++++
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 103 ++++
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          |  68 +++
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  74 +++
>  arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |  12 +-
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   1 -
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  55 ++
>  drivers/mmc/host/sdhci-tegra.c                     | 556 +++++++++++++++=
++++--
>  drivers/mmc/host/sdhci.c                           |  21 +
>  drivers/mmc/host/sdhci.h                           |   4 +
>  drivers/soc/tegra/pmc.c                            | 511 ++++++++++++++-=
----
>  include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |  18 +
>  include/soc/tegra/pmc.h                            |  20 +-
>  13 files changed, 1324 insertions(+), 212 deletions(-)
>  create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h

Adrian,

these patches are also a prerequisite for the UHS signalling changes in
the other two series that Aapo posted. It'd be great if you could take a
quick look and weigh in.

Thanks,
Thierry

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluDzhwACgkQ3SOs138+
s6G5jA/9HpMCkYUvtpab6RfEGNR3+8EWDEKJTzhJbY3/lkPRS53iPni/GWj41Pf6
GZBVffsYXMY3DN8Or1De4/1VDxdbN0j1eQbXtMIRw/4ZRuuEcfKeQGy4ndKKgX3O
6QPWolvc4KLuERlMdBSg4kT69zoDHk4Ozwha/q7VH/7Wc2+OrwhyP9pOgDS8vQw9
0jgPxw2E/4vNdb7cfhRCzlb+5RhKmmlVFyGScYU0hKff39+S980rVqhtk/yfSXZA
uUxceDuOYqopHUq6Te6/HJaYhaHoQjOWS9tQTP5uq9ZyPLBFNbd2//8c7Y0RqM89
6GkjoRXZUzS8xNHPxUCI9NS9P321qBzuCZNW9A87YZZBSl14thP0zh14YsFl1m6L
LI4b6josbfYkufYkefWAWPdvzCebXuU5JyyDwpt0wt4KfFlzsaccZG+o0R9xc3fO
RTkSvDSaX8gLNefCM2vjWTQi+LDM6xvRcCCvwtmyAGWWtImIfVvTp1q315QzbfxS
X88Yyu9KpHCslq4zcD12Bfu/WCPIMCiLs7gLI7Oyb6jX6DIfaJDB4Gv00zGdIwej
MOHMVRma1f7dKNbamWaCeFmEVshrZwQtS3mze4zk3Lad7jfJQMO8DFhonApffn+z
zPPkZoQZwCDs2htchKJp+/rk/EGKqr9ALJlHuSjfhGHug7O5TZY=
=CECx
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

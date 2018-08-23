Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E30D2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkxkd9bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E30D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbeHWMPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:15:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38116 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbeHWMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:15:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so3914286wrc.5;
        Thu, 23 Aug 2018 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cUD+PKCGb7jheyPDpVVJrVCUkkmlXGikBEVjuDOJ3+g=;
        b=fkxkd9bGJGmytrATjYjubDaSOpnusetDXi8KsnQ6uBHAJB3fDgp93S9xkndbZV6AAJ
         We987NCB+doTAyWbaQtS4cjfgMI6hawysQQP5FqEklwOau5jA71yl1TVRFOwCapkdZ8U
         qtm3aQ1BySzVxMSXLvLsIN/07PB+kbDioixg5OhUCpbX6jf7o1+IdsG8nbbPrdmhFKtS
         hUfmZNwD2BBHugl62dwfWs+UZ4/+un3jUgaZ1x2j84z/hv82Ur0qpkFGpMQKS2/WqAI2
         JEC6eSnof6Z2fszX4mUkzBGGqXI9a0lJiceuur6AvVgLrOyw8XbY8RqSJ0H1QZjaTR6E
         elZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cUD+PKCGb7jheyPDpVVJrVCUkkmlXGikBEVjuDOJ3+g=;
        b=otcM3MCCKoqR2KBQ2a/TNViT9ycrBn0ZsdntItlpCXOeuq2X3HjE8+4U9tkIhmjo+6
         f4LrC0OUqLfN6uO659ifknaDIHA5OBBvxZkJ7R/zanlDqxhHdBPED1iQlqZgS78Z/Ekn
         N2I44aq3JcAq8f0mnNAh6xJ+1KruP/x4BVZCYEJiX8aYAitNCSNX4H15yNJtUUeIt5q8
         UERy2SOGLbxLC8e7aUlakJIvw67S09zLg/hJY4LO+zWGgVrYe0sl95ixTLhk2vSstifu
         8HoMUVyk1FfSgO/39H4yMHBuIyE1i0vV5Fi/T3h6AxTRtnFJxAwbuff9MfUuGruLyHJd
         17qw==
X-Gm-Message-State: APzg51CCbpoVbWRd4dxeDOz7HYsRN0N1DgpxZySVUAQCBFvzsKozlY/a
        E6X1GHJEyICx6Pytfxl4++4=
X-Google-Smtp-Source: ANB0VdbEfs7Zxi0Rjmrgk7Z2Uruqy51iJEW59oG+S3u/GjQHjjL3WY9oIp683ZpLcVNTtYZn7/Pd/g==
X-Received: by 2002:adf:e846:: with SMTP id d6-v6mr16295714wrn.269.1535014027314;
        Thu, 23 Aug 2018 01:47:07 -0700 (PDT)
Received: from localhost (pD9E51C80.dip0.t-ipconnect.de. [217.229.28.128])
        by smtp.gmail.com with ESMTPSA id u1-v6sm2836674wrt.59.2018.08.23.01.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 01:47:06 -0700 (PDT)
Date:   Thu, 23 Aug 2018 10:47:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Aapo Vienamo <avienamo@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 00/40] Tegra SDHCI add support for HS200 and UHS
 signaling
Message-ID: <20180823084704.GA28696@ulmo>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
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

Hi Ulf, Adrian,

I've been running some tests on this on various Tegra boards and this
all seems to work fine. I'm also pretty happy with how this turned out,
so the whole series is:

Acked-by: Thierry Reding <treding@nvidia.com>

In order to get this merged, I think it'd be best for you guys to pick
up the MMC patches, since they are all independent of the rest. There is
a runtime dependency on the PMC bits for the faster modes, but things
will fallback to the status quo if those bits are not enabled. The only
dependency here is between the PMC and DTS changes, which I usually pick
up into the Tegra tree anyway, so I can sort that out there.

Since I've already gone through the process of splitting up the series,
I can offer to rebase the MMC patches on top of v4.19-rc1 when it's out
and send a pull request for the MMC patches. Alternatively I can further
split that branch up into two parts, one with the two patches that touch
the core and another with the remainder, if that's what you prefer. Or
you can of course feel free to apply all of the MMC patches yourselves
with my above Acked-by if you want to.

Any thought on the above?

Thanks,
Thierry

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlt+dIYACgkQ3SOs138+
s6HBgQ/+LNk9y6KpgR/vb4jhvXJSFL/o55wBlqhQB9kYXq1+2pRLyzCObtcl8sgX
3Uk8uZfWAEjmlWL4nW4OETcezHvSWNtYG6stIbIy0ZSLrMmvy/yy3BZkzdWbDOj1
xvpias4n/FZLVPyUWjG+JVudZx61EyP5ll0FlYrRLYmDpwrB3JL1K6Bj9TKurdxe
/HJumGE1UX/TQaScoAkU43onDMP8s19T+k/IXH6w/oguch6XN3Znm0e/aBRswKyN
B9q2XKR4+T285qX/ChjY2ezKE7awez9/2+0OHTR+sCq1Zjlwp86ToCqExlqyKwqS
It+UPn6c9nJAbw/VfATh6wPvNhrbyBZv5rJNmqVac+FaufuHvak7VaFyQ5YI3+Xt
mlaW6xAcYg+mqVTlFODWpNhDupIPHMzhmOa6HIkFjJvuaEUuVBfH/SHkqmIC74de
VBOpPikF7pCog5ygEYPZie0r6rga4nVJgysauxTRwjn9xkcnl9uH4PdAm3fVFpf7
W9gU+odEEllf8NJapITkAwHzAko0mBdz9o8f5koL9KRPDU9mpgcbupmDNHM2JpJt
yaDSg8+cXQo/aCue/Nt5ocbfzbvvD0CrUq/SsYFnLvLrXXywyyHGfh526Ryor7Li
p+ySNKlGCK2qyFvPCZqJHZpZ9TYtie7RSleYd1NwXjpWI+fMHT4=
=83Da
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

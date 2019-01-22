Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82234C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A3420854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpCbK8gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfAVHsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:48:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33855 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfAVHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:48:20 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so14187625vsi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 23:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBSv6Zh7MQQRKL8U8lTzL9C2kx61Mmu90Iox/dZMTjM=;
        b=YpCbK8ggWSSfdU132j2a66DRO1F95k0ZuMQDOYnFfnD9QTVsVSpx2Hie2bSs99Vc1T
         U8PoPfwkms/5U9HGiFxG0WQ93i82Bh6FMqVSEjbDeezprLfLr96yBAUt55yunxNJN+2O
         PEYsLke6eOzPcrcW5L7NG8VLvtA8fnZbtufx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBSv6Zh7MQQRKL8U8lTzL9C2kx61Mmu90Iox/dZMTjM=;
        b=B6s4EfmuoEZkZqcJmyewpQOTIzERgpPGhkH9Gkti5Z3RQaLh25thbIs3jkvCdcPMyh
         pUL2eogbndRRVFO5b/01b6c5J9gbG+aY/F7zWiZQp+dpaKAV24GFdvNnz8XhHv54lbaQ
         w7HGcRix5hFQ0PWoe58A8K3+VlgNpiWVwZFHW8kqspMwXk3s3VM5wh0a69FJ7oUQV1+Q
         UYMX2n5DymQDlJCQkuPHKVp1Cz7z9mqrYaQfYbVRKKODCKg8SVWEbDlYLRQkpY+zXAxC
         YrXwSzQCqqaE+LWx0EWCwYr/5KErYk6EeRbzvXaNhTDrWqSXY1OxpY/D5AO2qD+nNFfR
         Zbkg==
X-Gm-Message-State: AJcUukfoKbHvqG4KoNpkn5rEJNZ+BuMqBfDnGgGMVRUu4jv+iTB9TpuA
        8Vz3abZnWpSqhBo7+dRttaLayASSmWUn31mQpKZo/w==
X-Google-Smtp-Source: ALg8bN7FAPfNtEbP9KOzhhU63w6cp4tTCe+9JFPwTKRl8AOIRtMVzdi4XiiMQVzTlfKDY9DW9cnDuVBG1HEhyA9H3o8=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr13608226vsi.191.1548143299216;
 Mon, 21 Jan 2019 23:48:19 -0800 (PST)
MIME-Version: 1.0
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com> <1547160363-25323-2-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1547160363-25323-2-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Jan 2019 08:47:43 +0100
Message-ID: <CAPDyKFrBE6k1HfTU8wH-MxyMe9DXB++161qabixJx2fJ5AgHMg@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] arm64: dts: tegra: Add SDMMC Auto-cal settings
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com,
        DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 at 23:46, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Add SDMMC initial pad offsets used by auto calibration process.
>
> Add SDMMC fixed drive strengths for Tegra210, Tegra186 and
> Tegra194 which are used when calibration timeouts.
>
> Fixed drive strengths are based on Pre SI Analysis of the pads.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

For clarity, I am leaving this one for arm-soc.

Kind regards
Uffe


> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi |  2 ++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 34 +++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 57 ++++++++++++++++++++++++++++++--
>  3 files changed, 91 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 22815db4a3ed..169aee59ceac 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -315,6 +315,8 @@
>                 nvidia,pad-autocal-pull-down-offset-hs400 = <0x05>;
>                 nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
>                 nvidia,pad-autocal-pull-down-offset-1v8-timeout = <0x0a>;
> +               nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
> +               nvidia,pad-autocal-pull-down-offset-3v3-timeout = <0x0a>;
>                 nvidia,default-tap = <0x5>;
>                 nvidia,default-trim = <0x9>;
>                 nvidia,dqs-trim = <63>;
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 6dfa1ca0b851..596a36705c0f 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -303,6 +303,17 @@
>                         clock-names = "sdhci";
>                         resets = <&bpmp TEGRA194_RESET_SDMMC1>;
>                         reset-names = "sdhci";
> +                       nvidia,pad-autocal-pull-up-offset-3v3-timeout =
> +                                                                       <0x07>;
> +                       nvidia,pad-autocal-pull-down-offset-3v3-timeout =
> +                                                                       <0x07>;
> +                       nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
> +                       nvidia,pad-autocal-pull-down-offset-1v8-timeout =
> +                                                                       <0x07>;
> +                       nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
> +                       nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
> +                       nvidia,default-tap = <0x9>;
> +                       nvidia,default-trim = <0x5>;
>                         status = "disabled";
>                 };
>
> @@ -314,6 +325,18 @@
>                         clock-names = "sdhci";
>                         resets = <&bpmp TEGRA194_RESET_SDMMC3>;
>                         reset-names = "sdhci";
> +                       nvidia,pad-autocal-pull-up-offset-1v8 = <0x00>;
> +                       nvidia,pad-autocal-pull-down-offset-1v8 = <0x7a>;
> +                       nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x07>;
> +                       nvidia,pad-autocal-pull-down-offset-3v3-timeout =
> +                                                                       <0x07>;
> +                       nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
> +                       nvidia,pad-autocal-pull-down-offset-1v8-timeout =
> +                                                                       <0x07>;
> +                       nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
> +                       nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
> +                       nvidia,default-tap = <0x9>;
> +                       nvidia,default-trim = <0x5>;
>                         status = "disabled";
>                 };
>
> @@ -325,6 +348,17 @@
>                         clock-names = "sdhci";
>                         resets = <&bpmp TEGRA194_RESET_SDMMC4>;
>                         reset-names = "sdhci";
> +                       nvidia,pad-autocal-pull-up-offset-hs400 = <0x00>;
> +                       nvidia,pad-autocal-pull-down-offset-hs400 = <0x00>;
> +                       nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x0a>;
> +                       nvidia,pad-autocal-pull-down-offset-1v8-timeout =
> +                                                                       <0x0a>;
> +                       nvidia,pad-autocal-pull-up-offset-3v3-timeout = <0x0a>;
> +                       nvidia,pad-autocal-pull-down-offset-3v3-timeout =
> +                                                                       <0x0a>;
> +                       nvidia,default-tap = <0x8>;
> +                       nvidia,default-trim = <0x14>;
> +                       nvidia,dqs-trim = <40>;
>                         status = "disabled";
>                 };
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 2205d66b0443..41408df9d4e9 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -476,6 +476,48 @@
>                 compatible = "nvidia,tegra210-pinmux";
>                 reg = <0x0 0x700008d4 0x0 0x29c>, /* Pad control registers */
>                       <0x0 0x70003000 0x0 0x294>; /* Mux registers */
> +               sdmmc1_3v3_drv: sdmmc1-3v3-drv {
> +                       sdmmc1 {
> +                               nvidia,pins = "drive_sdmmc1";
> +                               nvidia,pull-down-strength = <0x8>;
> +                               nvidia,pull-up-strength = <0x8>;
> +                       };
> +               };
> +               sdmmc1_1v8_drv: sdmmc1-1v8-drv {
> +                       sdmmc1 {
> +                               nvidia,pins = "drive_sdmmc1";
> +                               nvidia,pull-down-strength = <0x4>;
> +                               nvidia,pull-up-strength = <0x3>;
> +                       };
> +               };
> +               sdmmc2_1v8_drv: sdmmc2-1v8-drv {
> +                       sdmmc2 {
> +                               nvidia,pins = "drive_sdmmc2";
> +                               nvidia,pull-down-strength = <0x10>;
> +                               nvidia,pull-up-strength = <0x10>;
> +                       };
> +               };
> +               sdmmc3_3v3_drv: sdmmc3-3v3-drv {
> +                       sdmmc3 {
> +                               nvidia,pins = "drive_sdmmc3";
> +                               nvidia,pull-down-strength = <0x8>;
> +                               nvidia,pull-up-strength = <0x8>;
> +                       };
> +               };
> +               sdmmc3_1v8_drv: sdmmc3-1v8-drv {
> +                       sdmmc3 {
> +                               nvidia,pins = "drive_sdmmc3";
> +                               nvidia,pull-down-strength = <0x4>;
> +                               nvidia,pull-up-strength = <0x3>;
> +                       };
> +               };
> +               sdmmc4_1v8_drv: sdmmc4-1v8-drv {
> +                       sdmmc4 {
> +                               nvidia,pins = "drive_sdmmc4";
> +                               nvidia,pull-down-strength = <0x10>;
> +                               nvidia,pull-up-strength = <0x10>;
> +                       };
> +               };
>         };
>
>         /*
> @@ -1050,9 +1092,12 @@
>                 clock-names = "sdhci";
>                 resets = <&tegra_car 14>;
>                 reset-names = "sdhci";
> -               pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +               pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
> +                               "sdmmc-3v3-drv", "sdmmc-1v8-drv";
>                 pinctrl-0 = <&sdmmc1_3v3>;
>                 pinctrl-1 = <&sdmmc1_1v8>;
> +               pinctrl-2 = <&sdmmc1_3v3_drv>;
> +               pinctrl-3 = <&sdmmc1_1v8_drv>;
>                 nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
>                 nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
>                 nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
> @@ -1075,6 +1120,8 @@
>                 clock-names = "sdhci";
>                 resets = <&tegra_car 9>;
>                 reset-names = "sdhci";
> +               pinctrl-names = "sdmmc-1v8-drv";
> +               pinctrl-0 = <&sdmmc2_1v8_drv>;
>                 nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
>                 nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
>                 nvidia,default-tap = <0x8>;
> @@ -1090,9 +1137,12 @@
>                 clock-names = "sdhci";
>                 resets = <&tegra_car 69>;
>                 reset-names = "sdhci";
> -               pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +               pinctrl-names = "sdmmc-3v3", "sdmmc-1v8",
> +                               "sdmmc-3v3-drv", "sdmmc-1v8-drv";
>                 pinctrl-0 = <&sdmmc3_3v3>;
>                 pinctrl-1 = <&sdmmc3_1v8>;
> +               pinctrl-2 = <&sdmmc3_3v3_drv>;
> +               pinctrl-3 = <&sdmmc3_1v8_drv>;
>                 nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
>                 nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
>                 nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
> @@ -1110,6 +1160,9 @@
>                 clock-names = "sdhci";
>                 resets = <&tegra_car 15>;
>                 reset-names = "sdhci";
> +               pinctrl-names = "sdmmc-3v3-drv", "sdmmc-1v8-drv";
> +               pinctrl-0 = <&sdmmc4_1v8_drv>;
> +               pinctrl-1 = <&sdmmc4_1v8_drv>;
>                 nvidia,pad-autocal-pull-up-offset-1v8 = <0x05>;
>                 nvidia,pad-autocal-pull-down-offset-1v8 = <0x05>;
>                 nvidia,default-tap = <0x8>;
> --
> 2.7.4
>

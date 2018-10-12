Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2565C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C01A2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="beGlzBA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C01A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeJLSP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:15:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6164 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:15:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc07af90000>; Fri, 12 Oct 2018 03:44:09 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 03:44:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 03:44:06 -0700
Received: from [10.21.132.143] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 10:44:04 +0000
Subject: Re: [PATCH v1 3/8] ARM: tegra: apalis/colibri_t30: fix hdmi regulator
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
 <20181009152523.3771-4-marcel@ziswiler.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <521e8eb0-ce63-851a-0637-a0207bec6a32@nvidia.com>
Date:   Fri, 12 Oct 2018 11:44:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009152523.3771-4-marcel@ziswiler.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539341049; bh=eMs9uq1E0RdJFcNcdd3TAmAXqWJh9Qm3+4u1ZpzPQjY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=beGlzBA9UT2EbdjAYiLJ0O3J93j39/Tf4gcdPPPVc6I8UzlBm1jyv8amk2vR8Gs7K
         If2nnR9D0iv1NcJqQg9KuS9FHBW+ThxMGWRW1hAor7Pa+neEl29p2X86QNceP12c0r
         VauTmrczNoQUw4i8jS8tW62jfEJTtgvnSNd3pL//qnJoK3i1pYJm7jGsonrToX6l5S
         3UkW4RqG5nmrV/chwC0TGz4jHdwwH73Ar2c7GAXRL2uQ9QSPEIsPhhHT6SNf04ICMz
         53S2KIP9YKloERMbYHa/bS4xLYL+HB7CxcoQJp3M2XJo0xOZ8iW0QwHqi92nIHHps5
         LScAictdtkUSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/10/18 16:25, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix HDMI requiring two regulators being enabled by a single GPIO. Model
> this using an intermediate reg_en_vdd_hdmi regulator being the
> vin-supply of them other two. This fixes the display subsystem and gets
> rid of the following error during boot:
> 
>  reg-fixed-voltage: probe of regulator-3v3-avdd-hdmi failed with error -16
>  tegra-hdmi 54280000.hdmi: failed to get VDD regulator
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v1: None
> 
>  arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 16 ++++++++++++----
>  arch/arm/boot/dts/tegra30-apalis.dtsi      | 16 ++++++++++++----
>  arch/arm/boot/dts/tegra30-colibri.dtsi     | 16 ++++++++++++----
>  3 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
> index 02f8126481a2..065a24ac1052 100644
> --- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
> @@ -1133,8 +1133,7 @@
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <1800000>;
>  		enable-active-high;
> -		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> -		vin-supply = <&reg_1v8_vio>;
> +		vin-supply = <&reg_en_vdd_hdmi>;
>  	};
>  
>  	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
> @@ -1143,8 +1142,7 @@
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		enable-active-high;
> -		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> -		vin-supply = <&reg_module_3v3>;
> +		vin-supply = <&reg_en_vdd_hdmi>;
>  	};
>  
>  	reg_5v0_charge_pump: regulator-5v0-charge-pump {
> @@ -1171,6 +1169,16 @@
>  		regulator-always-on;
>  	};
>  
> +	reg_en_vdd_hdmi: regulator-en-vdd-hdmi {
> +		compatible = "regulator-fixed";
> +		regulator-name = "EN_VDD_HDMI";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&reg_module_3v3>;
> +	};
> +
>  	sound {
>  		compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
>  			     "nvidia,tegra-audio-sgtl5000";
> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
> index 7f112f192fe9..6727c5868425 100644
> --- a/arch/arm/boot/dts/tegra30-apalis.dtsi
> +++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
> @@ -1115,8 +1115,7 @@
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <1800000>;
>  		enable-active-high;
> -		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> -		vin-supply = <&reg_1v8_vio>;
> +		vin-supply = <&reg_en_vdd_hdmi>;
>  	};
>  
>  	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
> @@ -1125,8 +1124,7 @@
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		enable-active-high;
> -		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> -		vin-supply = <&reg_module_3v3>;
> +		vin-supply = <&reg_en_vdd_hdmi>;
>  	};
>  
>  	reg_5v0_charge_pump: regulator-5v0-charge-pump {
> @@ -1153,6 +1151,16 @@
>  		regulator-always-on;
>  	};
>  
> +	reg_en_vdd_hdmi: regulator-en-vdd-hdmi {
> +		compatible = "regulator-fixed";
> +		regulator-name = "EN_VDD_HDMI";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&reg_module_3v3>;
> +	};
> +
>  	sound {
>  		compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
>  			     "nvidia,tegra-audio-sgtl5000";
> diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
> index 35af03ca9e90..963f26071415 100644
> --- a/arch/arm/boot/dts/tegra30-colibri.dtsi
> +++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
> @@ -965,8 +965,7 @@
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <1800000>;
>  		enable-active-high;
> -		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> -		vin-supply = <&reg_1v8_vio>;
> +		vin-supply = <&reg_en_vdd_hdmi>;
>  	};
>  
>  	reg_3v3_avdd_hdmi: regulator-3v3-avdd-hdmi {
> @@ -975,8 +974,7 @@
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		enable-active-high;
> -		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> -		vin-supply = <&reg_module_3v3>;
> +		vin-supply = <&reg_en_vdd_hdmi>;
>  	};
>  
>  	reg_5v0_charge_pump: regulator-5v0-charge-pump {
> @@ -1012,6 +1010,16 @@
>  		regulator-always-on;
>  	};
>  
> +	reg_en_vdd_hdmi: regulator-en-vdd-hdmi {
> +		compatible = "regulator-fixed";
> +		regulator-name = "EN_VDD_HDMI";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&reg_module_3v3>;
> +	};
> +
>  	sound {
>  		compatible = "toradex,tegra-audio-sgtl5000-colibri_t30",
>  			     "nvidia,tegra-audio-sgtl5000";
> 

Given Linus W's fix for the gpiolib [0], I am not convinced that this is
really better/needed.

Cheers
Jon

[0] https://lore.kernel.org/patchwork/patch/998354/

-- 
nvpublic

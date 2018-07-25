Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2F520671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 06:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="enalBOa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2F520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeGYIAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:00:44 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:39663 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbeGYIAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JVg95Kjx80YnQgfN8Xu1Hov5LM3+H2Fs8y1Ea1zplxw=; b=enalBOa751n0qCZBpxJD63oFoc
        eDvyvX6bji+96tsFApoWRvVMUnnDnl5ACBVEH84IiWM8SMq3J588lD0h+VILK30Amz0ewy3YGDlqV
        7uP14mnXxTTzBfj4yz0ag0cq6gEw9nCifG9QQqlosse5KlgM2jiBX/pekiMVZx6VKpact9PUQNRod
        4ZIlwjqcpzWgEcMJc2v9pG6n4J8LOSI+2hmPab8ix0gJp7DgUVh84N8/oNR8u0NC+U+MzmeHUeV2l
        /Y416Y0410VJ5k6cgn8aHwj6HlhQ8T/h39EvuwhO9gTQCbhoxDU4iy0bhhT+thVJB3Fc/6MqhXGsH
        XuaLQdzQ==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fiDcx-0003pX-S1; Wed, 25 Jul 2018 09:50:27 +0300
Subject: Re: [PATCH 4/7] arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
 <1532090746-15863-5-git-send-email-avienamo@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <6a37f483-4430-e70e-62a8-4e4181463735@kapsi.fi>
Date:   Wed, 25 Jul 2018 09:50:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532090746-15863-5-git-send-email-avienamo@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

On 20.07.2018 15:45, Aapo Vienamo wrote:
> Add pad voltage configuration nodes for sdmmc pads with configurable
> voltages on Tegra186.
> 
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 40 ++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index b762227..7669756 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -4,6 +4,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/mailbox/tegra186-hsp.h>
>   #include <dt-bindings/memory/tegra186-mc.h>
> +#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
>   #include <dt-bindings/power/tegra186-powergate.h>
>   #include <dt-bindings/reset/tegra186-reset.h>
>   #include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
> @@ -236,6 +237,9 @@
>   		clock-names = "sdhci";
>   		resets = <&bpmp TEGRA186_RESET_SDMMC1>;
>   		reset-names = "sdhci";
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc1_3v3>;
> +		pinctrl-1 = <&sdmmc1_1v8>;
>   		status = "disabled";
>   	};
>   
> @@ -247,6 +251,9 @@
>   		clock-names = "sdhci";
>   		resets = <&bpmp TEGRA186_RESET_SDMMC2>;
>   		reset-names = "sdhci";
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc2_3v3>;
> +		pinctrl-1 = <&sdmmc2_1v8>;
>   		status = "disabled";
>   	};
>   
> @@ -258,6 +265,9 @@
>   		clock-names = "sdhci";
>   		resets = <&bpmp TEGRA186_RESET_SDMMC3>;
>   		reset-names = "sdhci";
> +		pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
> +		pinctrl-0 = <&sdmmc3_3v3>;
> +		pinctrl-1 = <&sdmmc3_1v8>;
>   		status = "disabled";
>   	};
>   
> @@ -368,6 +378,36 @@
>   		      <0 0x0c380000 0 0x10000>,
>   		      <0 0x0c390000 0 0x10000>;
>   		reg-names = "pmc", "wake", "aotag", "scratch";
> +
> +		sdmmc1_3v3: sdmmc1-3v3 {
> +			pins = "sdmmc1-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc1_1v8: sdmmc1-1v8 {
> +			pins = "sdmmc1-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
> +
> +		sdmmc2_3v3: sdmmc2-3v3 {
> +			pins = "sdmmc2-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc2_1v8: sdmmc2-1v8 {
> +			pins = "sdmmc2-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
> +
> +		sdmmc3_3v3: sdmmc3-3v3 {
> +			pins = "sdmmc3-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +		};
> +
> +		sdmmc3_1v8: sdmmc3-1v8 {
> +			pins = "sdmmc3-hv";
> +			power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +		};
>   	};
>   
>   	ccplex@e000000 {
> 

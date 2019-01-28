Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C179C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEDD20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DlU0sPxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfA1H7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:59:39 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19017 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA1H7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:59:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4eb6410000>; Sun, 27 Jan 2019 23:58:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 23:59:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 27 Jan 2019 23:59:36 -0800
Received: from [10.19.108.140] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 07:59:34 +0000
Subject: Re: [PATCH 4/6] arm64: tegra: Add XUSB and pad controller on Tegra186
To:     Thierry Reding <thierry.reding@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
 <20190125113013.11447-4-thierry.reding@gmail.com>
From:   jckuo <jckuo@nvidia.com>
Message-ID: <1a04128b-3f08-dbe1-97cc-566d7ab94240@nvidia.com>
Date:   Mon, 28 Jan 2019 15:59:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125113013.11447-4-thierry.reding@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548662337; bh=O0jmC85z8zU88Mv21jxUHA0C3v1pD7JrurBGE2Gd6Lc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=DlU0sPxcpqNMY8ZMMFHGgk3wMjLmc/6x6RFzB0OabPys3Qsv7d8yVdtWU9NaAuA57
         A7liT83NX5ZN4qokS3ObfHVWtn2zVgaIpCdNyk17ucGXGd8J4zVTr6EHFi8+xoOnkr
         2G6RbYb91yVQThtD50TG54AnTTPAObamrW58/EZvBp6Ko2hepSOWNBfOyoAmljHfN5
         gnSHfWXgiVC7aHM0Dc80HwtM8vBpXLphVUikzuvMCGqwim1hXeJmBhnr+H7GroISWj
         lc4jDRmj4IMbS06AUDxLouJJuvoyL/sWEuU/l77bGFrFZ1MvYY2d0z2/tCKq1wQ1Cv
         Tgj6xZfuD5S3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 1/25/19 7:30 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Adds the XUSB pad and XUSB controllers on Tegra186.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 135 +++++++++++++++++++++++
>   1 file changed, 135 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 22815db4a3ed..09d3b0d60e41 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -338,6 +338,141 @@
>   		status = "disabled";
>   	};
>   
> +	padctl: padctl@3520000 {
> +		compatible = "nvidia,tegra186-xusb-padctl";
> +		reg = <0x0 0x03520000 0x0 0x1000>,
> +		      <0x0 0x03540000 0x0 0x1000>;
> +		reg-names = "padctl", "ao";
> +
> +		resets = <&bpmp TEGRA186_RESET_XUSB_PADCTL>;
> +		reset-names = "padctl";
> +
> +		status = "disabled";
> +
> +		pads {
> +			usb2 {
> +				clocks = <&bpmp TEGRA186_CLK_USB2_TRK>;
> +				clock-names = "trk";
> +				status = "disabled";
> +
> +				lanes {
> +					usb2-0 {
> +						status = "disabled";
> +						#phy-cells = <0>;
> +					};
> +
> +					usb2-1 {
> +						status = "disabled";
> +						#phy-cells = <0>;
> +					};
> +
> +					usb2-2 {
> +						status = "disabled";
> +						#phy-cells = <0>;
> +					};
> +				};
> +			};
> +
> +			hsic {
> +				clocks = <&bpmp TEGRA186_CLK_HSIC_TRK>;
> +				clock-names = "trk";
> +				status = "disabled";
> +
> +				lanes {
> +					hsic-0 {
> +						status = "disabled";
> +						#phy-cells = <0>;
> +					};
> +				};
> +			};
> +
> +			usb3 {
> +				status = "disabled";
> +
> +				lanes {
> +					usb3-0 {
> +						status = "disabled";
> +						#phy-cells = <0>;
> +					};
> +
> +					usb3-1 {
> +						status = "disabled";
> +						#phy-cells = <0>;
> +					};
> +
> +					usb3-2 {
> +						status = "disabled";
> +						#phy-cells = <0>;
> +					};
> +				};
> +			};
> +		};
> +
> +		ports {
> +			usb2-0 {
> +				status = "disabled";
> +			};
> +
> +			usb2-1 {
> +				status = "disabled";
> +			};
> +
> +			usb2-2 {
> +				status = "disabled";
> +			};
> +
> +			hsic-0 {
> +				status = "disabled";
> +			};
> +
> +			usb3-0 {
> +				status = "disabled";
> +			};
> +
> +			usb3-1 {
> +				status = "disabled";
> +			};
> +
> +			usb3-2 {
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	usb@3530000 {
> +		compatible = "nvidia,tegra186-xusb";
> +		reg = <0x0 0x03530000 0x0 0x8000>,
> +		      <0x0 0x03538000 0x0 0x1000>;
> +		reg-names = "hcd", "fpci";
> +
> +		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		clocks = <&bpmp TEGRA186_CLK_XUSB_HOST>,
> +			 <&bpmp TEGRA186_CLK_XUSB_FALCON>,
> +			 <&bpmp TEGRA186_CLK_XUSB_SS>,
> +			 <&bpmp TEGRA186_CLK_XUSB_CORE_SS>,
> +			 <&bpmp TEGRA186_CLK_CLK_M>,
> +			 <&bpmp TEGRA186_CLK_XUSB_FS>,
> +			 <&bpmp TEGRA186_CLK_PLLU>,
> +			 <&bpmp TEGRA186_CLK_CLK_M>,
> +			 <&bpmp TEGRA186_CLK_PLLE>;
> +		clock-names = "xusb_host", "xusb_falcon_src", "xusb_ss",
> +			      "xusb_ss_src", "xusb_hs_src", "xusb_fs_src",
> +			      "pll_u_480m", "clk_m", "pll_e";
> +
> +		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_XUSBC>,
> +				<&bpmp TEGRA186_POWER_DOMAIN_XUSBA>;
> +		power-domain-names = "xusb_host", "xusb_ss";
> +		nvidia,xusb-padctl = <&padctl>;
> +
> +		status = "disabled";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
>   	fuse@3820000 {
>   		compatible = "nvidia,tegra186-efuse";
>   		reg = <0x0 0x03820000 0x0 0x10000>;

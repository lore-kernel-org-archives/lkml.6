Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB64C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB07820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 10:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YgRy9vJG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eh3VrbQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfAQKnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:43:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35760 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 05:43:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F8B0607DD; Thu, 17 Jan 2019 10:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547721829;
        bh=bZY00lQOroGHMaECe3RcMsIpaCi4NI9dpDfdrICBBbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YgRy9vJG3b+EEu/jxQBx+j3k61Z+4oMCTznMC9pUi1T32jqBszaQVLJ6/LTPSoqB7
         2fFe10nH6eA3MwXXiL0z7PtMZZiwCrywYcN8+BeByAi7pW0jwlaw7a+BaAWCyCEt8o
         Gm4gazNFer8QMCWHfVkGpnbiwBAyfBiRor28vSCk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 52270604B4;
        Thu, 17 Jan 2019 10:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547721828;
        bh=bZY00lQOroGHMaECe3RcMsIpaCi4NI9dpDfdrICBBbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Eh3VrbQPcqwfd7oAjILTSTWsgUcDn4fUPvyFV1//4LzcgATETnc0doWZX9f1NlD2o
         Cq8UbK/UubAw49cEuo2KEXc5D8iZsFtgDvXF/af0nmcjSjma1PbBhhrJ5/lPwrjk4y
         qZXo98RtJ2IjefF21+6RtFAYa+q7maj3WZQo4g/Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Jan 2019 16:13:48 +0530
From:   mgottam@codeaurora.org
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        stanimir.varbanov@linaro.org, vgarodia@codeaurora.org
Subject: Re: [PATCH v4] arm64: dts: sdm845: add video nodes
In-Reply-To: <1546871444-13224-1-git-send-email-mgottam@codeaurora.org>
References: <1546871444-13224-1-git-send-email-mgottam@codeaurora.org>
Message-ID: <c1967739f843d1227803cb2c510373ae@codeaurora.org>
X-Sender: mgottam@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-07 20:00, Malathi Gottam wrote:
> This adds video nodes to sdm845 based on the examples
> in the bindings.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0..df31d39 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -87,6 +87,11 @@
>  			reg = <0 0x86200000 0 0x2d00000>;
>  			no-map;
>  		};
> +
> +		venus_region: memory@95800000 {
> +			reg = <0x0 0x95800000 0x0 0x600000>;
> +			no-map;
> +		};
>  	};
> 
>  	cpus {
> @@ -1403,5 +1408,35 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		video-codec@aa00000 {
> +			compatible = "qcom,sdm845-venus";
> +			reg = <0x0aa00000 0xff000>;
> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +			power-domains = <&videocc VENUS_GDSC>;
> +			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> +				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
> +			clock-names = "core", "iface", "bus";
> +			iommus = <&apps_smmu 0x10a0 0x8>,
> +				 <&apps_smmu 0x10b0 0x0>;
> +			memory-region = <&venus_region>;
> +
> +			video-core0 {
> +				compatible = "venus-decoder";
> +				clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +					 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> +				clock-names = "core", "bus";
> +				power-domains = <&videocc VCODEC0_GDSC>;
> +			};
> +
> +			video-core1 {
> +				compatible = "venus-encoder";
> +				clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> +					 <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> +				clock-names = "core", "bus";
> +				power-domains = <&videocc VCODEC1_GDSC>;
> +			};
> +		};
>  	};
>  };

This patch is no longer needed as the size mismatch patch has been 
posted
https://patchwork.kernel.org/patch/10753645/

So please consider v3 as the latest one.

Thanks,
Malathi.

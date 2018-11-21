Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5507C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6642821104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BQ/cJm11";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kij8hawt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6642821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeKURIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:08:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33620 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbeKURIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:08:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E1B960376; Wed, 21 Nov 2018 06:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542782114;
        bh=AuE8i3ZQ0qEw6bq3GwqPqxFCwbqxY2mfG9HAmvhhjuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BQ/cJm11VXAno5jUyeMAjn73K2UnnzNm1A2/cYBvmcwHjl+GP/jBQ2kEmCwKghi6e
         ABhJ9CyFhC5l+QRZzlao/n6sAnRD97zYzurlYlOlrwdyIu/i4nQh2OsP35NmS2KWmu
         FLrqW0q1gk6pRL58b8DFLhQmo+EGuXwJiyV6hD7g=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4680560376;
        Wed, 21 Nov 2018 06:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542782113;
        bh=AuE8i3ZQ0qEw6bq3GwqPqxFCwbqxY2mfG9HAmvhhjuI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kij8hawtdnsaI1NlU4Qrv2K3i7YsTNCVQ36LCVcWkZC70rcF4nSHui/RXSDjGAmgT
         SPk6VjNjMG372lZ1/csYLSjb/4UPi64l9DsclbgbDmmuQ+c+atB0kY7yDdE1vWwONP
         dIy4EYCbrO/2jv2lpfnLKnA9s97y7IulwWyyn1n0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Nov 2018 12:05:13 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Malathi Gottam <mgottam@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        acourbot@chromium.org, vgarodia@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sdm845: add video nodes
In-Reply-To: <1542708506-12680-1-git-send-email-mgottam@codeaurora.org>
References: <1542708506-12680-1-git-send-email-mgottam@codeaurora.org>
Message-ID: <81d44fc3504854220ef7926bc6f0b580@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

On 2018-11-20 15:38, Malathi Gottam wrote:
> This adds video nodes to sdm845 based on the examples
> in the bindings.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 34 
> ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa..d82487d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -84,6 +84,10 @@
>  			reg = <0 0x86200000 0 0x2d00000>;
>  			no-map;
>  		};
> +		venus_region: venus@95800000 {
> +			reg = <0x0 0x95800000 0x0 0x500000>;
> +			no-map;
> +		};

nit: Please make this venus_region: memory@95800000
instead and add a new line before venus_region.

>  	};
> 
>  	cpus {
> @@ -1103,5 +1107,35 @@
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

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

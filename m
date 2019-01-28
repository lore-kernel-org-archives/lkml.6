Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBBFC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B3620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ENhwnvEJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SJ/Ti8sv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfA1Icr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:32:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfA1Icq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:32:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8BB39607F1; Mon, 28 Jan 2019 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548664365;
        bh=QDYGN2pqWHqCk6jiowAwF7qOFdiSdsH8BP9s/zQ/M8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ENhwnvEJ8PQkQHg/zWjxKqsL8eFO2dKD4Psngju2dR2NEtMYajRVycUWep5n4wmMd
         IF4hapAM6BtJK3AcI8CzyjGReOXJVkWStXoUs7JqljOwFjnujjN3rjNQ8irTjrnP9z
         Edr2r53OOob72CGCBnakpOK+zLQQG/YMhUyir1fk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id AF1F66047C;
        Mon, 28 Jan 2019 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548664364;
        bh=QDYGN2pqWHqCk6jiowAwF7qOFdiSdsH8BP9s/zQ/M8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJ/Ti8svPKmD1WtGcorudRe5bsR+MQ6m6MR9GZsQp+2a8YkGQdaxy3VUknZbE0wYg
         mJrt8L3AsJKyQP/yXzDywUppNFDPV1ljmUlLzHn+LZEpypeaJ/phZuBXc6n8FH1HZK
         swqWfrlKEPEAPmE1Ktl8jqlcTAtlWUb9S1iw1Jco=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jan 2019 14:02:44 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Malathi Gottam <mgottam@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        acourbot@chromium.org, stanimir.varbanov@linaro.org,
        vgarodia@codeaurora.org, linux-arm-msm-owner@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v5] arm64: dts: sdm845: add video nodes
In-Reply-To: <1548403893-21677-1-git-send-email-mgottam@codeaurora.org>
References: <1548403893-21677-1-git-send-email-mgottam@codeaurora.org>
Message-ID: <4df9ddb2ea57d4d85b407b7d7a934ac2@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Malathi,

Bjorn has a patch adding all reserved memory
nodes from version 10 so you can probably drop
the venus_region node from the patch.

https://patchwork.kernel.org/patch/10774869/

On 2019-01-25 13:41, Malathi Gottam wrote:
> This adds video nodes to sdm845 based on the examples
> in the bindings.
> 
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
> Changes:
> 	Added video firmware node
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index b72bdb0..1af68f5 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -87,6 +87,11 @@
>  			reg = <0 0x86200000 0 0x2d00000>;
>  			no-map;
>  		};
> +
> +		venus_region: memory@95800000 {
> +			reg = <0x0 0x95800000 0x0 0x500000>;
> +			no-map;
> +		};
>  	};
> 
>  	cpus {
> @@ -1403,5 +1408,38 @@
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
> +			video-firmware {
> +				iommus = <&apps_smmu 0x10b2 0x0>;
> +			};
> +		};
>  	};
>  };

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

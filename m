Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1FAC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6E421726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bM/pX1Qz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Dr0QvUXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfBAFuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:50:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49232 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBAFuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:50:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A10860746; Fri,  1 Feb 2019 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549000206;
        bh=KZBb8Kbf0m2cyx6T2WLjzS0QAHuJMti3E3fA5y1SSJc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bM/pX1QzOmCaMi18QwwQXfSZuyB5mwaBR3Cszy0ramr3eCUN1zQTEnZZPJ8x4NBZD
         qRyQNVDrpWCdB0oJYAgydtlRCi/5Z6TG0CuZo8l3hVRzMNUx25mmo4KklPjxl+wuMl
         CKWOzBe+WwPfnL4Jl5AgysbU6OAgW1W93iyIy3o8=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 36AF76047C;
        Fri,  1 Feb 2019 05:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549000205;
        bh=KZBb8Kbf0m2cyx6T2WLjzS0QAHuJMti3E3fA5y1SSJc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Dr0QvUXEdD8aTQ5OiZvOw3TtTU3+l6VIBCXrgWjOhm7e16A8d5yT2N7JKw5jLn4s6
         pE53ELnFInmBl4WDLk28hjP2k5LNN8wFsfhYYvsQ3mUGVxp4xP1vG2P8xYOT3FpMR0
         m8TEFoEZfdbWbycnXreY85WwguP8PfoEcG4R0G5U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 36AF76047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v5 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS
 nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
 <20190131003933.11436-4-bjorn.andersson@linaro.org>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <4539b3ca-cace-9c71-0453-94427ad79b73@codeaurora.org>
Date:   Fri, 1 Feb 2019 11:19:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190131003933.11436-4-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,

Tested-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

On 01/31/2019 06:09 AM, Bjorn Andersson wrote:
> Add the Audio DSP (ADSP) and Compute DSP (CDSP) nodes for TrustZone
> based remoteproc, supporting booting these cores on e.g. the MTP, and
> enable the same for the MTP.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - None
> 
> Changes since v3:
> - Make xo reference the actual CXO clock
> 
>   arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  8 ++++
>   arch/arm64/boot/dts/qcom/sdm845.dtsi    | 58 +++++++++++++++++++++++++
>   2 files changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index af8c6a2445a2..02b8357c8ce8 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -48,6 +48,10 @@
>   	};
>   };
>   
> +&adsp_pas {
> +	status = "okay";
> +};
> +
>   &apps_rsc {
>   	pm8998-rpmh-regulators {
>   		compatible = "qcom,pm8998-rpmh-regulators";
> @@ -344,6 +348,10 @@
>   	};
>   };
>   
> +&cdsp_pas {
> +	status = "okay";
> +};
> +
>   &gcc {
>   	protected-clocks = <GCC_QSPI_CORE_CLK>,
>   			   <GCC_QSPI_CORE_CLK_SRC>,
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index d19486ba1e5e..07d9cd6fba7d 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -325,6 +325,64 @@
>   		};
>   	};
>   
> +	adsp_pas: remoteproc-adsp {
> +		compatible = "qcom,sdm845-adsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 162 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>;
> +		clock-names = "xo";
> +
> +		memory-region = <&adsp_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
> +			label = "lpass";
> +			qcom,remote-pid = <2>;
> +			mboxes = <&apss_shared 8>;
> +		};
> +	};
> +
> +	cdsp_pas: remoteproc-cdsp {
> +		compatible = "qcom,sdm845-cdsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>;
> +		clock-names = "xo";
> +
> +		memory-region = <&cdsp_mem>;
> +
> +		qcom,smem-states = <&cdsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>;
> +			label = "turing";
> +			qcom,remote-pid = <5>;
> +			mboxes = <&apss_shared 4>;
> +		};
> +	};
> +
>   	tcsr_mutex: hwlock {
>   		compatible = "qcom,tcsr-mutex";
>   		syscon = <&tcsr_mutex_regs 0 0x1000>;
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

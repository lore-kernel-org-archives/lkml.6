Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE10C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B2120823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 05:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IuxNmA/7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XLokIavt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B2120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbeKSPyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 10:54:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeKSPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 10:54:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 334F460764; Mon, 19 Nov 2018 05:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542605502;
        bh=rJmtezl+uvVVDibL8rXm3iwIAbBSwnyPxr3Tib+s5Wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IuxNmA/7sbefR7NHRDr/BwqZL9u1x4xajDbIjJHJGgQ3eH9lYLy7LKQ9RcaP5hb3F
         pdF/KTG3K1pSNarqlYZtAhniaayczGSo4hEFR+zYDURRuHubsKlvPteQmMhv00EJyk
         oLR8JO108DxSSzZgSKOX9xaOGC9EvfdwGI7WNqq0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5C77560764;
        Mon, 19 Nov 2018 05:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542605501;
        bh=rJmtezl+uvVVDibL8rXm3iwIAbBSwnyPxr3Tib+s5Wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XLokIavtiwWO9Bg05bGuZwbavDnVNxpKuCYmNuRb71XoxEU44rupaaqwaCZqosa9p
         KeOAT2y4GPhVuRKpAYbMQ7aXdav/oFeFSHnntol2JlHdhHc6YPFSeK5NZUH0tBOAQG
         CorP1WYo9CXEToFyr9+Qj3q2EHQ2ew1VNw+ixtPM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Nov 2018 11:01:41 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 14/18] arm64: dts: qcom: qcs404: Add remoteproc nodes
In-Reply-To: <20181109094417.12109-15-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
 <20181109094417.12109-15-vkoul@kernel.org>
Message-ID: <718e105af9caeba834281dcab4aed499@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn/Vinod,

On 2018-11-09 15:14, Vinod Koul wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add the TrustZone based remoteproc nodes and their glink edges for
> adsp, cdsp and wcss. Enable them for EVB common DTS.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 12 +++++
>  arch/arm64/boot/dts/qcom/qcs404.dtsi     | 93 
> ++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index db035fef67d9..a39924efebe4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -21,6 +21,18 @@
>  	};
>  };
> 
> +&remoteproc_adsp {
> +	status = "ok";
> +};
> +
> +&remoteproc_cdsp {
> +	status = "ok";
> +};
> +
> +&remoteproc_wcss {
> +	status = "ok";
> +};
> +
>  &rpm_requests {
>  	pms405-regulators {
>  		compatible = "qcom,rpm-pms405-regulators";
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 46fce264c8fe..06607419c9d6 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -80,6 +80,99 @@
>  		method = "smc";
>  	};
> 
> +	remoteproc_adsp: remoteproc-adsp {
> +		compatible = "qcom,qcs404-adsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&adsp_fw_mem>;
> +
> +		qcom,smem-states = <&adsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <2>;
> +			mboxes = <&apcs_glb 8>;
> +
> +			label = "adsp";
> +		};
> +	};
> +
> +	remoteproc_cdsp: remoteproc-cdsp {
> +		compatible = "qcom,qcs404-cdsp-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";
> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&cdsp_fw_mem>;
> +
> +		qcom,smem-states = <&cdsp_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <5>;
> +			mboxes = <&apcs_glb 12>;
> +
> +			label = "cdsp";
> +		};
> +	};
> +
> +	remoteproc_wcss: remoteproc-wcss {
> +		compatible = "qcom,qcs404-wcss-pas";
> +
> +		interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +				      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +		interrupt-names = "wdog", "fatal", "ready",
> +				  "handover", "stop-ack";

I can see that wcss remoteproc uses an additional smp2p interrupt called 
shutdown-ack
downstream you may want to skip wcss entry for now till the shutdown-ack 
gets posted,
reviewed and merged.

> +
> +		clocks = <&xo_board>;
> +		clock-names = "xo";
> +
> +		memory-region = <&wlan_fw_mem>;
> +
> +		qcom,smem-states = <&wcss_smp2p_out 0>;
> +		qcom,smem-state-names = "stop";
> +
> +		status = "disabled";
> +
> +		glink-edge {
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
> +
> +			qcom,remote-pid = <1>;
> +			mboxes = <&apcs_glb 16>;
> +
> +			label = "wcss";
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403742089E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HjCvzVSN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HjCvzVSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403742089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeH1Mne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:43:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1Mne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:43:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EADFF60445; Tue, 28 Aug 2018 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535446375;
        bh=yQTLAkj65b/ZwKOySIuHMYgOLP3kPjqlujvwoCdwOIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HjCvzVSNrK2uO8ZRM/XSaEz12cyQoxOAB71+QeyqqX/FOd6ZxeM1oQbxNBENIOlzd
         6kG0wEtR81GWeGJUEZEHVJ2i39wdVTKNxrgBp2FWvJ7Iqr4VtooxKg4/xgrKb0h0HS
         4yxtqYzZAqiiI/MCU0qMH2pW6F0GnVweN7cv+DQs=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 233656030D;
        Tue, 28 Aug 2018 08:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535446375;
        bh=yQTLAkj65b/ZwKOySIuHMYgOLP3kPjqlujvwoCdwOIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HjCvzVSNrK2uO8ZRM/XSaEz12cyQoxOAB71+QeyqqX/FOd6ZxeM1oQbxNBENIOlzd
         6kG0wEtR81GWeGJUEZEHVJ2i39wdVTKNxrgBp2FWvJ7Iqr4VtooxKg4/xgrKb0h0HS
         4yxtqYzZAqiiI/MCU0qMH2pW6F0GnVweN7cv+DQs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Aug 2018 14:22:55 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Add smp2p nodes
In-Reply-To: <20180828071203.26740-1-bjorn.andersson@linaro.org>
References: <20180828071203.26740-1-bjorn.andersson@linaro.org>
Message-ID: <ab17f50051abd65aa6bead48567a003e@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

On 2018-08-28 12:42, Bjorn Andersson wrote:
> Add the SMP2P nodes for the remoteproc states for adsp, cdsp, mpss and
> slpi.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 88 ++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa6a1b5..d977117acac4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -230,6 +230,94 @@
>  		hwlocks = <&tcsr_mutex 3>;
>  	};
> 
> +	smp2p-cdsp {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <94>, <432>;
> +
> +		interrupts = <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
> +
> +		mboxes = <&apss_shared 6>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <5>;
> +
> +		cdsp_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		cdsp_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-lpass {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <443>, <429>;
> +
> +		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
> +
> +		mboxes = <&apss_shared 10>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <2>;
> +
> +		adsp_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		adsp_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-mpss {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&apss_shared 14>;
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <1>;
> +
> +		modem_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		modem_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	smp2p-slpi {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <481>, <430>;
> +		interrupts = <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>;
> +		mboxes = <&apss_shared 26>;
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <3>;
> +
> +		slpi_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		slpi_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93F0C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58B420857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="opXZicYo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="opXZicYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfBAHRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:17:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBAHRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:17:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A82F60721; Fri,  1 Feb 2019 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549005451;
        bh=4KMPn1Hklozcb73cCQTuHST2RPSMu1Wn4bm0V9p6Czc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=opXZicYoypEeirYO2jVBGcTCoez2dO95mqr83YARwdzzZmSin2Pa7OHvibUGvwzs8
         coIqXs6bG5+qgcc0A3Dsn+ZtLVatF2WwCi2WHzbzmQWrSO28aEeOHP4vvggJ4EF784
         Hu5Akh+Z6501d9God0Ls4Dbjmrk1mdVBx5qBBTpo=
Received: from [10.79.40.96] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DECE460398;
        Fri,  1 Feb 2019 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549005451;
        bh=4KMPn1Hklozcb73cCQTuHST2RPSMu1Wn4bm0V9p6Czc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=opXZicYoypEeirYO2jVBGcTCoez2dO95mqr83YARwdzzZmSin2Pa7OHvibUGvwzs8
         coIqXs6bG5+qgcc0A3Dsn+ZtLVatF2WwCi2WHzbzmQWrSO28aEeOHP4vvggJ4EF784
         Hu5Akh+Z6501d9God0Ls4Dbjmrk1mdVBx5qBBTpo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DECE460398
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v5 09/10] arm64: dts: qcom: Add AOSS QMP node
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
 <20190131003933.11436-10-bjorn.andersson@linaro.org>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <fe4c1e15-ae5d-3f10-e265-39df3230c30c@codeaurora.org>
Date:   Fri, 1 Feb 2019 12:47:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190131003933.11436-10-bjorn.andersson@linaro.org>
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
> The AOSS QMP provides a number of power domains, used for QDSS and
> PIL, add the node for this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - None
> 
> Changes since v3:
> - None
> 
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 07d9cd6fba7d..dc43fee8bb90 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -14,6 +14,7 @@
>   #include <dt-bindings/interconnect/qcom,sdm845.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/phy/phy-qcom-qusb2.h>
> +#include <dt-bindings/power/qcom-aoss-qmp.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> @@ -2076,6 +2077,15 @@
>   			#reset-cells = <1>;
>   		};
>   
> +		aoss_qmp: qmp@c300000 {
> +			compatible = "qcom,sdm845-aoss-qmp";
> +			reg = <0 0x0c300000 0 0x100000>;
> +			interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
> +			mboxes = <&apss_shared 0>;
> +
> +			#power-domain-cells = <1>;
> +		};
> +
>   		spmi_bus: spmi@c440000 {
>   			compatible = "qcom,spmi-pmic-arb";
>   			reg = <0 0x0c440000 0 0x1100>,
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

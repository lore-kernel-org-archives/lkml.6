Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A324FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694D0218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vylig4sY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vylig4sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388769AbfAaQ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:58:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:32896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbfAaQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:58:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DFC5660398; Thu, 31 Jan 2019 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548953912;
        bh=XzMGluJJbMmnytZqUKnR4Zt1OOvgguOn+yh6KRa0aFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vylig4sYBpfIEEX12vh8dZFW95VV1kStjdu378c3WOHyUqj5T73B9B24YlDh3Am9q
         Dm46BkEPstWFdSzI1r//3VzX87qeY3j4jDbg4NPY6emAsXWMyJAzmHAWNmJxtdzZEf
         n7zJ3WGoKtijyc+5Iyamq7UFezOgpk4rHJaJY3CY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2149F601CF;
        Thu, 31 Jan 2019 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548953912;
        bh=XzMGluJJbMmnytZqUKnR4Zt1OOvgguOn+yh6KRa0aFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vylig4sYBpfIEEX12vh8dZFW95VV1kStjdu378c3WOHyUqj5T73B9B24YlDh3Am9q
         Dm46BkEPstWFdSzI1r//3VzX87qeY3j4jDbg4NPY6emAsXWMyJAzmHAWNmJxtdzZEf
         n7zJ3WGoKtijyc+5Iyamq7UFezOgpk4rHJaJY3CY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Jan 2019 22:28:32 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v5 01/10] arm64: dts: qcom: sdm845: Update reserved memory
 map
In-Reply-To: <20190131003933.11436-2-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
 <20190131003933.11436-2-bjorn.andersson@linaro.org>
Message-ID: <0c5cc8f10e3c78f4d0eead81abb90d85@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,

On 2019-01-31 06:09, Bjorn Andersson wrote:
> Update existing and add missing regions to the reserved memory map, as
> described in version 10.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v4:
> - Labeled aop_mem, aop_cmd_db_mem and made tz_mem span the last TZ
> related segment
> 
> Changes since v3:
> - Added hyp and xbl memory nodes.
> - Labeled all PIL nodes
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 72 +++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 33f5f4ba6160..45b1616392aa 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -73,12 +73,22 @@
>  		#size-cells = <2>;
>  		ranges;
> 
> -		memory@85fc0000 {
> +		hyp_mem: memory@85700000 {
> +			reg = <0x0 0x85700000 0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_mem: memory@85e00000 {
> +			reg = <0x0 0x85e00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		aop_mem: memory@85fc0000 {
>  			reg = <0 0x85fc0000 0 0x20000>;
>  			no-map;
>  		};
> 
> -		memory@85fe0000 {
> +		aop_cmd_db_mem: memory@85fe0000 {
>  			compatible = "qcom,cmd-db";
>  			reg = <0x0 0x85fe0000 0x0 0x20000>;
>  			no-map;
> @@ -89,13 +99,43 @@
>  			no-map;
>  		};
> 
> -		memory@86200000 {
> -			reg = <0 0x86200000 0 0x2d00000>;
> +		tz_mem: memory@86200000 {
> +			reg = <0 0x86200000 0 0x3c00000>;

should be 0x2d00000 instead of 0x3c00000
tz_mem ends at 0x88F00000 :-)

nit: Also for hyp_mem and xbl_mem you could
use 0 instead of 0x0

Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

> +			no-map;
> +		};
> +
> +		qseecom_mem: memory@8ab00000 {
> +			reg = <0 0x8ab00000 0 0x1400000>;
> +			no-map;
> +		};
> +
> +		camera_mem: memory@8bf00000 {
> +			reg = <0 0x8bf00000 0 0x500000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: memory@8c400000 {
> +			reg = <0 0x8c400000 0 0x10000>;
> +			no-map;
> +		};
> +
> +		ipa_gsi_mem: memory@8c410000 {
> +			reg = <0 0x8c410000 0 0x5000>;
>  			no-map;
>  		};
> 
> -		wlan_msa_mem: memory@96700000 {
> -			reg = <0 0x96700000 0 0x100000>;
> +		gpu_mem: memory@8c415000 {
> +			reg = <0 0x8c415000 0 0x2000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: memory@8c500000 {
> +			reg = <0 0x8c500000 0 0x1a00000>;
> +			no-map;
> +		};
> +
> +		wlan_msa_mem: memory@8df00000 {
> +			reg = <0 0x8df00000 0 0x100000>;
>  			no-map;
>  		};
> 
> @@ -104,10 +144,30 @@
>  			no-map;
>  		};
> 
> +		venus_mem: memory@95800000 {
> +			reg = <0 0x95800000 0 0x500000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: memory@95d00000 {
> +			reg = <0 0x95d00000 0 0x800000>;
> +			no-map;
> +		};
> +
>  		mba_region: memory@96500000 {
>  			reg = <0 0x96500000 0 0x200000>;
>  			no-map;
>  		};
> +
> +		slpi_mem: memory@96700000 {
> +			reg = <0 0x96700000 0 0x1400000>;
> +			no-map;
> +		};
> +
> +		spss_mem: memory@97b00000 {
> +			reg = <0 0x97b00000 0 0x100000>;
> +			no-map;
> +		};
>  	};
> 
>  	cpus {

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

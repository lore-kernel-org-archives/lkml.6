Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036FBC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C22218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PR97mGZv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PR97mGZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfAYRkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:40:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:40:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5FB460850; Fri, 25 Jan 2019 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548438048;
        bh=auKadNCRyCk9nVyVmT74uiJWyteYnDEQhEY72yLVvfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PR97mGZvBEzOxojk0lQ2AeSyS175V/NuckrGWLk+INdAvXg68f78nuWefES2yIWEf
         UPLrlm2sgVucw1EPP/5RSlmj1z/Sm+7d79Og/2ZJl0TmYIZtx8vpu+ScE8yAev6W8/
         jYoLuGmGntBmPaFerxYGF5gpvfNZpVfL3Rlv+Zj0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 065676034E;
        Fri, 25 Jan 2019 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548438048;
        bh=auKadNCRyCk9nVyVmT74uiJWyteYnDEQhEY72yLVvfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PR97mGZvBEzOxojk0lQ2AeSyS175V/NuckrGWLk+INdAvXg68f78nuWefES2yIWEf
         UPLrlm2sgVucw1EPP/5RSlmj1z/Sm+7d79Og/2ZJl0TmYIZtx8vpu+ScE8yAev6W8/
         jYoLuGmGntBmPaFerxYGF5gpvfNZpVfL3Rlv+Zj0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Jan 2019 23:10:47 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region
 memory map
In-Reply-To: <20190122055112.30943-2-bjorn.andersson@linaro.org>
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-2-bjorn.andersson@linaro.org>
Message-ID: <d8bb5a09037835e07838ab6996eb01ed@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,

On 2019-01-22 11:21, Bjorn Andersson wrote:
> Update existing and add all missing PIL regions to the reserved memory
> map, as described in version 10.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - New patch
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 61 ++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0ec827394e92..cdcac3704c13 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -89,12 +89,47 @@
>  		};

Shouldn't we add hyp and xbl regions
as well?

> 
>  		memory@86200000 {
> -			reg = <0 0x86200000 0 0x2d00000>;
> +			reg = <0 0x86200000 0 0x100000>;
>  			no-map;
>  		};
> 
> -		wlan_msa_mem: memory@96700000 {
> -			reg = <0 0x96700000 0 0x100000>;
> +		memory@86300000 {
> +			reg = <0 0x86300000 0 0x4800000>;

from v10 I see we don't need to reserve the
last 28M it just needs to be

reg = <0 0x86300000 0 0x2c00000>;

> +			no-map;
> +		};
> +
> +		memory@8ab00000 {
> +			reg = <0 0x8ab00000 0 0x1400000>;
> +			no-map;
> +		};
> +
> +		memory@8bf00000 {
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
> +			no-map;
> +		};
> +
> +		memory@8c415000 {
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
> @@ -103,10 +138,30 @@
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

should we re-name mba_region/mpss_region
to mba_mem and mpss_mem for consistency.

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

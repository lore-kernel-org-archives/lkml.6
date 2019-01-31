Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDCEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A70218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ID4MQap5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fnlakalu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbfAaEVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:21:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53920 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfAaEVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:21:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B503F6060A; Thu, 31 Jan 2019 04:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548908508;
        bh=qxcsN9MK8rmsU1FaomWHr3Yq25d6yLE/xAvCdnbz8d4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ID4MQap5fYKstO9DMaYruPTIB5B4o3ojh2r0++oE/eb0fpIoMeVipo7q2O8vEXA80
         H5hjkvsG2JQidGbaeIF3ViMElqTwctpejiWW6Z/NlVu4OkQQw+3CAaDNEKNrG0pHrR
         NOQ3EuxR0OYJpbC8Dj1iV4AUtDelzGO92zQQUWkE=
Received: from [10.79.129.198] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02801602CB;
        Thu, 31 Jan 2019 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548908507;
        bh=qxcsN9MK8rmsU1FaomWHr3Yq25d6yLE/xAvCdnbz8d4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fnlakalu104GpxU1bryqTz9GUnNauif2d2eu3fITJQ3xpor/QLPZd7A9shQMfMdYL
         f5A3F58Jr0ZAYfiuOv6WUT7qMbRSm1egh8ZpVLA7w35flx6DWVLVig/bEyhBsVyiY4
         A0aaK//Q3f88o5xbafDRB3nX5Ds5wtEGSbsJAU+E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02801602CB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [RESEND PATCH v2] arm64: dts: qcom: msm8998: Add rpmcc node
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
References: <6da00186-e7c9-c93d-a80a-65eda2516451@free.fr>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <afcb4d79-9888-3c48-bdc2-1475d93c860b@codeaurora.org>
Date:   Thu, 31 Jan 2019 09:51:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6da00186-e7c9-c93d-a80a-65eda2516451@free.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2019 10:01 PM, Marc Gonzalez wrote:
> Add MSM8998 Resource Power Manager Clock Controller DT node.
> 
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
> Detach this patch from UFS series
> Resend because SMTP server was blacklisted.
> ---
>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index a6d66cf77403..6f4f4b79853b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -3,6 +3,7 @@
>   
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
>   #include <dt-bindings/gpio/gpio.h>
>   
>   / {
> @@ -266,6 +267,11 @@
>   		rpm_requests: rpm-requests {
>   			compatible = "qcom,rpm-msm8998";
>   			qcom,glink-channels = "rpm_requests";
> +
> +			rpmcc: clock-controller {
> +				compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
> +				#clock-cells = <1>;
> +			};
>   		};
>   	};
>   
> 

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

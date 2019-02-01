Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E050C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3D020863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aSYM6D5g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Va2WHu96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfBAI5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:57:46 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfBAI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:57:46 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C84760908; Fri,  1 Feb 2019 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549011464;
        bh=aA0HJj7ZGV6efgC5etjJF1qn0btS6fhHPGxyai4hI1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aSYM6D5gMZYcjuClv4wR/GUkj53etsLqkHaQSmgTt+GzvxK8/98w4lNu754jc0Hz8
         0DtC58fmhGdzS7t23zQ1QJsoTJ+uu5+ws5qSH7PwLiVaAegA0313xhXLvXc0dSICD4
         SkGqjPYQcG+PosyKxBsswROFsyzRTsA1ZpI/QgWA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 2F7F560746;
        Fri,  1 Feb 2019 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549011463;
        bh=aA0HJj7ZGV6efgC5etjJF1qn0btS6fhHPGxyai4hI1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Va2WHu96M4gUOSoYpwwMIghuD8JtaUm1x2RJMKcCFn2FMMx77p1EhPF/Wuy1xvyhA
         zBropzPxu/SRQUgYuzvxe4qLCnOGKkxpIgWFlXclS6qgrZB0dzYkNJt3/0gfOkwazC
         nRxElwEY+sp9x8cvDpzX8KckRypT+OJQNAEIgGNY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Feb 2019 14:27:42 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add clocks and iommus to
 WCN3990 WLAN node
In-Reply-To: <20190131051438.12867-1-bjorn.andersson@linaro.org>
References: <20190131051438.12867-1-bjorn.andersson@linaro.org>
Message-ID: <f8a085407b751b26316ff91ebcae99f3@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-31 10:44, Bjorn Andersson wrote:
> From: Douglas Anderson <dianders@chromium.org>
> 
> When commit be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module
> device node") was posted upstream no clocks were specified.  However,
> when the pack was picked into the Chrome OS kernel tree (allegedly
> directly from the mailing list post) it had clock properties.
> 
> I presume that the clock should be there, so let's add it.

Tested-by: Sibi Sankar <sibis@codeaurora.org>

> 
> Fixes: be7019103469 ("dts: arm64/sdm845: Add WCN3990 WLAN module device 
> node")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> [bjorn: Add also the required iommus property]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Hijacking Doug's fixup patch to also add the missing iommus property. 
> Without
> this the MTP reboots once the ath10k is trying to exercise the 
> copyengine.
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cba09899282e..58f034664336 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2422,6 +2422,8 @@
>  			reg = <0 0x18800000 0 0x800000>;
>  			reg-names = "membase";
>  			memory-region = <&wlan_msa_mem>;
> +			clock-names = "cxo_ref_clk_pin";
> +			clocks = <&rpmhcc RPMH_RF_CLK2>;
>  			interrupts =
>  				<GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
>  				<GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
> @@ -2435,6 +2437,7 @@
>  				<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
>  				<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
>  				<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
> +			iommus = <&apps_smmu 0x0040 0x1>;
>  		};
>  	};

-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.

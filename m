Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF786C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716D520859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYWssyol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733202AbfAPGJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:09:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45001 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733015AbfAPGJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:09:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id t13so2313471pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M+ixhQyQ0wIvJQ8u89a765L0xXAvVV6mCNg8MpBKdjs=;
        b=RYWssyolPAtDytRLYL2d2rqS95AihQB0PABj6IEp9VTPcxDNvIBVmndbL+fzWuhOnJ
         LXquJJXc4F+TFFhXTmrB8HUmE4Iw6GoGwDq8btgiqRp3jOjhhIQeMP/Co0ZqoIRK/vM+
         VUVM6qGb/Khm6psEOYcpRxgyd792tD+wTPSHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M+ixhQyQ0wIvJQ8u89a765L0xXAvVV6mCNg8MpBKdjs=;
        b=D0KyQDqmHCarzoLKq/TDncfDOeND8O5DHyDRHBIoKIov9+lcrP4HI2OZM3PmyW3q+4
         I5iFGg7YZsiKa3sWCqGCJj+OYLwjvo8oKzH1dXTMgLZmCox8zS8YykLsxdMF3jqF7rBK
         Cc9T+ypdWpxWAd4F2f58HzBRV4VYGx7CHUlBpUcs4X6jBHPG7fXUruRaJULq/fuKFTee
         i5nyrm++6mvOkDeMn22io+eY85AC8Rb42IXk1CVrgDDjXzfMbl1R36cZQXQ8ASSGK9ib
         ICwiCtvHhmOTHPzAKXV7M1iCWdlwtbXxVO3JIVSCX+r38HPMyGngYr6USCRgQ760BtCk
         1WaA==
X-Gm-Message-State: AJcUukfJGRo5KF6DwoDP9iVUckQ8PSzrGYKjbPAlbHFDpXe1vCIIacdz
        RFlUTcD8SWUOvV9ncfxoKTtW6w==
X-Google-Smtp-Source: ALg8bN4RzpnVGDfKC6dQVgaFbBs23OKVAzEhDsZyGxbFH43aytp2ds0CeegvdDLwj/iwiGDk5nO5Bg==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr8092327pfi.172.1547618992565;
        Tue, 15 Jan 2019 22:09:52 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c7sm10762871pfh.18.2019.01.15.22.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 22:09:51 -0800 (PST)
Date:   Tue, 15 Jan 2019 22:09:10 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, david.brown@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add lpasscc node
Message-ID: <20190116060910.GA6841@builder>
References: <1543996836-16717-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543996836-16717-1-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05 Dec 00:00 PST 2018, Taniya Das wrote:

> This adds the low pass audio clock controller node to sdm845 based on
> the example in the bindings.
> 

Applying this causes my MTP to reboot as clk_disable_unused() tries to
disable "lpass_qdsp6ss_core_clk". Am I missing something?

Regards,
Bjorn

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 4 +++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index b3def03..cf73f3c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -346,7 +346,9 @@
>  &gcc {
>  	protected-clocks = <GCC_QSPI_CORE_CLK>,
>  			   <GCC_QSPI_CORE_CLK_SRC>,
> -			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
> +			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +			   <GCC_LPASS_Q6_AXI_CLK>,
> +			   <GCC_LPASS_SWAY_CLK>;
>  };
> 
>  &i2c10 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1419b00..a3db089 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -7,6 +7,7 @@
> 
>  #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/clock/qcom,lpass-sdm845.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> @@ -1264,6 +1265,13 @@
>  			#power-domain-cells = <1>;
>  		};
> 
> +		lpasscc: clock-controller@17014000 {
> +			compatible = "qcom,sdm845-lpasscc";
> +			reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
> +			reg-names = "cc", "qdsp6ss";
> +			#clock-cells = <1>;
> +		};
> +
>  		tsens0: thermal-sensor@c263000 {
>  			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
>  			reg = <0xc263000 0x1ff>, /* TM */
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 

Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18217C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26D020870
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGeip17K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26D020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbeGKQno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:43:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42670 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388256AbeGKQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:43:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id f4-v6so5201722plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCbumMildgd7jmmHFkA0002n0ukBdAZCR7GbymlfnyU=;
        b=FGeip17KqaO3KCDGr7JgofkDkp0K5bVeHAbB8htDP0hRRyZib6JD0U1KJEiY+aEKzM
         gb9AgZNwkotWvYgTvOkePzUpfpM7NSkU2LzvtBJCJGxcxeme1kXdaAFUS95jnPad8u76
         ry+QB6D4CdVeh2C75+A3cLSp3d5KVNyGQh0JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCbumMildgd7jmmHFkA0002n0ukBdAZCR7GbymlfnyU=;
        b=qnOyui5j3uWZKea3C8kjzOb1AksymCm2z0KDCgxeq3gETJM+sTlJ63rzdqBIkMUeJQ
         VYmNM25zj+z0nYqw+d0HjNWpBWaBOnmclRjIGViOhklXeGx5GDdlxPY/i2e8Ct2NatAh
         mfOxZjLUM3Vk65SR/sU+iNByyml2fCIML+z8o0bc42luhaOX/B0bLVg0ufsysLiBwAlo
         2DMRcb3r0TY5LOzbGydtZEAupWNaAePuVok52sTYJRdY8igLztzbddxCa2qnpBsvpiF0
         5daV4lMatgQgFmRSJaj+hENrZyKZ99VOI4w6GtsAqxiRF7++29tfQqeZSphx0QLchyTc
         qwfQ==
X-Gm-Message-State: APt69E1AN07NmVkyCf4p8hnPiu3OV7EQIfDNCTnaZg6lP7f7JPlxpXlm
        ve4aVFBHiRmVAOjiJ8mA6JC53Q==
X-Google-Smtp-Source: AAOMgpcW9AQ+r8OtdP9dxgTT++vd1q2WEfkfnLK4ssDiBvK1vEdj5IkfAC699PVpHzw4A1CTlnX92A==
X-Received: by 2002:a17:902:a24:: with SMTP id 33-v6mr29335728plo.88.1531327115012;
        Wed, 11 Jul 2018 09:38:35 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j190-v6sm2929850pgc.75.2018.07.11.09.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:38:34 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:41:15 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 7/7] arm64: dts: sdm845: Add tsens nodes
Message-ID: <20180711164115.GE545@tuxbook-pro>
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c39c405076627bd43ec94c211c6998191b9f16.1531136000.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 04:43 PDT 2018, Amit Kucheria wrote:

> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors. It uses version 2 of the TSENS IP, so use the fallback property to
> allow more common code.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb..ba2899c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		tsens0: tsens@c263000 {
> +			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +			reg = <0xc263000 0x1ff>, /* TM */
> +			      <0xc222000 0x1ff>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: tsens@c265000 {
> +			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
> +			reg = <0xc265000 0x1ff>, /* TM */
> +			      <0xc223000 0x1ff>; /* SROT */
> +			#qcom,sensors = <8>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0xc440000 0x1100>,
> -- 
> 2.7.4
> 

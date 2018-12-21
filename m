Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D72C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E942C21720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WC4DGYjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391591AbeLUTSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:18:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33344 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389487AbeLUTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:18:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so2920085plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNZkKTW9ghPAsFPXFwikUlad7at8yj0BUqI3ImS0Ju8=;
        b=WC4DGYjLK+EfsL5/zGoJytngU4/SQgejCGGtnVV/hAhcaKTu/AK9dZhm2Vpy3xqVzH
         DsWLPA5w/uyG+m7hPX3gxWIRyK1W3rcz1npYz+sfTllf76MK+3qDVyhKfjb9p9ZvnCUT
         nRsfbzzBtvydRSXzb3UyuuP/XIy8fII13pzd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNZkKTW9ghPAsFPXFwikUlad7at8yj0BUqI3ImS0Ju8=;
        b=dvLouYJlj7x7fBvdWICza5YkLidV4UUn/SPUXBdVWw7Vx2V3sCQT9Znm94SsJht/At
         QdfrAV8CUEFqFKXSDp3rUfg8Lcz/7Ytszs8fGp8a5kLDMuGRwSf9aMkr5wSDNrlqnKDv
         WFuV6sF66Z76zN94gAY556R7OU9ntqpcMS6mo8sB/LSharrendLLEXPSZckqKMH2366u
         JbsXOdPso+Wic1KyxS3HSBvhqyZqk5auQXrotxHahjcJWHV9BIw4c27VJ4z7W9PrQM1O
         Lvtxc5pbOWTFF15ax8CL1UWOBbSjIvyWaqyL7se7KwsdObbwZG0W9F1mAkr0mMNcIMmy
         NYng==
X-Gm-Message-State: AJcUukdf0DUsCTVnicFjuUp15G2llF1gJqnr3QBlewie5wG/8jcMjjnO
        adoU+YEEwzPYzyK0W/jdg13rQw==
X-Google-Smtp-Source: ALg8bN5ta+9fNX8AZJ25kfL3clHROmwbFVsVkvdFHWEJs/bidtQGLUT6vyqqBGPtNWAxU0H05vrU/Q==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr3651295plh.99.1545419932696;
        Fri, 21 Dec 2018 11:18:52 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d21sm40390507pgv.37.2018.12.21.11.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 11:18:52 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:18:51 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, david.brown@linaro.org,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        amit.kucheria@linaro.org
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add cpufreq device node
Message-ID: <20181221191851.GC261387@google.com>
References: <1545416063-22552-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545416063-22552-1-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 11:44:23PM +0530, Taniya Das wrote:
> This change adds the cpufreq node as per the bindings example for SDM845.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 23a253b..a69a21e 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -99,6 +99,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_0>;
>  			L2_0: l2-cache {
>  				compatible = "cache";
> @@ -114,6 +115,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_100>;
>  			L2_100: l2-cache {
>  				compatible = "cache";
> @@ -126,6 +128,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x200>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_200>;
>  			L2_200: l2-cache {
>  				compatible = "cache";
> @@ -138,6 +141,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x300>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			next-level-cache = <&L2_300>;
>  			L2_300: l2-cache {
>  				compatible = "cache";
> @@ -150,6 +154,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x400>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_400>;
>  			L2_400: l2-cache {
>  				compatible = "cache";
> @@ -162,6 +167,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x500>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_500>;
>  			L2_500: l2-cache {
>  				compatible = "cache";
> @@ -174,6 +180,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x600>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_600>;
>  			L2_600: l2-cache {
>  				compatible = "cache";
> @@ -186,6 +193,7 @@
>  			compatible = "qcom,kryo385";
>  			reg = <0x0 0x700>;
>  			enable-method = "psci";
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			next-level-cache = <&L2_700>;
>  			L2_700: l2-cache {
>  				compatible = "cache";
> @@ -1686,6 +1694,17 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		cpufreq_hw: cpufreq@17d43000 {
> +			compatible = "qcom,cpufreq-hw";
> +			reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
> +			reg-names = "freq-domain0", "freq-domain1";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +			clock-names = "xo", "alternate";
> +
> +			#freq-domain-cells = <1>;
> +		};
>  	};
> 
>  	thermal-zones {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks

Matthias

Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D0EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30E8222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LstBb9Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbfBNHMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:12:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44870 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfBNHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:12:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so2652131plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 23:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UFUxl+Fljm7yqlfrAchzNpMXHkNbSIOG02QGuZvFWpc=;
        b=LstBb9Pwynk2kwzMvrgXvs01+bT8CIfvaeQWBGiPjcTgGkiZG3EBCQ1e3WAJuAJ0XA
         Rjp/z13BhWFFiNsKmyf+kqdTy8ob4ULuXOpP6B1dIUADF+NF/F2589qkuO7TdJ4KZJWX
         1R9Na5rIPM4dxxlAdsspWrYFOw6iJtWKylQaEmoRCAU6gUyIhBG/5lJcCLyIpiqPkGZ6
         9alBpsHe75yhfA+Ih1hrUfZ3GquiFKfA8x1kufhWyampHnUIEEw5vw8o8MR1kcZO65OS
         bpFyPZO7pFN3xhuvNBE4zeLurmt1b3zjnJ9PJ3jjKKLd61XgC1C4U9l/IQLncUgedIel
         /huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UFUxl+Fljm7yqlfrAchzNpMXHkNbSIOG02QGuZvFWpc=;
        b=R/CVvyehA5rUzpSsF2IyV9jTWGy9EWGzOjTSm8S9EuQojBAjszNlpPgnRvyaCpzjLR
         LUcbOcs2SM5FeMXIi0nDm/k/lYlhLyd2iSicOw0LwZ9BulDjtNCs2aCVW9fieEmzdb5z
         T7jsvYyNrw+F2dfPQQoI1eAhyi6PPV0rfyYDTmiX1WHF+tEwpF2bl96PthCdDTADogkF
         w/LLMeqk6+TA0a9PQiV0fUYQRwNfDIwAaob4qxYeNfQa1fXZsWN5lkdmrq7C0s+U6T+C
         SL1qHdciSDSYO59pJSSCp0eRGPdhJ1KTxJcJEz/g9/cu6ohdj6kuhLbbsK0DRs4hOJLX
         M7dA==
X-Gm-Message-State: AHQUAuYrwlbynknt9tWrcJGNm5r/eq8yhxrpWO3BfbphM2/GuE7sBwyT
        3iPKyHzUKHw61JDfyqnCCpS1HQ==
X-Google-Smtp-Source: AHgI3Ib4ToWIHPDvYuqj7oSDLZt95BaIPm9ck5ZYpZgPoYIFFOk+ystVUKtsvCu42axUckdhp+vXuA==
X-Received: by 2002:a17:902:e087:: with SMTP id cb7mr2585329plb.313.1550128359043;
        Wed, 13 Feb 2019 23:12:39 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y12sm1937330pgh.38.2019.02.13.23.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 23:12:38 -0800 (PST)
Date:   Thu, 14 Feb 2019 12:42:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V4 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190214071233.7uypqihkfasxqyw6@vireshk-i7>
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-19, 01:54, Anson Huang wrote:
> Add i.MX8QXP CPU opp table to support cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change since V3.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4021f25..593e2db 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -34,6 +34,10 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;
> +			clock-latency = <61036>;

Who uses this value ? And why is it different from the one mentioned
in the OPP table ?

> +			#cooling-cells = <2>;

clocks and cooling-cells must be defined for all the CPUs.

> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_1: cpu@1 {
> @@ -42,6 +46,7 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_2: cpu@2 {
> @@ -50,6 +55,7 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_3: cpu@3 {
> @@ -58,6 +64,7 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			operating-points-v2 = <&a35_0_opp_table>;
>  		};
>  
>  		A35_L2: l2-cache0 {
> @@ -65,6 +72,24 @@
>  		};
>  	};
>  
> +	a35_0_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-900000000 {
> +			opp-hz = /bits/ 64 <900000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <150000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <150000>;
> +			opp-suspend;

You want to go to a higher frequency on suspend ?

> +		};
> +	};
> +
>  	gic: interrupt-controller@51a00000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> -- 
> 2.7.4

-- 
viresh

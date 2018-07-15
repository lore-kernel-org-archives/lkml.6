Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22287ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D335B2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 14:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WizLeGwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D335B2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeGOPOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:14:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43612 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeGOPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:14:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id v13-v6so6557817pgr.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2flE3noEECKVKBcgF+Ddu+JchgI8mi+aWz4JgiqPjts=;
        b=WizLeGwLh6lYh5sp3VRKEi551wHSV8J6D8L9HTS/Pg4sENWBmwtbr9Sx79syRdKizy
         vHCzNZXue+Du8OnhH28pIlxoo/VMJGYu+GTe3FCUNpv8Wj+jZxCyHiFOqU1yn3pDuFgA
         F9EDjk9r2L2MGB2tOSk/DHuT6SB/xIz+3N2ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2flE3noEECKVKBcgF+Ddu+JchgI8mi+aWz4JgiqPjts=;
        b=ZsKZ3P8czNFqKnDN4wHKDUu+8KCxi5mCRBwQ5x59wqisUKnbw2MeBVzjrPsG7dxWdr
         +DJEPtlGrUz95a84nfL2jg1hsqrMu1w65MaVEb2ShUy2WKv1Ue22cq3eT1+Elj9Akhny
         MjRk72SonSD7oeJdckda6uvD3qyhrW9YEKAZFhrKw1A+sCS3D8TMbkm06Tp8BC6Sz90O
         2d/WeCYi+XBfZHX0QnHD4Ky72RrX2VLIrJUfRNChUtsyrFdAofDv+q2KwbQq0K+xHpZq
         8PO6OaAI7jdgiPxRVf0tUDfvqHQSzrQCy/57kVFsqh6FDI887PR0PCAWAb9BgLI5gFgn
         n5Kw==
X-Gm-Message-State: AOUpUlEhexZBKJTy7jXIz7O5UActvj15SjMpsQw3enphXO3srXmImmpz
        GuFtRoW5gEmCeIbyOOhH1G6LYy/KsA==
X-Google-Smtp-Source: AAOMgpda3wwltR7x2m5TpzoMfQv7+RnzUs2QnXL0ol/7FTRfkWM5Jl9D6cq8j+9cVyMy6qCtjLuBYA==
X-Received: by 2002:a63:291:: with SMTP id 139-v6mr12659620pgc.365.1531666289883;
        Sun, 15 Jul 2018 07:51:29 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:71c5:dcf2:1082:c344:2c7e:f99b])
        by smtp.gmail.com with ESMTPSA id b67-v6sm100817433pfd.74.2018.07.15.07.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 07:51:29 -0700 (PDT)
Date:   Sun, 15 Jul 2018 20:21:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux@cubietech.com,
        support@cubietech.com, catalin.marinas@arm.com,
        mturquette@baylibre.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        darren@cubietech.com, robh+dt@kernel.org,
        jeff.chen@actions-semi.com, pn@denx.de, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mp-cs@actions-semi.com
Subject: Re: [PATCH v4 4/5] arm64: dts: actions: Enable clock controller for
 S700
Message-ID: <20180715145115.GE9980@Mani-XPS-13-9360>
References: <20180715123145.16975-1-sravanhome@gmail.com>
 <20180715123145.16975-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715123145.16975-5-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 15, 2018 at 02:31:44PM +0200, Saravanan Sekar wrote:
> Added clock management controller for S700
> 

Commit message can be as below:

Add Clock Management Unit binding for Actions Semi S700 SoC.

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 66dd5309f0a2..19998f19af60 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/actions,s700-cmu.h>
>  
>  / {
>  	compatible = "actions,s700";
> @@ -44,6 +45,13 @@
>  		};
>  	};
>  
> +	clock: clock-controller@e0168000 {

Following the S900 dts, label can be "cmu" instead of "clock".

> +		compatible = "actions,s700-cmu";
> +		reg = <0 0xe0168000 0 0x1000>;

Should be:

reg = <0x0 0xe0168000 0x0 0x1000>;

Thanks,
Mani

> +		clocks = <&hosc>, <&losc>;
> +		#clock-cells = <1>;
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -87,6 +95,12 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	losc: losc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> -- 
> 2.18.0
> 

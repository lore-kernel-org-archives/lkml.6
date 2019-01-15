Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC61C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5B420659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9YxR+6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfAOAmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:42:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfAOAmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:42:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so416053pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAlMM3wam1EnEZPTz8hjwvSQAf8cQua8KxIh0XvQWUY=;
        b=B9YxR+6P2MVrW8WeQTO89fR2UBRsBXhi8Lms4mvUTQgJJXkNbkpD716UGG6ty1cYMh
         8Ks+3WFvz+rRzD8kgLOnh4OAekecXPZqVn2ebshRBXOmQrFt3t0tpzKkHNiEv2cV1Jrm
         K2R9lvawbhhL1SndKBzVaGlh+enKdZ+VLO2qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAlMM3wam1EnEZPTz8hjwvSQAf8cQua8KxIh0XvQWUY=;
        b=nlBwxL2iIx60uURzBahu6JwpiJtBgTAMzFJtB6girj2IyZmZ75wMB3rOKPv0FdAGKn
         jNeNIdFUE+R2t0MIcxM71bHdsXEQVI37i942p4TU0GhA/KMmznxbUBC90I1Z9+wsvAa2
         GZx8Vsfs54w3Yb5bBqA1ZyKSvijPtqweFXqBC/h2Kq6aBbP1Aaqk7RNyJIj02XXOnTDu
         c6z5Prp28B9XINhHqcfRLK62ZmGD8Km9nhQX34GH3n5fEMl6BdTqLl5bHQoAT2kL8X1O
         eD0vIbWIOerk83V/8diX5M2zbaZdLbiGisc5l5qwg6zawpvXiqze72OWXkUbRsJbyH90
         WM7g==
X-Gm-Message-State: AJcUukdeU49Q9SojKLMdQXN9Zs5RYmMImm0Zrz2IBwgvzjXuujRytC6p
        CWZUKn62hR6v5hD7vP3E6wxgwA==
X-Google-Smtp-Source: ALg8bN4i47hA2CL8YJ3U1tFGGsBmleZRTyYkabKtP3zNvK2nyRpnWvNjBbx+MUb5vj9p3np95DraRg==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr1199555pfd.224.1547512965423;
        Mon, 14 Jan 2019 16:42:45 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id n21sm2192951pfg.84.2019.01.14.16.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:42:44 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:42:41 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/14] ARM: dts: qcom: pm8941: add interrupt
 controller properties
Message-ID: <20190115004240.GL9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-9-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-9-masneyb@onstation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Jan 07:47 PST 2019, Brian Masney wrote:

> Add interrupt controller properties now that spmi-gpio is a proper
> hierarchical IRQ chip. The interrupts property is no longer needed so
> remove it. Code was tested on the LG Nexus 5 (hammerhead) phone.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Changes since v3:
> - None
> 
> Changes since v2:
> - Remove interrupt-parent property
> 
> Changes since v1:
> - Interrupts are now two cells instead of four cells.
> - Drop unnecessary interrupts property.
> 
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 38 ++----------------------------
>  1 file changed, 2 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index 2515c5c217ac..e65049e0fb45 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -64,42 +64,8 @@
>  			reg = <0xc000>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> -				     <0 0xc1 0 IRQ_TYPE_NONE>,
> -				     <0 0xc2 0 IRQ_TYPE_NONE>,
> -				     <0 0xc3 0 IRQ_TYPE_NONE>,
> -				     <0 0xc4 0 IRQ_TYPE_NONE>,
> -				     <0 0xc5 0 IRQ_TYPE_NONE>,
> -				     <0 0xc6 0 IRQ_TYPE_NONE>,
> -				     <0 0xc7 0 IRQ_TYPE_NONE>,
> -				     <0 0xc8 0 IRQ_TYPE_NONE>,
> -				     <0 0xc9 0 IRQ_TYPE_NONE>,
> -				     <0 0xca 0 IRQ_TYPE_NONE>,
> -				     <0 0xcb 0 IRQ_TYPE_NONE>,
> -				     <0 0xcc 0 IRQ_TYPE_NONE>,
> -				     <0 0xcd 0 IRQ_TYPE_NONE>,
> -				     <0 0xce 0 IRQ_TYPE_NONE>,
> -				     <0 0xcf 0 IRQ_TYPE_NONE>,
> -				     <0 0xd0 0 IRQ_TYPE_NONE>,
> -				     <0 0xd1 0 IRQ_TYPE_NONE>,
> -				     <0 0xd2 0 IRQ_TYPE_NONE>,
> -				     <0 0xd3 0 IRQ_TYPE_NONE>,
> -				     <0 0xd4 0 IRQ_TYPE_NONE>,
> -				     <0 0xd5 0 IRQ_TYPE_NONE>,
> -				     <0 0xd6 0 IRQ_TYPE_NONE>,
> -				     <0 0xd7 0 IRQ_TYPE_NONE>,
> -				     <0 0xd8 0 IRQ_TYPE_NONE>,
> -				     <0 0xd9 0 IRQ_TYPE_NONE>,
> -				     <0 0xda 0 IRQ_TYPE_NONE>,
> -				     <0 0xdb 0 IRQ_TYPE_NONE>,
> -				     <0 0xdc 0 IRQ_TYPE_NONE>,
> -				     <0 0xdd 0 IRQ_TYPE_NONE>,
> -				     <0 0xde 0 IRQ_TYPE_NONE>,
> -				     <0 0xdf 0 IRQ_TYPE_NONE>,
> -				     <0 0xe0 0 IRQ_TYPE_NONE>,
> -				     <0 0xe1 0 IRQ_TYPE_NONE>,
> -				     <0 0xe2 0 IRQ_TYPE_NONE>,
> -				     <0 0xe3 0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  
>  			boost_bypass_n_pin: boost-bypass {
>  				pins = "gpio21";
> -- 
> 2.17.2
> 

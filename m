Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B81C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6C7274CC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6DeqBik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6C7274CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966427AbeF1OIM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:08:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35341 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeF1OIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:08:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so9261670wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8zgQZ+mtp63Q/vuWBiCce7scpylc6F0UuNNTdapWpcQ=;
        b=K6DeqBikDMII4NT2/GCz6wXbJlPZqWWo3vzkm3/G4it37jUEOXIUAt2KiUUIr1AByv
         WiVstCFekMXPWM7yvtKoJ0Z4abIM11hmV+ku+t4c00KOGQGDLhUvSuWFrWtFnpJLKghB
         IYyW1kJRZOrCF4iOQddRW5s7Si8HJW+c32Ckk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8zgQZ+mtp63Q/vuWBiCce7scpylc6F0UuNNTdapWpcQ=;
        b=OHCBN8XTOLJIXY/FRoHZkyh3dIZiBHDsJIcod+v5kJwk3ieISiSSkTPtvHBGm+c2GZ
         EHlfEbwkQW9wh1BmP6Pb2/nlAwkqeR2R3aXlES7v8W/mYFRBIWwfu4TbPagz/TiI/viw
         P07Ggw8HcQF4pgnAZ75RPbyp4Wvg1gIwHuwi5N7QegoSyex3NZUpSTlS1+1BUhRBWdLR
         Q9gT9+wFfTPRKXWH5l3GxrgjiKkQEKQZ9l4TAMIqSKQjenX3GTrFopXLcELIYfAGCk/A
         /oo3fWSyL/g7GIY5H5TKEuD3HcQzrLLYwtOfdrLEFEoHYCwpGMLYOBWx7eSuYRr3a8rc
         1+sQ==
X-Gm-Message-State: APt69E0G6naXKrkp08QI0HBygsh84KQ5wyE9cTkyNb99fEvmKzcRHhjd
        ZXZqkI7hKpdft3JCPss/EjFf7g==
X-Google-Smtp-Source: AAOMgpdtmdDSGayS0ajud2pk2PWOvNk8Dn67950B/PQkguYOkgD3bdiXHG5ny3Af9Upr3pRaBauZyw==
X-Received: by 2002:a1c:58d5:: with SMTP id m204-v6mr8007259wmb.118.1530194889395;
        Thu, 28 Jun 2018 07:08:09 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:3923:5e2e:38ae:83dc? ([2001:41d0:fe90:b800:3923:5e2e:38ae:83dc])
        by smtp.googlemail.com with ESMTPSA id a12-v6sm7227828wrs.26.2018.06.28.07.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:08:08 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
 <1530182744-10731-2-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <93345c88-f880-5e2e-ae36-cf1b57df9bba@linaro.org>
Date:   Thu, 28 Jun 2018 16:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530182744-10731-2-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2018 12:45, Stanley Chu wrote:
> This patch fixes bindings of existed "General Purpose Timer",
> and then add bindings of new "System Timer" on Mediatek SoCs.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt          |   38 ++++++++++++++++----
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index b1fe7e9..d42247b 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -1,5 +1,14 @@
> -Mediatek MT6577, MT6572 and MT6589 Timers
> ----------------------------------------
> +Mediatek Timers
> +---------------
> +
> +Mediatek SoCs have two different timers on different platforms,
> +- GPT (General Purpose Timer)
> +- SYST (System Timer)
> +
> +Please bind correct timers in each platforms.
> +
> +
> +** General Purpose Timer (GPT)
>  
>  Required properties:
>  - compatible should contain:
> @@ -11,9 +20,8 @@ Required properties:
>  	* "mediatek,mt8135-timer" for MT8135 compatible timers
>  	* "mediatek,mt8173-timer" for MT8173 compatible timers
>  	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers
> -- reg: Should contain location and length for timers register.
> -- clocks: Clocks driving the timer hardware. This list should include two
> -	clocks. The order is system clock and as second clock the RTC clock.
> +- reg: Should contain location and length for GPT register.
> +- clocks: GPT is drived by system clock.
>  
>  Examples:
>  
> @@ -21,5 +29,23 @@ Examples:
>  		compatible = "mediatek,mt6577-timer";
>  		reg = <0x10008000 0x80>;
>  		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&system_clk>, <&rtc_clk>;
> +		clocks = <&system_clk>;
> +	};
> +
> +
> +** System Timer (SYST)
> +
> +Required properties:
> +- compatible: Should contain
> +	* "mediatek,mt6765-systimer" for MT6765 compatible timers
> +- reg: Should contain the location and length for system timer registers.
> +- clocks: System timer is drived by system clock.
> +
> +Examples:
> +
> +	systimer@10017000 {
> +		compatible = "mediatek,mt6765-systimer";

why not "mediatek,mt6765-timer" ? for consistency.

> +		reg = <0 0x10017000 0 0x1000>;
> +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&system_clk>;
>  	};
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


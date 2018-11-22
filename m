Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E71C04EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAA42081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZPqD6Gp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAA42081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436801AbeKWADG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:03:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35550 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388885AbeKWADF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:03:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so9093070wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 05:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4w0MIK4419v8QaqU3k3Um9A+0am0yvH61l+/nftgpcY=;
        b=MZPqD6Gp8Y5+2NvcXP8TLr/LWIW5nSzKvkb+ljA0P2Qg5vq0ym5P6snUQVCllfjqsM
         /6ulI+WZQIOhvGs61/mTurJf6i2h0h3sYEULf+eSy5uoFjeOVaavOhrNxHWNrvb+6lvU
         X/1K36zTbhq45+DyDX5/wa1UP4jEoRrtgMtLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4w0MIK4419v8QaqU3k3Um9A+0am0yvH61l+/nftgpcY=;
        b=TBx7nSR7osl+mfWEJuOvMjfNcVcEoRAohTe1nyCSlGl9XO8yfjpX2nd0+RE+BAdjlt
         6F98nWVX4K1NDurYd0W+yuTcfMh6WhG9kfq4jDyn0c3fzbkzf8sYykjbI3LlWwA5q4e/
         H3p2SazHa5krdJIHSE44wq8lOFlAGXKYZc5Ni0xdwV/tAZ32FxYlIJYSTUGpwaOyNHXu
         feuFGs5Jbh+8C+5BGDtLwPxtKM1V8NzK16qUboDt/k4Jm4rHITHY9BA9Ivsi4dyRQSFf
         6mL0SQSA7Mr03Sm2ENx8k0+De4zIArFx+ZgcivW0cUrWe7f6vRW9TMkftsP5cr/J5tTV
         eTMw==
X-Gm-Message-State: AGRZ1gLaaWHsqIIvIdQj0sME03oo1zHwluVdzhr6PvuCX5GV65mNmBJR
        R/ov5jaIr5aLFv+QBqF31Sqw6w==
X-Google-Smtp-Source: AJdET5efw2jP3yCuEX3araxDIGMpqJwUZO2onQ/qLt/X4b6NJvv5aAXRdkgyWi7ytZQxcMHXT+tZiA==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr9283584wma.91.1542893024427;
        Thu, 22 Nov 2018 05:23:44 -0800 (PST)
Received: from [192.168.0.40] (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.googlemail.com with ESMTPSA id 134-v6sm5450488wmp.6.2018.11.22.05.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:23:43 -0800 (PST)
Subject: Re: [RFC PATCH v3 07/17] clocksource: sun4i: add a compatible for
 suniv
To:     Mesih Kilinc <mesihkilinc@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
 <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a732f908-c70e-ce30-ad18-ddbb6879995f@linaro.org>
Date:   Thu, 22 Nov 2018 14:23:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <60bc70fc43743f664de76abf3ab0a01cd7924458.1542824904.git.mesihkilinc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 19:30, Mesih Kilinc wrote:
> The suniv (new F-series) chip has a timer with less functionality than
> the A10 timer, e.g. it has only 3 channels.
> 
> Add a new compatible for it. As we didn't use the extra channels on A10
> either now, the code needn't to be changed.
> 
> The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.
> 
> Register sun4i_timer as sched_clock on it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/clocksource/sun4i_timer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> index 6e0180a..65f38f6 100644
> --- a/drivers/clocksource/sun4i_timer.c
> +++ b/drivers/clocksource/sun4i_timer.c
> @@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
>  	 */
>  	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
>  	    of_machine_is_compatible("allwinner,sun5i-a13") ||
> -	    of_machine_is_compatible("allwinner,sun5i-a10s"))
> +	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
> +	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
>  		sched_clock_register(sun4i_timer_sched_read, 32,
>  				     timer_of_rate(&to));
>  
> @@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
>  }
>  TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
>  		       sun4i_timer_init);
> +TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
> +		       sun4i_timer_init);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D397C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21F0208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNCzNYTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21F0208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933939AbeGJPC1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:02:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55024 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933740AbeGJPCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:02:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so24851141wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VR6DncitMqpZqCenywT1zeem8LmqSgvOL6GHWXJNk5g=;
        b=ZNCzNYTjGkQVBihk0LLO6ghZw2ZretswvPV381tnB4QZvijBYJHcCR94qHWsDdbIBC
         HqtDvck41UKRi07w/8Cfupv0/x59BZSZgyEot7ZHAVo0LVeQF4XVnlnwiXbPQzm5hlW4
         CxSh2vdQ5ZKL4AWEOBfKZFtvVstvNevEbD3o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VR6DncitMqpZqCenywT1zeem8LmqSgvOL6GHWXJNk5g=;
        b=PyVsbqZP7WrTSvge2X38EwqW4Od60ri3pZ+fIVmmqmks9ccE2emFKiDqIQPA5TTs2u
         Xav6MPg3qEjS+p+GzbAg0XjRH7NeS4omroaaKxn2Z3mFlXhkO3MIdHwLTQ21SRK2AF/X
         9jtYzdr4HMK8M8iGj/H0epwwaQB2G+OHss1OXcnMUS+GlxQN9uH8EF+HQAWQsYQhpIix
         DaiAhEcmTYp9RfuYwD8/HTaUJhrKfMNPT9hXsd72urUWMQ9IhYBpvgjyKOe22IKQrGdD
         s17OcVpd5w6ovL8ZnzpCMd9EpVdK42ME6N6Jsq1caayolytnpBqsXIEy97ReDHPyJ5Ov
         osaA==
X-Gm-Message-State: APt69E2OZPXQw1C5/Ve7FkHXbftrpoKaCONKlQAh2KH/oOjcMOmKEAKZ
        ndQBO3D+dQtTa6bLPJsMEvOdhg==
X-Google-Smtp-Source: AAOMgpdeTfTYkZclRhuYL/HpZEvqwXoirnVA15arcGZXIkoq89tvOJEw2K9bEpPU41nEWw66kDKxZw==
X-Received: by 2002:a1c:6d2:: with SMTP id 201-v6mr14070348wmg.47.1531234942427;
        Tue, 10 Jul 2018 08:02:22 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.242.72])
        by smtp.googlemail.com with ESMTPSA id f18-v6sm15432271wrt.64.2018.07.10.08.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:02:21 -0700 (PDT)
Subject: Re: [PATCH v9 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530832288-8156-1-git-send-email-stanley.chu@mediatek.com>
 <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a4c1a9cf-4d48-a9a7-e7ac-d94685c30619@linaro.org>
Date:   Tue, 10 Jul 2018 17:02:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob ? Are you fine with this change ?

On 06/07/2018 01:11, Stanley Chu wrote:
> This patch adds bindings of new "System Timer" on Mediatek SoCs.
> 
> Remove RTC clock in the same time because it is not used by
> both "General Purpose Timer" and "System Timer" now.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt          |   34 ++++++++++++--------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index b1fe7e9..18d4d01 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -1,19 +1,25 @@
> -Mediatek MT6577, MT6572 and MT6589 Timers
> ----------------------------------------
> +Mediatek Timers
> +---------------
> +
> +Mediatek SoCs have two different timers on different platforms,
> +- GPT (General Purpose Timer)
> +- SYST (System Timer)
> +
> +The proper timer will be selected automatically by driver.
>  
>  Required properties:
>  - compatible should contain:
> -	* "mediatek,mt2701-timer" for MT2701 compatible timers
> -	* "mediatek,mt6580-timer" for MT6580 compatible timers
> -	* "mediatek,mt6589-timer" for MT6589 compatible timers
> -	* "mediatek,mt7623-timer" for MT7623 compatible timers
> -	* "mediatek,mt8127-timer" for MT8127 compatible timers
> -	* "mediatek,mt8135-timer" for MT8135 compatible timers
> -	* "mediatek,mt8173-timer" for MT8173 compatible timers
> -	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers
> -- reg: Should contain location and length for timers register.
> -- clocks: Clocks driving the timer hardware. This list should include two
> -	clocks. The order is system clock and as second clock the RTC clock.
> +	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
> +	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
> +	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
> +	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
> +	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
> +	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
> +	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
> +	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
> +	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
> +- reg: Should contain location and length for timer register.
> +- clocks: Should contain system clock.
>  
>  Examples:
>  
> @@ -21,5 +27,5 @@ Examples:
>  		compatible = "mediatek,mt6577-timer";
>  		reg = <0x10008000 0x80>;
>  		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&system_clk>, <&rtc_clk>;
> +		clocks = <&system_clk>;
>  	};
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


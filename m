Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066D5C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51EE20849
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51EE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754357AbeGEVP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:15:57 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46574 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbeGEVPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:15:55 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so19557308oie.13;
        Thu, 05 Jul 2018 14:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2x0ON1BbNj8lYhagclu9D0aGZukA8sr6ZEuTW/pQGg=;
        b=g0uvTlHHLEap/N9JG2yCX8IFlyogFYy93RVso5jRKF3M/TgfhTprcREYhwObxbf5St
         A/LX95gqyvD+sfaSGqpSPkjxFIR3/TgK49qGizEdZ/tAerkDH/n+r7CsNWzgC55b3UIM
         SMyxjRrxYmnhwA5yq3PWO5ipSonoRwdrtG8LVsnKR57mZ4Pka97KY4hURhVHUJ84IAUM
         pKwhvcb3ATYZql8w6qUC4rU6tyP6l0raav0equY4ddb/oFhj3R+1RDa1MWEs3LXvHoMU
         RShECPup0Lf9xFiQs7jit0mKn79sJAWVHjGEwUfLMg8ZcEUNJxRSIqeIXCmqpWO8cApV
         NZXw==
X-Gm-Message-State: APt69E0EeFBEipMmnmbe285Ucs8DsEnYYZp8+Q92axkJLAb43Pd5WTt/
        ciGs1G2cTNTY8fS7xTYn3Q==
X-Google-Smtp-Source: AAOMgpe3Ty+0Jp6HpsdirknbeiPrrjkcm+0wmNuclntYGGZrxbLIY41MeJAOMcOL3COVEl+WngCtkw==
X-Received: by 2002:aca:2cce:: with SMTP id s197-v6mr8221522ois.125.1530825354905;
        Thu, 05 Jul 2018 14:15:54 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r3-v6sm3987671oig.49.2018.07.05.14.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:15:54 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:15:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v7 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
Message-ID: <20180705211552.GA3699@rob-hp-laptop>
References: <1530752972-833-1-git-send-email-stanley.chu@mediatek.com>
 <1530752972-833-2-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530752972-833-2-git-send-email-stanley.chu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:09:28AM +0800, Stanley Chu wrote:
> This patch fixes bindings of existed "General Purpose Timer",
> and then add bindings of new "System Timer" on Mediatek SoCs.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt          |   36 ++++++++++++--------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index b1fe7e9..0f3b8a1 100644
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
> +- clocks: Both timers are driven by system clock.

The binding just needs to say how many clocks, what they are and the 
order.

You need to explain in the commit message why you remove the RTC clock.

>  
>  Examples:
>  
> @@ -21,5 +27,5 @@ Examples:
>  		compatible = "mediatek,mt6577-timer";
>  		reg = <0x10008000 0x80>;
>  		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&system_clk>, <&rtc_clk>;
> -	};
> +		clocks = <&system_clk>;
> +	};
> \ No newline at end of file

Fix this.

> -- 
> 1.7.9.5
> 

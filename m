Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B56C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0063124749
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0063124749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeGCXdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:33:00 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:38721 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeGCXc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:32:59 -0400
Received: by mail-yb0-f195.google.com with SMTP id i9-v6so1386935ybo.5;
        Tue, 03 Jul 2018 16:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZVLhj9D0+qv+EYqBS3bVo+hEvPrWbMwgGOIRq76k3g=;
        b=NE0yL3hZfs/o+RxLvmIJASiY4p0PvgzEX+M9M+0A8LUDiQkLODWzaGBY6qeHkg8k+M
         OBESp39RQHx8HDsI4orAmdwaATobY1FG/8GKMo6E9dlnfMLH41gNU81r6oALF5ulz10q
         A6CfvYx+iPk3BbrokJLlEq2wJDJeNdlKkTHdcnzquXK7JSHzEKxPOnIwOvAsSSfa+Zxm
         y2xKmhfTRwZYJ7RcVtI62cXeQhvjvl1C/VlBqLvxS4gnzaFnsJklU6j2eRDqXZ1LgzK/
         En5BzLSxgs3b0IpHngFRfSVC/tgobDK3xOm23ZyEu28/2dIi6aSqPRWQ8exSvNNY1lSN
         wLNw==
X-Gm-Message-State: APt69E2YxgL/GxDRXmYeh2aIVDO1vzMfvZ5fovicTqhfLZi2PVZfxyUj
        +tDRh9tPVu3jBEf8DAmbJg==
X-Google-Smtp-Source: AAOMgpdJuRrqGY4AJGv37jTlr3k9N/15gnpfi6Nz89L4v7mQfTD1KQni7SewnlHwI3IFBTbVgVQ3zg==
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr3858842ybi.247.1530660778426;
        Tue, 03 Jul 2018 16:32:58 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h68-v6sm184177ywd.43.2018.07.03.16.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:32:57 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:32:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v4 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
Message-ID: <20180703233256.GA27424@rob-hp-laptop>
References: <1530231446-13760-1-git-send-email-stanley.chu@mediatek.com>
 <1530231446-13760-2-git-send-email-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530231446-13760-2-git-send-email-stanley.chu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 08:17:22AM +0800, Stanley Chu wrote:
> This patch fixes bindings of existed "General Purpose Timer",
> and then add bindings of new "System Timer" on Mediatek SoCs.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  .../bindings/timer/mediatek,mtk-timer.txt          |   38 ++++++++++++++++----
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index b1fe7e9..605fd8f 100644
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

s/drived/driven/

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
> +	* "mediatek,mt6765-timer" for MT6765 compatible timers
> +- reg: Should contain the location and length for system timer registers.
> +- clocks: System timer is drived by system clock.

These look the same. Can't you just add the compatible string and note 
in the description it is the system timer. Or make the compatible 
"mediatek,mt6765-systimer"

> +
> +Examples:
> +
> +	systimer@10017000 {

timer@

> +		compatible = "mediatek,mt6765-timer";
> +		reg = <0 0x10017000 0 0x1000>;
> +		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&system_clk>;
>  	};
> -- 
> 1.7.9.5
> 

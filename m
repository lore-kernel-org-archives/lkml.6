Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B48AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3FF216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3FF216FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeHHJRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:17:13 -0400
Received: from muru.com ([72.249.23.125]:52934 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbeHHJRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:17:13 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CE31C805C;
        Wed,  8 Aug 2018 07:02:26 +0000 (UTC)
Date:   Tue, 7 Aug 2018 23:58:52 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        baolin.wang@linaro.org, d-gerlach@ti.com, grygorii.strashko@ti.com,
        t-kristo@ti.com
Subject: Re: [PATCH] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
Message-ID: <20180808065852.GO99251@atomide.com>
References: <1533633926-28908-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533633926-28908-1-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180807 09:29]:
> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
> add the flag for all the other SoCs.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com> 

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/clocksource/timer-ti-32k.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
> index 29e2e1a..dd09171 100644
> --- a/drivers/clocksource/timer-ti-32k.c
> +++ b/drivers/clocksource/timer-ti-32k.c
> @@ -97,6 +97,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
>  		return -ENXIO;
>  	}
>  
> +	if (!of_machine_is_compatible("ti,am4372"))
> +		ti_32k_timer.cs.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
> +
>  	ti_32k_timer.counter = ti_32k_timer.base;
>  
>  	/*
> -- 
> 1.9.1
> 

Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B9DC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC37274C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbI7ljFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC37274C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753816AbeF1ODS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:03:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33033 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbeF1ODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:03:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so20934072wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=54IaGINc7EPrVviZUY2cez86fG7QH5OUOnEHq1qwQ8I=;
        b=MbI7ljFINvvpGrf/lqCuXFAF3/9zHLcApaau8OkPMwWqLWYnphM7oLZexI15SjUrrT
         y8Vzu0YAdDikUHIE8M48n+HAENzjDqe1quQu+s/M9bd5/+LHbI2FkT/K1ySLE/nGMWWE
         95LMdoiBM99l9q6mrQTnMBln+TFRiNN+iWtcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=54IaGINc7EPrVviZUY2cez86fG7QH5OUOnEHq1qwQ8I=;
        b=trb2tA05hC5JX6WgiypLbB4yaEzOX0jtKikRuQsdLGmP1VVrW9OMA5Hlel7n3jXQD2
         qr1qQuvn4zkjvBTa4ERvIY5OLngiIrf+PennqBvqMhktJKXrePinpp+DGqSfr+2SZMmy
         TR5AQK3MHhMyxljBP8z2bF1WWjkhHNrY0Y5ZwulH0PCaTq8EoY7FU37tMyXo7EpmXyBV
         qEuK51F0iX6T/T+GQrPkACpC95iOiGkw6X9YI35UhKhKI4DbOGNyZlpWUT6jKIwcRXWX
         34x+YMcf8b4R6fWjs1Us9FnIgxgI0KBWNQIz/Z/I3b2pCGzGw0woupQnx/tmOCcYAaZd
         OQOQ==
X-Gm-Message-State: APt69E1akyZDY9K5p88HgGmzLz+9XFlgdvFq5ivgYRIuv7aelHuRvOxO
        K0YmEqWxOQRR0aKwqVUBsdjViw==
X-Google-Smtp-Source: AAOMgpfArvUiwDaz37FhhYbR9+Vzr37U5koszxPHPKgQzAOxop4BNScX/qIYzMZ1JXe1AQeWDSs//Q==
X-Received: by 2002:a1c:110a:: with SMTP id 10-v6mr7822092wmr.130.1530194594946;
        Thu, 28 Jun 2018 07:03:14 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:3923:5e2e:38ae:83dc? ([2001:41d0:fe90:b800:3923:5e2e:38ae:83dc])
        by smtp.googlemail.com with ESMTPSA id h15-v6sm9323810wrp.79.2018.06.28.07.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:03:14 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] clocksource/drivers/timer-mediatek: Convert the
 driver to timer-of
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
 <1530182744-10731-5-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5cdfbfdf-4d6e-de18-0f20-2f3b50129b87@linaro.org>
Date:   Thu, 28 Jun 2018 16:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530182744-10731-5-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2018 12:45, Stanley Chu wrote:
> Convert the driver to use the timer_of helpers.
> This allows to remove custom proprietary structure,
> factors out and simplifies the code.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/clocksource/timer-mediatek.c |  222 ++++++++++++++++------------------
>  1 file changed, 104 insertions(+), 118 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index ff284f2..d94d8e1 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -18,16 +18,13 @@
>  
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
> -#include <linux/clk.h>
>  #include <linux/clockchips.h>
> +#include <linux/clocksource.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/irqreturn.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/slab.h>
> +#include "timer-of.h"
>  
>  #define GPT_IRQ_EN_REG		0x00
>  #define GPT_IRQ_ENABLE(val)	BIT((val) - 1)
> @@ -56,49 +53,57 @@
>  #define GPT_CLK_EVT	1
>  #define GPT_CLK_SRC	2
>  
> -struct mtk_clock_event_device {
> -	void __iomem *gpt_base;
> -	u32 ticks_per_jiffy;
> -	struct clock_event_device dev;
> +struct mtk_timer_private {
> +	unsigned long ticks_per_jiffy;
>  };

This private structure is not needed. There is timer_of_clk->period

cf.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-of.c#n144





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


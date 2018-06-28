Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBB3C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86400274C9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gmpYGvq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86400274C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966454AbeF1OI7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:08:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37694 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeF1OI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:08:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so8712371wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKBGIaI1jmmZnbXWe/mezwINWQvsVFCet4a4sMIrQwo=;
        b=gmpYGvq0o/GDeBKX8r/rj2GWWQZA1xvjUSt2CxHIyCXaGA/tIZzlWtbGmCjqC9wWho
         M0hd2hH0/ZpiisXFdiLN7SvDna+y4cEYmOK4eBY59pINJaMiODOVCPMc4KMBE7ilTk3b
         BXT0v7WwHwMooXIHzVY5rb18O5Dq18h8I8p9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKBGIaI1jmmZnbXWe/mezwINWQvsVFCet4a4sMIrQwo=;
        b=trocZ6jDn3hBaHnlit622YJ+lJEa6eH4cQovYGNTYgKVA8z0+xNBMl4hLKv1AhkMAg
         RfXSBVKAghs/THH6LsY11sXHl4iP0u/OIbBPZyVZs3qls0hslW27oZ9rXH1q6xvPKTR2
         0BsjMaI1pQaruLAqnEY2cczRtczG1DDLYO2uDoRR2/0Yco7m4eBT0Q36DpvDEg+MBIix
         cA/Q0NuNb1IeOsxNTg+oCRoe5sjQKxKdZIddnRsltP53vZUjzcjvIm7s6yIym2xy83NL
         scp3AW8a6mrEK0bjvMX5yO5bU2OlP3YbCIPEyjZRxIU+GtPcpGvIErAtK9D6IQlIzSJn
         aiPg==
X-Gm-Message-State: APt69E25ZhVfJ1m8O4PidgRiWl+fy/hqHMecPyWo/eSry16awV6POt4c
        y0ld41MPK8rPrQQd8K7VLLNZNQ==
X-Google-Smtp-Source: AAOMgpcIdosWIRA5WJZgEhWkdcz8uxo3VJthmsB7AoGZ4e59z54HFmsTZE7LK8pHCoaucklTj+qfnA==
X-Received: by 2002:a1c:7218:: with SMTP id n24-v6mr8456203wmc.27.1530194936803;
        Thu, 28 Jun 2018 07:08:56 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:3923:5e2e:38ae:83dc? ([2001:41d0:fe90:b800:3923:5e2e:38ae:83dc])
        by smtp.googlemail.com with ESMTPSA id h12-v6sm16908989wmb.3.2018.06.28.07.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 07:08:55 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] clocksource/drivers/timer-mediatek: Add support
 for system timer
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530182744-10731-1-git-send-email-stanley.chu@mediatek.com>
 <1530182744-10731-6-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b025b8c2-9cfd-466e-ec1c-9fa5e2148904@linaro.org>
Date:   Thu, 28 Jun 2018 16:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530182744-10731-6-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2018 12:45, Stanley Chu wrote:
> This patch adds a new "System Timer" on the Mediatek SoCs.
> 
> The System Timer is introduced as an always-on timer being
> clockevent device for tick-broadcasting.
> 
> For clock, it is driven by 13 MHz system clock.
> The implementation uses the system clock with no clock
> source divider.
> 
> For interrupt, the clock event timer can be used by all cores.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---

Please do the GPT prefix in patch 3/5, so this patch will contain 'syst'
addition only.

>  drivers/clocksource/timer-mediatek.c |  225 +++++++++++++++++++++++++---------
>  1 file changed, 167 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index d94d8e1..6878736 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -26,32 +26,46 @@
>  #include <linux/slab.h>
>  #include "timer-of.h"
>  
> -#define GPT_IRQ_EN_REG		0x00
> -#define GPT_IRQ_ENABLE(val)	BIT((val) - 1)
> -#define GPT_IRQ_ACK_REG		0x08
> -#define GPT_IRQ_ACK(val)	BIT((val) - 1)
> -
> -#define TIMER_CTRL_REG(val)	(0x10 * (val))
> -#define TIMER_CTRL_OP(val)	(((val) & 0x3) << 4)
> -#define TIMER_CTRL_OP_ONESHOT	(0)
> -#define TIMER_CTRL_OP_REPEAT	(1)
> -#define TIMER_CTRL_OP_FREERUN	(3)
> -#define TIMER_CTRL_CLEAR	(2)
> -#define TIMER_CTRL_ENABLE	(1)
> -#define TIMER_CTRL_DISABLE	(0)
> -
> -#define TIMER_CLK_REG(val)	(0x04 + (0x10 * (val)))
> -#define TIMER_CLK_SRC(val)	(((val) & 0x1) << 4)
> -#define TIMER_CLK_SRC_SYS13M	(0)
> -#define TIMER_CLK_SRC_RTC32K	(1)
> -#define TIMER_CLK_DIV1		(0x0)
> -#define TIMER_CLK_DIV2		(0x1)
> -
> -#define TIMER_CNT_REG(val)	(0x08 + (0x10 * (val)))
> -#define TIMER_CMP_REG(val)	(0x0C + (0x10 * (val)))
> -
> -#define GPT_CLK_EVT	1
> -#define GPT_CLK_SRC	2
> +#define TIMER_CLK_EVT           (1)
> +#define TIMER_CLK_SRC           (2)
> +
> +#define TIMER_SYNC_TICKS        (3)
> +
> +/* gpt */
> +#define GPT_IRQ_EN_REG          0x00
> +#define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
> +#define GPT_IRQ_ACK_REG	        0x08
> +#define GPT_IRQ_ACK(val)        BIT((val) - 1)
> +
> +#define GPT_CTRL_REG(val)       (0x10 * (val))
> +#define GPT_CTRL_OP(val)        (((val) & 0x3) << 4)
> +#define GPT_CTRL_OP_ONESHOT     (0)
> +#define GPT_CTRL_OP_REPEAT      (1)
> +#define GPT_CTRL_OP_FREERUN     (3)
> +#define GPT_CTRL_CLEAR          (2)
> +#define GPT_CTRL_ENABLE         (1)
> +#define GPT_CTRL_DISABLE        (0)
> +
> +#define GPT_CLK_REG(val)        (0x04 + (0x10 * (val)))
> +#define GPT_CLK_SRC(val)        (((val) & 0x1) << 4)
> +#define GPT_CLK_SRC_SYS13M      (0)
> +#define GPT_CLK_SRC_RTC32K      (1)
> +#define GPT_CLK_DIV1            (0x0)
> +#define GPT_CLK_DIV2            (0x1)
> +
> +#define GPT_CNT_REG(val)        (0x08 + (0x10 * (val)))
> +#define GPT_CMP_REG(val)        (0x0C + (0x10 * (val)))

Please do the GPT prefix in patch 3/5, so this patch will contain 'syst'
addition only and will make review easier.

Thanks.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


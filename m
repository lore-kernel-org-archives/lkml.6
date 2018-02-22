Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeBVK5S (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:57:18 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:56434 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeBVK5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:57:16 -0500
Date: Thu, 22 Feb 2018 11:57:13 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Keerthy <j-keerthy@ti.com>
Cc: daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com,
        aaro.koskinen@iki.fi, Claudiu.Beznea@microchip.com,
        narmstrong@baylibre.com, linux-pwm@vger.kernel.org, s-anna@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sebastian.reichel@collabora.co.uk, linux-omap@vger.kernel.org,
        robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
Subject: Re: [PATCH v11 04/10] clocksource: timer-ti-dm: Replace architecture
Message-ID: <20180222105713.GA30885@lenoch>
References: <1518674511-26421-1-git-send-email-j-keerthy@ti.com>
 <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518674511-26421-5-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 11:31:45AM +0530, Keerthy wrote:
> Replace architecture specific guard with clocksource guard.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Replace architecture specific defines with clocksource

This looks like a bit unussual commit log. Also, what about merging
it with previous patch?

Btw, I tested whole serie again on the top of today's -next and it is
still working fine. What is preventing these patches from being merged?

Thank you,
	ladis

> ---
>  include/clocksource/timer-ti-dm.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
> index 831174f..4f31095 100644
> --- a/include/clocksource/timer-ti-dm.h
> +++ b/include/clocksource/timer-ti-dm.h
> @@ -1,6 +1,4 @@
>  /*
> - * arch/arm/plat-omap/include/plat/dmtimer.h
> - *
>   * OMAP Dual-Mode Timers
>   *
>   * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
> @@ -36,8 +34,8 @@
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
>  
> -#ifndef __ASM_ARCH_DMTIMER_H
> -#define __ASM_ARCH_DMTIMER_H
> +#ifndef __CLOCKSOURCE_DMTIMER_H
> +#define __CLOCKSOURCE_DMTIMER_H
>  
>  /* clock sources */
>  #define OMAP_TIMER_SRC_SYS_CLK			0x00
> @@ -426,4 +424,4 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
>  	writel_relaxed(value, timer->irq_stat);
>  }
>  #endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
> -#endif /* __ASM_ARCH_DMTIMER_H */
> +#endif /* __CLOCKSOURCE_DMTIMER_H */
> -- 
> 1.9.1

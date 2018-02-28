Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeB1Izt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:55:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48176 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB1Izs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:55:48 -0500
Date: Wed, 28 Feb 2018 09:56:02 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Felix Fietkau <nbd@nbd.name>
cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        paul.burton@imgtec.com
Subject: Re: [PATCH] clocksource: mips-gic-timer: fix clocksource counter
 width
In-Reply-To: <20180221124749.39471-1-nbd@nbd.name>
Message-ID: <alpine.DEB.2.21.1802280955430.1886@nanos.tec.linutronix.de>
References: <20180221124749.39471-1-nbd@nbd.name>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2018, Felix Fietkau wrote:

> This code needs to use ffs instead of fls on the mask to determine the
> shift for reading the GIC_CONFIG_COUNTBITS field.

Why?

Thanks,

	tglx
 
> Fixes: e07127a077c7 ("clocksource: mips-gic-timer: Use new GIC accessor functions")
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/clocksource/mips-gic-timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index a04808a21d4e..bf0eee78c6ef 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -166,7 +166,7 @@ static int __init __gic_clocksource_init(void)
>  
>  	/* Set clocksource mask. */
>  	count_width = read_gic_config() & GIC_CONFIG_COUNTBITS;
> -	count_width >>= __fls(GIC_CONFIG_COUNTBITS);
> +	count_width >>= __ffs(GIC_CONFIG_COUNTBITS);
>  	count_width *= 4;
>  	count_width += 32;
>  	gic_clocksource.mask = CLOCKSOURCE_MASK(count_width);
> -- 
> 2.14.2
> 
> 

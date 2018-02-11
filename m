Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBKDyu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:54:50 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41178 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbeBKDyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:54:49 -0500
X-Google-Smtp-Source: AH8x224r/XP/JoNWvp9uwIb+uIjQOqIFKHufApMcKpMS/nLzqRfGr7S02J7u2He0tEgij48+d3FzYg==
Subject: Re: [PATCH 2/4] watchdog: omap_wdt: change order for setting default
 timeout
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
 <20180210203623.17832-2-marcus.folkesson@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1e30bcff-801e-7b1f-2e1c-2645e9171826@roeck-us.net>
Date: Sat, 10 Feb 2018 19:54:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210203623.17832-2-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 12:36 PM, Marcus Folkesson wrote:
> watchdog_init_timeout() will preserve wdd->timeout value if
> no parameter nor timeout-secs dt property is set.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/omap_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index 1b02bfa81b29..ae77112ce97f 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c
> @@ -253,10 +253,10 @@ static int omap_wdt_probe(struct platform_device *pdev)
>   	wdev->wdog.ops = &omap_wdt_ops;
>   	wdev->wdog.min_timeout = TIMER_MARGIN_MIN;
>   	wdev->wdog.max_timeout = TIMER_MARGIN_MAX;
> +	wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
>   	wdev->wdog.parent = &pdev->dev;
>   
> -	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
> -		wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
> +	watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev);
>   
>   	watchdog_set_nowayout(&wdev->wdog, nowayout);
>   
> 

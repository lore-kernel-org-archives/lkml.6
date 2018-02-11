Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeBKDz1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:55:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41451 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbeBKDz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:55:26 -0500
X-Google-Smtp-Source: AH8x227b2rYZ6okwwHSz9ESwZH7+phizPwaxpavra+CfMbeRfBW8qkmhsFsrPi8uORo/UfsbPxAI6g==
Subject: Re: [PATCH 3/4] watchdog: gpio: change order for setting default
 timeout
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
 <20180210203623.17832-3-marcus.folkesson@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <0a76687f-332e-c851-d222-1f352e36e3c3@roeck-us.net>
Date: Sat, 10 Feb 2018 19:55:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210203623.17832-3-marcus.folkesson@gmail.com>
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
>   drivers/watchdog/gpio_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index cb66c2f99ff1..d0e8203f7a60 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -156,9 +156,9 @@ static int gpio_wdt_probe(struct platform_device *pdev)
>   	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
>   	priv->wdd.max_hw_heartbeat_ms = hw_margin;
>   	priv->wdd.parent	= &pdev->dev;
> +	priv->wdd.timeout = SOFT_TIMEOUT_DEF;
>   
> -	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
> -		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
> +	watchdog_init_timeout(&priv->wdd, 0, &pdev->dev);
>   
>   	watchdog_stop_on_reboot(&priv->wdd);
>   
> 

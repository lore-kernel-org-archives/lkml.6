Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeBKDyP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:54:15 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37628 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeBKDyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:54:13 -0500
X-Google-Smtp-Source: AH8x224LOasxZUTqadlq6C7tkkQSwNWSetQQxBcpkqAu8/KyauHG7fpgZsTCMiC5N+10WzAlJfIgvw==
Subject: Re: [PATCH 1/4] watchdog: uniphier: change order for setting default
 timeout
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2427b67d-7d4f-e82f-a6bf-cb51a75a67dc@roeck-us.net>
Date: Sat, 10 Feb 2018 19:54:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2018 12:36 PM, Marcus Folkesson wrote:
> watchdog_init_timeout() will preserve wdd->timeout value if no parameter
> nor timeout-secs dt property is set.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/uniphier_wdt.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index 0ea2339d9702..0e4f8d53ce3c 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -212,11 +212,10 @@ static int uniphier_wdt_probe(struct platform_device *pdev)
>   	wdev->wdt_dev.ops = &uniphier_wdt_ops;
>   	wdev->wdt_dev.max_timeout = WDT_PERIOD_MAX;
>   	wdev->wdt_dev.min_timeout = WDT_PERIOD_MIN;
> +	wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
>   	wdev->wdt_dev.parent = dev;
>   
> -	if (watchdog_init_timeout(&wdev->wdt_dev, timeout, dev) < 0) {
> -		wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
> -	}
> +	watchdog_init_timeout(&wdev->wdt_dev, timeout, dev);
>   	watchdog_set_nowayout(&wdev->wdt_dev, nowayout);
>   	watchdog_stop_on_reboot(&wdev->wdt_dev);
>   
> 

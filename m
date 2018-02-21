Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBUBau (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:30:50 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:57160 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeBUBat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:30:49 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1L1UJi1004176
X-Nifty-SrcIP: [209.85.213.46]
X-Google-Smtp-Source: AH8x22659Cl9xvasQkKAQOojLJ6VylM2vL8cuddz4JRls6Uf6SSW1Jj+z5qdz4qDA0XIBG5nax4wh3U6HwLgREpX9+I=
MIME-Version: 1.0
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 10:29:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2T5UHgx_iyui43=GMTTYam0bk6FViD_cdpoRSkq3y+A@mail.gmail.com>
Message-ID: <CAK7LNAT2T5UHgx_iyui43=GMTTYam0bk6FViD_cdpoRSkq3y+A@mail.gmail.com>
Subject: Re: [PATCH 1/4] watchdog: uniphier: change order for setting default timeout
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-11 5:36 GMT+09:00 Marcus Folkesson <marcus.folkesson@gmail.com>:
> watchdog_init_timeout() will preserve wdd->timeout value if no parameter
> nor timeout-secs dt property is set.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/watchdog/uniphier_wdt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index 0ea2339d9702..0e4f8d53ce3c 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -212,11 +212,10 @@ static int uniphier_wdt_probe(struct platform_device *pdev)
>         wdev->wdt_dev.ops = &uniphier_wdt_ops;
>         wdev->wdt_dev.max_timeout = WDT_PERIOD_MAX;
>         wdev->wdt_dev.min_timeout = WDT_PERIOD_MIN;
> +       wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
>         wdev->wdt_dev.parent = dev;
>
> -       if (watchdog_init_timeout(&wdev->wdt_dev, timeout, dev) < 0) {
> -               wdev->wdt_dev.timeout = WDT_DEFAULT_TIMEOUT;
> -       }
> +       watchdog_init_timeout(&wdev->wdt_dev, timeout, dev);
>         watchdog_set_nowayout(&wdev->wdt_dev, nowayout);
>         watchdog_stop_on_reboot(&wdev->wdt_dev);
>
> --
> 2.15.1
>

I am pasting Acked-by from the author here just in case.

Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>


You can see his original tag here.
https://www.spinics.net/lists/linux-watchdog/msg13513.html



-- 
Best Regards
Masahiro Yamada

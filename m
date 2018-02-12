Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeBLI7D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:59:03 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64765 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933024AbeBLI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:58:38 -0500
X-IronPort-AV: E=Sophos;i="5.46,501,1511852400";
   d="scan'208";a="11052543"
Subject: Re: [PATCH v3 1/7] watchdog: sama5d4: make use of timeout-secs
 provided in devicetree
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <20180211200847.25000-1-marcus.folkesson@gmail.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <c925c4cb-1367-d57e-49eb-f88a6d2a1e70@microchip.com>
Date: Mon, 12 Feb 2018 09:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180211200847.25000-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2018 at 21:08, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> Following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt to make use of
> the parameter logic.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
  Nicolas

> ---
> 
> Notes:
>     v3:
>     	- Use wdd->timeout instead of wdt_timeout when print out
>     	  timout in probe function.
> 
>  drivers/watchdog/sama5d4_wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
> index 0ae947c3d7bc..255169916dbb 100644
> --- a/drivers/watchdog/sama5d4_wdt.c
> +++ b/drivers/watchdog/sama5d4_wdt.c
> @@ -33,7 +33,7 @@ struct sama5d4_wdt {
>  	unsigned long		last_ping;
>  };
>  
> -static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
> +static int wdt_timeout;
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  module_param(wdt_timeout, int, 0);
> @@ -212,7 +212,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	wdd = &wdt->wdd;
> -	wdd->timeout = wdt_timeout;
> +	wdd->timeout = WDT_DEFAULT_TIMEOUT;
>  	wdd->info = &sama5d4_wdt_info;
>  	wdd->ops = &sama5d4_wdt_ops;
>  	wdd->min_timeout = MIN_WDT_TIMEOUT;
> @@ -273,7 +273,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, wdt);
>  
>  	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
> -		 wdt_timeout, nowayout);
> +		 wdd->timeout, nowayout);
>  
>  	return 0;
>  }
> 


-- 
Nicolas Ferre

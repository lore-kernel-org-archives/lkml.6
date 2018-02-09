Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeBIWsy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:48:54 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38265 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbeBIWsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:48:51 -0500
X-Google-Smtp-Source: AH8x225EJRmtM35x54wnMTEArwGkNN1X/zdGV3+hjOySGbldfbGmc9WasXg/9baW1dItD7uMPIhEBA==
Date: Fri, 9 Feb 2018 14:48:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 6/7] watchdog: meson: allow setting timeout in devicetree
Message-ID: <20180209224849.GH19627@roeck-us.net>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-7-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209192724.1227-7-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 08:27:23PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also
> let us to set timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenetr Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/meson-wdt.txt | 4 ++++
>  drivers/watchdog/meson_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> index 8a6d84cb36c9..7588cc3971bf 100644
> --- a/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/meson-wdt.txt
> @@ -9,9 +9,13 @@ Required properties:
>  	"amlogic,meson8m2-wdt" and "amlogic,meson8b-wdt" on Meson8m2 SoCs
>  - reg : Specifies base physical address and size of the registers.
>  
> +Optional properties:
> +- timeout-sec: contains the watchdog timeout in seconds.
> +
>  Example:
>  
>  wdt: watchdog@c1109900 {
>  	compatible = "amlogic,meson6-wdt";
>  	reg = <0xc1109900 0x8>;
> +	timeout-sec = <10>;
>  };
> diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
> index 304274c67735..cd0275a6cdac 100644
> --- a/drivers/watchdog/meson_wdt.c
> +++ b/drivers/watchdog/meson_wdt.c
> @@ -36,7 +36,7 @@
>  #define MESON_SEC_TO_TC(s, c)	((s) * (c))
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -static unsigned int timeout = MESON_WDT_TIMEOUT;
> +static unsigned int timeout;
>  
>  struct meson_wdt_data {
>  	unsigned int enable;
> -- 
> 2.15.1
> 

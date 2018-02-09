Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeBIWjI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:39:08 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44033 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeBIWjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:39:06 -0500
X-Google-Smtp-Source: AH8x225OpGzR/ka65JiE8IGXnY5eDgqGVUcpEQvGhdMHJzRtIk8MIU+yCZekMiKLLgJn5kHGQvf7uw==
Date: Fri, 9 Feb 2018 14:39:04 -0800
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
Subject: Re: [PATCH 2/7] watchdog: sunxi: allow setting timeout in devicetree
Message-ID: <20180209223904.GC19627@roeck-us.net>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209192724.1227-3-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 08:27:19PM +0100, Marcus Folkesson wrote:
> watchdog_init_timeout() will allways pick timeout_param since it
> defaults to a valid timeout.
> 
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also
> let us to set timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 4 ++++
>  drivers/watchdog/sunxi_wdt.c                             | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> index 62dd5baad70e..49900e72f6b1 100644
> --- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
> @@ -6,9 +6,13 @@ Required properties:
>                 "allwinner,sun6i-a31-wdt"
>  - reg : Specifies base physical address and size of the registers.
>  
> +Optional properties:
> +- timeout-sec : Contains the watchdog timeout in seconds
> +
>  Example:
>  
>  wdt: watchdog@1c20c90 {
>  	compatible = "allwinner,sun4i-a10-wdt";
>  	reg = <0x01c20c90 0x10>;
> +	timeout-sec = <10>;
>  };
> diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
> index 9728fa32c357..55f166bec0ca 100644
> --- a/drivers/watchdog/sunxi_wdt.c
> +++ b/drivers/watchdog/sunxi_wdt.c
> @@ -39,7 +39,7 @@
>  #define DRV_VERSION		"1.0"
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -static unsigned int timeout = WDT_MAX_TIMEOUT;
> +static unsigned int timeout;
>  
>  /*
>   * This structure stores the register offsets for different variants
> -- 
> 2.15.1
> 

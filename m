Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933358AbeCMQsP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:48:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43106 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeCMQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:48:12 -0400
X-Google-Smtp-Source: AG47ELtqm+2q+eAClPUpwBwlBVCLZKK2u7dO/HI4gdpgDVgU8sDugFeEV8jhVCXa3hX59DY2mEL8ag==
Date: Tue, 13 Mar 2018 09:48:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: watchdog: Add Nuvoton NPCM
 description
Message-ID: <20180313164809.GA13835@roeck-us.net>
References: <20180313061726.21601-1-joel@jms.id.au>
 <20180313061726.21601-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313061726.21601-2-joel@jms.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 04:47:25PM +1030, Joel Stanley wrote:
> These bindings describe the watchdog IP as used by the Nuvoton NPCM750
> (Poleg) BMC SoC.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V2: Add optional timeout property
> v3:
>  - Fix address in example
>  - Add Rob's reviewed-by
> ---
>  .../bindings/watchdog/nuvoton,npcm-wdt.txt         | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> new file mode 100644
> index 000000000000..6d593003c933
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
> @@ -0,0 +1,28 @@
> +Nuvoton NPCM Watchdog
> +
> +Nuvoton NPCM timer module provides five 24-bit timer counters, and a watchdog.
> +The watchdog supports a pre-timeout interrupt that fires 10ms before the
> +expiry.
> +
> +Required properties:
> +- compatible      : "nuvoton,npcm750-wdt" for NPCM750 (Poleg).
> +- reg             : Offset and length of the register set for the device.
> +- interrupts      : Contain the timer interrupt with flags for
> +                    falling edge.
> +
> +Required clocking property, have to be one of:
> +- clocks          : phandle of timer reference clock.
> +- clock-frequency : The frequency in Hz of the clock that drives the NPCM7xx
> +                    timer (usually 25000000).
> +
> +Optional properties:
> +- timeout-sec : Contains the watchdog timeout in seconds
> +
> +Example:
> +
> +timer@f000801c {
> +    compatible = "nuvoton,npcm750-wdt";
> +    interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +    reg = <0xf000801c 0x4>;
> +    clocks = <&clk NPCM7XX_CLK_TIMER>;
> +};
> -- 
> 2.15.1
> 

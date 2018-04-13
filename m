Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeDMQXa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:23:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48203 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbeDMQX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:23:29 -0400
Date: Fri, 13 Apr 2018 18:23:27 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: broonie@kernel.org, nicolas.ferre@microchip.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
Message-ID: <20180413162327.GE22187@piout.net>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413161117.20274-3-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2018 19:11:16+0300, Radu Pirea wrote:
> These are bindings for at91-usart IP in spi spi mode. There is no support for
> internal chip select. Only kind of chip selects available are gpio chip
> selects.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  .../bindings/spi/microchip,at91-usart-spi.txt | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> new file mode 100644
> index 000000000000..92d33ccdffae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
> @@ -0,0 +1,24 @@
> +* Universal Synchronous Asynchronous Receiver/Transmitter (USART) in SPI mode
> +
> +Required properties:
> +- #size-cells      : Must be <0>
> +- #address-cells   : Must be <1>
> +- compatible: Should be "microchip,at91sam9g45-usart-spi" or "microchip,sama5d2-usart-spi" 
> +- reg: Should contain registers location and length
> +- interrupts: Should contain interrupt
> +- clocks: phandles to input clocks.
> +- clock-names: tuple listing input clock names.
> +	Required elements: "usart"
> +- cs-gpios: chipselects (internal cs not supported)
> +
> +Example:
> +	spi0: spi@f001c000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "microchip,sama5d2-usart-spi", "microchip,at91sam9g45-usart-spi";

I'm pretty sure this will be considered configuration rather than
hardware description. Why don't you do something like the flexcom mode
selection?

> +		reg = <0xf001c000 0x100>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&usart0_clk>;
> +		clock-names = "usart";
> +		cs-gpios = <&pioB 3 0>;
> +	};
> -- 
> 2.17.0
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

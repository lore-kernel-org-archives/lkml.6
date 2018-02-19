Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752697AbeBSLqX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:46:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752591AbeBSLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:46:21 -0500
Message-ID: <1519040775.3408.6.camel@pengutronix.de>
Subject: Re: [PATCH 1/3] dt-bindings: aspeed-lpc: Add reset controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Andrew Jeffery <andrew@aj.id.au>
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date: Mon, 19 Feb 2018 12:46:15 +0100
In-Reply-To: <20180219065438.19933-2-joel@jms.id.au>
References: <20180219065438.19933-1-joel@jms.id.au>
         <20180219065438.19933-2-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-19 at 17:24 +1030, Joel Stanley wrote:
> This describes the reset controller present in the LPC address space.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 514d82ced95b..721a2b1eb40f 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -135,3 +135,24 @@ lhc: lhc@20 {
>  	compatible = "aspeed,ast2500-lhc";
>  	reg = <0x20 0x24 0x48 0x8>;
>  };
> +
> +LPC reset control
> +-----------------
> +
> +The UARTs present in the ASPEED SoC can have their resets tied to the reset
> +state of the LPC bus. Some systems may chose to modify this configuration.
> +
> +Required properties:
> +
> + - comaptible:		"aspeed,ast2500-lpc-reset" or

"compatible"

> + 			"aspeed,ast2400-lpc-reset"
> + - reg:			offset and length of the IP in the LHC memory region
> + - #reset-controller	indacates the number of reset cells excepted

"indicates", "expected"

> +
> +Example:
> +
> +lpc_reset: reset-controller@18 {
> +        compatible = "aspeed,ast2500-lpc-reset";
> +        reg = <0x18 0x4>;
> +        #reset-cells = <1>;
> +};

Should this mention or indicate in the example that the reset-controller 
node must be child of (a subnode of) the lpc node?

regards
Philipp

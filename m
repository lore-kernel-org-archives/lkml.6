Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932721AbeEaDF3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 23:05:29 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42929 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932637AbeEaDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 23:05:25 -0400
X-Google-Smtp-Source: ADUXVKJM/BD0JeCdiLZDBN2iEKXC5fJU+7nVYG2VFrEf133SGfkjJFJQ+4TzbEI61M+oM5OPWT+6ug==
Date: Wed, 30 May 2018 22:05:22 -0500
From: Rob Herring <robh@kernel.org>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v4 4/6] clk: bd71837: Devicetree bindings for ROHM
 BD71837 PMIC
Message-ID: <20180531030522.GC16122@rob-hp-laptop>
References: <cover.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
 <99bae24fdaee0fe101e9ed1f2e55682932b92a74.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99bae24fdaee0fe101e9ed1f2e55682932b92a74.1527669443.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:42:55AM +0300, Matti Vaittinen wrote:
> Document devicetree bindings for ROHM BD71837 PMIC clock output.

Comments from the core binding apply here too.

> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  .../bindings/clock/rohm,bd71837-clock.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> new file mode 100644
> index 000000000000..9759fd145781
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rohm,bd71837-clock.txt
> @@ -0,0 +1,37 @@
> +ROHM BD71837 Power Management Integrated Circuit clock bindings
> +
> +BD71837 clock node should be sub node of the BD71837 MFD node.
> +See BD71837 MFD bindings at
> +Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
> +
> +Required properties:
> +- compatible		: Should be "rohm,bd71837-clk"
> +- clock-frequency	: Should be 32768
> +- #clock-cells		: Should be 0
> +
> +Optional properties:
> +- clock-output-names	: Should contain name for output clock.
> +  Name "bd71837-32k-out" is used if this is not given.
> +
> +
> +Example:
> +
> +pmic: bd71837@4b {
> +	compatible = "rohm,bd71837";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	reg = <0x4b>;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <29 GPIO_ACTIVE_LOW>;
> +	interrupt-names = "irq";
> +	#interrupt-cells = <1>;
> +	interrupt-controller;
> +
> +	/* Clock node */
> +	clk: bd71837-32k-out {
> +		compatible = "rohm,bd71837-clk";
> +		#clock-cells = <0>;
> +		clock-frequency  = <32768>;
> +		clock-output-names = "bd71837-32k-out";
> +	};
> +};
> -- 
> 2.14.3
> 

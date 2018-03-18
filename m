Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754366AbeCRMxO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:53:14 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39587 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeCRMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:53:08 -0400
X-Google-Smtp-Source: AG47ELu1RSVJ32xsQiGZ8yo9Z2DYH6r/42v4978dUdk1f5NUPijUFuk6MeyqXGO+R4z0Pxno+hEXzw==
Date: Sun, 18 Mar 2018 07:53:04 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linus.walleij@linaro.org, afaerber@suse.de, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com
Subject: Re: [PATCH v5 4/9] dt-bindings: gpio: Add gpio nodes for Actions
 S900 SoC
Message-ID: <20180318125304.3i3kqzcefhv5iusv@rob-hp-laptop>
References: <20180309051345.1011-1-manivannan.sadhasivam@linaro.org>
 <20180309051345.1011-5-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309051345.1011-5-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 10:43:40AM +0530, Manivannan Sadhasivam wrote:
> Add gpio nodes for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/gpio/actions,owl-gpio.txt  | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> new file mode 100644
> index 000000000000..ad7d32ce2abe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> @@ -0,0 +1,90 @@
> +* Actions Semi OWL GPIO controller bindings
> +
> +The GPIOs are organized as individual banks/ports with variable number
> +of GPIOs. Each bank is represented as an individual GPIO controller.
> +
> +Required properties:
> +- compatible            : Should be "actions,s900-gpio"
> +- reg                   : Address and range of the GPIO controller registers.
> +- gpio-controller       : Marks the device node as a GPIO controller.
> +- #gpio-cells           : Should be <2>. The first cell is the gpio number
> +                          and the second cell is used to specify optional
> +                          parameters.
> +- ngpios                : Specifies the number of GPIO lines.
> +- interrupt-controller  : Marks the device node as an interrupt controller.
> +- #interrupt-cells      : Specifies the number of cells needed to encode an
> +                          interrupt.  Shall be set to 2.  The first cell
> +                          defines the interrupt number, the second encodes
> +                          the trigger flags described in
> +                          bindings/interrupt-controller/interrupts.txt
> +
> +Optional properties:
> +- gpio-ranges           : Mapping between GPIO and pinctrl
> +
> +Examples:
> +
> +       gpioa: gpio@e01b0000 {
> +               compatible = "actions,s900-gpio";
> +               reg = <0x0 0xe01b0000 0x0 0x1000>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-ranges = <&pinctrl 0 0 32>;
> +               ngpios = <32>;

This is only needed if the number of gpios is reduced for some reason 
such as not pinned out. IOW, 32 is implied because that's the size of 
each bank.

> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };
> +
> +       gpiob: gpio@e01b000c {
> +               compatible = "actions,s900-gpio";
> +               reg = <0x0 0xe01b000c 0x0 0x1000>;

Due to the sizes, these are still overlapping.

Rob

> +               gpio-controller;
> +               #gpio-cells = <2>;
> +               gpio-ranges = <&pinctrl 0 32 32>;
> +               ngpios = <32>;
> +               interrupt-controller;
> +               #interrupt-cells = <2>;
> +       };

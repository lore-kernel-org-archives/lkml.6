Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031561AbeCAO2s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031546AbeCAO2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:28:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A364021795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELv57y1p7cJO0zEuDH7DEWVmRmM1/X1hkS7HxjzAdNGc1nNiW4j44T8PLoKFmKmj/TX6kzZtGsKePAHbin00Xd4=
MIME-Version: 1.0
In-Reply-To: <20180227110107.30259-2-ard.biesheuvel@linaro.org>
References: <20180227110107.30259-1-ard.biesheuvel@linaro.org> <20180227110107.30259-2-ard.biesheuvel@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 1 Mar 2018 08:28:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJL9idphGUyZ8M4MuF2oTUC0hNYaVsbLu4ec+=s90qJ1w@mail.gmail.com>
Message-ID: <CAL_JsqJL9idphGUyZ8M4MuF2oTUC0hNYaVsbLu4ec+=s90qJ1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: add binding for Socionext
 SynQuacer I2C
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>,
        Linux I2C <linux-i2c@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 5:01 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Add a binding for the I2C controller that can be found in the Socionext
> SynQuacer SoC. Note that this is the exact same IP as the Fujitsu F_I2C.

Is there a binding for that? Should be the same doc if so.

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-synquacer.txt | 29 ++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
> new file mode 100644
> index 000000000000..4d0bb6a71211
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
> @@ -0,0 +1,29 @@
> +Socionext SynQuacer I2C
> +
> +Required properties:
> +- compatible      : Must be "socionext,synquacer-i2c"
> +- reg             : Offset and length of the register set for the device
> +- interrupts      : the interrupt specifier

How many?

> +- #address-cells  : Must be <1>;
> +- #size-cells     : Must be <0>;
> +- clock-names     : Must contain "pclk".
> +- clocks          : Must contain an entry for each name in clock-names.
> +                    (See the common clock bindings.)
> +
> +Optional properties:
> +- clock-frequency : Desired I2C bus clock frequency in Hz. As only Normal and
> +                    Fast modes are supported, possible values are 100000 and
> +                    400000.
> +
> +Example :
> +
> +    i2c@51210000 {
> +        compatible = "socionext,synquacer-i2c";
> +        reg = <0x51210000 0x1000>;
> +        interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clock-names = "pclk";
> +        clocks = <&clk_i2c>;
> +        clock-frequency = <400000>;
> +    };
> --
> 2.11.0
>

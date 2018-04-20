Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbeDTHik (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:38:40 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33048 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753620AbeDTHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:38:38 -0400
X-Google-Smtp-Source: AIpwx4/OaNb9L6rRRbjt7D1RpHQTlvREXtvcqRc15n8PohnjjvizJ8Xv2JdentCwYPOHHa1USEDdmgmZ0XY6FrC8x1Q=
MIME-Version: 1.0
In-Reply-To: <20180316215436.22906-1-srinivas.kandagatla@linaro.org>
References: <20180316215436.22906-1-srinivas.kandagatla@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Fri, 20 Apr 2018 09:37:57 +0200
Message-ID: <CAMZdPi-Pq4WiKhy7aJPJMSo3n-Gwv9s2cvv5v25FHStbX3p09g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: qcom: Add apq8064 Dragon Board 600c support
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 16 March 2018 at 22:54,  <srinivas.kandagatla@linaro.org> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch add support to DB600c board, which is another
> 96boards based on Qualcomm APQ8064 SoC.
>
> Support for USB, HDMI, PCIe, I2C, SPI, eMMC, microSD card, LEDs
> device tree nodes is added in this patch.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Changes since v1:
>         - added chosen node with stdout, suggested by Stephen Boyd
>         - removed spi flash node and gpio22 pinconf, as its not required in this patch.
>         - removed extra comment lines and fix a node name, spotted by Stephen Boyd.
>
>  arch/arm/boot/dts/Makefile                |   1 +
>  arch/arm/boot/dts/qcom-apq8064-db600c.dts | 530 ++++++++++++++++++++++++++++++
>  2 files changed, 531 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-apq8064-db600c.dts

> +
> +               gsbi@16500000 {
> +                       status = "okay";
> +                       qcom,mode = <GSBI_PROT_UART_W_FC>;
> +                       serial@1654000 {

Missing zero, should be serial@16540000.

> +                               label = "BT-UART";
> +                               status = "okay";
> +                               pinctrl-name = "default";
> +                               pinctrl-0 = <&gsbi6_uart_4pins>;
> +                       };
> +               };

Regards,
Loic

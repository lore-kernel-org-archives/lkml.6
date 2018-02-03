Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeBCMNv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 07:13:51 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBCMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 07:13:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Feb 2018 17:43:38 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 12/15] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2
 board file
In-Reply-To: <1517202689-14212-13-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-13-git-send-email-sricharan@codeaurora.org>
Message-ID: <033a420e14f090258e4c8f14b7ba89a7@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-29 10:41, Sricharan R wrote:
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 78
> +++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ef5b133..b4339ae 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -729,6 +729,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq4019-ap.dk04.1-c5.dtb \
>  	qcom-ipq4019-ap.dk04.1-c3.dtb \
>  	qcom-ipq4019-ap.dk07.1-c1.dtb \
> +	qcom-ipq4019-ap.dk07.1-c2.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> new file mode 100644
> index 0000000..d4ee52d
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK07.1-C2";

  s/IPQ40xx/IPQ4019

> +
> +	soc {
> +		pcie0: pci@40000000 {
> +			status = "disabled";
> +		};

  We can disable in base dtsi itself.

> +
> +		pinctrl@1000000 {
> +			serial_1_pins: serial1_pinmux {
> +				mux {
> +					pins = "gpio8", "gpio9";
> +					function = "blsp_uart1";
> +					bias-disable;
> +				};
> +			};
> +
> +			spi_0_pins: spi_0_pinmux {
> +				mux {
> +					pins = "gpio13", "gpio14",
> "gpio15";
> +					function = "blsp_spi0";
> +					bias-disable;
> +				};
> +				cs1 {
> +					pins = "gpio12";
> +					function = "gpio";
> +				};
> +				host_int1 {
> +					pins = "gpio10";
> +					function = "gpio";
> +					input;
> +				};
> +				cs2 {
> +					pins = "gpio45";
> +					function = "gpio";
> +				};
> +				host_int2 {
> +					pins = "gpio61";
> +					function = "gpio";
> +					input;
> +				};
> +				rst {
> +					pins = "gpio36";
> +					function = "gpio";
> +					output-high;
> +				};

  Normally spi pins should contains spi protocol related pins
  could you please explain what is the role of host_pin and rst
  pins and which driver will use these.

> +			};
> +		};
> +
> +		serial@78b0000 {
> +			pinctrl-0 = <&serial_1_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};
> +
> +		spi_0: spi@78b5000 { /* BLSP1 QUP1 */
> +			pinctrl-0 = <&spi_0_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";

  From pinmux, it looks like multiple gpio based cs are being
  used so do we need to specify cs-gpios like dk01-c2.

  Thanks,
  Abhishek

> +
> +			spidev0_0 {
> +				compatible = "spidev";
> +				reg = <0>;
> +				spi-max-frequency = <24000000>;
> +			};
> +			spidev0_1 {
> +				compatible = "spidev";
> +				reg = <1>;
> +				spi-max-frequency = <24000000>;
> +			};
> +		};
> +	};
> +};

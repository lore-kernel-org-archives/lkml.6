Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeCPKVS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:21:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeCPKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:21:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Mar 2018 15:51:15 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2 05/13] ARM: dts: ipq4019: Add ipq4019-ap.dk04.dtsi
In-Reply-To: <1521193101-4586-6-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <ff5fdfb8c08179235c54f9ef8aa4cf68@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-16 15:08, Sricharan R wrote:
> Add the common parts for the dk04 boards.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi | 129 
> ++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
> new file mode 100644
> index 0000000..96ce081
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1";
> +	compatible = "qcom,ipq4019";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256MB */
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rsvd1@87000000 {
> +			/* Reserved for other subsystem */
> +			reg = <0x87000000 0x500000>;
> +			no-map;
> +		};
> +
> +		wifi_dump@87500000 {
> +			reg = <0x87500000 0x600000>;
> +			no-map;
> +		};
> +
> +		rsvd2@87B00000 {
> +			/* Reserved for other subsystem */
> +			reg = <0x87B00000 0x500000>;
> +			no-map;
> +		};
> +	};
> +
> +	soc {
> +		pinctrl@1000000 {
> +			serial_0_pins: serial0_pinmux {
> +				mux {
> +					pins = "gpio16", "gpio17";
> +					function = "blsp_uart0";
> +					bias-disable;
> +				};
> +			};
> +
> +			serial_1_pins: serial1_pinmux {
> +				mux {
> +					pins = "gpio8", "gpio9",
> +						"gpio10", "gpio11";
> +					function = "blsp_uart1";
> +					bias-disable;
> +				};
> +			};
> +
> +			spi_0_pins: spi_0_pinmux {
> +				pinmux {
> +					function = "blsp_spi0";
> +					pins = "gpio13", "gpio14", "gpio15";
> +					bias-disable;
> +				};
> +				pinmux_cs {
> +					function = "gpio";
> +					pins = "gpio12";
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			i2c_0_pins: i2c_0_pinmux {
> +				mux {
> +					pins = "gpio20", "gpio21";
> +					function = "blsp_i2c0";
> +					bias-disable;
> +				};
> +			};
> +
> +			nand_pins: nand_pins {
> +				mux {
> +					pins = "gpio53", "gpio55", "gpio56",
> +						"gpio57", "gpio58", "gpio59",
> +						"gpio60", "gpio62", "gpio63",
> +						"gpio64", "gpio65", "gpio66",
> +						"gpio67", "gpio68", "gpio69";
> +					function = "qpic";
> +				};
> +			};
> +		};
> +
> +		serial@78af000 {
> +			pinctrl-0 = <&serial_0_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};
> +
> +		serial@78b0000 {
> +			pinctrl-0 = <&serial_1_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};
> +
> +		blsp_dma: dma@7884000 {
> +			status = "ok";
> +		};
> +
> +		spi_0: spi@78b5000 { /* BLSP1 QUP1 */
> +			pinctrl-0 = <&spi_0_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +			cs-gpios = <&tlmm 12 0>;
> +
> +			m25p80@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0>;
> +				compatible = "n25q128a11";
> +				spi-max-frequency = <24000000>;
> +			};
> +		};
> +
> +		pcie0: pci@40000000 {
> +			status = "ok";
> +			perst-gpio = <&tlmm 38 0x1>;
> +		};
> +	};
> +};

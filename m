Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeCPK1J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:27:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35036 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeCPK1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:27:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Mar 2018 15:57:03 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2 10/13] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk07.1-c2
 board file
In-Reply-To: <1521193101-4586-11-git-send-email-sricharan@codeaurora.org>
References: <1521193101-4586-1-git-send-email-sricharan@codeaurora.org>
 <1521193101-4586-11-git-send-email-sricharan@codeaurora.org>
Message-ID: <0a8267721c841603894cbe50fe51560b@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-16 15:08, Sricharan R wrote:
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

  Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>

> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts | 26 
> +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8c93fd0..0844087 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -750,6 +750,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq4019-ap.dk04.1-c1.dtb \
>  	qcom-ipq4019-ap.dk04.1-c3.dtb \
>  	qcom-ipq4019-ap.dk07.1-c1.dtb \
> +	qcom-ipq4019-ap.dk07.1-c2.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> new file mode 100644
> index 0000000..c1e909c
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk07.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK07.1-C2";
> +
> +	soc {
> +		pinctrl@1000000 {
> +			serial_1_pins: serial1_pinmux {
> +				mux {
> +					pins = "gpio8", "gpio9";
> +					function = "blsp_uart1";
> +					bias-disable;
> +				};
> +			};
> +		};
> +
> +		serial@78b0000 {
> +			pinctrl-0 = <&serial_1_pins>;
> +			pinctrl-names = "default";
> +			status = "ok";
> +		};
> +	};
> +};

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBCK4A (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 05:56:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:32974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeBCKzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 05:55:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Feb 2018 16:25:53 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 05/15] ARM: dts: ipq4019: Add ipq4019-ap-dk01-c2 board
 file
In-Reply-To: <1517202689-14212-6-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <9afb20e560a7ebbcefcb801e7447a983@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-29 10:41, Sricharan R wrote:
> The board has a spi-nand interface on spi0 bus chipselect1.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts | 25
> +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9..21ed56d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -724,6 +724,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-apq8084-ifc6540.dtb \
>  	qcom-apq8084-mtp.dtb \
>  	qcom-ipq4019-ap.dk01.1-c1.dtb \
> +	qcom-ipq4019-ap.dk01.1-c2.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
> new file mode 100644
> index 0000000..e3442da
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c2.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk01.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ40xx/AP-DK01.1-C2";

  s/IPQ40xx/IPQ4019

> +
> +	soc {
> +		spi_0: spi@78b5000 { /* BLSP1 QUP1 */
> +			status = "ok";
> +			cs-gpios = <&tlmm 54 0>, <&tlmm 59 0>;

  the base dk01 file has pinmux for 54 only.
  for 59 pin, we need to add pinmux entry also.

  Thanks,
  Abhishek

> +			num-cs = <2>;
> +
> +			mt29f@1 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "spinand,mt29f";
> +				reg = <1>;
> +				spi-max-frequency = <24000000>;
> +			};
> +
> +		};
> +	};
> +};

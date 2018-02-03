Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeBCLh0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 06:37:26 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBCLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 06:37:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 03 Feb 2018 17:07:19 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH 09/15] ARM: dts: ipq4019: Add qcom-ipq4019-ap.dk04.1-c3
 board file
In-Reply-To: <1517202689-14212-10-git-send-email-sricharan@codeaurora.org>
References: <1517202689-14212-1-git-send-email-sricharan@codeaurora.org>
 <1517202689-14212-10-git-send-email-sricharan@codeaurora.org>
Message-ID: <4a173ff2a74ed7d1555d52674cf64ddd@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-01-29 10:41, Sricharan R wrote:
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 68e4b15..0104ba2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -727,6 +727,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-ipq4019-ap.dk01.1-c2.dtb \
>  	qcom-ipq4019-ap.dk04.1-c1.dtb \
>  	qcom-ipq4019-ap.dk04.1-c5.dtb \
> +	qcom-ipq4019-ap.dk04.1-c3.dtb \
>  	qcom-ipq8064-ap148.dtb \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
> b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
> new file mode 100644
> index 0000000..7a93fc4
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017, The Linux Foundation. All rights reserved.
> +
> +#include "qcom-ipq4019-ap.dk04.1.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ4019/AP-DK04.1-C3";
> +
> +	soc {
> +		nand: qpic-nand@79b0000 {
> +			status = "disabled";
> +		};

  Normally we need to disable in base dtsi and enable in
  board dtsi so that base dtsi will always work in all the
  boards. Now If We load the base dtsi in any DK04 board
  other than C1, then nand failure will come.

  Thanks,
  Abhishek

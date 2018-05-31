Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755856AbeEaRRd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:17:33 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34880 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755678AbeEaRR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:17:29 -0400
X-Google-Smtp-Source: ADUXVKIEQml28XqpKluuMlihVGWaRQLQ+I0gJCKGQXMnfgeBozYUS1pMPEkY1CGLAxzBoB/Q8hmLJw==
Date: Thu, 31 May 2018 12:17:26 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com
Subject: Re: [PATCH 2/2] arm64: dts: Add Mediatek X20 Development Board
 support
Message-ID: <20180531171726.GB23016@rob-hp-laptop>
References: <20180529045258.1415-1-manivannan.sadhasivam@linaro.org>
 <20180529045258.1415-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529045258.1415-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tOn Tue, May 29, 2018 at 10:22:58AM +0530, Manivannan Sadhasivam wrote:
> Add initial device tree support for Mediatek X20 Development Board
> based on MT6797 Deca core SoC. This board is one of the 96Boards
> Consumer Edition platform.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index ac17f60f998c..5b7fd6ad96e4 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> new file mode 100644
> index 000000000000..2c09ca95d9e2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for MediaTek X20 Development Board
> + *
> + * Copyright (C) 2018, Linaro Ltd.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "mt6797.dtsi"
> +
> +/ {
> +	model = "Mediatek X20 Development Board";
> +	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";

The board compatible needs documenting.

> +
> +	aliases {
> +		serial0 = &uart1;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x1e605000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> -- 
> 2.17.0
> 

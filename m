Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753699AbeC0Quw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:50:52 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33988 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC0Qut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:50:49 -0400
X-Google-Smtp-Source: AIpwx4+lXU7DfgUsW4t2TRooaWLDineD1C/Ev5qRyxg+DHiJK3Gz9LZSUrqyiiaU27iHDLo8zkrOIw==
Date: Tue, 27 Mar 2018 09:50:59 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com, sboyd@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, absahu@codeaurora.org, marc.zyngier@arm.com,
        richardcochran@gmail.com
Subject: Re: [PATCH v5 03/13] ARM: dts: ipq4019: Add a few peripheral nodes
Message-ID: <20180327165059.GE1403@tuxbook-pro>
References: <1521800336-19266-1-git-send-email-sricharan@codeaurora.org>
 <1521800336-19266-4-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521800336-19266-4-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 23 Mar 03:18 PDT 2018, Sricharan R wrote:
> @@ -172,6 +180,22 @@
>  			clock-names = "core", "iface";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
> +			dma-names = "rx", "tx";
> +			status = "disabled";
> +		};
> +
> +		spi_1: spi@78b6000 { /* BLSP1 QUP2 */
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x78b6000 0x600>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
> +				<&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
> +			dma-names = "rx", "tx";
>  			status = "disabled";
>  		};
>  
> @@ -184,9 +208,24 @@
>  			clock-names = "iface", "core";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +			dmas = <&blsp_dma 9>, <&blsp_dma 8>;
> +			dma-names = "rx", "tx";
>  			status = "disabled";
>  		};
>  
> +		i2c_1: i2c@78b8000 { /* BLSP1 QUP4 */

The label, comment and the core clock disagrees on which qup this is.

Label your nodes based on the SoC naming, not your board - as this will
prevent a future board from using e.g. blsp1 qup2 as i2c (as you already
used the label for that).

> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x78b8000 0x600>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> +				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;

QUP4?

> +			clock-names = "iface", "core";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
> +			dma-names = "rx", "tx";
> +			status = "disabled";
> +		};

Apart from this the patch looks good.

Regards,
Bjorn

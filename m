Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC11C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39412710B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 09:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UFqvMJwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39412710B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936403AbeF3JnQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 05:43:16 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37322 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936096AbeF3JnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 05:43:14 -0400
Received: by mail-pg0-f65.google.com with SMTP id n15-v6so1787188pgv.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+udzymVFgC5pnW8HbJ5+TWomg9QNOElkZzAwZUKuxw=;
        b=UFqvMJwHIeMCLGp+Xgna+VkTfKVyRYgdiIxYNlD9iAqsUySIoTpRbHPbGzhHa89n4V
         EzJCLj4LR2Z+3XNLKHQgXpY4NKIzhx0Li6kfRlkoeMGYaAP/LfXHOddVDeTmcwCetKgr
         cAUWHq996XsuWk4IcDe+gwyhchH+zic01eoy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+udzymVFgC5pnW8HbJ5+TWomg9QNOElkZzAwZUKuxw=;
        b=cbU3zkIIXI1bVKfen2GSSbJ3YEKCrmj/CNDXU3MKsOO1a2gD4Jjzn8AI+ZRFyQ2SGJ
         Rwnvp+0qKWojk/nRN6gbhGQZsGK2nJKtRA5BwRYogXCOvJdSuVBNVgejEaPyzgh73p1u
         u8gJ9uslTYNXzGRJFc3OAZBgKlNcjl4sddEnMOBqOMXDbzo0SHhhbxERL/HLmkeYbGuY
         W6B8Jahk9Roc2ZeArF8D7TYbXoR6F3jai1cdMNQAgWesot0iYzTO/aQOWUXmC4hhRoYD
         thdQ0l1hZw+8ZKROHZtvmtSDeOA0/1f8YrOasZkYJfve+sdZipTPaOnxI5eZvqsU6HSD
         jFcg==
X-Gm-Message-State: APt69E1fHaBlPD09pVUfHj2Ado1hWXUEyV25F6WulqgXVBXxOAQ/zOWo
        dOUOdH7KZnraOu5UylmDOsdv
X-Google-Smtp-Source: ADUXVKLBv8X3ziGEwIKzJEh9y1jAcsqLtIAj6wPDtVwoW+otMuLhDAGdIAqKX/Z3i0DVQSx5G9OQvQ==
X-Received: by 2002:a65:6210:: with SMTP id d16-v6mr15109975pgv.272.1530351793610;
        Sat, 30 Jun 2018 02:43:13 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id g70-v6sm31331372pfc.107.2018.06.30.02.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Jun 2018 02:43:12 -0700 (PDT)
Date:   Sat, 30 Jun 2018 15:12:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, pn@denx.de,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: dts: actions: Enable clock controller for
 S700
Message-ID: <20180630094259.GC7320@Mani-XPS-13-9360>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628191805.3722-2-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:18:03PM +0200, Saravanan Sekar wrote:
> Added clock management controller for S700
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../boot/dts/actions/s700-cubieboard7.dts     |   7 -
>  arch/arm64/boot/dts/actions/s700.dtsi         |   8 ++
>  include/dt-bindings/clock/actions,s700-cmu.h  | 128 ++++++++++++++++++
>  3 files changed, 136 insertions(+), 7 deletions(-)
>  create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index ef79d7905f44..28f3f4a0f7f0 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -28,12 +28,6 @@
>  		device_type = "memory";
>  		reg = <0x1 0xe0000000 0x0 0x0>;
>  	};
> -
> -	uart3_clk: uart3-clk {
> -		compatible = "fixed-clock";
> -		clock-frequency = <921600>;
> -		#clock-cells = <0>;
> -	};

Sourcing CMU clock for UART should be in a separate patch.

>  };
>  
>  &timer {
> @@ -42,5 +36,4 @@
>  
>  &uart3 {
>  	status = "okay";
> -	clocks = <&uart3_clk>;
>  };
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 66dd5309f0a2..3530b705df90 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/actions,s700-cmu.h>
>  
>  / {
>  	compatible = "actions,s700";
> @@ -44,6 +45,12 @@
>  		};
>  	};
>  
> +	clock: clock-controller@e0168000 {
> +		compatible = "actions,s700-cmu";
> +		reg = <0 0xe0168000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +

There is no fixed rate clock like losc?

>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -129,6 +136,7 @@
>  			compatible = "actions,s900-uart", "actions,owl-uart";
>  			reg = <0x0 0xe0126000 0x0 0x2000>;
>  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clock CLK_UART3>;
>  			status = "disabled";
>  		};
>  
> diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
> new file mode 100644
> index 000000000000..e5b4ea130953
> --- /dev/null
> +++ b/include/dt-bindings/clock/actions,s700-cmu.h
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Actions S700 clock driver
> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Author: David Liu <liuwei@actions-semi.com>
> + *
> + * Author: Pathiban Nallathambi <pn@denx.de>
> + * Author: Saravanan Sekar <sravanhome@gmail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_S700_H
> +#define __DT_BINDINGS_CLOCK_S700_H
> +
> +#define CLK_NONE			0
> +
> +/* fixed rate clocks */
> +#define CLK_LOSC			1
> +#define CLK_HOSC			2
> +
> +/* pll clocks */
> +#define CLK_CORE_PLL			3
> +#define CLK_DEV_PLL			4
> +#define CLK_DDR_PLL			5
> +#define CLK_NAND_PLL			6
> +#define CLK_DISPLAY_PLL			7
> +#define CLK_TVOUT_PLL			8
> +#define CLK_CVBS_PLL			9
> +#define CLK_AUDIO_PLL			10
> +#define CLK_ETHERNET_PLL		11
> +

Remove extra new line please.

> +
> +/* system clock */
> +#define CLK_SYS_BASE			12
> +#define CLK_CPU				CLK_SYS_BASE
> +#define CLK_DEV				(CLK_SYS_BASE+1)
> +#define CLK_AHB				(CLK_SYS_BASE+2)
> +#define CLK_APB				(CLK_SYS_BASE+3)
> +#define CLK_DMAC			(CLK_SYS_BASE+4)
> +#define CLK_NOC0_CLK_MUX		(CLK_SYS_BASE+5)
> +#define CLK_NOC1_CLK_MUX		(CLK_SYS_BASE+6)
> +#define CLK_HP_CLK_MUX			(CLK_SYS_BASE+7)
> +#define CLK_HP_CLK_DIV			(CLK_SYS_BASE+8)
> +#define CLK_NOC1_CLK_DIV		(CLK_SYS_BASE+9)
> +#define CLK_NOC0			(CLK_SYS_BASE+10)
> +#define CLK_NOC1			(CLK_SYS_BASE+11)
> +#define CLK_SENOR_SRC			(CLK_SYS_BASE+12)
> +
> +/* peripheral device clock */
> +#define CLK_PERIP_BASE			25
> +#define CLK_GPIO			(CLK_PERIP_BASE)
> +#define CLK_TIMER			(CLK_PERIP_BASE+1)
> +#define CLK_DSI				(CLK_PERIP_BASE+2)
> +#define CLK_CSI				(CLK_PERIP_BASE+3)
> +#define CLK_SI				(CLK_PERIP_BASE+4)
> +#define CLK_DE				(CLK_PERIP_BASE+5)
> +#define CLK_HDE				(CLK_PERIP_BASE+6)
> +#define CLK_VDE				(CLK_PERIP_BASE+7)
> +#define CLK_VCE				(CLK_PERIP_BASE+8)
> +#define CLK_NAND			(CLK_PERIP_BASE+9)
> +#define CLK_SD0				(CLK_PERIP_BASE+10)
> +#define CLK_SD1				(CLK_PERIP_BASE+11)
> +#define CLK_SD2				(CLK_PERIP_BASE+12)
> +
> +#define CLK_UART0			(CLK_PERIP_BASE+13)
> +#define CLK_UART1			(CLK_PERIP_BASE+14)
> +#define CLK_UART2			(CLK_PERIP_BASE+15)
> +#define CLK_UART3			(CLK_PERIP_BASE+16)
> +#define CLK_UART4			(CLK_PERIP_BASE+17)
> +#define CLK_UART5			(CLK_PERIP_BASE+18)
> +#define CLK_UART6			(CLK_PERIP_BASE+19)
> +
> +#define CLK_PWM0			(CLK_PERIP_BASE+20)
> +#define CLK_PWM1			(CLK_PERIP_BASE+21)
> +#define CLK_PWM2			(CLK_PERIP_BASE+22)
> +#define CLK_PWM3			(CLK_PERIP_BASE+23)
> +#define CLK_PWM4			(CLK_PERIP_BASE+24)
> +#define CLK_PWM5			(CLK_PERIP_BASE+25)
> +#define CLK_GPU3D			(CLK_PERIP_BASE+26)
> +
> +#define CLK_I2C0			(CLK_PERIP_BASE+27)
> +#define CLK_I2C1			(CLK_PERIP_BASE+28)
> +#define CLK_I2C2			(CLK_PERIP_BASE+29)
> +#define CLK_I2C3			(CLK_PERIP_BASE+30)
> +
> +
> +#define CLK_SPI0			(CLK_PERIP_BASE+31)
> +#define CLK_SPI1			(CLK_PERIP_BASE+32)
> +#define CLK_SPI2			(CLK_PERIP_BASE+33)
> +#define CLK_SPI3			(CLK_PERIP_BASE+34)
> +
> +#define CLK_USB3_480MPLL0		(CLK_PERIP_BASE+35)
> +#define CLK_USB3_480MPHY0		(CLK_PERIP_BASE+36)
> +#define CLK_USB3_5GPHY			(CLK_PERIP_BASE+37)
> +#define CLK_USB3_CCE			(CLK_PERIP_BASE+48)
> +#define CLK_USB3_MAC			(CLK_PERIP_BASE+49)
> +
> +
> +#define CLK_LCD				(CLK_PERIP_BASE+50)
> +#define CLK_HDMI_AUDIO			(CLK_PERIP_BASE+51)
> +#define CLK_I2SRX			(CLK_PERIP_BASE+52)
> +#define CLK_I2STX			(CLK_PERIP_BASE+53)
> +
> +#define CLK_SENSOR0			(CLK_PERIP_BASE+54)
> +#define CLK_SENSOR1			(CLK_PERIP_BASE+55)
> +
> +#define CLK_HDMI_DEV			(CLK_PERIP_BASE+56)
> +
> +#define CLK_ETHERNET			(CLK_PERIP_BASE+59)
> +#define CLK_RMII_REF			(CLK_PERIP_BASE+60)
> +
> +#define CLK_USB2H0_PLLEN		(CLK_PERIP_BASE+61)
> +#define CLK_USB2H0_PHY			(CLK_PERIP_BASE+62)
> +#define CLK_USB2H0_CCE			(CLK_PERIP_BASE+63)
> +#define CLK_USB2H1_PLLEN		(CLK_PERIP_BASE+64)
> +#define CLK_USB2H1_PHY			(CLK_PERIP_BASE+65)
> +#define CLK_USB2H1_CCE			(CLK_PERIP_BASE+66)
> +
> +
> +#define CLK_TVOUT			(CLK_PERIP_BASE+67)
> +
> +#define CLK_THERMAL_SENSOR		(CLK_PERIP_BASE+68)
> +
> +#define CLK_IRC_SWITCH			(CLK_PERIP_BASE+69)
> +#define CLK_PCM1			(CLK_PERIP_BASE+70)
> +#define CLK_NR_CLKS			(CLK_PCM1) /* update on adding new clk */
> +

Since the index starts from 0, CLK_NR_CLKS should be CLK_PCM1 + 1

Thanks,
Mani

> +#endif /* __DT_BINDINGS_CLOCK_S700_H */
> -- 
> 2.18.0
> 

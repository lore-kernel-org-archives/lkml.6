Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C66C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAEE2403E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 23:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAEE2403E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbeGEXTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 19:19:49 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44236 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeGEXTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 19:19:47 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so20038674oih.11;
        Thu, 05 Jul 2018 16:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O37SOxh6sNX/wNbG5haJPqwqIcTBLPZnPtJCxNX2Pkw=;
        b=FhrnrpBmOIjqPSl5KCN5N//v6R4gSbUsVOm58MGtMYn8jp7hs5csHBYqdwYduCXP8N
         ZTTaXDdiGVXHkKzDG3IwTiGa4S+vZkC8zTfFVeKmmCGmL4ExAcalDUHzSZielqIkYh28
         Xq3n7lT9SlERkSfor4m797fhU8os1L0ihcutxMwtZYz/8LF5zYTCam6B8KX/yysLBmQP
         wSECqWac8Eo9EddGYPMA/onMruizEeYQgP6LdMDU3/aMgYqYUGIw66Dvu06FXU62G7n+
         Q6EACU6Cl4PtU0K21LbobbTp7iEX3hfyZ7B/czA/tO7bRLvHbE8Ls4Lf4SBsPFzySu42
         ZUfg==
X-Gm-Message-State: APt69E3EH62mGWb93IW6VID0u7+EMT8dyaGuQUV0Dhrc6kMTsH3LDmXp
        UeXuLXCI5Dw9TKjD1Vyi4w==
X-Google-Smtp-Source: AAOMgpcDl+Bj9YFSGFrtPOT4YMnRSuUa1pzVU8tCLqi15s/ZbZdaH6nXmrki9G6TuPsmDZOpH3HbqA==
X-Received: by 2002:aca:5545:: with SMTP id j66-v6mr9576987oib.291.1530832786466;
        Thu, 05 Jul 2018 16:19:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e1-v6sm5985476oiy.19.2018.07.05.16.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 16:19:45 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:19:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        devicetree@vger.kernel.org, support@cubietech.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        linux@cubietech.com, darren@cubietech.com, mp-cs@actions-semi.com,
        pn@denx.de
Subject: Re: [PATCH v3 1/5] dt-bindings: clock: Rename document generic to
 Actions Semi Soc's
Message-ID: <20180705231944.GA3359@rob-hp-laptop>
References: <20180703092524.1697111-1-sravanhome@gmail.com>
 <20180703092524.1697111-2-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703092524.1697111-2-sravanhome@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 11:25:20AM +0200, Saravanan Sekar wrote:
> Rename document generic to Actions Semi Owl S700/S900 Soc's.
> Add clock bindings constants for action S700

The important think you are doing is adding the S700, so the subject 
should reflect that. Renaming is secondary. Please the subject and 
commit msg wording is not very coherent.

> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../{actions,s900-cmu.txt => actions,owl-cmu.txt}  |  20 ++--
>  include/dt-bindings/clock/actions,s700-cmu.h       | 128 +++++++++++++++++++++
>  2 files changed, 139 insertions(+), 9 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,owl-cmu.txt} (67%)
>  create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> similarity index 67%
> rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> rename to Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> index 93e4fb827cd6..d737ea74a450 100644
> --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> +++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
> @@ -1,12 +1,14 @@
> -* Actions S900 Clock Management Unit (CMU)
> +* Actions Semi Owl Clock Management Unit (CMU)
>  
> -The Actions S900 clock management unit generates and supplies clock to various
> -controllers within the SoC. The clock binding described here is applicable to
> -S900 SoC.
> +The Actions Semi S900/S700 clock management unit generates and supplies clock
> +to various controllers within the SoC. The clock binding described here is
> +applicable to S900 and S700 SoC's.
>  
>  Required Properties:
>  
> -- compatible: should be "actions,s900-cmu"
> +- compatible: should be one of the following,
> +	"actions,s900-cmu"
> +	"actions,s700-cmu"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - clocks: Reference to the parent clocks ("hosc", "losc")
> @@ -15,16 +17,16 @@ Required Properties:
>  Each clock is assigned an identifier, and client nodes can use this identifier
>  to specify the clock which they consume.
>  
> -All available clocks are defined as preprocessor macros in
> -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
> -tree sources.
> +All available clocks are defined as preprocessor macros in corresponding
> +dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h header and can be
> +used in device tree sources.
>  
>  External clocks:
>  
>  The hosc clock used as input for the plls is generated outside the SoC. It is
>  expected that it is defined using standard clock bindings as "hosc".
>  
> -Actions S900 CMU also requires one more clock:
> +Actions Semi S900 CMU also requires one more clock:
>   - "losc" - internal low frequency oscillator
>  
>  Example: Clock Management Unit node:
> diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
> new file mode 100644
> index 000000000000..b8b8baa34613
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

These are inputs and outputs? Does the CMU block actually control them? 
If not, then they should not be part of this number space.

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
> +
> +/* system clock */
> +#define CLK_SYS_BASE			12
> +#define CLK_CPU				CLK_SYS_BASE
> +#define CLK_DEV				(CLK_SYS_BASE+1)

Not really any point to have the base define because you can never 
change it. It's an ABI.

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
> +#define CLK_NR_CLKS			(CLK_PCM1+1) /* update on adding new clk */
> +
> +#endif /* __DT_BINDINGS_CLOCK_S700_H */
> -- 
> 2.14.4
> 

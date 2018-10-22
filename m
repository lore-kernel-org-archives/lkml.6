Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DEAC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF1A20674
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF1A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJWGhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:37:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33472 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeJWGhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:37:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so33611570oib.0;
        Mon, 22 Oct 2018 15:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2PZ8c6z6YRxDvgMBZbbU5YUlsbs7z7YObFMJie7ZRc=;
        b=Vu/kOQ6P2jZflCXBGsZuAXrpWyreuyDO073oko8lugQtBRcpviTD/3usGeByCkvl07
         I3q8E9evOnc4zR1zQQIkExsblVPmPSxZD93Dt8iKCG7mc2rq+cHYs7NBrcOYiEbPlfLQ
         +7x8Z4+PivPP8WI4L1DiDVQOQcZqlBk08OsMT2cUonWD3eCfLIGw9GP3mInu2n/8YGSf
         QF0LzSUn12M0qOrY3Zmaun8+k1UNXSD6zAtklaH9M0CsiY6Nj6L9NtKfhSNYH1PH69B3
         O/dGhjqw8ebDKFbaQF/7zu2UNkxa2BhlRFuG+8eY6qVFZ1oWtKxAmRpTRTdRZCMAUbPn
         ejTw==
X-Gm-Message-State: ABuFfoiua6Y8JSwVEpzYiMOcbwxrelhuxCoy4LHyWn1g4bUZrz5rJH93
        PJE3Upfw7bh30NWhXqDzFihmmcY=
X-Google-Smtp-Source: ACcGV63hvrjXGk89j9MZj6tmJEzI69H7TMl13/X2HVqSW7s6S1D3m6gqcwjoA3Eqdy5+ANFb1GViqA==
X-Received: by 2002:aca:e24f:: with SMTP id z76-v6mr26337411oig.95.1540246600776;
        Mon, 22 Oct 2018 15:16:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j22sm12195520ote.61.2018.10.22.15.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 15:16:40 -0700 (PDT)
Date:   Mon, 22 Oct 2018 17:16:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     "A.s. Dong" <aisheng.dong@nxp.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH RESEND V4 6/9] dt-bindings: clock: add imx7ulp clock
 binding doc
Message-ID: <20181022221639.GA31408@bogus>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
 <1540127173-21346-7-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540127173-21346-7-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 01:11:09PM +0000, A.s. Dong wrote:
> i.MX7ULP Clock functions are under joint control of the System
> Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> modules, and Core Mode Controller (CMC)1 blocks
> 
> Note IMX7ULP has two clock domains: M4 and A7. This binding doc
> is only for A7 clock domain.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Anson Huang <Anson.Huang@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> ---
> ChangeLog:
> v3->v4:
>  * make scg, pcc separate nodes according to Rob's suggestion
> v2->v3:
>  * no changes
> v1->v2: no changes
> ---
>  .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 ++++++++++++++++
>  include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++++++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
>  create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> new file mode 100644
> index 0000000..2239383
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
> @@ -0,0 +1,87 @@
> +* Clock bindings for Freescale i.MX7ULP
> +
> +i.MX7ULP Clock functions are under joint control of the System
> +Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
> +modules, and Core Mode Controller (CMC)1 blocks
> +
> +The clocking scheme provides clear separation between M4 domain
> +and A7 domain. Except for a few clock sources shared between two
> +domains, such as the System Oscillator clock, the Slow IRC (SIRC),
> +and and the Fast IRC clock (FIRCLK), clock sources and clock
> +management are separated and contained within each domain.
> +
> +M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> +A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

Where's the CMC1 binding?

> +
> +Note: this binding doc is only for A7 clock domain.
> +
> +System Clock Generation (SCG) modules:
> +---------------------------------------------------------------------
> +The System Clock Generation (SCG) is responsible for clock generation
> +and distribution across this device. Functions performed by the SCG
> +include: clock reference selection, generation of clock used to derive
> +processor, system, peripheral bus and external memory interface clocks,
> +source selection for peripheral clocks and control of power saving
> +clock gating mode.
> +
> +Required properties:
> +
> +- compatible:	Should be "fsl,imx7ulp-scg1".
> +- reg : 	Should contain registers location and length.
> +- #clock-cells:	Should be <1>.
> +- clocks:	Should contain the fixed input clocks.
> +- clock-name:   Should contain the following clock names:"rosc", "sosc",

clock-names

> +		"sirc", "firc", "upll", "mpll".
> +
> +Peripheral Clock Control (PCC) modules:
> +---------------------------------------------------------------------
> +The Peripheral Clock Control (PCC) is responsible for clock selection,
> +optional division and clock gating mode for peripherals in their
> +respected power domain
> +
> +Required properties:
> +- compatible:	Should be "fsl,imx7ulp-pcc2" or "fsl,imx7ulp-pcc3".

Please format one per line.

There's some register layout difference between PCC2 and PCC3?

> +- reg : 	Should contain registers location and length.
> +- #clock-cells:	Should be <1>.

No input clocks to list?

> +
> +The clock consumer should specify the desired clock by having the clock
> +ID in its "clocks" phandle cell.
> +See include/dt-bindings/clock/imx7ulp-clock.h
> +for the full list of i.MX7ULP clock IDs of each module.
> +
> +Examples:
> +
> +#include <dt-bindings/clock/imx7ulp-clock.h>
> +
> +scg1: scg1@403e0000 {
> +	compatible = "fsl,imx7ulp-scg1;
> +	reg = <0x403e0000 0x10000>;
> +	clocks = <&rosc>, <&sosc>, <&sirc>,
> +		 <&firc>, <&upll>, <&mpll>;
> +	clock-names = "rosc", "sosc", "sirc",
> +		      "firc", "upll", "mpll";
> +	#clock-cells = <1>;
> +};
> +
> +pcc2: pcc2@403f0000 {
> +	compatible = "fsl,imx7ulp-pcc2";
> +	reg = <0x403f0000 0x10000>;
> +	#clock-cells = <1>;
> +};
> +
> +pcc3: pcc3@40b30000 {
> +	compatible = "fsl,imx7ulp-pcc3";
> +	reg = <0x40b30000 0x10000>;
> +	#clock-cells = <1>;
> +};
> +
> +usdhc1: usdhc@40380000 {
> +	compatible = "fsl,imx7ulp-usdhc";
> +	reg = <0x40380000 0x10000>;
> +	interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
> +		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
> +		 <&pcc2 IMX7ULP_CLK_USDHC1>;
> +	clock-names ="ipg", "ahb", "per";
> +	bus-width = <4>;
> +};
> diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
> new file mode 100644
> index 0000000..008c5ee
> --- /dev/null
> +++ b/include/dt-bindings/clock/imx7ulp-clock.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + *
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H
> +#define __DT_BINDINGS_CLOCK_IMX7ULP_H
> +
> +/* SCG1 */
> +
> +#define IMX7ULP_CLK_DUMMY		0
> +#define IMX7ULP_CLK_ROSC		1
> +#define IMX7ULP_CLK_SOSC		2
> +#define IMX7ULP_CLK_FIRC		3
> +#define IMX7ULP_CLK_SPLL_PRE_SEL	4
> +#define IMX7ULP_CLK_SPLL_PRE_DIV	5
> +#define IMX7ULP_CLK_SPLL		6
> +#define IMX7ULP_CLK_SPLL_POST_DIV1	7
> +#define IMX7ULP_CLK_SPLL_POST_DIV2	8
> +#define IMX7ULP_CLK_SPLL_PFD0		9
> +#define IMX7ULP_CLK_SPLL_PFD1		10
> +#define IMX7ULP_CLK_SPLL_PFD2		11
> +#define IMX7ULP_CLK_SPLL_PFD3		12
> +#define IMX7ULP_CLK_SPLL_PFD_SEL	13
> +#define IMX7ULP_CLK_SPLL_SEL		14
> +#define IMX7ULP_CLK_APLL_PRE_SEL	15
> +#define IMX7ULP_CLK_APLL_PRE_DIV	16
> +#define IMX7ULP_CLK_APLL		17
> +#define IMX7ULP_CLK_APLL_POST_DIV1	18
> +#define IMX7ULP_CLK_APLL_POST_DIV2	19
> +#define IMX7ULP_CLK_APLL_PFD0		20
> +#define IMX7ULP_CLK_APLL_PFD1		21
> +#define IMX7ULP_CLK_APLL_PFD2		22
> +#define IMX7ULP_CLK_APLL_PFD3		23
> +#define IMX7ULP_CLK_APLL_PFD_SEL	24
> +#define IMX7ULP_CLK_APLL_SEL		25
> +#define IMX7ULP_CLK_UPLL		26
> +#define IMX7ULP_CLK_SYS_SEL		27
> +#define IMX7ULP_CLK_CORE_DIV		28
> +#define IMX7ULP_CLK_BUS_DIV		29
> +#define IMX7ULP_CLK_PLAT_DIV		30
> +#define IMX7ULP_CLK_DDR_SEL		31
> +#define IMX7ULP_CLK_DDR_DIV		32
> +#define IMX7ULP_CLK_NIC_SEL		33
> +#define IMX7ULP_CLK_NIC0_DIV		34
> +#define IMX7ULP_CLK_GPU_DIV		35
> +#define IMX7ULP_CLK_NIC1_DIV		36
> +#define IMX7ULP_CLK_NIC1_BUS_DIV	37
> +#define IMX7ULP_CLK_NIC1_EXT_DIV	38
> +#define IMX7ULP_CLK_MIPI_PLL		39
> +#define IMX7ULP_CLK_SIRC		40
> +#define IMX7ULP_CLK_SOSC_BUS_CLK	41
> +#define IMX7ULP_CLK_FIRC_BUS_CLK	42
> +#define IMX7ULP_CLK_SPLL_BUS_CLK	43
> +
> +#define IMX7ULP_CLK_SCG1_END		44
> +
> +/* PCC2 */
> +#define IMX7ULP_CLK_DMA1		0
> +#define IMX7ULP_CLK_RGPIO2P1		1
> +#define IMX7ULP_CLK_FLEXBUS		2
> +#define IMX7ULP_CLK_SEMA42_1		3
> +#define IMX7ULP_CLK_DMA_MUX1		4
> +#define IMX7ULP_CLK_SNVS		5
> +#define IMX7ULP_CLK_CAAM		6
> +#define IMX7ULP_CLK_LPTPM4		7
> +#define IMX7ULP_CLK_LPTPM5		8
> +#define IMX7ULP_CLK_LPIT1		9
> +#define IMX7ULP_CLK_LPSPI2		10
> +#define IMX7ULP_CLK_LPSPI3		11
> +#define IMX7ULP_CLK_LPI2C4		12
> +#define IMX7ULP_CLK_LPI2C5		13
> +#define IMX7ULP_CLK_LPUART4		14
> +#define IMX7ULP_CLK_LPUART5		15
> +#define IMX7ULP_CLK_FLEXIO1		16
> +#define IMX7ULP_CLK_USB0		17
> +#define IMX7ULP_CLK_USB1		18
> +#define IMX7ULP_CLK_USB_PHY		19
> +#define IMX7ULP_CLK_USB_PL301		20
> +#define IMX7ULP_CLK_USDHC0		21
> +#define IMX7ULP_CLK_USDHC1		22
> +#define IMX7ULP_CLK_WDG1		23
> +#define IMX7ULP_CLK_WDG2		24
> +
> +#define IMX7ULP_CLK_PCC2_END		25
> +
> +/* PCC3 */
> +#define IMX7ULP_CLK_LPTPM6		0
> +#define IMX7ULP_CLK_LPTPM7		1
> +#define IMX7ULP_CLK_LPI2C6		2
> +#define IMX7ULP_CLK_LPI2C7		3
> +#define IMX7ULP_CLK_LPUART6		4
> +#define IMX7ULP_CLK_LPUART7		5
> +#define IMX7ULP_CLK_VIU			6
> +#define IMX7ULP_CLK_DSI			7
> +#define IMX7ULP_CLK_LCDIF		8
> +#define IMX7ULP_CLK_MMDC		9
> +#define IMX7ULP_CLK_PCTLC		10
> +#define IMX7ULP_CLK_PCTLD		11
> +#define IMX7ULP_CLK_PCTLE		12
> +#define IMX7ULP_CLK_PCTLF		13
> +#define IMX7ULP_CLK_GPU3D		14
> +#define IMX7ULP_CLK_GPU2D		15
> +
> +#define IMX7ULP_CLK_PCC3_END		16
> +
> +#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
> -- 
> 2.7.4
> 

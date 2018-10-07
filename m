Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD45C65C33
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB8120895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 13:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXTHE+3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB8120895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeJGUjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbeJGUjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 16:39:16 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721F720882;
        Sun,  7 Oct 2018 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538919121;
        bh=wj2QmWov8A96peUkfsylEHO5nk/nrzp9lY/32T+O+JY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXTHE+3Qr1yJNJa79SC4OemF3QT8V1fuTlwQV//6bvoMULtwVnEq2PIsqOJFkaJt/
         2fXQMSAeO51yVtAlTl8Ot7Q5xxDD33yK2AXq4AUDrkUltOAF4OsxO0MwY979Qh94+V
         4bCkLEeNQQnpAbjpCNiCaDtQdZjUTI0nn5x+ok+k=
Date:   Sun, 7 Oct 2018 19:01:51 +0530
From:   Vinod <vkoul@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shefali Jain <shefjain@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add global clock controller driver
 for QCS404
Message-ID: <20181007133151.GS2372@vkoul-mobl>
References: <20180921185936.9590-1-vkoul@kernel.org>
 <20180921185936.9590-2-vkoul@kernel.org>
 <68d91d52-302d-1b0d-a995-bae976afe8e2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68d91d52-302d-1b0d-a995-bae976afe8e2@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thanks for the review, It would be great if you can strip the irrelevant
context while replying, makes it easier for people to follow.

On 06-10-18, 23:28, Taniya Das wrote:

> > +static struct clk_rcg2 pclk0_clk_src = {
> > +	.cmd_rcgr = 0x4d000,
> > +	.mnd_width = 8,
> > +	.hid_width = 5,
> > +	.parent_map = gcc_parent_map_12,
> > +	.clkr.hw.init = &(struct clk_init_data){
> > +		.name = "pclk0_clk_src",
> > +		.parent_names = gcc_parent_names_12,
> > +		.num_parents = 4,
> > +		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> 
> Please remove the NOCACHE flag for all display RCGs as there are no real
> requirement.

Thanks for the suggestion, will do

> > +++ b/include/dt-bindings/clock/qcom,gcc-qcs404.h
> > @@ -0,0 +1,166 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_QCS404_H
> > +#define _DT_BINDINGS_CLK_QCOM_GCC_QCS404_H
> > +
> > +#define APSS_AHB_CLK_SRC				0
> > +#define BLSP1_QUP0_I2C_APPS_CLK_SRC			1
> > +#define BLSP1_QUP0_SPI_APPS_CLK_SRC			2
> > +#define BLSP1_QUP1_I2C_APPS_CLK_SRC			3
> > +#define BLSP1_QUP1_SPI_APPS_CLK_SRC			4
> > +#define BLSP1_QUP2_I2C_APPS_CLK_SRC			5
> > +#define BLSP1_QUP2_SPI_APPS_CLK_SRC			6
> > +#define BLSP1_QUP3_I2C_APPS_CLK_SRC			7
> > +#define BLSP1_QUP3_SPI_APPS_CLK_SRC			8
> > +#define BLSP1_QUP4_I2C_APPS_CLK_SRC			9
> > +#define BLSP1_QUP4_SPI_APPS_CLK_SRC			10
> > +#define BLSP1_UART0_APPS_CLK_SRC			11
> > +#define BLSP1_UART1_APPS_CLK_SRC			12
> > +#define BLSP1_UART2_APPS_CLK_SRC			13
> > +#define BLSP1_UART3_APPS_CLK_SRC			14
> > +#define BLSP2_QUP0_I2C_APPS_CLK_SRC			15
> > +#define BLSP2_QUP0_SPI_APPS_CLK_SRC			16
> > +#define BLSP2_UART0_APPS_CLK_SRC			17
> > +#define BYTE0_CLK_SRC					18
> > +#define EMAC_CLK_SRC					19
> > +#define EMAC_PTP_CLK_SRC				20
> > +#define ESC0_CLK_SRC					21
> > +#define GCC_APSS_AHB_CLK				22
> > +#define GCC_APSS_AXI_CLK				23
> > +#define GCC_BIMC_APSS_AXI_CLK				24
> > +#define GCC_BIMC_GFX_CLK				25
> > +#define GCC_BIMC_MDSS_CLK				26
> > +#define GCC_BLSP1_AHB_CLK				27
> > +#define GCC_BLSP1_QUP0_I2C_APPS_CLK			28
> > +#define GCC_BLSP1_QUP0_SPI_APPS_CLK			29
> > +#define GCC_BLSP1_QUP1_I2C_APPS_CLK			30
> > +#define GCC_BLSP1_QUP1_SPI_APPS_CLK			31
> > +#define GCC_BLSP1_QUP2_I2C_APPS_CLK			32
> > +#define GCC_BLSP1_QUP2_SPI_APPS_CLK			33
> > +#define GCC_BLSP1_QUP3_I2C_APPS_CLK			34
> > +#define GCC_BLSP1_QUP3_SPI_APPS_CLK			35
> > +#define GCC_BLSP1_QUP4_I2C_APPS_CLK			36
> > +#define GCC_BLSP1_QUP4_SPI_APPS_CLK			37
> > +#define GCC_BLSP1_UART0_APPS_CLK			38
> > +#define GCC_BLSP1_UART1_APPS_CLK			39
> > +#define GCC_BLSP1_UART2_APPS_CLK			40
> > +#define GCC_BLSP1_UART3_APPS_CLK			41
> > +#define GCC_BLSP2_AHB_CLK				42
> > +#define GCC_BLSP2_QUP0_I2C_APPS_CLK			43
> > +#define GCC_BLSP2_QUP0_SPI_APPS_CLK			44
> > +#define GCC_BLSP2_UART0_APPS_CLK			45
> > +#define GCC_BOOT_ROM_AHB_CLK				46
> > +#define GCC_DCC_CLK					47
> > +#define GCC_GENI_IR_H_CLK				48
> > +#define GCC_ETH_AXI_CLK					49
> > +#define GCC_ETH_PTP_CLK					50
> > +#define GCC_ETH_RGMII_CLK				51
> > +#define GCC_ETH_SLAVE_AHB_CLK				52
> > +#define GCC_GENI_IR_S_CLK				53
> > +#define GCC_GP1_CLK					54
> > +#define GCC_GP2_CLK					55
> > +#define GCC_GP3_CLK					56
> > +#define GCC_MDSS_AHB_CLK				57
> > +#define GCC_MDSS_AXI_CLK				58
> > +#define GCC_MDSS_BYTE0_CLK				59
> > +#define GCC_MDSS_ESC0_CLK				60
> > +#define GCC_MDSS_HDMI_APP_CLK				61
> > +#define GCC_MDSS_HDMI_PCLK_CLK				62
> > +#define GCC_MDSS_MDP_CLK				63
> > +#define GCC_MDSS_PCLK0_CLK				64
> > +#define GCC_MDSS_VSYNC_CLK				65
> > +#define GCC_OXILI_AHB_CLK				66
> > +#define GCC_OXILI_GFX3D_CLK				67
> > +#define GCC_PCIE_0_AUX_CLK				68
> > +#define GCC_PCIE_0_CFG_AHB_CLK				69
> > +#define GCC_PCIE_0_MSTR_AXI_CLK				70
> > +#define GCC_PCIE_0_PIPE_CLK				71
> > +#define GCC_PCIE_0_SLV_AXI_CLK				72
> > +#define GCC_PCNOC_USB2_CLK				73
> > +#define GCC_PCNOC_USB3_CLK				74
> > +#define GCC_PDM2_CLK					75
> > +#define GCC_PDM_AHB_CLK					76
> > +#define VSYNC_CLK_SRC					77
> > +#define GCC_PRNG_AHB_CLK				78
> > +#define GCC_PWM0_XO512_CLK				79
> > +#define GCC_PWM1_XO512_CLK				80
> > +#define GCC_PWM2_XO512_CLK				81
> > +#define GCC_SDCC1_AHB_CLK				82
> > +#define GCC_SDCC1_APPS_CLK				83
> > +#define GCC_SDCC1_ICE_CORE_CLK				84
> > +#define GCC_SDCC2_AHB_CLK				85
> > +#define GCC_SDCC2_APPS_CLK				86
> > +#define GCC_SYS_NOC_USB3_CLK				87
> > +#define GCC_USB20_MOCK_UTMI_CLK				88
> > +#define GCC_USB2A_PHY_SLEEP_CLK				89
> > +#define GCC_USB30_MASTER_CLK				90
> > +#define GCC_USB30_MOCK_UTMI_CLK				91
> > +#define GCC_USB30_SLEEP_CLK				92
> > +#define GCC_USB3_PHY_AUX_CLK				93
> > +#define GCC_USB3_PHY_PIPE_CLK				94
> > +#define GCC_USB_HS_PHY_CFG_AHB_CLK			95
> > +#define GCC_USB_HS_SYSTEM_CLK				96
> > +#define GFX3D_CLK_SRC					97
> > +#define GP1_CLK_SRC					98
> > +#define GP2_CLK_SRC					99
> > +#define GP3_CLK_SRC					100
> > +#define GPLL0_OUT_MAIN					101
> > +#define GPLL1_OUT_MAIN					102
> > +#define GPLL3_OUT_MAIN					103
> > +#define GPLL4_OUT_MAIN					104
> > +#define HDMI_APP_CLK_SRC				105
> > +#define HDMI_PCLK_CLK_SRC				106
> > +#define MDP_CLK_SRC					107
> > +#define PCIE_0_AUX_CLK_SRC				108
> > +#define PCIE_0_PIPE_CLK_SRC				109
> > +#define PCLK0_CLK_SRC					110
> > +#define PDM2_CLK_SRC					111
> > +#define SDCC1_APPS_CLK_SRC				112
> > +#define SDCC1_ICE_CORE_CLK_SRC				113
> > +#define SDCC2_APPS_CLK_SRC				114
> > +#define USB20_MOCK_UTMI_CLK_SRC				115
> > +#define USB30_MASTER_CLK_SRC				116
> > +#define USB30_MOCK_UTMI_CLK_SRC				117
> > +#define USB3_PHY_AUX_CLK_SRC				118
> > +#define USB_HS_SYSTEM_CLK_SRC				119
> > +#define GPLL0_AO_CLK_SRC				120
> > +#define WCNSS_M_CLK					121
> 
> Please remove WCNSS_M_CLK.

And the reason for that?

-- 
~Vinod

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967657AbeBNL4S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:56:18 -0500
Received: from mail.kapsi.fi ([91.232.154.25]:41925 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967430AbeBNL4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:56:15 -0500
Subject: Re: [PATCH v2 6/7] arm64: tegra: Add Tegra194 chip device tree
To: Rob Herring <robh@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
 <1517901757-15353-7-git-send-email-mperttunen@nvidia.com>
 <20180209225402.uexw7vlzwflo7zmr@rob-hp-laptop>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, mark.rutland@arm.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <49fc21ac-4630-b90c-04fb-31740354b35b@kapsi.fi>
Date: Wed, 14 Feb 2018 13:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180209225402.uexw7vlzwflo7zmr@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.209.167.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.02.2018 00:54, Rob Herring wrote:
> On Tue, Feb 06, 2018 at 09:22:36AM +0200, Mikko Perttunen wrote:
>> ...
>> index 000000000000..dcc6eea52684
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/tegra194-clock.h
>> @@ -0,0 +1,664 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>
> You can remove all this boilerplate since you have SPDX tag.

OK, I'll remove the GPL boilerplate and leave the copyright line and 
SPDX tag.

>
>> + */
>> +
>> +#ifndef __ABI_MACH_T194_CLOCK_H
>> +#define __ABI_MACH_T194_CLOCK_H
>> +
>> +/** @file */
>> +
>> +/** @brief output of mux controlled by TEGRA194_CLK_SOC_ACTMON */
>> +#define TEGRA194_CLK_ACTMON			1
>> +/** @brief output of gate CLK_ENB_ADSP */
>
> These comments don't add much and make readability horrible.

The comments allow mapping each define to the clocks defined in the chip 
technical reference manual. The file also comes as is from the firmware 
team so I'd prefer to keep changes to a minimum. We have done this 
previously with the BPMP ABI and device tree binding headers for the 
Tegra186.

>
>> +#define TEGRA194_CLK_ADSP			2
>> +/** @brief output of gate CLK_ENB_ADSPNEON */
>> +#define TEGRA194_CLK_ADSPNEON			3
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AHUB */
>> +#define TEGRA194_CLK_AHUB			4
>> +/** @brief output of gate CLK_ENB_APB2APE */
>> +#define TEGRA194_CLK_APB2APE			5
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_APE */
>> +#define TEGRA194_CLK_APE			6
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AUD_MCLK */
>> +#define TEGRA194_CLK_AUD_MCLK			7
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AXI_CBB */
>> +#define TEGRA194_CLK_AXI_CBB			8
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_CAN1 */
>> +#define TEGRA194_CLK_CAN1			9
>> +/** @brief output of gate CLK_ENB_CAN1_HOST */
>> +#define TEGRA194_CLK_CAN1_HOST			10
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_CAN2 */
>> +#define TEGRA194_CLK_CAN2			11
>> +/** @brief output of gate CLK_ENB_CAN2_HOST */
>> +#define TEGRA194_CLK_CAN2_HOST			12
>> +/** @brief output of gate CLK_ENB_CEC */
>> +#define TEGRA194_CLK_CEC			13
>> +/** @brief output of divider CLK_RST_CONTROLLER_CLK_M_DIVIDE */
>> +#define TEGRA194_CLK_CLK_M			14
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC1 */
>> +#define TEGRA194_CLK_DMIC1			15
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC2 */
>> +#define TEGRA194_CLK_DMIC2			16
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC3 */
>> +#define TEGRA194_CLK_DMIC3			17
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC4 */
>> +#define TEGRA194_CLK_DMIC4			18
>> +/** @brief output of gate CLK_ENB_DPAUX */
>> +#define TEGRA194_CLK_DPAUX			19
>> +/** @brief output of gate CLK_ENB_DPAUX1 */
>> +#define TEGRA194_CLK_DPAUX1			20
>> +/**
>> + * @brief output of mux controlled by CLK_RST_CONTROLLER_ACLK_BURST_POLICY
>> + * divided by the divider controlled by ACLK_CLK_DIVISOR in
>> + * CLK_RST_CONTROLLER_SUPER_ACLK_DIVIDER
>> + */
>> +#define TEGRA194_CLK_ACLK			21
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_MSS_ENCRYPT switch divider output */
>> +#define TEGRA194_CLK_MSS_ENCRYPT		22
>> +/** @brief clock recovered from EAVB input */
>> +#define TEGRA194_CLK_EQOS_RX_INPUT		23
>> +/** @brief Output of gate CLK_ENB_IQC2 */
>> +#define TEGRA194_CLK_IQC2			24
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_AON_APB switch divider output */
>> +#define TEGRA194_CLK_AON_APB			25
>> +/** @brief CLK_RST_CONTROLLER_AON_NIC_RATE divider output */
>> +#define TEGRA194_CLK_AON_NIC			26
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_AON_CPU_NIC switch divider output */
>> +#define TEGRA194_CLK_AON_CPU_NIC		27
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLA1_BASE for use by audio clocks */
>> +#define TEGRA194_CLK_PLLA1			28
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSPK1 */
>> +#define TEGRA194_CLK_DSPK1			29
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSPK2 */
>> +#define TEGRA194_CLK_DSPK2			30
>> +/**
>> + * @brief controls the EMC clock frequency.
>> + * @details Doing a clk_set_rate on this clock will select the
>> + * appropriate clock source, program the source rate and execute a
>> + * specific sequence to switch to the new clock source for both memory
>> + * controllers. This can be used to control the balance between memory
>> + * throughput and memory controller power.
>> + */
>> +#define TEGRA194_CLK_EMC			31
>> +/** @brief output of gate CLK_ENB_EQOS */
>> +#define TEGRA194_CLK_EQOS_AXI			32
>> +/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_EQOS_PTP_REF_CLK_0 */
>> +#define TEGRA194_CLK_EQOS_PTP_REF		33
>> +/** @brief output of gate CLK_ENB_EQOS_RX */
>> +#define TEGRA194_CLK_EQOS_RX			34
>> +/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_EQOS_TX_CLK */
>> +#define TEGRA194_CLK_EQOS_TX			35
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH1 */
>> +#define TEGRA194_CLK_EXTPERIPH1			36
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH2 */
>> +#define TEGRA194_CLK_EXTPERIPH2			37
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH3 */
>> +#define TEGRA194_CLK_EXTPERIPH3			38
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_EXTPERIPH4 */
>> +#define TEGRA194_CLK_EXTPERIPH4			39
>> +/** @brief output of gate CLK_ENB_FUSE */
>> +#define TEGRA194_CLK_FUSE			40
>> +/** @brief GPC2CLK-div-2 */
>> +#define TEGRA194_CLK_GPCCLK			41
>> +/** @brief TODO */
>> +#define TEGRA194_CLK_GPU_PWR			42
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_HDA2CODEC_2X */
>> +#define TEGRA194_CLK_HDA			43
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_HDA2CODEC_2X */
>> +#define TEGRA194_CLK_HDA2CODEC_2X		44
>> +/** @brief output of gate CLK_ENB_HDA2HDMICODEC */
>> +#define TEGRA194_CLK_HDA2HDMICODEC		45
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_HOST1X */
>> +#define TEGRA194_CLK_HOST1X			46
>> +/** @brief Obselete - maintained for ABI compatibility */
>> +#define TEGRA194_CLK_HSIC_TRK			47
>> +/** @clkdesc{i2c_clks, out, mux, CLK_RST_CONTROLLER_CLK_SOURCE_I2C1} */
>> +#define TEGRA194_CLK_I2C1			48
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C2 */
>> +#define TEGRA194_CLK_I2C2			49
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C3 */
>> +#define TEGRA194_CLK_I2C3			50
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C4 */
>> +#define TEGRA194_CLK_I2C4			51
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C6 */
>> +#define TEGRA194_CLK_I2C6			52
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C7 */
>> +#define TEGRA194_CLK_I2C7			53
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C8 */
>> +#define TEGRA194_CLK_I2C8			54
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C9 */
>> +#define TEGRA194_CLK_I2C9			55
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S1 */
>> +#define TEGRA194_CLK_I2S1			56
>> +/** @brief clock recovered from I2S1 input */
>> +#define TEGRA194_CLK_I2S1_SYNC_INPUT		57
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S2 */
>> +#define TEGRA194_CLK_I2S2			58
>> +/** @brief clock recovered from I2S2 input */
>> +#define TEGRA194_CLK_I2S2_SYNC_INPUT		59
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S3 */
>> +#define TEGRA194_CLK_I2S3			60
>> +/** @brief clock recovered from I2S3 input */
>> +#define TEGRA194_CLK_I2S3_SYNC_INPUT		61
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S4 */
>> +#define TEGRA194_CLK_I2S4			62
>> +/** @brief clock recovered from I2S4 input */
>> +#define TEGRA194_CLK_I2S4_SYNC_INPUT		63
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S5 */
>> +#define TEGRA194_CLK_I2S5			64
>> +/** @brief clock recovered from I2S5 input */
>> +#define TEGRA194_CLK_I2S5_SYNC_INPUT		65
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C6 */
>> +#define TEGRA194_CLK_I2S6			66
>> +/** @brief clock recovered from I2S6 input */
>> +#define TEGRA194_CLK_I2S6_SYNC_INPUT		67
>> +/** @brief output of gate CLK_ENB_IQC1 */
>> +#define TEGRA194_CLK_IQC1			68
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_ISP */
>> +#define TEGRA194_CLK_ISP			69
>> +/**
>> + * @brief A fake clock which must be enabled during
>> + * KFUSE read operations to ensure adequate VDD_CORE voltage
>> + */
>> +#define TEGRA194_CLK_KFUSE			70
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_MAUD */
>> +#define TEGRA194_CLK_MAUD			71
>> +/** @brief output of gate CLK_ENB_MIPI_CAL */
>> +#define TEGRA194_CLK_MIPI_CAL			72
>> +/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_CORE_PLL_FIXED */
>> +#define TEGRA194_CLK_MPHY_CORE_PLL_FIXED	73
>> +/** @brief output of gate CLK_ENB_MPHY_L0_RX_ANA */
>> +#define TEGRA194_CLK_MPHY_L0_RX_ANA		74
>> +/** @brief output of gate CLK_ENB_MPHY_L0_RX_LS_BIT */
>> +#define TEGRA194_CLK_MPHY_L0_RX_LS_BIT		75
>> +/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_L0_RX_LS_SYMB */
>> +#define TEGRA194_CLK_MPHY_L0_RX_SYMB		76
>> +/** @brief output of gate CLK_ENB_MPHY_L0_TX_LS_3XBIT */
>> +#define TEGRA194_CLK_MPHY_L0_TX_LS_3XBIT	77
>> +/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_L0_TX_LS_SYMB */
>> +#define TEGRA194_CLK_MPHY_L0_TX_SYMB		78
>> +/** @brief output of gate CLK_ENB_MPHY_L1_RX_ANA */
>> +#define TEGRA194_CLK_MPHY_L1_RX_ANA		79
>> +/** @brief output of the divider CLK_RST_CONTROLLER_CLK_SOURCE_MPHY_TX_1MHZ_REF */
>> +#define TEGRA194_CLK_MPHY_TX_1MHZ_REF		80
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVCSI */
>> +#define TEGRA194_CLK_NVCSI			81
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVCSILP */
>> +#define TEGRA194_CLK_NVCSILP			82
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVDEC */
>> +#define TEGRA194_CLK_NVDEC			83
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAYHUB switch divider output */
>> +#define TEGRA194_CLK_NVDISPLAYHUB		84
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_DISP switch divider output */
>> +#define TEGRA194_CLK_NVDISPLAY_DISP		85
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_P0 switch divider output */
>> +#define TEGRA194_CLK_NVDISPLAY_P0		86
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_P1 switch divider output */
>> +#define TEGRA194_CLK_NVDISPLAY_P1		87
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_P2 switch divider output */
>> +#define TEGRA194_CLK_NVDISPLAY_P2		88
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVENC */
>> +#define TEGRA194_CLK_NVENC			89
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVJPG */
>> +#define TEGRA194_CLK_NVJPG			90
>> +/** @brief input from Tegra's XTAL_IN */
>> +#define TEGRA194_CLK_OSC			91
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_AON_TOUCH switch divider output */
>> +#define TEGRA194_CLK_AON_TOUCH			92
>> +/** PLL controlled by CLK_RST_CONTROLLER_PLLA_BASE for use by audio clocks */
>> +#define TEGRA194_CLK_PLLA			93
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLAON_BASE for use by IP blocks in the AON domain */
>> +#define TEGRA194_CLK_PLLAON			94
>> +/** @brief PLLD */
>> +#define TEGRA194_CLK_PLLD			95
>> +/** @brief PLLD2 */
>> +#define TEGRA194_CLK_PLLD2			96
>> +/** @brief PLLD3 */
>> +#define TEGRA194_CLK_PLLD3			97
>> +/** @brief PLLDP */
>> +#define TEGRA194_CLK_PLLDP			98
>> +/** @brief PLLD4 */
>> +#define TEGRA194_CLK_PLLD4			99
>> +/** Fixed 100MHz PLL for PCIe, SATA and superspeed USB */
>> +#define TEGRA194_CLK_PLLE			100
>> +/** @brief PLLP */
>> +#define TEGRA194_CLK_PLLP			101
>> +/** @brief PLLP VCO output */
>> +#define TEGRA194_CLK_PLLP_OUT0			102
>> +/** Fixed frequency 960MHz PLL for USB and EAVB */
>> +#define TEGRA194_CLK_UTMIPLL			103
>> +/** @brief output of the divider CLK_RST_CONTROLLER_PLLA_OUT */
>> +#define TEGRA194_CLK_PLLA_OUT0			104
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM1 */
>> +#define TEGRA194_CLK_PWM1			105
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM2 */
>> +#define TEGRA194_CLK_PWM2			106
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM3 */
>> +#define TEGRA194_CLK_PWM3			107
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM4 */
>> +#define TEGRA194_CLK_PWM4			108
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM5 */
>> +#define TEGRA194_CLK_PWM5			109
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM6 */
>> +#define TEGRA194_CLK_PWM6			110
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM7 */
>> +#define TEGRA194_CLK_PWM7			111
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_PWM8 */
>> +#define TEGRA194_CLK_PWM8			112
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_RCE_CPU_NIC output */
>> +#define TEGRA194_CLK_RCE_CPU_NIC		113
>> +/** @brief CLK_RST_CONTROLLER_RCE_NIC_RATE divider output */
>> +#define TEGRA194_CLK_RCE_NIC			114
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SATA */
>> +#define TEGRA194_CLK_SATA			115
>> +/** @brief output of gate CLK_ENB_SATA_OOB */
>> +#define TEGRA194_CLK_SATA_OOB			116
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_AON_I2C_SLOW switch divider output */
>> +#define TEGRA194_CLK_AON_I2C_SLOW		117
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SCE_CPU_NIC */
>> +#define TEGRA194_CLK_SCE_CPU_NIC		118
>> +/** @brief output of divider CLK_RST_CONTROLLER_SCE_NIC_RATE */
>> +#define TEGRA194_CLK_SCE_NIC			119
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC1 */
>> +#define TEGRA194_CLK_SDMMC1			120
>> +/** @brief Logical clk for setting the UPHY PLL3 rate */
>> +#define TEGRA194_CLK_UPHY_PLL3			121
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC3 */
>> +#define TEGRA194_CLK_SDMMC3			122
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC4 */
>> +#define TEGRA194_CLK_SDMMC4			123
>> +/** @brief gated version of SE_FREE clk */
>> +#define TEGRA194_CLK_SE				124
>> +/** @brief output of mux controlled by SOR0_CLK_SEL1 and SOR0_CLK_SEL0 */
>> +#define TEGRA194_CLK_SOR0_OUT			125
>> +/** @brief output of mux controlled by SOR0_CLK_SRC */
>> +#define TEGRA194_CLK_SOR0_REF			126
>> +/** @brief SOR0 brick output which feeds into SOR0_CLK_SEL0 mux */
>> +#define TEGRA194_CLK_SOR0_PAD_CLKOUT		127
>> +/** @brief output of mux controlled by SOR1_CLK_SEL1 and SOR1_CLK_SEL0 */
>> +#define TEGRA194_CLK_SOR1_OUT			128
>> +/** @brief output of mux controlled by SOR1_CLK_SRC */
>> +#define TEGRA194_CLK_SOR1_REF			129
>> +/** @brief SOR1 brick output which feeds into SOR1_CLK_SEL0 mux */
>> +#define TEGRA194_CLK_SOR1_PAD_CLKOUT		130
>> +/** @brief output of gate CLK_ENB_SOR_SAFE */
>> +#define TEGRA194_CLK_SOR_SAFE			131
>> +/** @brief Interface clock from IQC pad (1) */
>> +#define TEGRA194_CLK_IQC1_IN			132
>> +/** @brief Interface clock from IQC pad (2) */
>> +#define TEGRA194_CLK_IQC2_IN			133
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC5 */
>> +#define TEGRA194_CLK_DMIC5			134
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SPI1 */
>> +#define TEGRA194_CLK_SPI1			135
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SPI2 */
>> +#define TEGRA194_CLK_SPI2			136
>> +/**  @clkdesc{spi_clks, out, mux, CLK_RST_CONTROLLER_CLK_SOURCE_SPI3} */
>> +#define TEGRA194_CLK_SPI3			137
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C_SLOW */
>> +#define TEGRA194_CLK_I2C_SLOW			138
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC1 */
>> +#define TEGRA194_CLK_SYNC_DMIC1			139
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC2 */
>> +#define TEGRA194_CLK_SYNC_DMIC2			140
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC3 */
>> +#define TEGRA194_CLK_SYNC_DMIC3			141
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC4 */
>> +#define TEGRA194_CLK_SYNC_DMIC4			142
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DSPK1 */
>> +#define TEGRA194_CLK_SYNC_DSPK1			143
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DSPK2 */
>> +#define TEGRA194_CLK_SYNC_DSPK2			144
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S1 */
>> +#define TEGRA194_CLK_SYNC_I2S1			145
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S2 */
>> +#define TEGRA194_CLK_SYNC_I2S2			146
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S3 */
>> +#define TEGRA194_CLK_SYNC_I2S3			147
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S4 */
>> +#define TEGRA194_CLK_SYNC_I2S4			148
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S5 */
>> +#define TEGRA194_CLK_SYNC_I2S5			149
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S6 */
>> +#define TEGRA194_CLK_SYNC_I2S6			150
>> +/** @brief controls MPHY_FORCE_LS_MODE upon enable & disable */
>> +#define TEGRA194_CLK_MPHY_FORCE_LS_MODE		151
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_TACH */
>> +#define TEGRA194_CLK_TACH			152
>> +/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_TSEC */
>> +#define TEGRA194_CLK_TSEC			153
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_TSECB */
>> +#define TEGRA194_CLK_TSECB			154
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTA */
>> +#define TEGRA194_CLK_UARTA			155
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTB */
>> +#define TEGRA194_CLK_UARTB			156
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTC */
>> +#define TEGRA194_CLK_UARTC			157
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTD */
>> +#define TEGRA194_CLK_UARTD			158
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTE */
>> +#define TEGRA194_CLK_UARTE			159
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTF */
>> +#define TEGRA194_CLK_UARTF			160
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTG */
>> +#define TEGRA194_CLK_UARTG			161
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UART_FST_MIPI_CAL */
>> +#define TEGRA194_CLK_UART_FST_MIPI_CAL		162
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UFSDEV_REF */
>> +#define TEGRA194_CLK_UFSDEV_REF			163
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UFSHC_CG_SYS */
>> +#define TEGRA194_CLK_UFSHC			164
>> +/** @brief output of gate CLK_ENB_USB2_TRK */
>> +#define TEGRA194_CLK_USB2_TRK			165
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_VI */
>> +#define TEGRA194_CLK_VI				166
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_VIC */
>> +#define TEGRA194_CLK_VIC			167
>> +/** @brief pva0_axi */
>> +#define TEGRA194_CLK_PVA0_AXI			168
>> +/** @brief PVA0_vps0_clk */
>> +#define TEGRA194_CLK_PVA0_VPS0			169
>> +/** @brief PVA0_vps1_clk */
>> +#define TEGRA194_CLK_PVA0_VPS1			170
>> +/** @brief pva1_axi clk */
>> +#define TEGRA194_CLK_PVA1_AXI			171
>> +/** @brief PVA1_vps0_clk */
>> +#define TEGRA194_CLK_PVA1_VPS0			172
>> +/** @brief PVA1_vps1_clk */
>> +#define TEGRA194_CLK_PVA1_VPS1			173
>> +/** @brief DLA0_falcon_clk */
>> +#define TEGRA194_CLK_DLA0_FALCON		174
>> +/** @brief DLA0_core_clk */
>> +#define TEGRA194_CLK_DLA0_CORE			175
>> +/** @brief DLA1_falcon_clk */
>> +#define TEGRA194_CLK_DLA1_FALCON		176
>> +/** @brief DLA1_core_clk */
>> +#define TEGRA194_CLK_DLA1_CORE			177
>> +/** @brief output of mux controlled by SOR2_CLK_SEL1 and SOR2_CLK_SEL0 */
>> +#define TEGRA194_CLK_SOR2_OUT			178
>> +/** @brief output of mux controlled by SOR2_CLK_SRC */
>> +#define TEGRA194_CLK_SOR2_REF			179
>> +/** @brief SOR2 brick output which feeds into SOR2_CLK_SEL0 mux */
>> +#define TEGRA194_CLK_SOR2_PAD_CLKOUT		180
>> +/** @brief output of mux controlled by SOR3_CLK_SEL1 and SOR3_CLK_SEL0 */
>> +#define TEGRA194_CLK_SOR3_OUT			181
>> +/** @brief output of mux controlled by SOR3_CLK_SRC */
>> +#define TEGRA194_CLK_SOR3_REF			182
>> +/** @brief SOR3 brick output which feeds into SOR3_CLK_SEL0 mux */
>> +#define TEGRA194_CLK_SOR3_PAD_CLKOUT		183
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_P3 switch divider output */
>> +#define TEGRA194_CLK_NVDISPLAY_P3		184
>> +/** @brief output of gate CLK_ENB_DPAUX2 */
>> +#define TEGRA194_CLK_DPAUX2			185
>> +/** @brief output of gate CLK_ENB_DPAUX3 */
>> +#define TEGRA194_CLK_DPAUX3			186
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVDEC1 switch divider output */
>> +#define TEGRA194_CLK_NVDEC1			187
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_NVENC1 switch divider output */
>> +#define TEGRA194_CLK_NVENC1			188
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_SE switch divider output */
>> +#define TEGRA194_CLK_SE_FREE			189
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_UARTH switch divider output */
>> +#define TEGRA194_CLK_UARTH			190
>> +/** @brief ungated version of fuse clk */
>> +#define TEGRA194_CLK_FUSE_SERIAL		191
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_QSPI0 switch divider output */
>> +#define TEGRA194_CLK_QSPI0			192
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_QSPI1 switch divider output */
>> +#define TEGRA194_CLK_QSPI1			193
>> +/** @brief output of the divider QSPI_CLK_DIV2_SEL in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI0 */
>> +#define TEGRA194_CLK_QSPI0_PM			194
>> +/** @brief output of the divider QSPI_CLK_DIV2_SEL in CLK_RST_CONTROLLER_CLK_SOURCE_QSPI1 */
>> +#define TEGRA194_CLK_QSPI1_PM			195
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_VI_CONST switch divider output */
>> +#define TEGRA194_CLK_VI_CONST			196
>> +/** @brief NAFLL clock source for BPMP */
>> +#define TEGRA194_CLK_NAFLL_BPMP			197
>> +/** @brief NAFLL clock source for SCE */
>> +#define TEGRA194_CLK_NAFLL_SCE			198
>> +/** @brief NAFLL clock source for NVDEC */
>> +#define TEGRA194_CLK_NAFLL_NVDEC		199
>> +/** @brief NAFLL clock source for NVJPG */
>> +#define TEGRA194_CLK_NAFLL_NVJPG		200
>> +/** @brief NAFLL clock source for TSEC */
>> +#define TEGRA194_CLK_NAFLL_TSEC			201
>> +/** @brief NAFLL clock source for TSECB */
>> +#define TEGRA194_CLK_NAFLL_TSECB		202
>> +/** @brief NAFLL clock source for VI */
>> +#define TEGRA194_CLK_NAFLL_VI			203
>> +/** @brief NAFLL clock source for SE */
>> +#define TEGRA194_CLK_NAFLL_SE			204
>> +/** @brief NAFLL clock source for NVENC */
>> +#define TEGRA194_CLK_NAFLL_NVENC		205
>> +/** @brief NAFLL clock source for ISP */
>> +#define TEGRA194_CLK_NAFLL_ISP			206
>> +/** @brief NAFLL clock source for VIC */
>> +#define TEGRA194_CLK_NAFLL_VIC			207
>> +/** @brief NAFLL clock source for NVDISPLAYHUB */
>> +#define TEGRA194_CLK_NAFLL_NVDISPLAYHUB		208
>> +/** @brief NAFLL clock source for AXICBB */
>> +#define TEGRA194_CLK_NAFLL_AXICBB		209
>> +/** @brief NAFLL clock source for DLA */
>> +#define TEGRA194_CLK_NAFLL_DLA			210
>> +/** @brief NAFLL clock source for PVA_CORE */
>> +#define TEGRA194_CLK_NAFLL_PVA_CORE		211
>> +/** @brief NAFLL clock source for PVA_VPS */
>> +#define TEGRA194_CLK_NAFLL_PVA_VPS		212
>> +/** @brief NAFLL clock source for CVNAS */
>> +#define TEGRA194_CLK_NAFLL_CVNAS		213
>> +/** @brief NAFLL clock source for RCE */
>> +#define TEGRA194_CLK_NAFLL_RCE			214
>> +/** @brief NAFLL clock source for NVENC1 */
>> +#define TEGRA194_CLK_NAFLL_NVENC1		215
>> +/** @brief NAFLL clock source for DLA_FALCON */
>> +#define TEGRA194_CLK_NAFLL_DLA_FALCON		216
>> +/** @brief NAFLL clock source for NVDEC1 */
>> +#define TEGRA194_CLK_NAFLL_NVDEC1		217
>> +/** @brief NAFLL clock source for GPU */
>> +#define TEGRA194_CLK_NAFLL_GPU			218
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC_LEGACY_TM switch divider output */
>> +#define TEGRA194_CLK_SDMMC_LEGACY_TM		219
>> +/** @brief output of gate CLK_ENB_PEX0_CORE_0 */
>> +#define TEGRA194_CLK_PEX0_CORE_0		220
>> +/** @brief output of gate CLK_ENB_PEX0_CORE_1 */
>> +#define TEGRA194_CLK_PEX0_CORE_1		221
>> +/** @brief output of gate CLK_ENB_PEX0_CORE_2 */
>> +#define TEGRA194_CLK_PEX0_CORE_2		222
>> +/** @brief output of gate CLK_ENB_PEX0_CORE_3 */
>> +#define TEGRA194_CLK_PEX0_CORE_3		223
>> +/** @brief output of gate CLK_ENB_PEX0_CORE_4 */
>> +#define TEGRA194_CLK_PEX0_CORE_4		224
>> +/** @brief output of gate CLK_ENB_PEX1_CORE_5 */
>> +#define TEGRA194_CLK_PEX1_CORE_5		225
>> +/** @brief PCIE endpoint mode, HSIO UPHY PLL1 */
>> +#define TEGRA194_CLK_PEX_REF1			226
>> +/** @brief PCIE endpoint mode, HSIO UPHY PLL2 */
>> +#define TEGRA194_CLK_PEX_REF2			227
>> +/** @brief NVCSI_CIL clock for partition A */
>> +#define TEGRA194_CLK_CSI_A			229
>> +/** @brief NVCSI_CIL clock for partition B */
>> +#define TEGRA194_CLK_CSI_B			230
>> +/** @brief NVCSI_CIL clock for partition C */
>> +#define TEGRA194_CLK_CSI_C			231
>> +/** @brief NVCSI_CIL clock for partition D */
>> +#define TEGRA194_CLK_CSI_D			232
>> +/** @brief NVCSI_CIL clock for partition E */
>> +#define TEGRA194_CLK_CSI_E			233
>> +/** @brief NVCSI_CIL clock for partition F */
>> +#define TEGRA194_CLK_CSI_F			234
>> +/** @brief NVCSI_CIL clock for partition G */
>> +#define TEGRA194_CLK_CSI_G			235
>> +/** @brief NVCSI_CIL clock for partition H */
>> +#define TEGRA194_CLK_CSI_H			236
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC4_BASE */
>> +#define TEGRA194_CLK_PLLC4			237
>> +/** @brief output of gate CLK_ENB_PLLC4_OUT */
>> +#define TEGRA194_CLK_PLLC4_OUT			238
>> +/** @brief PLLC4 VCO followed by DIV3 path */
>> +#define TEGRA194_CLK_PLLC4_OUT1			239
>> +/** @brief PLLC4 VCO followed by DIV5 path */
>> +#define TEGRA194_CLK_PLLC4_OUT2			240
>> +/** @brief output of the mux controlled by PLLC4_CLK_SEL */
>> +#define TEGRA194_CLK_PLLC4_MUXED		241
>> +/** @brief PLLC4 VCO followed by DIV2 path */
>> +#define TEGRA194_CLK_PLLC4_VCO_DIV2		242
>> +/** @brief CSI pad brick input from partition A */
>> +#define TEGRA194_CLK_CSI_A_PAD			244
>> +/** @brief CSI pad brick input from partition B */
>> +#define TEGRA194_CLK_CSI_B_PAD			245
>> +/** @brief CSI pad brick input from partition C */
>> +#define TEGRA194_CLK_CSI_C_PAD			246
>> +/** @brief CSI pad brick input from partition D */
>> +#define TEGRA194_CLK_CSI_D_PAD			247
>> +/** @brief CSI pad brick input from partition E */
>> +#define TEGRA194_CLK_CSI_E_PAD			248
>> +/** @brief CSI pad brick input from partition F */
>> +#define TEGRA194_CLK_CSI_F_PAD			249
>> +/** @brief CSI pad brick input from partition G */
>> +#define TEGRA194_CLK_CSI_G_PAD			250
>> +/** @brief CSI pad brick input from partition H */
>> +#define TEGRA194_CLK_CSI_H_PAD			251
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PEX_SATA_USB_RX_BYP switch divider output */
>> +#define TEGRA194_CLK_PEX_SATA_USB_RX_BYP	254
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PEX_USB_PAD_PLL0_MGMT switch divider output */
>> +#define TEGRA194_CLK_PEX_USB_PAD_PLL0_MGMT	255
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PEX_USB_PAD_PLL1_MGMT switch divider output */
>> +#define TEGRA194_CLK_PEX_USB_PAD_PLL1_MGMT	256
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PEX_USB_PAD_PLL2_MGMT switch divider output */
>> +#define TEGRA194_CLK_PEX_USB_PAD_PLL2_MGMT	257
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PEX_USB_PAD_PLL3_MGMT switch divider output */
>> +#define TEGRA194_CLK_PEX_USB_PAD_PLL3_MGMT	258
>> +/** @brief xusb_core_dev_clk */
>> +#define TEGRA194_CLK_XUSB_CORE_DEV		265
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_XUSB_CORE_HOST switch divider output  */
>> +#define TEGRA194_CLK_XUSB_CORE_MUX		266
>> +/** @brief xusb_core_host_clk */
>> +#define TEGRA194_CLK_XUSB_CORE_HOST		267
>> +/** @brief xusb_core_superspeed_clk */
>> +#define TEGRA194_CLK_XUSB_CORE_SS		268
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_XUSB_FALCON switch divider output */
>> +#define TEGRA194_CLK_XUSB_FALCON		269
>> +/** @brief xusb_falcon_host_clk */
>> +#define TEGRA194_CLK_XUSB_FALCON_HOST		270
>> +/** @brief xusb_falcon_superspeed_clk */
>> +#define TEGRA194_CLK_XUSB_FALCON_SS		271
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_XUSB_FS switch divider output */
>> +#define TEGRA194_CLK_XUSB_FS			272
>> +/** @brief xusb_fs_host_clk */
>> +#define TEGRA194_CLK_XUSB_FS_HOST		273
>> +/** @brief xusb_fs_dev_clk */
>> +#define TEGRA194_CLK_XUSB_FS_DEV		274
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_XUSB_SS switch divider output */
>> +#define TEGRA194_CLK_XUSB_SS			275
>> +/** @brief xusb_ss_dev_clk */
>> +#define TEGRA194_CLK_XUSB_SS_DEV		276
>> +/** @brief xusb_ss_superspeed_clk */
>> +#define TEGRA194_CLK_XUSB_SS_SUPERSPEED		277
>> +/** @brief HPLL for display hub clock */
>> +#define TEGRA194_CLK_PLLDISPHUB			278
>> +/** @brief Output of divider controlled by CLK_RST_CONTROLLER_CLK_SOURCE_NVDISPLAY_DISP */
>> +#define TEGRA194_CLK_PLLDISPHUB_DIV		279
>> +/** @brief NAFLL clock source for CPU cluster 0 */
>> +#define TEGRA194_CLK_NAFLL_CLUSTER0		280
>> +/** @brief NAFLL clock source for CPU cluster 1 */
>> +#define TEGRA194_CLK_NAFLL_CLUSTER1		281
>> +/** @brief NAFLL clock source for CPU cluster 2 */
>> +#define TEGRA194_CLK_NAFLL_CLUSTER2		282
>> +/** @brief NAFLL clock source for CPU cluster 3 */
>> +#define TEGRA194_CLK_NAFLL_CLUSTER3		283
>> +/** @brief CLK_RST_CONTROLLER_CAN1_CORE_RATE divider output */
>> +#define TEGRA194_CLK_CAN1_CORE			284
>> +/** @brief CLK_RST_CONTROLLER_CAN2_CORE_RATE divider outputt */
>> +#define TEGRA194_CLK_CAN2_CORE			285
>> +/** @brief CLK_RST_CONTROLLER_PLLA1_OUT1 switch divider output */
>> +#define TEGRA194_CLK_PLLA1_OUT1			286
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLREFE_BASE */
>> +#define TEGRA194_CLK_PLLREFE_VCOOUT		288
>> +/** @brief 32K input clock provided by PMIC */
>> +#define TEGRA194_CLK_CLK_32K			289
>> +/** @brief Clock recovered from SPDIFIN input */
>> +#define TEGRA194_CLK_SPDIFIN_SYNC_INPUT		290
>> +/** @brief Fixed 48MHz clock divided down from utmipll */
>> +#define TEGRA194_CLK_UTMIPLL_CLKOUT48		291
>> +/** @brief Fixed 480MHz clock divided down from utmipll */
>> +#define TEGRA194_CLK_UTMIPLL_CLKOUT480		292
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_CVNAS switch divider output */
>> +#define TEGRA194_CLK_CVNAS			293
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLNVCSI_BASE  */
>> +#define TEGRA194_CLK_PLLNVCSI			294
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PVA0_CPU_AXI switch divider output */
>> +#define TEGRA194_CLK_PVA0_CPU_AXI		295
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PVA1_CPU_AXI switch divider output */
>> +#define TEGRA194_CLK_PVA1_CPU_AXI		296
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PVA0_VPS switch divider output */
>> +#define TEGRA194_CLK_PVA0_VPS			297
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_PVA1_VPS switch divider output */
>> +#define TEGRA194_CLK_PVA1_VPS			298
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_DLA0_FALCON switch divider output */
>> +#define TEGRA194_CLK_DLA0_FALCON_MUX		299
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_DLA1_FALCON switch divider output */
>> +#define TEGRA194_CLK_DLA1_FALCON_MUX		300
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_DLA0_CORE switch divider output */
>> +#define TEGRA194_CLK_DLA0_CORE_MUX		301
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_DLA1_CORE switch divider output */
>> +#define TEGRA194_CLK_DLA1_CORE_MUX		302
>> +/** @brief UTMI PLL HW power sequencer */
>> +#define TEGRA194_CLK_UTMIPLL_HPS		304
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C5 */
>> +#define TEGRA194_CLK_I2C5			305
>> +/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2C10 */
>> +#define TEGRA194_CLK_I2C10			306
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_BPMP_CPU_NIC switch divider output */
>> +#define TEGRA194_CLK_BPMP_CPU_NIC		307
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_BPMP_APB switch divider output */
>> +#define TEGRA194_CLK_BPMP_APB			308
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_TSC switch divider output */
>> +#define TEGRA194_CLK_TSC			309
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_EMC switch divider output */
>> +#define TEGRA194_CLK_EMCSA			310
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_EMCSB switch divider output */
>> +#define TEGRA194_CLK_EMCSB			311
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_EMCSC switch divider output */
>> +#define TEGRA194_CLK_EMCSC			312
>> +/** @brief CLK_RST_CONTROLLER_CLK_SOURCE_EMCSD switch divider output */
>> +#define TEGRA194_CLK_EMCSD			313
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC_BASE */
>> +#define TEGRA194_CLK_PLLC			314
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC2_BASE */
>> +#define TEGRA194_CLK_PLLC2			315
>> +/** @brief PLL controlled by CLK_RST_CONTROLLER_PLLC3_BASE */
>> +#define TEGRA194_CLK_PLLC3			316
>> +/** @brief CLK_RST_CONTROLLER_TSC_HS_SUPER_CLK_DIVIDER skip divider output */
>> +#define TEGRA194_CLK_TSC_REF			317
>> +/** @brief Dummy clock to ensure minimum SoC voltage for fuse burning */
>> +#define TEGRA194_CLK_FUSE_BURN			318
>> +/** @brief Monitored branch of PEX0_CORE_0 clock */
>> +#define TEGRA194_CLK_PEX0_CORE_0M		319
>> +/** @brief Monitored branch of PEX0_CORE_1 clock */
>> +#define TEGRA194_CLK_PEX0_CORE_1M		320
>> +/** @brief Monitored branch of PEX0_CORE_2 clock */
>> +#define TEGRA194_CLK_PEX0_CORE_2M		321
>> +/** @brief Monitored branch of PEX0_CORE_3 clock */
>> +#define TEGRA194_CLK_PEX0_CORE_3M		322
>> +/** @brief Monitored branch of PEX0_CORE_4 clock */
>> +#define TEGRA194_CLK_PEX0_CORE_4M		323
>> +/** @brief Monitored branch of PEX1_CORE_5 clock */
>> +#define TEGRA194_CLK_PEX1_CORE_5M		324
>> +/** @brief PLLE hardware power sequencer (overrides 'manual' programming of PLL) */
>> +#define TEGRA194_CLK_PLLE_HPS			326
>> +
>> +#endif
>> diff --git a/include/dt-bindings/gpio/tegra194-gpio.h b/include/dt-bindings/gpio/tegra194-gpio.h
>> new file mode 100644
>> index 000000000000..86435a73ef9e
>> --- /dev/null
>> +++ b/include/dt-bindings/gpio/tegra194-gpio.h
>> @@ -0,0 +1,59 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>
> No copyright?

Looks like we've had copyrights in some files and forgotten it in some 
files.. I'll try to harmonize this for Tegra194.

>
>> + * This header provides constants for binding nvidia,tegra194-gpio*.
>> + *
>> + * The first cell in Tegra's GPIO specifier is the GPIO ID. The macros below
>> + * provide names for this.
>> + *
>> + * The second cell contains standard flag values specified in gpio.h.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_GPIO_TEGRA194_GPIO_H
>> +#define _DT_BINDINGS_GPIO_TEGRA194_GPIO_H
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/* GPIOs implemented by main GPIO controller */
>> +#define TEGRA194_MAIN_GPIO_PORT_A 0
>> +#define TEGRA194_MAIN_GPIO_PORT_B 1
>> +#define TEGRA194_MAIN_GPIO_PORT_C 2
>> +#define TEGRA194_MAIN_GPIO_PORT_D 3
>> +#define TEGRA194_MAIN_GPIO_PORT_E 4
>> +#define TEGRA194_MAIN_GPIO_PORT_F 5
>> +#define TEGRA194_MAIN_GPIO_PORT_G 6
>> +#define TEGRA194_MAIN_GPIO_PORT_H 7
>> +#define TEGRA194_MAIN_GPIO_PORT_I 8
>> +#define TEGRA194_MAIN_GPIO_PORT_J 9
>> +#define TEGRA194_MAIN_GPIO_PORT_K 10
>> +#define TEGRA194_MAIN_GPIO_PORT_L 11
>> +#define TEGRA194_MAIN_GPIO_PORT_M 12
>> +#define TEGRA194_MAIN_GPIO_PORT_N 13
>> +#define TEGRA194_MAIN_GPIO_PORT_O 14
>> +#define TEGRA194_MAIN_GPIO_PORT_P 15
>> +#define TEGRA194_MAIN_GPIO_PORT_Q 16
>> +#define TEGRA194_MAIN_GPIO_PORT_R 17
>> +#define TEGRA194_MAIN_GPIO_PORT_S 18
>> +#define TEGRA194_MAIN_GPIO_PORT_T 19
>> +#define TEGRA194_MAIN_GPIO_PORT_U 20
>> +#define TEGRA194_MAIN_GPIO_PORT_V 21
>> +#define TEGRA194_MAIN_GPIO_PORT_W 22
>> +#define TEGRA194_MAIN_GPIO_PORT_X 23
>> +#define TEGRA194_MAIN_GPIO_PORT_Y 24
>> +#define TEGRA194_MAIN_GPIO_PORT_Z 25
>> +#define TEGRA194_MAIN_GPIO_PORT_FF 26
>> +#define TEGRA194_MAIN_GPIO_PORT_GG 27
>> +
>> +#define TEGRA194_MAIN_GPIO(port, offset) \
>> +	((TEGRA194_MAIN_GPIO_PORT_##port * 8) + offset)
>> +
>> +/* GPIOs implemented by AON GPIO controller */
>> +#define TEGRA194_AON_GPIO_PORT_AA 0
>> +#define TEGRA194_AON_GPIO_PORT_BB 1
>> +#define TEGRA194_AON_GPIO_PORT_CC 2
>> +#define TEGRA194_AON_GPIO_PORT_DD 3
>> +#define TEGRA194_AON_GPIO_PORT_EE 4
>> +
>> +#define TEGRA194_AON_GPIO(port, offset) \
>> +	((TEGRA194_AON_GPIO_PORT_##port * 8) + offset)
>> +
>> +#endif
>> diff --git a/include/dt-bindings/power/tegra194-powergate.h b/include/dt-bindings/power/tegra194-powergate.h
>> new file mode 100644
>> index 000000000000..f9f6a0e41858
>> --- /dev/null
>> +++ b/include/dt-bindings/power/tegra194-powergate.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION.  All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>
> Remove the boilerplate.

Sure.

Thanks,
Mikko

>
>> + */
>> +
>> +#ifndef __ABI_MACH_T194_POWERGATE_T194_H_
>> +#define __ABI_MACH_T194_POWERGATE_T194_H_
>> +
>> +#define TEGRA194_POWER_DOMAIN_AUD	1
>> +#define TEGRA194_POWER_DOMAIN_DISP	2
>> +#define TEGRA194_POWER_DOMAIN_DISPB	3
>> +#define TEGRA194_POWER_DOMAIN_DISPC	4
>> +#define TEGRA194_POWER_DOMAIN_ISPA	5
>> +#define TEGRA194_POWER_DOMAIN_NVDECA	6
>> +#define TEGRA194_POWER_DOMAIN_NVJPG	7
>> +#define TEGRA194_POWER_DOMAIN_NVENCA	8
>> +#define TEGRA194_POWER_DOMAIN_NVENCB	9
>> +#define TEGRA194_POWER_DOMAIN_NVDECB	10
>> +#define TEGRA194_POWER_DOMAIN_SAX	11
>> +#define TEGRA194_POWER_DOMAIN_VE	12
>> +#define TEGRA194_POWER_DOMAIN_VIC	13
>> +#define TEGRA194_POWER_DOMAIN_XUSBA	14
>> +#define TEGRA194_POWER_DOMAIN_XUSBB	15
>> +#define TEGRA194_POWER_DOMAIN_XUSBC	16
>> +#define TEGRA194_POWER_DOMAIN_PCIEX8A	17
>> +#define TEGRA194_POWER_DOMAIN_PCIEX4A	18
>> +#define TEGRA194_POWER_DOMAIN_PCIEX1A	19
>> +#define TEGRA194_POWER_DOMAIN_PCIEX8B	21
>> +#define TEGRA194_POWER_DOMAIN_PVAA	22
>> +#define TEGRA194_POWER_DOMAIN_PVAB	23
>> +#define TEGRA194_POWER_DOMAIN_DLAA	24
>> +#define TEGRA194_POWER_DOMAIN_DLAB	25
>> +#define TEGRA194_POWER_DOMAIN_CV	26
>> +#define TEGRA194_POWER_DOMAIN_GPU	27
>> +#define TEGRA194_POWER_DOMAIN_MAX	27
>> +
>> +#endif
>> diff --git a/include/dt-bindings/reset/tegra194-reset.h b/include/dt-bindings/reset/tegra194-reset.h
>> new file mode 100644
>> index 000000000000..469eb555a84c
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/tegra194-reset.h
>> @@ -0,0 +1,166 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2018, NVIDIA CORPORATION. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ABI_MACH_T194_RESET_H
>> +#define __ABI_MACH_T194_RESET_H
>> +
>> +#define TEGRA194_RESET_ACTMON			1
>> +#define TEGRA194_RESET_ADSP_ALL			2
>> +#define TEGRA194_RESET_AFI			3
>> +#define TEGRA194_RESET_CAN1			4
>> +#define TEGRA194_RESET_CAN2			5
>> +#define TEGRA194_RESET_DLA0			6
>> +#define TEGRA194_RESET_DLA1			7
>> +#define TEGRA194_RESET_DPAUX			8
>> +#define TEGRA194_RESET_DPAUX1			9
>> +#define TEGRA194_RESET_DPAUX2			10
>> +#define TEGRA194_RESET_DPAUX3			11
>> +#define TEGRA194_RESET_EQOS			17
>> +#define TEGRA194_RESET_GPCDMA			18
>> +#define TEGRA194_RESET_GPU			19
>> +#define TEGRA194_RESET_HDA			20
>> +#define TEGRA194_RESET_HDA2CODEC_2X		21
>> +#define TEGRA194_RESET_HDA2HDMICODEC		22
>> +#define TEGRA194_RESET_HOST1X			23
>> +#define TEGRA194_RESET_I2C1			24
>> +#define TEGRA194_RESET_I2C10			25
>> +#define TEGRA194_RESET_RSVD_26			26
>> +#define TEGRA194_RESET_RSVD_27			27
>> +#define TEGRA194_RESET_RSVD_28			28
>> +#define TEGRA194_RESET_I2C2			29
>> +#define TEGRA194_RESET_I2C3			30
>> +#define TEGRA194_RESET_I2C4			31
>> +#define TEGRA194_RESET_I2C6			32
>> +#define TEGRA194_RESET_I2C7			33
>> +#define TEGRA194_RESET_I2C8			34
>> +#define TEGRA194_RESET_I2C9			35
>> +#define TEGRA194_RESET_ISP			36
>> +#define TEGRA194_RESET_MIPI_CAL			37
>> +#define TEGRA194_RESET_MPHY_CLK_CTL		38
>> +#define TEGRA194_RESET_MPHY_L0_RX		39
>> +#define TEGRA194_RESET_MPHY_L0_TX		40
>> +#define TEGRA194_RESET_MPHY_L1_RX		41
>> +#define TEGRA194_RESET_MPHY_L1_TX		42
>> +#define TEGRA194_RESET_NVCSI			43
>> +#define TEGRA194_RESET_NVDEC			44
>> +#define TEGRA194_RESET_NVDISPLAY0_HEAD0		45
>> +#define TEGRA194_RESET_NVDISPLAY0_HEAD1		46
>> +#define TEGRA194_RESET_NVDISPLAY0_HEAD2		47
>> +#define TEGRA194_RESET_NVDISPLAY0_HEAD3		48
>> +#define TEGRA194_RESET_NVDISPLAY0_MISC		49
>> +#define TEGRA194_RESET_NVDISPLAY0_WGRP0		50
>> +#define TEGRA194_RESET_NVDISPLAY0_WGRP1		51
>> +#define TEGRA194_RESET_NVDISPLAY0_WGRP2		52
>> +#define TEGRA194_RESET_NVDISPLAY0_WGRP3		53
>> +#define TEGRA194_RESET_NVDISPLAY0_WGRP4		54
>> +#define TEGRA194_RESET_NVDISPLAY0_WGRP5		55
>> +#define TEGRA194_RESET_RSVD_56			56
>> +#define TEGRA194_RESET_RSVD_57			57
>> +#define TEGRA194_RESET_RSVD_58			58
>> +#define TEGRA194_RESET_NVENC			59
>> +#define TEGRA194_RESET_NVENC1			60
>> +#define TEGRA194_RESET_NVJPG			61
>> +#define TEGRA194_RESET_PCIE			62
>> +#define TEGRA194_RESET_PCIEXCLK			63
>> +#define TEGRA194_RESET_RSVD_64			64
>> +#define TEGRA194_RESET_RSVD_65			65
>> +#define TEGRA194_RESET_PVA0_ALL			66
>> +#define TEGRA194_RESET_PVA1_ALL			67
>> +#define TEGRA194_RESET_PWM1			68
>> +#define TEGRA194_RESET_PWM2			69
>> +#define TEGRA194_RESET_PWM3			70
>> +#define TEGRA194_RESET_PWM4			71
>> +#define TEGRA194_RESET_PWM5			72
>> +#define TEGRA194_RESET_PWM6			73
>> +#define TEGRA194_RESET_PWM7			74
>> +#define TEGRA194_RESET_PWM8			75
>> +#define TEGRA194_RESET_QSPI0			76
>> +#define TEGRA194_RESET_QSPI1			77
>> +#define TEGRA194_RESET_SATA			78
>> +#define TEGRA194_RESET_SATACOLD			79
>> +#define TEGRA194_RESET_SCE_ALL			80
>> +#define TEGRA194_RESET_RCE_ALL			81
>> +#define TEGRA194_RESET_SDMMC1			82
>> +#define TEGRA194_RESET_RSVD_83			83
>> +#define TEGRA194_RESET_SDMMC3			84
>> +#define TEGRA194_RESET_SDMMC4			85
>> +#define TEGRA194_RESET_SE			86
>> +#define TEGRA194_RESET_SOR0			87
>> +#define TEGRA194_RESET_SOR1			88
>> +#define TEGRA194_RESET_SOR2			89
>> +#define TEGRA194_RESET_SOR3			90
>> +#define TEGRA194_RESET_SPI1			91
>> +#define TEGRA194_RESET_SPI2			92
>> +#define TEGRA194_RESET_SPI3			93
>> +#define TEGRA194_RESET_SPI4			94
>> +#define TEGRA194_RESET_TACH			95
>> +#define TEGRA194_RESET_RSVD_96			96
>> +#define TEGRA194_RESET_TSCTNVI			97
>> +#define TEGRA194_RESET_TSEC			98
>> +#define TEGRA194_RESET_TSECB			99
>> +#define TEGRA194_RESET_UARTA			100
>> +#define TEGRA194_RESET_UARTB			101
>> +#define TEGRA194_RESET_UARTC			102
>> +#define TEGRA194_RESET_UARTD			103
>> +#define TEGRA194_RESET_UARTE			104
>> +#define TEGRA194_RESET_UARTF			105
>> +#define TEGRA194_RESET_UARTG			106
>> +#define TEGRA194_RESET_UARTH			107
>> +#define TEGRA194_RESET_UFSHC			108
>> +#define TEGRA194_RESET_UFSHC_AXI_M		109
>> +#define TEGRA194_RESET_UFSHC_LP_SEQ		110
>> +#define TEGRA194_RESET_RSVD_111			111
>> +#define TEGRA194_RESET_VI			112
>> +#define TEGRA194_RESET_VIC			113
>> +#define TEGRA194_RESET_XUSB_PADCTL		114
>> +#define TEGRA194_RESET_NVDEC1			115
>> +#define TEGRA194_RESET_PEX0_CORE_0		116
>> +#define TEGRA194_RESET_PEX0_CORE_1		117
>> +#define TEGRA194_RESET_PEX0_CORE_2		118
>> +#define TEGRA194_RESET_PEX0_CORE_3		119
>> +#define TEGRA194_RESET_PEX0_CORE_4		120
>> +#define TEGRA194_RESET_PEX0_CORE_0_APB		121
>> +#define TEGRA194_RESET_PEX0_CORE_1_APB		122
>> +#define TEGRA194_RESET_PEX0_CORE_2_APB		123
>> +#define TEGRA194_RESET_PEX0_CORE_3_APB		124
>> +#define TEGRA194_RESET_PEX0_CORE_4_APB		125
>> +#define TEGRA194_RESET_PEX0_COMMON_APB		126
>> +#define TEGRA194_RESET_PEX1_CORE_5		129
>> +#define TEGRA194_RESET_PEX1_CORE_5_APB		130
>> +#define TEGRA194_RESET_CVNAS			131
>> +#define TEGRA194_RESET_CVNAS_FCM		132
>> +#define TEGRA194_RESET_DMIC5			144
>> +#define TEGRA194_RESET_APE			145
>> +#define TEGRA194_RESET_PEX_USB_UPHY		146
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L0		147
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L1		148
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L2		149
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L3		150
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L4		151
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L5		152
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L6		153
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L7		154
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L8		155
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L9		156
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L10		157
>> +#define TEGRA194_RESET_PEX_USB_UPHY_L11		158
>> +#define TEGRA194_RESET_PEX_USB_UPHY_PLL0	159
>> +#define TEGRA194_RESET_PEX_USB_UPHY_PLL1	160
>> +#define TEGRA194_RESET_PEX_USB_UPHY_PLL2	161
>> +#define TEGRA194_RESET_PEX_USB_UPHY_PLL3	162
>> +
>> +#endif
>> --
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

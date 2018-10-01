Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64511C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CB52089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCCsZjcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CB52089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbeJAX5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbeJAX5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:57:50 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEAF32089A;
        Mon,  1 Oct 2018 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538414341;
        bh=weplQd4eQWV0tVdR1LeFu7NuGvTw7P23/r5acXBQuXY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=rCCsZjcVckX/D03ICTN0ATmMa4moksIFIQfidsUVAQgDI+m7MfNIldvAtOmKtwo5x
         Ff1Z6neKrpt2yk0uTP/aG4F3FXFcATXlpgRiAdICAorYtDbHFG3cA/KhQqiPHra5zo
         Y6jDDkElV7Yqk0xp/ee3XVgXZ8b+Mn/X2W6szW80=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180921185936.9590-2-vkoul@kernel.org>
Cc:     Shefali Jain <shefjain@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
References: <20180921185936.9590-1-vkoul@kernel.org>
 <20180921185936.9590-2-vkoul@kernel.org>
Message-ID: <153841434099.119890.3912925112860077471@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add global clock controller driver for QCS404
Date:   Mon, 01 Oct 2018 10:19:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2018-09-21 11:59:36)
> From: Shefali Jain <shefjain@codeaurora.org>
> =

> Add the clocks supported in global clock controller which clock the
> peripherals like BLSPs, SDCC, USB, MDSS etc. Register all the clocks
> to the clock framework for the clients to be able to request for them.
> =

> Signed-off-by: Shefali Jain <shefjain@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Co-developed-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
> [rebase and tidyup for upstream]

Who did the tidying?

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  - reg : shall contain base register location and length
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 064768699fe7..529d84cc7503 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -235,6 +235,14 @@ config MSM_GCC_8998
>           Say Y if you want to use peripheral devices such as UART, SPI,
>           i2c, USB, UFS, SD/eMMC, PCIe, etc.
>  =

> +config QCS_GCC_404
> +       tristate "QCS404 Global Clock Controller"
> +       depends on COMMON_CLK_QCOM
> +       help
> +        Support for the global clock controller on QCS404 devices.
> +        Say Y if you want to use peripheral devices such as UART, SPI, I=
2C,
> +        USB, SD/eMMC, PCIe, etc.

It seems to include multimedia display clks and ethernet? Maybe include
those too.

> +
>  config SDM_GCC_845
>         tristate "SDM845 Global Clock Controller"
>         select QCOM_GDSC
> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> new file mode 100644
> index 000000000000..6d1387ef798b
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -0,0 +1,2729 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/clk.h>

Please don't include this.

> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "reset.h"
[...]
> +
> +/* 930MHz configuration */
> +static const struct alpha_pll_config gpll3_config =3D {
> +       .l =3D 48,
> +       .alpha =3D 0x0,
> +       .alpha_en_mask =3D BIT(24),
> +       .post_div_mask =3D 0xf << 8,
> +       .post_div_val =3D 0x1 << 8,
> +       .vco_mask =3D 0x3 << 20,
> +       .main_output_mask =3D 0x1,
> +       .config_ctl_val =3D 0x4001055b,
> +};
> +
> +static struct pll_vco gpll3_vco[] =3D {

const?

> +       { 700000000, 1400000000, 0 },
> +};
> +
> +static struct clk_alpha_pll gpll3_out_main =3D {
> +       .offset =3D 0x22000,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> +       .vco_table =3D gpll3_vco,
> +       .num_vco =3D ARRAY_SIZE(gpll3_vco),
> +       .clkr =3D {
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gpll3_out_main",
> +                       .parent_names =3D (const char *[]){ "cxo" },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_ops,
> +               },
> +       },
> +};
> +
[...]
> +
> +static struct clk_branch gcc_pwm1_xo512_clk =3D {
> +       .halt_reg =3D 0x49004,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x49004,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_pwm1_xo512_clk",
> +                       .ops =3D &clk_branch2_ops,

Do these pwm clks have a parent clk of the XO?

> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_pwm2_xo512_clk =3D {
> +       .halt_reg =3D 0x4a004,
> +       .halt_check =3D BRANCH_HALT,
> +       .clkr =3D {
> +               .enable_reg =3D 0x4a004,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_pwm2_xo512_clk",
> +                       .ops =3D &clk_branch2_ops,
> +               },
> +       },
> +};
> +
> +static struct clk_branch gcc_qdss_dap_clk =3D {
[...]
> +
> +static struct clk_regmap *gcc_qcs404_clocks[] =3D {
> +       [APSS_AHB_CLK_SRC] =3D &apss_ahb_clk_src.clkr,
> +       [BLSP1_QUP0_I2C_APPS_CLK_SRC] =3D &blsp1_qup0_i2c_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP0_SPI_APPS_CLK_SRC] =3D &blsp1_qup0_spi_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP1_I2C_APPS_CLK_SRC] =3D &blsp1_qup1_i2c_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP1_SPI_APPS_CLK_SRC] =3D &blsp1_qup1_spi_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP2_I2C_APPS_CLK_SRC] =3D &blsp1_qup2_i2c_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP2_SPI_APPS_CLK_SRC] =3D &blsp1_qup2_spi_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP3_I2C_APPS_CLK_SRC] =3D &blsp1_qup3_i2c_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP3_SPI_APPS_CLK_SRC] =3D &blsp1_qup3_spi_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP4_I2C_APPS_CLK_SRC] =3D &blsp1_qup4_i2c_apps_clk_src.cl=
kr,
> +       [BLSP1_QUP4_SPI_APPS_CLK_SRC] =3D &blsp1_qup4_spi_apps_clk_src.cl=
kr,
> +       [BLSP1_UART0_APPS_CLK_SRC] =3D &blsp1_uart0_apps_clk_src.clkr,
> +       [BLSP1_UART1_APPS_CLK_SRC] =3D &blsp1_uart1_apps_clk_src.clkr,
> +       [BLSP1_UART2_APPS_CLK_SRC] =3D &blsp1_uart2_apps_clk_src.clkr,
> +       [BLSP1_UART3_APPS_CLK_SRC] =3D &blsp1_uart3_apps_clk_src.clkr,
> +       [BLSP2_QUP0_I2C_APPS_CLK_SRC] =3D &blsp2_qup0_i2c_apps_clk_src.cl=
kr,
> +       [BLSP2_QUP0_SPI_APPS_CLK_SRC] =3D &blsp2_qup0_spi_apps_clk_src.cl=
kr,
> +       [BLSP2_UART0_APPS_CLK_SRC] =3D &blsp2_uart0_apps_clk_src.clkr,
> +       [BYTE0_CLK_SRC] =3D &byte0_clk_src.clkr,
> +       [EMAC_CLK_SRC] =3D &emac_clk_src.clkr,
> +       [EMAC_PTP_CLK_SRC] =3D &emac_ptp_clk_src.clkr,
> +       [ESC0_CLK_SRC] =3D &esc0_clk_src.clkr,
> +       [GCC_APSS_AHB_CLK] =3D &gcc_apss_ahb_clk.clkr,
> +       [GCC_BIMC_GFX_CLK] =3D &gcc_bimc_gfx_clk.clkr,
> +       [GCC_BIMC_MDSS_CLK] =3D &gcc_bimc_mdss_clk.clkr,
> +       [GCC_BLSP1_AHB_CLK] =3D &gcc_blsp1_ahb_clk.clkr,
> +       [GCC_BLSP1_QUP0_I2C_APPS_CLK] =3D &gcc_blsp1_qup0_i2c_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP0_SPI_APPS_CLK] =3D &gcc_blsp1_qup0_spi_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP1_I2C_APPS_CLK] =3D &gcc_blsp1_qup1_i2c_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP1_SPI_APPS_CLK] =3D &gcc_blsp1_qup1_spi_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP2_I2C_APPS_CLK] =3D &gcc_blsp1_qup2_i2c_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP2_SPI_APPS_CLK] =3D &gcc_blsp1_qup2_spi_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP3_I2C_APPS_CLK] =3D &gcc_blsp1_qup3_i2c_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP3_SPI_APPS_CLK] =3D &gcc_blsp1_qup3_spi_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP4_I2C_APPS_CLK] =3D &gcc_blsp1_qup4_i2c_apps_clk.cl=
kr,
> +       [GCC_BLSP1_QUP4_SPI_APPS_CLK] =3D &gcc_blsp1_qup4_spi_apps_clk.cl=
kr,
> +       [GCC_BLSP1_UART0_APPS_CLK] =3D &gcc_blsp1_uart0_apps_clk.clkr,
> +       [GCC_BLSP1_UART1_APPS_CLK] =3D &gcc_blsp1_uart1_apps_clk.clkr,
> +       [GCC_BLSP1_UART2_APPS_CLK] =3D &gcc_blsp1_uart2_apps_clk.clkr,
> +       [GCC_BLSP1_UART3_APPS_CLK] =3D &gcc_blsp1_uart3_apps_clk.clkr,
> +       [GCC_BLSP2_AHB_CLK] =3D &gcc_blsp2_ahb_clk.clkr,
> +       [GCC_BLSP2_QUP0_I2C_APPS_CLK] =3D &gcc_blsp2_qup0_i2c_apps_clk.cl=
kr,
> +       [GCC_BLSP2_QUP0_SPI_APPS_CLK] =3D &gcc_blsp2_qup0_spi_apps_clk.cl=
kr,
> +       [GCC_BLSP2_UART0_APPS_CLK] =3D &gcc_blsp2_uart0_apps_clk.clkr,
> +       [GCC_BOOT_ROM_AHB_CLK] =3D &gcc_boot_rom_ahb_clk.clkr,
> +       [GCC_ETH_AXI_CLK] =3D &gcc_eth_axi_clk.clkr,
> +       [GCC_ETH_PTP_CLK] =3D &gcc_eth_ptp_clk.clkr,
> +       [GCC_ETH_RGMII_CLK] =3D &gcc_eth_rgmii_clk.clkr,
> +       [GCC_ETH_SLAVE_AHB_CLK] =3D &gcc_eth_slave_ahb_clk.clkr,
> +       [GCC_GENI_IR_S_CLK] =3D &gcc_geni_ir_s_clk.clkr,
> +       [GCC_GENI_IR_H_CLK] =3D &gcc_geni_ir_h_clk.clkr,
> +       [GCC_GP1_CLK] =3D &gcc_gp1_clk.clkr,
> +       [GCC_GP2_CLK] =3D &gcc_gp2_clk.clkr,
> +       [GCC_GP3_CLK] =3D &gcc_gp3_clk.clkr,
> +       [GCC_MDSS_AHB_CLK] =3D &gcc_mdss_ahb_clk.clkr,
> +       [GCC_MDSS_AXI_CLK] =3D &gcc_mdss_axi_clk.clkr,
> +       [GCC_MDSS_BYTE0_CLK] =3D &gcc_mdss_byte0_clk.clkr,
> +       [GCC_MDSS_ESC0_CLK] =3D &gcc_mdss_esc0_clk.clkr,
> +       [GCC_MDSS_HDMI_APP_CLK] =3D &gcc_mdss_hdmi_app_clk.clkr,
> +       [GCC_MDSS_HDMI_PCLK_CLK] =3D &gcc_mdss_hdmi_pclk_clk.clkr,
> +       [GCC_MDSS_MDP_CLK] =3D &gcc_mdss_mdp_clk.clkr,
> +       [GCC_MDSS_PCLK0_CLK] =3D &gcc_mdss_pclk0_clk.clkr,
> +       [GCC_MDSS_VSYNC_CLK] =3D &gcc_mdss_vsync_clk.clkr,
> +       [GCC_OXILI_AHB_CLK] =3D &gcc_oxili_ahb_clk.clkr,
> +       [GCC_OXILI_GFX3D_CLK] =3D &gcc_oxili_gfx3d_clk.clkr,
> +       [GCC_PCIE_0_AUX_CLK] =3D &gcc_pcie_0_aux_clk.clkr,
> +       [GCC_PCIE_0_CFG_AHB_CLK] =3D &gcc_pcie_0_cfg_ahb_clk.clkr,
> +       [GCC_PCIE_0_MSTR_AXI_CLK] =3D &gcc_pcie_0_mstr_axi_clk.clkr,
> +       [GCC_PCIE_0_PIPE_CLK] =3D &gcc_pcie_0_pipe_clk.clkr,
> +       [GCC_PCIE_0_SLV_AXI_CLK] =3D &gcc_pcie_0_slv_axi_clk.clkr,
> +       [GCC_PCNOC_USB2_CLK] =3D &gcc_pcnoc_usb2_clk.clkr,
> +       [GCC_PCNOC_USB3_CLK] =3D &gcc_pcnoc_usb3_clk.clkr,
> +       [GCC_PDM2_CLK] =3D &gcc_pdm2_clk.clkr,
> +       [GCC_PDM_AHB_CLK] =3D &gcc_pdm_ahb_clk.clkr,
> +       [GCC_PRNG_AHB_CLK] =3D &gcc_prng_ahb_clk.clkr,
> +       [GCC_PWM0_XO512_CLK] =3D &gcc_pwm0_xo512_clk.clkr,
> +       [GCC_PWM1_XO512_CLK] =3D &gcc_pwm1_xo512_clk.clkr,
> +       [GCC_PWM2_XO512_CLK] =3D &gcc_pwm2_xo512_clk.clkr,
> +       [GCC_SDCC1_AHB_CLK] =3D &gcc_sdcc1_ahb_clk.clkr,
> +       [GCC_SDCC1_APPS_CLK] =3D &gcc_sdcc1_apps_clk.clkr,
> +       [GCC_SDCC1_ICE_CORE_CLK] =3D &gcc_sdcc1_ice_core_clk.clkr,
> +       [GCC_SDCC2_AHB_CLK] =3D &gcc_sdcc2_ahb_clk.clkr,
> +       [GCC_SDCC2_APPS_CLK] =3D &gcc_sdcc2_apps_clk.clkr,
> +       [GCC_SYS_NOC_USB3_CLK] =3D &gcc_sys_noc_usb3_clk.clkr,
> +       [GCC_USB20_MOCK_UTMI_CLK] =3D &gcc_usb20_mock_utmi_clk.clkr,
> +       [GCC_USB2A_PHY_SLEEP_CLK] =3D &gcc_usb2a_phy_sleep_clk.clkr,
> +       [GCC_USB30_MASTER_CLK] =3D &gcc_usb30_master_clk.clkr,
> +       [GCC_USB30_MOCK_UTMI_CLK] =3D &gcc_usb30_mock_utmi_clk.clkr,
> +       [GCC_USB30_SLEEP_CLK] =3D &gcc_usb30_sleep_clk.clkr,
> +       [GCC_USB3_PHY_AUX_CLK] =3D &gcc_usb3_phy_aux_clk.clkr,
> +       [GCC_USB3_PHY_PIPE_CLK] =3D &gcc_usb3_phy_pipe_clk.clkr,
> +       [GCC_USB_HS_PHY_CFG_AHB_CLK] =3D &gcc_usb_hs_phy_cfg_ahb_clk.clkr,
> +       [GCC_USB_HS_SYSTEM_CLK] =3D &gcc_usb_hs_system_clk.clkr,
> +       [GFX3D_CLK_SRC] =3D &gfx3d_clk_src.clkr,
> +       [GP1_CLK_SRC] =3D &gp1_clk_src.clkr,

Why are some of these missing GCC_ prefix?

> +       [GP2_CLK_SRC] =3D &gp2_clk_src.clkr,
> +       [GP3_CLK_SRC] =3D &gp3_clk_src.clkr,
> +       [GPLL0_OUT_MAIN] =3D &gpll0_out_main.clkr,
> +       [GPLL0_AO_OUT_MAIN] =3D &gpll0_ao_out_main.clkr,
> +       [GPLL0_SLEEP_CLK_SRC] =3D &gpll0_sleep_clk_src.clkr,
> +       [GPLL1_OUT_MAIN] =3D &gpll1_out_main.clkr,
> +       [GPLL3_OUT_MAIN] =3D &gpll3_out_main.clkr,
> +       [GPLL4_OUT_MAIN] =3D &gpll4_out_main.clkr,
> +       [GPLL6] =3D &gpll6.clkr,
> +       [GPLL6_OUT_AUX] =3D &gpll6_out_aux,
> +       [HDMI_APP_CLK_SRC] =3D &hdmi_app_clk_src.clkr,
> +       [HDMI_PCLK_CLK_SRC] =3D &hdmi_pclk_clk_src.clkr,
> +       [MDP_CLK_SRC] =3D &mdp_clk_src.clkr,
> +       [PCIE_0_AUX_CLK_SRC] =3D &pcie_0_aux_clk_src.clkr,
> +       [PCIE_0_PIPE_CLK_SRC] =3D &pcie_0_pipe_clk_src.clkr,
> +       [PCLK0_CLK_SRC] =3D &pclk0_clk_src.clkr,
> +       [PDM2_CLK_SRC] =3D &pdm2_clk_src.clkr,
> +       [SDCC1_APPS_CLK_SRC] =3D &sdcc1_apps_clk_src.clkr,
> +       [SDCC1_ICE_CORE_CLK_SRC] =3D &sdcc1_ice_core_clk_src.clkr,
> +       [SDCC2_APPS_CLK_SRC] =3D &sdcc2_apps_clk_src.clkr,
> +       [USB20_MOCK_UTMI_CLK_SRC] =3D &usb20_mock_utmi_clk_src.clkr,
> +       [USB30_MASTER_CLK_SRC] =3D &usb30_master_clk_src.clkr,
> +       [USB30_MOCK_UTMI_CLK_SRC] =3D &usb30_mock_utmi_clk_src.clkr,
> +       [USB3_PHY_AUX_CLK_SRC] =3D &usb3_phy_aux_clk_src.clkr,
> +       [USB_HS_SYSTEM_CLK_SRC] =3D &usb_hs_system_clk_src.clkr,
> +       [VSYNC_CLK_SRC] =3D &vsync_clk_src.clkr,
> +       [GCC_USB_HS_INACTIVITY_TIMERS_CLK] =3D
> +                       &gcc_usb_hs_inactivity_timers_clk.clkr,
> +       [GCC_BIMC_GPU_CLK] =3D &gcc_bimc_gpu_clk.clkr,
> +       [GCC_GTCU_AHB_CLK] =3D &gcc_gtcu_ahb_clk.clkr,
> +       [GCC_GFX_TCU_CLK] =3D &gcc_gfx_tcu_clk.clkr,
> +       [GCC_GFX_TBU_CLK] =3D &gcc_gfx_tbu_clk.clkr,
> +       [GCC_SMMU_CFG_CLK] =3D &gcc_smmu_cfg_clk.clkr,
> +       [GCC_APSS_TCU_CLK] =3D &gcc_apss_tcu_clk.clkr,
> +       [GCC_CRYPTO_AHB_CLK] =3D &gcc_crypto_ahb_clk.clkr,
> +       [GCC_CRYPTO_AXI_CLK] =3D &gcc_crypto_axi_clk.clkr,
> +       [GCC_CRYPTO_CLK] =3D &gcc_crypto_clk.clkr,
> +       [GCC_MDP_TBU_CLK] =3D &gcc_mdp_tbu_clk.clkr,
> +       [GCC_QDSS_DAP_CLK] =3D &gcc_qdss_dap_clk.clkr,
> +       [GCC_DCC_CLK] =3D &gcc_dcc_clk.clkr,
> +       [GCC_DCC_XO_CLK] =3D &gcc_dcc_xo_clk.clkr,
> +};
> +
> +static const struct qcom_reset_map gcc_qcs404_resets[] =3D {
> +       [GCC_GENI_IR_BCR] =3D {0x0F000},
> +       [GCC_USB_HS_BCR] =3D {0x41000},
> +       [GCC_USB2_HS_PHY_ONLY_BCR] =3D {0x41034},
> +       [GCC_QUSB2_PHY_BCR] =3D {0x4103C},
> +       [GCC_USB_HS_PHY_CFG_AHB_BCR] =3D {0x0000C, 1},
> +       [GCC_USB2A_PHY_BCR] =3D {0x0000C, 0},
> +       [GCC_USB3_PHY_BCR] =3D {0x39004},
> +       [GCC_USB_30_BCR] =3D {0x39000},
> +       [GCC_USB3PHY_PHY_BCR] =3D {0x39008},
> +       [GCC_PCIE_0_BCR] =3D {0x3E000},
> +       [GCC_PCIE_0_PHY_BCR] =3D {0x3E004},
> +       [GCC_PCIE_0_LINK_DOWN_BCR] =3D {0x3E038},
> +       [GCC_PCIEPHY_0_PHY_BCR] =3D {0x3E03C},
> +       [GCC_EMAC_BCR] =3D {0x4E000},
> +};
> +
> +static const struct regmap_config gcc_qcs404_regmap_config =3D {
> +       .reg_bits       =3D 32,
> +       .reg_stride     =3D 4,
> +       .val_bits       =3D 32,
> +       .max_register   =3D 0x7f000,
> +       .fast_io        =3D true,
> +};
> +
> +static const struct qcom_cc_desc gcc_qcs404_desc =3D {
> +       .config =3D &gcc_qcs404_regmap_config,
> +       .clks =3D gcc_qcs404_clocks,
> +       .num_clks =3D ARRAY_SIZE(gcc_qcs404_clocks),
> +       .resets =3D gcc_qcs404_resets,
> +       .num_resets =3D ARRAY_SIZE(gcc_qcs404_resets),
> +};
> +
> +static const struct of_device_id gcc_qcs404_match_table[] =3D {
> +       { .compatible =3D "qcom,gcc-qcs404" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, gcc_qcs404_match_table);
> +
> +static int gcc_qcs404_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       int ret;
> +
> +       ret =3D qcom_cc_register_board_clk(&pdev->dev,
> +                                        "xo_board", "cxo", 19200000);

You shouldn't need to do this. This function is for transitioning DT
that doesn't have the board clk in DT to something the driver wants to
use, in this case "cxo". So you can either register a fixed factor 1/1
clk to do the translation between board and cxo names, or use xo_board
as the parent of things that can take crystal.

> +       if (ret)
> +               return ret;
> +
> +       regmap =3D qcom_cc_map(pdev, &gcc_qcs404_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_alpha_pll_configure(&gpll3_out_main, regmap, &gpll3_config);
> +       clk_set_rate(apss_ahb_clk_src.clkr.hw.clk, 19200000);

use assigned clock rates from DT please.

> +       clk_prepare_enable(apss_ahb_clk_src.clkr.hw.clk);
> +       clk_prepare_enable(gpll0_ao_out_main.clkr.hw.clk);

And these should be marked as critical clocks.

> +
> +       return qcom_cc_really_probe(pdev, &gcc_qcs404_desc, regmap);
> +}
> +
> +static struct platform_driver gcc_qcs404_driver =3D {
> +       .probe =3D gcc_qcs404_probe,
> +       .driver =3D {
> +               .name =3D "gcc-qcs404",
> +               .of_match_table =3D gcc_qcs404_match_table,
> +       },
> +};
> +
> +static int __init gcc_qcs404_init(void)
> +{
> +       return platform_driver_register(&gcc_qcs404_driver);
> +}
> +subsys_initcall(gcc_qcs404_init);
> +
> +static void __exit gcc_qcs404_exit(void)
> +{
> +       platform_driver_unregister(&gcc_qcs404_driver);
> +}
> +module_exit(gcc_qcs404_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm GCC QCS404 Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/dt-bindings/clock/qcom,gcc-qcs404.h b/include/dt-bin=
dings/clock/qcom,gcc-qcs404.h
> new file mode 100644
> index 000000000000..e2def29e31b3
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gcc-qcs404.h
> @@ -0,0 +1,166 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_QCS404_H
> +#define _DT_BINDINGS_CLK_QCOM_GCC_QCS404_H
> +
> +#define APSS_AHB_CLK_SRC                               0
> +#define BLSP1_QUP0_I2C_APPS_CLK_SRC                    1
> +#define BLSP1_QUP0_SPI_APPS_CLK_SRC                    2
> +#define BLSP1_QUP1_I2C_APPS_CLK_SRC                    3
> +#define BLSP1_QUP1_SPI_APPS_CLK_SRC                    4
> +#define BLSP1_QUP2_I2C_APPS_CLK_SRC                    5
> +#define BLSP1_QUP2_SPI_APPS_CLK_SRC                    6
> +#define BLSP1_QUP3_I2C_APPS_CLK_SRC                    7
> +#define BLSP1_QUP3_SPI_APPS_CLK_SRC                    8
> +#define BLSP1_QUP4_I2C_APPS_CLK_SRC                    9
> +#define BLSP1_QUP4_SPI_APPS_CLK_SRC                    10
> +#define BLSP1_UART0_APPS_CLK_SRC                       11
> +#define BLSP1_UART1_APPS_CLK_SRC                       12
> +#define BLSP1_UART2_APPS_CLK_SRC                       13
> +#define BLSP1_UART3_APPS_CLK_SRC                       14
> +#define BLSP2_QUP0_I2C_APPS_CLK_SRC                    15
> +#define BLSP2_QUP0_SPI_APPS_CLK_SRC                    16
> +#define BLSP2_UART0_APPS_CLK_SRC                       17
> +#define BYTE0_CLK_SRC                                  18
> +#define EMAC_CLK_SRC                                   19
> +#define EMAC_PTP_CLK_SRC                               20
> +#define ESC0_CLK_SRC                                   21
> +#define GCC_APSS_AHB_CLK                               22
> +#define GCC_APSS_AXI_CLK                               23
> +#define GCC_BIMC_APSS_AXI_CLK                          24
> +#define GCC_BIMC_GFX_CLK                               25
> +#define GCC_BIMC_MDSS_CLK                              26
> +#define GCC_BLSP1_AHB_CLK                              27
> +#define GCC_BLSP1_QUP0_I2C_APPS_CLK                    28
> +#define GCC_BLSP1_QUP0_SPI_APPS_CLK                    29
> +#define GCC_BLSP1_QUP1_I2C_APPS_CLK                    30
> +#define GCC_BLSP1_QUP1_SPI_APPS_CLK                    31
> +#define GCC_BLSP1_QUP2_I2C_APPS_CLK                    32
> +#define GCC_BLSP1_QUP2_SPI_APPS_CLK                    33
> +#define GCC_BLSP1_QUP3_I2C_APPS_CLK                    34
> +#define GCC_BLSP1_QUP3_SPI_APPS_CLK                    35
> +#define GCC_BLSP1_QUP4_I2C_APPS_CLK                    36
> +#define GCC_BLSP1_QUP4_SPI_APPS_CLK                    37
> +#define GCC_BLSP1_UART0_APPS_CLK                       38
> +#define GCC_BLSP1_UART1_APPS_CLK                       39
> +#define GCC_BLSP1_UART2_APPS_CLK                       40
> +#define GCC_BLSP1_UART3_APPS_CLK                       41
> +#define GCC_BLSP2_AHB_CLK                              42
> +#define GCC_BLSP2_QUP0_I2C_APPS_CLK                    43
> +#define GCC_BLSP2_QUP0_SPI_APPS_CLK                    44
> +#define GCC_BLSP2_UART0_APPS_CLK                       45
> +#define GCC_BOOT_ROM_AHB_CLK                           46
> +#define GCC_DCC_CLK                                    47
> +#define GCC_GENI_IR_H_CLK                              48
> +#define GCC_ETH_AXI_CLK                                        49
> +#define GCC_ETH_PTP_CLK                                        50
> +#define GCC_ETH_RGMII_CLK                              51
> +#define GCC_ETH_SLAVE_AHB_CLK                          52
> +#define GCC_GENI_IR_S_CLK                              53
> +#define GCC_GP1_CLK                                    54
> +#define GCC_GP2_CLK                                    55
> +#define GCC_GP3_CLK                                    56
> +#define GCC_MDSS_AHB_CLK                               57
> +#define GCC_MDSS_AXI_CLK                               58
> +#define GCC_MDSS_BYTE0_CLK                             59
> +#define GCC_MDSS_ESC0_CLK                              60
> +#define GCC_MDSS_HDMI_APP_CLK                          61
> +#define GCC_MDSS_HDMI_PCLK_CLK                         62
> +#define GCC_MDSS_MDP_CLK                               63
> +#define GCC_MDSS_PCLK0_CLK                             64
> +#define GCC_MDSS_VSYNC_CLK                             65
> +#define GCC_OXILI_AHB_CLK                              66
> +#define GCC_OXILI_GFX3D_CLK                            67
> +#define GCC_PCIE_0_AUX_CLK                             68
> +#define GCC_PCIE_0_CFG_AHB_CLK                         69
> +#define GCC_PCIE_0_MSTR_AXI_CLK                                70
> +#define GCC_PCIE_0_PIPE_CLK                            71
> +#define GCC_PCIE_0_SLV_AXI_CLK                         72
> +#define GCC_PCNOC_USB2_CLK                             73
> +#define GCC_PCNOC_USB3_CLK                             74
> +#define GCC_PDM2_CLK                                   75
> +#define GCC_PDM_AHB_CLK                                        76
> +#define VSYNC_CLK_SRC                                  77
> +#define GCC_PRNG_AHB_CLK                               78
> +#define GCC_PWM0_XO512_CLK                             79
> +#define GCC_PWM1_XO512_CLK                             80
> +#define GCC_PWM2_XO512_CLK                             81
> +#define GCC_SDCC1_AHB_CLK                              82
> +#define GCC_SDCC1_APPS_CLK                             83
> +#define GCC_SDCC1_ICE_CORE_CLK                         84
> +#define GCC_SDCC2_AHB_CLK                              85
> +#define GCC_SDCC2_APPS_CLK                             86
> +#define GCC_SYS_NOC_USB3_CLK                           87
> +#define GCC_USB20_MOCK_UTMI_CLK                                88
> +#define GCC_USB2A_PHY_SLEEP_CLK                                89
> +#define GCC_USB30_MASTER_CLK                           90
> +#define GCC_USB30_MOCK_UTMI_CLK                                91
> +#define gcc_usb30_sleep_clk                            92
> +#define gcc_usb3_phy_aux_clk                           93
> +#define gcc_usb3_phy_pipe_clk                          94
> +#define gcc_usb_hs_phy_cfg_ahb_clk                     95
> +#define gcc_usb_hs_system_clk                          96
> +#define gfx3d_clk_src                                  97
> +#define gp1_clk_src                                    98
> +#define gp2_clk_src                                    99
> +#define gp3_clk_src                                    100
> +#define gpll0_out_main                                 101
> +#define gpll1_out_main                                 102
> +#define gpll3_out_main                                 103
> +#define gpll4_out_main                                 104
> +#define hdmi_app_clk_src                               105
> +#define hdmi_pclk_clk_src                              106
> +#define mdp_clk_src                                    107
> +#define pcie_0_aux_clk_src                             108
> +#define pcie_0_pipe_clk_src                            109
> +#define pclk0_clk_src                                  110
> +#define pdm2_clk_src                                   111
> +#define sdcc1_apps_clk_src                             112
> +#define sdcc1_ice_core_clk_src                         113
> +#define sdcc2_apps_clk_src                             114
> +#define usb20_mock_utmi_clk_src                                115
> +#define usb30_master_clk_src                           116
> +#define usb30_mock_utmi_clk_src                                117
> +#define usb3_phy_aux_clk_src                           118
> +#define usb_hs_system_clk_src                          119
> +#define gpll0_ao_clk_src                               120
> +#define wcnss_m_clk                                    121
> +#define gcc_usb_hs_inactivity_timers_clk               122

Please capitalize all these macros.

> +#define GPLL0_AO_OUT_MAIN                              123
> +#define GPLL0_SLEEP_CLK_SRC                            124
> +#define GPLL6                                          125
> +#define GPLL6_OUT_AUX                                  126
> +#define MDSS_MDP_VOTE_CLK                              127
> +#define MDSS_ROTATOR_VOTE_CLK                          128
> +#define GCC_BIMC_GPU_CLK                               129
> +#define GCC_GTCU_AHB_CLK                               130
> +#define GCC_GFX_TCU_CLK                                        131
> +#define GCC_GFX_TBU_CLK                                        132
> +#define GCC_SMMU_CFG_CLK                               133
> +#define GCC_APSS_TCU_CLK                               134
> +#define GCC_CRYPTO_AHB_CLK                             135
> +#define GCC_CRYPTO_AXI_CLK                             136
> +#define GCC_CRYPTO_CLK                                 137
> +#define GCC_MDP_TBU_CLK                                        138
> +#define GCC_QDSS_DAP_CLK                               139
> +#define GCC_DCC_XO_CLK                                 140
> +
> +#define GCC_GENI_IR_BCR                                        0
> +#define GCC_USB_HS_BCR                                 1
> +#define GCC_USB2_HS_PHY_ONLY_BCR                       2
> +#define GCC_QUSB2_PHY_BCR                              3
> +#define GCC_USB_HS_PHY_CFG_AHB_BCR                     4
> +#define GCC_USB2A_PHY_BCR                              5
> +#define GCC_USB3_PHY_BCR                               6
> +#define GCC_USB_30_BCR                                 7
> +#define GCC_USB3PHY_PHY_BCR                            8
> +#define GCC_PCIE_0_BCR                                 9
> +#define GCC_PCIE_0_PHY_BCR                             10
> +#define GCC_PCIE_0_LINK_DOWN_BCR                       11
> +#define GCC_PCIEPHY_0_PHY_BCR                          12
> +#define GCC_EMAC_BCR                                   13

No GDSCs? Ok.

> +

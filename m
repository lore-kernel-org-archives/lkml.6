Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeCVOZ3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:25:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45887 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754121AbeCVOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:25:24 -0400
X-Google-Smtp-Source: AIpwx4+48HoqpCPjD0dIsI6oZYlWWI+I4Nkch0qe12VvfhRIqiqOA8tFfebnXtYAT6tHPz+QsuBBd/VhOsczPVZGmEQ=
MIME-Version: 1.0
In-Reply-To: <1521712529-632-5-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com> <1521712529-632-5-git-send-email-abel.vesa@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Mar 2018 11:25:23 -0300
Message-ID: <CAOMZO5DBR7qrMBw+DWcK26EsKPG_Pkc4xXy0WXp7Qn3QTOaL4Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm: imx: Update clk driver for imx7d
To: Abel Vesa <abel.vesa@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yongcai Huang <anson.huang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 6:55 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> From: Anson Huang <anson.huang@nxp.com>
>
> This patch updates the imx7d clk driver to make use of the new imx clk API.

Why? Please give the reasons in the commit log.

> Signed-off-by: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/clk-imx7d.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 3553b68..255563b 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -433,13 +433,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>         clks[IMX7D_PLL_AUDIO_MAIN_BYPASS] = imx_clk_mux_flags("pll_audio_main_bypass", base + 0xf0, 16, 1, pll_audio_bypass_sel, ARRAY_SIZE(pll_audio_bypass_sel), CLK_SET_RATE_PARENT);
>         clks[IMX7D_PLL_VIDEO_MAIN_BYPASS] = imx_clk_mux_flags("pll_video_main_bypass", base + 0x130, 16, 1, pll_video_bypass_sel, ARRAY_SIZE(pll_video_bypass_sel), CLK_SET_RATE_PARENT);
>
> -       clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
> -       clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
> -       clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
> -       clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
> -       clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
> -       clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);
> -
>         clks[IMX7D_PLL_ARM_MAIN_CLK] = imx_clk_gate("pll_arm_main_clk", "pll_arm_main_bypass", base + 0x60, 13);
>         clks[IMX7D_PLL_DRAM_MAIN_CLK] = imx_clk_gate("pll_dram_main_clk", "pll_dram_test_div", base + 0x70, 13);
>         clks[IMX7D_PLL_SYS_MAIN_CLK] = imx_clk_gate("pll_sys_main_clk", "pll_sys_main_bypass", base + 0xb0, 13);
> @@ -525,7 +518,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>         clks[IMX7D_PCIE_CTRL_ROOT_SRC] = imx_clk_mux2("pcie_ctrl_src", base + 0xa180, 24, 3, pcie_ctrl_sel, ARRAY_SIZE(pcie_ctrl_sel));
>         clks[IMX7D_PCIE_PHY_ROOT_SRC] = imx_clk_mux2("pcie_phy_src", base + 0xa200, 24, 3, pcie_phy_sel, ARRAY_SIZE(pcie_phy_sel));
>         clks[IMX7D_EPDC_PIXEL_ROOT_SRC] = imx_clk_mux2("epdc_pixel_src", base + 0xa280, 24, 3, epdc_pixel_sel, ARRAY_SIZE(epdc_pixel_sel));
> -       clks[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_mux2("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel));
> +       clks[IMX7D_LCDIF_PIXEL_ROOT_SRC] = imx_clk_mux_flags("lcdif_pixel_src", base + 0xa300, 24, 3, lcdif_pixel_sel, ARRAY_SIZE(lcdif_pixel_sel), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
>         clks[IMX7D_MIPI_DSI_ROOT_SRC] = imx_clk_mux2("mipi_dsi_src", base + 0xa380, 24, 3,  mipi_dsi_sel, ARRAY_SIZE(mipi_dsi_sel));
>         clks[IMX7D_MIPI_CSI_ROOT_SRC] = imx_clk_mux2("mipi_csi_src", base + 0xa400, 24, 3, mipi_csi_sel, ARRAY_SIZE(mipi_csi_sel));
>         clks[IMX7D_MIPI_DPHY_ROOT_SRC] = imx_clk_mux2("mipi_dphy_src", base + 0xa480, 24, 3, mipi_dphy_sel, ARRAY_SIZE(mipi_dphy_sel));
> @@ -719,13 +712,13 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>         clks[IMX7D_CLKO1_ROOT_PRE_DIV] = imx_clk_divider2("clko1_pre_div", "clko1_cg", base + 0xbd80, 16, 3);
>         clks[IMX7D_CLKO2_ROOT_PRE_DIV] = imx_clk_divider2("clko2_pre_div", "clko2_cg", base + 0xbe00, 16, 3);
>
> -       clks[IMX7D_ARM_A7_ROOT_DIV] = imx_clk_divider2("arm_a7_div", "arm_a7_cg", base + 0x8000, 0, 3);
> +       clks[IMX7D_ARM_A7_ROOT_DIV] = imx_clk_divider_flags("arm_a7_div", "arm_a7_cg", base + 0x8000, 0, 3, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
>         clks[IMX7D_ARM_M4_ROOT_DIV] = imx_clk_divider2("arm_m4_div", "arm_m4_cg", base + 0x8080, 0, 3);
> -       clks[IMX7D_MAIN_AXI_ROOT_DIV] = imx_clk_divider2("axi_post_div", "axi_pre_div", base + 0x8800, 0, 6);
> +       clks[IMX7D_MAIN_AXI_ROOT_DIV] = imx_clk_divider_flags("axi_post_div", "axi_pre_div", base + 0x8800, 0, 6, CLK_OPS_PARENT_ENABLE);
>         clks[IMX7D_DISP_AXI_ROOT_DIV] = imx_clk_divider2("disp_axi_post_div", "disp_axi_pre_div", base + 0x8880, 0, 6);
>         clks[IMX7D_ENET_AXI_ROOT_DIV] = imx_clk_divider2("enet_axi_post_div", "enet_axi_pre_div", base + 0x8900, 0, 6);
>         clks[IMX7D_NAND_USDHC_BUS_ROOT_CLK] = imx_clk_divider2("nand_usdhc_root_clk", "nand_usdhc_pre_div", base + 0x8980, 0, 6);
> -       clks[IMX7D_AHB_CHANNEL_ROOT_DIV] = imx_clk_divider2("ahb_root_clk", "ahb_pre_div", base + 0x9000, 0, 6);
> +       clks[IMX7D_AHB_CHANNEL_ROOT_CLK] = imx_clk_divider_flags("ahb_root_clk", "ahb_pre_div", base + 0x9000, 0, 6, CLK_OPS_PARENT_ENABLE);
>         clks[IMX7D_IPG_ROOT_CLK] = imx_clk_divider2("ipg_root_clk", "ahb_root_clk", base + 0x9080, 0, 2);
>         clks[IMX7D_DRAM_ROOT_DIV] = imx_clk_divider2("dram_post_div", "dram_cg", base + 0x9880, 0, 3);
>         clks[IMX7D_DRAM_PHYM_ALT_ROOT_DIV] = imx_clk_divider2("dram_phym_alt_post_div", "dram_phym_alt_pre_div", base + 0xa000, 0, 3);
> @@ -790,7 +783,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>         clks[IMX7D_CLKO1_ROOT_DIV] = imx_clk_divider2("clko1_post_div", "clko1_pre_div", base + 0xbd80, 0, 6);
>         clks[IMX7D_CLKO2_ROOT_DIV] = imx_clk_divider2("clko2_post_div", "clko2_pre_div", base + 0xbe00, 0, 6);
>
> -       clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate4("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0);
> +       clks[IMX7D_ARM_A7_ROOT_CLK] = imx_clk_gate2_flags("arm_a7_root_clk", "arm_a7_div", base + 0x4000, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
>         clks[IMX7D_ARM_M4_ROOT_CLK] = imx_clk_gate4("arm_m4_root_clk", "arm_m4_div", base + 0x4010, 0);
>         clks[IMX7D_MAIN_AXI_ROOT_CLK] = imx_clk_gate4("main_axi_root_clk", "axi_post_div", base + 0x4040, 0);
>         clks[IMX7D_DISP_AXI_ROOT_CLK] = imx_clk_gate4("disp_axi_root_clk", "disp_axi_post_div", base + 0x4050, 0);
> @@ -886,11 +879,18 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
>         for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>                 clk_prepare_enable(clks[clks_init_on[i]]);
>
> +       imx_clk_set_parent(clks[IMX7D_PLL_ARM_MAIN_BYPASS], clks[IMX7D_PLL_ARM_MAIN]);
> +       imx_clk_set_parent(clks[IMX7D_PLL_DRAM_MAIN_BYPASS], clks[IMX7D_PLL_DRAM_MAIN]);
> +       imx_clk_set_parent(clks[IMX7D_PLL_SYS_MAIN_BYPASS], clks[IMX7D_PLL_SYS_MAIN]);
> +       imx_clk_set_parent(clks[IMX7D_PLL_ENET_MAIN_BYPASS], clks[IMX7D_PLL_ENET_MAIN]);
> +       imx_clk_set_parent(clks[IMX7D_PLL_AUDIO_MAIN_BYPASS], clks[IMX7D_PLL_AUDIO_MAIN]);
> +       imx_clk_set_parent(clks[IMX7D_PLL_VIDEO_MAIN_BYPASS], clks[IMX7D_PLL_VIDEO_MAIN]);

You have not only changed to use imx_clk_set_parent(), but also moved
the location of the code.

Why was this block of code moved?

Also, I am not seeing too much benefit in using imx_clk_set_parent().

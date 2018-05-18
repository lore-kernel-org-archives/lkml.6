Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbeERNDy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 09:03:54 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:60132 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeERNDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 09:03:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Fri, 18 May 2018 15:03:48 +0200
From: Stefan Agner <stefan@agner.ch>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, adriana.reus@nxp.com, rui.silva@linaro.org,
        Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V2 1/3] clk: imx7d: correct enet phy ref clock gates
In-Reply-To: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <66f3e8827e41338291c3e2298cbc87cc@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.05.2018 03:01, Anson Huang wrote:
> IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY directly,
> there is no clock gate after it, rename it to
> IMX7D_ENET_PHY_REF_ROOT_CLK to avoid device tree change.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  drivers/clk/imx/clk-imx7d.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index 975a20d..23d5090a 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -738,7 +738,7 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_ENET1_TIME_ROOT_DIV] =
> imx_clk_divider2("enet1_time_post_div", "enet1_time_pre_div", base +
> 0xa780, 0, 6);
>  	clks[IMX7D_ENET2_REF_ROOT_DIV] =
> imx_clk_divider2("enet2_ref_post_div", "enet2_ref_pre_div", base +
> 0xa800, 0, 6);
>  	clks[IMX7D_ENET2_TIME_ROOT_DIV] =
> imx_clk_divider2("enet2_time_post_div", "enet2_time_pre_div", base +
> 0xa880, 0, 6);
> -	clks[IMX7D_ENET_PHY_REF_ROOT_DIV] =
> imx_clk_divider2("enet_phy_ref_post_div", "enet_phy_ref_pre_div", base
> + 0xa900, 0, 6);
> +	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> imx_clk_divider2("enet_phy_ref_root_clk", "enet_phy_ref_pre_div", base
> + 0xa900, 0, 6);
>  	clks[IMX7D_EIM_ROOT_DIV] = imx_clk_divider2("eim_post_div",
> "eim_pre_div", base + 0xa980, 0, 6);
>  	clks[IMX7D_NAND_ROOT_CLK] = imx_clk_divider2("nand_root_clk",
> "nand_pre_div", base + 0xaa00, 0, 6);
>  	clks[IMX7D_QSPI_ROOT_DIV] = imx_clk_divider2("qspi_post_div",
> "qspi_pre_div", base + 0xaa80, 0, 6);
> @@ -816,7 +816,6 @@ static void __init imx7d_clocks_init(struct
> device_node *ccm_node)
>  	clks[IMX7D_ENET1_TIME_ROOT_CLK] =
> imx_clk_gate4("enet1_time_root_clk", "enet1_time_post_div", base +
> 0x44f0, 0);
>  	clks[IMX7D_ENET2_REF_ROOT_CLK] = imx_clk_gate4("enet2_ref_root_clk",
> "enet2_ref_post_div", base + 0x4500, 0);
>  	clks[IMX7D_ENET2_TIME_ROOT_CLK] =
> imx_clk_gate4("enet2_time_root_clk", "enet2_time_post_div", base +
> 0x4510, 0);
> -	clks[IMX7D_ENET_PHY_REF_ROOT_CLK] =
> imx_clk_gate4("enet_phy_ref_root_clk", "enet_phy_ref_post_div", base +
> 0x4520, 0);
>  	clks[IMX7D_EIM_ROOT_CLK] = imx_clk_gate4("eim_root_clk",
> "eim_post_div", base + 0x4160, 0);
>  	clks[IMX7D_NAND_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_rawnand_clk", "nand_root_clk", base +
> 0x4140, 0, &share_count_nand);
>  	clks[IMX7D_NAND_USDHC_BUS_RAWNAND_CLK] =
> imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_root_clk",
> base + 0x4140, 0, &share_count_nand);

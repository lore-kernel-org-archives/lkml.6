Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030810AbeBOMdB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:33:01 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:48181 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967960AbeBOMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:32:57 -0500
Subject: Re: [PATCH 1/8] pinctrl: sh-pfc: r8a77995: Add DU support
To: Kieran Bingham <kbingham@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>, geert@glider.be,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-2-git-send-email-kbingham@kernel.org>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <9ac40731-eb13-4727-864d-0e3b7059b9f8@ideasonboard.com>
Date: Thu, 15 Feb 2018 12:32:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1518683903-10681-2-git-send-email-kbingham@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch duplicates work performed by Ulrich.

Please consider this patch dropped, and no need for review.

(especially the obvious error in the pin-values)

Oh well - it was a fun exercise to go through :-)

--
Regards

Kieran

On 15/02/18 08:38, Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Provide pin control support for the DU parallel RGB output signals.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 101 ++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
> index a4927b78a17b..277b0d6972f7 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
> @@ -1114,6 +1114,87 @@ static const unsigned int canfd1_data_mux[] = {
>  	CANFD1_TX_MARK, CANFD1_RX_MARK,
>  };
>  
> +/* - DU --------------------------------------------------------------------- */
> +static const unsigned int du_rgb666_pins[] = {
> +	/* R[7:2], G[7:2], B[7:2] */
> +	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 21),
> +	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 19), RCAR_GP_PIN(1, 18),
> +	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 13),
> +	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 11), RCAR_GP_PIN(1, 10),
> +	RCAR_GP_PIN(1, 7),  RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 5),
> +	RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 2),
> +};
> +static const unsigned int du_rgb666_mux[] = {
> +	DU_DR7_MARK, DU_DR6_MARK, DU_DR5_MARK, DU_DR4_MARK,
> +	DU_DR3_MARK, DU_DR2_MARK,
> +	DU_DG7_MARK, DU_DG6_MARK, DU_DG5_MARK, DU_DG4_MARK,
> +	DU_DG3_MARK, DU_DG2_MARK,
> +	DU_DB7_MARK, DU_DB6_MARK, DU_DB5_MARK, DU_DB4_MARK,
> +	DU_DB3_MARK, DU_DB2_MARK,
> +};
> +static const unsigned int du_rgb888_pins[] = {
> +	/* R[7:0], G[7:0], B[7:0] */
> +	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 21),
> +	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 19), RCAR_GP_PIN(1, 18),
> +	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 16),
> +	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 13),
> +	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 11), RCAR_GP_PIN(1, 10),
> +	RCAR_GP_PIN(1, 9),  RCAR_GP_PIN(1, 8),
> +	RCAR_GP_PIN(1, 7),  RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 5),
> +	RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 2),
> +	RCAR_GP_PIN(1, 1),  RCAR_GP_PIN(1, 0),
> +};
> +static const unsigned int du_rgb888_mux[] = {
> +	DU_DR7_MARK, DU_DR6_MARK, DU_DR5_MARK, DU_DR4_MARK,
> +	DU_DR3_MARK, DU_DR2_MARK, DU_DR1_MARK, DU_DR0_MARK,
> +	DU_DG7_MARK, DU_DG6_MARK, DU_DG5_MARK, DU_DG4_MARK,
> +	DU_DG3_MARK, DU_DG2_MARK, DU_DG1_MARK, DU_DG0_MARK,
> +	DU_DB7_MARK, DU_DB6_MARK, DU_DB5_MARK, DU_DB4_MARK,
> +	DU_DB3_MARK, DU_DB2_MARK, DU_DB1_MARK, DU_DB0_MARK,
> +};
> +static const unsigned int du_dotclkout0_pins[] = {
> +	/* CLKOUT */
> +	RCAR_GP_PIN(1, 24),
> +};
> +static const unsigned int du_dotclkout0_mux[] = {
> +	DU_DOTCLKOUT0_MARK
> +};
> +static const unsigned int du_sync_pins[] = {
> +	/* HSYNC, VSYNC */
> +	RCAR_GP_PIN(1, 25), RCAR_GP_PIN(1, 26),
> +};
> +static const unsigned int du_sync_mux[] = {
> +	DU_HSYNC_MARK, DU_VSYNC_MARK
> +};
> +static const unsigned int du_disp_pins[] = {
> +	/* DISP */
> +	RCAR_GP_PIN(2, 1),
> +};
> +static const unsigned int du_disp_mux[] = {
> +	DU_DISP_MARK,
> +};
> +static const unsigned int du_dotclkin1_pins[] = {
> +	/* DOTCLKOUT0 */
> +	RCAR_GP_PIN(1, 28),
> +};
> +static const unsigned int du_dotclkin1_mux[] = {
> +	DU_DOTCLKIN1_MARK,
> +};
> +static const unsigned int du_disp_cde_pins[] = {
> +	/* DISP/CDE */
> +	RCAR_GP_PIN(1, 28),
> +};
> +static const unsigned int du_disp_cde_mux[] = {
> +	DU_DISP_CDE_MARK,
> +};
> +static const unsigned int du_cde_pins[] = {
> +	/* CDE */
> +	RCAR_GP_PIN(1, 29),
> +};
> +static const unsigned int du_cde_mux[] = {
> +	DU_CDE_MARK,
> +};
> +
>  /* - I2C -------------------------------------------------------------------- */
>  static const unsigned int i2c0_pins[] = {
>  	/* SCL, SDA */
> @@ -1568,6 +1649,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
>  	SH_PFC_PIN_GROUP(can_clk),
>  	SH_PFC_PIN_GROUP(canfd0_data),
>  	SH_PFC_PIN_GROUP(canfd1_data),
> +	SH_PFC_PIN_GROUP(du_rgb666),
> +	SH_PFC_PIN_GROUP(du_rgb888),
> +	SH_PFC_PIN_GROUP(du_dotclkout0),
> +	SH_PFC_PIN_GROUP(du_sync),
> +	SH_PFC_PIN_GROUP(du_disp),
> +	SH_PFC_PIN_GROUP(du_dotclkin1),
> +	SH_PFC_PIN_GROUP(du_disp_cde),
> +	SH_PFC_PIN_GROUP(du_cde),
>  	SH_PFC_PIN_GROUP(i2c0),
>  	SH_PFC_PIN_GROUP(i2c1),
>  	SH_PFC_PIN_GROUP(i2c2_a),
> @@ -1664,6 +1753,17 @@ static const char * const canfd1_groups[] = {
>  	"canfd1_data",
>  };
>  
> +static const char * const du_groups[] = {
> +	"du_rgb666",
> +	"du_rgb888",
> +	"du_dotclk_out_0",
> +	"du_sync",
> +	"du_disp",
> +	"du_dotclk_in_1",
> +	"du_disp_cde",
> +	"du_cde",
> +};
> +
>  static const char * const i2c0_groups[] = {
>  	"i2c0",
>  };
> @@ -1779,6 +1879,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(can_clk),
>  	SH_PFC_FUNCTION(canfd0),
>  	SH_PFC_FUNCTION(canfd1),
> +	SH_PFC_FUNCTION(du),
>  	SH_PFC_FUNCTION(i2c0),
>  	SH_PFC_FUNCTION(i2c1),
>  	SH_PFC_FUNCTION(i2c2),
> 

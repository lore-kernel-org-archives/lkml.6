Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934941AbeBMJrG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:47:06 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47177 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934917AbeBMJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:46:59 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] pinctrl: sh-pfc: r8a77965: Add SCIFs groups/functions
Date: Tue, 13 Feb 2018 10:45:56 +0100
Message-Id: <1518515162-23663-10-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SCIF[0-5] groups and pin function definitions for R-Car M3-N.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 296 ++++++++++++++++++++++++++++++++++
 1 file changed, 296 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 9286aa2..6989db2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -1577,10 +1577,306 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
 };
 
+/* - SCIF0 ------------------------------------------------------------------ */
+static const unsigned int scif0_data_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
+};
+static const unsigned int scif0_data_mux[] = {
+	RX0_MARK, TX0_MARK,
+};
+static const unsigned int scif0_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 0),
+};
+static const unsigned int scif0_clk_mux[] = {
+	SCK0_MARK,
+};
+static const unsigned int scif0_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 3),
+};
+static const unsigned int scif0_ctrl_mux[] = {
+	RTS0_N_TANS_MARK, CTS0_N_MARK,
+};
+/* - SCIF1 ------------------------------------------------------------------ */
+static const unsigned int scif1_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
+};
+static const unsigned int scif1_data_a_mux[] = {
+	RX1_A_MARK, TX1_A_MARK,
+};
+static const unsigned int scif1_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(6, 21),
+};
+static const unsigned int scif1_clk_mux[] = {
+	SCK1_MARK,
+};
+static const unsigned int scif1_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 7),
+};
+static const unsigned int scif1_ctrl_mux[] = {
+	RTS1_N_TANS_MARK, CTS1_N_MARK,
+};
+static const unsigned int scif1_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 25),
+};
+static const unsigned int scif1_data_b_mux[] = {
+	RX1_B_MARK, TX1_B_MARK,
+};
+/* - SCIF2 ------------------------------------------------------------------ */
+static const unsigned int scif2_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 10),
+};
+static const unsigned int scif2_data_a_mux[] = {
+	RX2_A_MARK, TX2_A_MARK,
+};
+static const unsigned int scif2_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 9),
+};
+static const unsigned int scif2_clk_mux[] = {
+	SCK2_MARK,
+};
+static const unsigned int scif2_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 16),
+};
+static const unsigned int scif2_data_b_mux[] = {
+	RX2_B_MARK, TX2_B_MARK,
+};
+/* - SCIF3 ------------------------------------------------------------------ */
+static const unsigned int scif3_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 24),
+};
+static const unsigned int scif3_data_a_mux[] = {
+	RX3_A_MARK, TX3_A_MARK,
+};
+static const unsigned int scif3_clk_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 22),
+};
+static const unsigned int scif3_clk_mux[] = {
+	SCK3_MARK,
+};
+static const unsigned int scif3_ctrl_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 26), RCAR_GP_PIN(1, 25),
+};
+static const unsigned int scif3_ctrl_mux[] = {
+	RTS3_N_TANS_MARK, CTS3_N_MARK,
+};
+static const unsigned int scif3_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 8), RCAR_GP_PIN(1, 11),
+};
+static const unsigned int scif3_data_b_mux[] = {
+	RX3_B_MARK, TX3_B_MARK,
+};
+/* - SCIF4 ------------------------------------------------------------------ */
+static const unsigned int scif4_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(2, 11), RCAR_GP_PIN(2, 12),
+};
+static const unsigned int scif4_data_a_mux[] = {
+	RX4_A_MARK, TX4_A_MARK,
+};
+static const unsigned int scif4_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(2, 10),
+};
+static const unsigned int scif4_clk_a_mux[] = {
+	SCK4_A_MARK,
+};
+static const unsigned int scif4_ctrl_a_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(2, 14), RCAR_GP_PIN(2, 13),
+};
+static const unsigned int scif4_ctrl_a_mux[] = {
+	RTS4_N_TANS_A_MARK, CTS4_N_A_MARK,
+};
+static const unsigned int scif4_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+};
+static const unsigned int scif4_data_b_mux[] = {
+	RX4_B_MARK, TX4_B_MARK,
+};
+static const unsigned int scif4_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(1, 5),
+};
+static const unsigned int scif4_clk_b_mux[] = {
+	SCK4_B_MARK,
+};
+static const unsigned int scif4_ctrl_b_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 9),
+};
+static const unsigned int scif4_ctrl_b_mux[] = {
+	RTS4_N_TANS_B_MARK, CTS4_N_B_MARK,
+};
+static const unsigned int scif4_data_c_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+};
+static const unsigned int scif4_data_c_mux[] = {
+	RX4_C_MARK, TX4_C_MARK,
+};
+static const unsigned int scif4_clk_c_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(0, 8),
+};
+static const unsigned int scif4_clk_c_mux[] = {
+	SCK4_C_MARK,
+};
+static const unsigned int scif4_ctrl_c_pins[] = {
+	/* RTS, CTS */
+	RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 10),
+};
+static const unsigned int scif4_ctrl_c_mux[] = {
+	RTS4_N_TANS_C_MARK, CTS4_N_C_MARK,
+};
+/* - SCIF5 ------------------------------------------------------------------ */
+static const unsigned int scif5_data_a_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 21),
+};
+static const unsigned int scif5_data_a_mux[] = {
+	RX5_A_MARK, TX5_A_MARK,
+};
+static const unsigned int scif5_clk_a_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(6, 21),
+};
+static const unsigned int scif5_clk_a_mux[] = {
+	SCK5_A_MARK,
+};
+static const unsigned int scif5_data_b_pins[] = {
+	/* RX, TX */
+	RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 18),
+};
+static const unsigned int scif5_data_b_mux[] = {
+	RX5_B_MARK, TX5_B_MARK,
+};
+static const unsigned int scif5_clk_b_pins[] = {
+	/* SCK */
+	RCAR_GP_PIN(5, 0),
+};
+static const unsigned int scif5_clk_b_mux[] = {
+	SCK5_B_MARK,
+};
+/* - SCIF Clock ------------------------------------------------------------- */
+static const unsigned int scif_clk_a_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(6, 23),
+};
+static const unsigned int scif_clk_a_mux[] = {
+	SCIF_CLK_A_MARK,
+};
+static const unsigned int scif_clk_b_pins[] = {
+	/* SCIF_CLK */
+	RCAR_GP_PIN(5, 9),
+};
+static const unsigned int scif_clk_b_mux[] = {
+	SCIF_CLK_B_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(scif0_data),
+	SH_PFC_PIN_GROUP(scif0_clk),
+	SH_PFC_PIN_GROUP(scif0_ctrl),
+	SH_PFC_PIN_GROUP(scif1_data_a),
+	SH_PFC_PIN_GROUP(scif1_clk),
+	SH_PFC_PIN_GROUP(scif1_ctrl),
+	SH_PFC_PIN_GROUP(scif1_data_b),
+	SH_PFC_PIN_GROUP(scif2_data_a),
+	SH_PFC_PIN_GROUP(scif2_clk),
+	SH_PFC_PIN_GROUP(scif2_data_b),
+	SH_PFC_PIN_GROUP(scif3_data_a),
+	SH_PFC_PIN_GROUP(scif3_clk),
+	SH_PFC_PIN_GROUP(scif3_ctrl),
+	SH_PFC_PIN_GROUP(scif3_data_b),
+	SH_PFC_PIN_GROUP(scif4_data_a),
+	SH_PFC_PIN_GROUP(scif4_clk_a),
+	SH_PFC_PIN_GROUP(scif4_ctrl_a),
+	SH_PFC_PIN_GROUP(scif4_data_b),
+	SH_PFC_PIN_GROUP(scif4_clk_b),
+	SH_PFC_PIN_GROUP(scif4_ctrl_b),
+	SH_PFC_PIN_GROUP(scif4_data_c),
+	SH_PFC_PIN_GROUP(scif4_clk_c),
+	SH_PFC_PIN_GROUP(scif4_ctrl_c),
+	SH_PFC_PIN_GROUP(scif5_data_a),
+	SH_PFC_PIN_GROUP(scif5_clk_a),
+	SH_PFC_PIN_GROUP(scif5_data_b),
+	SH_PFC_PIN_GROUP(scif5_clk_b),
+	SH_PFC_PIN_GROUP(scif_clk_a),
+	SH_PFC_PIN_GROUP(scif_clk_b),
+};
+
+static const char * const scif0_groups[] = {
+	"scif0_data",
+	"scif0_clk",
+	"scif0_ctrl",
+};
+
+static const char * const scif1_groups[] = {
+	"scif1_data_a",
+	"scif1_clk",
+	"scif1_ctrl",
+	"scif1_data_b",
+};
+static const char * const scif2_groups[] = {
+	"scif2_data_a",
+	"scif2_clk",
+	"scif2_data_b",
+};
+
+static const char * const scif3_groups[] = {
+	"scif3_data_a",
+	"scif3_clk",
+	"scif3_ctrl",
+	"scif3_data_b",
+};
+
+static const char * const scif4_groups[] = {
+	"scif4_data_a",
+	"scif4_clk_a",
+	"scif4_ctrl_a",
+	"scif4_data_b",
+	"scif4_clk_b",
+	"scif4_ctrl_b",
+	"scif4_data_c",
+	"scif4_clk_c",
+	"scif4_ctrl_c",
+};
+
+static const char * const scif5_groups[] = {
+	"scif5_data_a",
+	"scif5_clk_a",
+	"scif5_data_b",
+	"scif5_clk_b",
+};
+
+static const char * const scif_clk_groups[] = {
+	"scif_clk_a",
+	"scif_clk_b",
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(scif0),
+	SH_PFC_FUNCTION(scif1),
+	SH_PFC_FUNCTION(scif2),
+	SH_PFC_FUNCTION(scif3),
+	SH_PFC_FUNCTION(scif4),
+	SH_PFC_FUNCTION(scif5),
+	SH_PFC_FUNCTION(scif_clk),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.7.4

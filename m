Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757115AbeDZQ7c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:59:32 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58080 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756688AbeDZQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:53:55 -0400
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/17] pinctrl: sh-pfc: r8a77965: Add DU RGB output pins, groups and functions
Date: Thu, 26 Apr 2018 17:53:32 +0100
Message-Id: <20180426165346.494-4-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
References: <20180426165346.494-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pins, groups and functions for parallel RGB output
signals from DU. The HDMI and TCON pins are added to separate groups.

Based on a similar patch of the R8A7796 PFC driver by Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[Kieran: Rebase on top of tree]
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 116 ++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 3771b2d10f39..f5a37d3ea753 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -1662,6 +1662,102 @@ static const unsigned int avb_avtp_capture_b_mux[] = {
 	AVB_AVTP_CAPTURE_B_MARK,
 };
 
+/* - DU --------------------------------------------------------------------- */
+static const unsigned int du_rgb666_pins[] = {
+	/* R[7:2], G[7:2], B[7:2] */
+	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 13),
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 10),
+	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 13),
+	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 19), RCAR_GP_PIN(1, 18),
+	RCAR_GP_PIN(1, 7),  RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 2),
+};
+
+static const unsigned int du_rgb666_mux[] = {
+	DU_DR7_MARK, DU_DR6_MARK, DU_DR5_MARK, DU_DR4_MARK,
+	DU_DR3_MARK, DU_DR2_MARK,
+	DU_DG7_MARK, DU_DG6_MARK, DU_DG5_MARK, DU_DG4_MARK,
+	DU_DG3_MARK, DU_DG2_MARK,
+	DU_DB7_MARK, DU_DB6_MARK, DU_DB5_MARK, DU_DB4_MARK,
+	DU_DB3_MARK, DU_DB2_MARK,
+};
+
+static const unsigned int du_rgb888_pins[] = {
+	/* R[7:0], G[7:0], B[7:0] */
+	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 13),
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 11), RCAR_GP_PIN(0, 10),
+	RCAR_GP_PIN(0, 9),  RCAR_GP_PIN(0, 8),
+	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 13),
+	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 19), RCAR_GP_PIN(1, 18),
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 16),
+	RCAR_GP_PIN(1, 7),  RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 2),
+	RCAR_GP_PIN(1, 1),  RCAR_GP_PIN(1, 0),
+};
+
+static const unsigned int du_rgb888_mux[] = {
+	DU_DR7_MARK, DU_DR6_MARK, DU_DR5_MARK, DU_DR4_MARK,
+	DU_DR3_MARK, DU_DR2_MARK, DU_DR1_MARK, DU_DR0_MARK,
+	DU_DG7_MARK, DU_DG6_MARK, DU_DG5_MARK, DU_DG4_MARK,
+	DU_DG3_MARK, DU_DG2_MARK, DU_DG1_MARK, DU_DG0_MARK,
+	DU_DB7_MARK, DU_DB6_MARK, DU_DB5_MARK, DU_DB4_MARK,
+	DU_DB3_MARK, DU_DB2_MARK, DU_DB1_MARK, DU_DB0_MARK,
+};
+
+static const unsigned int du_clk_out_0_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(1, 27),
+};
+
+static const unsigned int du_clk_out_0_mux[] = {
+	DU_DOTCLKOUT0_MARK
+};
+
+static const unsigned int du_clk_out_1_pins[] = {
+	/* CLKOUT */
+	RCAR_GP_PIN(2, 3),
+};
+
+static const unsigned int du_clk_out_1_mux[] = {
+	DU_DOTCLKOUT1_MARK
+};
+
+static const unsigned int du_sync_pins[] = {
+	/* EXVSYNC/VSYNC, EXHSYNC/HSYNC */
+	RCAR_GP_PIN(2, 5), RCAR_GP_PIN(2, 4),
+};
+
+static const unsigned int du_sync_mux[] = {
+	DU_EXVSYNC_DU_VSYNC_MARK, DU_EXHSYNC_DU_HSYNC_MARK
+};
+
+static const unsigned int du_oddf_pins[] = {
+	/* EXDISP/EXODDF/EXCDE */
+	RCAR_GP_PIN(2, 2),
+};
+
+static const unsigned int du_oddf_mux[] = {
+	DU_EXODDF_DU_ODDF_DISP_CDE_MARK,
+};
+
+static const unsigned int du_cde_pins[] = {
+	/* CDE */
+	RCAR_GP_PIN(2, 0),
+};
+
+static const unsigned int du_cde_mux[] = {
+	DU_CDE_MARK,
+};
+
+static const unsigned int du_disp_pins[] = {
+	/* DISP */
+	RCAR_GP_PIN(2, 1),
+};
+
+static const unsigned int du_disp_mux[] = {
+	DU_DISP_MARK,
+};
+
 /* - INTC-EX ---------------------------------------------------------------- */
 static const unsigned int intc_ex_irq0_pins[] = {
 	/* IRQ0 */
@@ -2756,6 +2852,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
 	SH_PFC_PIN_GROUP(avb_avtp_match_b),
 	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+	SH_PFC_PIN_GROUP(du_rgb666),
+	SH_PFC_PIN_GROUP(du_rgb888),
+	SH_PFC_PIN_GROUP(du_clk_out_0),
+	SH_PFC_PIN_GROUP(du_clk_out_1),
+	SH_PFC_PIN_GROUP(du_sync),
+	SH_PFC_PIN_GROUP(du_oddf),
+	SH_PFC_PIN_GROUP(du_cde),
+	SH_PFC_PIN_GROUP(du_disp),
 	SH_PFC_PIN_GROUP(intc_ex_irq0),
 	SH_PFC_PIN_GROUP(intc_ex_irq1),
 	SH_PFC_PIN_GROUP(intc_ex_irq2),
@@ -2922,6 +3026,17 @@ static const char * const avb_groups[] = {
 	"avb_avtp_capture_b",
 };
 
+static const char * const du_groups[] = {
+	"du_rgb666",
+	"du_rgb888",
+	"du_clk_out_0",
+	"du_clk_out_1",
+	"du_sync",
+	"du_oddf",
+	"du_cde",
+	"du_disp",
+};
+
 static const char * const intc_ex_groups[] = {
 	"intc_ex_irq0",
 	"intc_ex_irq1",
@@ -3139,6 +3254,7 @@ static const char * const usb30_groups[] = {
 
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(avb),
+	SH_PFC_FUNCTION(du),
 	SH_PFC_FUNCTION(intc_ex),
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),
-- 
2.17.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbeBMJrS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:47:18 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40121 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934621AbeBMJrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:47:15 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] pinctrl: sh-pfc: r8a77965: Add EtherAVB groups/functions
Date: Tue, 13 Feb 2018 10:46:01 +0100
Message-Id: <1518515162-23663-15-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EtherAVB groups and functions definitions for R-Car M3-N.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 110 ++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 6989db2..ac260d4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -1577,6 +1577,92 @@ static const struct sh_pfc_pin pinmux_pins[] = {
 	SH_PFC_PIN_NAMED_CFG(ROW_GROUP_A('T'), 30, ASEBRK, CFG_FLAGS),
 };
 
+/* - EtherAVB --------------------------------------------------------------- */
+static const unsigned int avb_link_pins[] = {
+	/* AVB_LINK */
+	RCAR_GP_PIN(2, 12),
+};
+static const unsigned int avb_link_mux[] = {
+	AVB_LINK_MARK,
+};
+static const unsigned int avb_magic_pins[] = {
+	/* AVB_MAGIC_ */
+	RCAR_GP_PIN(2, 10),
+};
+static const unsigned int avb_magic_mux[] = {
+	AVB_MAGIC_MARK,
+};
+static const unsigned int avb_phy_int_pins[] = {
+	/* AVB_PHY_INT */
+	RCAR_GP_PIN(2, 11),
+};
+static const unsigned int avb_phy_int_mux[] = {
+	AVB_PHY_INT_MARK,
+};
+static const unsigned int avb_mdc_pins[] = {
+	/* AVB_MDC, AVB_MDIO */
+	RCAR_GP_PIN(2, 9), PIN_NUMBER('A', 9),
+};
+static const unsigned int avb_mdc_mux[] = {
+	AVB_MDC_MARK, AVB_MDIO_MARK,
+};
+static const unsigned int avb_mii_pins[] = {
+	/*
+	 * AVB_TX_CTL, AVB_TXC, AVB_TD0,
+	 * AVB_TD1, AVB_TD2, AVB_TD3,
+	 * AVB_RX_CTL, AVB_RXC, AVB_RD0,
+	 * AVB_RD1, AVB_RD2, AVB_RD3,
+	 * AVB_TXCREFCLK
+	 */
+	PIN_NUMBER('A', 8), PIN_NUMBER('A', 19), PIN_NUMBER('A', 18),
+	PIN_NUMBER('B', 18), PIN_NUMBER('A', 17), PIN_NUMBER('B', 17),
+	PIN_NUMBER('A', 16), PIN_NUMBER('B', 19), PIN_NUMBER('A', 13),
+	PIN_NUMBER('B', 13), PIN_NUMBER('A', 14), PIN_NUMBER('B', 14),
+	PIN_NUMBER('A', 12),
+
+};
+static const unsigned int avb_mii_mux[] = {
+	AVB_TX_CTL_MARK, AVB_TXC_MARK, AVB_TD0_MARK,
+	AVB_TD1_MARK, AVB_TD2_MARK, AVB_TD3_MARK,
+	AVB_RX_CTL_MARK, AVB_RXC_MARK, AVB_RD0_MARK,
+	AVB_RD1_MARK, AVB_RD2_MARK, AVB_RD3_MARK,
+	AVB_TXCREFCLK_MARK,
+};
+static const unsigned int avb_avtp_pps_pins[] = {
+	/* AVB_AVTP_PPS */
+	RCAR_GP_PIN(2, 6),
+};
+static const unsigned int avb_avtp_pps_mux[] = {
+	AVB_AVTP_PPS_MARK,
+};
+static const unsigned int avb_avtp_match_a_pins[] = {
+	/* AVB_AVTP_MATCH_A */
+	RCAR_GP_PIN(2, 13),
+};
+static const unsigned int avb_avtp_match_a_mux[] = {
+	AVB_AVTP_MATCH_A_MARK,
+};
+static const unsigned int avb_avtp_capture_a_pins[] = {
+	/* AVB_AVTP_CAPTURE_A */
+	RCAR_GP_PIN(2, 14),
+};
+static const unsigned int avb_avtp_capture_a_mux[] = {
+	AVB_AVTP_CAPTURE_A_MARK,
+};
+static const unsigned int avb_avtp_match_b_pins[] = {
+	/*  AVB_AVTP_MATCH_B */
+	RCAR_GP_PIN(1, 8),
+};
+static const unsigned int avb_avtp_match_b_mux[] = {
+	AVB_AVTP_MATCH_B_MARK,
+};
+static const unsigned int avb_avtp_capture_b_pins[] = {
+	/* AVB_AVTP_CAPTURE_B */
+	RCAR_GP_PIN(1, 11),
+};
+static const unsigned int avb_avtp_capture_b_mux[] = {
+	AVB_AVTP_CAPTURE_B_MARK,
+};
 /* - SCIF0 ------------------------------------------------------------------ */
 static const unsigned int scif0_data_pins[] = {
 	/* RX, TX */
@@ -1789,6 +1875,16 @@ static const unsigned int scif_clk_b_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(avb_link),
+	SH_PFC_PIN_GROUP(avb_magic),
+	SH_PFC_PIN_GROUP(avb_phy_int),
+	SH_PFC_PIN_GROUP(avb_mdc),
+	SH_PFC_PIN_GROUP(avb_mii),
+	SH_PFC_PIN_GROUP(avb_avtp_pps),
+	SH_PFC_PIN_GROUP(avb_avtp_match_a),
+	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
+	SH_PFC_PIN_GROUP(avb_avtp_match_b),
+	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_ctrl),
@@ -1820,6 +1916,19 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif_clk_b),
 };
 
+static const char * const avb_groups[] = {
+	"avb_link",
+	"avb_magic",
+	"avb_phy_int",
+	"avb_mdc",
+	"avb_mii",
+	"avb_avtp_pps",
+	"avb_avtp_match_a",
+	"avb_avtp_capture_a",
+	"avb_avtp_match_b",
+	"avb_avtp_capture_b",
+};
+
 static const char * const scif0_groups[] = {
 	"scif0_data",
 	"scif0_clk",
@@ -1870,6 +1979,7 @@ static const char * const scif_clk_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(avb),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
 	SH_PFC_FUNCTION(scif2),
-- 
2.7.4

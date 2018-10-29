Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0EC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8B620870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8B620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeJ3DDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:03:50 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58241 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbeJ3DDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:03:49 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id EE4E54000C;
        Mon, 29 Oct 2018 18:13:59 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert+renesas@glider.be, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, linus.walleij@linaro.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: sh-pfc: r8a77965: Add VIN[4|5] groups/functions
Date:   Mon, 29 Oct 2018 19:13:44 +0100
Message-Id: <1540836824-4636-3-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VIN4 and VIN5 interfaces supports parallel video input.
Add pin, mux and functions definitions for VIN4 and VIN5 for R-Car M3-N.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c | 254 ++++++++++++++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index dfdd982..1aca4b0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -3725,6 +3725,216 @@ static const unsigned int usb30_mux[] = {
 	USB30_PWEN_MARK, USB30_OVC_MARK,
 };
 
+/* - VIN4 ------------------------------------------------------------------- */
+static const unsigned int vin4_data18_a_pins[] = {
+	RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
+	RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+	RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+	RCAR_GP_PIN(1, 2),  RCAR_GP_PIN(1, 3),
+	RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 7),
+	RCAR_GP_PIN(0, 2),  RCAR_GP_PIN(0, 3),
+	RCAR_GP_PIN(0, 4),  RCAR_GP_PIN(0, 5),
+	RCAR_GP_PIN(0, 6),  RCAR_GP_PIN(0, 7),
+};
+
+static const unsigned int vin4_data18_a_mux[] = {
+	VI4_DATA2_A_MARK, VI4_DATA3_A_MARK,
+	VI4_DATA4_A_MARK, VI4_DATA5_A_MARK,
+	VI4_DATA6_A_MARK, VI4_DATA7_A_MARK,
+	VI4_DATA10_MARK,  VI4_DATA11_MARK,
+	VI4_DATA12_MARK,  VI4_DATA13_MARK,
+	VI4_DATA14_MARK,  VI4_DATA15_MARK,
+	VI4_DATA18_MARK,  VI4_DATA19_MARK,
+	VI4_DATA20_MARK,  VI4_DATA21_MARK,
+	VI4_DATA22_MARK,  VI4_DATA23_MARK,
+};
+
+static const union vin_data vin4_data_a_pins = {
+	.data24 = {
+		RCAR_GP_PIN(0, 8),  RCAR_GP_PIN(0, 9),
+		RCAR_GP_PIN(0, 10), RCAR_GP_PIN(0, 11),
+		RCAR_GP_PIN(0, 12), RCAR_GP_PIN(0, 13),
+		RCAR_GP_PIN(0, 14), RCAR_GP_PIN(0, 15),
+		RCAR_GP_PIN(1, 0),  RCAR_GP_PIN(1, 1),
+		RCAR_GP_PIN(1, 2),  RCAR_GP_PIN(1, 3),
+		RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 7),
+		RCAR_GP_PIN(0, 0),  RCAR_GP_PIN(0, 1),
+		RCAR_GP_PIN(0, 2),  RCAR_GP_PIN(0, 3),
+		RCAR_GP_PIN(0, 4),  RCAR_GP_PIN(0, 5),
+		RCAR_GP_PIN(0, 6),  RCAR_GP_PIN(0, 7),
+	},
+};
+
+static const union vin_data vin4_data_a_mux = {
+	.data24 = {
+		VI4_DATA0_A_MARK, VI4_DATA1_A_MARK,
+		VI4_DATA2_A_MARK, VI4_DATA3_A_MARK,
+		VI4_DATA4_A_MARK, VI4_DATA5_A_MARK,
+		VI4_DATA6_A_MARK, VI4_DATA7_A_MARK,
+		VI4_DATA8_MARK,   VI4_DATA9_MARK,
+		VI4_DATA10_MARK,  VI4_DATA11_MARK,
+		VI4_DATA12_MARK,  VI4_DATA13_MARK,
+		VI4_DATA14_MARK,  VI4_DATA15_MARK,
+		VI4_DATA16_MARK,  VI4_DATA17_MARK,
+		VI4_DATA18_MARK,  VI4_DATA19_MARK,
+		VI4_DATA20_MARK,  VI4_DATA21_MARK,
+		VI4_DATA22_MARK,  VI4_DATA23_MARK,
+	},
+};
+
+static const unsigned int vin4_data18_b_pins[] = {
+	RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
+	RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5),
+	RCAR_GP_PIN(2, 6), RCAR_GP_PIN(2, 7),
+	RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 3),
+	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+	RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+	RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+	RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+};
+
+static const unsigned int vin4_data18_b_mux[] = {
+	VI4_DATA2_B_MARK, VI4_DATA3_B_MARK,
+	VI4_DATA4_B_MARK, VI4_DATA5_B_MARK,
+	VI4_DATA6_B_MARK, VI4_DATA7_B_MARK,
+	VI4_DATA10_MARK,  VI4_DATA11_MARK,
+	VI4_DATA12_MARK,  VI4_DATA13_MARK,
+	VI4_DATA14_MARK,  VI4_DATA15_MARK,
+	VI4_DATA18_MARK,  VI4_DATA19_MARK,
+	VI4_DATA20_MARK,  VI4_DATA21_MARK,
+	VI4_DATA22_MARK,  VI4_DATA23_MARK,
+};
+
+static const union vin_data vin4_data_b_pins = {
+	.data24 = {
+		RCAR_GP_PIN(2, 0), RCAR_GP_PIN(2, 1),
+		RCAR_GP_PIN(2, 2), RCAR_GP_PIN(2, 3),
+		RCAR_GP_PIN(2, 4), RCAR_GP_PIN(2, 5),
+		RCAR_GP_PIN(2, 6), RCAR_GP_PIN(2, 7),
+		RCAR_GP_PIN(1, 0), RCAR_GP_PIN(1, 1),
+		RCAR_GP_PIN(1, 2), RCAR_GP_PIN(1, 3),
+		RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
+		RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+		RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+		RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+		RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+	},
+};
+
+static const union vin_data vin4_data_b_mux = {
+	.data24 = {
+		VI4_DATA0_B_MARK, VI4_DATA1_B_MARK,
+		VI4_DATA2_B_MARK, VI4_DATA3_B_MARK,
+		VI4_DATA4_B_MARK, VI4_DATA5_B_MARK,
+		VI4_DATA6_B_MARK, VI4_DATA7_B_MARK,
+		VI4_DATA8_MARK,   VI4_DATA9_MARK,
+		VI4_DATA10_MARK,  VI4_DATA11_MARK,
+		VI4_DATA12_MARK,  VI4_DATA13_MARK,
+		VI4_DATA14_MARK,  VI4_DATA15_MARK,
+		VI4_DATA16_MARK,  VI4_DATA17_MARK,
+		VI4_DATA18_MARK,  VI4_DATA19_MARK,
+		VI4_DATA20_MARK,  VI4_DATA21_MARK,
+		VI4_DATA22_MARK,  VI4_DATA23_MARK,
+	},
+};
+
+static const unsigned int vin4_sync_pins[] = {
+	/* VSYNC_N, HSYNC_N */
+	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 18),
+};
+
+static const unsigned int vin4_sync_mux[] = {
+	VI4_HSYNC_N_MARK, VI4_VSYNC_N_MARK,
+};
+
+static const unsigned int vin4_field_pins[] = {
+	RCAR_GP_PIN(1, 16),
+};
+
+static const unsigned int vin4_field_mux[] = {
+	VI4_FIELD_MARK,
+};
+
+static const unsigned int vin4_clkenb_pins[] = {
+	RCAR_GP_PIN(1, 19),
+};
+
+static const unsigned int vin4_clkenb_mux[] = {
+	VI4_CLKENB_MARK,
+};
+
+static const unsigned int vin4_clk_pins[] = {
+	RCAR_GP_PIN(1, 27),
+};
+
+static const unsigned int vin4_clk_mux[] = {
+	VI4_CLK_MARK,
+};
+
+/* - VIN5 ------------------------------------------------------------------- */
+static const union vin_data vin5_data_pins = {
+	.data16 = {
+		RCAR_GP_PIN(0, 0), RCAR_GP_PIN(0, 1),
+		RCAR_GP_PIN(0, 2), RCAR_GP_PIN(0, 3),
+		RCAR_GP_PIN(0, 4), RCAR_GP_PIN(0, 5),
+		RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
+		RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
+		RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 15),
+		RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 5),
+		RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 7),
+	},
+};
+
+static const union vin_data vin5_data_mux = {
+	.data16 = {
+		VI5_DATA0_MARK, VI5_DATA1_MARK,
+		VI5_DATA2_MARK, VI5_DATA3_MARK,
+		VI5_DATA4_MARK, VI5_DATA5_MARK,
+		VI5_DATA6_MARK, VI5_DATA7_MARK,
+		VI5_DATA8_MARK,  VI5_DATA9_MARK,
+		VI5_DATA10_MARK, VI5_DATA11_MARK,
+		VI5_DATA12_MARK, VI5_DATA13_MARK,
+		VI5_DATA14_MARK, VI5_DATA15_MARK,
+	},
+};
+
+static const unsigned int vin5_sync_pins[] = {
+	/* VSYNC_N, HSYNC_N */
+	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 10),
+};
+
+static const unsigned int vin5_sync_mux[] = {
+	VI5_HSYNC_N_MARK, VI5_VSYNC_N_MARK,
+};
+
+static const unsigned int vin5_field_pins[] = {
+	RCAR_GP_PIN(1, 11),
+};
+
+static const unsigned int vin5_field_mux[] = {
+	VI5_FIELD_MARK,
+};
+
+static const unsigned int vin5_clkenb_pins[] = {
+	RCAR_GP_PIN(1, 20),
+};
+
+static const unsigned int vin5_clkenb_mux[] = {
+	VI5_CLKENB_MARK,
+};
+
+static const unsigned int vin5_clk_pins[] = {
+	RCAR_GP_PIN(1, 21),
+};
+
+static const unsigned int vin5_clk_mux[] = {
+	VI5_CLK_MARK,
+};
+
 static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(audio_clk_a_a),
 	SH_PFC_PIN_GROUP(audio_clk_a_b),
@@ -4000,6 +4210,24 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(usb0),
 	SH_PFC_PIN_GROUP(usb1),
 	SH_PFC_PIN_GROUP(usb30),
+	VIN_DATA_PIN_GROUP_VER(vin4_data, a, 8),
+	VIN_DATA_PIN_GROUP_VER(vin4_data, a, 16),
+	SH_PFC_PIN_GROUP(vin4_data18_a),
+	VIN_DATA_PIN_GROUP_VER(vin4_data, a, 24),
+	VIN_DATA_PIN_GROUP_VER(vin4_data, b, 8),
+	VIN_DATA_PIN_GROUP_VER(vin4_data, b, 16),
+	SH_PFC_PIN_GROUP(vin4_data18_b),
+	VIN_DATA_PIN_GROUP_VER(vin4_data, b, 24),
+	SH_PFC_PIN_GROUP(vin4_sync),
+	SH_PFC_PIN_GROUP(vin4_field),
+	SH_PFC_PIN_GROUP(vin4_clkenb),
+	SH_PFC_PIN_GROUP(vin4_clk),
+	VIN_DATA_PIN_GROUP(vin5_data, 8),
+	VIN_DATA_PIN_GROUP(vin5_data, 16),
+	SH_PFC_PIN_GROUP(vin5_sync),
+	SH_PFC_PIN_GROUP(vin5_field),
+	SH_PFC_PIN_GROUP(vin5_clkenb),
+	SH_PFC_PIN_GROUP(vin5_clk),
 };
 
 static const char * const audio_clk_groups[] = {
@@ -4392,6 +4620,30 @@ static const char * const usb30_groups[] = {
 	"usb30",
 };
 
+static const char * const vin4_groups[] = {
+	"vin4_data8_a",
+	"vin4_data16_a",
+	"vin4_data18_a",
+	"vin4_data24_a",
+	"vin4_data8_b",
+	"vin4_data16_b",
+	"vin4_data18_b",
+	"vin4_data24_b",
+	"vin4_sync",
+	"vin4_field",
+	"vin4_clkenb",
+	"vin4_clk",
+};
+
+static const char * const vin5_groups[] = {
+	"vin5_data8",
+	"vin5_data16",
+	"vin5_sync",
+	"vin5_field",
+	"vin5_clkenb",
+	"vin5_clk",
+};
+
 static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(audio_clk),
 	SH_PFC_FUNCTION(avb),
@@ -4432,6 +4684,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(usb0),
 	SH_PFC_FUNCTION(usb1),
 	SH_PFC_FUNCTION(usb30),
+	SH_PFC_FUNCTION(vin4),
+	SH_PFC_FUNCTION(vin5),
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-- 
2.7.4


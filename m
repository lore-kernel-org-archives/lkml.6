Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeBIJsg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:48:36 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36627 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBIJsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:48:32 -0500
X-Google-Smtp-Source: AH8x2277T4nZlQ1+fPDsNoXhAyhrv/rBvYq4kizPgNVslo9WI0i+aNrXndbT4gmrIAE+oLvAMwiW7A==
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 2/2] clk: sprd: add RTC gate for SC9860
Date: Fri,  9 Feb 2018 17:48:11 +0800
Message-Id: <1518169691-14870-2-git-send-email-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518169691-14870-1-git-send-email-zhang.lyra@gmail.com>
References: <1518169691-14870-1-git-send-email-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

Add a few gate clocks which are used for gating RTC for some
devices on AON area of SC9860.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/sc9860-clk.c | 76 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/clk/sprd/sc9860-clk.c b/drivers/clk/sprd/sc9860-clk.c
index ed5c027..9980ab5 100644
--- a/drivers/clk/sprd/sc9860-clk.c
+++ b/drivers/clk/sprd/sc9860-clk.c
@@ -959,6 +959,44 @@ static SPRD_SC_GATE_CLK(sdio2_2x_en,	"sdio2-2x-en",	"aon-apb", 0x13c,
 			       0x1000, BIT(6), 0, 0);
 static SPRD_SC_GATE_CLK(emmc_2x_en,	"emmc-2x-en",	"aon-apb", 0x13c,
 			       0x1000, BIT(9), 0, 0);
+static SPRD_SC_GATE_CLK(arch_rtc_eb, "arch-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(0), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(kpb_rtc_eb, "kpb-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(1), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(aon_syst_rtc_eb, "aon-syst-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(2), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(ap_syst_rtc_eb, "ap-syst-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(3), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(aon_tmr_rtc_eb, "aon-tmr-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(4), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(ap_tmr0_rtc_eb, "ap-tmr0-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(5), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(eic_rtc_eb, "eic-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(6), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(eic_rtcdv5_eb, "eic-rtcdv5-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(7), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(ap_wdg_rtc_eb, "ap-wdg-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(9), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(ap_tmr1_rtc_eb, "ap-tmr1-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(15), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(ap_tmr2_rtc_eb, "ap-tmr2-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(16), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(dcxo_tmr_rtc_eb, "dcxo-tmr-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(17), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(bb_cal_rtc_eb, "bb-cal-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(18), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(avs_big_rtc_eb, "avs-big-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(20), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(avs_lit_rtc_eb, "avs-lit-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(21), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(avs_gpu0_rtc_eb, "avs-gpu0-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(22), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(avs_gpu1_rtc_eb, "avs-gpu1-rtc-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(23), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(gpu_ts_eb, "gpu-ts-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(24), CLK_IGNORE_UNUSED, 0);
+static SPRD_SC_GATE_CLK(rtcdv10_eb, "rtcdv10-eb",	"aon-apb", 0x10,
+		     0x1000, BIT(27), CLK_IGNORE_UNUSED, 0);
 
 static struct sprd_clk_common *sc9860_aon_gate[] = {
 	/* address base is 0x402e0000 */
@@ -1030,6 +1068,25 @@ static struct sprd_clk_common *sc9860_aon_gate[] = {
 	&sdio1_2x_en.common,
 	&sdio2_2x_en.common,
 	&emmc_2x_en.common,
+	&arch_rtc_eb.common,
+	&kpb_rtc_eb.common,
+	&aon_syst_rtc_eb.common,
+	&ap_syst_rtc_eb.common,
+	&aon_tmr_rtc_eb.common,
+	&ap_tmr0_rtc_eb.common,
+	&eic_rtc_eb.common,
+	&eic_rtcdv5_eb.common,
+	&ap_wdg_rtc_eb.common,
+	&ap_tmr1_rtc_eb.common,
+	&ap_tmr2_rtc_eb.common,
+	&dcxo_tmr_rtc_eb.common,
+	&bb_cal_rtc_eb.common,
+	&avs_big_rtc_eb.common,
+	&avs_lit_rtc_eb.common,
+	&avs_gpu0_rtc_eb.common,
+	&avs_gpu1_rtc_eb.common,
+	&gpu_ts_eb.common,
+	&rtcdv10_eb.common,
 };
 
 static struct clk_hw_onecell_data sc9860_aon_gate_hws = {
@@ -1102,6 +1159,25 @@ static struct clk_hw_onecell_data sc9860_aon_gate_hws = {
 		[CLK_SDIO1_2X_EN]	= &sdio1_2x_en.common.hw,
 		[CLK_SDIO2_2X_EN]	= &sdio2_2x_en.common.hw,
 		[CLK_EMMC_2X_EN]	= &emmc_2x_en.common.hw,
+		[CLK_ARCH_RTC_EB]	= &arch_rtc_eb.common.hw,
+		[CLK_KPB_RTC_EB]	= &kpb_rtc_eb.common.hw,
+		[CLK_AON_SYST_RTC_EB]	= &aon_syst_rtc_eb.common.hw,
+		[CLK_AP_SYST_RTC_EB]	= &ap_syst_rtc_eb.common.hw,
+		[CLK_AON_TMR_RTC_EB]	= &aon_tmr_rtc_eb.common.hw,
+		[CLK_AP_TMR0_RTC_EB]	= &ap_tmr0_rtc_eb.common.hw,
+		[CLK_EIC_RTC_EB]	= &eic_rtc_eb.common.hw,
+		[CLK_EIC_RTCDV5_EB]	= &eic_rtcdv5_eb.common.hw,
+		[CLK_AP_WDG_RTC_EB]	= &ap_wdg_rtc_eb.common.hw,
+		[CLK_AP_TMR1_RTC_EB]	= &ap_tmr1_rtc_eb.common.hw,
+		[CLK_AP_TMR2_RTC_EB]	= &ap_tmr2_rtc_eb.common.hw,
+		[CLK_DCXO_TMR_RTC_EB]	= &dcxo_tmr_rtc_eb.common.hw,
+		[CLK_BB_CAL_RTC_EB]	= &bb_cal_rtc_eb.common.hw,
+		[CLK_AVS_BIG_RTC_EB]	= &avs_big_rtc_eb.common.hw,
+		[CLK_AVS_LIT_RTC_EB]	= &avs_lit_rtc_eb.common.hw,
+		[CLK_AVS_GPU0_RTC_EB]	= &avs_gpu0_rtc_eb.common.hw,
+		[CLK_AVS_GPU1_RTC_EB]	= &avs_gpu1_rtc_eb.common.hw,
+		[CLK_GPU_TS_EB]		= &gpu_ts_eb.common.hw,
+		[CLK_RTCDV10_EB]	= &rtcdv10_eb.common.hw,
 	},
 	.num	= CLK_AON_GATE_NUM,
 };
-- 
2.7.4

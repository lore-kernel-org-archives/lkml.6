Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7E4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13172083A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChWCXAVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13172083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeIYWn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:43:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40813 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeIYWn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:43:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so4371215ljr.7;
        Tue, 25 Sep 2018 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GW4GA4N4o/YtFKYWG76KdnB2ZCIvAhYRe9ar/m4lvtg=;
        b=ChWCXAVGnlffza7E6PeRObGnFcaHnEWhRdxf6eYr8BDWFa6HQQr6QMveIJNxBRfCNG
         sW1xpA14lKNClF114hjwDgbSyvtrD/toSfo2GTGvkqg3NQSE4jrnBs5nLhoBB3ENWOsL
         hAHg/Ha4/t/SfEpxvc4TZJ3tp6x34+1F2Cq7fFeXw8rbnUFxz9scMH7GjaRXFZeTCwnp
         o7w49k8dwlpZxsi9B4hQ1tkioCZvrWkKClQj1BN56cVA8vta6cRAAWwVoMtcthNSVFfl
         5klrdEzw1eX/LX6FbFSTQR2bsHo40ftSJlJLK0uw8+17HHQ8pPm/NnE1OmqtJdKKb5f9
         XVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GW4GA4N4o/YtFKYWG76KdnB2ZCIvAhYRe9ar/m4lvtg=;
        b=PQK+zmyp4cuatFuw8zHWepmCBPHLS+WH0Gv0+7fFbFJxh+axu5wTBxNSvPMcw2Vm2B
         K2CelvPEVJqixUjxtj2ZuAQ9ogoqArrJZpa44E2bYgOntJUPrGwmsjn4w9k23kTUGcH1
         algaB8BM5crIqYlTLscwqYpFaq9C7ONv2P1IJjjUp1Gh4BrHSBRQP0Z6isGwT2XnfR4B
         jSRQRBN1216zNwOfZy1/s5cQjTo3HKRePLF4q5UZQfzhdfF8hqdjHm1YV9lVDN4fANb0
         +r+pO15zCrEdWzy9HXp5hGYu627K8Ofdt7Qy1cIRM0W0YkuYS8ulTeH/KuA2mp4NIS5e
         E8iA==
X-Gm-Message-State: ABuFfoiJAu2NAOIDoxlKaKokVStPcC6+WVRpc5cZGLW4+JLHNTZ4dcO3
        oK/PeG8VT5WUwkscXysmVg==
X-Google-Smtp-Source: ACcGV63n7vUkN1Bgd34y2T1JgNbCqk7PPJmQEGY185KjMGMLJFOGZP2/tVMz8od+dSnRjaf434R4eg==
X-Received: by 2002:a2e:6c07:: with SMTP id h7-v6mr1467577ljc.81.1537893331584;
        Tue, 25 Sep 2018 09:35:31 -0700 (PDT)
Received: from localhost.localdomain (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.googlemail.com with ESMTPSA id m8-v6sm496324ljj.10.2018.09.25.09.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 09:35:30 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v2] clk: qcom: Add Global Clock controller (GCC) driver for SDM660
Date:   Tue, 25 Sep 2018 17:35:11 +0100
Message-Id: <20180925163516.12425-1-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810202123.29238-1-ctatlor97@gmail.com>
References: <20180810202123.29238-1-ctatlor97@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

Add support for the global clock controller found on SDM660
based devices. This should allow most non-multimedia device
drivers to probe and control their clocks.
Based on CAF implementation.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
[craig: rename parents to fit upstream, and other cleanups]
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 .../devicetree/bindings/clock/qcom,gcc.txt    |    1 +
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sdm660.c                 | 2479 +++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sdm660.h   |  159 ++
 5 files changed, 2649 insertions(+)
 create mode 100644 drivers/clk/qcom/gcc-sdm660.c
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdm660.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 664ea1fd6c76..e498ad2e8db8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -19,6 +19,7 @@ Required properties :
 			"qcom,gcc-msm8996"
 			"qcom,gcc-msm8998"
 			"qcom,gcc-mdm9615"
+			"qcom,gcc-sdm660"
 			"qcom,gcc-sdm845"
 
 - reg : shall contain base register location and length
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 5b181b182f40..4d478b261dfe 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -243,6 +243,15 @@ config SDM_CAMCC_845
 	  Support for the camera clock controller on SDM845 devices.
 	  Say Y if you want to support camera devices and camera functionality.
 
+config SDM_GCC_660
+	tristate "SDM660 Global Clock Controller"
+	select QCOM_GDSC
+	depends on COMMON_CLK_QCOM
+	help
+	  Support for the global clock controller on SDM660 devices.
+	  Say Y if you want to use peripheral devices such as UART, SPI,
+	  i2C, USB, UFS, SDDC, PCIe, etc.
+
 config SDM_GCC_845
 	tristate "SDM845 Global Clock Controller"
 	select QCOM_GDSC
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 935f142bc155..ab892f6d847c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_QCOM_CLK_RPMH) += clk-rpmh.o
 obj-$(CONFIG_QCOM_CLK_SMD_RPM) += clk-smd-rpm.o
 obj-$(CONFIG_SDM_CAMCC_845) += camcc-sdm845.o
 obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
+obj-$(CONFIG_SDM_GCC_660) += gcc-sdm660.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
 obj-$(CONFIG_SDM_VIDEOCC_845) += videocc-sdm845.o
 obj-$(CONFIG_SPMI_PMIC_CLKDIV) += clk-spmi-pmic-div.o
diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
new file mode 100644
index 000000000000..cec8b4145b71
--- /dev/null
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -0,0 +1,2479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2016-2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2018, Craig Tatlor.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/qcom,gcc-sdm660.h>
+
+#include "common.h"
+#include "clk-regmap.h"
+#include "clk-alpha-pll.h"
+#include "clk-rcg.h"
+#include "clk-branch.h"
+#include "reset.h"
+#include "gdsc.h"
+
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+
+enum {
+	P_XO,
+	P_SLEEP_CLK,
+	P_GPLL0,
+	P_GPLL1,
+	P_GPLL4,
+	P_GPLL0_EARLY_DIV,
+	P_GPLL1_EARLY_DIV,
+};
+
+static const struct parent_map gcc_parent_map_xo_gpll0_gpll0_early_div[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 1 },
+	{ P_GPLL0_EARLY_DIV, 6 },
+};
+
+static const char * const gcc_parent_names_xo_gpll0_gpll0_early_div[] = {
+	"xo",
+	"gpll0",
+	"gpll0_early_div",
+};
+
+static const struct parent_map gcc_parent_map_xo_gpll0[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 1 },
+};
+
+static const char * const gcc_parent_names_xo_gpll0[] = {
+	"xo",
+	"gpll0",
+};
+
+static const struct parent_map gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 1 },
+	{ P_SLEEP_CLK, 5 },
+	{ P_GPLL0_EARLY_DIV, 6 },
+};
+
+static const char * const gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div[] = {
+	"xo",
+	"gpll0",
+	"sleep_clk",
+	"gpll0_early_div",
+};
+
+static const struct parent_map gcc_parent_map_xo_sleep_clk[] = {
+	{ P_XO, 0 },
+	{ P_SLEEP_CLK, 5 },
+};
+
+static const char * const gcc_parent_names_xo_sleep_clk[] = {
+	"xo",
+	"sleep_clk",
+};
+
+static const struct parent_map gcc_parent_map_xo_gpll4[] = {
+	{ P_XO, 0 },
+	{ P_GPLL4, 5 },
+};
+
+static const char * const gcc_parent_names_xo_gpll4[] = {
+	"xo",
+	"gpll4",
+};
+
+static const struct parent_map gcc_parent_map_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 1 },
+	{ P_GPLL0_EARLY_DIV, 3 },
+	{ P_GPLL1, 4 },
+	{ P_GPLL4, 5 },
+	{ P_GPLL1_EARLY_DIV, 6 },
+};
+
+static const char * const gcc_parent_names_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div[] = {
+	"xo",
+	"gpll0",
+	"gpll0_early_div",
+	"gpll1",
+	"gpll4",
+	"gpll1_early_div",
+};
+
+static const struct parent_map gcc_parent_map_xo_gpll0_gpll4_gpll0_early_div[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 1 },
+	{ P_GPLL4, 5 },
+	{ P_GPLL0_EARLY_DIV, 6 },
+};
+
+static const char * const gcc_parent_names_xo_gpll0_gpll4_gpll0_early_div[] = {
+	"xo",
+	"gpll0",
+	"gpll4",
+	"gpll0_early_div",
+};
+
+static const struct parent_map gcc_parent_map_xo_gpll0_gpll0_early_div_gpll4[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 1 },
+	{ P_GPLL0_EARLY_DIV, 2 },
+	{ P_GPLL4, 5 },
+};
+
+static const char * const gcc_parent_names_xo_gpll0_gpll0_early_div_gpll4[] = {
+	"xo",
+	"gpll0",
+	"gpll0_early_div",
+	"gpll4",
+};
+
+static struct clk_fixed_factor xo = {
+	.mult = 1,
+	.div = 1,
+	.hw.init = &(struct clk_init_data){
+		.name = "xo",
+		.parent_names = (const char *[]){ "xo_board" },
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static struct clk_alpha_pll gpll0_early = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll0_early",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor gpll0_early_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "gpll0_early_div",
+		.parent_names = (const char *[]){ "gpll0_early" },
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv gpll0 = {
+	.offset = 0x00000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll0",
+		.parent_names = (const char *[]){ "gpll0_early" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+static struct clk_alpha_pll gpll1_early = {
+	.offset = 0x1000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll1_early",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static struct clk_fixed_factor gpll1_early_div = {
+	.mult = 1,
+	.div = 2,
+	.hw.init = &(struct clk_init_data){
+		.name = "gpll1_early_div",
+		.parent_names = (const char *[]){ "gpll1_early" },
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+	},
+};
+
+static struct clk_alpha_pll_postdiv gpll1 = {
+	.offset = 0x1000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpll1",
+		.parent_names = (const char *[]){ "gpll1_early" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+static struct clk_alpha_pll gpll4_early = {
+	.offset = 0x77000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpll4_early",
+			.parent_names = (const char *[]){ "xo" },
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll_postdiv gpll4 = {
+	.offset = 0x77000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr.hw.init = &(struct clk_init_data)
+	{
+		.name = "gpll4",
+		.parent_names = (const char *[]) { "gpll4_early" },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_blsp1_qup1_i2c_apps_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(50000000, P_GPLL0, 12, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 blsp1_qup1_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x19020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup1_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_blsp1_qup1_spi_apps_clk_src[] = {
+	F(960000, P_XO, 10, 1, 2),
+	F(4800000, P_XO, 4, 0, 0),
+	F(9600000, P_XO, 2, 0, 0),
+	F(15000000, P_GPLL0, 10, 1, 4),
+	F(19200000, P_XO, 1, 0, 0),
+	F(25000000, P_GPLL0, 12, 1, 2),
+	F(50000000, P_GPLL0, 12, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 blsp1_qup1_spi_apps_clk_src = {
+	.cmd_rcgr = 0x1900c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup1_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup2_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x1b020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup2_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup2_spi_apps_clk_src = {
+	.cmd_rcgr = 0x1b00c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup2_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup3_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x1d020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup3_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup3_spi_apps_clk_src = {
+	.cmd_rcgr = 0x1d00c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup3_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup4_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x1f020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup4_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_qup4_spi_apps_clk_src = {
+	.cmd_rcgr = 0x1f00c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_qup4_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_blsp1_uart1_apps_clk_src[] = {
+	F(3686400, P_GPLL0, 1, 96, 15625),
+	F(7372800, P_GPLL0, 1, 192, 15625),
+	F(14745600, P_GPLL0, 1, 384, 15625),
+	F(16000000, P_GPLL0, 5, 2, 15),
+	F(19200000, P_XO, 1, 0, 0),
+	F(24000000, P_GPLL0, 5, 1, 5),
+	F(32000000, P_GPLL0, 1, 4, 75),
+	F(40000000, P_GPLL0, 15, 0, 0),
+	F(46400000, P_GPLL0, 1, 29, 375),
+	F(48000000, P_GPLL0, 12.5, 0, 0),
+	F(51200000, P_GPLL0, 1, 32, 375),
+	F(56000000, P_GPLL0, 1, 7, 75),
+	F(58982400, P_GPLL0, 1, 1536, 15625),
+	F(60000000, P_GPLL0, 10, 0, 0),
+	F(63157895, P_GPLL0, 9.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 blsp1_uart1_apps_clk_src = {
+	.cmd_rcgr = 0x1a00c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_uart1_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_uart1_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp1_uart2_apps_clk_src = {
+	.cmd_rcgr = 0x1c00c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_uart1_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp1_uart2_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup1_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x26020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup1_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup1_spi_apps_clk_src = {
+	.cmd_rcgr = 0x2600c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup1_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup2_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x28020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup2_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup2_spi_apps_clk_src = {
+	.cmd_rcgr = 0x2800c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup2_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup3_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x2a020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup3_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup3_spi_apps_clk_src = {
+	.cmd_rcgr = 0x2a00c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup3_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup4_i2c_apps_clk_src = {
+	.cmd_rcgr = 0x2c020,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_i2c_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup4_i2c_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_qup4_spi_apps_clk_src = {
+	.cmd_rcgr = 0x2c00c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_qup1_spi_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_qup4_spi_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_uart1_apps_clk_src = {
+	.cmd_rcgr = 0x2700c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_uart1_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_uart1_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 blsp2_uart2_apps_clk_src = {
+	.cmd_rcgr = 0x2900c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_blsp1_uart1_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "blsp2_uart2_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gp1_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gp1_clk_src = {
+	.cmd_rcgr = 0x64004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div,
+	.freq_tbl = ftbl_gp1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gp1_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gp2_clk_src = {
+	.cmd_rcgr = 0x65004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div,
+	.freq_tbl = ftbl_gp1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gp2_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 gp3_clk_src = {
+	.cmd_rcgr = 0x66004,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_sleep_clk_gpll0_early_div,
+	.freq_tbl = ftbl_gp1_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gp3_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_sleep_clk_gpll0_early_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_hmss_gpll0_clk_src[] = {
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(600000000, P_GPLL0, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 hmss_gpll0_clk_src = {
+	.cmd_rcgr = 0x4805c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_hmss_gpll0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "hmss_gpll0_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_hmss_gpll4_clk_src[] = {
+	F(384000000, P_GPLL4, 4, 0, 0),
+	F(768000000, P_GPLL4, 2, 0, 0),
+	F(1536000000, P_GPLL4, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 hmss_gpll4_clk_src = {
+	.cmd_rcgr = 0x48074,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll4,
+	.freq_tbl = ftbl_hmss_gpll4_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "hmss_gpll4_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll4,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_hmss_rbcpr_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 hmss_rbcpr_clk_src = {
+	.cmd_rcgr = 0x48044,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_hmss_rbcpr_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "hmss_rbcpr_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_pdm2_clk_src[] = {
+	F(60000000, P_GPLL0, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 pdm2_clk_src = {
+	.cmd_rcgr = 0x33010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_pdm2_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pdm2_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_qspi_ser_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(80200000, P_GPLL1_EARLY_DIV, 5, 0, 0),
+	F(160400000, P_GPLL1, 5, 0, 0),
+	F(267333333, P_GPLL1, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 qspi_ser_clk_src = {
+	.cmd_rcgr = 0x4d00c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div,
+	.freq_tbl = ftbl_qspi_ser_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "qspi_ser_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div_gpll1_gpll4_gpll1_early_div,
+		.num_parents = 6,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
+	F(144000, P_XO, 16, 3, 25),
+	F(400000, P_XO, 12, 1, 4),
+	F(20000000, P_GPLL0_EARLY_DIV, 5, 1, 3),
+	F(25000000, P_GPLL0_EARLY_DIV, 6, 1, 2),
+	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(192000000, P_GPLL4, 8, 0, 0),
+	F(384000000, P_GPLL4, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 sdcc1_apps_clk_src = {
+	.cmd_rcgr = 0x1602c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll4_gpll0_early_div,
+	.freq_tbl = ftbl_sdcc1_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "sdcc1_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll4_gpll0_early_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_sdcc1_ice_core_clk_src[] = {
+	F(75000000, P_GPLL0_EARLY_DIV, 4, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 sdcc1_ice_core_clk_src = {
+	.cmd_rcgr = 0x16010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_sdcc1_ice_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "sdcc1_ice_core_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_sdcc2_apps_clk_src[] = {
+	F(144000, P_XO, 16, 3, 25),
+	F(400000, P_XO, 12, 1, 4),
+	F(20000000, P_GPLL0_EARLY_DIV, 5, 1, 3),
+	F(25000000, P_GPLL0_EARLY_DIV, 6, 1, 2),
+	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(192000000, P_GPLL4, 8, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 sdcc2_apps_clk_src = {
+	.cmd_rcgr = 0x14010,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div_gpll4,
+	.freq_tbl = ftbl_sdcc2_apps_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "sdcc2_apps_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div_gpll4,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ufs_axi_clk_src[] = {
+	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(240000000, P_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ufs_axi_clk_src = {
+	.cmd_rcgr = 0x75018,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_ufs_axi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "ufs_axi_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ufs_ice_core_clk_src[] = {
+	F(75000000, P_GPLL0_EARLY_DIV, 4, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ufs_ice_core_clk_src = {
+	.cmd_rcgr = 0x76010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_ufs_ice_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "ufs_ice_core_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 ufs_phy_aux_clk_src = {
+	.cmd_rcgr = 0x76044,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_sleep_clk,
+	.freq_tbl = ftbl_hmss_rbcpr_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "ufs_phy_aux_clk_src",
+		.parent_names = gcc_parent_names_xo_sleep_clk,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_ufs_unipro_core_clk_src[] = {
+	F(37500000, P_GPLL0_EARLY_DIV, 8, 0, 0),
+	F(75000000, P_GPLL0, 8, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ufs_unipro_core_clk_src = {
+	.cmd_rcgr = 0x76028,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_ufs_unipro_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "ufs_unipro_core_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb20_master_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(60000000, P_GPLL0, 10, 0, 0),
+	F(120000000, P_GPLL0, 5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 usb20_master_clk_src = {
+	.cmd_rcgr = 0x2f010,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_usb20_master_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb20_master_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb20_mock_utmi_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(60000000, P_GPLL0, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 usb20_mock_utmi_clk_src = {
+	.cmd_rcgr = 0x2f024,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_usb20_mock_utmi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb20_mock_utmi_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(66666667, P_GPLL0_EARLY_DIV, 4.5, 0, 0),
+	F(120000000, P_GPLL0, 5, 0, 0),
+	F(133333333, P_GPLL0, 4.5, 0, 0),
+	F(150000000, P_GPLL0, 4, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(240000000, P_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 usb30_master_clk_src = {
+	.cmd_rcgr = 0xf014,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_usb30_master_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb30_master_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb30_mock_utmi_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(40000000, P_GPLL0_EARLY_DIV, 7.5, 0, 0),
+	F(60000000, P_GPLL0, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 usb30_mock_utmi_clk_src = {
+	.cmd_rcgr = 0xf028,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_gpll0_gpll0_early_div,
+	.freq_tbl = ftbl_usb30_mock_utmi_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb30_mock_utmi_clk_src",
+		.parent_names = gcc_parent_names_xo_gpll0_gpll0_early_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_usb3_phy_aux_clk_src[] = {
+	F(1200000, P_XO, 16, 0, 0),
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 usb3_phy_aux_clk_src = {
+	.cmd_rcgr = 0x5000c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_xo_sleep_clk,
+	.freq_tbl = ftbl_usb3_phy_aux_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb3_phy_aux_clk_src",
+		.parent_names = gcc_parent_names_xo_sleep_clk,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch gcc_aggre2_ufs_axi_clk = {
+	.halt_reg = 0x75034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x75034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_aggre2_ufs_axi_clk",
+			.parent_names = (const char *[]){
+				"ufs_axi_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_aggre2_usb3_axi_clk = {
+	.halt_reg = 0xf03c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_aggre2_usb3_axi_clk",
+			.parent_names = (const char *[]){
+				"usb30_master_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_bimc_gfx_clk = {
+	.halt_reg = 0x7106c,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x7106c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_bimc_gfx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_bimc_hmss_axi_clk = {
+	.halt_reg = 0x48004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52004,
+		.enable_mask = BIT(22),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_bimc_hmss_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_bimc_mss_q6_axi_clk = {
+	.halt_reg = 0x4401c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4401c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_bimc_mss_q6_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_ahb_clk = {
+	.halt_reg = 0x17004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52004,
+		.enable_mask = BIT(17),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup1_i2c_apps_clk = {
+	.halt_reg = 0x19008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x19008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup1_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup1_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup1_spi_apps_clk = {
+	.halt_reg = 0x19004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x19004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup1_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup1_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup2_i2c_apps_clk = {
+	.halt_reg = 0x1b008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1b008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup2_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup2_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup2_spi_apps_clk = {
+	.halt_reg = 0x1b004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1b004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup2_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup2_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup3_i2c_apps_clk = {
+	.halt_reg = 0x1d008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1d008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup3_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup3_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup3_spi_apps_clk = {
+	.halt_reg = 0x1d004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1d004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup3_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup3_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup4_i2c_apps_clk = {
+	.halt_reg = 0x1f008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1f008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup4_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup4_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_qup4_spi_apps_clk = {
+	.halt_reg = 0x1f004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1f004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_qup4_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_qup4_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_uart1_apps_clk = {
+	.halt_reg = 0x1a004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_uart1_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_uart1_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp1_uart2_apps_clk = {
+	.halt_reg = 0x1c004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1c004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp1_uart2_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp1_uart2_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_ahb_clk = {
+	.halt_reg = 0x25004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52004,
+		.enable_mask = BIT(15),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup1_i2c_apps_clk = {
+	.halt_reg = 0x26008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x26008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup1_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup1_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup1_spi_apps_clk = {
+	.halt_reg = 0x26004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x26004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup1_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup1_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup2_i2c_apps_clk = {
+	.halt_reg = 0x28008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x28008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup2_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup2_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup2_spi_apps_clk = {
+	.halt_reg = 0x28004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x28004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup2_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup2_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup3_i2c_apps_clk = {
+	.halt_reg = 0x2a008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2a008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup3_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup3_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup3_spi_apps_clk = {
+	.halt_reg = 0x2a004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup3_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup3_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup4_i2c_apps_clk = {
+	.halt_reg = 0x2c008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2c008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup4_i2c_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup4_i2c_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_qup4_spi_apps_clk = {
+	.halt_reg = 0x2c004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2c004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_qup4_spi_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_qup4_spi_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_uart1_apps_clk = {
+	.halt_reg = 0x27004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x27004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_uart1_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_uart1_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_blsp2_uart2_apps_clk = {
+	.halt_reg = 0x29004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x29004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_blsp2_uart2_apps_clk",
+			.parent_names = (const char *[]){
+				"blsp2_uart2_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_boot_rom_ahb_clk = {
+	.halt_reg = 0x38004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52004,
+		.enable_mask = BIT(10),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_boot_rom_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cfg_noc_usb2_axi_clk = {
+	.halt_reg = 0x5058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_cfg_noc_usb2_axi_clk",
+			.parent_names = (const char *[]){
+				"usb20_master_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cfg_noc_usb3_axi_clk = {
+	.halt_reg = 0x5018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x5018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_cfg_noc_usb3_axi_clk",
+			.parent_names = (const char *[]){
+				"usb30_master_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_dcc_ahb_clk = {
+	.halt_reg = 0x84004,
+	.clkr = {
+		.enable_reg = 0x84004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_dcc_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp1_clk = {
+	.halt_reg = 0x64000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x64000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gp1_clk",
+			.parent_names = (const char *[]){
+				"gp1_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp2_clk = {
+	.halt_reg = 0x65000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x65000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gp2_clk",
+			.parent_names = (const char *[]){
+				"gp2_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp3_clk = {
+	.halt_reg = 0x66000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x66000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gp3_clk",
+			.parent_names = (const char *[]){
+				"gp3_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gpu_bimc_gfx_clk = {
+	.halt_reg = 0x71010,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x71010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gpu_bimc_gfx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gpu_cfg_ahb_clk = {
+	.halt_reg = 0x71004,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x71004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gpu_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gpu_gpll0_clk = {
+	.halt_reg = 0x5200c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x5200c,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gpu_gpll0_clk",
+			.parent_names = (const char *[]){
+				"gpll0",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gpu_gpll0_div_clk = {
+	.halt_reg = 0x5200c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x5200c,
+		.enable_mask = BIT(3),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_gpu_gpll0_div_clk",
+			.parent_names = (const char *[]){
+				"gpll0_early_div",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_hmss_dvm_bus_clk = {
+	.halt_reg = 0x4808c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4808c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_hmss_dvm_bus_clk",
+			.ops = &clk_branch2_ops,
+			.flags = CLK_IGNORE_UNUSED,
+		},
+	},
+};
+
+static struct clk_branch gcc_hmss_rbcpr_clk = {
+	.halt_reg = 0x48008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x48008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_hmss_rbcpr_clk",
+			.parent_names = (const char *[]){
+				"hmss_rbcpr_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mmss_gpll0_clk = {
+	.halt_reg = 0x5200c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x5200c,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mmss_gpll0_clk",
+			.parent_names = (const char *[]){
+				"gpll0",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mmss_gpll0_div_clk = {
+	.halt_reg = 0x5200c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x5200c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mmss_gpll0_div_clk",
+			.parent_names = (const char *[]){
+				"gpll0_early_div",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mmss_noc_cfg_ahb_clk = {
+	.halt_reg = 0x9004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mmss_noc_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mmss_sys_noc_axi_clk = {
+	.halt_reg = 0x9000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x9000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mmss_sys_noc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_cfg_ahb_clk = {
+	.halt_reg = 0x8a000,
+	.clkr = {
+		.enable_reg = 0x8a000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_mnoc_bimc_axi_clk = {
+	.halt_reg = 0x8a004,
+	.clkr = {
+		.enable_reg = 0x8a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_mnoc_bimc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
+	.halt_reg = 0x8a040,
+	.clkr = {
+		.enable_reg = 0x8a040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_q6_bimc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_mss_snoc_axi_clk = {
+	.halt_reg = 0x8a03c,
+	.clkr = {
+		.enable_reg = 0x8a03c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_mss_snoc_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm2_clk = {
+	.halt_reg = 0x3300c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3300c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pdm2_clk",
+			.parent_names = (const char *[]){
+				"pdm2_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_ahb_clk = {
+	.halt_reg = 0x33004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x33004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_pdm_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_prng_ahb_clk = {
+	.halt_reg = 0x34004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52004,
+		.enable_mask = BIT(13),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_prng_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qspi_ahb_clk = {
+	.halt_reg = 0x4d004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_qspi_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qspi_ser_clk = {
+	.halt_reg = 0x4d008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x4d008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_qspi_ser_clk",
+			.parent_names = (const char *[]){
+				"qspi_ser_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_rx0_usb2_clkref_clk = {
+	.halt_reg = 0x88018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x88018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_rx0_usb2_clkref_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_rx1_usb2_clkref_clk = {
+	.halt_reg = 0x88014,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x88014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_rx1_usb2_clkref_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_ahb_clk = {
+	.halt_reg = 0x16008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x16008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc1_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_apps_clk = {
+	.halt_reg = 0x16004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x16004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc1_apps_clk",
+			.parent_names = (const char *[]){
+				"sdcc1_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc1_ice_core_clk = {
+	.halt_reg = 0x1600c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1600c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc1_ice_core_clk",
+			.parent_names = (const char *[]){
+				"sdcc1_ice_core_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc2_ahb_clk = {
+	.halt_reg = 0x14008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x14008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc2_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc2_apps_clk = {
+	.halt_reg = 0x14004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x14004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_sdcc2_apps_clk",
+			.parent_names = (const char *[]){
+				"sdcc2_apps_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_ahb_clk = {
+	.halt_reg = 0x7500c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7500c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_axi_clk = {
+	.halt_reg = 0x75008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x75008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_axi_clk",
+			.parent_names = (const char *[]){
+				"ufs_axi_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_clkref_clk = {
+	.halt_reg = 0x88008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x88008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_clkref_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_ice_core_clk = {
+	.halt_reg = 0x7600c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7600c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_ice_core_clk",
+			.parent_names = (const char *[]){
+				"ufs_ice_core_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_aux_clk = {
+	.halt_reg = 0x76040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x76040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_phy_aux_clk",
+			.parent_names = (const char *[]){
+				"ufs_phy_aux_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_rx_symbol_0_clk = {
+	.halt_reg = 0x75014,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x75014,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_rx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_rx_symbol_1_clk = {
+	.halt_reg = 0x7605c,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x7605c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_rx_symbol_1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_tx_symbol_0_clk = {
+	.halt_reg = 0x75010,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x75010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_tx_symbol_0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_unipro_core_clk = {
+	.halt_reg = 0x76008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x76008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_ufs_unipro_core_clk",
+			.parent_names = (const char *[]){
+				"ufs_unipro_core_clk_src",
+			},
+			.flags = CLK_SET_RATE_PARENT,
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb20_master_clk = {
+	.halt_reg = 0x2f004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2f004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb20_master_clk",
+			.parent_names = (const char *[]){
+				"usb20_master_clk_src"
+			},
+			.flags = CLK_SET_RATE_PARENT,
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb20_mock_utmi_clk = {
+	.halt_reg = 0x2f00c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2f00c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb20_mock_utmi_clk",
+			.parent_names = (const char *[]){
+				"usb20_mock_utmi_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb20_sleep_clk = {
+	.halt_reg = 0x2f008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2f008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb20_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_master_clk = {
+	.halt_reg = 0xf008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb30_master_clk",
+			.parent_names = (const char *[]){
+				"usb30_master_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_mock_utmi_clk = {
+	.halt_reg = 0xf010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb30_mock_utmi_clk",
+			.parent_names = (const char *[]){
+				"usb30_mock_utmi_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_sleep_clk = {
+	.halt_reg = 0xf00c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xf00c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb30_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_clkref_clk = {
+	.halt_reg = 0x8800c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8800c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_clkref_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_phy_aux_clk = {
+	.halt_reg = 0x50000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x50000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_phy_aux_clk",
+			.parent_names = (const char *[]){
+				"usb3_phy_aux_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_phy_pipe_clk = {
+	.halt_reg = 0x50004,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x50004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_phy_pipe_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
+	.halt_reg = 0x6a004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6a004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb_phy_cfg_ahb2phy_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc ufs_gdsc = {
+	.gdscr = 0x75004,
+	.gds_hw_ctrl = 0x0,
+	.pd = {
+		.name = "ufs_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc usb_30_gdsc = {
+	.gdscr = 0xf004,
+	.gds_hw_ctrl = 0x0,
+	.pd = {
+		.name = "usb_30_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct gdsc pcie_0_gdsc = {
+	.gdscr = 0x6b004,
+	.gds_hw_ctrl = 0x0,
+	.pd = {
+		.name = "pcie_0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE,
+};
+
+static struct clk_hw *gcc_sdm660_hws[] = {
+	[GCC_XO] = &xo.hw,
+	[GCC_GPLL0_EARLY_DIV] = &gpll0_early_div.hw,
+	[GCC_GPLL1_EARLY_DIV] = &gpll1_early_div.hw,
+};
+
+static struct clk_regmap *gcc_660_clocks[] = {
+	[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP1_SPI_APPS_CLK_SRC] = &blsp1_qup1_spi_apps_clk_src.clkr,
+	[BLSP1_QUP2_I2C_APPS_CLK_SRC] = &blsp1_qup2_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP2_SPI_APPS_CLK_SRC] = &blsp1_qup2_spi_apps_clk_src.clkr,
+	[BLSP1_QUP3_I2C_APPS_CLK_SRC] = &blsp1_qup3_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP3_SPI_APPS_CLK_SRC] = &blsp1_qup3_spi_apps_clk_src.clkr,
+	[BLSP1_QUP4_I2C_APPS_CLK_SRC] = &blsp1_qup4_i2c_apps_clk_src.clkr,
+	[BLSP1_QUP4_SPI_APPS_CLK_SRC] = &blsp1_qup4_spi_apps_clk_src.clkr,
+	[BLSP1_UART1_APPS_CLK_SRC] = &blsp1_uart1_apps_clk_src.clkr,
+	[BLSP1_UART2_APPS_CLK_SRC] = &blsp1_uart2_apps_clk_src.clkr,
+	[BLSP2_QUP1_I2C_APPS_CLK_SRC] = &blsp2_qup1_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP1_SPI_APPS_CLK_SRC] = &blsp2_qup1_spi_apps_clk_src.clkr,
+	[BLSP2_QUP2_I2C_APPS_CLK_SRC] = &blsp2_qup2_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP2_SPI_APPS_CLK_SRC] = &blsp2_qup2_spi_apps_clk_src.clkr,
+	[BLSP2_QUP3_I2C_APPS_CLK_SRC] = &blsp2_qup3_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP3_SPI_APPS_CLK_SRC] = &blsp2_qup3_spi_apps_clk_src.clkr,
+	[BLSP2_QUP4_I2C_APPS_CLK_SRC] = &blsp2_qup4_i2c_apps_clk_src.clkr,
+	[BLSP2_QUP4_SPI_APPS_CLK_SRC] = &blsp2_qup4_spi_apps_clk_src.clkr,
+	[BLSP2_UART1_APPS_CLK_SRC] = &blsp2_uart1_apps_clk_src.clkr,
+	[BLSP2_UART2_APPS_CLK_SRC] = &blsp2_uart2_apps_clk_src.clkr,
+	[GCC_AGGRE2_UFS_AXI_CLK] = &gcc_aggre2_ufs_axi_clk.clkr,
+	[GCC_AGGRE2_USB3_AXI_CLK] = &gcc_aggre2_usb3_axi_clk.clkr,
+	[GCC_BIMC_GFX_CLK] = &gcc_bimc_gfx_clk.clkr,
+	[GCC_BIMC_HMSS_AXI_CLK] = &gcc_bimc_hmss_axi_clk.clkr,
+	[GCC_BIMC_MSS_Q6_AXI_CLK] = &gcc_bimc_mss_q6_axi_clk.clkr,
+	[GCC_BLSP1_AHB_CLK] = &gcc_blsp1_ahb_clk.clkr,
+	[GCC_BLSP1_QUP1_I2C_APPS_CLK] = &gcc_blsp1_qup1_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP1_SPI_APPS_CLK] = &gcc_blsp1_qup1_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP2_I2C_APPS_CLK] = &gcc_blsp1_qup2_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP2_SPI_APPS_CLK] = &gcc_blsp1_qup2_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP3_I2C_APPS_CLK] = &gcc_blsp1_qup3_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP3_SPI_APPS_CLK] = &gcc_blsp1_qup3_spi_apps_clk.clkr,
+	[GCC_BLSP1_QUP4_I2C_APPS_CLK] = &gcc_blsp1_qup4_i2c_apps_clk.clkr,
+	[GCC_BLSP1_QUP4_SPI_APPS_CLK] = &gcc_blsp1_qup4_spi_apps_clk.clkr,
+	[GCC_BLSP1_UART1_APPS_CLK] = &gcc_blsp1_uart1_apps_clk.clkr,
+	[GCC_BLSP1_UART2_APPS_CLK] = &gcc_blsp1_uart2_apps_clk.clkr,
+	[GCC_BLSP2_AHB_CLK] = &gcc_blsp2_ahb_clk.clkr,
+	[GCC_BLSP2_QUP1_I2C_APPS_CLK] = &gcc_blsp2_qup1_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP1_SPI_APPS_CLK] = &gcc_blsp2_qup1_spi_apps_clk.clkr,
+	[GCC_BLSP2_QUP2_I2C_APPS_CLK] = &gcc_blsp2_qup2_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP2_SPI_APPS_CLK] = &gcc_blsp2_qup2_spi_apps_clk.clkr,
+	[GCC_BLSP2_QUP3_I2C_APPS_CLK] = &gcc_blsp2_qup3_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP3_SPI_APPS_CLK] = &gcc_blsp2_qup3_spi_apps_clk.clkr,
+	[GCC_BLSP2_QUP4_I2C_APPS_CLK] = &gcc_blsp2_qup4_i2c_apps_clk.clkr,
+	[GCC_BLSP2_QUP4_SPI_APPS_CLK] = &gcc_blsp2_qup4_spi_apps_clk.clkr,
+	[GCC_BLSP2_UART1_APPS_CLK] = &gcc_blsp2_uart1_apps_clk.clkr,
+	[GCC_BLSP2_UART2_APPS_CLK] = &gcc_blsp2_uart2_apps_clk.clkr,
+	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
+	[GCC_CFG_NOC_USB2_AXI_CLK] = &gcc_cfg_noc_usb2_axi_clk.clkr,
+	[GCC_CFG_NOC_USB3_AXI_CLK] = &gcc_cfg_noc_usb3_axi_clk.clkr,
+	[GCC_DCC_AHB_CLK] = &gcc_dcc_ahb_clk.clkr,
+	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
+	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
+	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_GPU_BIMC_GFX_CLK] = &gcc_gpu_bimc_gfx_clk.clkr,
+	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
+	[GCC_GPU_GPLL0_CLK] = &gcc_gpu_gpll0_clk.clkr,
+	[GCC_GPU_GPLL0_DIV_CLK] = &gcc_gpu_gpll0_div_clk.clkr,
+	[GCC_HMSS_DVM_BUS_CLK] = &gcc_hmss_dvm_bus_clk.clkr,
+	[GCC_HMSS_RBCPR_CLK] = &gcc_hmss_rbcpr_clk.clkr,
+	[GCC_MMSS_GPLL0_CLK] = &gcc_mmss_gpll0_clk.clkr,
+	[GCC_MMSS_GPLL0_DIV_CLK] = &gcc_mmss_gpll0_div_clk.clkr,
+	[GCC_MMSS_NOC_CFG_AHB_CLK] = &gcc_mmss_noc_cfg_ahb_clk.clkr,
+	[GCC_MMSS_SYS_NOC_AXI_CLK] = &gcc_mmss_sys_noc_axi_clk.clkr,
+	[GCC_MSS_CFG_AHB_CLK] = &gcc_mss_cfg_ahb_clk.clkr,
+	[GCC_MSS_MNOC_BIMC_AXI_CLK] = &gcc_mss_mnoc_bimc_axi_clk.clkr,
+	[GCC_MSS_Q6_BIMC_AXI_CLK] = &gcc_mss_q6_bimc_axi_clk.clkr,
+	[GCC_MSS_SNOC_AXI_CLK] = &gcc_mss_snoc_axi_clk.clkr,
+	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
+	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
+	[GCC_PRNG_AHB_CLK] = &gcc_prng_ahb_clk.clkr,
+	[GCC_QSPI_AHB_CLK] = &gcc_qspi_ahb_clk.clkr,
+	[GCC_QSPI_SER_CLK] = &gcc_qspi_ser_clk.clkr,
+	[GCC_RX0_USB2_CLKREF_CLK] = &gcc_rx0_usb2_clkref_clk.clkr,
+	[GCC_RX1_USB2_CLKREF_CLK] = &gcc_rx1_usb2_clkref_clk.clkr,
+	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
+	[GCC_SDCC1_APPS_CLK] = &gcc_sdcc1_apps_clk.clkr,
+	[GCC_SDCC1_ICE_CORE_CLK] = &gcc_sdcc1_ice_core_clk.clkr,
+	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
+	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
+	[GCC_UFS_AHB_CLK] = &gcc_ufs_ahb_clk.clkr,
+	[GCC_UFS_AXI_CLK] = &gcc_ufs_axi_clk.clkr,
+	[GCC_UFS_CLKREF_CLK] = &gcc_ufs_clkref_clk.clkr,
+	[GCC_UFS_ICE_CORE_CLK] = &gcc_ufs_ice_core_clk.clkr,
+	[GCC_UFS_PHY_AUX_CLK] = &gcc_ufs_phy_aux_clk.clkr,
+	[GCC_UFS_RX_SYMBOL_0_CLK] = &gcc_ufs_rx_symbol_0_clk.clkr,
+	[GCC_UFS_RX_SYMBOL_1_CLK] = &gcc_ufs_rx_symbol_1_clk.clkr,
+	[GCC_UFS_TX_SYMBOL_0_CLK] = &gcc_ufs_tx_symbol_0_clk.clkr,
+	[GCC_UFS_UNIPRO_CORE_CLK] = &gcc_ufs_unipro_core_clk.clkr,
+	[GCC_USB20_MASTER_CLK] = &gcc_usb20_master_clk.clkr,
+	[GCC_USB20_MOCK_UTMI_CLK] = &gcc_usb20_mock_utmi_clk.clkr,
+	[GCC_USB20_SLEEP_CLK] = &gcc_usb20_sleep_clk.clkr,
+	[GCC_USB30_MASTER_CLK] = &gcc_usb30_master_clk.clkr,
+	[GCC_USB30_MOCK_UTMI_CLK] = &gcc_usb30_mock_utmi_clk.clkr,
+	[GCC_USB30_SLEEP_CLK] = &gcc_usb30_sleep_clk.clkr,
+	[GCC_USB3_CLKREF_CLK] = &gcc_usb3_clkref_clk.clkr,
+	[GCC_USB3_PHY_AUX_CLK] = &gcc_usb3_phy_aux_clk.clkr,
+	[GCC_USB3_PHY_PIPE_CLK] = &gcc_usb3_phy_pipe_clk.clkr,
+	[GCC_USB_PHY_CFG_AHB2PHY_CLK] = &gcc_usb_phy_cfg_ahb2phy_clk.clkr,
+	[GP1_CLK_SRC] = &gp1_clk_src.clkr,
+	[GP2_CLK_SRC] = &gp2_clk_src.clkr,
+	[GP3_CLK_SRC] = &gp3_clk_src.clkr,
+	[GPLL0] = &gpll0.clkr,
+	[GPLL0_EARLY] = &gpll0_early.clkr,
+	[GPLL1] = &gpll1.clkr,
+	[GPLL1_EARLY] = &gpll1_early.clkr,
+	[GPLL1] = &gpll1.clkr,
+	[GPLL4_EARLY] = &gpll4_early.clkr,
+	[GPLL4] = &gpll4.clkr,
+	[HMSS_GPLL0_CLK_SRC] = &hmss_gpll0_clk_src.clkr,
+	[HMSS_GPLL4_CLK_SRC] = &hmss_gpll4_clk_src.clkr,
+	[HMSS_RBCPR_CLK_SRC] = &hmss_rbcpr_clk_src.clkr,
+	[PDM2_CLK_SRC] = &pdm2_clk_src.clkr,
+	[QSPI_SER_CLK_SRC] = &qspi_ser_clk_src.clkr,
+	[SDCC1_APPS_CLK_SRC] = &sdcc1_apps_clk_src.clkr,
+	[SDCC1_ICE_CORE_CLK_SRC] = &sdcc1_ice_core_clk_src.clkr,
+	[SDCC2_APPS_CLK_SRC] = &sdcc2_apps_clk_src.clkr,
+	[UFS_AXI_CLK_SRC] = &ufs_axi_clk_src.clkr,
+	[UFS_ICE_CORE_CLK_SRC] = &ufs_ice_core_clk_src.clkr,
+	[UFS_PHY_AUX_CLK_SRC] = &ufs_phy_aux_clk_src.clkr,
+	[UFS_UNIPRO_CORE_CLK_SRC] = &ufs_unipro_core_clk_src.clkr,
+	[USB20_MASTER_CLK_SRC] = &usb20_master_clk_src.clkr,
+	[USB20_MOCK_UTMI_CLK_SRC] = &usb20_mock_utmi_clk_src.clkr,
+	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
+	[USB30_MOCK_UTMI_CLK_SRC] = &usb30_mock_utmi_clk_src.clkr,
+	[USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,
+};
+
+static struct gdsc *gcc_660_gdscs[] = {
+	[UFS_GDSC] = &ufs_gdsc,
+	[USB_30_GDSC] = &usb_30_gdsc,
+	[PCIE_0_GDSC] = &pcie_0_gdsc,
+};
+
+static const struct qcom_reset_map gcc_660_resets[] = {
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_UFS_BCR] = { 0x75000 },
+	[GCC_USB3_DP_PHY_BCR] = { 0x50028 },
+	[GCC_USB3_PHY_BCR] = { 0x50020 },
+	[GCC_USB3PHY_PHY_BCR] = { 0x50024 },
+	[GCC_USB_20_BCR] = { 0x2f000 },
+	[GCC_USB_30_BCR] = { 0xf000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+};
+
+static const struct regmap_config gcc_660_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x94000,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc gcc_660_desc = {
+	.config = &gcc_660_regmap_config,
+	.clks = gcc_660_clocks,
+	.num_clks = ARRAY_SIZE(gcc_660_clocks),
+	.resets = gcc_660_resets,
+	.num_resets = ARRAY_SIZE(gcc_660_resets),
+	.gdscs = gcc_660_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_660_gdscs),
+};
+
+static const struct of_device_id gcc_660_match_table[] = {
+	{ .compatible = "qcom,gcc-sdm660" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gcc_660_match_table);
+
+static int gcc_660_probe(struct platform_device *pdev)
+{
+	int i, ret = 0;
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gcc_660_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	/*
+	 * Set the HMSS_AHB_CLK_SLEEP_ENA bit to allow the hmss_ahb_clk to be
+	 * turned off by hardware during certain apps low power modes.
+	 */
+	ret = regmap_update_bits(regmap, 0x52008, BIT(21), BIT(21));
+	if (ret)
+		return ret;
+
+	/* Register the hws */
+	for (i = 0; i < ARRAY_SIZE(gcc_sdm660_hws); i++) {
+		ret = devm_clk_hw_register(&pdev->dev, gcc_sdm660_hws[i]);
+		if (ret)
+			return ret;
+	}
+
+	return qcom_cc_really_probe(pdev, &gcc_660_desc, regmap);
+}
+
+static struct platform_driver gcc_660_driver = {
+	.probe		= gcc_660_probe,
+	.driver		= {
+		.name	= "gcc-sdm660",
+		.of_match_table = gcc_660_match_table,
+	},
+};
+
+static int __init gcc_660_init(void)
+{
+	return platform_driver_register(&gcc_660_driver);
+}
+core_initcall_sync(gcc_660_init);
+
+static void __exit gcc_660_exit(void)
+{
+	platform_driver_unregister(&gcc_660_driver);
+}
+module_exit(gcc_660_exit);
+
+MODULE_DESCRIPTION("QCOM GCC sdm660 Driver");
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm660.h b/include/dt-bindings/clock/qcom,gcc-sdm660.h
new file mode 100644
index 000000000000..76aabcc5e7e3
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sdm660.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2017, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2018, Craig Tatlor.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_GCC_660_H
+#define _DT_BINDINGS_CLK_MSM_GCC_660_H
+
+#define GCC_XO					0
+#define GCC_GPLL0_EARLY_DIV			1
+#define GCC_GPLL1_EARLY_DIV			2
+#define BLSP1_QUP1_I2C_APPS_CLK_SRC		3
+#define BLSP1_QUP1_SPI_APPS_CLK_SRC		4
+#define BLSP1_QUP2_I2C_APPS_CLK_SRC		5
+#define BLSP1_QUP2_SPI_APPS_CLK_SRC		6
+#define BLSP1_QUP3_I2C_APPS_CLK_SRC		7
+#define BLSP1_QUP3_SPI_APPS_CLK_SRC		8
+#define BLSP1_QUP4_I2C_APPS_CLK_SRC		9
+#define BLSP1_QUP4_SPI_APPS_CLK_SRC		10
+#define BLSP1_UART1_APPS_CLK_SRC		11
+#define BLSP1_UART2_APPS_CLK_SRC		12
+#define BLSP2_QUP1_I2C_APPS_CLK_SRC		13
+#define BLSP2_QUP1_SPI_APPS_CLK_SRC		14
+#define BLSP2_QUP2_I2C_APPS_CLK_SRC		15
+#define BLSP2_QUP2_SPI_APPS_CLK_SRC		16
+#define BLSP2_QUP3_I2C_APPS_CLK_SRC		17
+#define BLSP2_QUP3_SPI_APPS_CLK_SRC		18
+#define BLSP2_QUP4_I2C_APPS_CLK_SRC		19
+#define BLSP2_QUP4_SPI_APPS_CLK_SRC		20
+#define BLSP2_UART1_APPS_CLK_SRC		21
+#define BLSP2_UART2_APPS_CLK_SRC		22
+#define GCC_AGGRE2_UFS_AXI_CLK			23
+#define GCC_AGGRE2_USB3_AXI_CLK			24
+#define GCC_BIMC_GFX_CLK			25
+#define GCC_BIMC_HMSS_AXI_CLK			26
+#define GCC_BIMC_MSS_Q6_AXI_CLK			27
+#define GCC_BLSP1_AHB_CLK			28
+#define GCC_BLSP1_QUP1_I2C_APPS_CLK		29
+#define GCC_BLSP1_QUP1_SPI_APPS_CLK		30
+#define GCC_BLSP1_QUP2_I2C_APPS_CLK		31
+#define GCC_BLSP1_QUP2_SPI_APPS_CLK		32
+#define GCC_BLSP1_QUP3_I2C_APPS_CLK		33
+#define GCC_BLSP1_QUP3_SPI_APPS_CLK		34
+#define GCC_BLSP1_QUP4_I2C_APPS_CLK		35
+#define GCC_BLSP1_QUP4_SPI_APPS_CLK		36
+#define GCC_BLSP1_UART1_APPS_CLK		37
+#define GCC_BLSP1_UART2_APPS_CLK		38
+#define GCC_BLSP2_AHB_CLK			39
+#define GCC_BLSP2_QUP1_I2C_APPS_CLK		40
+#define GCC_BLSP2_QUP1_SPI_APPS_CLK		41
+#define GCC_BLSP2_QUP2_I2C_APPS_CLK		42
+#define GCC_BLSP2_QUP2_SPI_APPS_CLK		43
+#define GCC_BLSP2_QUP3_I2C_APPS_CLK		44
+#define GCC_BLSP2_QUP3_SPI_APPS_CLK		46
+#define GCC_BLSP2_QUP4_I2C_APPS_CLK		45
+#define GCC_BLSP2_QUP4_SPI_APPS_CLK		46
+#define GCC_BLSP2_UART1_APPS_CLK		47
+#define GCC_BLSP2_UART2_APPS_CLK		48
+#define GCC_BOOT_ROM_AHB_CLK			49
+#define GCC_CFG_NOC_USB2_AXI_CLK		50
+#define GCC_CFG_NOC_USB3_AXI_CLK		51
+#define GCC_DCC_AHB_CLK				52
+#define GCC_GP1_CLK				53
+#define GCC_GP2_CLK				54
+#define GCC_GP3_CLK				55
+#define GCC_GPU_BIMC_GFX_CLK			56
+#define GCC_GPU_CFG_AHB_CLK			57
+#define GCC_GPU_GPLL0_CLK			58
+#define GCC_GPU_GPLL0_DIV_CLK			59
+#define GCC_HMSS_DVM_BUS_CLK			60
+#define GCC_HMSS_RBCPR_CLK			61
+#define GCC_MMSS_GPLL0_CLK			62
+#define GCC_MMSS_GPLL0_DIV_CLK			63
+#define GCC_MMSS_NOC_CFG_AHB_CLK		64
+#define GCC_MMSS_SYS_NOC_AXI_CLK		65
+#define GCC_MSS_CFG_AHB_CLK			66
+#define GCC_MSS_GPLL0_DIV_CLK			67
+#define GCC_MSS_MNOC_BIMC_AXI_CLK		68
+#define GCC_MSS_Q6_BIMC_AXI_CLK			69
+#define GCC_MSS_SNOC_AXI_CLK			70
+#define GCC_PDM2_CLK				71
+#define GCC_PDM_AHB_CLK				72
+#define GCC_PRNG_AHB_CLK			73
+#define GCC_QSPI_AHB_CLK			74
+#define GCC_QSPI_SER_CLK			75
+#define GCC_SDCC1_AHB_CLK			76
+#define GCC_SDCC1_APPS_CLK			77
+#define GCC_SDCC1_ICE_CORE_CLK			78
+#define GCC_SDCC2_AHB_CLK			79
+#define GCC_SDCC2_APPS_CLK			80
+#define GCC_UFS_AHB_CLK				81
+#define GCC_UFS_AXI_CLK				82
+#define GCC_UFS_CLKREF_CLK			83
+#define GCC_UFS_ICE_CORE_CLK			84
+#define GCC_UFS_PHY_AUX_CLK			85
+#define GCC_UFS_RX_SYMBOL_0_CLK			86
+#define GCC_UFS_RX_SYMBOL_1_CLK			87
+#define GCC_UFS_TX_SYMBOL_0_CLK			88
+#define GCC_UFS_UNIPRO_CORE_CLK			89
+#define GCC_USB20_MASTER_CLK			90
+#define GCC_USB20_MOCK_UTMI_CLK			91
+#define GCC_USB20_SLEEP_CLK			92
+#define GCC_USB30_MASTER_CLK			93
+#define GCC_USB30_MOCK_UTMI_CLK			94
+#define GCC_USB30_SLEEP_CLK			95
+#define GCC_USB3_CLKREF_CLK			96
+#define GCC_USB3_PHY_AUX_CLK			97
+#define GCC_USB3_PHY_PIPE_CLK			98
+#define GCC_USB_PHY_CFG_AHB2PHY_CLK		99
+#define GP1_CLK_SRC				100
+#define GP2_CLK_SRC				101
+#define GP3_CLK_SRC				102
+#define GPLL0					103
+#define GPLL0_EARLY				104
+#define GPLL1					105
+#define GPLL1_EARLY				106
+#define GPLL4					107
+#define GPLL4_EARLY				108
+#define HMSS_GPLL0_CLK_SRC			109
+#define HMSS_GPLL4_CLK_SRC			110
+#define HMSS_RBCPR_CLK_SRC			111
+#define PDM2_CLK_SRC				112
+#define QSPI_SER_CLK_SRC			113
+#define SDCC1_APPS_CLK_SRC			114
+#define SDCC1_ICE_CORE_CLK_SRC			115
+#define SDCC2_APPS_CLK_SRC			116
+#define UFS_AXI_CLK_SRC				117
+#define UFS_ICE_CORE_CLK_SRC			118
+#define UFS_PHY_AUX_CLK_SRC			119
+#define UFS_UNIPRO_CORE_CLK_SRC			120
+#define USB20_MASTER_CLK_SRC			121
+#define USB20_MOCK_UTMI_CLK_SRC			122
+#define USB30_MASTER_CLK_SRC			123
+#define USB30_MOCK_UTMI_CLK_SRC			124
+#define USB3_PHY_AUX_CLK_SRC			125
+#define GPLL0_OUT_MSSCC				126
+#define GCC_UFS_AXI_HW_CTL_CLK			127
+#define GCC_UFS_ICE_CORE_HW_CTL_CLK		128
+#define GCC_UFS_PHY_AUX_HW_CTL_CLK		129
+#define GCC_UFS_UNIPRO_CORE_HW_CTL_CLK		130
+#define GCC_RX0_USB2_CLKREF_CLK			131
+#define GCC_RX1_USB2_CLKREF_CLK			132
+
+#define PCIE_0_GDSC	0
+#define UFS_GDSC	1
+#define USB_30_GDSC	2
+
+#define GCC_QUSB2PHY_PRIM_BCR		0
+#define GCC_QUSB2PHY_SEC_BCR		1
+#define GCC_UFS_BCR			2
+#define GCC_USB3_DP_PHY_BCR		3
+#define GCC_USB3_PHY_BCR		4
+#define GCC_USB3PHY_PHY_BCR		5
+#define GCC_USB_20_BCR                  6
+#define GCC_USB_30_BCR			7
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR	8
+
+#endif
-- 
2.18.0


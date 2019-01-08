Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E8F2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfAHNvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:51:15 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:63162 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfAHNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:51:13 -0500
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 8 Jan 2019
 21:51:32 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/4] clk: meson: add DT documentation for emmc clock controller
Date:   Tue, 8 Jan 2019 21:50:43 +0800
Message-ID: <1546955444-7549-4-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yixun Lan <yixun.lan@amlogic.com>

Document the MMC sub clock controller driver, the potential consumer
of this driver is MMC or NAND. Also add four clock bindings IDs which
provided by this driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 .../devicetree/bindings/clock/amlogic,mmc-clkc.txt | 39 ++++++++++++++++++++++
 include/dt-bindings/clock/amlogic,mmc-clkc.h       | 17 ++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
 create mode 100644 include/dt-bindings/clock/amlogic,mmc-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
new file mode 100644
index 0000000..0f518e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/amlogic,mmc-clkc.txt
@@ -0,0 +1,39 @@
+* Amlogic MMC Sub Clock Controller Driver
+
+The Amlogic MMC clock controller generates and supplies clock to support
+MMC and NAND controller
+
+Required Properties:
+
+- compatible: should be:
+		"amlogic,gx-mmc-clkc"
+		"amlogic,axg-mmc-clkc"
+
+- #clock-cells: should be 1.
+- clocks: phandles to clocks corresponding to the clock-names property
+- clock-names: list of parent clock names
+	- "clkin0", "clkin1"
+
+- reg: address of emmc sub clock register
+
+Example: Clock controller node:
+
+sd_mmc_c_clkc: clock-controller@7000 {
+	compatible = "amlogic,axg-mmc-clkc", "syscon";
+	reg = <0x0 0x7000 0x0 0x4>;
+	#clock-cells = <1>;
+
+	clock-names = "clkin0", "clkin1";
+	clocks = <&clkc CLKID_SD_MMC_C_CLK0>,
+		 <&clkc CLKID_FCLK_DIV2>;
+};
+
+sd_emmc_b_clkc: clock-controller@5000 {
+	compatible = "amlogic,axg-mmc-clkc", "syscon";
+	reg = <0x0 0x5000 0x0 0x4>;
+
+	#clock-cells = <1>;
+	clock-names = "clkin0", "clkin1";
+	clocks = <&clkc CLKID_SD_EMMC_B_CLK0>,
+		 <&clkc CLKID_FCLK_DIV2>;
+};
diff --git a/include/dt-bindings/clock/amlogic,mmc-clkc.h b/include/dt-bindings/clock/amlogic,mmc-clkc.h
new file mode 100644
index 0000000..34a3c56
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,mmc-clkc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Meson MMC sub clock tree IDs
+ *
+ * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ */
+
+#ifndef __MMC_CLKC_H
+#define __MMC_CLKC_H
+
+#define CLKID_MMC_DIV		0
+#define CLKID_MMC_PHASE_CORE	1
+#define CLKID_MMC_PHASE_TX	2
+#define CLKID_MMC_PHASE_RX	3
+
+#endif
-- 
1.9.1


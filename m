Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF2AC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E022404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7E022404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeHJMX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:23:58 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:12148 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbeHJMX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:23:57 -0400
Received: from droid15-sz.amlogic.com (10.28.8.25) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Fri, 10 Aug 2018
 17:54:49 +0800
From:   Jian Hu <jian.hu@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Jian Hu <jian.hu@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: clk: meson-g12a: Add G12A AO Clock Bindings
Date:   Fri, 10 Aug 2018 17:54:27 +0800
Message-ID: <1533894868-85815-2-git-send-email-jian.hu@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.25]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new clock controller compatible and dt-bingdings headers
for the Always-On domain of the g12a SoC

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
---
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  1 +
 include/dt-bindings/clock/g12a-aoclkc.h            | 28 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100755 include/dt-bindings/clock/g12a-aoclkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
index 3a88052..6f02288 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -10,6 +10,7 @@ Required Properties:
 	- GXL (S905X, S905D) : "amlogic,meson-gxl-aoclkc"
 	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
 	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
+	- G12A (S905D2, S905X2) : "amlogic,g12a-aoclkc"
 	followed by the common "amlogic,meson-gx-aoclkc"
 
 - #clock-cells: should be 1.
diff --git a/include/dt-bindings/clock/g12a-aoclkc.h b/include/dt-bindings/clock/g12a-aoclkc.h
new file mode 100755
index 0000000..6b3f921
--- /dev/null
+++ b/include/dt-bindings/clock/g12a-aoclkc.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Jian Hu<jian.hu@amlogic.com>
+ */
+
+#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_G12A_AOCLK
+
+#define CLKID_AO_AHB_BUS		0
+#define CLKID_AO_REMOTE			1
+#define CLKID_AO_I2C_MASTER		2
+#define CLKID_AO_I2C_SLAVE		3
+#define CLKID_AO_UART1			4
+#define CLKID_AO_PROD_I2C		5
+#define CLKID_AO_UART2			6
+#define CLKID_AO_IR_BLASTER		7
+#define CLKID_AO_SAR_ADC		8
+#define CLKID_AO_CLK81			9
+#define CLKID_AO_SAR_ADC_SEL		10
+#define CLKID_AO_SAR_ADC_DIV		11
+#define CLKID_AO_SAR_ADC_CLK		12
+#define CLKID_AO_ALT_XTAL		13
+
+#endif
-- 
1.9.1


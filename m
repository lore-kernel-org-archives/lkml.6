Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50485ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DAD20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DAD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbeGXCVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:21:00 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58102 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388234AbeGXCVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:21:00 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 9DB349F64A;
        Tue, 24 Jul 2018 01:17:03 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/3] arm64: allwinner: dts: h6: add Pine H64 model B
Date:   Tue, 24 Jul 2018 09:15:49 +0800
Message-Id: <20180724011551.49603-2-icenowy@aosc.io>
In-Reply-To: <20180724011551.49603-1-icenowy@aosc.io>
References: <20180724011551.49603-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pine H64 model B is another variant of Pine H64 by Pine64. It features a
smaller board footprint (of RPi size) and drops PCIe. It also have WLAN
on board (rather than via expansion connector on the original model A)
and some LED changes.

Add an initial device tree for it. Only LED difference is considered
now, as functionalities related to other changes are still not available
now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-h6-pine-h64-model-b.dts  | 20 +++++++++++++++++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 +++--
 3 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 9ffa7a038791..330b5fb3715b 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -16,3 +16,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
new file mode 100644
index 000000000000..d0fcc25efb00
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+/*
+ * Copyright (c) 2017 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include "sun50i-h6-pine-h64.dts"
+
+/ {
+	model = "Pine H64 Model B";
+	compatible = "pine64,pine-h64-model-b", "pine64,pine-h64",
+		     "allwinner,sun50i-h6";
+
+	leds {
+		/delete-node/ heartbeat;
+
+		status {
+			label = "pine-h64:red:status";
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index ceffc40810ee..a85867f8b684 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -10,8 +10,9 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Pine H64";
-	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
+	model = "Pine H64 Model A";
+	compatible = "pine64,pine-h64-model-a", "pine64,pine-h64",
+		     "allwinner,sun50i-h6";
 
 	aliases {
 		serial0 = &uart0;
-- 
2.18.0


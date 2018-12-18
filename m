Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E202C218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeLRVfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:35:17 -0500
Received: from palmtree.beeroclock.net ([178.79.160.154]:55382 "EHLO
        palmtree.beeroclock.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeLRVfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:35:08 -0500
Received: from beros.lan (89-160-129-47.du.xdsl.is [89.160.129.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: karlp)
        by palmtree.beeroclock.net (Postfix) with ESMTPSA id F42321028D;
        Tue, 18 Dec 2018 21:28:12 +0000 (UTC)
From:   Karl Palsson <karlp@tweak.net.au>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Karl Palsson <karlp@tweak.net.au>
Subject: [PATCH 3/3] ARM: dts: sun8i: add FriendlyARM NanoPi Duo2-IoT Box
Date:   Tue, 18 Dec 2018 21:24:57 +0000
Message-Id: <20181218212457.30382-3-karlp@tweak.net.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181218212457.30382-1-karlp@tweak.net.au>
References: <20181218212457.30382-1-karlp@tweak.net.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IoT-Box is a dock for the NanoPi Duo2, adding two USB host ports, a
10/100 ethernet port, a variety of pin headers for i2c and uarts, and a
quad band 2G GSM module, a SIM800C.

Full documentation and schematics available from vendor:
http://wiki.friendlyarm.com/wiki/index.php/NanoPi_Duo2_IoT-Box

Signed-off-by: Karl Palsson <karlp@tweak.net.au>
---
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts | 45 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7f296bfea94a..b62d84639c7a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1064,6 +1064,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-libretech-all-h3-cc.dtb \
 	sun8i-h3-mapleboard-mp130.dtb \
 	sun8i-h3-nanopi-duo2.dtb \
+	sun8i-h3-nanopi-duo2-iotbox.dtb \
 	sun8i-h3-nanopi-m1.dtb	\
 	sun8i-h3-nanopi-m1-plus.dtb \
 	sun8i-h3-nanopi-neo.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts
new file mode 100644
index 000000000000..4e7fae4046a8
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2-iotbox.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Karl Palsson <karlp@tweak.net.au>
+ */
+
+#include "sun8i-h3-nanopi-duo2.dts"
+
+/ {
+	model = "FriendlyARM NanoPi Duo2 IoT Box";
+	compatible = "friendlyarm,nanopi-duo2-iotbox",
+		"friendlyarm,nanopi-duo2",
+		"allwinner,sun8i-h3";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+/* Not addressed, SIM800C module on uart3 */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
-- 
2.14.5


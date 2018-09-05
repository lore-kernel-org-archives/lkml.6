Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D41C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7577F2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CiPBfHgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7577F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIEUvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:51:49 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58122 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeIEUvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:51:48 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w85GKPlB071638;
        Wed, 5 Sep 2018 11:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536164425;
        bh=JlGMJiKwmGy6SwDe02bL2g4ysMAQQb/2uhXpU8BgrDw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CiPBfHgy9BE70CvB6F9AmxQEf8gEmqCKZE6Q1GYRK9lvUEorY7uaXIcugrx/bDsh2
         RQXNswRQcMzpPZUlEqHc/ML6rtXvIhxgOKqvp+ExYH86H8FWssRuiDLcz5ufmGNdSF
         Yu/inofhNwuRsHZCWh3z9YRgNQ9IyCY3EWiuQr9U=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85GKPd7003795;
        Wed, 5 Sep 2018 11:20:25 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 5 Sep
 2018 11:20:25 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 5 Sep 2018 11:20:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85GKPUt020620;
        Wed, 5 Sep 2018 11:20:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: am654: Add uart nodes
Date:   Wed, 5 Sep 2018 11:20:22 -0500
Message-ID: <20180905162024.28243-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180905162024.28243-1-nm@ti.com>
References: <20180905162024.28243-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uart nodes for AM654 device tree components.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 30 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        | 18 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     | 18 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65.dtsi            | 10 +++++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts |  5 +++++
 5 files changed, 81 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index faace3805c01..674a266066ca 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -28,4 +28,34 @@
 			#msi-cells = <1>;
 		};
 	};
+
+	main_uart0: serial@2800000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x02800000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
+
+	main_uart1: serial@2810000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
+
+	main_uart2: serial@2820000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x02820000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
new file mode 100644
index 000000000000..8c611d16df44
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family MCU Domain peripherals
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+&cbass_mcu {
+	mcu_uart0: serial@40a00000 {
+		compatible = "ti,am654-uart";
+			reg = <0x00 0x40a00000 0x00 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <96000000>;
+			current-speed = <115200>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
new file mode 100644
index 000000000000..8b4378d4d0a3
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM6 SoC Family Wakeup Domain peripherals
+ *
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+&cbass_wakeup {
+	wkup_uart0: serial@42300000 {
+		compatible = "ti,am654-uart";
+		reg = <0x00 0x42300000 0x00 0x100>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <48000000>;
+		current-speed = <115200>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index ded364d20835..3d4bf369d030 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -16,6 +16,14 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+	};
+
 	chosen { };
 
 	firmware {
@@ -85,3 +93,5 @@
 
 /* Now include the peripherals for each bus segments */
 #include "k3-am65-main.dtsi"
+#include "k3-am65-mcu.dtsi"
+#include "k3-am65-wakeup.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index af6956fdc13f..e146ac2ad781 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -34,3 +34,8 @@
 		};
 	};
 };
+
+&wkup_uart0 {
+	/* Wakeup UART is used by System firmware */
+	status = "disabled";
+};
-- 
2.15.1


Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4DAC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B1726909
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jznJxwwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B1726909
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeFZQ1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:27:08 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56152 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeFZQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:26:55 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5QGQGNM062756;
        Tue, 26 Jun 2018 11:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530030376;
        bh=0TA0EzAj75xsqlZAD951i6UiO3LFPJQfV06foUxkNLo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jznJxwwnaC10FvFPysDMKQg2hZHoWf70rcY+5Ze9nw1PrvR5V91ASeF3Kb2YErLxl
         zfU3N/7u96jStPozZE1jMRGEOqkFlAJv9TvrRTIkSyrMNJj2W4+3rEHfXH2xLQSV3+
         trtEcFzbW2jhwg/TmqYG4tci+j7Ya2vqIFmF/ASQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5QGQGxa004628;
        Tue, 26 Jun 2018 11:26:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 26
 Jun 2018 11:26:16 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 26 Jun 2018 11:26:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5QGQFvt001859;
        Tue, 26 Jun 2018 11:26:15 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH V2 5/5] arm64: dts: ti: Add support for AM654 EVM base board
Date:   Tue, 26 Jun 2018 11:26:15 -0500
Message-ID: <20180626162615.19194-6-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180626162615.19194-1-nm@ti.com>
References: <20180626162615.19194-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EValuation Module(EVM) platform for AM654 consists of a
common Base board + one or more of daughter cards, which include:
a) "Personality Modules", which can be specific to a profile, such as
 ICSSG enabled or Multi-media (including audio).
b) SERDES modules, which may be 2 lane PCIe or two port PCIe + USB2
c) Camera daughter card
d) various display panels

Among other options. There are two basic configurations defined which
include an "EVM" configuration and "IDK" (Industrial development kit)
which differ in the specific combination of daughter cards that are
used.

To simplify support, we choose to support just the base board as the
core device tree file and all daughter cards would be expected to be
device tree overlays.

Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
 * Picked up Tony's reviewed-by
 
V1: https://patchwork.kernel.org/patch/10475333/
RFC: https://patchwork.kernel.org/patch/10447741/

 MAINTAINERS                                    |  1 +
 arch/arm64/boot/dts/Makefile                   |  1 +
 arch/arm64/boot/dts/ti/Makefile                |  9 +++++++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 36 ++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/Makefile
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 6785ceaf5b0b..e9e916d1fb52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2093,6 +2093,7 @@ M:	Nishanth Menon <nm@ti.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+F:	arch/arm64/boot/dts/ti/Makefile
 F:	arch/arm64/boot/dts/ti/k3-*
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 3543bc324553..4690364d584b 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -23,5 +23,6 @@ subdir-y += rockchip
 subdir-y += socionext
 subdir-y += sprd
 subdir-y += synaptics
+subdir-y += ti
 subdir-y += xilinx
 subdir-y += zte
diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
new file mode 100644
index 000000000000..63e619d0b5b8
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Make file to build device tree binaries for boards based on
+# Texas Instruments Inc processors
+#
+# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+#
+
+dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
new file mode 100644
index 000000000000..af6956fdc13f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/dts-v1/;
+
+#include "k3-am654.dtsi"
+
+/ {
+	compatible =  "ti,am654-evm", "ti,am654";
+	model = "Texas Instruments AM654 Base Board";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 4G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		secure_ddr: secure_ddr@9e800000 {
+			reg = <0 0x9e800000 0 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+	};
+};
-- 
2.15.1


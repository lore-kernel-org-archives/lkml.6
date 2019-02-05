Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B25F2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfBEJHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:07:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35532 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728348AbfBEJHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:07:34 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x158tpgZ022872;
        Tue, 5 Feb 2019 10:07:19 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qd2ymdppy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Feb 2019 10:07:19 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5ADA838;
        Tue,  5 Feb 2019 09:07:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 328B82480;
        Tue,  5 Feb 2019 09:07:18 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 Feb 2019 10:07:17
 +0100
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ARM: dts: stm32: add initial support of stm32mp157a-dk1 board
Date:   Tue, 5 Feb 2019 10:07:04 +0100
Message-ID: <1549357625-7229-2-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
References: <1549357625-7229-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of stm32mp157a discovery1 board (part number: STM32MP157A-DK1).
This board embeds a STM32MP157a SOC with AC package (TFBGA361, 148 ios)
and 512MB of DDR3. Several connections are available on this boards:
4*USB2.0, 1*USB2.0 typeC, SDcard, RJ45, HDMI, Arduino connector, ...

This patch enables basic support for a kernel boot.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148..a1ca713 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -951,6 +951,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
 	stm32746g-eval.dtb \
 	stm32h743i-eval.dtb \
 	stm32h743i-disco.dtb \
+	stm32mp157a-dk1.dtb \
 	stm32mp157c-ed1.dtb \
 	stm32mp157c-ev1.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
new file mode 100644
index 0000000..873a80e
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2019 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@st.com> for STMicroelectronics.
+ */
+
+/dts-v1/;
+
+#include "stm32mp157c.dtsi"
+#include "stm32mp157-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "STMicroelectronics STM32MP157A-DK1 Discovery Board";
+	compatible = "st,stm32mp157a-dk1", "st,stm32mp157";
+
+	aliases {
+		ethernet0 = &ethernet0;
+		serial0 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@c0000000 {
+		reg = <0xc0000000 0x20000000>;
+	};
+
+	led {
+		compatible = "gpio-leds";
+		blue {
+			label = "heartbeat";
+			gpios = <&gpiod 11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			default-state = "off";
+		};
+	};
+};
+
+&ethernet0 {
+	status = "okay";
+	pinctrl-0 = <&ethernet0_rgmii_pins_a>;
+	pinctrl-1 = <&ethernet0_rgmii_pins_sleep_a>;
+	pinctrl-names = "default", "sleep";
+	phy-mode = "rgmii";
+	max-speed = <1000>;
+	phy-handle = <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&iwdg2 {
+	timeout-sec = <32>;
+	status = "okay";
+};
+
+&rng1 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins_a>;
+	status = "okay";
+};
-- 
2.7.4


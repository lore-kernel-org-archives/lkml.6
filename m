Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A5AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6D1208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kynetics-com.20150623.gappssmtp.com header.i=@kynetics-com.20150623.gappssmtp.com header.b="Mskl07BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6D1208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kynetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388552AbeG0OWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:22:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41498 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbeG0OWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:22:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so4982188wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=r/Ar8Yizv8yzsSWL3b3xZ8o+cuq530JLSnImYeoKX8U=;
        b=Mskl07BPdO7n1T9tknseSUwg5iCcKQJe3aT7pjkquESl7MfnhOm1oCXYH2ZC86rCO2
         YmB8Vrm4hUgpAQEYn9YSlqcxWg+5GVhnhRGw9NSvSGG/w18DdLKZOq+Jnvr5TMMjEmPU
         Ly64ssQv36cdR0nqAw6WJ8dWSs1T3D7KjDz5opcfX0g+uRmHrtE54zINY8/bQzneU0pC
         plpQ5qY5uLRALvqVQkM+CB/5BJiL1miwTqU6HnZ9js0e/yqg13FPBzNyz+98oGyGxUeb
         fR2eE42eYsWBaia8uwr0Een17YxC9vqxrCIdy2IaUK+8u9Qs7udbmeHHxTtvsQgiHM5v
         PUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r/Ar8Yizv8yzsSWL3b3xZ8o+cuq530JLSnImYeoKX8U=;
        b=TQZEDPxcIu3vxwWjRd6ppXBbr2YDNTzN8x9ejydL3WIM5pGTJxZBUp+IfrHeKwmzY4
         Pf86CJNPp5IGt4M1xiFBI73nSX1n1jyrv4B8DMghPJ5MW4xUvQ6gkliRNLqJY4eXLocA
         dvfvCj7cnZ6W0hqUxhmKiIBMgFkczd8gB0psapuNEL+L8lTPO62r5prlTri2fRiO3+E2
         AspylHSYKtfYNmljFNoySNWV6LmgWhOHuqn+zm1i4dN1FsVu9oaeItdZPxuhvxJ21WVo
         9bhE5tmVnC//tJZUjBYwF3lFGsCAv9zoPGF5e7Ozc9j+cQOpog8EKvMCWYSAyPpEgK+o
         Lenw==
X-Gm-Message-State: AOUpUlF0OoxsdpLm6lctt07hpCSWkOXu0lX8MwSKUPibh74l4+f8ms3y
        AZHy/bp3M5tFGAHu47gcNqGKgQ==
X-Google-Smtp-Source: AAOMgpfwJBecCX6G4d8eSGT+QKOAatMBnvirqHJ3GchMFAvbgyrH5/RLLOw4D28ztymQfuXMfunAeQ==
X-Received: by 2002:adf:87f1:: with SMTP id c46-v6mr4594476wrc.246.1532696454565;
        Fri, 27 Jul 2018 06:00:54 -0700 (PDT)
Received: from localhost.localdomain.it (host57-224-static.7-79-b.business.telecomitalia.it. [79.7.224.57])
        by smtp.gmail.com with ESMTPSA id a9-v6sm3966353wrp.55.2018.07.27.06.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 06:00:53 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Jagan Teki <jteki@openedev.com>
Cc:     Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3 support
Date:   Fri, 27 Jul 2018 14:57:39 +0200
Message-Id: <20180727125739.22871-1-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orangepi Zero Plus 2 is an open-source single-board computer, available in two
Allwinner SOC variants, H3 and H5. We add support for H3 variant here, as the
H5 is already supported by sun50i-h5-orangepi-zero-plus2.dts.

H5 Orangepi Zero Plus 2 has
- Quad-core Cortex-A7
- 512MB DDR3
- micrSD slot and 8GB eMMC
- Debug TTL UART
- HDMI
- Wifi + BT
- OTG+power supply

Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 146 ++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..03fb915f2337 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1024,6 +1024,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-pc-plus.dtb \
 	sun8i-h3-orangepi-plus.dtb \
 	sun8i-h3-orangepi-plus2e.dtb \
+	sun8i-h3-orangepi-zero-plus2.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
 	sun8i-r16-nintendo-nes-classic.dtb \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
new file mode 100644
index 000000000000..3701644adc30
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
+ * Copyright (C) 2018 Diego Rondini <diego.rondini@kynetics.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "sun8i-h3.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "OrangePi Zero Plus2 H3";
+	compatible = "xunlong,orangepi-zero-plus2", "allwinner,sun8i-h3";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		reset-gpios = <&pio 0 9 GPIO_ACTIVE_LOW>; /* PA9 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&de {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_LEVEL_LOW>;	/* PL7 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	status = "okay";
+};
-- 
2.17.1


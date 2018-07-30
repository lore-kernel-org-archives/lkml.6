Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E8FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E8920893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kynetics-com.20150623.gappssmtp.com header.i=@kynetics-com.20150623.gappssmtp.com header.b="hXJjfrUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E8920893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kynetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeG3N1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:27:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36551 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbeG3N1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:27:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so12578260wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePSad14ErFT1RopEf8XCBP5pt12XwoD56B2u25eMSPk=;
        b=hXJjfrUIGize5hVsRUolLMfJwquXS57thsX8SdEeCyKBYq63KuL1EwjnRyjp6ffk4x
         DdUtFKbGdwoHsLgni8Avf8IEz+AqwTVBfbHxGJ3sTueAI3vOk6OrF/5ET0Cz6kQLHwBD
         uQuMn0EXdd1Qihc2MEPr9kW/qvPTgWHNfe3r0dMcR15tSBY68Kb3HRkptbCBiotQ4bW/
         Z8Y3BlVq1hMd78ASUcml7MF8w8/qLlj+4e5PsMvEtvBW+D+s8m2zJsAMzM65xX/xhzeY
         8vnXOFqNIdoRmJceXlAthPRhp3jFIhAyPUFqTwwecpDr08aX098IXUL85z8r5KcdA2Vp
         1eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePSad14ErFT1RopEf8XCBP5pt12XwoD56B2u25eMSPk=;
        b=Kt8TS5/nmKoP3gqWwdZOAKKEetMgoM7vrC1N+FzBk8v/FJ9HiqkqtSHumjlfH21TKU
         629ohN6PdQ38IHeRIB13CvbNFAz4aKxOCbSX2/HJeaFdkogRB64/i/N3fLnBGDwJXlLi
         zi6IKoLmcahbtQ0zHn85xfIpFaMwh0QhS1znrqyhx0de1i+syaESfM8X/gO9CQw4w2VN
         bqqtD3V0Ztp6U82ww66Xyg6z378li/NCyO/tj7HFrcLCp2HfjMztraozuG6OxDGUcJL6
         m/0MpL4J/BPCl5mDeMIZ5lXTcQsbrzApE3Ct1oXv8G8JU+Y3Fl2fnre3cIP+Kde+0xvS
         vJ9g==
X-Gm-Message-State: AOUpUlE+7n3lHXoJ60yCgofBSsPwXPpzbnK3Ntj70LUyltAV+sWL7QpX
        kFsRrFpgRkOKYDxw5KEmxlsg/w==
X-Google-Smtp-Source: AAOMgpdVlgZgV9cVkiNbOCjiYbisVafqKsCcKLdIzMZbeyOBkdH6h64ASeyaOjD4EDmHgZ1q6V6XkQ==
X-Received: by 2002:adf:9996:: with SMTP id y22-v6mr18343803wrb.69.1532951591644;
        Mon, 30 Jul 2018 04:53:11 -0700 (PDT)
Received: from localhost.localdomain.it (host57-224-static.7-79-b.business.telecomitalia.it. [79.7.224.57])
        by smtp.gmail.com with ESMTPSA id 68-v6sm15568130wmi.31.2018.07.30.04.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 04:53:10 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH v2] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3 support
Date:   Mon, 30 Jul 2018 13:52:23 +0200
Message-Id: <20180730115223.14161-1-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727125739.22871-1-diego.rondini@kynetics.com>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orangepi Zero Plus 2 is an open-source single-board computer, available in two
Allwinner SOC variants, H3 and H5. We add support for H3 variant here, as the
H5 is already supported by sun50i-h5-orangepi-zero-plus2.dts.

H3 Orangepi Zero Plus 2 has
- Quad-core Cortex-A7
- 512MB DDR3
- micrSD slot and 8GB eMMC
- Debug TTL UART
- HDMI
- Wifi + BT
- OTG+power supply

Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>

---

Changes for v2:
- add "-h3" suffix to compatible name
- fix wrong "H5" in the commit message
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
index 000000000000..b18b3a5105ce
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
+	compatible = "xunlong,orangepi-zero-plus2-h3", "allwinner,sun8i-h3";
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


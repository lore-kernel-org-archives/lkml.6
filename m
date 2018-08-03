Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6D4C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712102172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kynetics-com.20150623.gappssmtp.com header.i=@kynetics-com.20150623.gappssmtp.com header.b="B+m8HdYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712102172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kynetics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeHCJxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:53:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52202 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeHCJxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:53:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so5274828wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 00:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynetics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+jyTOKGf1ttXu/BD+3ayOEBxej5qVGJ20Mrm+C+fQm4=;
        b=B+m8HdYdlEJFRWUsLSEBByXac9YlFEh6/ujyRpgECfxW4k5HZJIe/8KUBY6EXbKh/a
         mRQwa4APxqvlaEwCOlxqihflU25WB+2TO3g7xGfziUOmHARc3SwFNsiIqxJ6VlG2RarG
         YIpU0xphc8kcBhsb/6HME0O1JcoHKX9qa1iohvXLd3vMkE9iN3q2Kuq4J4Ery19/ei4H
         oKM4+KlvrXEv8vyKUfebgqlg9VXc5uaST8+GUCJQ2x1lP65hJBclVhidhEngVUv9cgOL
         D2B/dJYejCglzGNXD3LIIfTUcx3LM0cO58Z8U6ciN2PMS8fb/B05szyJgxuFGKcKkqrH
         JCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+jyTOKGf1ttXu/BD+3ayOEBxej5qVGJ20Mrm+C+fQm4=;
        b=Qx69g+d8W/7NVv2rq5gvi6aU2qQtZhDpdSW0vXHoKe/nlTUIRDR/enDASnCTYvlUP+
         hKz3wUqKl+f+L7hJTUG6fuO4vWvTNKCbxsO+fn99XZMWCeRr/nrxZ1avX6d9lvE780WZ
         fURkmFhq9vIn8dWzSuSMmV5rhmKCAuOUYTh1kKSneNnz3cAtT7UaDBSzfeDvhUibfKYz
         gfOtasMhWWZfjwWBqFl5s4DncEDTOkN1PEirbJR5gWVrUDx2fmttRv48bJEAI2sVdhl8
         fehRnMtYGhdQGS8fTtbjC++FiE1UTFZ56FRuoiVXdYtlIMBToZpeX52Mtz9rNSADAt8n
         T9lg==
X-Gm-Message-State: AOUpUlHlG/NhsupqmN4OjPBu1HimTER/GVsYk+2d0NxQ44Outly51DVe
        kunrfMZe+yaRoKqb+m8y03zCLg==
X-Google-Smtp-Source: AAOMgpfu0Lw5NkWDZj6dJ1fFj7cqX/22aH9ssjtSe45Ig27L+96dC3ozQSskuUQDPFIr/Un26xdKlA==
X-Received: by 2002:a1c:ec1b:: with SMTP id k27-v6mr4003646wmh.157.1533283082612;
        Fri, 03 Aug 2018 00:58:02 -0700 (PDT)
Received: from localhost.localdomain.it (host57-224-static.7-79-b.business.telecomitalia.it. [79.7.224.57])
        by smtp.gmail.com with ESMTPSA id 71-v6sm5750973wmq.17.2018.08.03.00.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 00:58:01 -0700 (PDT)
From:   Diego Rondini <diego.rondini@kynetics.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Diego Rondini <diego.rondini@kynetics.com>
Subject: [PATCH v3] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3 support
Date:   Fri,  3 Aug 2018 09:56:25 +0200
Message-Id: <20180803075625.13289-1-diego.rondini@kynetics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730115223.14161-1-diego.rondini@kynetics.com>
References: <20180730115223.14161-1-diego.rondini@kynetics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Orangepi Zero Plus 2 is an open-source single-board computer, available in two
Allwinner SOC variants, H3 and H5. We add support for H3 variant here, as the
H5 is already supported by sun50i-h5-orangepi-zero-plus2.dts.

H3 Orangepi Zero Plus 2 has:
- Quad-core Cortex-A7
- 512MB DDR3
- microSD slot and 8GB eMMC
- Debug TTL UART
- HDMI
- Wifi + BT
- OTG + power supply

Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>

---
Changes for v3:
- removed uart1 node until we have working Bluetooth support

Changes for v2:
- add "-h3" suffix to compatible name
- fix wrong "H5" in the commit message
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/sun8i-h3-orangepi-zero-plus2.dts | 140 ++++++++++++++++++
 2 files changed, 141 insertions(+)
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
index 000000000000..c834048c325e
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
@@ -0,0 +1,140 @@
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
-- 
2.17.1


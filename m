Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456C7C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04A4820869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvriUcWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A4820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbeKSAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:39:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52111 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeKSAjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:39:11 -0500
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so2814319wmc.1;
        Sun, 18 Nov 2018 06:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nean5KzGgPTYBSLoLsUHGS7++gBG6XLbIiW5iStY59w=;
        b=HvriUcWCC1wIt+abC5mLh8VIQy2I8AKBrmdZ4fxQ3R2eu5mbi10Ipz+Up+4V4oID1Z
         SogoTJbVxxpzdmdI16iI7CltDBXNiwG9eHseqwD5x0+sbFGGESE7Lqnpk2rAWZ7kEasL
         xEoV9+TGHf0RBMFC1fGChpXVkbSkKZndqQPAhmYkzZved9Ns+4E+ugi0UsaJp/SCE1eG
         XI5OrhDbx0rNopaPKSXtcTS9GgVwMZ8pTWQe2dCtq/X+1v7lAPgp/NEIZ36xlI2OLa1i
         CPSzoWNYp+f0O2pvOs1llvzShq9+V6DeaMIONImYlEboswmKS5HpraJJSZ8or7/+m47V
         1Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nean5KzGgPTYBSLoLsUHGS7++gBG6XLbIiW5iStY59w=;
        b=IifwRZD5G9HSkEb+e5YQmtriWFDj/z0HhepXsGbkOiWiV0Q8YxQjjU90aZlsKQWvMm
         I6O/ZeLGYuiS4BbJQK0By1t4myB4Vjd1Bhqrix9xj8Zr+aHtvnVCeQmX4m5RdRH7V3Zf
         EVLzfoD2o0dLG6DnEFtaelVeQyPL/+u0yYo0ztddO05wJVUo4+or/0xueHCMQSRWQGOa
         DOSb0wA7ydy/VJ5m2ks/lkBuqB/CV5KajuaMqtFl96IulRNEH3f6l7HeShtdJOUR2PNG
         yF74lhVPys/yPqq7YdDma9qamKAJDMSBmVdBWdC0vj15IVWUd5MMzFFj5BHyMMnLuwUY
         dfIA==
X-Gm-Message-State: AGRZ1gI02lkxEXrevn7Ba+67sT8emvJ5MHfFccgSzIrJDL+mutj1vGfC
        kIufHqS1NwaSOUMup8xGOimHsn2+etk=
X-Google-Smtp-Source: AFSGD/WabYNKnqnPIyn6MOGAypciEZ647Z2Z4elpqkdYDPIofh2tae/TnCi6QHqe5747sbYKgZUgJQ==
X-Received: by 2002:a1c:b102:: with SMTP id a2-v6mr4542183wmf.101.1542550722544;
        Sun, 18 Nov 2018 06:18:42 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:42 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Mesih Kilinc <mesihkilnc@gmail.com>
Subject: [RFC PATCH v2 13/14] ARM: dts: suniv: add initial DTSI file for F1C100s
Date:   Sun, 18 Nov 2018 17:17:12 +0300
Message-Id: <b1cc86d5330df59e75914ab3c3a773900b589455.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F1C100s is one product with the suniv die, which has a 32MiB co-packaged
DDR1 DRAM chip. As we have the support for suniv pin controller and CCU now, add a
initial DTSI for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilnc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 158 +++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
new file mode 100644
index 0000000..d98f658
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
+ * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
+ */
+
+#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
+#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		osc24M: clk-24M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
+		};
+
+		osc32k: clk-32k {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
+		};
+
+		fake100M: clk-100M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+			clock-output-names = "fake-100M";
+		};
+	};
+
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		sram-controller@1c00000 {
+			compatible = "allwinner,sun4i-a10-sram-controller";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_d: sram@10000 {
+				compatible = "mmio-sram";
+				reg = <0x00010000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00010000 0x1000>;
+
+				otg_sram: sram-section@0 {
+					compatible = "allwinner,sun4i-a10-sram-d";
+					reg = <0x0000 0x1000>;
+					status = "disabled";
+				};
+			};
+		};
+
+		ccu: clock@1c20000 {
+			compatible = "allwinner,suniv-f1c100s-ccu";
+			reg = <0x01c20000 0x400>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		intc: interrupt-controller@1c20400 {
+			compatible = "allwinner,suniv-f1c100s-ic";
+			reg = <0x01c20400 0x400>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		pio: pinctrl@1c20800 {
+			compatible = "allwinner,suniv-f1c100s-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <38>, <39>, <40>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#gpio-cells = <3>;
+
+			uart0_pins_a: uart-pins-pe {
+				pins = "PE0", "PE1";
+				function = "uart0";
+			};
+		};
+
+		timer@1c20c00 {
+			compatible = "allwinner,suniv-f1c100s-timer";
+			reg = <0x01c20c00 0x90>;
+			interrupts = <13>;
+			clocks = <&osc24M>;
+		};
+
+		wdt: watchdog@1c20ca0 {
+			compatible = "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+		};
+
+		uart0: serial@1c25000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25000 0x400>;
+			interrupts = <1>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		uart1: serial@1c25400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25400 0x400>;
+			interrupts = <2>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			status = "disabled";
+		};
+
+		uart2: serial@1c25800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25800 0x400>;
+			interrupts = <3>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4


Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ACBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73157214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdQM4xhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73157214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbeKVFHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38549 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387427AbeKVFHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so3274703wrw.5;
        Wed, 21 Nov 2018 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nwmip1A+la+a07VN/rOqBKthSuSlBcSoXvJ85NRv8pE=;
        b=VdQM4xhCKTuSoI2tcgrWbhAa9PcTDUEH/69Rh85IJSEu04MZDopdRt9FZvPjQ1tp1x
         CQGY28KZ3UGFXvxWcUWGqbjs50HN1CpL5lv/xbxZB5STdT7M9BvYppRVmrxR18kZM//5
         va7OU4H/GfqGizeM7zdGWUsErmb92O5ghfCdWWnPDjjGSsEX234gHDn66jMcqsIvg0V2
         b+a9RcuAVMCvN7EtFMUtqkWHbW6OuYCnum7KgG4oOdDUPikf49g/62KA0w7HcJrhMG82
         hBYmf8avWsWY944X0p3DYTtL1/ncA2KeMhh+a89kKwO1GobvS+o31K541f6xm0/hIG1y
         kT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nwmip1A+la+a07VN/rOqBKthSuSlBcSoXvJ85NRv8pE=;
        b=If7ZjFb82roVAv7Rz4jDZPenCKCW+pPEztv7vDZLrDTGqxP1uhO/byv3AtzCo09Dni
         YAAmURTOE4jprLh/md85VPQ2dkCdfOegOnRdz2PUVVbsZauBqcmndEeja54njE9zPM63
         CLwjg1fCwjYp1WmmFWHh8z5Jt/HGdgqA7W/P/ck6MbhcqkE4BgycApzv3Vo4bogbPJ7x
         gjuzTRTq/HSHyboyV6aljwH3c6AuKj++vWkOfPYPsvPfwg6Jb1CYNMIPeluCRcGPw1vH
         OC2YEFjKk14LbCyB4H4EtOAwyc5vVKvPbgvNv3wZGef3L8+ZDDW1BG7T1usiHoZFPEqs
         +4tQ==
X-Gm-Message-State: AA+aEWauVswWYmIfadCQQ49zhuDoK0v94fs2T/weyg0ON3aKG7sMTp4i
        Q4fgHgxP1UBKD/pPdQR4gLj+ApleU08=
X-Google-Smtp-Source: AFSGD/VYJZLSAqa/z2p5KSPjl2GKDIaWBvXqZi3NLNjY75BVY19bLsajvInnmCzxblRlxhT+WHg4KQ==
X-Received: by 2002:adf:b716:: with SMTP id l22mr7173491wre.186.1542825133170;
        Wed, 21 Nov 2018 10:32:13 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:32:12 -0800 (PST)
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
Subject: [RFC PATCH v3 16/17] ARM: dts: suniv: add initial DTSI file for F1C100s
Date:   Wed, 21 Nov 2018 21:30:49 +0300
Message-Id: <05dab577154c72117678c2f49ae85a9663a630e2.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F1C100s is one product with the suniv die, which has a 32MiB co-packaged
DDR1 DRAM chip. As we have the support for suniv pin controller and CCU now, add a
initial DTSI for it.

Signed-off-by: Mesih Kilinc <mesihkilnc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 151 +++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
new file mode 100644
index 0000000..3ad64ee
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -0,0 +1,151 @@
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
+			compatible = "allwinner,suniv-f1c100s-system-control";
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
+					compatible = "allwinner,suniv-f1c100s-sram-d";
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
+			compatible = "allwinner,suniv-f1c100s-wdt";
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


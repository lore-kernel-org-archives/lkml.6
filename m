Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09878C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BDA2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga3BkypM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BDA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeK2Jhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46722 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbeK2Jhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so27906140wrt.13;
        Wed, 28 Nov 2018 14:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9WG2eU/ejG4wAWToKoueA27/6ygzN1rLZLWAo8LIhNE=;
        b=ga3BkypMafnIrlIbTkOz7SkxXzmYMDMUlEcgr2JTXWZhpvI+aG8kd83AUIFgVSjeXA
         ellD4QPs7Ssv/URymLaizJqg+caslTJ8a7wDtWL5pbC75wv49SytulWzkmWTD2JN6BwS
         Jj1ZIz/up5rwjkXLQnfxtSUcqRruoFS0VJDBbd3RclYdNySiPSjQsQ24TBrLo5AQQspg
         4hE4CH7vvSeL0aIgcqY1OpEczZaIg/jffchAUGeVnMVHq5mcgrE7IQcYtPfXG1ktPKZ8
         YBgLeM902M7dW1KzzXL5V5doK9FibPz49T/TAQ+idiMBnnoQNx73yUv7vT2uSt8+GQyP
         x4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9WG2eU/ejG4wAWToKoueA27/6ygzN1rLZLWAo8LIhNE=;
        b=VyAAX6BYvr2ya9czUV3OmXXAfce32XbbMGQqsypV8++qXt0M/e2LCSDp6mFMDKA3k2
         KRyvi8QyowfeQWiMkrmjNVH9rMwHYti0+ZKPQQiPtjlIj1p6Vm9GWNtxUR3zJ5+zCpei
         i+wE0agKQRfXeehrEcTowoB9z/lqUkr2Kt3kae4YjXbMe9w5LmX1UYJ2sTIUJEinqfwC
         GXhCFUV+4dhb0T4XWJ5BwyOgGlqB/C3fk3JZ6SScRPSrbXb9Kd8HieZhveiFmX/P7ZiK
         d4AfFTT1Dx//ur96HY4w/1asT1Vh1paJKp7Jj8NdtqLdc6P23AsQGjsh7Kskx0ZKA7Up
         EweQ==
X-Gm-Message-State: AA+aEWbIrDDwOeX9u/TTeJyhxIe/1Xw1LLJMdmg8rdeO5jr5xcTr7l7e
        UPPyxfL4IoHFrB9QVdzSzjkVVjt+0u8=
X-Google-Smtp-Source: AFSGD/U/J4HMWDVg4+d+ZUM3QbF6zHFGbTdN0nSG8bSWCDEn/WhRA4iJDCl8HzEe0AbLc1HMjELSyg==
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr34191114wro.218.1543444479105;
        Wed, 28 Nov 2018 14:34:39 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:38 -0800 (PST)
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
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v5 16/17] ARM: dts: suniv: add initial DTSI file for F1C100s
Date:   Thu, 29 Nov 2018 01:33:26 +0300
Message-Id: <ad582610c3df538ad192fbec4231a634c6aab583.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F1C100s is one product with the suniv die, which has a 32MiB co-packaged
DDR1 DRAM chip. As we have the support for suniv pin controller and CCU now, add a
initial DTSI for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/boot/dts/suniv-f1c100s.dtsi | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
new file mode 100644
index 0000000..aff5f90
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -0,0 +1,147 @@
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
+			compatible = "allwinner,suniv-f1c100s-system-control",
+				     "allwinner,sun4i-a10-system-control";
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
+					compatible = "allwinner,suniv-f1c100s-sram-d",
+						     "allwinner,sun4i-a10-sram-d";
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
+			clocks = <&ccu 37>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#gpio-cells = <3>;
+
+			uart0_pe_pins: uart0-pe-pins {
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
+			compatible = "allwinner,suniv-f1c100s-wdt",
+				     "allwinner,sun4i-a10-wdt";
+			reg = <0x01c20ca0 0x20>;
+		};
+
+		uart0: serial@1c25000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25000 0x400>;
+			interrupts = <1>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu 38>;
+			resets = <&ccu 24>;
+			status = "disabled";
+		};
+
+		uart1: serial@1c25400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25400 0x400>;
+			interrupts = <2>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu 39>;
+			resets = <&ccu 25>;
+			status = "disabled";
+		};
+
+		uart2: serial@1c25800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25800 0x400>;
+			interrupts = <3>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu 40>;
+			resets = <&ccu 26>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4


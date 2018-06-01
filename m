Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeFARfm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:35:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38216 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeFARfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:35:40 -0400
X-Google-Smtp-Source: ADUXVKK6GDJps1+nazgHcENiYpTTsXnr0Dw+BTnd4bsxmo5BUq4JxmLKdU0Rq57Ka5OxSC/EsBsAWw==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/2] arm64: allwinner: a64: Add RTC clock to phandle 32kHz external oscillator
Date: Fri,  1 Jun 2018 23:05:26 +0530
Message-Id: <20180601173527.18051-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Outside of SOC few chips need external clock source
through RTC example Wifi chip. So RTC clock nodes to
phandle 32kHz external oscillator.

prefix rtc- with clock-output-names defined in
dt-binding to avoid confusion with existing osc32k name.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- squash of previous v2 patch

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..82516aec4153 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -634,6 +634,9 @@
 			reg = <0x01f00000 0x54>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
 		};
 
 		r_intc: interrupt-controller@1f00c00 {
-- 
2.14.3

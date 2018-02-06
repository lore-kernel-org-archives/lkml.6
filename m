Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeBFJ3V (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:29:21 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40740 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeBFJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:29:03 -0500
X-Google-Smtp-Source: AH8x2274GOg7dTzzn7k0QRa+tKBXixumaUUc7ihLppadaaDPer0wl4NT3eYplOgYSGWRiL37GWNotQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@spreadtrum.com, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 5/7] arm64: dts: Add watchdog device node for Spreadtrum SC9860
Date: Tue,  6 Feb 2018 17:28:24 +0800
Message-Id: <9b1a2b944df46b7127dce3baa237e1bfbc5ed2b6.1517908478.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the watchdog device node for Spreadtrum SC9860 platform to
watch the system's stability.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 3dc6389..f2cdf4d 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -141,6 +141,15 @@
 				compatible = "sprd,sc9860-pinctrl";
 				reg = <0 0x402a0000 0 0x10000>;
 			};
+
+			watchdog@40310000 {
+				compatible = "sprd,sp9860-wdt";
+				reg = <0 0x40310000 0 0x1000>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				timeout-sec = <12>;
+				clock-names = "enable";
+				clocks = <&aon_gate CLK_APCPU_WDG_EB>;
+			};
 		};
 	};
 
-- 
1.7.9.5

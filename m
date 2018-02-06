Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeBFJaF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:30:05 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42640 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752689AbeBFJ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:28:59 -0500
X-Google-Smtp-Source: AH8x2273UOYR5oKI+EdA45qRwUEEaW8Mxya+D+Aj5Fzz/8LVuhN+dN4XevaX5kE5pOAg0SrVw5CpOA==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@spreadtrum.com, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 4/7] arm64: dts: Add timer node for Spreadtrum SC9860
Date: Tue,  6 Feb 2018 17:28:23 +0800
Message-Id: <46052ca3b42066deeb0f90d13592bb0cc53902c1.1517908478.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
In-Reply-To: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
References: <410b2f2d3f3f019c96ec31213647c41cd7f1174d.1517908478.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use one always-on timer to be the broadcast device, thus add
the timer device node for Spreadtrum SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 23cedbd..3dc6389 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -122,6 +122,13 @@
 				#size-cells = <0>;
 			};
 
+			timer@40050000 {
+				compatible = "sprd,sc9860-timer";
+				reg = <0 0x40050000 0 0x20>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&ext_32k>;
+			};
+
 			hwlock: hwspinlock@40500000 {
 				compatible = "sprd,hwspinlock-r3p0";
 				reg = <0 0x40500000 0 0x1000>;
-- 
1.7.9.5

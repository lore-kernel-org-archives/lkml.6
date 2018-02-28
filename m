Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbeB1KsA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:48:00 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36809 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeB1Kr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:47:56 -0500
X-Google-Smtp-Source: AH8x225QnV6LPvwLjHPCd24NwXmIkL/n+OAfuDNcTXNTO3MUtAf3rWWMeHcOPZttMzzj4Rjr7GGZKw==
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de
Cc: chunyan.zhang@linaro.org, orson.zhai@spreadtrum.com,
        mathieu.poirier@linaro.org, devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [RESEND PATCH 2/7] arm64: dts: Add ADI device node for Spreadtrum SC9860
Date: Wed, 28 Feb 2018 18:47:05 +0800
Message-Id: <459e248911c44411fcf5171d4cdf0058dea850cf.1519814593.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
In-Reply-To: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
References: <5ec790b43c6fea9f36e06b5b20233b2adebd7d50.1519814593.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will access the PMIC through ADI controller, thus this patch adds
the ADI device node for Spreadtrum SC9860 platform.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |    1 +
 arch/arm64/boot/dts/sprd/whale2.dtsi      |    9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 0362ecd..550f323 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -22,6 +22,7 @@
 		serial1 = &uart1; /* UART console */
 		serial2 = &uart2; /* Reserved */
 		serial3 = &uart3; /* for GPS */
+		spi0 = &adi_bus;
 	};
 
 	memory{
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index b9cc0fb..63fe89e 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -113,6 +113,15 @@
 			#size-cells = <2>;
 			ranges;
 
+			adi_bus: spi@40030000 {
+				compatible = "sprd,sc9860-adi";
+				reg = <0 0x40030000 0 0x10000>;
+				hwlocks = <&hwlock 0>;
+				hwlock-names = "adi";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
 			hwlock: hwspinlock@40500000 {
 				compatible = "sprd,hwspinlock-r3p0";
 				reg = <0 0x40500000 0 0x1000>;
-- 
1.7.9.5

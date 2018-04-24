Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeDXRh3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbeDXRh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:37:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1EC21735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFT][PATCH] arm64: dts: exynos: Remove unneeded address space mapping for soc node
Date: Tue, 24 Apr 2018 19:36:52 +0200
Message-Id: <20180424173652.14735-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the address space mapping between root and soc nodes to fix
DTC warnings in Exynos5433 and Exynos7 like:

    arch/arm64/boot/dts/exynos/exynos5433-tm2.dtb:
        Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested.
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 828996a06610..ba8157ceaa56 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -18,8 +18,8 @@
 
 / {
 	compatible = "samsung,exynos5433";
-	#address-cells = <2>;
-	#size-cells = <2>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	interrupt-parent = <&gic>;
 
@@ -235,7 +235,7 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x18000000>;
+		ranges;
 
 		arm_a53_pmu {
 			compatible = "arm,cortex-a53-pmu", "arm,armv8-pmuv3";
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 0b98d2334cad..93a84338938a 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -12,8 +12,8 @@
 / {
 	compatible = "samsung,exynos7";
 	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	aliases {
 		pinctrl0 = &pinctrl_alive;
@@ -70,7 +70,7 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0 0 0 0x18000000>;
+		ranges;
 
 		chipid@10000000 {
 			compatible = "samsung,exynos4210-chipid";
-- 
2.14.1

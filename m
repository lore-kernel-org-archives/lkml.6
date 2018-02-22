Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBVTLn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbeBVTLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:11:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022F821747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] ARM: dts: exynos: Fix address of PPMU ACP on Exynos4210
Date: Thu, 22 Feb 2018 20:11:10 +0100
Message-Id: <20180222191111.23747-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in unit address of PPMU ACP caused DTC warnings:

    arch/arm/boot/dts/exynos4412-odroidu3.dtb:
        Warning (simple_bus_reg): Node /soc/ppmu_acp@10ae0000 simple-bus unit address format error, expected "106e0000"

PPMU ACP (under 0x10ae0000 address) is present only in Exynos4210 so
move this node to exynos4210.dtsi with fixing the reg address to proper
one.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi    | 6 ------
 arch/arm/boot/dts/exynos4210.dtsi | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 967cd02401c5..909a9f2bf5be 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -821,12 +821,6 @@
 			status = "disabled";
 		};
 
-		ppmu_acp: ppmu_acp@10ae0000 {
-			compatible = "samsung,exynos-ppmu";
-			reg = <0x106e0000 0x2000>;
-			status = "disabled";
-		};
-
 		ppmu_rightbus: ppmu_rightbus@112a0000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x112a0000 0x2000>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 853604d91158..88fb47cef9a8 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -162,6 +162,12 @@
 			iommus = <&sysmmu_g2d>;
 		};
 
+		ppmu_acp: ppmu_acp@10ae0000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10ae0000 0x2000>;
+			status = "disabled";
+		};
+
 		ppmu_lcd1: ppmu_lcd1@12240000 {
 			compatible = "samsung,exynos-ppmu";
 			reg = <0x12240000 0x2000>;
-- 
2.14.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeEFQLH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 12:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeEFQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 12:10:58 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/3] ARM: dts: s3c24xx: Fix unnecessary address/size cells DTC warnings
Date: Sun,  6 May 2018 18:10:24 +0200
Message-Id: <20180506161025.26937-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180506161025.26937-1-krzk@kernel.org>
References: <20180506161025.26937-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix DTC warnings:

    arch/arm/boot/dts/s3c2416-smdk2416.dtb: Warning (avoid_unnecessary_addr_size):
        /cpus: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
    arch/arm/boot/dts/s3c2416-smdk2416.dtb: Warning (avoid_unnecessary_addr_size):
        /clocks: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c2416-smdk2416.dts | 2 --
 arch/arm/boot/dts/s3c2416.dtsi         | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index 5ef1144afceb..5164386aff3a 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -19,8 +19,6 @@
 
 	clocks {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
 
 		xti: xti {
 			compatible = "fixed-clock";
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 46cf85f3c18b..6adf64ea3ff2 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -18,9 +18,6 @@
 	};
 
 	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
 		cpu {
 			compatible = "arm,arm926ej-s";
 		};
-- 
2.14.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbeDUSbO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 14:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753158AbeDUSbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 14:31:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3A021486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Fix invalid node referenced by i2c20 alias
Date: Sat, 21 Apr 2018 20:30:31 +0200
Message-Id: <20180421183031.21195-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After moving all nodes under "soc" node in commit 5d99cc59a3c6 ("ARM:
dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc"), the i2c20
alias stopped point to proper node:

    arch/arm/boot/dts/exynos5420-peach-pit.dtb: Warning (alias_paths):
        /aliases:i2c20: aliases property is not a valid node (/spi@12d40000/cros-ec@0/i2c-tunnel)
    arch/arm/boot/dts/exynos5800-peach-pi.dtb: Warning (alias_paths):
        /aliases:i2c20: aliases property is not a valid node (/spi@12d40000/cros-ec@0/i2c-tunnel)

Fixes: 5d99cc59a3c6 ("ARM: dts: exynos: Move Exynos5250 and Exynos5420 nodes under soc")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 ++--
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 244f0091c21f..57c2332bf282 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -29,7 +29,7 @@
 
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
-		i2c20 = "/spi@12d40000/cros-ec@0/i2c-tunnel";
+		i2c20 = &i2c_tunnel;
 	};
 
 	backlight: backlight {
@@ -970,7 +970,7 @@
 			samsung,spi-feedback-delay = <1>;
 		};
 
-		i2c-tunnel {
+		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 2f8df9244f72..d80ab9085da1 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -27,7 +27,7 @@
 
 	aliases {
 		/* Assign 20 so we don't get confused w/ builtin ones */
-		i2c20 = "/spi@12d40000/cros-ec@0/i2c-tunnel";
+		i2c20 = &i2c_tunnel;
 	};
 
 	backlight: backlight {
@@ -939,7 +939,7 @@
 			samsung,spi-feedback-delay = <1>;
 		};
 
-		i2c-tunnel {
+		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.14.1

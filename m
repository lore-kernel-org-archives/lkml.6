Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeCOL4C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 07:56:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37040 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCOLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 07:55:54 -0400
X-Google-Smtp-Source: AG47ELtzNmze9tZcrEotauV7efSCf/XeebVUy/W8rmFzjFn+M/G2S+Orp2U2oqF0u1lAlaKeaY0q6w==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM64: dts: meson-gx: sysctrl is the parent of the clock controller
Date: Thu, 15 Mar 2018 12:55:43 +0100
Message-Id: <20180315115545.1884-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315115545.1884-1-jbrunet@baylibre.com>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parent of the meson-gx clock controller should be the hhi system
controller, not the HIU bus. This way, the HHI register region can be
used safely by multiple drivers

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 5 ++---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index cac72acb85b1..a48d2b821a49 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -304,11 +304,10 @@
 	clock-names = "isfr", "iahb", "venci";
 };
 
-&hiubus {
-	clkc: clock-controller@0 {
+&sysctrl {
+	clkc: clock-controller {
 		compatible = "amlogic,gxbb-clkc";
 		#clock-cells = <1>;
-		reg = <0x0 0x0 0x0 0x3db>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index e1a39cbed8c9..6b7dfa2d48e4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -206,11 +206,10 @@
 	clock-names = "isfr", "iahb", "venci";
 };
 
-&hiubus {
-	clkc: clock-controller@0 {
+&sysctrl {
+	clkc: clock-controller {
 		compatible = "amlogic,gxl-clkc", "amlogic,gxbb-clkc";
 		#clock-cells = <1>;
-		reg = <0x0 0x0 0x0 0x3db>;
 	};
 };
 
-- 
2.14.3

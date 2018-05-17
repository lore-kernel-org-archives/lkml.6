Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeEQJcD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:32:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55910 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeEQJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:31:17 -0400
X-Google-Smtp-Source: AB8JxZoxPik5KTbTNbC3jd5p1Tpmv+6eYXXmiyg/kKz7sVlF5SYFtvyaPWm9ReCTXbWVGywkhtHsgA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ARM64: dts: meson-axg: correct i2c AO clock
Date: Thu, 17 May 2018 11:30:58 +0200
Message-Id: <20180517093100.22225-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180517093100.22225-1-jbrunet@baylibre.com>
References: <20180517093100.22225-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock specified for the i2c AO controller is the one for the EE
domain, which is incorrect as this controller needs the clock for AO
i2c controller.

Fixes: dc6f858e2690 ("ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b59f341104d7..d213ab715e03 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1110,7 +1110,7 @@
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x05000 0x0 0x20>;
 				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
+				clocks = <&clkc CLKID_AO_I2C>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.14.3

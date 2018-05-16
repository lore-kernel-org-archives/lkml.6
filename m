Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeEPPwf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:52:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41472 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeEPPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:52:17 -0400
X-Google-Smtp-Source: AB8JxZoJ3YfokKmGCkyOICXMNWxWvFgDeeLUAPPPaSd00/m9Cce5g8dwj1AQIc4gqHnV7molftJStA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM64: dts: meson-axg: remove incorrect i2c ao clock
Date: Wed, 16 May 2018 17:52:03 +0200
Message-Id: <20180516155203.24922-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516155203.24922-1-jbrunet@baylibre.com>
References: <20180516155203.24922-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock specified for the i2c AO controller is the one from
the EE domain, which is incorrect as this controller needs the
clock from AO clock controller.

Replace with xtal to avoid claiming an unrelated gate until the
required clock controller becomes available.

Fixes: dc6f858e2690 ("ARM64: dts: meson-axg: add I2C DT info for Meson-AXG SoC")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b59f341104d7..b82b9d79ec49 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1110,7 +1110,12 @@
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x05000 0x0 0x20>;
 				interrupts = <GIC_SPI 195 IRQ_TYPE_EDGE_RISING>;
-				clocks = <&clkc CLKID_I2C>;
+
+				/*
+				 * FIXME: replace with the correct clock when
+				 * the controller is available
+				 */
+				clocks = <&xtal>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				status = "disabled";
-- 
2.14.3

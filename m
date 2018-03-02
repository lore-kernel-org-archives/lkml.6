Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428271AbeCBNoo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:44:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50238 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424532AbeCBNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:44:41 -0500
X-Google-Smtp-Source: AG47ELtRmo3W+cDv3E4NyiCJoOdK3YJQ1bQvZyQ0t+YwdtxmCGitp+pSbpc/aIJ08nmbm07Y5YVO/A==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: ellierevves@gmail.com, Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson: reduce odroid-c2 eMMC maximum rate
Date: Fri,  2 Mar 2018 14:44:36 +0100
Message-Id: <20180302134436.18844-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different modules maybe installed by the user on the eMMC connector
of the odroid-c2. While the red modules are working without an issue,
it seems some black modules (apparently Samsung based) are having
issue at 200MHz

While the tuning algorithm introduced in v4.14 enables high speed modes
on every other tested designs, it seems a problem remains for this
particular combination of board and eMMC module.

Lowering the maximum frequency of the eMMC on this board until we can
figure out a better solution.

Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
Suggested-by: Ellie Reeves <ellierevves@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 73a030a5ecf3..43475139576c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -311,7 +311,7 @@
 	pinctrl-names = "default", "clk-gate";
 
 	bus-width = <8>;
-	max-frequency = <200000000>;
+	max-frequency = <100000000>;
 	non-removable;
 	disable-wp;
 	cap-mmc-highspeed;
-- 
2.14.3

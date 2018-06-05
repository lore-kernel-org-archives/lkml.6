Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeFEKI0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 06:08:26 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:47854 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeFEKIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 06:08:25 -0400
From: Keerthy <j-keerthy@ti.com>
To: <nsekhar@ti.com>
CC: <khilman@kernel.org>, <robh+dt@kernel.org>, <j-keerthy@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ARM: dts: da850: Fix interrups property for gpio
Date: Tue, 5 Jun 2018 15:37:51 +0530
Message-ID: <1528193271-10726-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intc #interrupt-cells is equal to 1. Currently gpio
node has 2 cells per IRQ which is wrong. Remove the additional
cell for each of the interrupts.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Fixes: 2e38b946dc54 ("ARM: davinci: da850: add GPIO DT node")
---

Changes in v2:

  * Fixed $Subject

 arch/arm/boot/dts/da850.dtsi | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index f6f1597..0f4f817 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -549,11 +549,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			reg = <0x226000 0x1000>;
-			interrupts = <42 IRQ_TYPE_EDGE_BOTH
-				43 IRQ_TYPE_EDGE_BOTH 44 IRQ_TYPE_EDGE_BOTH
-				45 IRQ_TYPE_EDGE_BOTH 46 IRQ_TYPE_EDGE_BOTH
-				47 IRQ_TYPE_EDGE_BOTH 48 IRQ_TYPE_EDGE_BOTH
-				49 IRQ_TYPE_EDGE_BOTH 50 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <42 43 44 45 46 47 48 49 50>;
 			ti,ngpio = <144>;
 			ti,davinci-gpio-unbanked = <0>;
 			status = "disabled";
-- 
1.9.1

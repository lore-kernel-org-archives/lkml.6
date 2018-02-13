Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934743AbeBMJot (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:44:49 -0500
Received: from mail.microcatalog.org.uk ([217.6.246.34]:44455 "EHLO
        root.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933805AbeBMJog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:44:36 -0500
From: Daniel Schultz <d.schultz@phytec.de>
To: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: rockchip: phycore: Remove 1.8 GHz operation point
Date: Tue, 13 Feb 2018 10:44:32 +0100
Message-Id: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
X-Mailer: git-send-email 2.7.4
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:44:34,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.02.2018 10:44:34,
        Serialize complete at 13.02.2018 10:44:34
X-TNEFEvaluated: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip recommends to run the CPU cores only with operations points of
1.6 GHz or lower.

Removed the cpu0 node with too high operation points and use the default
values instead.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 99cfae8..5eae477 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -110,26 +110,6 @@
 	};
 };
 
-&cpu0 {
-	cpu0-supply = <&vdd_cpu>;
-	operating-points = <
-		/* KHz    uV */
-		1800000	1400000
-		1608000	1350000
-		1512000 1300000
-		1416000 1200000
-		1200000 1100000
-		1008000 1050000
-		 816000 1000000
-		 696000  950000
-		 600000  900000
-		 408000  900000
-		 312000  900000
-		 216000  900000
-		 126000  900000
-	>;
-};
-
 &emmc {
 	status = "okay";
 	bus-width = <8>;
-- 
2.7.4

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBFO04 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:26:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34458 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeBFO0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:26:41 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 3/3] ARM: dts: imx53: PPD: Enable secure-reg-access
Date: Tue,  6 Feb 2018 15:26:29 +0100
Message-Id: <20180206142629.534-4-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
References: <20180206142629.534-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@collabora.com>

Add secure-reg-access on PPD device tree to enable PMU and
hardware counters for perf.

Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 4 ++++
 arch/arm/boot/dts/imx53.dtsi    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index cce959438a79..4ecbe6e4eecb 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -556,6 +556,10 @@
 	};
 };
 
+&pmu {
+	secure-reg-access;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 1040251f2951..7df4853dc771 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -116,7 +116,7 @@
 		};
 	};
 
-	pmu {
+	pmu: pmu {
 		compatible = "arm,cortex-a8-pmu";
 		interrupt-parent = <&tzic>;
 		interrupts = <77>;
-- 
2.15.1

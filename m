Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934654AbeBLMkM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:40:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39262 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934557AbeBLMj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:39:56 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 2/2] ARM: dts: imx53: PPD: Enable secure-reg-access
Date: Mon, 12 Feb 2018 13:39:45 +0100
Message-Id: <20180212123945.15732-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add secure-reg-access on PPD device tree to enable PMU and
hardware counters for perf.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx53-ppd.dts | 4 ++++
 arch/arm/boot/dts/imx53.dtsi    | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index dd1b524e5074..3c87e0d73f63 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -562,6 +562,10 @@
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

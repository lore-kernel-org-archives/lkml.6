Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeBERIx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:08:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58344 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeBERIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:08:44 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: Ian Ray <ian.ray@ge.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2] ARM: dts: imx6q-bx50v3: Enable secure-reg-access
Date: Mon,  5 Feb 2018 18:08:40 +0100
Message-Id: <20180205170840.14045-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180205052659.GA31354@dragon>
References: <20180205052659.GA31354@dragon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@collabora.com>

Enable secure debug enable register access for Bx50v3 devices to enable
PMU and hardware counters for perf.

Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes since PATCHv1:
 * add property by adding a label to the pmu node in imx6qdl and
   referencing it in bx50v3.dtsi.
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 4 ++++
 arch/arm/boot/dts/imx6qdl.dtsi      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index 916ea94d75ca..2baffc8b9094 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -388,3 +388,7 @@
 		#interrupt-cells = <1>;
 	};
 };
+
+&pmu {
+	secure-reg-access;
+};
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 59ff86695a14..2b921de44c02 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -143,7 +143,7 @@
 		};
 	};
 
-	pmu {
+	pmu: pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupt-parent = <&gpc>;
 		interrupts = <0 94 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.15.1

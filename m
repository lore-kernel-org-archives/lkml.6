Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754347AbeCVLuz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 07:50:55 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:26657 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754267AbeCVLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 07:50:48 -0400
X-IronPort-AV: E=Sophos;i="5.48,344,1517842800";
   d="scan'208";a="274538272"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 7/8] DT: arm: Add Renesas RZN1D-DB Board base file
Date: Thu, 22 Mar 2018 11:44:44 +0000
Message-Id: <1521719091-25157-8-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a base device tree file for the RZN1-DB board, with only the
basic support allowing the system to boot to a prompt. Only one UART is
used, with only a single CPU running.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts

diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
new file mode 100644
index 0000000..a462b1a
--- /dev/null
+++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-db.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZN1D-DB Board
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ */
+
+/dts-v1/;
+
+#include "r9a06g0xx.dtsi"
+
+/ {
+	model = "RZN1D-DB Board";
+	compatible = "renesas,rzn1d400-db", "renesas,r9a06g032", "renesas,rzn1";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+	aliases {
+		serial0 = &uart0;
+	};
+};
+&uart0 {
+	status = "okay";
+};
-- 
2.7.4

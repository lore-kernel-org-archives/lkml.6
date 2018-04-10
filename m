Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752724AbeDJIgJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:36:09 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:19423 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751888AbeDJIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:36:06 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517842800";
   d="scan'208";a="277754389"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, buserror+upstream@gmail.com,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 3/8] dt-bindings: mfd: renesas,rzn1-sysctrl: document RZ/N1 sysctrl node
Date: Tue, 10 Apr 2018 09:30:03 +0100
Message-Id: <1523349015-37985-4-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523349015-37985-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1 Family (Part #R9A06G0xx) has a multi-function
system controller. This documents the node used to encapsulate
it's sub drivers.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/mfd/renesas,rzn1-sysctrl.txt          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt

diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
new file mode 100644
index 0000000..9897f8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/renesas,rzn1-sysctrl.txt
@@ -0,0 +1,23 @@
+DT bindings for the Renesas RZ/N1 System Controller
+
+== System Controller Node ==
+
+The system controller node currently only hosts a single sub-node to handle
+the rebooting of the CPU. Eventually it will host the clock driver, SMP
+start handler, watchdog etc.
+
+See renesas,rzn1-reboot.txt for further details.
+
+Bindings:
++ Required:
+	compatible = "renesas,r9a06g032-sysctrl",
+			"renesas,rzn1-sysctrl",
+			"syscon", "simple-mfd";
+
+Example:
+	sysctrl: sysctrl@4000c000 {
+		compatible = "renesas,r9a06g032-sysctrl",
+				"renesas,rzn1-sysctrl",
+				"syscon", "simple-mfd";
+		reg = <0x4000c000 0x1000>;
+	};
-- 
2.7.4

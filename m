Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeC2Hvn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:51:43 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:62650 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751935AbeC2Hvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:51:42 -0400
X-IronPort-AV: E=Sophos;i="5.48,375,1517842800";
   d="scan'208";a="276602217"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 2/8] DT: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
Date: Thu, 29 Mar 2018 08:46:58 +0100
Message-Id: <1522309629-10152-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
as part of the sysctrl MFD to handle rebooting the CA7 cores.
This documents the driver bindings.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../bindings/power/renesas,rzn1-reboot.txt           | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
new file mode 100644
index 0000000..f592769
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
@@ -0,0 +1,20 @@
+DT bindings for the Renesas RZ/N1 Reboot Driver
+
+== Reboot Driver Node ==
+
+The reboot driver is always a subnode of the system controller node, see
+renesas,rzn1-sysctrl.txt for details.
+
+Bindings:
++ Required:
+	compatible = "renesas,rzn1-reboot";
+
+Example:
+	sysctrl: sysctrl@4000c000 {
+		compatible = "renesas,rzn1-sysctrl", "syscon", "simple-mfd";
+		reg = <0x4000c000 0x1000>;
+
+		reboot {
+			compatible = "renesas,rzn1-reboot";
+		};
+	};
-- 
2.7.4

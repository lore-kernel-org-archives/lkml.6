Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeDXAqX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 20:46:23 -0400
Received: from anholt.net ([50.246.234.109]:34458 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932676AbeDXAqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 20:46:16 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 2/3] dt-bindings: Add a new binding for Broadcom V3D 3.x and newer GPUs.
Date: Mon, 23 Apr 2018 17:46:09 -0700
Message-Id: <20180424004610.4637-3-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424004610.4637-1-eric@anholt.net>
References: <20180424004610.4637-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These OpenGL ES GPUs are present in the 7268 and 7278 set top box
chips.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bindings/display/brcm,bcm-v3d.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt b/Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
new file mode 100644
index 000000000000..1c814714de0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/brcm,bcm-v3d.txt
@@ -0,0 +1,28 @@
+Broadcom V3D GPU
+
+Only the Broadcom V3D 3.x and newer GPUs are covered by this binding.
+For V3D 2.x, see brcm,bcm-vc4.txt.
+
+Required properties:
+- compatible:	Should be "brcm,7268-v3d" or "brcm,7278-v3d"
+- reg:		Physical base addresses and lengths of the register areas
+- reg-names:	Names for the register areas.  The "hub", "bridge", and "core0"
+		  register areas are always required.  The "gca" register area
+		  is required if the GCA cache controller is present.
+- interrupts:	The interrupt numbers.  The first interrupt is for the hub,
+		  while the following inerrupts are for the cores.
+		  See bindings/interrupt-controller/interrupts.txt
+
+Optional properties:
+- clocks:	The core clock the unit runs on
+
+v3d {
+	compatible = "brcm,7268-v3d";
+	reg = <0xf1204000 0x100>,
+	      <0xf1200000 0x4000>,
+	      <0xf1208000 0x4000>,
+	      <0xf1204100 0x100>;
+	reg-names = "bridge", "hub", "core0", "gca";
+	interrupts = <0 78 4>,
+		     <0 77 4>;
+};
-- 
2.17.0

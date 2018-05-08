Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbeEHMPn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:15:43 -0400
Received: from foss.arm.com ([217.140.101.70]:57580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932174AbeEHMPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:15:16 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] dt-bindings/gic-v3: Add documentation for MBI support
Date: Tue,  8 May 2018 13:14:38 +0100
Message-Id: <20180508121438.11301-10-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180508121438.11301-1-marc.zyngier@arm.com>
References: <20180508121438.11301-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required properties to support the MBI feature on GICv3.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 .../bindings/interrupt-controller/arm,gic-v3.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 0a57f2f4167d..3ea78c4ef887 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -57,6 +57,20 @@ Optional
   occupied by the redistributors. Required if more than one such
   region is present.
 
+- msi-controller: Boolean property. Identifies the node as an MSI
+  controller. Only present if the Message Based Interrupt
+  functionnality is being exposed by the HW, and the mbi-ranges
+  property present.
+
+- mbi-ranges: A list of pairs <intid span>, where "intid" is the first
+  SPI of a range that can be used an MBI, and "span" the size of that
+  range. Multiple ranges can be provided. Requires "msi-controller" to
+  be set.
+
+- mbi-alias: Address property. Base address of an alias of the GICD
+  region containing only the {SET,CLR}SPI registers to be used if
+  isolation is required, and if supported by the HW.
+
 Sub-nodes:
 
 PPI affinity can be expressed as a single "ppi-partitions" node,
@@ -99,6 +113,9 @@ Examples:
 		      <0x0 0x2c020000 0 0x2000>;	// GICV
 		interrupts = <1 9 4>;
 
+		msi-controller;
+		mbi-ranges = <256 128>;
+
 		gic-its@2c200000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
-- 
2.14.2

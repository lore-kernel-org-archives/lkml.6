Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeEMOIJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:08:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMOIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:08:07 -0400
Date: Sun, 13 May 2018 07:07:56 -0700
From: tip-bot for Marc Zyngier <tipbot@zytor.com>
Message-ID: <tip-53667c670fe00d63246fb3cfb4480bb1ba247bcc@git.kernel.org>
Cc: miquel.raynal@bootlin.com, hpa@zytor.com, robh@kernel.org,
        mingo@kernel.org, marc.zyngier@arm.com, tglx@linutronix.de,
        srinivas.kandagatla@linaro.org, thomas.petazzoni@bootlin.com,
        linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        jason@lakedaemon.net
Reply-To: jason@lakedaemon.net, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        srinivas.kandagatla@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mingo@kernel.org, robh@kernel.org, hpa@zytor.com,
        miquel.raynal@bootlin.com
In-Reply-To: <20180508121438.11301-10-marc.zyngier@arm.com>
References: <20180508121438.11301-10-marc.zyngier@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] dt-bindings/gic-v3: Add documentation for MBI
 support
Git-Commit-ID: 53667c670fe00d63246fb3cfb4480bb1ba247bcc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  53667c670fe00d63246fb3cfb4480bb1ba247bcc
Gitweb:     https://git.kernel.org/tip/53667c670fe00d63246fb3cfb4480bb1ba247bcc
Author:     Marc Zyngier <marc.zyngier@arm.com>
AuthorDate: Tue, 8 May 2018 13:14:38 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:59:02 +0200

dt-bindings/gic-v3: Add documentation for MBI support

Add the required properties to support the MBI feature on GICv3.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lkml.kernel.org/r/20180508121438.11301-10-marc.zyngier@arm.com

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

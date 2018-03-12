Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeCLW33 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:29:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:55859 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbeCLW32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:29:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="34420161"
Date: Mon, 12 Mar 2018 15:21:48 -0700
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 1/2] of: Documentation: Specify local APIC ID in "reg"
Message-ID: <a0a0aff3befabf74a65361d0b7b7e5bc9d00176d.1520891263.git.ivan.gorinov@intel.com>
References: <cover.1520891263.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520891263.git.ivan.gorinov@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the "reg" property to the processor's local APIC ID.
Local APIC ID is assigned by hardware and may differ from CPU number.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 Documentation/devicetree/bindings/x86/ce4100.txt | 38 ++++++++++++++++++------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
index b49ae59..5a4bd83 100644
--- a/Documentation/devicetree/bindings/x86/ce4100.txt
+++ b/Documentation/devicetree/bindings/x86/ce4100.txt
@@ -7,17 +7,37 @@ Many of the "generic" devices like HPET or IO APIC have the ce4100
 name in their compatible property because they first appeared in this
 SoC.
 
-The CPU node
-------------
-	cpu@0 {
-		device_type = "cpu";
-		compatible = "intel,ce4100";
-		reg = <0>;
-		lapic = <&lapic0>;
+The CPU nodes
+-------------
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "intel,ce4100";
+			reg = <0x00>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "intel,ce4100";
+			reg = <0x02>;
+		};
 	};
 
-The reg property describes the CPU number. The lapic property points to
-the local APIC timer.
+A "cpu" node describes one logical processor (hardware thread).
+
+Required properties:
+
+- device_type
+	Device type, must be "cpu".
+
+- reg
+	Local APIC ID, a unique number assigned to each processor by
+	hardware. This ID is used to specify the destination of interrupt
+	messages with "physical" destination mode, including startup IPI.
 
 The SoC node
 ------------
-- 
2.7.4

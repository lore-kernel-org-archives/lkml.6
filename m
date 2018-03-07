Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965828AbeCGTyi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:54:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:28473 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934658AbeCGTyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:54:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="23760033"
Date: Wed, 7 Mar 2018 11:47:05 -0800
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 3/4] of: Documentation: Add x86 local APIC ID property
Message-ID: <3a0359afad71abc0c0d682bfcd0dd66055f5d7e5.1520450752.git.ivan.gorinov@intel.com>
References: <cover.1520450752.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520450752.git.ivan.gorinov@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current x86 Device Tree implementation does not support multiprocessing.
Add new "intel,apic-id" property to allow using CPU descriptions
in Device Tree data provided by the U-Boot loader.
Address specified in 'reg' to be used as default local APIC ID
to avoid breaking existing systems with DTB provided by firmware.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 Documentation/devicetree/bindings/x86/ce4100.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
index b49ae59..d15de48 100644
--- a/Documentation/devicetree/bindings/x86/ce4100.txt
+++ b/Documentation/devicetree/bindings/x86/ce4100.txt
@@ -14,11 +14,17 @@ The CPU node
 		compatible = "intel,ce4100";
 		reg = <0>;
 		lapic = <&lapic0>;
+		intel,apic-id = <0>;
 	};
 
 The reg property describes the CPU number. The lapic property points to
 the local APIC timer.
 
+Optional properties:
+
+- intel,apic-id: local APIC ID.
+  The address specified in "reg" is used as default local APIC ID.
+
 The SoC node
 ------------
 
-- 
2.7.4

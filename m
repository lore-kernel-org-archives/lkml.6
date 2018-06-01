Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeFASVL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:21:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:14436 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbeFASVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:21:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="233889315"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH linux-next v5 01/13] dt-bindings: Add a document of PECI subsystem
Date: Fri,  1 Jun 2018 11:21:03 -0700
Message-Id: <20180601182103.23630-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a document of generic PECI bus, adapter and client
driver.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/peci/peci.txt         | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/peci/peci.txt

diff --git a/Documentation/devicetree/bindings/peci/peci.txt b/Documentation/devicetree/bindings/peci/peci.txt
new file mode 100644
index 000000000000..8db2b1e56a01
--- /dev/null
+++ b/Documentation/devicetree/bindings/peci/peci.txt
@@ -0,0 +1,59 @@
+Generic device tree configuration for PECI buses
+================================================
+
+Required properties:
+- compatible     : Should be "simple-bus".
+- #address-cells : Should be present if the device has sub-nodes.
+- #size-cells    : Should be present if the device has sub-nodes.
+- ranges         : Should contain PECI controller registers ranges.
+
+Example:
+	peci: peci@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x10000000 0x1000>;
+	};
+
+Generic device tree configuration for PECI adapters
+===================================================
+
+Required properties:
+- #address-cells : Should be <1>. Read more about client addresses below.
+- #size-cells    : Should be <0>. Read more about client addresses below.
+
+The cells properties above define that an address of CPU clients of a PECI bus
+are described by a single value.
+
+Example:
+	peci0: peci-bus@0 {
+		compatible = "soc,soc-peci";
+		reg = <0x0 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+Generic device tree configuration for PECI clients
+==================================================
+
+Required properties:
+- compatible : Should contain name of PECI client.
+- reg        : Should contain address of a client CPU. Address range of CPU
+	       clients is starting from 0x30 based on PECI specification.
+
+Example:
+	peci-bus@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		< more properties >
+
+		peci-client@30 {
+			compatible = "intel,peci-client";
+			reg = <0x30>;
+		};
+
+		peci-client@31 {
+			compatible = "intel,peci-client";
+			reg = <0x31>;
+		};
+	};
-- 
2.17.0

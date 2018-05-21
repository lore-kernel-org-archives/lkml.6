Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEUT7f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:59:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:12388 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbeEUT7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:59:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,427,1520924400";
   d="scan'208";a="201237200"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [v4 07/11] dt-bindings: hwmon: Add documents for PECI hwmon client drivers
Date: Mon, 21 May 2018 12:59:05 -0700
Message-Id: <20180521195905.27983-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds dt-bindings documents for PECI hwmon client drivers.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 .../bindings/hwmon/peci-cputemp.txt           | 23 ++++++++++++++++++
 .../bindings/hwmon/peci-dimmtemp.txt          | 24 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt

diff --git a/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
new file mode 100644
index 000000000000..2f59aee12d9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
@@ -0,0 +1,23 @@
+Bindings for Intel PECI (Platform Environment Control Interface) cputemp driver.
+
+Required properties:
+- compatible : Should be "intel,peci-cputemp".
+- reg        : Should contain address of a client CPU. Address range of CPU
+	       clients is starting from 0x30 based on PECI specification.
+
+Example:
+	peci-bus@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		< more properties >
+
+		peci-cputemp@30 {
+			compatible = "intel,peci-cputemp";
+			reg = <0x30>;
+		};
+
+		peci-cputemp@31 {
+			compatible = "intel,peci-cputemp";
+			reg = <0x31>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
new file mode 100644
index 000000000000..4592ce23f620
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
@@ -0,0 +1,24 @@
+Bindings for Intel PECI (Platform Environment Control Interface) dimmtemp
+driver.
+
+Required properties:
+- compatible : Should be "intel,peci-dimmtemp".
+- reg        : Should contain address of a client CPU. Address range of CPU
+	       clients is starting from 0x30 based on PECI specification.
+
+Example:
+	peci-bus@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		< more properties >
+
+		peci-dimmtemp@30 {
+			compatible = "intel,peci-dimmtemp";
+			reg = <0x30>;
+		};
+
+		peci-dimmtemp@31 {
+			compatible = "intel,peci-dimmtemp";
+			reg = <0x31>;
+		};
+	};
-- 
2.17.0

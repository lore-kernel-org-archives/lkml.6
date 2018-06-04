Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeFDTBG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 15:01:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751085AbeFDTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 15:01:02 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v9 1/7] dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
Date: Mon,  4 Jun 2018 14:00:44 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1528138850-18259-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060419-0040-0000-0000-0000043B179C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009129; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01042302; UDB=6.00533708; IPR=6.00821432;
 MB=3.00021461; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-04 19:00:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060419-0041-0000-0000-0000084117A2
Message-Id: <1528138850-18259-2-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=918 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-fsi.txt | 40 +++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-fsi.txt b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
new file mode 100644
index 0000000..b1be2ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-fsi.txt
@@ -0,0 +1,40 @@
+Device-tree bindings for FSI-attached I2C master and busses
+-----------------------------------------------------------
+
+Required properties:
+ - compatible = "ibm,i2c-fsi";
+ - reg = < address size >;		: The FSI CFAM address and address
+					  space size.
+ - #address-cells = <1>;		: Number of address cells in child
+					  nodes.
+ - #size-cells = <0>;			: Number of size cells in child nodes.
+ - child nodes				: Nodes to describe busses off the I2C
+					  master.
+
+Child node required properties:
+ - reg = < port number >		: The port number on the I2C master.
+
+Child node optional properties:
+ - child nodes				: Nodes to describe devices on the I2C
+					  bus.
+
+Examples:
+
+    i2c@1800 {
+        compatible = "ibm,i2c-fsi";
+        reg = < 0x1800 0x400 >;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        i2c-bus@0 {
+            reg = <0>;
+        };
+
+        i2c-bus@1 {
+            reg = <1>;
+
+            eeprom@50 {
+                compatible = "vendor,dev-name";
+            };
+        };
+    };
-- 
1.8.3.1

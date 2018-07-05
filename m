Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E832403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E832403A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754515AbeGESmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:42:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753975AbeGESkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:40:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65IYUqF126875
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 14:40:40 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1p326ncx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 14:40:40 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:40:40 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:40:36 -0600
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65IeZlo7274992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 11:40:35 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB4113604F;
        Thu,  5 Jul 2018 12:40:35 -0600 (MDT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CA59136053;
        Thu,  5 Jul 2018 12:40:34 -0600 (MDT)
Received: from talon7.ibm.com (unknown [9.41.102.69])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 12:40:34 -0600 (MDT)
From:   Eddie James <eajames@linux.vnet.ibm.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wsa@the-dreams.de, robh+dt@kernel.org, benh@kernel.crashing.org,
        joel@jms.id.au, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, peda@axentia.se,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v11 1/8] dt-bindings: i2c: Add FSI-attached I2C master dt binding documentation
Date:   Thu,  5 Jul 2018 13:40:23 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1530816030-13010-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070518-0012-0000-0000-000016883359
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009314; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057019; UDB=6.00542279; IPR=6.00834939;
 MB=3.00022012; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 18:40:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070518-0013-0000-0000-000053914970
Message-Id: <1530816030-13010-2-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=892 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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


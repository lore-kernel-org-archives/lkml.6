Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B73ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330FB2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330FB2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeKIGn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:43:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727536AbeKIGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:42:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8L0a0h081761
        for <linux-kernel@vger.kernel.org>; Thu, 8 Nov 2018 16:05:41 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nmsf7rjar-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 16:05:41 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Thu, 8 Nov 2018 21:05:40 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Nov 2018 21:05:37 -0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wA8L5aMd27525196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 21:05:36 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 667CF2805A;
        Thu,  8 Nov 2018 21:05:36 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FA5A28065;
        Thu,  8 Nov 2018 21:05:35 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  8 Nov 2018 21:05:35 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        jdelvare@suse.com, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@roeck-us.net, rdunlap@infradead.org,
        benh@kernel.crashing.org, Eddie James <eajames@linux.vnet.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v6 04/10] dt-bindings: i2c: Add P8 OCC hwmon device documentation
Date:   Thu,  8 Nov 2018 15:05:23 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
References: <1541711129-26631-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18110821-0060-0000-0000-000002CFBA21
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010009; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000269; SDB=6.01114610; UDB=6.00577887; IPR=6.00894709;
 MB=3.00024077; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-08 21:05:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18110821-0061-0000-0000-0000472272C3
Message-Id: <1541711129-26631-5-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eddie James <eajames@linux.vnet.ibm.com>

Document the bindings for I2C-based OCC hwmon device.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt

diff --git a/Documentation/devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt b/Documentation/devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt
new file mode 100644
index 0000000..5dc5d2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt
@@ -0,0 +1,25 @@
+Device-tree bindings for I2C-based On-Chip Controller hwmon device
+------------------------------------------------------------------
+
+Required properties:
+ - compatible = "ibm,p8-occ-hwmon";
+ - reg = <I2C address>;			: I2C bus address
+
+Examples:
+
+    i2c-bus@100 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clock-frequency = <100000>;
+        < more properties >
+
+        occ-hwmon@1 {
+            compatible = "ibm,p8-occ-hwmon";
+            reg = <0x50>;
+        };
+
+        occ-hwmon@2 {
+            compatible = "ibm,p8-occ-hwmon";
+            reg = <0x51>;
+        };
+    };
-- 
1.8.3.1


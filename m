Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E341C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CCD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeKUAqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:46:05 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37862 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbeKUAqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:46:04 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKEEHBj030453;
        Tue, 20 Nov 2018 08:16:36 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984dqp-1;
        Tue, 20 Nov 2018 08:16:35 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id AB975611E121;
        Tue, 20 Nov 2018 08:16:34 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 14:16:32 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKEGVr0000703; Tue,
 20 Nov 2018 14:16:32 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v5 5/8] regulator: lochnagar: Add initial binding documentation
Date:   Tue, 20 Nov 2018 14:16:28 +0000
Message-ID: <20181120141631.18949-5-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
References: <20181120141631.18949-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lochnagar is an evaluation and development board for Cirrus
Logic Smart CODEC and Amp devices. It allows the connection of
most Cirrus Logic devices on mini-cards, as well as allowing
connection of various application processor systems to provide a
full evaluation platform. This driver supports the board
controller chip on the Lochnagar board.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 .../bindings/regulator/cirrus,lochnagar.txt        | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt

diff --git a/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
new file mode 100644
index 000000000000..91974e6ee251
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
@@ -0,0 +1,82 @@
+Cirrus Logic Lochnagar Audio Development Board
+
+Lochnagar is an evaluation and development board for Cirrus Logic
+Smart CODEC and Amp devices. It allows the connection of most Cirrus
+Logic devices on mini-cards, as well as allowing connection of
+various application processor systems to provide a full evaluation
+platform.  Audio system topology, clocking and power can all be
+controlled through the Lochnagar, allowing the device under test
+to be used in a variety of possible use cases.
+
+This binding document describes the binding for the regulator portion
+of the driver.
+
+Also see these documents for generic binding information:
+  [1] Regulator: ../regulator/regulator.txt
+
+This binding must be part of the Lochnagar MFD binding:
+  [2] ../mfd/cirrus,lochnagar.txt
+
+Optional sub-nodes:
+
+  - VDDCORE : Initialisation data for the VDDCORE regulator, which
+    supplies the CODECs digital core if it has no build regulator for that
+    purpose.
+      Required Properties:
+      - compatible : One of the following strings:
+                     "cirrus,lochnagar2-vddcore"
+      - SYSVDD-supply: Primary power supply for the Lochnagar.
+
+  - MICVDD : Initialisation data for the MICVDD regulator, which
+    supplies the CODECs MICVDD.
+      Required Properties:
+      - compatible : One of the following strings:
+                     "cirrus,lochnagar2-micvdd"
+      - SYSVDD-supply: Primary power supply for the Lochnagar.
+
+  - MIC1VDD, MIC2VDD : Initialisation data for the MICxVDD supplies.
+      Required Properties:
+      - compatible : One of the following strings:
+                     "cirrus,lochnagar2-mic1vdd", "cirrus,lochnagar2-mic2vdd"
+      Optional Properties:
+      - cirrus,micbias-input : A property selecting which of the CODEC
+        minicard micbias outputs should be used, valid values are 1 - 4.
+      - MICBIAS1-supply, MICBIAS2-supply: Regulator supplies for the
+        MICxVDD outputs, supplying the digital microphones, normally
+        supplied from the attached CODEC.
+
+  - VDD1V8 : Recommended fixed regulator for the VDD1V8 regulator, which supplies the
+    CODECs analog and 1.8V digital supplies.
+      Required Properties:
+      - compatible : Should be set to "regulator-fixed"
+      - regulator-min-microvolt : Should be set to 1.8V
+      - regulator-max-microvolt : Should be set to 1.8V
+      - regulator-boot-on
+      - regulator-always-on
+      - vin-supply : Should be set to same supply as SYSVDD
+
+Example:
+
+lochnagar {
+	lochnagar-micvdd: MICVDD {
+		compatible = "cirrus,lochnagar2-micvdd";
+
+		SYSVDD-supply = <&wallvdd>;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	lochnagar-vdd1v8: VDD1V8 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VDD1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+
+		vin-supply = <&wallvdd>;
+	};
+};
+
-- 
2.11.0


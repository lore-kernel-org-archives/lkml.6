Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F2C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C11D20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C11D20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbeKUArB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:47:01 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37864 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbeKUAqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:46:05 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKEEnTL030925;
        Tue, 20 Nov 2018 08:16:34 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984dqj-1;
        Tue, 20 Nov 2018 08:16:34 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 75527611E124;
        Tue, 20 Nov 2018 08:16:33 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 14:16:32 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wAKEGVqw000703; Tue,
 20 Nov 2018 14:16:32 GMT
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <broonie@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: [PATCH v5 3/8] clk: lochnagar: Add initial binding documentation
Date:   Tue, 20 Nov 2018 14:16:26 +0000
Message-ID: <20181120141631.18949-3-ckeepax@opensource.cirrus.com>
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
 .../devicetree/bindings/clock/cirrus,lochnagar.txt | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt

diff --git a/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
new file mode 100644
index 000000000000..c1b5478d5432
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
@@ -0,0 +1,89 @@
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
+This binding document describes the binding for the clock portion of
+the driver.
+
+Also see these documents for generic binding information:
+  [1] Clock : ../clock/clock-bindings.txt
+
+And these for relevant defines:
+  [2] include/dt-bindings/clock/lochnagar.h
+
+This binding must be part of the Lochnagar MFD binding:
+  [3] ../mfd/cirrus,lochnagar.txt
+
+Required properties:
+
+  - compatible : One of the following strings:
+                 "cirrus,lochnagar1-clk"
+                 "cirrus,lochnagar2-clk"
+
+  - #clock-cells : Must be 1. The first cell indicates the clock
+    number, see [2] for available clocks and [1].
+
+Optional properties:
+
+  - clocks : Must contain an entry for each clock in clock-names.
+  - clock-names : May contain entries for each of the following
+    clocks:
+     - ln-cdc-clkout : Output clock from CODEC card.
+     - ln-dsp-clkout : Output clock from DSP card.
+     - ln-gf-mclk1,ln-gf-mclk2,ln-gf-mclk3,ln-gf-mclk4 : Optional
+       input audio clocks from host system.
+     - ln-psia1-mclk, ln-psia2-mclk : Optional input audio clocks from
+       external connector.
+     - ln-spdif-clkout : Optional input audio clock from SPDIF.
+     - ln-adat-clkout : Optional input audio clock from ADAT.
+     - ln-pmic-32k : On board fixed regulator.
+     - ln-clk-12m : On board fixed regulator.
+     - ln-clk-11m : On board fixed regulator.
+     - ln-clk-24m : On board fixed regulator.
+     - ln-clk-22m : On board fixed regulator.
+     - ln-usb-clk-24m : On board fixed regulator.
+     - ln-usb-clk-12m : On board fixed regulator.
+
+  - assigned-clocks : A list of Lochnagar clocks to be reparented, see
+    [2] for available clocks.
+  - assigned-clock-parents : Parents to be assigned to the clocks
+    listed in "assigned-clocks".
+
+Optional sub-nodes:
+
+  - fixed-clock nodes may be registered for the following on board clocks:
+     - ln-pmic-32k : 32768 kHz
+     - ln-clk-12m : 12288000 kHz
+     - ln-clk-11m : 11298600 kHz
+     - ln-clk-24m : 24576000 kHz
+     - ln-clk-22m : 22579200 kHz
+     - ln-usb-clk-24m : 24576000 kHz
+     - ln-usb-clk-12m : 12288000 kHz
+
+Example:
+
+lochnagar-clk {
+	compatible = "cirrus,lochnagar2-clk";
+
+	#clock-cells = <1>;
+
+	clocks = <&clk-audio>, <&clk_pmic>;
+	clock-names = "ln-gf-mclk2", "ln-pmic-32k";
+
+	assigned-clocks = <&lochnagar-clk LOCHNAGAR_CDC_MCLK1>,
+			  <&lochnagar-clk LOCHNAGAR_CDC_MCLK2>;
+	assigned-clock-parents = <&clk-audio>,
+				 <&clk-pmic>;
+
+	clk-pmic: clk-pmic {
+		compatible = "fixed-clock";
+		clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+};
-- 
2.11.0


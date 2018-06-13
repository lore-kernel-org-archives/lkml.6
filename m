Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C94EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA8D208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA8D208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935767AbeFMOBL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:01:11 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:50405 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeFMOBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:01:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 751D918990;
        Wed, 13 Jun 2018 16:01:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id xf_l6aVyPICG; Wed, 13 Jun 2018 16:01:02 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 718A2185C3;
        Wed, 13 Jun 2018 16:01:01 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5349F1E076;
        Wed, 13 Jun 2018 16:01:01 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46AA11E070;
        Wed, 13 Jun 2018 16:01:01 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 13 Jun 2018 16:01:01 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
        by seth.se.axis.com (Postfix) with ESMTP id 3994C56A;
        Wed, 13 Jun 2018 16:01:01 +0200 (CEST)
Received: from lnxborysmn.se.axis.com (10.0.5.60) by XBOX03.axis.com
 (10.0.5.17) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Wed, 13 Jun 2018
 16:01:00 +0200
From:   Borys Movchan <borys.movchan@axis.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Borys Movchan <borysmn@axis.com>, Borys Movchan <borysmn@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: light: add ISL29033 device bindings
Date:   Wed, 13 Jun 2018 16:00:15 +0200
Message-ID: <20180613140043.5802-1-borys.movchan@axis.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX03.axis.com (10.0.5.17)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borys Movchan <borysmn@axis.com>

Signed-off-by: Borys Movchan <borys.movchan@axis.com>
---
 .../devicetree/bindings/iio/light/isl29033.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29033.txt

diff --git a/Documentation/devicetree/bindings/iio/light/isl29033.txt b/Documentation/devicetree/bindings/iio/light/isl29033.txt
new file mode 100644
index 000000000000..988e40acc6ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/isl29033.txt
@@ -0,0 +1,18 @@
+Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated Digital Ambient Light Sensor
+
+Required properties:
+  - compatible : Must be "isil,isl29033".
+  - reg: the I2C address of the device
+
+Optional properties:
+  - isil,rext-kohms: External resistor nominal in kOhms used for ADC
+    reference. If not specified, 499 kOhm value will be used.
+
+Example:
+
+        als_sensor@44 {
+            compatible = "isil,isl29033";
+            reg = <0x44>;
+            isil,rext-kohms = <1000>;
+        };
+
-- 
2.11.0


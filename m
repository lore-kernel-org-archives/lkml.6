Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE57C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB05217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBLBDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:03:06 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:57208 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728110AbfBLBDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:03:01 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C11GXP009611;
        Mon, 11 Feb 2019 19:02:56 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2qhus0se7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:56 -0600
Received: from us-aus-exch2.ni.corp.natinst.com (us-aus-exch2.ni.corp.natinst.com [130.164.68.12])
        by us-aus-skprod3.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x1C12s6U016801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:54 -0600
Received: from us-aus-exch4.ni.corp.natinst.com (130.164.68.14) by
 us-aus-exch2.ni.corp.natinst.com (130.164.68.12) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:54 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch4.ni.corp.natinst.com (130.164.68.14) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:54 -0600
Received: from nisurp-linux-2.ni.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 19:02:54 -0600
From:   Virendra Kakade <virendra.kakade@ni.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sre@kernel.org>,
        <moritz.fischer@ettus.com>,
        Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 5/6] power: supply: Ettus Research E31x battery driver
Date:   Mon, 11 Feb 2019 19:01:42 -0600
Message-ID: <20190212010143.3729-6-virendra.kakade@ni.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212010143.3729-1-virendra.kakade@ni.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-12_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for the E31x devices battery.

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 Documentation/devicetree/bindings/mfd/e31x-pmu.txt |  8 +++++++-
 .../bindings/power/supply/e31x-battery.txt         | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/e31x-battery.txt

diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
index 3798886578ba..223ab9e0d680 100644
--- a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
+++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
@@ -4,11 +4,14 @@ Required properties:
 - compatible : Must be "ni,e31x-pmu"
 - regmap     : Must be <&regmapnode>
 
-e31x-pmu has a sub-device called e31x-charger.
+e31x-pmu consists of two sub-devices, e31x-charger and e31x-battery.
 
 For the e31x-charger properties please refer to:
 Documentation/device-tree/bindings/power/supply/e31x-charger.txt
 
+For the e31x-battery properties please refer to:
+Documentation/device-tree/bindings/power/supply/e31x-battery.txt
+
 Example:
 
 pmu {
@@ -18,5 +21,8 @@ pmu {
 	charger: charger@0{
 		compatible = "ni,e31x-charger";
 	};
+	battery: battery@1{
+		compatible = "ni,e31x-battery";
+	};
 };
 
diff --git a/Documentation/devicetree/bindings/power/supply/e31x-battery.txt b/Documentation/devicetree/bindings/power/supply/e31x-battery.txt
new file mode 100644
index 000000000000..e09cd92ef82e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/e31x-battery.txt
@@ -0,0 +1,14 @@
+Ettus Research/National Instruments E31x Devices Battery
+
+Some variants of the E31x devices have an in-built Li-ion
+battery. This driver provides capability to monitor
+the battery.
+
+Required properties:
+- compatible: Must be "ni,e31x-battery"
+
+Example:
+
+battery: battery@0{
+	compatible = "ni,e31x-battery";
+};
-- 
2.17.1


Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBF9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1C7217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 01:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfBLBCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:02:52 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43130 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727492AbfBLBCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 20:02:51 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1C11Ghx001122;
        Mon, 11 Feb 2019 19:02:44 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2qhw8uh4uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:43 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod3.natinst.com (8.16.0.27/8.16.0.27) with ESMTPS id x1C12hjo016758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Feb 2019 19:02:43 -0600
Received: from us-aus-exch4.ni.corp.natinst.com (130.164.68.14) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:42 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch4.ni.corp.natinst.com (130.164.68.14) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 11 Feb 2019 19:02:42 -0600
Received: from nisurp-linux-2.ni.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Mon, 11 Feb 2019 19:02:42 -0600
From:   Virendra Kakade <virendra.kakade@ni.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <sre@kernel.org>,
        <moritz.fischer@ettus.com>,
        Virendra Kakade <virendra.kakade@ni.com>
Subject: [RFC 1/6] mfd: Support for Ettus Research E31x devices PMU
Date:   Mon, 11 Feb 2019 19:01:38 -0600
Message-ID: <20190212010143.3729-2-virendra.kakade@ni.com>
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

Document bindings for E31x device PMU MFD driver.

Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
---
 Documentation/devicetree/bindings/mfd/e31x-pmu.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt

diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
new file mode 100644
index 000000000000..ebb5625f6c74
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
@@ -0,0 +1,14 @@
+Ettus Research/National Instruments E31x PMU MFD driver
+
+Required properties:
+- compatible : Must be "ni,e31x-pmu"
+- regmap     : Must be <&regmapnode>
+
+Example:
+
+pmu {
+	compatible = "ni,e31x-pmu";
+	regmap = <&devctrl>;
+	status = "okay";
+};
+
-- 
2.17.1


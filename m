Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D06EECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C97320831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C97320831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJYK6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:58:47 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:51172 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726344AbeJYK6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:58:46 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9P2QLDK070316;
        Thu, 25 Oct 2018 10:26:21 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 25 Oct 2018
 10:24:55 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <ebiederm@xmission.com>,
        <gregkh@linuxfoundation.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <pombredanne@nexb.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <zong@andestech.com>,
        <alankao@andestech.com>, <deanbo422@gmail.com>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH v4 4/4] nds32: Add document for NDS32 PMU.
Date:   Thu, 25 Oct 2018 10:24:17 +0800
Message-ID: <fb0115313c7c717b1699ce5f21d6f24df457e1d1.1540430862.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1540430861.git.nickhu@andestech.com>
References: <cover.1540430861.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9P2QLDK070316
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nickhu <nickhu@andestech.com>

The document for how to add NDS32 PMU
in devicetree.

Signed-off-by: Nickhu <nickhu@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/perf/nds32v3-pmu.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/nds32v3-pmu.txt

diff --git a/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt b/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
new file mode 100644
index 000000000000..1bd15785b4ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/nds32v3-pmu.txt
@@ -0,0 +1,17 @@
+* NDS32 Performance Monitor Units
+
+NDS32 core have a PMU for counting cpu and cache events like cache misses.
+The NDS32 PMU representation in the device tree should be done as under:
+
+Required properties:
+
+- compatible :
+	"andestech,nds32v3-pmu"
+
+- interrupts : The interrupt number for NDS32 PMU is 13.
+
+Example:
+pmu{
+	compatible = "andestech,nds32v3-pmu";
+	interrupts = <13>;
+}
-- 
2.17.0


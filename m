Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7A0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F02F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F02F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeFUIGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:06:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37734 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754292AbeFUIFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:05:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5L8517R041535
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:05:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jr4w7fbax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:05:14 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Thu, 21 Jun 2018 09:05:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Jun 2018 09:05:09 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5L858f329818996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Jun 2018 08:05:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96D7111C04A;
        Thu, 21 Jun 2018 08:55:31 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D54A11C069;
        Thu, 21 Jun 2018 08:55:31 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Jun 2018 08:55:31 +0100 (BST)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/4] perf json: Add s390 transaction counter definition
Date:   Thu, 21 Jun 2018 10:04:51 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621080452.61012-1-tmricht@linux.ibm.com>
References: <20180621080452.61012-1-tmricht@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062108-0012-0000-0000-00000281D0B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062108-0013-0000-0000-000020B31410
Message-Id: <20180621080452.61012-3-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806210091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf stat displays transactional counters using flag -T on x86.
On s390 use a json file defined metric named transaction to
achieve the same result.

Output before:
 none

Output after:
[root@s35lp76 perf]# ./perf stat -M transaction  -- \
			~/mytesttx 1 >/tmp/111

 Performance counter stats for '/root/mytesttx 1':

                 1      tx_c_tend           #     13.0 transaction
                 1      tx_nc_tend
                11      tx_nc_tabort
                 0      tx_c_tabort_special
                 0      tx_c_tabort_no_special

       0.001061232 seconds time elapsed

[root@s35lp76 perf]#

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 tools/perf/pmu-events/arch/s390/cf_z13/transaction.json   | 7 +++++++
 tools/perf/pmu-events/arch/s390/cf_z14/transaction.json   | 7 +++++++
 tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json | 7 +++++++
 3 files changed, 21 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json b/tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json
new file mode 100644
index 000000000000..1a0034f79f73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json
@@ -0,0 +1,7 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+  }
+]
-- 
2.14.3


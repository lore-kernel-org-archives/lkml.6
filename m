Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721EC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A271920671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A271920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbeGYV4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:56:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbeGYV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:56:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKh1JC498853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:43:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKh1SJ498849;
        Wed, 25 Jul 2018 13:43:01 -0700
Date:   Wed, 25 Jul 2018 13:43:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-83eb383e942bba7aab465a334d2c365d3f47a0ae@git.kernel.org>
Cc:     schwidefsky@de.ibm.com, acme@redhat.com, mingo@kernel.org,
        brueckner@linux.ibm.com, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
        tglx@linutronix.de, tmricht@linux.ibm.com
Reply-To: schwidefsky@de.ibm.com, acme@redhat.com, mingo@kernel.org,
          brueckner@linux.ibm.com, heiko.carstens@de.ibm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
          tglx@linutronix.de, tmricht@linux.ibm.com
In-Reply-To: <20180621080452.61012-3-tmricht@linux.ibm.com>
References: <20180621080452.61012-3-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf json: Add s390 transaction counter definition
Git-Commit-ID: 83eb383e942bba7aab465a334d2c365d3f47a0ae
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  83eb383e942bba7aab465a334d2c365d3f47a0ae
Gitweb:     https://git.kernel.org/tip/83eb383e942bba7aab465a334d2c365d3f47a0ae
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Thu, 21 Jun 2018 10:04:51 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:49:30 -0300

perf json: Add s390 transaction counter definition

'perf stat' displays transactional counters using flag -T on x86.  On
s390 use a JSON file defined metric named transaction to achieve the
same result.

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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180621080452.61012-3-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z13/transaction.json   | 7 +++++++
 tools/perf/pmu-events/arch/s390/cf_z14/transaction.json   | 7 +++++++
 tools/perf/pmu-events/arch/s390/cf_zec12/transaction.json | 7 +++++++
 3 files changed, 21 insertions(+)

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

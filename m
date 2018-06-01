Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751459AbeFABIC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:08:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:61910 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbeFABHc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:07:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,464,1520924400";
   d="scan'208";a="46392515"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2 3/3] perf script python: Add fields introduction to Documentation
Date: Fri,  1 Jun 2018 17:01:03 +0800
Message-Id: <1527843663-32288-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
References: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the brief introduction of fields to perf-script-python.txt.

It may help python script developer easily finding what fields
are supported.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/Documentation/perf-script-python.txt | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/Documentation/perf-script-python.txt b/tools/perf/Documentation/perf-script-python.txt
index 51ec2d2..0fb9eda 100644
--- a/tools/perf/Documentation/perf-script-python.txt
+++ b/tools/perf/Documentation/perf-script-python.txt
@@ -610,6 +610,32 @@ Various utility functions for use with perf script:
   nsecs_str(nsecs) - returns printable string in the form secs.nsecs
   avg(total, n) - returns average given a sum and a total number of values
 
+SUPPORTED FIELDS
+----------------
+
+Currently supported fields:
+
+ev_name, comm, pid, tid, cpu, ip, time, period, phys_addr, addr,
+symbol, dso, time_enabled, time_running, values, callchain,
+brstack, brstacksym, datasrc, datasrc_decode, iregs, uregs,
+weight, transaction, raw_buf, attr.
+
+Some fields have sub items:
+
+brstack:
+    from, to, from_dsoname, to_dsoname, mispred,
+    predicted, in_tx, abort, cycles.
+
+brstacksym:
+    items: from, to, pred, in_tx, abort (converted string)
+
+For example,
+We can use this code to print brstack "from", "to", "cycles".
+
+if 'brstack' in dict:
+	for entry in dict['brstack']:
+		print "from %s, to %s, cycles %s" % (entry["from"], entry["to"], entry["cycles"])
+
 SEE ALSO
 --------
 linkperf:perf-script[1]
-- 
2.7.4

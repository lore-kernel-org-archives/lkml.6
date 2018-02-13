Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935078AbeBMMTh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:19:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51745 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934918AbeBMMTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:19:36 -0500
Date: Tue, 13 Feb 2018 04:09:10 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jelngl9q1ooaizvkcput9tic@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jolsa@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, hpa@zytor.com, wangnan0@huawei.com,
        acme@redhat.com, peterz@infradead.org, kan.liang@intel.com,
        mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org
Reply-To: jolsa@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        hpa@zytor.com, acme@redhat.com, kan.liang@intel.com,
        peterz@infradead.org, wangnan0@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Expose the perf_missing_features
 struct
Git-Commit-ID: 5bcf848912d3c8669dcd5922f576162727be31b2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5bcf848912d3c8669dcd5922f576162727be31b2
Gitweb:     https://git.kernel.org/tip/5bcf848912d3c8669dcd5922f576162727be31b2
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 2 Feb 2018 11:27:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:51 -0300

perf evsel: Expose the perf_missing_features struct

As tools may need to adjust to missing features, as 'perf top' will, in
the next csets, to cope with a missing 'write_backward' feature.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jelngl9q1ooaizvkcput9tic@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 12 +-----------
 tools/perf/util/evsel.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ff359c9..ef35168 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -41,17 +41,7 @@
 
 #include "sane_ctype.h"
 
-static struct {
-	bool sample_id_all;
-	bool exclude_guest;
-	bool mmap2;
-	bool cloexec;
-	bool clockid;
-	bool clockid_wrong;
-	bool lbr_flags;
-	bool write_backward;
-	bool group_read;
-} perf_missing_features;
+struct perf_missing_features perf_missing_features;
 
 static clockid_t clockid;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 846e416..a7487c6 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -149,6 +149,20 @@ union u64_swap {
 	u32 val32[2];
 };
 
+struct perf_missing_features {
+	bool sample_id_all;
+	bool exclude_guest;
+	bool mmap2;
+	bool cloexec;
+	bool clockid;
+	bool clockid_wrong;
+	bool lbr_flags;
+	bool write_backward;
+	bool group_read;
+};
+
+extern struct perf_missing_features perf_missing_features;
+
 struct cpu_map;
 struct target;
 struct thread_map;

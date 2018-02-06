Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeBFQ4m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:56:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752602AbeBFQyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:37 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1DE21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 13/21] perf evsel: Expose the perf_missing_features struct
Date: Tue,  6 Feb 2018 13:53:42 -0300
Message-Id: <20180206165350.2570-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index ff359c9ece2e..ef351688b797 100644
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
index 846e41644525..a7487c6d1866 100644
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
-- 
2.14.3

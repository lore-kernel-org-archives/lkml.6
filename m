Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeBFS0w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:26:52 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752758AbeBFS00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:26:26 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 17/17] perf tools: Fix comment for sort__* compare functions
Date: Tue,  6 Feb 2018 19:18:13 +0100
Message-Id: <20180206181813.10943-18-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 2f15bd8c6c6e ("perf tools: Fix "Command" sort_entry's cmp and collapse function")
we switched from pointer to string comparison.

But failed to remove related comments. Removing them and adding
another one to warn before pointer comparison in here.

Link: http://lkml.kernel.org/n/tip-8p85wxr2o5ia9uinxeea8853@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/sort.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2da4d0456a03..e8514f651865 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -111,17 +111,20 @@ struct sort_entry sort_thread = {
 
 /* --sort comm */
 
+/*
+ * We can't use pointer comparison in functions below,
+ * because it gives different results based on pointer
+ * values, which could break some sorting assumptions.
+ */
 static int64_t
 sort__comm_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	/* Compare the addr that should be unique among comm */
 	return strcmp(comm__str(right->comm), comm__str(left->comm));
 }
 
 static int64_t
 sort__comm_collapse(struct hist_entry *left, struct hist_entry *right)
 {
-	/* Compare the addr that should be unique among comm */
 	return strcmp(comm__str(right->comm), comm__str(left->comm));
 }
 
-- 
2.13.6

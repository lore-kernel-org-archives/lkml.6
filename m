Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbeBQLc1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:32:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeBQLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:32:26 -0500
Date: Sat, 17 Feb 2018 03:22:03 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-a7402c943bb4657cc0b44453177803fbead70990@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, namhyung@kernel.org, mingo@kernel.org,
        jolsa@kernel.org, acme@redhat.com, alexander.shishkin@linux.intel.com,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        dsahern@gmail.com
Reply-To: jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, acme@redhat.com
In-Reply-To: <20180206181813.10943-18-jolsa@kernel.org>
References: <20180206181813.10943-18-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix comment for sort__* compare
 functions
Git-Commit-ID: a7402c943bb4657cc0b44453177803fbead70990
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

Commit-ID:  a7402c943bb4657cc0b44453177803fbead70990
Gitweb:     https://git.kernel.org/tip/a7402c943bb4657cc0b44453177803fbead70990
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Feb 2018 19:18:13 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:23 -0300

perf tools: Fix comment for sort__* compare functions

In commit 2f15bd8c6c6e ("perf tools: Fix "Command" sort_entry's cmp and
collapse function") we switched from pointer to string comparison.

But failed to remove related comments. Removing them and adding another
one to warn before pointer comparison in here.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2da4d04..e8514f6 100644
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
 

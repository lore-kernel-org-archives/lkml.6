Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbeBFS3h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:29:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753224AbeBFS1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:48 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 01/17] perf report: Ask ordered events for --tasks option
Date: Tue,  6 Feb 2018 19:17:57 +0100
Message-Id: <20180206181813.10943-2-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have the time in, keep the events in time order.

Link: http://lkml.kernel.org/n/tip-3wcrngoibk5l96nqyhp0nbkm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-report.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4ad5dc649716..8ef71669e7a0 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -614,6 +614,7 @@ static int stats_print(struct report *rep)
 static void tasks_setup(struct report *rep)
 {
 	memset(&rep->tool, 0, sizeof(rep->tool));
+	rep->tool.ordered_events = true;
 	if (rep->mmaps_mode) {
 		rep->tool.mmap = perf_event__process_mmap;
 		rep->tool.mmap2 = perf_event__process_mmap2;
-- 
2.13.6

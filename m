Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeEPSBz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:01:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeEPSBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:01:53 -0400
Date: Wed, 16 May 2018 11:00:56 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-kw62fys9bwdgsp722so2ln1l@git.kernel.org>
Cc: namhyung@kernel.org, ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, dsahern@gmail.com, hpa@zytor.com
Reply-To: ak@linux.intel.com, namhyung@kernel.org, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, dsahern@gmail.com, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests parse-events: Add intel_pt parse test
Git-Commit-ID: b3f58c8da64bc63bd0c0a06a4e2cf258a3d20be6
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

Commit-ID:  b3f58c8da64bc63bd0c0a06a4e2cf258a3d20be6
Gitweb:     https://git.kernel.org/tip/b3f58c8da64bc63bd0c0a06a4e2cf258a3d20be6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 11 May 2018 11:48:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 15 May 2018 10:31:59 -0300

perf tests parse-events: Add intel_pt parse test

To avoid regressions such as the one fixed by 4a35a9027f64 ("Revert
"perf pmu: Fix pmu events parsing rule""), where '-e intel_pt//u' got
broken, with this new entry in this 'perf tests' subtest, we would have
caught it before pushing upstream.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kw62fys9bwdgsp722so2ln1l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 18b06444f230..6829dd416a99 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1309,6 +1309,14 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
 	return 0;
 }
 
+static int test__intel_pt(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel = perf_evlist__first(evlist);
+
+	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
+	return 0;
+}
+
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1637,6 +1645,11 @@ static struct evlist_test test__events[] = {
 		.check = test__checkevent_config_cache,
 		.id    = 51,
 	},
+	{
+		.name  = "intel_pt//u",
+		.check = test__intel_pt,
+		.id    = 52,
+	},
 };
 
 static struct evlist_test test__events_pmu[] = {

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeEPOta (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751132AbeEPOt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:49:26 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/11] perf tests parse-events: Add intel_pt parse test
Date: Wed, 16 May 2018 11:48:58 -0300
Message-Id: <20180516144908.22212-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180516144908.22212-1-acme@kernel.org>
References: <20180516144908.22212-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3

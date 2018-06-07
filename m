Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nHvcDpPpGFs+VgAAmS7hNA
	; Thu, 07 Jun 2018 08:15:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 260A9608B8; Thu,  7 Jun 2018 08:15:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 505E160115;
	Thu,  7 Jun 2018 08:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 505E160115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932476AbeFGIPL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:15:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeFGIPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:15:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578EuiJ2125209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:14:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578EuXF2125206;
        Thu, 7 Jun 2018 01:14:56 -0700
Date: Thu, 7 Jun 2018 01:14:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-145340oytbthatpfeaq1do18@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, acme@redhat.com, wangnan0@huawei.com,
        dsahern@gmail.com, jolsa@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, adrian.hunter@intel.com, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: wangnan0@huawei.com, dsahern@gmail.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, namhyung@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Add has_callchain() helper to make
 code more compact/clear
Git-Commit-ID: 27de9b2bd996de0ca4079c42c81c85158e10145c
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

Commit-ID:  27de9b2bd996de0ca4079c42c81c85158e10145c
Gitweb:     https://git.kernel.org/tip/27de9b2bd996de0ca4079c42c81c85158e10145c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 16:00:29 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 5 Jun 2018 10:09:54 -0300

perf evsel: Add has_callchain() helper to make code more compact/clear

Its common to have the (evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN),
so add an evsel__has_callchain(evsel) helper.

This will actually get more uses as we check that instead of
symbol_conf.use_callchain in places where that produces the same result
but makes this decision to be more fine grained, per evsel.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-145340oytbthatpfeaq1do18@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c      |  3 +--
 tools/perf/builtin-script.c     | 10 +++-------
 tools/perf/builtin-trace.c      |  2 +-
 tools/perf/tests/parse-events.c |  4 ++--
 tools/perf/util/evsel.c         |  4 ++--
 tools/perf/util/evsel.h         |  5 +++++
 tools/perf/util/hist.c          |  2 +-
 tools/perf/util/session.c       |  2 +-
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 4dfdee668b0c..97f9e755e8e6 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2933,8 +2933,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 			return -1;
 		}
 
-		if (sched->show_callchain &&
-		    !(evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN)) {
+		if (sched->show_callchain && !evsel__has_callchain(evsel)) {
 			pr_info("Samples do not have callchains.\n");
 			sched->show_callchain = 0;
 			symbol_conf.use_callchain = 0;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index cefc8813e91e..48e940efb3cb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -517,7 +517,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
+			if (evsel__has_callchain(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -532,22 +532,18 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	 */
 	if (symbol_conf.use_callchain &&
 	    !output[PERF_TYPE_TRACEPOINT].user_set) {
-		struct perf_event_attr *attr;
-
 		j = PERF_TYPE_TRACEPOINT;
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			if (evsel->attr.type != j)
 				continue;
 
-			attr = &evsel->attr;
-
-			if (attr->sample_type & PERF_SAMPLE_CALLCHAIN) {
+			if (evsel__has_callchain(evsel)) {
 				output[j].fields |= PERF_OUTPUT_IP;
 				output[j].fields |= PERF_OUTPUT_SYM;
 				output[j].fields |= PERF_OUTPUT_SYMOFFSET;
 				output[j].fields |= PERF_OUTPUT_DSO;
-				set_print_ip_opts(attr);
+				set_print_ip_opts(&evsel->attr);
 				goto out;
 			}
 		}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 560aed7da36a..6a748eca2edb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2491,7 +2491,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 * to override an explicitely set --max-stack global setting.
 	 */
 	evlist__for_each_entry(evlist, evsel) {
-		if ((evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+		if (evsel__has_callchain(evsel) &&
 		    evsel->attr.sample_max_stack == 0)
 			evsel->attr.sample_max_stack = trace->max_stack;
 	}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b9ebe15afb13..7d4077068454 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -499,7 +499,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlis
 	 * while this test executes only parse events method.
 	 */
 	TEST_ASSERT_VAL("wrong period",     0 == evsel->attr.sample_period);
-	TEST_ASSERT_VAL("wrong callgraph",  !(PERF_SAMPLE_CALLCHAIN & evsel->attr.sample_type));
+	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->attr.sample_type));
 
 	/* cpu/config=2,call-graph=no,time=0,period=2000/ */
@@ -512,7 +512,7 @@ static int test__checkevent_pmu_partial_time_callgraph(struct perf_evlist *evlis
 	 * while this test executes only parse events method.
 	 */
 	TEST_ASSERT_VAL("wrong period",     0 == evsel->attr.sample_period);
-	TEST_ASSERT_VAL("wrong callgraph",  !(PERF_SAMPLE_CALLCHAIN & evsel->attr.sample_type));
+	TEST_ASSERT_VAL("wrong callgraph",  !evsel__has_callchain(evsel));
 	TEST_ASSERT_VAL("wrong time",  !(PERF_SAMPLE_TIME & evsel->attr.sample_type));
 
 	return 0;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 150db5ed7400..94fce4f537e9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2197,7 +2197,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		}
 	}
 
-	if (type & PERF_SAMPLE_CALLCHAIN) {
+	if (evsel__has_callchain(evsel)) {
 		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
 
 		OVERFLOW_CHECK_u64(array);
@@ -2857,7 +2857,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			 "Hint: Try again after reducing the number of events.\n"
 			 "Hint: Try increasing the limit with 'ulimit -n <limit>'");
 	case ENOMEM:
-		if ((evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0 &&
+		if (evsel__has_callchain(evsel) &&
 		    access("/proc/sys/kernel/perf_event_max_stack", F_OK) == 0)
 			return scnprintf(msg, size,
 					 "Not enough memory to setup event with callchain.\n"
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index b13f5f234c8f..d277930b19a1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -459,6 +459,11 @@ static inline bool perf_evsel__has_branch_callstack(const struct perf_evsel *evs
 	return evsel->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
 }
 
+static inline bool evsel__has_callchain(const struct perf_evsel *evsel)
+{
+	return (evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
+}
+
 typedef int (*attr__fprintf_f)(FILE *, const char *, const char *, void *);
 
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 95333b068109..34864c87cd3c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1757,7 +1757,7 @@ void perf_evsel__output_resort(struct perf_evsel *evsel, struct ui_progress *pro
 	bool use_callchain;
 
 	if (evsel && symbol_conf.use_callchain && !symbol_conf.show_ref_callgraph)
-		use_callchain = evsel->attr.sample_type & PERF_SAMPLE_CALLCHAIN;
+		use_callchain = evsel__has_callchain(evsel);
 	else
 		use_callchain = symbol_conf.use_callchain;
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b998bb475589..8b9369303561 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1094,7 +1094,7 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
 
 	sample_type = evsel->attr.sample_type;
 
-	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+	if (evsel__has_callchain(evsel))
 		callchain__printf(evsel, sample);
 
 	if ((sample_type & PERF_SAMPLE_BRANCH_STACK) && !perf_evsel__has_branch_callstack(evsel))

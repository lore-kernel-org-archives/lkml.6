Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF2DC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91A420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91A420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbeIYPiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:38:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:38:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9VASF3386099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:31:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9V9wO3386096;
        Tue, 25 Sep 2018 02:31:09 -0700
Date:   Tue, 25 Sep 2018 02:31:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-89f1688a57a8f0b685fccd648e601a1f830fa744@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, andi@firstfloor.org,
        hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        namhyung@kernel.org
Reply-To: jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, andi@firstfloor.org, acme@redhat.com,
          alexey.budankov@linux.intel.com, peterz@infradead.org,
          namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180913125450.21342-2-jolsa@kernel.org>
References: <20180913125450.21342-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Remove perf_tool from event_op2
Git-Commit-ID: 89f1688a57a8f0b685fccd648e601a1f830fa744
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

Commit-ID:  89f1688a57a8f0b685fccd648e601a1f830fa744
Gitweb:     https://git.kernel.org/tip/89f1688a57a8f0b685fccd648e601a1f830fa744
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 13 Sep 2018 14:54:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:10 -0300

perf tools: Remove perf_tool from event_op2

Now that we keep a perf_tool pointer inside perf_session, there's no
need to have a perf_tool argument in the event_op2 callback. Remove it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c |  7 ++---
 tools/perf/builtin-inject.c   | 26 +++++++----------
 tools/perf/builtin-report.c   |  9 +++---
 tools/perf/builtin-script.c   | 38 ++++++++++++------------
 tools/perf/builtin-stat.c     | 23 +++++++--------
 tools/perf/util/auxtrace.c    | 10 +++----
 tools/perf/util/auxtrace.h    | 10 +++----
 tools/perf/util/header.c      | 16 +++++------
 tools/perf/util/header.h      | 15 ++++------
 tools/perf/util/session.c     | 67 ++++++++++++++++++-------------------------
 tools/perf/util/session.h     |  5 ++--
 tools/perf/util/stat.c        |  5 ++--
 tools/perf/util/stat.h        |  5 ++--
 tools/perf/util/tool.h        |  3 +-
 14 files changed, 103 insertions(+), 136 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 830481b8db26..93d679eaf1f4 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -283,12 +283,11 @@ out_put:
 	return ret;
 }
 
-static int process_feature_event(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session)
+static int process_feature_event(struct perf_session *session,
+				 union perf_event *event)
 {
 	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(tool, event, session);
+		return perf_event__process_feature(session, event);
 	return 0;
 }
 
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a3b346359ba0..d77ed2aea95a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -86,12 +86,10 @@ static int perf_event__drop_oe(struct perf_tool *tool __maybe_unused,
 }
 #endif
 
-static int perf_event__repipe_op2_synth(struct perf_tool *tool,
-					union perf_event *event,
-					struct perf_session *session
-					__maybe_unused)
+static int perf_event__repipe_op2_synth(struct perf_session *session,
+					union perf_event *event)
 {
-	return perf_event__repipe_synth(tool, event);
+	return perf_event__repipe_synth(session->tool, event);
 }
 
 static int perf_event__repipe_attr(struct perf_tool *tool,
@@ -362,26 +360,24 @@ static int perf_event__repipe_exit(struct perf_tool *tool,
 	return err;
 }
 
-static int perf_event__repipe_tracing_data(struct perf_tool *tool,
-					   union perf_event *event,
-					   struct perf_session *session)
+static int perf_event__repipe_tracing_data(struct perf_session *session,
+					   union perf_event *event)
 {
 	int err;
 
-	perf_event__repipe_synth(tool, event);
-	err = perf_event__process_tracing_data(tool, event, session);
+	perf_event__repipe_synth(session->tool, event);
+	err = perf_event__process_tracing_data(session, event);
 
 	return err;
 }
 
-static int perf_event__repipe_id_index(struct perf_tool *tool,
-				       union perf_event *event,
-				       struct perf_session *session)
+static int perf_event__repipe_id_index(struct perf_session *session,
+				       union perf_event *event)
 {
 	int err;
 
-	perf_event__repipe_synth(tool, event);
-	err = perf_event__process_id_index(tool, event, session);
+	perf_event__repipe_synth(session->tool, event);
+	err = perf_event__process_id_index(session, event);
 
 	return err;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 76e12bcd1765..7507e4d6dce1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -201,14 +201,13 @@ static void setup_forced_leader(struct report *report,
 		perf_evlist__force_leader(evlist);
 }
 
-static int process_feature_event(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session __maybe_unused)
+static int process_feature_event(struct perf_session *session,
+				 union perf_event *event)
 {
-	struct report *rep = container_of(tool, struct report, tool);
+	struct report *rep = container_of(session->tool, struct report, tool);
 
 	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(tool, event, session);
+		return perf_event__process_feature(session, event);
 
 	if (event->feat.feat_id != HEADER_LAST_FEATURE) {
 		pr_err("failed: wrong feature ID: %" PRIu64 "\n",
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6176bae177c2..765391b6c88c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2965,9 +2965,8 @@ static void script__setup_sample_type(struct perf_script *script)
 	}
 }
 
-static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
-				    union perf_event *event,
-				    struct perf_session *session)
+static int process_stat_round_event(struct perf_session *session,
+				    union perf_event *event)
 {
 	struct stat_round_event *round = &event->stat_round;
 	struct perf_evsel *counter;
@@ -2981,9 +2980,8 @@ static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int process_stat_config_event(struct perf_tool *tool __maybe_unused,
-				     union perf_event *event,
-				     struct perf_session *session __maybe_unused)
+static int process_stat_config_event(struct perf_session *session __maybe_unused,
+				     union perf_event *event)
 {
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
 	return 0;
@@ -3009,10 +3007,10 @@ static int set_maps(struct perf_script *script)
 }
 
 static
-int process_thread_map_event(struct perf_tool *tool,
-			     union perf_event *event,
-			     struct perf_session *session __maybe_unused)
+int process_thread_map_event(struct perf_session *session,
+			     union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
 	if (script->threads) {
@@ -3028,10 +3026,10 @@ int process_thread_map_event(struct perf_tool *tool,
 }
 
 static
-int process_cpu_map_event(struct perf_tool *tool __maybe_unused,
-			  union perf_event *event,
-			  struct perf_session *session __maybe_unused)
+int process_cpu_map_event(struct perf_session *session,
+			  union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct perf_script *script = container_of(tool, struct perf_script, tool);
 
 	if (script->cpus) {
@@ -3046,21 +3044,21 @@ int process_cpu_map_event(struct perf_tool *tool __maybe_unused,
 	return set_maps(script);
 }
 
-static int process_feature_event(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session)
+static int process_feature_event(struct perf_session *session,
+				 union perf_event *event)
 {
 	if (event->feat.feat_id < HEADER_LAST_FEATURE)
-		return perf_event__process_feature(tool, event, session);
+		return perf_event__process_feature(session, event);
 	return 0;
 }
 
 #ifdef HAVE_AUXTRACE_SUPPORT
-static int perf_script__process_auxtrace_info(struct perf_tool *tool,
-					      union perf_event *event,
-					      struct perf_session *session)
+static int perf_script__process_auxtrace_info(struct perf_session *session,
+					      union perf_event *event)
 {
-	int ret = perf_event__process_auxtrace_info(tool, event, session);
+	struct perf_tool *tool = session->tool;
+
+	int ret = perf_event__process_auxtrace_info(session, event);
 
 	if (ret == 0) {
 		struct perf_script *script = container_of(tool, struct perf_script, tool);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0b0e3961d511..b86aba1c8028 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1354,9 +1354,8 @@ static int __cmd_record(int argc, const char **argv)
 	return argc;
 }
 
-static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
-				    union perf_event *event,
-				    struct perf_session *session)
+static int process_stat_round_event(struct perf_session *session,
+				    union perf_event *event)
 {
 	struct stat_round_event *stat_round = &event->stat_round;
 	struct perf_evsel *counter;
@@ -1381,10 +1380,10 @@ static int process_stat_round_event(struct perf_tool *tool __maybe_unused,
 }
 
 static
-int process_stat_config_event(struct perf_tool *tool,
-			      union perf_event *event,
-			      struct perf_session *session __maybe_unused)
+int process_stat_config_event(struct perf_session *session,
+			      union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
 
 	perf_event__read_stat_config(&stat_config, &event->stat_config);
@@ -1424,10 +1423,10 @@ static int set_maps(struct perf_stat *st)
 }
 
 static
-int process_thread_map_event(struct perf_tool *tool,
-			     union perf_event *event,
-			     struct perf_session *session __maybe_unused)
+int process_thread_map_event(struct perf_session *session,
+			     union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
 
 	if (st->threads) {
@@ -1443,10 +1442,10 @@ int process_thread_map_event(struct perf_tool *tool,
 }
 
 static
-int process_cpu_map_event(struct perf_tool *tool,
-			  union perf_event *event,
-			  struct perf_session *session __maybe_unused)
+int process_cpu_map_event(struct perf_session *session,
+			  union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct perf_stat *st = container_of(tool, struct perf_stat, tool);
 	struct cpu_map *cpus;
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index db1511359c5e..86f0bc445f93 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -906,9 +906,8 @@ out_free:
 	return err;
 }
 
-int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
-				      union perf_event *event,
-				      struct perf_session *session)
+int perf_event__process_auxtrace_info(struct perf_session *session,
+				      union perf_event *event)
 {
 	enum auxtrace_type type = event->auxtrace_info.type;
 
@@ -1185,9 +1184,8 @@ void events_stats__auxtrace_error_warn(const struct events_stats *stats)
 	}
 }
 
-int perf_event__process_auxtrace_error(struct perf_tool *tool __maybe_unused,
-				       union perf_event *event,
-				       struct perf_session *session)
+int perf_event__process_auxtrace_error(struct perf_session *session,
+				       union perf_event *event)
 {
 	if (auxtrace__dont_decode(session))
 		return 0;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 71fc3bd74299..97776470a52e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -517,15 +517,13 @@ int perf_event__synthesize_auxtrace_info(struct auxtrace_record *itr,
 					 struct perf_tool *tool,
 					 struct perf_session *session,
 					 perf_event__handler_t process);
-int perf_event__process_auxtrace_info(struct perf_tool *tool,
-				      union perf_event *event,
-				      struct perf_session *session);
+int perf_event__process_auxtrace_info(struct perf_session *session,
+				      union perf_event *event);
 s64 perf_event__process_auxtrace(struct perf_tool *tool,
 				 union perf_event *event,
 				 struct perf_session *session);
-int perf_event__process_auxtrace_error(struct perf_tool *tool,
-				       union perf_event *event,
-				       struct perf_session *session);
+int perf_event__process_auxtrace_error(struct perf_session *session,
+				       union perf_event *event);
 int itrace_parse_synth_opts(const struct option *opt, const char *str,
 			    int unset);
 void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 91e6d9cfd906..c78051ad1fcc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3448,10 +3448,10 @@ int perf_event__synthesize_features(struct perf_tool *tool,
 	return ret;
 }
 
-int perf_event__process_feature(struct perf_tool *tool,
-				union perf_event *event,
-				struct perf_session *session __maybe_unused)
+int perf_event__process_feature(struct perf_session *session,
+				union perf_event *event)
 {
+	struct perf_tool *tool = session->tool;
 	struct feat_fd ff = { .fd = 0 };
 	struct feature_event *fe = (struct feature_event *)event;
 	int type = fe->header.type;
@@ -3856,9 +3856,8 @@ int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd,
 	return aligned_size;
 }
 
-int perf_event__process_tracing_data(struct perf_tool *tool __maybe_unused,
-				     union perf_event *event,
-				     struct perf_session *session)
+int perf_event__process_tracing_data(struct perf_session *session,
+				     union perf_event *event)
 {
 	ssize_t size_read, padding, size = event->tracing_data.size;
 	int fd = perf_data__fd(session->data);
@@ -3924,9 +3923,8 @@ int perf_event__synthesize_build_id(struct perf_tool *tool,
 	return err;
 }
 
-int perf_event__process_build_id(struct perf_tool *tool __maybe_unused,
-				 union perf_event *event,
-				 struct perf_session *session)
+int perf_event__process_build_id(struct perf_session *session,
+				 union perf_event *event)
 {
 	__event_process_build_id(&event->build_id,
 				 event->build_id.filename,
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index ff2a1263fb9b..e17903caa71d 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -116,9 +116,8 @@ int perf_event__synthesize_extra_attr(struct perf_tool *tool,
 				      perf_event__handler_t process,
 				      bool is_pipe);
 
-int perf_event__process_feature(struct perf_tool *tool,
-				union perf_event *event,
-				struct perf_session *session);
+int perf_event__process_feature(struct perf_session *session,
+				union perf_event *event);
 
 int perf_event__synthesize_attr(struct perf_tool *tool,
 				struct perf_event_attr *attr, u32 ids, u64 *id,
@@ -148,17 +147,15 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp);
 int perf_event__synthesize_tracing_data(struct perf_tool *tool,
 					int fd, struct perf_evlist *evlist,
 					perf_event__handler_t process);
-int perf_event__process_tracing_data(struct perf_tool *tool,
-				     union perf_event *event,
-				     struct perf_session *session);
+int perf_event__process_tracing_data(struct perf_session *session,
+				     union perf_event *event);
 
 int perf_event__synthesize_build_id(struct perf_tool *tool,
 				    struct dso *pos, u16 misc,
 				    perf_event__handler_t process,
 				    struct machine *machine);
-int perf_event__process_build_id(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session);
+int perf_event__process_build_id(struct perf_session *session,
+				 union perf_event *event);
 bool is_perf_magic(u64 magic);
 
 #define NAME_ALIGN 64
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 8b9369303561..e781cdba845c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -199,12 +199,10 @@ void perf_session__delete(struct perf_session *session)
 	free(session);
 }
 
-static int process_event_synth_tracing_data_stub(struct perf_tool *tool
+static int process_event_synth_tracing_data_stub(struct perf_session *session
 						 __maybe_unused,
 						 union perf_event *event
-						 __maybe_unused,
-						 struct perf_session *session
-						__maybe_unused)
+						 __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
@@ -288,9 +286,8 @@ static s64 process_event_auxtrace_stub(struct perf_tool *tool __maybe_unused,
 	return event->auxtrace.size;
 }
 
-static int process_event_op2_stub(struct perf_tool *tool __maybe_unused,
-				  union perf_event *event __maybe_unused,
-				  struct perf_session *session __maybe_unused)
+static int process_event_op2_stub(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused)
 {
 	dump_printf(": unhandled!\n");
 	return 0;
@@ -298,9 +295,8 @@ static int process_event_op2_stub(struct perf_tool *tool __maybe_unused,
 
 
 static
-int process_event_thread_map_stub(struct perf_tool *tool __maybe_unused,
-				  union perf_event *event __maybe_unused,
-				  struct perf_session *session __maybe_unused)
+int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_thread_map(event, stdout);
@@ -310,9 +306,8 @@ int process_event_thread_map_stub(struct perf_tool *tool __maybe_unused,
 }
 
 static
-int process_event_cpu_map_stub(struct perf_tool *tool __maybe_unused,
-			       union perf_event *event __maybe_unused,
-			       struct perf_session *session __maybe_unused)
+int process_event_cpu_map_stub(struct perf_session *session __maybe_unused,
+			       union perf_event *event __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_cpu_map(event, stdout);
@@ -322,9 +317,8 @@ int process_event_cpu_map_stub(struct perf_tool *tool __maybe_unused,
 }
 
 static
-int process_event_stat_config_stub(struct perf_tool *tool __maybe_unused,
-				   union perf_event *event __maybe_unused,
-				   struct perf_session *session __maybe_unused)
+int process_event_stat_config_stub(struct perf_session *session __maybe_unused,
+				   union perf_event *event __maybe_unused)
 {
 	if (dump_trace)
 		perf_event__fprintf_stat_config(event, stdout);
@@ -333,10 +327,8 @@ int process_event_stat_config_stub(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int process_stat_stub(struct perf_tool *tool __maybe_unused,
-			     union perf_event *event __maybe_unused,
-			     struct perf_session *perf_session
-			     __maybe_unused)
+static int process_stat_stub(struct perf_session *perf_session __maybe_unused,
+			     union perf_event *event)
 {
 	if (dump_trace)
 		perf_event__fprintf_stat(event, stdout);
@@ -345,10 +337,8 @@ static int process_stat_stub(struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-static int process_stat_round_stub(struct perf_tool *tool __maybe_unused,
-				   union perf_event *event __maybe_unused,
-				   struct perf_session *perf_session
-				   __maybe_unused)
+static int process_stat_round_stub(struct perf_session *perf_session __maybe_unused,
+				   union perf_event *event)
 {
 	if (dump_trace)
 		perf_event__fprintf_stat_round(event, stdout);
@@ -1374,37 +1364,37 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_HEADER_TRACING_DATA:
 		/* setup for reading amidst mmap */
 		lseek(fd, file_offset, SEEK_SET);
-		return tool->tracing_data(tool, event, session);
+		return tool->tracing_data(session, event);
 	case PERF_RECORD_HEADER_BUILD_ID:
-		return tool->build_id(tool, event, session);
+		return tool->build_id(session, event);
 	case PERF_RECORD_FINISHED_ROUND:
 		return tool->finished_round(tool, event, oe);
 	case PERF_RECORD_ID_INDEX:
-		return tool->id_index(tool, event, session);
+		return tool->id_index(session, event);
 	case PERF_RECORD_AUXTRACE_INFO:
-		return tool->auxtrace_info(tool, event, session);
+		return tool->auxtrace_info(session, event);
 	case PERF_RECORD_AUXTRACE:
 		/* setup for reading amidst mmap */
 		lseek(fd, file_offset + event->header.size, SEEK_SET);
 		return tool->auxtrace(tool, event, session);
 	case PERF_RECORD_AUXTRACE_ERROR:
 		perf_session__auxtrace_error_inc(session, event);
-		return tool->auxtrace_error(tool, event, session);
+		return tool->auxtrace_error(session, event);
 	case PERF_RECORD_THREAD_MAP:
-		return tool->thread_map(tool, event, session);
+		return tool->thread_map(session, event);
 	case PERF_RECORD_CPU_MAP:
-		return tool->cpu_map(tool, event, session);
+		return tool->cpu_map(session, event);
 	case PERF_RECORD_STAT_CONFIG:
-		return tool->stat_config(tool, event, session);
+		return tool->stat_config(session, event);
 	case PERF_RECORD_STAT:
-		return tool->stat(tool, event, session);
+		return tool->stat(session, event);
 	case PERF_RECORD_STAT_ROUND:
-		return tool->stat_round(tool, event, session);
+		return tool->stat_round(session, event);
 	case PERF_RECORD_TIME_CONV:
 		session->time_conv = event->time_conv;
-		return tool->time_conv(tool, event, session);
+		return tool->time_conv(session, event);
 	case PERF_RECORD_HEADER_FEATURE:
-		return tool->feature(tool, event, session);
+		return tool->feature(session, event);
 	default:
 		return -EINVAL;
 	}
@@ -2133,9 +2123,8 @@ out:
 	return err;
 }
 
-int perf_event__process_id_index(struct perf_tool *tool __maybe_unused,
-				 union perf_event *event,
-				 struct perf_session *session)
+int perf_event__process_id_index(struct perf_session *session,
+				 union perf_event *event)
 {
 	struct perf_evlist *evlist = session->evlist;
 	struct id_index_event *ie = &event->id_index;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index da40b4b380ca..d96eccd7d27f 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -120,9 +120,8 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample);
 
-int perf_event__process_id_index(struct perf_tool *tool,
-				 union perf_event *event,
-				 struct perf_session *session);
+int perf_event__process_id_index(struct perf_session *session,
+				 union perf_event *event);
 
 int perf_event__synthesize_id_index(struct perf_tool *tool,
 				    perf_event__handler_t process,
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 5d3172bcc4ae..4d40515307b8 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -374,9 +374,8 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	return 0;
 }
 
-int perf_event__process_stat_event(struct perf_tool *tool __maybe_unused,
-				   union perf_event *event,
-				   struct perf_session *session)
+int perf_event__process_stat_event(struct perf_session *session,
+				   union perf_event *event)
 {
 	struct perf_counts_values count;
 	struct stat_event *st = &event->stat;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 3a13a6dc5a62..2f9c9159a364 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -199,9 +199,8 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 struct perf_tool;
 union perf_event;
 struct perf_session;
-int perf_event__process_stat_event(struct perf_tool *tool,
-				   union perf_event *event,
-				   struct perf_session *session);
+int perf_event__process_stat_event(struct perf_session *session,
+				   union perf_event *event);
 
 size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 183c91453522..9c7f78d76275 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -26,8 +26,7 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_evlist **pevlist);
 
-typedef int (*event_op2)(struct perf_tool *tool, union perf_event *event,
-			 struct perf_session *session);
+typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
 
 typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);

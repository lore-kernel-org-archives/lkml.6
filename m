Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B20C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B4D218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbeLTSYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:24:31 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42339 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbeLTSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:24:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIOLEp3685841
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:24:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIOLYw3685837;
        Thu, 20 Dec 2018 10:24:21 -0800
Date:   Thu, 20 Dec 2018 10:24:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mw6peotz4n84rga0fk78buff@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com, lclaudio@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com
Reply-To: acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
          mingo@kernel.org, lclaudio@redhat.com, adrian.hunter@intel.com,
          namhyung@kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add alignment spaces after the closing
 parens
Git-Commit-ID: 4b8a240ed5e0a4e6b53c994ddfcff86a06879a66
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

Commit-ID:  4b8a240ed5e0a4e6b53c994ddfcff86a06879a66
Gitweb:     https://git.kernel.org/tip/4b8a240ed5e0a4e6b53c994ddfcff86a06879a66
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 11:48:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:10 -0300

perf trace: Add alignment spaces after the closing parens

To use strace's style, helping in comparing the output of 'perf trace'
with the one from 'strace', to help in upcoming regression tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mw6peotz4n84rga0fk78buff@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8a176ab2bd8e..226e994ac638 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1741,7 +1741,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, "%-*s) ...\n", trace->args_alignment, ttrace->entry_str);
+	printed += fprintf(trace->output, ")%-*s ...\n", trace->args_alignment, ttrace->entry_str);
 	ttrace->entry_pending = false;
 
 	++trace->nr_events_printed;
@@ -1798,7 +1798,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 {
 	char *msg;
 	void *args;
-	size_t printed = 0;
+	int printed = 0;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
 	int augmented_args_size = 0;
@@ -1847,8 +1847,13 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
+			int alignment = 0;
+
 			trace__fprintf_entry_head(trace, thread, 0, false, ttrace->entry_time, trace->output);
-			fprintf(trace->output, "%-*s)\n", trace->args_alignment, ttrace->entry_str);
+			printed = fprintf(trace->output, "%s)", ttrace->entry_str);
+			if (trace->args_alignment > printed)
+				alignment = trace->args_alignment - printed;
+			fprintf(trace->output, "%*s= ?\n", alignment, " ");
 		}
 	} else {
 		ttrace->entry_pending = true;
@@ -1943,7 +1948,8 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	u64 duration = 0;
 	bool duration_calculated = false;
 	struct thread *thread;
-	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0;
+	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
+	int alignment = trace->args_alignment;
 	struct syscall *sc = trace__syscall_info(trace, evsel, id);
 	struct thread_trace *ttrace;
 
@@ -1991,28 +1997,37 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	trace__fprintf_entry_head(trace, thread, duration, duration_calculated, ttrace->entry_time, trace->output);
 
 	if (ttrace->entry_pending) {
-		fprintf(trace->output, "%-*s", trace->args_alignment, ttrace->entry_str);
+		printed = fprintf(trace->output, "%s", ttrace->entry_str);
 	} else {
 		fprintf(trace->output, " ... [");
 		color_fprintf(trace->output, PERF_COLOR_YELLOW, "continued");
 		fprintf(trace->output, "]: %s()", sc->name);
 	}
 
+	printed++; /* the closing ')' */
+
+	if (alignment > printed)
+		alignment -= printed;
+	else
+		alignment = 0;
+
+	fprintf(trace->output, ")%*s= ", alignment, " ");
+
 	if (sc->fmt == NULL) {
 		if (ret < 0)
 			goto errno_print;
 signed_print:
-		fprintf(trace->output, ") = %ld", ret);
+		fprintf(trace->output, "%ld", ret);
 	} else if (ret < 0) {
 errno_print: {
 		char bf[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
 			   *e = errno_to_name(evsel, -ret);
 
-		fprintf(trace->output, ") = -1 %s %s", e, emsg);
+		fprintf(trace->output, "-1 %s %s", e, emsg);
 	}
 	} else if (ret == 0 && sc->fmt->timeout)
-		fprintf(trace->output, ") = 0 Timeout");
+		fprintf(trace->output, "0 Timeout");
 	else if (ttrace->ret_scnprintf) {
 		char bf[1024];
 		struct syscall_arg arg = {
@@ -2022,14 +2037,14 @@ errno_print: {
 		};
 		ttrace->ret_scnprintf(bf, sizeof(bf), &arg);
 		ttrace->ret_scnprintf = NULL;
-		fprintf(trace->output, ") = %s", bf);
+		fprintf(trace->output, "%s", bf);
 	} else if (sc->fmt->hexret)
-		fprintf(trace->output, ") = %#lx", ret);
+		fprintf(trace->output, "%#lx", ret);
 	else if (sc->fmt->errpid) {
 		struct thread *child = machine__find_thread(trace->host, ret, ret);
 
 		if (child != NULL) {
-			fprintf(trace->output, ") = %ld", ret);
+			fprintf(trace->output, "%ld", ret);
 			if (child->comm_set)
 				fprintf(trace->output, " (%s)", thread__comm_str(child));
 			thread__put(child);

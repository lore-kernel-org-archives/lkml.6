Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94791C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D1C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171286;
	bh=9G0I4k/UxmqepjwC1PJC5OEIikdJDtBDDjm77+ekhMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eZjQeIxa5teSMM9k5wecX57g0GCF6zshc3HISCgcs0AHQ+6nSdNcwMh9BFeyNbJng
	 F5ccn3ZvoPJ/135Z+m4pjQPhE2Gku0u/OmZTwXihm45t5uzf/JjpGtyDSRlkVSnbiR
	 vLBo3Dwiz59hLq/xx28s0FdkpDQY90ShoKxAZd0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeLRWOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbeLRWOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:14:44 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A16A6217D9;
        Tue, 18 Dec 2018 22:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171282;
        bh=9G0I4k/UxmqepjwC1PJC5OEIikdJDtBDDjm77+ekhMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKmvuSS+8vofEBGPepOnN2xT1bowBCmeDV9oogmMEVMB+XL8gznc73FF3kyD868un
         HJPfnztuF8drziIaKDZ6oLpT8g8WdSUZUyc7eYl9fA+VTCwR69YpZ1VnuIcpamP2St
         pqRwKnqXvH90De3rysQfDqJlNrDmFW6cBdUXkQrg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 47/63] perf trace: Add alignment spaces after the closing parens
Date:   Tue, 18 Dec 2018 19:07:17 -0300
Message-Id: <20181218220733.15839-48-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.19.2


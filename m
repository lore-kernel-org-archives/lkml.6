Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA4C04AB9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232A7214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2xdQYnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232A7214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbeHOSAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeHOSAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:00:09 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817DF214AB;
        Wed, 15 Aug 2018 15:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345655;
        bh=TyljiR4QTElLp29Vv6sTUWPMtx19fdLh+PHza1n5IXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2xdQYnB0QGmjWinEfx2LFMtPuon6m90nAaB0YS2xMD0UGy+jgIAy6aocetAZ1hXU
         RtR3QV3nxCGlrkXel8gABY2qITB4Ubp0IgsCLsBQLWXfmjjQbdgne6KYK1+TqMP1s6
         z35TArCPID4HDtXv800uEPrQUB9UUSKLy7QWHKUY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/35] tools lib traceevent, perf tools: Rename pevent_set_* APIs
Date:   Wed, 15 Aug 2018 12:05:47 -0300
Message-Id: <20180815150611.32080-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_set_file_bigendian, pevent_set_flag,
pevent_set_function_resolver, pevent_set_host_bigendian,
pevent_set_long_size, pevent_set_page_size and pevent_get_long_size

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180701.256265951@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c |  6 +++---
 tools/lib/traceevent/event-parse.h | 16 ++++++++--------
 tools/perf/builtin-report.c        |  6 +++---
 tools/perf/builtin-script.c        |  6 +++---
 tools/perf/util/machine.h          |  2 +-
 tools/perf/util/trace-event-read.c | 14 +++++++-------
 tools/perf/util/trace-event.c      |  8 ++++----
 7 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index cab411b99087..2667c18db27c 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -444,7 +444,7 @@ struct func_resolver {
 };
 
 /**
- * pevent_set_function_resolver - set an alternative function resolver
+ * tep_set_function_resolver - set an alternative function resolver
  * @pevent: handle for the pevent
  * @resolver: function to be used
  * @priv: resolver function private state.
@@ -453,8 +453,8 @@ struct func_resolver {
  * keep using it instead of duplicating all the entries inside
  * pevent->funclist.
  */
-int pevent_set_function_resolver(struct tep_handle *pevent,
-				 tep_func_resolver_t *func, void *priv)
+int tep_set_function_resolver(struct tep_handle *pevent,
+			      tep_func_resolver_t *func, void *priv)
 {
 	struct func_resolver *resolver = malloc(sizeof(*resolver));
 
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 399dea66b80e..a68591c8dec3 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -532,7 +532,7 @@ struct tep_handle {
 	char *trace_clock;
 };
 
-static inline void pevent_set_flag(struct tep_handle *pevent, int flag)
+static inline void tep_set_flag(struct tep_handle *pevent, int flag)
 {
 	pevent->flags |= flag;
 }
@@ -615,8 +615,8 @@ enum trace_flag_type {
 	TRACE_FLAG_SOFTIRQ		= 0x10,
 };
 
-int pevent_set_function_resolver(struct tep_handle *pevent,
-				 tep_func_resolver_t *func, void *priv);
+int tep_set_function_resolver(struct tep_handle *pevent,
+			      tep_func_resolver_t *func, void *priv);
 void pevent_reset_function_resolver(struct tep_handle *pevent);
 int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
 int pevent_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
@@ -741,12 +741,12 @@ static inline void pevent_set_cpus(struct tep_handle *pevent, int cpus)
 	pevent->cpus = cpus;
 }
 
-static inline int pevent_get_long_size(struct tep_handle *pevent)
+static inline int tep_get_long_size(struct tep_handle *pevent)
 {
 	return pevent->long_size;
 }
 
-static inline void pevent_set_long_size(struct tep_handle *pevent, int long_size)
+static inline void tep_set_long_size(struct tep_handle *pevent, int long_size)
 {
 	pevent->long_size = long_size;
 }
@@ -756,7 +756,7 @@ static inline int pevent_get_page_size(struct tep_handle *pevent)
 	return pevent->page_size;
 }
 
-static inline void pevent_set_page_size(struct tep_handle *pevent, int _page_size)
+static inline void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 {
 	pevent->page_size = _page_size;
 }
@@ -766,7 +766,7 @@ static inline int pevent_is_file_bigendian(struct tep_handle *pevent)
 	return pevent->file_bigendian;
 }
 
-static inline void pevent_set_file_bigendian(struct tep_handle *pevent, int endian)
+static inline void tep_set_file_bigendian(struct tep_handle *pevent, int endian)
 {
 	pevent->file_bigendian = endian;
 }
@@ -776,7 +776,7 @@ static inline int pevent_is_host_bigendian(struct tep_handle *pevent)
 	return pevent->host_bigendian;
 }
 
-static inline void pevent_set_host_bigendian(struct tep_handle *pevent, int endian)
+static inline void tep_set_host_bigendian(struct tep_handle *pevent, int endian)
 {
 	pevent->host_bigendian = endian;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 143542ffac20..76e12bcd1765 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1369,9 +1369,9 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (session->tevent.pevent &&
-	    pevent_set_function_resolver(session->tevent.pevent,
-					 machine__resolve_kernel_addr,
-					 &session->machines.host) < 0) {
+	    tep_set_function_resolver(session->tevent.pevent,
+				      machine__resolve_kernel_addr,
+				      &session->machines.host) < 0) {
 		pr_err("%s: failed to set libtraceevent function resolver\n",
 		       __func__);
 		return -1;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 568ddfac3213..ba481d73f910 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3429,9 +3429,9 @@ int cmd_script(int argc, const char **argv)
 		symbol_conf.use_callchain = false;
 
 	if (session->tevent.pevent &&
-	    pevent_set_function_resolver(session->tevent.pevent,
-					 machine__resolve_kernel_addr,
-					 &session->machines.host) < 0) {
+	    tep_set_function_resolver(session->tevent.pevent,
+				      machine__resolve_kernel_addr,
+				      &session->machines.host) < 0) {
 		pr_err("%s: failed to set libtraceevent function resolver\n", __func__);
 		err = -1;
 		goto out_delete;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 1de7660d93e9..d856b85862e2 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -265,7 +265,7 @@ pid_t machine__get_current_tid(struct machine *machine, int cpu);
 int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid);
 /*
- * For use with libtraceevent's pevent_set_function_resolver()
+ * For use with libtraceevent's tep_set_function_resolver()
  */
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp);
 
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index 850f7bf0eced..d970163f0145 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -236,12 +236,12 @@ static int read_header_files(struct tep_handle *pevent)
 	}
 
 	if (!tep_parse_header_page(pevent, header_page, size,
-				   pevent_get_long_size(pevent))) {
+				   tep_get_long_size(pevent))) {
 		/*
 		 * The commit field in the page is of type long,
 		 * use that instead, since it represents the kernel.
 		 */
-		pevent_set_long_size(pevent, pevent->header_page_size_size);
+		tep_set_long_size(pevent, pevent->header_page_size_size);
 	}
 	free(header_page);
 
@@ -439,9 +439,9 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 
 	pevent = tevent->pevent;
 
-	pevent_set_flag(pevent, PEVENT_NSEC_OUTPUT);
-	pevent_set_file_bigendian(pevent, file_bigendian);
-	pevent_set_host_bigendian(pevent, host_bigendian);
+	tep_set_flag(pevent, PEVENT_NSEC_OUTPUT);
+	tep_set_file_bigendian(pevent, file_bigendian);
+	tep_set_host_bigendian(pevent, host_bigendian);
 
 	if (do_read(buf, 1) < 0)
 		goto out;
@@ -451,8 +451,8 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 	if (!file_page_size)
 		goto out;
 
-	pevent_set_long_size(pevent, file_long_size);
-	pevent_set_page_size(pevent, file_page_size);
+	tep_set_long_size(pevent, file_long_size);
+	tep_set_page_size(pevent, file_page_size);
 
 	err = read_header_files(pevent);
 	if (err)
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index eed1c11c1915..679c93644a08 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -47,9 +47,9 @@ static int trace_event__init2(void)
 		return -1;
 
 	pevent = tevent.pevent;
-	pevent_set_flag(pevent, PEVENT_NSEC_OUTPUT);
-	pevent_set_file_bigendian(pevent, be);
-	pevent_set_host_bigendian(pevent, be);
+	tep_set_flag(pevent, PEVENT_NSEC_OUTPUT);
+	tep_set_file_bigendian(pevent, be);
+	tep_set_host_bigendian(pevent, be);
 	tevent_initialized = true;
 	return 0;
 }
@@ -60,7 +60,7 @@ int trace_event__register_resolver(struct machine *machine,
 	if (!tevent_initialized && trace_event__init2())
 		return -1;
 
-	return pevent_set_function_resolver(tevent.pevent, func, machine);
+	return tep_set_function_resolver(tevent.pevent, func, machine);
 }
 
 void trace_event__cleanup(struct trace_event *t)
-- 
2.14.4


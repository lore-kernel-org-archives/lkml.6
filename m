Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C9C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8007021878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8007021878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeHROz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:55:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:55:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBm97m1290319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:48:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBm93C1290316;
        Sat, 18 Aug 2018 04:48:09 -0700
Date:   Sat, 18 Aug 2018 04:48:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-ece2a4f48386acf7e35a751008976c9dda8d6232@git.kernel.org>
Cc:     y.karadz@gmail.com, rostedt@goodmis.org, mingo@kernel.org,
        tz.stoyanov@gmail.com, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        akpm@linux-foundation.org
Reply-To: peterz@infradead.org, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org,
          y.karadz@gmail.com, hpa@zytor.com, tz.stoyanov@gmail.com
In-Reply-To: <20180808180701.256265951@goodmis.org>
References: <20180808180701.256265951@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent, perf tools: Rename
 pevent_set_* APIs
Git-Commit-ID: ece2a4f48386acf7e35a751008976c9dda8d6232
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

Commit-ID:  ece2a4f48386acf7e35a751008976c9dda8d6232
Gitweb:     https://git.kernel.org/tip/ece2a4f48386acf7e35a751008976c9dda8d6232
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:02:55 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:22:10 -0300

tools lib traceevent, perf tools: Rename pevent_set_* APIs

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
@@ -1369,9 +1369,9 @@ repeat:
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

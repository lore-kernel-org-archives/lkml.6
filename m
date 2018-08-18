Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790CC218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790CC218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeHRO45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:56:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:56:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBnAOf1290401
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:49:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBnAbl1290397;
        Sat, 18 Aug 2018 04:49:10 -0700
Date:   Sat, 18 Aug 2018 04:49:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-6fed932e9242b55a32dd75da7c2448b9b0c48a73@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, y.karadz@gmail.com,
        rostedt@goodmis.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, tz.stoyanov@gmail.com,
        acme@redhat.com, peterz@infradead.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, mingo@kernel.org, rostedt@goodmis.org,
          y.karadz@gmail.com, akpm@linux-foundation.org,
          tz.stoyanov@gmail.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20180808180701.623942406@goodmis.org>
References: <20180808180701.623942406@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent, perf tools: Rename 'enum
 pevent_flag' to 'enum tep_flag'
Git-Commit-ID: 6fed932e9242b55a32dd75da7c2448b9b0c48a73
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

Commit-ID:  6fed932e9242b55a32dd75da7c2448b9b0c48a73
Gitweb:     https://git.kernel.org/tip/6fed932e9242b55a32dd75da7c2448b9b0c48a73
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:02:57 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:22:18 -0300

tools lib traceevent, perf tools: Rename 'enum pevent_flag' to 'enum tep_flag'

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
pevent_get_page_size API and enum pevent_flag to enum tep_flag

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180701.623942406@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c  |  2 +-
 tools/lib/traceevent/event-parse.h  | 10 +++++-----
 tools/lib/traceevent/event-plugin.c |  4 ++--
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/util/trace-event-read.c  |  2 +-
 tools/perf/util/trace-event.c       |  2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 2667c18db27c..cfb86b789da6 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5515,7 +5515,7 @@ void tep_print_event_time(struct tep_handle *pevent, struct trace_seq *s,
 	}
 
 	if (use_usec_format) {
-		if (pevent->flags & PEVENT_NSEC_OUTPUT) {
+		if (pevent->flags & TEP_NSEC_OUTPUT) {
 			usecs = nsecs;
 			p = 9;
 		} else {
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 97abeaced9c3..97deb15f5355 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -373,10 +373,10 @@ enum pevent_func_arg_type {
 	PEVENT_FUNC_ARG_MAX_TYPES
 };
 
-enum pevent_flag {
-	PEVENT_NSEC_OUTPUT		= 1,	/* output in NSECS */
-	PEVENT_DISABLE_SYS_PLUGINS	= 1 << 1,
-	PEVENT_DISABLE_PLUGINS		= 1 << 2,
+enum tep_flag {
+	TEP_NSEC_OUTPUT		= 1,	/* output in NSECS */
+	TEP_DISABLE_SYS_PLUGINS	= 1 << 1,
+	TEP_DISABLE_PLUGINS	= 1 << 2,
 };
 
 #define PEVENT_ERRORS 							      \
@@ -751,7 +751,7 @@ static inline void tep_set_long_size(struct tep_handle *pevent, int long_size)
 	pevent->long_size = long_size;
 }
 
-static inline int pevent_get_page_size(struct tep_handle *pevent)
+static inline int tep_get_page_size(struct tep_handle *pevent)
 {
 	return pevent->page_size;
 }
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index 39859cee7712..c837a73c03e6 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -390,7 +390,7 @@ load_plugins(struct tep_handle *pevent, const char *suffix,
 	char *envdir;
 	int ret;
 
-	if (pevent->flags & PEVENT_DISABLE_PLUGINS)
+	if (pevent->flags & TEP_DISABLE_PLUGINS)
 		return;
 
 	/*
@@ -398,7 +398,7 @@ load_plugins(struct tep_handle *pevent, const char *suffix,
 	 * check that first.
 	 */
 #ifdef PLUGIN_DIR
-	if (!(pevent->flags & PEVENT_DISABLE_SYS_PLUGINS))
+	if (!(pevent->flags & TEP_DISABLE_SYS_PLUGINS))
 		load_plugins_dir(pevent, suffix, PLUGIN_DIR,
 				 load_plugin, data);
 #endif
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 73c073ade71c..b63bca4b0c2a 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1974,7 +1974,7 @@ int cmd_kmem(int argc, const char **argv)
 			goto out_delete;
 		}
 
-		kmem_page_size = pevent_get_page_size(evsel->tp_format->pevent);
+		kmem_page_size = tep_get_page_size(evsel->tp_format->pevent);
 		symbol_conf.use_callchain = true;
 	}
 
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index d970163f0145..3dfc1db6b25b 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -439,7 +439,7 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 
 	pevent = tevent->pevent;
 
-	tep_set_flag(pevent, PEVENT_NSEC_OUTPUT);
+	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
 	tep_set_file_bigendian(pevent, file_bigendian);
 	tep_set_host_bigendian(pevent, host_bigendian);
 
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 3102e8be81f5..58bb72f266f3 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -47,7 +47,7 @@ static int trace_event__init2(void)
 		return -1;
 
 	pevent = tevent.pevent;
-	tep_set_flag(pevent, PEVENT_NSEC_OUTPUT);
+	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
 	tep_set_file_bigendian(pevent, be);
 	tep_set_host_bigendian(pevent, be);
 	tevent_initialized = true;

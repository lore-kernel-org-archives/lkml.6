Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBC4C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B8221748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B8221748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeHROz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:55:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:55:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBleHX1290108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:47:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBldej1290105;
        Sat, 18 Aug 2018 04:47:39 -0700
Date:   Sat, 18 Aug 2018 04:47:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-13a418904ee19e7a9892619cc93b025b31d08134@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, y.karadz@gmail.com, hpa@zytor.com,
        tz.stoyanov@gmail.com, mingo@kernel.org, akpm@linux-foundation.org,
        acme@redhat.com, peterz@infradead.org
Reply-To: akpm@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          tz.stoyanov@gmail.com, rostedt@goodmis.org, y.karadz@gmail.com
In-Reply-To: <20180808180700.948980691@goodmis.org>
References: <20180808180700.948980691@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent, perf tools: Rename
 pevent_register_* APIs
Git-Commit-ID: 13a418904ee19e7a9892619cc93b025b31d08134
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

Commit-ID:  13a418904ee19e7a9892619cc93b025b31d08134
Gitweb:     https://git.kernel.org/tip/13a418904ee19e7a9892619cc93b025b31d08134
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:02:54 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:22:08 -0300

tools lib traceevent, perf tools: Rename pevent_register_* APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_register_comm, pevent_register_print_string

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180700.948980691@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c         | 10 +++++-----
 tools/lib/traceevent/event-parse.h         |  6 +++---
 tools/lib/traceevent/plugin_sched_switch.c |  2 +-
 tools/perf/util/trace-event-parse.c        |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 4220b15781c8..cab411b99087 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -288,7 +288,7 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 }
 
 /**
- * pevent_register_comm - register a pid / comm mapping
+ * tep_register_comm - register a pid / comm mapping
  * @pevent: handle for the pevent
  * @comm: the command line to register
  * @pid: the pid to map the command line to
@@ -296,7 +296,7 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
  * This adds a mapping to search for command line names with
  * a given pid. The comm is duplicated.
  */
-int pevent_register_comm(struct tep_handle *pevent, const char *comm, int pid)
+int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
 {
 	struct cmdline_list *item;
 
@@ -685,7 +685,7 @@ find_printk(struct tep_handle *pevent, unsigned long long addr)
 }
 
 /**
- * pevent_register_print_string - register a string by its address
+ * tep_register_print_string - register a string by its address
  * @pevent: handle for the pevent
  * @fmt: the string format to register
  * @addr: the address the string was located at
@@ -693,8 +693,8 @@ find_printk(struct tep_handle *pevent, unsigned long long addr)
  * This registers a string by the address it was stored in the kernel.
  * The @fmt passed in is duplicated.
  */
-int pevent_register_print_string(struct tep_handle *pevent, const char *fmt,
-				 unsigned long long addr)
+int tep_register_print_string(struct tep_handle *pevent, const char *fmt,
+			      unsigned long long addr)
 {
 	struct printk_list *item = malloc(sizeof(*item));
 	char *p;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 58d9f0dedf05..399dea66b80e 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -618,12 +618,12 @@ enum trace_flag_type {
 int pevent_set_function_resolver(struct tep_handle *pevent,
 				 tep_func_resolver_t *func, void *priv);
 void pevent_reset_function_resolver(struct tep_handle *pevent);
-int pevent_register_comm(struct tep_handle *pevent, const char *comm, int pid);
+int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
 int pevent_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
 int pevent_register_function(struct tep_handle *pevent, char *name,
 			     unsigned long long addr, char *mod);
-int pevent_register_print_string(struct tep_handle *pevent, const char *fmt,
-				 unsigned long long addr);
+int tep_register_print_string(struct tep_handle *pevent, const char *fmt,
+			      unsigned long long addr);
 int pevent_pid_is_registered(struct tep_handle *pevent, int pid);
 
 void tep_print_event_task(struct tep_handle *pevent, struct trace_seq *s,
diff --git a/tools/lib/traceevent/plugin_sched_switch.c b/tools/lib/traceevent/plugin_sched_switch.c
index 90d2ef293cf9..4d8eaab6ac15 100644
--- a/tools/lib/traceevent/plugin_sched_switch.c
+++ b/tools/lib/traceevent/plugin_sched_switch.c
@@ -61,7 +61,7 @@ static void write_and_save_comm(struct format_field *field,
 	comm = &s->buffer[len];
 
 	/* Help out the comm to ids. This will handle dups */
-	pevent_register_comm(field->event->pevent, comm, pid);
+	tep_register_comm(field->event->pevent, comm, pid);
 }
 
 static int sched_wakeup_handler(struct trace_seq *s,
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index a0e2b2c54567..920b1d58a068 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -157,7 +157,7 @@ void parse_ftrace_printk(struct tep_handle *pevent,
 		/* fmt still has a space, skip it */
 		printk = strdup(fmt+1);
 		line = strtok_r(NULL, "\n", &next);
-		pevent_register_print_string(pevent, printk, addr);
+		tep_register_print_string(pevent, printk, addr);
 	}
 }
 
@@ -172,7 +172,7 @@ void parse_saved_cmdline(struct tep_handle *pevent,
 	line = strtok_r(file, "\n", &next);
 	while (line) {
 		sscanf(line, "%d %ms", &pid, &comm);
-		pevent_register_comm(pevent, comm, pid);
+		tep_register_comm(pevent, comm, pid);
 		free(comm);
 		line = strtok_r(NULL, "\n", &next);
 	}

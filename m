Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31901C46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C7521A84
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C7521A84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeHHU1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbeHHU1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:27:53 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F0AE21A6D;
        Wed,  8 Aug 2018 18:07:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fnSrN-0002Ob-1g; Wed, 08 Aug 2018 14:07:01 -0400
Message-Id: <20180808180700.948980691@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 Aug 2018 14:02:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [RFC][PATCH v2 09/24] tools/lib/traceevent, tools/perf: Rename pevent_register_* APIs
References: <20180808180245.352784763@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
APIs: pevent_register_comm, pevent_register_print_string

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
-- 
2.18.0



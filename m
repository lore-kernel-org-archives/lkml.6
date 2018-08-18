Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A54C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9EB21748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9EB21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeHRO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:56:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44275 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:56:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBmeUO1290364
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:48:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBmewq1290361;
        Sat, 18 Aug 2018 04:48:40 -0700
Date:   Sat, 18 Aug 2018 04:48:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-fc9b69710e0e5833c5d3e56c37cb56cfe89217c3@git.kernel.org>
Cc:     y.karadz@gmail.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, tz.stoyanov@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org
Reply-To: hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de,
          mingo@kernel.org, rostedt@goodmis.org, tz.stoyanov@gmail.com,
          peterz@infradead.org, y.karadz@gmail.com, acme@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180808180701.484691639@goodmis.org>
References: <20180808180701.484691639@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent, perf tools: Rename
 traceevent_* APIs
Git-Commit-ID: fc9b69710e0e5833c5d3e56c37cb56cfe89217c3
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

Commit-ID:  fc9b69710e0e5833c5d3e56c37cb56cfe89217c3
Gitweb:     https://git.kernel.org/tip/fc9b69710e0e5833c5d3e56c37cb56cfe89217c3
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:02:56 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:22:16 -0300

tools lib traceevent, perf tools: Rename traceevent_* APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "traceevent_". This
changes APIs: traceevent_host_bigendian, traceevent_load_plugins and
traceevent_unload_plugins

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180701.484691639@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h  | 8 ++++----
 tools/lib/traceevent/event-plugin.c | 8 ++++----
 tools/perf/util/trace-event.c       | 6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index a68591c8dec3..97abeaced9c3 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -435,9 +435,9 @@ struct plugin_list;
 
 #define INVALID_PLUGIN_LIST_OPTION	((char **)((unsigned long)-1))
 
-struct plugin_list *traceevent_load_plugins(struct tep_handle *pevent);
-void traceevent_unload_plugins(struct plugin_list *plugin_list,
-			       struct tep_handle *pevent);
+struct plugin_list *tep_load_plugins(struct tep_handle *pevent);
+void tep_unload_plugins(struct plugin_list *plugin_list,
+			struct tep_handle *pevent);
 char **traceevent_plugin_list_options(void);
 void traceevent_plugin_free_options_list(char **list);
 int traceevent_plugin_add_options(const char *name,
@@ -597,7 +597,7 @@ __data2host8(struct tep_handle *pevent, unsigned long long data)
 	__data2host8(pevent, __val);				\
 })
 
-static inline int traceevent_host_bigendian(void)
+static inline int tep_host_bigendian(void)
 {
 	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4 };
 	unsigned int val;
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index 8c91c8f0abd9..39859cee7712 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -264,10 +264,10 @@ void traceevent_plugin_remove_options(struct tep_plugin_option *options)
  * @s: the trace_seq descripter to write to
  * @prefix: The prefix string to add before listing the option name
  * @suffix: The suffix string ot append after the option name
- * @list: The list of plugins (usually returned by traceevent_load_plugins()
+ * @list: The list of plugins (usually returned by tep_load_plugins()
  *
  * Writes to the trace_seq @s the list of plugins (files) that is
- * returned by traceevent_load_plugins(). Use @prefix and @suffix for formating:
+ * returned by tep_load_plugins(). Use @prefix and @suffix for formating:
  * @prefix = "  ", @suffix = "\n".
  */
 void traceevent_print_plugins(struct trace_seq *s,
@@ -431,7 +431,7 @@ load_plugins(struct tep_handle *pevent, const char *suffix,
 }
 
 struct plugin_list*
-traceevent_load_plugins(struct tep_handle *pevent)
+tep_load_plugins(struct tep_handle *pevent)
 {
 	struct plugin_list *list = NULL;
 
@@ -440,7 +440,7 @@ traceevent_load_plugins(struct tep_handle *pevent)
 }
 
 void
-traceevent_unload_plugins(struct plugin_list *plugin_list, struct tep_handle *pevent)
+tep_unload_plugins(struct plugin_list *plugin_list, struct tep_handle *pevent)
 {
 	tep_plugin_unload_func func;
 	struct plugin_list *list;
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index 679c93644a08..3102e8be81f5 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -31,7 +31,7 @@ int trace_event__init(struct trace_event *t)
 	struct tep_handle *pevent = tep_alloc();
 
 	if (pevent) {
-		t->plugin_list = traceevent_load_plugins(pevent);
+		t->plugin_list = tep_load_plugins(pevent);
 		t->pevent  = pevent;
 	}
 
@@ -40,7 +40,7 @@ int trace_event__init(struct trace_event *t)
 
 static int trace_event__init2(void)
 {
-	int be = traceevent_host_bigendian();
+	int be = tep_host_bigendian();
 	struct tep_handle *pevent;
 
 	if (trace_event__init(&tevent))
@@ -65,7 +65,7 @@ int trace_event__register_resolver(struct machine *machine,
 
 void trace_event__cleanup(struct trace_event *t)
 {
-	traceevent_unload_plugins(t->plugin_list, t->pevent);
+	tep_unload_plugins(t->plugin_list, t->pevent);
 	tep_free(t->pevent);
 }
 

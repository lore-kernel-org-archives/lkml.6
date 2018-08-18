Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7966C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91246218A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91246218A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeHRO62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:58:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:58:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBofoD1290529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:50:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBoeeI1290526;
        Sat, 18 Aug 2018 04:50:40 -0700
Date:   Sat, 18 Aug 2018 04:50:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-ca2921dd90268dc37cd5096eb985da4288aa7041@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, y.karadz@gmail.com, rostedt@goodmis.org,
        akpm@linux-foundation.org, tz.stoyanov@gmail.com, acme@redhat.com,
        mingo@kernel.org
Reply-To: tz.stoyanov@gmail.com, rostedt@goodmis.org,
          akpm@linux-foundation.org, mingo@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          y.karadz@gmail.com, peterz@infradead.org
In-Reply-To: <20180808180702.089951638@goodmis.org>
References: <20180808180702.089951638@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent,  perf tools: Rename
 traceevent_plugin_* APIs
Git-Commit-ID: ca2921dd90268dc37cd5096eb985da4288aa7041
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

Commit-ID:  ca2921dd90268dc37cd5096eb985da4288aa7041
Gitweb:     https://git.kernel.org/tip/ca2921dd90268dc37cd5096eb985da4288aa7041
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:03:00 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:25:36 -0300

tools lib traceevent,  perf tools: Rename traceevent_plugin_* APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "traceevent_". This changes
APIs: traceevent_plugin_list_options, traceevent_plugin_free_options_list,
traceevent_plugin_add_options, traceevent_plugin_remove_options,
traceevent_print_plugins

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180702.089951638@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h     | 16 ++++++++--------
 tools/lib/traceevent/event-plugin.c    | 28 ++++++++++++++--------------
 tools/lib/traceevent/plugin_function.c |  4 ++--
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 81f34132fc47..ec327849a7dc 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -438,14 +438,14 @@ struct plugin_list;
 struct plugin_list *tep_load_plugins(struct tep_handle *pevent);
 void tep_unload_plugins(struct plugin_list *plugin_list,
 			struct tep_handle *pevent);
-char **traceevent_plugin_list_options(void);
-void traceevent_plugin_free_options_list(char **list);
-int traceevent_plugin_add_options(const char *name,
-				  struct tep_plugin_option *options);
-void traceevent_plugin_remove_options(struct tep_plugin_option *options);
-void traceevent_print_plugins(struct trace_seq *s,
-			      const char *prefix, const char *suffix,
-			      const struct plugin_list *list);
+char **tep_plugin_list_options(void);
+void tep_plugin_free_options_list(char **list);
+int tep_plugin_add_options(const char *name,
+			   struct tep_plugin_option *options);
+void tep_plugin_remove_options(struct tep_plugin_option *options);
+void tep_print_plugins(struct trace_seq *s,
+			const char *prefix, const char *suffix,
+			const struct plugin_list *list);
 
 struct cmdline;
 struct cmdline_list;
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index c837a73c03e6..8e324ed46547 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -97,7 +97,7 @@ static int update_option_value(struct tep_plugin_option *op, const char *val)
 }
 
 /**
- * traceevent_plugin_list_options - get list of plugin options
+ * tep_plugin_list_options - get list of plugin options
  *
  * Returns an array of char strings that list the currently registered
  * plugin options in the format of <plugin>:<option>. This list can be
@@ -106,9 +106,9 @@ static int update_option_value(struct tep_plugin_option *op, const char *val)
  * Returns NULL if there's no options registered. On error it returns
  * INVALID_PLUGIN_LIST_OPTION
  *
- * Must be freed with traceevent_plugin_free_options_list().
+ * Must be freed with tep_plugin_free_options_list().
  */
-char **traceevent_plugin_list_options(void)
+char **tep_plugin_list_options(void)
 {
 	struct registered_plugin_options *reg;
 	struct tep_plugin_option *op;
@@ -146,7 +146,7 @@ char **traceevent_plugin_list_options(void)
 	return INVALID_PLUGIN_LIST_OPTION;
 }
 
-void traceevent_plugin_free_options_list(char **list)
+void tep_plugin_free_options_list(char **list)
 {
 	int i;
 
@@ -215,14 +215,14 @@ update_option(const char *file, struct tep_plugin_option *option)
 }
 
 /**
- * traceevent_plugin_add_options - Add a set of options by a plugin
+ * tep_plugin_add_options - Add a set of options by a plugin
  * @name: The name of the plugin adding the options
  * @options: The set of options being loaded
  *
  * Sets the options with the values that have been added by user.
  */
-int traceevent_plugin_add_options(const char *name,
-				  struct tep_plugin_option *options)
+int tep_plugin_add_options(const char *name,
+			   struct tep_plugin_option *options)
 {
 	struct registered_plugin_options *reg;
 
@@ -241,10 +241,10 @@ int traceevent_plugin_add_options(const char *name,
 }
 
 /**
- * traceevent_plugin_remove_options - remove plugin options that were registered
- * @options: Options to removed that were registered with traceevent_plugin_add_options
+ * tep_plugin_remove_options - remove plugin options that were registered
+ * @options: Options to removed that were registered with tep_plugin_add_options
  */
-void traceevent_plugin_remove_options(struct tep_plugin_option *options)
+void tep_plugin_remove_options(struct tep_plugin_option *options)
 {
 	struct registered_plugin_options **last;
 	struct registered_plugin_options *reg;
@@ -260,7 +260,7 @@ void traceevent_plugin_remove_options(struct tep_plugin_option *options)
 }
 
 /**
- * traceevent_print_plugins - print out the list of plugins loaded
+ * tep_print_plugins - print out the list of plugins loaded
  * @s: the trace_seq descripter to write to
  * @prefix: The prefix string to add before listing the option name
  * @suffix: The suffix string ot append after the option name
@@ -270,9 +270,9 @@ void traceevent_plugin_remove_options(struct tep_plugin_option *options)
  * returned by tep_load_plugins(). Use @prefix and @suffix for formating:
  * @prefix = "  ", @suffix = "\n".
  */
-void traceevent_print_plugins(struct trace_seq *s,
-			      const char *prefix, const char *suffix,
-			      const struct plugin_list *list)
+void tep_print_plugins(struct trace_seq *s,
+		       const char *prefix, const char *suffix,
+		       const struct plugin_list *list)
 {
 	while (list) {
 		trace_seq_printf(s, "%s%s%s", prefix, list->name, suffix);
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugin_function.c
index 342be570ee8c..57165da1bd51 100644
--- a/tools/lib/traceevent/plugin_function.c
+++ b/tools/lib/traceevent/plugin_function.c
@@ -168,7 +168,7 @@ int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 	pevent_register_event_handler(pevent, -1, "ftrace", "function",
 				      function_handler, NULL);
 
-	traceevent_plugin_add_options("ftrace", plugin_options);
+	tep_plugin_add_options("ftrace", plugin_options);
 
 	return 0;
 }
@@ -186,7 +186,7 @@ void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 		free(fstack[i].stack);
 	}
 
-	traceevent_plugin_remove_options(plugin_options);
+	tep_plugin_remove_options(plugin_options);
 
 	free(fstack);
 	fstack = NULL;

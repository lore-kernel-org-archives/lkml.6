Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F61C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014A621748
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014A621748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeHROwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:52:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeHROwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:52:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBiXMR1289661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:44:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBiXpJ1289658;
        Sat, 18 Aug 2018 04:44:33 -0700
Date:   Sat, 18 Aug 2018 04:44:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-c32d52b4641d3c7b2569b3fe148bf687e5c61888@git.kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, peterz@infradead.org,
        y.karadz@gmail.com, acme@redhat.com, tz.stoyanov@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org
Reply-To: peterz@infradead.org, y.karadz@gmail.com, acme@redhat.com,
          tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org,
          hpa@zytor.com, tz.stoyanov@gmail.com, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180808180700.005287044@goodmis.org>
References: <20180808180700.005287044@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent, perf tools: Rename pevent
 plugin related APIs
Git-Commit-ID: c32d52b4641d3c7b2569b3fe148bf687e5c61888
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

Commit-ID:  c32d52b4641d3c7b2569b3fe148bf687e5c61888
Gitweb:     https://git.kernel.org/tip/c32d52b4641d3c7b2569b3fe148bf687e5c61888
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 8 Aug 2018 14:02:48 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 13 Aug 2018 15:21:39 -0300

tools lib traceevent, perf tools: Rename pevent plugin related APIs

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_" and not "pevent_". This changes
the pevent plugin related API.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180808180700.005287044@goodmis.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c         |  8 ++---
 tools/lib/traceevent/event-parse.h         | 56 +++++++++++++++---------------
 tools/lib/traceevent/event-plugin.c        | 24 ++++++-------
 tools/lib/traceevent/plugin_cfg80211.c     |  4 +--
 tools/lib/traceevent/plugin_function.c     | 10 +++---
 tools/lib/traceevent/plugin_hrtimer.c      |  4 +--
 tools/lib/traceevent/plugin_jbd2.c         |  4 +--
 tools/lib/traceevent/plugin_kmem.c         |  4 +--
 tools/lib/traceevent/plugin_kvm.c          |  4 +--
 tools/lib/traceevent/plugin_mac80211.c     |  4 +--
 tools/lib/traceevent/plugin_sched_switch.c |  4 +--
 tools/lib/traceevent/plugin_scsi.c         |  4 +--
 tools/lib/traceevent/plugin_xen.c          |  4 +--
 13 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 90f30f9dde14..57ed9348d1aa 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -88,7 +88,7 @@ struct event_handler {
 	int				id;
 	const char			*sys_name;
 	const char			*event_name;
-	pevent_event_handler_func	func;
+	tep_event_handler_func		func;
 	void				*context;
 };
 
@@ -6633,7 +6633,7 @@ static struct event_format *pevent_search_event(struct tep_handle *pevent, int i
  */
 int pevent_register_event_handler(struct tep_handle *pevent, int id,
 				  const char *sys_name, const char *event_name,
-				  pevent_event_handler_func func, void *context)
+				  tep_event_handler_func func, void *context)
 {
 	struct event_format *event;
 	struct event_handler *handle;
@@ -6682,7 +6682,7 @@ int pevent_register_event_handler(struct tep_handle *pevent, int id,
 
 static int handle_matches(struct event_handler *handler, int id,
 			  const char *sys_name, const char *event_name,
-			  pevent_event_handler_func func, void *context)
+			  tep_event_handler_func func, void *context)
 {
 	if (id >= 0 && id != handler->id)
 		return 0;
@@ -6717,7 +6717,7 @@ static int handle_matches(struct event_handler *handler, int id,
  */
 int pevent_unregister_event_handler(struct tep_handle *pevent, int id,
 				    const char *sys_name, const char *event_name,
-				    pevent_event_handler_func func, void *context)
+				    tep_event_handler_func func, void *context)
 {
 	struct event_format *event;
 	struct event_handler *handle;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index b1e4d37bedd8..b4b698c3833e 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -101,16 +101,16 @@ extern int trace_seq_do_printf(struct trace_seq *s);
 struct tep_handle;
 struct event_format;
 
-typedef int (*pevent_event_handler_func)(struct trace_seq *s,
-					 struct tep_record *record,
-					 struct event_format *event,
-					 void *context);
+typedef int (*tep_event_handler_func)(struct trace_seq *s,
+				      struct tep_record *record,
+				      struct event_format *event,
+				      void *context);
 
-typedef int (*pevent_plugin_load_func)(struct tep_handle *pevent);
-typedef int (*pevent_plugin_unload_func)(struct tep_handle *pevent);
+typedef int (*tep_plugin_load_func)(struct tep_handle *pevent);
+typedef int (*tep_plugin_unload_func)(struct tep_handle *pevent);
 
-struct pevent_plugin_option {
-	struct pevent_plugin_option	*next;
+struct tep_plugin_option {
+	struct tep_plugin_option	*next;
 	void				*handle;
 	char				*file;
 	char				*name;
@@ -124,20 +124,20 @@ struct pevent_plugin_option {
 /*
  * Plugin hooks that can be called:
  *
- * PEVENT_PLUGIN_LOADER:  (required)
+ * TEP_PLUGIN_LOADER:  (required)
  *   The function name to initialized the plugin.
  *
- *   int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+ *   int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
  *
- * PEVENT_PLUGIN_UNLOADER:  (optional)
+ * TEP_PLUGIN_UNLOADER:  (optional)
  *   The function called just before unloading
  *
- *   int PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+ *   int TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
  *
- * PEVENT_PLUGIN_OPTIONS:  (optional)
+ * TEP_PLUGIN_OPTIONS:  (optional)
  *   Plugin options that can be set before loading
  *
- *   struct pevent_plugin_option PEVENT_PLUGIN_OPTIONS[] = {
+ *   struct tep_plugin_option TEP_PLUGIN_OPTIONS[] = {
  *	{
  *		.name = "option-name",
  *		.plugin_alias = "override-file-name", (optional)
@@ -158,19 +158,19 @@ struct pevent_plugin_option {
  *   .set will be processed. If .value is defined, then it is considered
  *   a string option and .set will be ignored.
  *
- * PEVENT_PLUGIN_ALIAS: (optional)
+ * TEP_PLUGIN_ALIAS: (optional)
  *   The name to use for finding options (uses filename if not defined)
  */
-#define PEVENT_PLUGIN_LOADER pevent_plugin_loader
-#define PEVENT_PLUGIN_UNLOADER pevent_plugin_unloader
-#define PEVENT_PLUGIN_OPTIONS pevent_plugin_options
-#define PEVENT_PLUGIN_ALIAS pevent_plugin_alias
+#define TEP_PLUGIN_LOADER tep_plugin_loader
+#define TEP_PLUGIN_UNLOADER tep_plugin_unloader
+#define TEP_PLUGIN_OPTIONS tep_plugin_options
+#define TEP_PLUGIN_ALIAS tep_plugin_alias
 #define _MAKE_STR(x)	#x
 #define MAKE_STR(x)	_MAKE_STR(x)
-#define PEVENT_PLUGIN_LOADER_NAME MAKE_STR(PEVENT_PLUGIN_LOADER)
-#define PEVENT_PLUGIN_UNLOADER_NAME MAKE_STR(PEVENT_PLUGIN_UNLOADER)
-#define PEVENT_PLUGIN_OPTIONS_NAME MAKE_STR(PEVENT_PLUGIN_OPTIONS)
-#define PEVENT_PLUGIN_ALIAS_NAME MAKE_STR(PEVENT_PLUGIN_ALIAS)
+#define TEP_PLUGIN_LOADER_NAME MAKE_STR(TEP_PLUGIN_LOADER)
+#define TEP_PLUGIN_UNLOADER_NAME MAKE_STR(TEP_PLUGIN_UNLOADER)
+#define TEP_PLUGIN_OPTIONS_NAME MAKE_STR(TEP_PLUGIN_OPTIONS)
+#define TEP_PLUGIN_ALIAS_NAME MAKE_STR(TEP_PLUGIN_ALIAS)
 
 enum format_flags {
 	FIELD_IS_ARRAY		= 1,
@@ -327,7 +327,7 @@ struct event_format {
 	struct format		format;
 	struct print_fmt	print_fmt;
 	char			*system;
-	pevent_event_handler_func handler;
+	tep_event_handler_func	handler;
 	void			*context;
 };
 
@@ -441,8 +441,8 @@ void traceevent_unload_plugins(struct plugin_list *plugin_list,
 char **traceevent_plugin_list_options(void);
 void traceevent_plugin_free_options_list(char **list);
 int traceevent_plugin_add_options(const char *name,
-				  struct pevent_plugin_option *options);
-void traceevent_plugin_remove_options(struct pevent_plugin_option *options);
+				  struct tep_plugin_option *options);
+void traceevent_plugin_remove_options(struct tep_plugin_option *options);
 void traceevent_print_plugins(struct trace_seq *s,
 			      const char *prefix, const char *suffix,
 			      const struct plugin_list *list);
@@ -675,10 +675,10 @@ int pevent_print_func_field(struct trace_seq *s, const char *fmt,
 
 int pevent_register_event_handler(struct tep_handle *pevent, int id,
 				  const char *sys_name, const char *event_name,
-				  pevent_event_handler_func func, void *context);
+				  tep_event_handler_func func, void *context);
 int pevent_unregister_event_handler(struct tep_handle *pevent, int id,
 				    const char *sys_name, const char *event_name,
-				    pevent_event_handler_func func, void *context);
+				    tep_event_handler_func func, void *context);
 int pevent_register_print_function(struct tep_handle *pevent,
 				   pevent_func_handler func,
 				   enum pevent_func_arg_type ret_type,
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index 62b011ae18c1..8c91c8f0abd9 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -34,7 +34,7 @@
 
 static struct registered_plugin_options {
 	struct registered_plugin_options	*next;
-	struct pevent_plugin_option		*options;
+	struct tep_plugin_option		*options;
 } *registered_options;
 
 static struct trace_plugin_options {
@@ -58,7 +58,7 @@ static void lower_case(char *str)
 		*str = tolower(*str);
 }
 
-static int update_option_value(struct pevent_plugin_option *op, const char *val)
+static int update_option_value(struct tep_plugin_option *op, const char *val)
 {
 	char *op_val;
 
@@ -111,7 +111,7 @@ static int update_option_value(struct pevent_plugin_option *op, const char *val)
 char **traceevent_plugin_list_options(void)
 {
 	struct registered_plugin_options *reg;
-	struct pevent_plugin_option *op;
+	struct tep_plugin_option *op;
 	char **list = NULL;
 	char *name;
 	int count = 0;
@@ -163,7 +163,7 @@ void traceevent_plugin_free_options_list(char **list)
 }
 
 static int
-update_option(const char *file, struct pevent_plugin_option *option)
+update_option(const char *file, struct tep_plugin_option *option)
 {
 	struct trace_plugin_options *op;
 	char *plugin;
@@ -222,7 +222,7 @@ update_option(const char *file, struct pevent_plugin_option *option)
  * Sets the options with the values that have been added by user.
  */
 int traceevent_plugin_add_options(const char *name,
-				  struct pevent_plugin_option *options)
+				  struct tep_plugin_option *options)
 {
 	struct registered_plugin_options *reg;
 
@@ -244,7 +244,7 @@ int traceevent_plugin_add_options(const char *name,
  * traceevent_plugin_remove_options - remove plugin options that were registered
  * @options: Options to removed that were registered with traceevent_plugin_add_options
  */
-void traceevent_plugin_remove_options(struct pevent_plugin_option *options)
+void traceevent_plugin_remove_options(struct tep_plugin_option *options)
 {
 	struct registered_plugin_options **last;
 	struct registered_plugin_options *reg;
@@ -285,7 +285,7 @@ load_plugin(struct tep_handle *pevent, const char *path,
 	    const char *file, void *data)
 {
 	struct plugin_list **plugin_list = data;
-	pevent_plugin_load_func func;
+	tep_plugin_load_func func;
 	struct plugin_list *list;
 	const char *alias;
 	char *plugin;
@@ -305,14 +305,14 @@ load_plugin(struct tep_handle *pevent, const char *path,
 		goto out_free;
 	}
 
-	alias = dlsym(handle, PEVENT_PLUGIN_ALIAS_NAME);
+	alias = dlsym(handle, TEP_PLUGIN_ALIAS_NAME);
 	if (!alias)
 		alias = file;
 
-	func = dlsym(handle, PEVENT_PLUGIN_LOADER_NAME);
+	func = dlsym(handle, TEP_PLUGIN_LOADER_NAME);
 	if (!func) {
 		warning("could not find func '%s' in plugin '%s'\n%s\n",
-			PEVENT_PLUGIN_LOADER_NAME, plugin, dlerror());
+			TEP_PLUGIN_LOADER_NAME, plugin, dlerror());
 		goto out_free;
 	}
 
@@ -442,13 +442,13 @@ traceevent_load_plugins(struct tep_handle *pevent)
 void
 traceevent_unload_plugins(struct plugin_list *plugin_list, struct tep_handle *pevent)
 {
-	pevent_plugin_unload_func func;
+	tep_plugin_unload_func func;
 	struct plugin_list *list;
 
 	while (plugin_list) {
 		list = plugin_list;
 		plugin_list = list->next;
-		func = dlsym(list->handle, PEVENT_PLUGIN_UNLOADER_NAME);
+		func = dlsym(list->handle, TEP_PLUGIN_UNLOADER_NAME);
 		if (func)
 			func(pevent);
 		dlclose(list->handle);
diff --git a/tools/lib/traceevent/plugin_cfg80211.c b/tools/lib/traceevent/plugin_cfg80211.c
index 959d94f1d7f5..c189bbc9fa18 100644
--- a/tools/lib/traceevent/plugin_cfg80211.c
+++ b/tools/lib/traceevent/plugin_cfg80211.c
@@ -25,7 +25,7 @@ process___le16_to_cpup(struct trace_seq *s, unsigned long long *args)
 	return val ? (long long) le16toh(*val) : 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process___le16_to_cpup,
@@ -36,7 +36,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_print_function(pevent, process___le16_to_cpup,
 					 "__le16_to_cpup");
diff --git a/tools/lib/traceevent/plugin_function.c b/tools/lib/traceevent/plugin_function.c
index 86b5bb9bf22c..342be570ee8c 100644
--- a/tools/lib/traceevent/plugin_function.c
+++ b/tools/lib/traceevent/plugin_function.c
@@ -33,7 +33,7 @@ static int cpus = -1;
 
 #define STK_BLK 10
 
-struct pevent_plugin_option plugin_options[] =
+struct tep_plugin_option plugin_options[] =
 {
 	{
 		.name = "parent",
@@ -53,8 +53,8 @@ struct pevent_plugin_option plugin_options[] =
 	}
 };
 
-static struct pevent_plugin_option *ftrace_parent = &plugin_options[0];
-static struct pevent_plugin_option *ftrace_indent = &plugin_options[1];
+static struct tep_plugin_option *ftrace_parent = &plugin_options[0];
+static struct tep_plugin_option *ftrace_indent = &plugin_options[1];
 
 static void add_child(struct func_stack *stack, const char *child, int pos)
 {
@@ -163,7 +163,7 @@ static int function_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_event_handler(pevent, -1, "ftrace", "function",
 				      function_handler, NULL);
@@ -173,7 +173,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	int i, x;
 
diff --git a/tools/lib/traceevent/plugin_hrtimer.c b/tools/lib/traceevent/plugin_hrtimer.c
index 695e8e1b90e6..5704d56c6f6f 100644
--- a/tools/lib/traceevent/plugin_hrtimer.c
+++ b/tools/lib/traceevent/plugin_hrtimer.c
@@ -66,7 +66,7 @@ static int timer_start_handler(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_event_handler(pevent, -1,
 				      "timer", "hrtimer_expire_entry",
@@ -77,7 +77,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_event_handler(pevent, -1,
 					"timer", "hrtimer_expire_entry",
diff --git a/tools/lib/traceevent/plugin_jbd2.c b/tools/lib/traceevent/plugin_jbd2.c
index 3909db7043c9..9b88aebb48a9 100644
--- a/tools/lib/traceevent/plugin_jbd2.c
+++ b/tools/lib/traceevent/plugin_jbd2.c
@@ -47,7 +47,7 @@ process_jiffies_to_msecs(struct trace_seq *s, unsigned long long *args)
 	return jiffies;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process_jbd2_dev_to_name,
@@ -65,7 +65,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_print_function(pevent, process_jbd2_dev_to_name,
 					 "jbd2_dev_to_name");
diff --git a/tools/lib/traceevent/plugin_kmem.c b/tools/lib/traceevent/plugin_kmem.c
index 46e8e959539e..0a56562d0645 100644
--- a/tools/lib/traceevent/plugin_kmem.c
+++ b/tools/lib/traceevent/plugin_kmem.c
@@ -48,7 +48,7 @@ static int call_site_handler(struct trace_seq *s, struct tep_record *record,
 	return 1;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_event_handler(pevent, -1, "kmem", "kfree",
 				      call_site_handler, NULL);
@@ -71,7 +71,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_event_handler(pevent, -1, "kmem", "kfree",
 					call_site_handler, NULL);
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 63420e3a340c..ab5439e0ad87 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -444,7 +444,7 @@ process_is_writable_pte(struct trace_seq *s, unsigned long long *args)
 	return pte & PT_WRITABLE_MASK;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	init_disassembler();
 
@@ -486,7 +486,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_event_handler(pevent, -1, "kvm", "kvm_exit",
 					kvm_exit_handler, NULL);
diff --git a/tools/lib/traceevent/plugin_mac80211.c b/tools/lib/traceevent/plugin_mac80211.c
index 83d002753251..61eea3543cf1 100644
--- a/tools/lib/traceevent/plugin_mac80211.c
+++ b/tools/lib/traceevent/plugin_mac80211.c
@@ -86,7 +86,7 @@ static int drv_bss_info_changed(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_event_handler(pevent, -1, "mac80211",
 				      "drv_bss_info_changed",
@@ -94,7 +94,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_event_handler(pevent, -1, "mac80211",
 					"drv_bss_info_changed",
diff --git a/tools/lib/traceevent/plugin_sched_switch.c b/tools/lib/traceevent/plugin_sched_switch.c
index b72a52d2fd1d..24dc2bca8e67 100644
--- a/tools/lib/traceevent/plugin_sched_switch.c
+++ b/tools/lib/traceevent/plugin_sched_switch.c
@@ -134,7 +134,7 @@ static int sched_switch_handler(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_event_handler(pevent, -1, "sched", "sched_switch",
 				      sched_switch_handler, NULL);
@@ -147,7 +147,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_event_handler(pevent, -1, "sched", "sched_switch",
 					sched_switch_handler, NULL);
diff --git a/tools/lib/traceevent/plugin_scsi.c b/tools/lib/traceevent/plugin_scsi.c
index e430a49e4995..bb9aea6fb000 100644
--- a/tools/lib/traceevent/plugin_scsi.c
+++ b/tools/lib/traceevent/plugin_scsi.c
@@ -413,7 +413,7 @@ unsigned long long process_scsi_trace_parse_cdb(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process_scsi_trace_parse_cdb,
@@ -426,7 +426,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_print_function(pevent, process_scsi_trace_parse_cdb,
 					 "scsi_trace_parse_cdb");
diff --git a/tools/lib/traceevent/plugin_xen.c b/tools/lib/traceevent/plugin_xen.c
index 11dbddde2e6a..1973dd8abbfd 100644
--- a/tools/lib/traceevent/plugin_xen.c
+++ b/tools/lib/traceevent/plugin_xen.c
@@ -119,7 +119,7 @@ unsigned long long process_xen_hypercall_name(struct trace_seq *s,
 	return 0;
 }
 
-int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
+int TEP_PLUGIN_LOADER(struct tep_handle *pevent)
 {
 	pevent_register_print_function(pevent,
 				       process_xen_hypercall_name,
@@ -130,7 +130,7 @@ int PEVENT_PLUGIN_LOADER(struct tep_handle *pevent)
 	return 0;
 }
 
-void PEVENT_PLUGIN_UNLOADER(struct tep_handle *pevent)
+void TEP_PLUGIN_UNLOADER(struct tep_handle *pevent)
 {
 	pevent_unregister_print_function(pevent, process_xen_hypercall_name,
 					 "xen_hypercall_name");

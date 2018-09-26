Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F050ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75DF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75DF204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIZPEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:04:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:04:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8qCfn3772455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:52:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8qCCw3772452;
        Wed, 26 Sep 2018 01:52:12 -0700
Date:   Wed, 26 Sep 2018 01:52:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Tzvetomir Stoyanov (VMware)" <tipbot@zytor.com>
Message-ID: <tip-785be0c98d24aaf417588322c74999520ea790a4@git.kernel.org>
Cc:     tz.stoyanov@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, namhyung@kernel.org, acme@redhat.com,
        rostedt@goodmis.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, jolsa@redhat.com, tglx@linutronix.de,
          tz.stoyanov@gmail.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          akpm@linux-foundation.org, acme@redhat.com, namhyung@kernel.org
In-Reply-To: <20180919185724.586889128@goodmis.org>
References: <20180919185724.586889128@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Rename struct plugin_list to
 struct tep_plugin_list
Git-Commit-ID: 785be0c98d24aaf417588322c74999520ea790a4
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

Commit-ID:  785be0c98d24aaf417588322c74999520ea790a4
Gitweb:     https://git.kernel.org/tip/785be0c98d24aaf417588322c74999520ea790a4
Author:     Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
AuthorDate: Wed, 19 Sep 2018 14:56:56 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 17:29:26 -0300

tools lib traceevent: Rename struct plugin_list to struct tep_plugin_list

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_". This renames struct plugin_list
to struct tep_plugin_list

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: linux-trace-devel@vger.kernel.org
Link: http://lkml.kernel.org/r/20180919185724.586889128@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.h  |  8 ++++----
 tools/lib/traceevent/event-plugin.c | 18 +++++++++---------
 tools/perf/util/trace-event.h       |  4 ++--
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 1abf15882460..2a7b0a857f39 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -389,12 +389,12 @@ enum tep_errno {
 };
 #undef _PE
 
-struct plugin_list;
+struct tep_plugin_list;
 
 #define INVALID_PLUGIN_LIST_OPTION	((char **)((unsigned long)-1))
 
-struct plugin_list *tep_load_plugins(struct tep_handle *pevent);
-void tep_unload_plugins(struct plugin_list *plugin_list,
+struct tep_plugin_list *tep_load_plugins(struct tep_handle *pevent);
+void tep_unload_plugins(struct tep_plugin_list *plugin_list,
 			struct tep_handle *pevent);
 char **tep_plugin_list_options(void);
 void tep_plugin_free_options_list(char **list);
@@ -403,7 +403,7 @@ int tep_plugin_add_options(const char *name,
 void tep_plugin_remove_options(struct tep_plugin_option *options);
 void tep_print_plugins(struct trace_seq *s,
 			const char *prefix, const char *suffix,
-			const struct plugin_list *list);
+			const struct tep_plugin_list *list);
 
 struct cmdline;
 struct cmdline_list;
diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index ec16a103c0cc..46eb64eb0c2e 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -31,8 +31,8 @@ static struct trace_plugin_options {
 	char				*value;
 } *trace_plugin_options;
 
-struct plugin_list {
-	struct plugin_list	*next;
+struct tep_plugin_list {
+	struct tep_plugin_list	*next;
 	char			*name;
 	void			*handle;
 };
@@ -259,7 +259,7 @@ void tep_plugin_remove_options(struct tep_plugin_option *options)
  */
 void tep_print_plugins(struct trace_seq *s,
 		       const char *prefix, const char *suffix,
-		       const struct plugin_list *list)
+		       const struct tep_plugin_list *list)
 {
 	while (list) {
 		trace_seq_printf(s, "%s%s%s", prefix, list->name, suffix);
@@ -271,9 +271,9 @@ static void
 load_plugin(struct tep_handle *pevent, const char *path,
 	    const char *file, void *data)
 {
-	struct plugin_list **plugin_list = data;
+	struct tep_plugin_list **plugin_list = data;
 	tep_plugin_load_func func;
-	struct plugin_list *list;
+	struct tep_plugin_list *list;
 	const char *alias;
 	char *plugin;
 	void *handle;
@@ -417,20 +417,20 @@ load_plugins(struct tep_handle *pevent, const char *suffix,
 	free(path);
 }
 
-struct plugin_list*
+struct tep_plugin_list*
 tep_load_plugins(struct tep_handle *pevent)
 {
-	struct plugin_list *list = NULL;
+	struct tep_plugin_list *list = NULL;
 
 	load_plugins(pevent, ".so", load_plugin, &list);
 	return list;
 }
 
 void
-tep_unload_plugins(struct plugin_list *plugin_list, struct tep_handle *pevent)
+tep_unload_plugins(struct tep_plugin_list *plugin_list, struct tep_handle *pevent)
 {
 	tep_plugin_unload_func func;
-	struct plugin_list *list;
+	struct tep_plugin_list *list;
 
 	while (plugin_list) {
 		list = plugin_list;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 2da6eff0caaf..f024d73bfc40 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -11,11 +11,11 @@ struct perf_sample;
 union perf_event;
 struct perf_tool;
 struct thread;
-struct plugin_list;
+struct tep_plugin_list;
 
 struct trace_event {
 	struct tep_handle	*pevent;
-	struct plugin_list	*plugin_list;
+	struct tep_plugin_list	*plugin_list;
 };
 
 int trace_event__init(struct trace_event *t);

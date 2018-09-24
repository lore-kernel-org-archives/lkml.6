Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC857ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD96214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHyoWg/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD96214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeIXVH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbeIXVH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:26 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DCA12086B;
        Mon, 24 Sep 2018 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801490;
        bh=gVg2vQ+4fqryCpxD+bRvkeXPS37pN2V8kx67hbSsEEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHyoWg/ukWoE9OSd90aVE0s8MrLEmOMQoL6oIwxPKnKaPVnKciQAkbP9mFGStasdW
         Pq0ySds7xtMf5u+8jpdajbj0Fg1EvEz3xNBFDfiZ+s76tX+VsE/BXVLQSWJvuTce9a
         CoOBawT3vL2ZJE8KMUou7FtdTekVbhSiL7ff0GUY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/27] tools lib traceevent: Rename struct plugin_list to struct tep_plugin_list
Date:   Mon, 24 Sep 2018 12:02:33 -0300
Message-Id: <20180924150242.14235-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

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
-- 
2.14.4


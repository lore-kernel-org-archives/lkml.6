Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B77C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999A820C09
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky39ssYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999A820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbeHOSAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729293AbeHOSAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:00:11 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F90E20C0E;
        Wed, 15 Aug 2018 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345658;
        bh=LjJtxrH8QJYBhgjzzIW/795wGDoLdaBTUnG1C0NDBlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ky39ssYUeg22Omsd3PaNJwt8elbCIc9hI8BPe7fZILIg7Ux78PDjyRpQztSBNOxKG
         Vl0bvBaw5DUninOM12Dr8Zmvyw37mZzy71xSEZf8ES/ZfyBwmRdzpzjAqm80Pfg6+Q
         BEoUzPEH+ug7UKSKFCRt/YMHWYZHumpNzzTKFN/0=
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
Subject: [PATCH 12/35] tools lib traceevent, perf tools: Rename traceevent_* APIs
Date:   Wed, 15 Aug 2018 12:05:48 -0300
Message-Id: <20180815150611.32080-13-acme@kernel.org>
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
 
-- 
2.14.4


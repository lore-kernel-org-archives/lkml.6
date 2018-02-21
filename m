Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225IKUQaV6whHW3LH5Kspqyg207Isll7MpzjTNWGuz5gElcZTAUMvREDVkqcMrbbavp3313/
ARC-Seal: i=1; a=rsa-sha256; t=1519225037; cv=none;
        d=google.com; s=arc-20160816;
        b=pOy0aJxnh/nzAx0ff2Hzpzw9QRsIY8IomzudQ5LFN4TsSuEeK0YSVt2jYIHZciDbod
         G6HR34LDwhW/J3p4CtN0szCUEO1SS6/O/ID02HmAYeyZKbyWA6ZBDecImsct/NjfJmW4
         qQtZr1TPakjNDiZliEeds4uSwGQMZbkBTYzlB3jKMhZRn6+CqK/G9sfc0bngxQ59flbS
         RuYKgHxbhxImYrfKCHMvstMhdXY3wPL7inFyvP7IoFaxaR5kNk+Hv5CxleYnBU9VlAFT
         wnxq692shChImeL8ibHqnrUPn+nZuCzduXctH2b9cRANVbee/zSZkkjbGBLhnH9mItG0
         qsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=o+FV/ePwJTCOTYWK1Z4jTlUpEzuyw/FRbwekJySeMck=;
        b=N/AovQPqGLsDG43oYBuQq1aIL7e2V0FoJVzBCAUPX3hTDRt9idwLoAeOLV9JQr1MW3
         HRBrePf2gm6E2AUpL9mPkO9JLHxK4NH65t4TwQMvUmGnayTB42VK0xtoJBFJijjk2sgm
         5lIZgWYjWjxNL7s1oYAZUHN65X3mlakn3u/KVOYJriUYp8p6z36BEbKe71f7hifSZuB+
         GdS5oTP8bDSwyqcSMv6lzE/BeeXQR3GXK5k8mAcwXMZiEMw9QGmkfCBbkSl9SBE1Cosy
         m0wwdOemm5GtkFbmnl4bhNs3TQ9ulFB0xyv2u38fMLrT+nxei/D1JqN0dO3kQjbvnCOe
         zcAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938043AbeBUO5E (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937392AbeBUO5C (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:57:02 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C7C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v2 05/17] tracing: probeevent: Cleanup argument field definition
Date: Wed, 21 Feb 2018 23:56:38 +0900
Message-Id: <151922499866.6217.4568743070447952036.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151922484560.6217.1143686155616343906.stgit@devbox>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022912966847744?=
X-GMAIL-MSGID: =?utf-8?q?1593022912966847744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Cleanup event argument definition code in one place for
maintenancability.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   32 ++++----------------------------
 kernel/trace/trace_probe.c  |   21 +++++++++++++++++++++
 kernel/trace/trace_probe.h  |    2 ++
 kernel/trace/trace_uprobe.c |   15 ++-------------
 4 files changed, 29 insertions(+), 41 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59882393fc1b..a96328dfc012 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1146,49 +1146,25 @@ print_kretprobe_event(struct trace_iterator *iter, int flags,
 
 static int kprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i;
+	int ret;
 	struct kprobe_trace_entry_head field;
 	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
 
 	DEFINE_FIELD(unsigned long, ip, FIELD_STRING_IP, 0);
-	/* Set argument names as fields */
-	for (i = 0; i < tk->tp.nr_args; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
 
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
-					 sizeof(field) + parg->offset,
-					 parg->type->size,
-					 parg->type->is_signed,
-					 FILTER_OTHER);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
 }
 
 static int kretprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i;
+	int ret;
 	struct kretprobe_trace_entry_head field;
 	struct trace_kprobe *tk = (struct trace_kprobe *)event_call->data;
 
 	DEFINE_FIELD(unsigned long, func, FIELD_STRING_FUNC, 0);
 	DEFINE_FIELD(unsigned long, ret_ip, FIELD_STRING_RETIP, 0);
-	/* Set argument names as fields */
-	for (i = 0; i < tk->tp.nr_args; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
 
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name,
-					 sizeof(field) + parg->offset,
-					 parg->type->size,
-					 parg->type->is_signed,
-					 FILTER_OTHER);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, sizeof(field), &tk->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 59b0f76fb4a5..4f5447cec44a 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -682,3 +682,24 @@ int set_print_fmt(struct trace_probe *tp, bool is_return)
 
 	return 0;
 }
+
+int traceprobe_define_arg_fields(struct trace_event_call *event_call,
+				 size_t offset, struct trace_probe *tp)
+{
+	int ret, i;
+
+	/* Set argument names as fields */
+	for (i = 0; i < tp->nr_args; i++) {
+		struct probe_arg *parg = &tp->args[i];
+
+		ret = trace_define_field(event_call, parg->type->fmttype,
+					 parg->name,
+					 offset + parg->offset,
+					 parg->type->size,
+					 parg->type->is_signed,
+					 FILTER_OTHER);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0c8e66f9c855..de928052926b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -440,3 +440,5 @@ extern struct trace_event_call *
 create_local_trace_uprobe(char *name, unsigned long offs, bool is_return);
 extern void destroy_local_trace_uprobe(struct trace_event_call *event_call);
 #endif
+extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
+					size_t offset, struct trace_probe *tp);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 4c006a693663..887da2bb63aa 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -982,7 +982,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 
 static int uprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret, i, size;
+	int ret, size;
 	struct uprobe_trace_entry_head field;
 	struct trace_uprobe *tu = event_call->data;
 
@@ -994,19 +994,8 @@ static int uprobe_event_define_fields(struct trace_event_call *event_call)
 		DEFINE_FIELD(unsigned long, vaddr[0], FIELD_STRING_IP, 0);
 		size = SIZEOF_TRACE_ENTRY(false);
 	}
-	/* Set argument names as fields */
-	for (i = 0; i < tu->tp.nr_args; i++) {
-		struct probe_arg *parg = &tu->tp.args[i];
-
-		ret = trace_define_field(event_call, parg->type->fmttype,
-					 parg->name, size + parg->offset,
-					 parg->type->size, parg->type->is_signed,
-					 FILTER_OTHER);
 
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return traceprobe_define_arg_fields(event_call, size, &tu->tp);
 }
 
 #ifdef CONFIG_PERF_EVENTS


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225zfjdnbucJ/hVd5hj1C/KyYNlN9eV1qK4hSYBIRoCpyKjbt0FA7ElbV728rkGV6P3knsN7
ARC-Seal: i=1; a=rsa-sha256; t=1519788313; cv=none;
        d=google.com; s=arc-20160816;
        b=Oto2iTtd3NAv7PkJ/tSvdE5eGnUqeaf30kQiPz3+55n0Mc0jALSqSoIE+CGT87RmAp
         izvqTXzWM5C1XlDkW5lbb9YwrX4ec+3H5gkht/83ruSAIDMbBXrOAmsrj77gJyGcPCA3
         xNngwoRp6Tvj4hLvVPOFDW7+G4CR1Vx7Cgvq8E+mzGsSbCAVEq5+GrR56OrIjWTUTUgx
         viWngjT7/jV30r+kh0w2YRL/y9rc/5hudhChhxTwAuLcP/GQoRErtTGBvxiCZFwLvt8q
         rwjAo4m/0NZHSACc0gk21dXt/lgEO+ctNpuLJDBKsYJJlNJ//gOlB+nnTbZCr1Fm83W2
         sHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=NYyi6Qs58Cg1OVxISYiSemVYwzxXgldQ766v8FCwgjs=;
        b=ZrSaX6EFeDjIn0vP1iA0GB3mMVY93aPmihRF5hpD1Vn28Tgi6UN0FBmaDj71XVXOYp
         0oDQk7EDXRBhjIqvX4vcrB6Vdg2sViK+cZvDM4ahg2l8R4pqJ6iaWBc2x5tLP5JMXCRs
         xVa+PAIMiP5B7UfjmMpgH8NayhMHHeNQiQ2WB8YssVEOCKkZtEWu58ndXb1i9YgL4ObU
         Xf502SdEcVHHjcdzZGrfsKziw935e1AqH7geEo/9rT/dHlzEL9a1VBprIAMnxjm7c7z9
         8o5qv+vgYUuDMB/+XxGdD82YP/djo+IhKEkc7V0ELS8oJBWubMzLLDKbiZPtSTLQmy6T
         UHSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeB1DZN (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:56444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbeB1DZM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:25:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1392168D
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
Subject: [PATCH v4 11/19] tracing: probeevent: Append traceprobe_ for exported function
Date: Wed, 28 Feb 2018 12:24:48 +0900
Message-Id: <151978828831.2577.14306538483944889390.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151978796240.2577.6531711990653677529.stgit@devbox>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613551016605900?=
X-GMAIL-MSGID: =?utf-8?q?1593613551016605900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Append traceprobe_ for exported function set_print_fmt() as
same as other functions.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    4 ++--
 kernel/trace/trace_probe.c  |    2 +-
 kernel/trace/trace_probe.h  |    2 +-
 kernel/trace/trace_uprobe.c |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 927299ff191c..7d48ae5f0617 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1305,7 +1305,7 @@ static int register_kprobe_event(struct trace_kprobe *tk)
 
 	init_trace_event_call(tk, call);
 
-	if (set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0)
+	if (traceprobe_set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0)
 		return -ENOMEM;
 	ret = register_trace_event(&call->event);
 	if (!ret) {
@@ -1362,7 +1362,7 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
 
 	init_trace_event_call(tk, &tk->tp.call);
 
-	if (set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0) {
+	if (traceprobe_set_print_fmt(&tk->tp, trace_kprobe_is_return(tk)) < 0) {
 		ret = -ENOMEM;
 		goto error;
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index ed3766fb290d..fff3ccfcdbb6 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -502,7 +502,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 	return pos;
 }
 
-int set_print_fmt(struct trace_probe *tp, bool is_return)
+int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return)
 {
 	int len;
 	char *print_fmt;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index d1b8bd74bf56..3bc43c1ce628 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -266,7 +266,7 @@ extern void traceprobe_free_probe_arg(struct probe_arg *arg);
 
 extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
 
-extern int set_print_fmt(struct trace_probe *tp, bool is_return);
+extern int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return);
 
 #ifdef CONFIG_PERF_EVENTS
 extern struct trace_event_call *
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index de4f91bb313a..fafd48310823 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1314,7 +1314,7 @@ static int register_uprobe_event(struct trace_uprobe *tu)
 
 	init_trace_event_call(tu, call);
 
-	if (set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0)
+	if (traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0)
 		return -ENOMEM;
 
 	ret = register_trace_event(&call->event);
@@ -1388,7 +1388,7 @@ create_local_trace_uprobe(char *name, unsigned long offs, bool is_return)
 	tu->filename = kstrdup(name, GFP_KERNEL);
 	init_trace_event_call(tu, &tu->tp.call);
 
-	if (set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0) {
+	if (traceprobe_set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0) {
 		ret = -ENOMEM;
 		goto error;
 	}


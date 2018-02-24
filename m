Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226zcHlXCnejGzsqjfC6PZotpQ6fIh9MdqzmOMn+k9FTO9qHunWWgiqfp3SJWZwyE7e9O3gj
ARC-Seal: i=1; a=rsa-sha256; t=1519450443; cv=none;
        d=google.com; s=arc-20160816;
        b=j7oH+9LsCsWd+6Oc9e9RtLwZPAzmc+Ja+33xT5gigL6NJwlVXsjiNm9Bk9u3gMfx1+
         q3Vui5vXKXbB1rWjKfASeK7jNApxQw8EWCLy0VWS+X0HfKa1sQoYfxAjzhwkWbdZxgvg
         HJDBg6mQBFtvhJZGLp88UUI0u3eM6dfrrJ6D77G6Ybawwyq2N92YMFHWTPp0PinuNmUU
         Bgml3dImF0P6SHa2HLYr3Ktoi/jEsZSOyVGAcGssvrFDaP6XsM4Iq5xvwUhE2PwjGLAS
         n8FOm9fwx2Ck115RC1qwS/6KBdSrOtMhGumOG8WYKSNSIdJ+Mg1ApPJ4Xgjd5HjlAnMw
         Sgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=dSaO8zrWiY1gy9kbOVcISuy3mzHfzwqqt0iksiW1ru8=;
        b=hGZXEXh2XNRxOOE3EXGkGrJDn+B/jjXUfWtR7xkqv24drTGYBSvWdanjoZLxRE12KB
         PBYD33sjZaOvf7swnQtWemAt2dgmUMivdX+aWdpVUbLOoWIwgpbvIl/fRMvfozc2394H
         W7CGKKl2m3YDStcuy7U5Xq2dXcV3mmX+KLrFGtCSFEiTxKfgzdcq8E82J8/rEwI4611Q
         3U7izcZhGhlW03PBOnQQo/fjdqgwQsmVWJqs6TfafFVXVOklWgJO7323K2N/YygcEwxo
         kTOY76cBhcgzMvaefyuqjVZM872DhRHutw8yyPZHQX1q/pFmuVtXGCUnStrVsGk3lCnx
         PJJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbeBXFdu (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:33:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeBXFdj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:33:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8B21741
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
Subject: [PATCH v3 10/18] tracing: probeevent: Append traceprobe_ for exported function
Date: Sat, 24 Feb 2018 14:33:15 +0900
Message-Id: <151945039562.27508.7337747321467125588.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <151945010287.27508.6226184958678620828.stgit@devbox>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593259268556952185?=
X-GMAIL-MSGID: =?utf-8?q?1593259268556952185?=
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
index 02d19eff49bb..35f81e1eb70e 100644
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
index 9ffc07c7c949..9c1b55e0ccfd 100644
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


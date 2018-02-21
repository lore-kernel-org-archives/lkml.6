Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x227dZmHDjuHVkVRh3EH/S7pAlKFjf52RHWWHyPL50+ptsIZm3ehAZVokfiLzZnlieV4E8+zQ
ARC-Seal: i=1; a=rsa-sha256; t=1519225153; cv=none;
        d=google.com; s=arc-20160816;
        b=qNRoA/x22tZQqVY45mWTWuu3C+so5zgv2et9UUlC8/cvwkQlq2F2IAlKX/pVPxRYb1
         d8Kdy+vepCVlDCcP06TRlAx/wbZCLYzihjuyDieSWo/jbYkGSUGtejsu3GulB56FMqhw
         ORkeRmkUhWHgZxC7gLPmWdSKyCc5Zf4SeAlfWwQNKaz46wKGq1bdhwlgzT/YtsjTatsb
         xUk2RXy2C+hf8FAs5f8CappYGZuoavC+ILugRNoZ5t8rAJjGzuPfMDQXYPlKhO+XLY39
         sclFgKCqzOy5K/ZeguQapKPafEapTcHvGzNj9fOmgjOOSqqkU3Hv8uKYYnXDGWzTUD64
         zaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=TY2s9KrVP/9sPYVewtdqeaafSPc5UxC2Al0lnDqE7bw=;
        b=tclNPwXHzxinCYYx+lj1jQs0V9EFexJXb5F1mY4qjPWstIVoxw4qPtRFrqTTd2N/gw
         fr+fVQxQC4yF3S6QqJmyCm+cZlX/py6DgLAVvEsG2ciaS7lq2KNAe5ilyM51ohSPjxkh
         5Lg/EZ+qxplbYqmiZVWXR1T1o90ZgJwdHMwMYV44h3y1ae+q1tkx6R+ZP0XWf7hiDzgM
         AOugz9iH84wxBB2cgy1yKRfkbpZm1xRkycFE32YhjW/ABmwpc93WuEed5ckB9ZA0gJP9
         8iSlHzDhX9wOHZB4t/hXbAAakb74V/ULsEQ7gvCi3am/htDoeDIADIZA7VbHV7pLZAeJ
         2PMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937062AbeBUO7A (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935439AbeBUO67 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:58:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B83D205F4
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
Subject: [PATCH v2 09/17] tracing: probeevent: Append traceprobe_ for exported function
Date: Wed, 21 Feb 2018 23:58:35 +0900
Message-Id: <151922511518.6217.2924410291515219270.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593023034916410919?=
X-GMAIL-MSGID: =?utf-8?q?1593023034916410919?=
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
index ee41d5700e25..ec20f0b56cfe 100644
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
index cd87490b3492..8d43f377143d 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -504,7 +504,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
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


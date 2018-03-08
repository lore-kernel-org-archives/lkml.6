Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELusetdRQuDkS5IHqjNJO7K4kOGPyv1qRfWY38DuWZfA8gzGZaIHfXjayOR01/hmlXAkQMcX
ARC-Seal: i=1; a=rsa-sha256; t=1520498845; cv=none;
        d=google.com; s=arc-20160816;
        b=KmojjjGk4DsM7GDpFZH9IP/DddeEkl3foFo2c/w7Ul4klTG74qIR1DUhXyjJ4uFjmD
         NV3PrLvq21TH26R8DEYBSk3eOAtJ5U8QLGb2Xi7TsCPYKuqJWqFE++MLutyvJun9fG0Q
         SesB0SW5I3O0GA6hEXULAh3TDhNVBKhupAQpAT5QTZsrfM4YBnxfEwcUU0Xxu7A4UXX+
         eeD9MCGx5AwwXbX1+qWAdOT4xfd7REIVcqeyW7NfX2VOWRb4fxOrvOv6MqjKA7LnBTVN
         MB+0HBKNz3xl0zqJTn82ZFhzH5d6V7j/xJr1RoZjMOJPkNaxcLnK0Yxr4v1YeI627JNN
         BbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=Qp4iggARqBTZprkNl9HfL5SYh57/ldbii8nPfgtUAyI=;
        b=NLF9N0kZYH24orfAwhUePUtMRG4046FClifyuTxfA/GoMO5IEeE07xtan4sJu82NJ6
         fKGzKT2nUUkF5VKC5EWAiGroURMx3rqavcoC3+sqJhpifpDLdtB51h8N3hmw3EeLApth
         xF1W+mYruoRNFLKPYvvQcbQ8QWURqDuGgi8mtmmBjoVJo4QJiQnliHHNLYST6W9Cnd+w
         qZg9SEFpGFBNC9M0O53YhJRGsjyYLZw6o6qMk3aZnAhF4i47U1AQSylpm4MlMtZcU9ee
         Tnx7Gl2xPvyvcuPGs+B2JbJBnH6GGiD6QCy1lVhtUkEDoRopadjzmd5lR0qrNB00P54h
         dqDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934887AbeCHIrY (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 03:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755223AbeCHIrX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 03:47:23 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1352172D
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
Subject: [PATCH v5 07/19] tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
Date: Thu,  8 Mar 2018 17:46:59 +0900
Message-Id: <152049881961.7289.7652284231051413170.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152049860385.7289.14079393589900496424.stgit@devbox>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358596864173154?=
X-GMAIL-MSGID: =?utf-8?q?1594358596864173154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unneeded NOKPROBE_SYMBOL from print functions since
the print functions are only used when printing out the
trace data, and not from kprobe handler.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 049e8531fdf8..51ca8f751332 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -43,8 +43,7 @@ int PRINT_TYPE_FUNC_NAME(tname)(struct trace_seq *s, void *data, void *ent)\
 	trace_seq_printf(s, fmt, *(type *)data);			\
 	return !trace_seq_has_overflowed(s);				\
 }									\
-const char PRINT_TYPE_FMT_NAME(tname)[] = fmt;				\
-NOKPROBE_SYMBOL(PRINT_TYPE_FUNC_NAME(tname));
+const char PRINT_TYPE_FMT_NAME(tname)[] = fmt;
 
 DEFINE_BASIC_PRINT_TYPE_FUNC(u8,  u8,  "%u")
 DEFINE_BASIC_PRINT_TYPE_FUNC(u16, u16, "%u")
@@ -71,7 +70,6 @@ int PRINT_TYPE_FUNC_NAME(string)(struct trace_seq *s, void *data, void *ent)
 				 (const char *)get_loc_data(data, ent));
 	return !trace_seq_has_overflowed(s);
 }
-NOKPROBE_SYMBOL(PRINT_TYPE_FUNC_NAME(string));
 
 const char PRINT_TYPE_FMT_NAME(string)[] = "\\\"%s\\\"";
 


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvJETpXCdJs99RNEI4UkVsD15pYTkx5QtSClP1LfOycg6HbSTsuM27cRopVZ2QQlhK9oucw
ARC-Seal: i=1; a=rsa-sha256; t=1521290634; cv=none;
        d=google.com; s=arc-20160816;
        b=ksTv8KX+HAeuPHM9RKl6Ui5PJeQoab8I3Th4fnXHmSo1kab5KHz7hmS1xa8L31CCRF
         5R/jZ5eHiw/YyRiZfe7U+O2IPOXAeejwdrl+PR+agLLjXC4N9Z0gPDWdDyhg4t6ozFem
         iLzD7RQUN47J4kf/fT61zGVa8n7s4E5cefaKWOoqjqJQKxBjvz/1ilDZWgF2AcB5PtH6
         BeCVdsUYqFrsju+Nq2eIQ5/6ojs25NjZwPvgj8WkfHNH31tNb5RIJe0ELj3RHShau63b
         TLnGjO3NFWC+xHqKxRdyQt6jzkrsdXasODn2Z34+VCV+bhYZb+QcIY1bro8ny4zBeXT4
         AeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=Qp4iggARqBTZprkNl9HfL5SYh57/ldbii8nPfgtUAyI=;
        b=p0wVwLA6Ld38P9KtAa04bFK7YBk1DnFEB9jLScuIqDkcsMKsas45RUCDxYOb7i4mdS
         Vv2qOZyVjHKXFpgC0YkVsFKt4wfoSCrQaJ5Xh0E/PBuOZbRt2tSRTdH+pJWFYPyj1Mv1
         16bn/lz62hzyolKh3uPR5spMO+NDyoqFtsBinkR5Q0wY6QFYG9npNQXKHlH3BruRiR4D
         8udJ3bFzzAyvsEInEy6y048zhXKRww1VlpI9gkHXfHkV1oWRY9lJZj2HmqwceRQSwmKY
         Aj1Zy6l7rWhqVAMoQLrYXnQcR4KKESXmUPGJ/sTP3uHg10Au9TcneqiyURMOmcaxfXiI
         lTKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeCQMnn (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 17 Mar 2018 08:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752787AbeCQMnd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Mar 2018 08:43:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D380121737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v6 07/21] tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
Date: Sat, 17 Mar 2018 21:42:44 +0900
Message-Id: <152129056480.31874.12788717040043254904.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152129024033.31874.15800253385376959274.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188848010346239?=
X-GMAIL-MSGID: =?utf-8?q?1595188848010346239?=
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
 


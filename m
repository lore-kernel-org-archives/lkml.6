Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226NfDqiJ/+DXhWaXTtVNA44JxuaWf4zxu8l1xMis3Raq8aQ97hui8b3BxjeCj1fT2elNkow
ARC-Seal: i=1; a=rsa-sha256; t=1519225064; cv=none;
        d=google.com; s=arc-20160816;
        b=DlGx5uR9+dON2UP9BAHivRiLKm27wHfHkeiZtpPO8ErSQxmFxAtohpwOsZ41gQKJ9s
         skruDPAByJ946IuzQs9SinVCKJIyWNaeOaiQU1c3Z4/OE/kooPSgfAUm87lT9dESZEJv
         zNeMTs0tefgoEOGDwe/d/ApHz38ZkXBHZPlyt+mx3IjbY1Jo8eNm/4dRqT6pbVm/RUn1
         WnTIAHs0Mx4mD/QOMRKqh1AykhFvhs0TLWo8e20qD3neXuIvftUpXWXAWqLuglDx7hyj
         6BjuqljjQQqOwsj840hBLzoZcn3Gf2XtJF6Fq5/P6wNmoWFBqRa9M7qH4o7wob7Afwsa
         ovgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=W8yQDQu7EemafJASYnuyhW4bX1ksI/tfDBnRYFUMERE=;
        b=ppRV/3JnxcYIGMonnn59am+5XFhblqaECIcn+wQ9d2WRGS8MJBDN7EG8H0pTTxVW3S
         xBCPpdhn6pPKI6NJIslM34jV7IyshIxmcFwopz/guQSFss7AqhHx7LamDGO8G833R1ha
         w4YYcryu2tRZayQAzg9NuUUYvSD5M5EhPK3vga1bHN+Gqbn5dvfrl3e1uv52xnpqLmuq
         kwmc0wNHMKhxdQLBdBqKeXhVqqQK1wKoowTizQLvFc5Wkk7hNzszTKiyUTdECmbtFfny
         5OkcAdsjaHpOtbhZkvIluq2NykGEDTDYZc8fGbXUXlTZPd69iFzj/Wsbx7MlpoVvzk/l
         lCtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935922AbeBUO5c (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 09:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932826AbeBUO5b (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 09:57:31 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC461205F4
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
Subject: [PATCH v2 06/17] tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
Date: Wed, 21 Feb 2018 23:57:07 +0900
Message-Id: <151922502764.6217.6652071625580117591.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593022941296181673?=
X-GMAIL-MSGID: =?utf-8?q?1593022941296181673?=
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
index 4f5447cec44a..37bdd56b4988 100644
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
 


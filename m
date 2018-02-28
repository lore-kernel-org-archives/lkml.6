Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2259jOjJuXPAvqeIQ5mgUZvSIRpb1CJVh9mvGcIS+M89drd+6sYyFHz/DSsBgIs5F9wjgnx2
ARC-Seal: i=1; a=rsa-sha256; t=1519788197; cv=none;
        d=google.com; s=arc-20160816;
        b=UQ/r+13joeCTCPDW60Ylnzqd5aefWZgX13I1wlXysm8BTDMMwCPK1KfM+UsJ4E+iOD
         1EDOkMM4mK+ug3HhkfgvOXm87obgqx3UvnV3s3kWxuq97HAROH6a0l46Y0OS6sk1nCuf
         MqMW3IPQi31cfKCD5Z3hjUYdAl8wGkO+Xycw2iOmP74XqgbFv9mwcNqQqTMMfcAqfPhB
         uP01CLfdSVaBrrWj0MSIOxrqgPhyab5iPqT6lRwfTsInqlCQTGtCKLVJiDHGOuNQHQ4f
         ffemFmoxI/Rv6Oh9Ml2mXifZpOZWjPRhg6VV/GQyx9k5mWvBT4Qh31eqcL0H9wFwyQ3V
         /DjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=Qp4iggARqBTZprkNl9HfL5SYh57/ldbii8nPfgtUAyI=;
        b=H5Zt3cHc9HETzhfFmSAnDuLT1xAxYjZZ28Nnysi59ewFTKiyqfK/OwVdjVBSi3cReu
         bAG6oW/1OzuSvAASEBjiMdpkqV9JJ+OGgG7ZMxNpebVDZqg0pLbqhaf5eGdBfNFFQ9s2
         N9TcHp5Kdma2RnVuJtn8GhjLf3Ejl0GowebXnSaSqdbNGuNO2NXRuk8XDAEWmGoA6VsG
         ZNyON+icHJw4Iry+qxNWFwGtnm1qkhrqaA3tzhZiECXG/aGb95vlqXIcYJAKCqT0VgS+
         eoSIjYBRdwzmZ2HcJGF5BCxRXhB96ksHTmFeS+VkKxS8fLQtlZtUEnjOfafoPr78FfA7
         tJQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeB1DXQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Tue, 27 Feb 2018 22:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751735AbeB1DXQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Feb 2018 22:23:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584722168D
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
Subject: [PATCH v4 07/19] tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
Date: Wed, 28 Feb 2018 12:22:52 +0900
Message-Id: <151978817231.2577.7346514119363309249.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593613429335052853?=
X-GMAIL-MSGID: =?utf-8?q?1593613429335052853?=
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
 


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+oVfoNqs/VCFxKzaBhKcltit4HPhRYhji0G9x5cqgcFK6efIXKmdIzwObYo9wKet+NqR81
ARC-Seal: i=1; a=rsa-sha256; t=1524658691; cv=none;
        d=google.com; s=arc-20160816;
        b=unr0JcLAT/w+8j1C1zWs3wQyH8QdeD6brhA/mA6SENi1/Nb+hlCS5TA1F9V/yHw5uW
         GwdjfxeUe18nl1cM9wOM6uAw6XCPaXIUCJFG47J+22zNSL+a96E0/NzE/UTVQlBnMrcG
         YgTPjShMtpJ4dgBQkNqkVCsV9HJOS1Z4YAXPr0OvzYwhHJoZlqG63Sm5qkQCv35/vR26
         3NzZIBo3PRSCnZdM73oxoQ6TfEf2iexAdazTDUiuCo4zIGd0FNP2cFK5eLkmrye1SMVe
         nxmFe8zI9WL8Flg7yvFZGZdhfboQrqZSnJWcnMze5QXgJgqZU5R5kyGEkbD5v0e8464I
         XNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=Qp4iggARqBTZprkNl9HfL5SYh57/ldbii8nPfgtUAyI=;
        b=0JCFHqYRIM1muvK+biiIVJAmHMz5wCHOGTXtsWQ77IeFk20zSo3W/gGH0kepNBnOwO
         1FfT38/oRZN5bwS24HhNkMlNmEa8tglCqYHri25WIh7lTXTdQEX1+LS1B6ne3AxD5hua
         mzxmMS52igf+8VOla9Cai5UFlKBDVy/qz5zPBMgmb1hbQzdpUb+IO3s+AWLbcT4Fj7w1
         0dSDyUzX8wzOuXuZlY449xNeArP0P4MCvKPCNO2hDfG2vLy26WydxZuiXnqFioEvKcLN
         ih23azy3bZGGKSFecFmSGuNesx6mU1NDiM6dOXv2/ZByuEZNhzewkrur/8ZaalOgiBZW
         Capg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeDYMR7 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 08:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752189AbeDYMR6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 08:17:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CD721748
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
Subject: [PATCH v7 03/16] tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
Date: Wed, 25 Apr 2018 21:17:34 +0900
Message-Id: <152465865422.26224.10111548170594014954.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598720511911626892?=
X-GMAIL-MSGID: =?utf-8?q?1598720511911626892?=
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
 


Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2267HA1cfdCW5DJ3RG4YXVGbxGtpFA1jRk965a9FnwN9q8J2zUdzAf7H5WDDXnrJoMO1CO7k
ARC-Seal: i=1; a=rsa-sha256; t=1519450312; cv=none;
        d=google.com; s=arc-20160816;
        b=cL/ovgXf0deSHLahlBQnGToRNn7sv2pEVetM9SMlR/zyV2NXRcmjrycJT30RFjJD9X
         Cm/GzKrRxLdvQaPMsu5QAeFsXnHWfuUF+LmBcHOjH0qJ7PKCT5Y7c6pD2A14aCzNVnjH
         y271PYTpyHD0GVUUW3bgp8d0VTdW99LUb/COAXQUUuqQ1GiggYka/dqtP3zMlh8xYgSa
         ewe3lnOm6yd9Ss/pmRrxRxxgVrJ19T1KUAIUSVoGL7ZtB/RIqQjuTaY/8jWIYNSR2t4H
         HbnTdTjz50xLh91nEx7q2x0LfXmKLq4iUWbXc8NHHBgBlckSjPzM3vFMzTVvp2uQ/f7y
         55Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :user-agent:references:in-reply-to:message-id:date:subject:cc:to
         :from:dmarc-filter:arc-authentication-results;
        bh=FaUPhnc6shQlMDgx37TVRABAFnjC6LXvpn8BdEeDHwc=;
        b=U2NIJ0z0ia0jO+DsGhSf6wRWutxrmjEYMK6cGhCtP4b52VnRq96FshYsr2eXBrBePd
         Ijl/X44vTOx23pgr62XkyHa9OdyPjih3nGQoKoFHGJoe4i7UxPuXevuSU2cPhXLDGYyv
         YWkJsl/jFu62nICFmoGw8miJSUir40j2Z5N/rVHg/d8xd7I7LEQzEbBMVnxzvnEREX8L
         Tp/s8uJMc0fosmS7t6C2u4qAXWqUsoOPjEq3Co1pGML52G45pEIFquzV2OcoaqHV/0xi
         PQLligLpWyCAlp46CoEkzknw9XB0LXRhcGbo5Z+YCIuKsmivYQ9yTU2hjOj1tvVKvmz0
         X7sA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeBXFbn (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sat, 24 Feb 2018 00:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbeBXFbm (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Feb 2018 00:31:42 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 949CE21741
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
Subject: [PATCH v3 06/18] tracing: probeevent: Remove NOKPROBE_SYMBOL from print functions
Date: Sat, 24 Feb 2018 14:31:18 +0900
Message-Id: <151945027840.27508.3320829168318373572.stgit@devbox>
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
X-GMAIL-THRID: =?utf-8?q?1593259130699032059?=
X-GMAIL-MSGID: =?utf-8?q?1593259130699032059?=
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
index 92d96ed6a2bf..0a809efabeb6 100644
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
 


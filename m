Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55DDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8955F21773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUw1+TkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfBIQTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:19:37 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44231 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfBIQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:19:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so3092757pfh.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 08:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTfTzdWgtBj2OIpypiaEbIqzqSKoyUzZbXVKzgKvFkk=;
        b=XUw1+TkVqB/B+dNcH/LirnvTUxwW83Gkmn60SxjJJ5J9/ojgw37Q3DS58QwR5DuAYT
         QYi5UiyaSuIV7tZEyUGYikTz2X+ioAhx2BqJ3NArlwrQvf2ICIRfH38L7ee52cWFP7sQ
         H81zeV0Z03E5UB/GoK0YTeCyME2jtUuNCtg6i4wCHFhjPQiuirqnJqQWBqucf02ZTFSk
         SkAsM2+anb33A1arFyLE2GCIj4Vtxb5PlMcaC5SlZOHs8QnESsPx0SLou1II5RskoWQz
         OEDDciqmvti0zYcPIXgFnRLE/w3c9cJM7cGFx7GU5VIFsBtKu+MRCXDi0UO3T2Gg3DaX
         s7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fTfTzdWgtBj2OIpypiaEbIqzqSKoyUzZbXVKzgKvFkk=;
        b=WaS2Rz4tv8C4zBbPm0wnQqavTZeL6pVwrzez5CTqHZJ+5Es468xOlvKJz43zje9hFe
         P+CR6mxhXO85y3HAfNPpzgrHXsefoMYZkW7SgX5WbiBwpEOy+XLAIC7CM//Bolboz/Hx
         aof7a3zKj4+r/aC5UxMwc+tZ1gtjhxG3HF0Pi2zUwogn7cF8wKGZUa8x9MTKOauXbZGL
         oZ3nXP8CkOQ2sIATzhH/y751tJS27JH+fKng0mzWhb8aDZqt4BUScyF9/Z0PM+rLD2Uw
         cf5QImQ7qd8wBzySaaxCLSbGW9/BI9lSDgGjjMNP2Bxx/aio0ensMb9hsuc0cud0Q+I8
         5uag==
X-Gm-Message-State: AHQUAubCji/bQk8Et86aNUTWWT9n/AE60nH+7K0LHI8W7dGxHgooxrXc
        W6Fhy6to+TkOE7bHGhTiVSs=
X-Google-Smtp-Source: AHgI3IaHlVmMtbA13sv0zmqoUQD9WU72duWycaQWdHLQSapGvC1CA/fllhtobMK2d5dvXErxaTmA8w==
X-Received: by 2002:a63:e516:: with SMTP id r22mr21688823pgh.256.1549729175873;
        Sat, 09 Feb 2019 08:19:35 -0800 (PST)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u5sm6130005pgp.2.2019.02.09.08.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 08:19:34 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] tracing: print function names instead of just address
Date:   Sun, 10 Feb 2019 00:19:19 +0800
Message-Id: <20190209161919.32350-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an example for this change.

$ sudo perf record -e 'ftrace:function' --filter='ip==schedule'
$ sudo perf report

The output of perf before this patch:

\# Samples: 100  of event 'ftrace:function'
\# Event count (approx.): 100
\#
\# Overhead  Trace output
\# ........  ......................................
\#
    51.00%   ffffffff81f6aaa0 <-- ffffffff81158e8d
    29.00%   ffffffff81f6aaa0 <-- ffffffff8116ccb2
     8.00%   ffffffff81f6aaa0 <-- ffffffff81f6f2ed
     4.00%   ffffffff81f6aaa0 <-- ffffffff811628db
     4.00%   ffffffff81f6aaa0 <-- ffffffff81f6ec5b
     2.00%   ffffffff81f6aaa0 <-- ffffffff81f6f21a
     1.00%   ffffffff81f6aaa0 <-- ffffffff811b04af
     1.00%   ffffffff81f6aaa0 <-- ffffffff8143ce17

After this patch:

\# Samples: 36  of event 'ftrace:function'
\# Event count (approx.): 36
\#
\# Overhead  Trace output
\# ........  ............................................
\#
    38.89%   schedule <-- schedule_hrtimeout_range_clock
    27.78%   schedule <-- worker_thread
    13.89%   schedule <-- schedule_timeout
    11.11%   schedule <-- smpboot_thread_fn
     5.56%   schedule <-- rcu_gp_kthread
     2.78%   schedule <-- exit_to_usermode_loop

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace_entries.h | 41 +++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 06bb2fd9a56c..fc8e97328e54 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -65,7 +65,8 @@ FTRACE_ENTRY_REG(function, ftrace_entry,
 		__field(	unsigned long,	parent_ip	)
 	),
 
-	F_printk(" %lx <-- %lx", __entry->ip, __entry->parent_ip),
+	F_printk(" %ps <-- %ps",
+		 (void *)__entry->ip, (void *)__entry->parent_ip),
 
 	FILTER_TRACE_FN,
 
@@ -83,7 +84,7 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 		__field_desc(	int,		graph_ent,	depth		)
 	),
 
-	F_printk("--> %lx (%d)", __entry->func, __entry->depth),
+	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth),
 
 	FILTER_OTHER
 );
@@ -102,8 +103,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		__field_desc(	int,		ret,		depth	)
 	),
 
-	F_printk("<-- %lx (%d) (start: %llx  end: %llx) over: %d",
-		 __entry->func, __entry->depth,
+	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
+		 (void *)__entry->func, __entry->depth,
 		 __entry->calltime, __entry->rettime,
 		 __entry->depth),
 
@@ -167,12 +168,6 @@ FTRACE_ENTRY_DUP(wakeup, ctx_switch_entry,
 
 #define FTRACE_STACK_ENTRIES	8
 
-#ifndef CONFIG_64BIT
-# define IP_FMT "%08lx"
-#else
-# define IP_FMT "%016lx"
-#endif
-
 FTRACE_ENTRY(kernel_stack, stack_entry,
 
 	TRACE_STACK,
@@ -182,12 +177,13 @@ FTRACE_ENTRY(kernel_stack, stack_entry,
 		__dynamic_array(unsigned long,	caller	)
 	),
 
-	F_printk("\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n",
-		 __entry->caller[0], __entry->caller[1], __entry->caller[2],
-		 __entry->caller[3], __entry->caller[4], __entry->caller[5],
-		 __entry->caller[6], __entry->caller[7]),
+	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n",
+		 (void *)__entry->caller[0], (void *)__entry->caller[1],
+		 (void *)__entry->caller[2], (void *)__entry->caller[3],
+		 (void *)__entry->caller[4], (void *)__entry->caller[5],
+		 (void *)__entry->caller[6], (void *)__entry->caller[7]),
 
 	FILTER_OTHER
 );
@@ -201,12 +197,13 @@ FTRACE_ENTRY(user_stack, userstack_entry,
 		__array(	unsigned long,	caller, FTRACE_STACK_ENTRIES	)
 	),
 
-	F_printk("\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n"
-		 "\t=> (" IP_FMT ")\n\t=> (" IP_FMT ")\n",
-		 __entry->caller[0], __entry->caller[1], __entry->caller[2],
-		 __entry->caller[3], __entry->caller[4], __entry->caller[5],
-		 __entry->caller[6], __entry->caller[7]),
+	F_printk("\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n\t=> %ps\n"
+		 "\t=> %ps\n\t=> %ps\n",
+		 (void *)__entry->caller[0], (void *)__entry->caller[1],
+		 (void *)__entry->caller[2], (void *)__entry->caller[3],
+		 (void *)__entry->caller[4], (void *)__entry->caller[5],
+		 (void *)__entry->caller[6], (void *)__entry->caller[7]),
 
 	FILTER_OTHER
 );
-- 
2.19.1


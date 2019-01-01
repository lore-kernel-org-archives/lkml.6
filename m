Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B97C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFBD218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEwWK9GR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfAAPr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 10:47:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46883 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfAAPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 10:47:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so13557338ply.13;
        Tue, 01 Jan 2019 07:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TI/AIyshgrN4fgelDTekX7HJwhmudrg12etbzasitz8=;
        b=aEwWK9GRaMCKXTIvCVhM1lV9qp5g0qDQEA9TYb5D1lxcPzXgubMfdxr+gYbxTEPwzz
         QMBBY526mmMz4iIKHb0oK2JvL2GHWSUMb4HvhpWmtGMblYvt2vt8+5IFhnExwTAS5Zgl
         EuYhoCXdRrau/fj6D3l2eyIK8HTlGFxH3nmTU3ltEBGhI0hOGFFWS7nT7amY3xMTF3Cs
         HOBL3TS0HqZeIAAOAqRP9ZL9GTYbcHUr9/xRhPtVn4/loih+It/drdJQ7wfDDqVhdgCc
         huCRNTodsq6P0dtMS8RGaP7Ur1GsvF5jSkD4GEEHe2F0eyfrLW/TXx4jKaU6H+6dujIh
         uylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TI/AIyshgrN4fgelDTekX7HJwhmudrg12etbzasitz8=;
        b=HENrUKaodvrmrtX/o9hqLxal7WCdTIEPWMjslZWGG35T+igkMvDue83xcjUXsbqYsh
         ywOgzZYDC1fKPeuFYNyd8zIij69rSLQrIel6NE7JTAikHDK4k72hVXwFqUKHBaej6fR/
         zqVGQUftISb79UEM8LPAHAXVKkxoQd3syAPHM28I822OVRfaE2u0vX4t4/IkgW1KSufT
         st7SQ0d4tKi0rWWSlDKG7Q60I0K0vHGjMuRnqeZgABNGgK/0fjbVLSkCfcXc9grP36/8
         BKwVtQBBdzEDoLx2GqpH2xgvod8DA2wh9eOnYfR8/x8r/DK3MNedRf9D/63lC+eKdyi4
         pB0A==
X-Gm-Message-State: AJcUukeRfhlHbuKu0ZHEtyZexxOYQbuYFmlua3LtQCZ24kwsc/7DJ+XD
        qHIx2wLKS29PnI850Hig69c=
X-Google-Smtp-Source: ALg8bN6BfKrE79LkTCUKPqXGJGtqWs+dz0xBcnRTGtHBZIs6TigRK/68ddO73C6MC+e45Qp4z+zpKw==
X-Received: by 2002:a17:902:7614:: with SMTP id k20mr41165268pll.285.1546357645412;
        Tue, 01 Jan 2019 07:47:25 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id m3sm84122386pff.173.2019.01.01.07.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 07:47:24 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 1/5] function_graph: Support displaying relative timestamp
Date:   Tue,  1 Jan 2019 23:46:10 +0800
Message-Id: <20190101154614.8887-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101154614.8887-1-changbin.du@gmail.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When function_graph is used for latency tracers, relative timestamp
is more straightforward than absolute timestamp as function trace
does. This change adds relative timestamp support to function_graph
and applies to latency tracers (wakeup and irqsoff).

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace.h                 |  9 +++++----
 kernel/trace/trace_functions_graph.c | 25 +++++++++++++++++++++++++
 kernel/trace/trace_irqsoff.c         |  2 +-
 kernel/trace/trace_sched_wakeup.c    |  2 +-
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 08900828d282..a34fa5e76abb 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -855,10 +855,11 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_PROC          0x8
 #define TRACE_GRAPH_PRINT_DURATION      0x10
 #define TRACE_GRAPH_PRINT_ABS_TIME      0x20
-#define TRACE_GRAPH_PRINT_IRQS          0x40
-#define TRACE_GRAPH_PRINT_TAIL          0x80
-#define TRACE_GRAPH_SLEEP_TIME		0x100
-#define TRACE_GRAPH_GRAPH_TIME		0x200
+#define TRACE_GRAPH_PRINT_REL_TIME      0x40
+#define TRACE_GRAPH_PRINT_IRQS          0x80
+#define TRACE_GRAPH_PRINT_TAIL          0x100
+#define TRACE_GRAPH_SLEEP_TIME          0x200
+#define TRACE_GRAPH_GRAPH_TIME          0x400
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index c2af1560e856..16ebbdd7b22e 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -500,6 +500,17 @@ static void print_graph_abs_time(u64 t, struct trace_seq *s)
 			 (unsigned long)t, usecs_rem);
 }
 
+static void
+print_graph_rel_time(struct trace_iterator *iter, struct trace_seq *s)
+{
+	unsigned long long usecs;
+
+	usecs = iter->ts - iter->trace_buffer->time_start;
+	do_div(usecs, NSEC_PER_USEC);
+
+	trace_seq_printf(s, "%9llu us |  ", usecs);
+}
+
 static void
 print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 		enum trace_type type, int cpu, pid_t pid, u32 flags)
@@ -517,6 +528,10 @@ print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 		if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 			print_graph_abs_time(iter->ts, s);
 
+		/* Relative time */
+		if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+			print_graph_rel_time(iter, s);
+
 		/* Cpu */
 		if (flags & TRACE_GRAPH_PRINT_CPU)
 			print_graph_cpu(s, cpu);
@@ -725,6 +740,10 @@ print_graph_prologue(struct trace_iterator *iter, struct trace_seq *s,
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		print_graph_abs_time(iter->ts, s);
 
+	/* Relative time */
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		print_graph_rel_time(iter, s);
+
 	/* Cpu */
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		print_graph_cpu(s, cpu);
@@ -1101,6 +1120,8 @@ static void print_lat_header(struct seq_file *s, u32 flags)
 
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		size += 16;
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		size += 16;
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		size += 4;
 	if (flags & TRACE_GRAPH_PRINT_PROC)
@@ -1125,6 +1146,8 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	seq_putc(s, '#');
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		seq_puts(s, "     TIME       ");
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		seq_puts(s, "   REL TIME     ");
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		seq_puts(s, " CPU");
 	if (flags & TRACE_GRAPH_PRINT_PROC)
@@ -1139,6 +1162,8 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	seq_putc(s, '#');
 	if (flags & TRACE_GRAPH_PRINT_ABS_TIME)
 		seq_puts(s, "      |         ");
+	if (flags & TRACE_GRAPH_PRINT_REL_TIME)
+		seq_puts(s, "      |         ");
 	if (flags & TRACE_GRAPH_PRINT_CPU)
 		seq_puts(s, " |  ");
 	if (flags & TRACE_GRAPH_PRINT_PROC)
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d3294721f119..e6a62e7c6b69 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -238,7 +238,7 @@ static void irqsoff_trace_close(struct trace_iterator *iter)
 
 #define GRAPH_TRACER_FLAGS (TRACE_GRAPH_PRINT_CPU | \
 			    TRACE_GRAPH_PRINT_PROC | \
-			    TRACE_GRAPH_PRINT_ABS_TIME | \
+			    TRACE_GRAPH_PRINT_REL_TIME | \
 			    TRACE_GRAPH_PRINT_DURATION)
 
 static enum print_line_t irqsoff_print_line(struct trace_iterator *iter)
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 4ea7e6845efb..b6c5fa10347e 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -180,7 +180,7 @@ static void wakeup_trace_close(struct trace_iterator *iter)
 }
 
 #define GRAPH_TRACER_FLAGS (TRACE_GRAPH_PRINT_PROC | \
-			    TRACE_GRAPH_PRINT_ABS_TIME | \
+			    TRACE_GRAPH_PRINT_REL_TIME | \
 			    TRACE_GRAPH_PRINT_DURATION)
 
 static enum print_line_t wakeup_print_line(struct trace_iterator *iter)
-- 
2.17.1


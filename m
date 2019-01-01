Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD71C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8B1218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 15:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUrHMjuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfAAPrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 10:47:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35730 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfAAPrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 10:47:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so14183460pfi.2;
        Tue, 01 Jan 2019 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=61DEp7PHbJrMNxcYppWsSaNRXPkf6mq3TAlmifFP7Ws=;
        b=EUrHMjuIzcXGj/N7KOEg0MbWi6sj2BGo9Q/cCUdQ8SuJOuWFWaLBHqZksfdSSybfQx
         pMGCSTlH+MOW1o5nmXus3B6mnhqhwWl68a0c7AFYqX2a2wVxeGe5yGJCV2/fQmwSwcmL
         1a5g3DXCpHXckeQ7DCGQuyRxxsDb46qxiT790mToMSZzcLVU9kO2MMdLfwKIn+DkpcxE
         uUKNqy2lizYAFmTPjVCVpjnzbGDedz1Pxtm63PQcKHupU7MOsld+2AmU2Jya9IDiynWI
         1gHMR9IJglpGvZmpAXdxqUsYOgXwD6fYnCZQkKipwKEEuGefNXb75q1kewvpn2sW94iG
         2Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=61DEp7PHbJrMNxcYppWsSaNRXPkf6mq3TAlmifFP7Ws=;
        b=RDWJC744Qlseh20n2Vv+qcFOpfFBW9Vuo41CkZp1lAK8njDfE5lOFaVDnN00BZIDl4
         qjFCTziC7lbvYJeEZwjG8RdR6UdwTLV+oMkJa769sZuSfCRcz9hm0vKt0vmV6QHWiowc
         zYa5AOuTVgLS6rkq/WBEn17DqEprw42S9nGCyvltr0IH31Kc+a7ZIXlmmp546cVMFQhK
         BWo+ayhfpUvtCP9eQ4vLApuy6EaXfs7HrgH9edc2NinACvCEolUMbt6nKW232RUCI6zr
         zPJZVR92wGMba3ieybD2wvRTJr/YFXMRK1iMmVMQdGHLOYPY02QZACvCSiQi5csLZe2p
         QXyQ==
X-Gm-Message-State: AJcUukcDOEFe+yFoXYSVXpPEUaawQ6rbV4jorIlldWeF3wX4z1TKBZbZ
        QaYc3MGy1JtM22ohSwKAdLQ=
X-Google-Smtp-Source: ALg8bN7n6UfU+ebY9jrq+3nvUat72O8NaBlC4FEvIltynts7sZL1p6DB3BVkvU76ZXyU38P98zmBsg==
X-Received: by 2002:a63:1766:: with SMTP id 38mr10679239pgx.299.1546357669069;
        Tue, 01 Jan 2019 07:47:49 -0800 (PST)
Received: from localhost.localdomain ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id m3sm84122386pff.173.2019.01.01.07.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 07:47:48 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 3/5] sched/tracing: Put a margin between flags and duration for wakeup tracers
Date:   Tue,  1 Jan 2019 23:46:12 +0800
Message-Id: <20190101154614.8887-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190101154614.8887-1-changbin.du@gmail.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't mix context flags with function duration info. Now the output looks
like this:

\# tracer: wakeup
\#
\# wakeup latency trace v1.1.5 on 4.20.0+
\# --------------------------------------------------------------------
\# latency: 593 us, #674/674, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:4)
\#    -----------------
\#    | task: kworker/0:1H-339 (uid:0 nice:-20 policy:0 rt_prio:0)
\#    -----------------
\#
\#                                      _-----=> irqs-off
\#                                     / _----=> need-resched
\#                                    | / _---=> hardirq/softirq
\#                                    || / _--=> preempt-depth
\#                                    ||| /
\#  REL TIME      CPU  TASK/PID       ||||     DURATION                  FUNCTION CALLS
\#     |          |     |    |        ||||      |   |                     |   |   |   |
        0 us |   0)    <idle>-0    |  dNs. |               |  /*      0:120:R   + [000]   339:100:R kworker/0:1H */
        3 us |   0)    <idle>-0    |  dNs. |   0.000 us    |            (null)();
       67 us |   0)    <idle>-0    |  dNs. |   0.721 us    |  ttwu_stat();
       69 us |   0)    <idle>-0    |  dNs. |   0.607 us    |  _raw_spin_unlock_irqrestore();
       71 us |   0)    <idle>-0    |  .Ns. |   0.598 us    |  _raw_spin_lock_irq();
       72 us |   0)    <idle>-0    |  .Ns. |   0.584 us    |  _raw_spin_lock_irq();
       73 us |   0)    <idle>-0    |  dNs. | + 11.118 us   |  __next_timer_interrupt();
       75 us |   0)    <idle>-0    |  dNs. |               |  call_timer_fn() {
       76 us |   0)    <idle>-0    |  dNs. |               |    delayed_work_timer_fn() {
       76 us |   0)    <idle>-0    |  dNs. |               |      __queue_work() {
       ...

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/trace_functions_graph.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 16ebbdd7b22e..69ebf3c2f1b5 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -380,6 +380,7 @@ static void print_graph_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 {
 	trace_seq_putc(s, ' ');
 	trace_print_lat_fmt(s, entry);
+	trace_seq_puts(s, " | ");
 }
 
 /* If the pid changed since the last trace, output this event */
@@ -1153,7 +1154,7 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	if (flags & TRACE_GRAPH_PRINT_PROC)
 		seq_puts(s, "  TASK/PID       ");
 	if (lat)
-		seq_puts(s, "||||");
+		seq_puts(s, "||||   ");
 	if (flags & TRACE_GRAPH_PRINT_DURATION)
 		seq_puts(s, "  DURATION   ");
 	seq_puts(s, "               FUNCTION CALLS\n");
@@ -1169,7 +1170,7 @@ static void __print_graph_headers_flags(struct trace_array *tr,
 	if (flags & TRACE_GRAPH_PRINT_PROC)
 		seq_puts(s, "   |    |        ");
 	if (lat)
-		seq_puts(s, "||||");
+		seq_puts(s, "||||   ");
 	if (flags & TRACE_GRAPH_PRINT_DURATION)
 		seq_puts(s, "   |   |      ");
 	seq_puts(s, "               |   |   |   |\n");
-- 
2.17.1


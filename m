Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeDFNFK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752653AbeDFNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:01:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB1B21839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180406130112.263267055@goodmis.org>
User-Agent: quilt/0.63-1
Date: Fri, 06 Apr 2018 09:00:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [for-next][PATCH 04/18] tracing: Mention trace_clock=global when warning about unstable
 clocks
References: <20180406130035.400292196@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0004-tracing-Mention-trace_clock-global-when-warning-abou.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

Mention the alternative of adding trace_clock=global to the kernel
command line when we detect that we've used an unstable clock across a
suspend/resume cycle.

Link: http://lkml.kernel.org/r/20180330150132.16903-2-chris@chris-wilson.co.uk

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a2fd3893cc02..515be03e3009 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2731,7 +2731,8 @@ rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
-		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n");
+		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
+		  "or add trace_clock=global to the kernel command line\n");
 	info->add_timestamp = 1;
 }
 
-- 
2.15.1

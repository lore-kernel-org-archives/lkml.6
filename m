Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeC3PSL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:18:11 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:59430 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751195AbeC3PSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:18:09 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
From: Chris Wilson <chris@chris-wilson.co.uk>
To: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/2] trace: Mention trace_clock=global when warning about unstable clocks
Date: Fri, 30 Mar 2018 16:01:32 +0100
Message-Id: <20180330150132.16903-2-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330150132.16903-1-chris@chris-wilson.co.uk>
References: <20180330150132.16903-1-chris@chris-wilson.co.uk>
X-Originating-IP: 78.156.65.138
X-Country: code=GB country="United Kingdom" ip=78.156.65.138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention the alternative of adding trace_clock=global to the kernel
command line when we detect that we've used an unstable clock across a
suspend/resume cycle.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dcf1c4dd3efe..88098d7fac06 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2637,7 +2637,8 @@ rb_handle_timestamp(struct ring_buffer_per_cpu *cpu_buffer,
 		  sched_clock_stable() ? "" :
 		  "If you just came from a suspend/resume,\n"
 		  "please switch to the trace global clock:\n"
-		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n");
+		  "  echo global > /sys/kernel/debug/tracing/trace_clock\n"
+		  "or add trace_clock=global to the kernel command line\n");
 	info->add_timestamp = 1;
 }
 
-- 
2.16.3

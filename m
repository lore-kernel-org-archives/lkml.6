Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032834AbeBNQmF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:42:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032775AbeBNQlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:41:17 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] percpu: Remove inert tracepoint in __init code
Date: Wed, 14 Feb 2018 10:40:43 -0600
Message-Id: <42d6bf23a6d151b5d13778be969c7a063d60665a.1518626149.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1518626149.git.jpoimboe@redhat.com>
References: <cover.1518626149.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jump_label code doesn't patch init code, so this tracepoint can
never be enabled.  Remove it.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 mm/percpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 50e7fdf84055..3216364ad91b 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2156,7 +2156,6 @@ int __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
 	pcpu_chunk_relocate(pcpu_first_chunk, -1);
 
 	pcpu_stats_chunk_alloc();
-	trace_percpu_create_chunk(base_addr);
 
 	/* we're done */
 	pcpu_base_addr = base_addr;
-- 
2.14.3

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032847AbeBNQmU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:42:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032774AbeBNQlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:41:17 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/3] x86/xen: Remove inert tracepoint in __init code
Date: Wed, 14 Feb 2018 10:40:42 -0600
Message-Id: <e6d9f3b13f2a5a55a0b158e79dfc5a2d8dc40bd7.1518626149.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1518626149.git.jpoimboe@redhat.com>
References: <cover.1518626149.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jump_label code doesn't patch init code, so this tracepoint can
never be enabled.  Remove it.

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/xen/enlighten_pv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index c047f42552e1..0dbfad92f442 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -803,8 +803,6 @@ static void xen_write_gdt_entry(struct desc_struct *dt, int entry,
 static void __init xen_write_gdt_entry_boot(struct desc_struct *dt, int entry,
 					    const void *desc, int type)
 {
-	trace_xen_cpu_write_gdt_entry(dt, entry, desc, type);
-
 	switch (type) {
 	case DESC_LDT:
 	case DESC_TSS:
-- 
2.14.3

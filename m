Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2531373-1520026352-2-3252556526885760734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520026352; b=m7a9/o5dobEfrs8/ewx8MLVm4V+GfGXkb2hQSVzgUMf99hS
    VYzmftcvaF2ILNAyFbBCnegkZL/xMmQ0+e7HtKwdtvWuCN6WcYot8Sc2hNwZAb+K
    BB8UiHdMALJj3yK973ZbHBKAwbbWVWWsBRdseNXY0cLEH/JDlMuwpq4gePnRhFqD
    wYnTZorr8y9dtXug5F72CKBLhL0dAksZGuQbjH7Sh1HCmnthMpQLEsy5Lvn2yjLR
    me1mSn0TOHok3j4W5ZG6zqvZOcG61ockqkQrMzPjSPrcFRNt8UQ7xzHnEWo61drS
    PL8i//sXJS3QTlyUFR+tDsYENKc8ou0toUsv3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:sender:list-id; s=
    arctest; t=1520026352; bh=Ltpzrwu92nSCsiw5UiFnheZ8I1GtxGNCyYxszx
    SJY5w=; b=ZFbUU+5VyiKkMFMB/5no5y7jpMGoxVnxNHN3WdlmOA+rmLL8GOAVzo
    a8MGJkssLcZtSbbSOTTBusiXFNdYzKLT/Y3lkObBYmzpuAhIok0tVPKRgHGBhHL3
    MZIaFIuoVFW1Om/oYxLk01W/c9wMQSG1ON6qMk4H70Zpw/uFSgYyZGD4S9CQP98x
    9SXnj7zKlYHBtQ9NqerXBdb00njDM5I5InZi7veYUjhGlyJB8IxIXO8HqgHMd2wU
    WyTy2QsS+8LwCeJ2J820giq13fipZhBSH4kFScbrm+MIPfoGivTSh68zZ+ji/ezO
    iNVzpByWtHqeqExJktFAoWo6D43zQqvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933990AbeCBVc3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 16:32:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:55420 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934016AbeCBVc0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 16:32:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="22145325"
From: Tim Chen <tim.c.chen@linux.intel.com>
To: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>, ak@linux.intel.com,
        karahmed@amazon.de, pbonzini@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        gregkh@linux-foundation.org
Subject: [PATCH 2/2] x86/speculation: Use Indirect Branch Prediction Barrier in context switch
Date: Fri,  2 Mar 2018 13:32:10 -0800
Message-Id: <e25ad06fecab41d2d6ec82d1164e34f1d581d77d.1520026221.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1520026221.git.tim.c.chen@linux.intel.com>
References: <cover.1520026221.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1520026221.git.tim.c.chen@linux.intel.com>
References: <cover.1520026221.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit: 18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7

Flush indirect branches when switching into a process that marked itself
non dumpable. This protects high value processes like gpg better,
without having too high performance overhead.

If done naïvely, we could switch to a kernel idle thread and then back
to the original process, such as:

    process A -> idle -> process A

In such scenario, we do not have to do IBPB here even though the process
is non-dumpable, as we are switching back to the same process after a
hiatus.

To avoid the redundant IBPB, which is expensive, we track the last mm
user context ID. The cost is to have an extra u64 mm context id to track
the last mm we were using before switching to the init_mm used by idle.
Avoiding the extra IBPB is probably worth the extra memory for this
common scenario.

For those cases where tlb_defer_switch_to_init_mm() returns true (non
PCID), lazy tlb will defer switch to init_mm, so we will not be changing
the mm for the process A -> idle -> process A switch. So IBPB will be
skipped for this case.

Thanks to the reviewers and Andy Lutomirski for the suggestion of
using ctx_id which got rid of the problem of mm pointer recycling.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: linux@dominikbrodowski.net
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: pbonzini@redhat.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517263487-3708-1-git-send-email-dwmw@amazon.co.uk
---
 arch/x86/include/asm/tlbflush.h |  2 ++
 arch/x86/mm/tlb.c               | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 94146f6..99185a0 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -68,6 +68,8 @@ static inline void invpcid_flush_all_nonglobals(void)
 struct tlb_state {
 	struct mm_struct *active_mm;
 	int state;
+	/* last user mm's ctx id */
+	u64 last_ctx_id;
 
 	/*
 	 * Access to this CR4 shadow and to H/W CR4 is protected by
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index fa74bf5..eac92e2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -10,6 +10,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
+#include <asm/nospec-branch.h>
 #include <asm/cache.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
@@ -106,6 +107,28 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	unsigned cpu = smp_processor_id();
 
 	if (likely(prev != next)) {
+		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
+
+		/*
+		 * Avoid user/user BTB poisoning by flushing the branch
+		 * predictor when switching between processes. This stops
+		 * one process from doing Spectre-v2 attacks on another.
+		 *
+		 * As an optimization, flush indirect branches only when
+		 * switching into processes that disable dumping. This
+		 * protects high value processes like gpg, without having
+		 * too high performance overhead. IBPB is *expensive*!
+		 *
+		 * This will not flush branches when switching into kernel
+		 * threads. It will also not flush if we switch to idle
+		 * thread and back to the same process. It will flush if we
+		 * switch to a different non-dumpable process.
+		 */
+		if (tsk && tsk->mm &&
+		    tsk->mm->context.ctx_id != last_ctx_id &&
+		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+			indirect_branch_prediction_barrier();
+
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
 			 * If our current stack is in vmalloc space and isn't
@@ -120,6 +143,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 				set_pgd(pgd, init_mm.pgd[stack_pgd_index]);
 		}
 
+		/*
+		 * Record last user mm's context id, so we can avoid
+		 * flushing branch buffer with IBPB if we switch back
+		 * to the same user.
+		 */
+		if (next != &init_mm)
+			this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
+
 		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
 		this_cpu_write(cpu_tlbstate.active_mm, next);
 
-- 
2.9.4

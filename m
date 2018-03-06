Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520295974-2-13097766260337856283
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520295973; b=bl9I3UQxIN40A/09vgUAOUTpXDMzyVkip8baLRPbm/MvjwV
    NUXCsBqMgt2VS1/8pr5mSMm3aMk9AvKcAIEsnSRQ7aPO6hsL+BkRHefHl58idnTW
    VLTtczGAY62bZKZPK0vToegBrmT3ZhaZrfN7168XLR20kuXwfDtQ9TUfpYqi/dHt
    XiGooz3fvq0nK6Ioy8Yc7jrtj+JKLWwarjp9yxTWT7Z8R3N0YbNuQOquZ4ZjHmsI
    RvttjN+agyIGeZKALjksyiyRY4jJ+FWgyyX/y83eUBbuxoQ7+B8yUcY0SCkVdqE4
    NWhFmd/68MD1fssEls6z9ivxE21odeb02UcnOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520295973;
    bh=yiexmfzFJCZaFPVZUdV7YyqgR8uYFnW/1Ktuxgpja4c=; b=MaP+AAAKkmzF
    wj2Ht+oYFuYTTpad5qKBc57TEMpq9vM+AA38trIUhPaffB0KLh86qGwR3CkdhPzW
    Ax+91+FqzaXtyyRpetldsgoOq8Sjli1gwi6STu4YlpITwIvagyOx4LfDYoMkZa7J
    zM0LljiJ6J7h2VvDI7IG/DH9PV6AkZ15zH6gdKXcMcvqrSZMWBAVQJqbH5/hLywD
    nnyubhEhqVJaJSrlcSwhzNnrpeMdiS6Wz8m3NLUABFFFqKqzEy/pIpKv8egkJAEA
    c8po8TL5xMV5/jwPOgX+QEO+4W+CZZzMkc7zH/nUM2PoRoASEWrChlAdT5kliXgY
    ewBo2TxmUw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=SckJ2e1o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=SckJ2e1o x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932930AbeCFA0L (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:26:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34758 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932926AbeCFA0K (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:10 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 09/65] x86/mm, sched/core: Turn off IRQs in switch_mm()
Date: Mon,  5 Mar 2018 19:24:42 -0500
Message-Id: <20180306002538.1761-10-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit 078194f8e9fe3cf54c8fd8bded48a1db5bd8eb8a upstream.

Potential races between switch_mm() and TLB-flush or LDT-flush IPIs
could be very messy.  AFAICT the code is currently okay, whether by
accident or by careful design, but enabling PCID will make it
considerably more complicated and will no longer be obviously safe.

Fix it with a big hammer: run switch_mm() with IRQs off.

To avoid a performance hit in the scheduler, we take advantage of
our knowledge that the scheduler already has IRQs disabled when it
calls switch_mm().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/f19baf759693c9dcae64bbff76189db77cb13398.1461688545.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 4ead44fd2525ed97e5362a806d312a0e3b0ea445)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/include/asm/mmu_context.h
---
 arch/x86/include/asm/mmu_context.h |  4 ++++
 arch/x86/mm/tlb.c                  | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 375fafccb32c..2bf4bae1c65e 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -95,6 +95,10 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		      struct task_struct *tsk);
 
+extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
+			       struct task_struct *tsk);
+#define switch_mm_irqs_off switch_mm_irqs_off
+
 #define activate_mm(prev, next)			\
 do {						\
 	paravirt_activate_mm((prev), (next));	\
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 40c640980720..4ce6569ad963 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -63,6 +63,16 @@ EXPORT_SYMBOL_GPL(leave_mm);
 
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	switch_mm_irqs_off(prev, next, tsk);
+	local_irq_restore(flags);
+}
+
+void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
+			struct task_struct *tsk)
 {
 	unsigned cpu = smp_processor_id();
 
-- 
2.16.2

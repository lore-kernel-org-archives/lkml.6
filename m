Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2968864-1520295979-2-6059301650245304331
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
    t=1520295978; b=pTQ7BbWncLeoFYUOcYTPmbkBMM4d/LmIRl+rJnAnIWzkbIg
    3pdaeJR21hnF0lJnrHw4cqwNKwC63Yg/0HwBeR8IQVPrBlPgN/6o+CJBN3w4ieyb
    Jx6RhNvWwnkws4qhpmwtfYEaBCZ+pYC1GhagOKdzoAbWf/FOePEM6X1CSD+SGhT/
    JKuPTmU82Z8M6H/dKpeE6jwphY8OQnmlnKk+UjwaO04+rQj7OlztFp035kuJcRjZ
    +WRNZ4bwzV+Dvx/NGziMj22TY9DbY1w066SE7g7Nxo/jBbsaGamuuJvridvy2XeY
    xH712NkSyMT0FWT3lPSsq2nqddPAg87MrrBG+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520295978;
    bh=lthWPhASUsytPLDUOvPxBs0Eic4fJmKrdLabUUi49ls=; b=o2hg6lRRWXhN
    T6dKUctkZ2PWMAoQsqdgwUk0pAxC7OvqL7OzQAKjoVVEXa1i2Y+q5lLFzkTdsc47
    HRuZPECKeDtFgY1BJtnrzLKPnxVqxKKAqkHvwysnga1rgR0gbT3Y5e3iYq1RqEe4
    pM5pi7xXyP+Y45iYrgekZuDcI27lC/Bsf9RsWi7P7avUtwYW92AkpRYc+T0dDLjW
    t1IAl5dnBExL0W3yZFaJZjX3FIqsyYXHHXXbWOqmv1fVz6pmRVH4xbTjTUGsenYg
    6ej4H32dN0KFvkjvsOpktX1GYJWwcikphLrTSKx5vaucBpbX4zt8Ko4cdsS/3tKB
    8CMKueLodw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=FlR7EtO6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=FlR7EtO6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933008AbeCFA0Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:26:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56164 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932961AbeCFA0N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:26:13 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 12/65] x86/irq: Do not substract irq_tlb_count from irq_call_count
Date: Mon,  5 Mar 2018 19:24:45 -0500
Message-Id: <20180306002538.1761-13-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Aaron Lu <aaron.lu@intel.com>

commit 82ba4faca1bffad429f15c90c980ffd010366c25 upstream.

Since commit:

  52aec3308db8 ("x86/tlb: replace INVALIDATE_TLB_VECTOR by CALL_FUNCTION_VECTOR")

the TLB remote shootdown is done through call function vector. That
commit didn't take care of irq_tlb_count, which a later commit:

  fd0f5869724f ("x86: Distinguish TLB shootdown interrupts from other functions call interrupts")

... tried to fix.

The fix assumes every increase of irq_tlb_count has a corresponding
increase of irq_call_count. So the irq_call_count is always bigger than
irq_tlb_count and we could substract irq_tlb_count from irq_call_count.

Unfortunately this is not true for the smp_call_function_single() case.
The IPI is only sent if the target CPU's call_single_queue is empty when
adding a csd into it in generic_exec_single. That means if two threads
are both adding flush tlb csds to the same CPU's call_single_queue, only
one IPI is sent. In other words, the irq_call_count is incremented by 1
but irq_tlb_count is incremented by 2. Over time, irq_tlb_count will be
bigger than irq_call_count and the substract will produce a very large
irq_call_count value due to overflow.

Considering that:

  1) it's not worth to send more IPIs for the sake of accurate counting of
     irq_call_count in generic_exec_single();

  2) it's not easy to tell if the call function interrupt is for TLB
     shootdown in __smp_call_function_single_interrupt().

Not to exclude TLB shootdown from call function count seems to be the
simplest fix and this patch just does that.

This bug was found by LKP's cyclic performance regression tracking recently
with the vm-scalability test suite. I have bisected to commit:

  3dec0ba0be6a ("mm/rmap: share the i_mmap_rwsem")

This commit didn't do anything wrong but revealed the irq_call_count
problem. IIUC, the commit makes rwc->remap_one in rmap_walk_file
concurrent with multiple threads.  When remap_one is try_to_unmap_one(),
then multiple threads could queue flush TLB to the same CPU but only
one IPI will be sent.

Since the commit was added in Linux v3.19, the counting problem only
shows up from v3.19 onwards.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Cc: Alex Shi <alex.shi@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tomoki Sekiyama <tomoki.sekiyama.qu@hitachi.com>
Link: http://lkml.kernel.org/r/20160811074430.GA18163@aaronlu.sh.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 3b9d9ec0d8261bb9b12f858e66f0c84cd2a6a3bb)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/hardirq.h | 4 ----
 arch/x86/kernel/irq.c          | 3 +--
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 0f5fb6b6567e..ebaf64d0a785 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -21,10 +21,6 @@ typedef struct {
 #ifdef CONFIG_SMP
 	unsigned int irq_resched_count;
 	unsigned int irq_call_count;
-	/*
-	 * irq_tlb_count is double-counted in irq_call_count, so it must be
-	 * subtracted from irq_call_count when displaying irq_call_count
-	 */
 	unsigned int irq_tlb_count;
 #endif
 #ifdef CONFIG_X86_THERMAL_VECTOR
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index e5952c225532..b6460c5a9cab 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -96,8 +96,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	seq_puts(p, "  Rescheduling interrupts\n");
 	seq_printf(p, "%*s: ", prec, "CAL");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stats(j)->irq_call_count -
-					irq_stats(j)->irq_tlb_count);
+		seq_printf(p, "%10u ", irq_stats(j)->irq_call_count);
 	seq_puts(p, "  Function call interrupts\n");
 	seq_printf(p, "%*s: ", prec, "TLB");
 	for_each_online_cpu(j)
-- 
2.16.2

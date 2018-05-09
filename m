Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-823031-1525891573-2-7356590063024417592
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525891572; b=nWrztUBW3gdotvVL72fiaXjjn0tbKzxKGxn5Z+ALkmDkUDjD9w
    xw3TMSjvFtu/wlttcxJCxjEToiEMmx8fGbGI0EAsWL63N4VzgFP02Twarbowm0AS
    zMNn5IRA1iJb9CE6dbMaRKYpY6lDxxxeXvt720fSEi9JasHegX5uV+if2mQl5pQh
    x8DqfECWI4cJ/KRTm4GaDR01Gp51Ut6B+w0mFLz6J4HnNrPcVymJg1BxX1m1Y1VP
    /0Mi6LTAwUNsWz+7pTrgQJPIZDIDsbX7Sp6knqAvKdsS3az2NRRanTBzL7gkpKX2
    y4efYpjbq1aAa/NMfYN2mwgMHH2zQbL1hnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1525891572; bh=VCVvx2kAV5bGp3v9+c0fQRHYn9mWpJ
    sYv81dC3DOIFk=; b=cBhmxBkwo7wf2FN9DeRZnM+JUxBlDy0QYpOYt6kbpDRWum
    YHeZh1DvnO6QRYt1K+RlKPLfnJlTAJYUGAQePZjqsvTyYt2b8199N9sWkzoaowxH
    tk3IWNwP/V0hBA46cMFPERnK6FHe379SF+efN+JafpxgQsi2RXNKWSaq1wJE3Uf5
    Nki1HvFqpn1/kDd22ZNFQfJrL/hDxEzSKXuAoi1QuyQgXwkszQ/l4ktF+cNyDCVO
    aBBq3G5HHc6Qo28sULTNNY7lyWIqMC9xGc4JC2wdhwr5W7VYQn4N6N0oeuCj5ITi
    20s1ZScoihRQ4sFjZYtdf6HS5fK2ebRekOTpaFvw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=goodmis.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=goodmis.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJA4vykP5eowVsiBhM0K6KSBxLvditkL+Qe05dDqtZP/PMFAhGgorM65mzqL/rsRQwuuLMgSSFpF/nX09wR/c22NR2EFsi2ZEj9VYkWI//rbZdf8zoOo
    z3QhDAUuSk6fCNQF7SOfKO9/Af+aXuKoo2ryFE31HBenl1NjMFALU/9P7BnN+XxwyXULkmtXFTXE9B+nYVoLlJP8msDLRii+8Icpu4l1Kl7HiFpvp/SXh6K5
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=meVymXHHAAAA:8 a=VwQbUJbxAAAA:8 a=XRH7TU2YvASs1ZvYd64A:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935240AbeEISqJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 14:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934980AbeEISqJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 9 May 2018 14:46:09 -0400
Date: Wed, 9 May 2018 14:46:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jingjie Jiang <jingjie.jiang@oracle.com>,
        Mukesh Rathor <mukesh.rathor@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH] tracing/x86/xen: Remove zero data size trace events
 trace_xen_mmu_flush_tlb{_all}
Message-ID: <20180509144605.5a220327@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Doing an audit of trace events, I discovered two trace events in the xen
subsystem that use a hack to create zero data size trace events. This is not
what trace events are for. Trace events add memory footprint overhead, and
if all you need to do is see if a function is hit or not, simply make that
function noinline and use function tracer filtering.

Worse yet, the hack used was:

 __array(char, x, 0)

Which creates a static string of zero in length. There's assumptions about
such constructs in ftrace that this is a dynamic string that is nul
terminated. This is not the case with these tracepoints and can cause
problems in various parts of ftrace.

Nuke the trace events!

Cc: stable@vger.kernel.org
Fixes: 95a7d76897c1e ("xen/mmu: Use Xen specific TLB flush instead of the generic one.")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/xen/mmu.c         |  4 +---
 arch/x86/xen/mmu_pv.c      |  4 +---
 include/trace/events/xen.h | 16 ----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
index d33e7dbe3129..2d76106788a3 100644
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -42,13 +42,11 @@ xmaddr_t arbitrary_virt_to_machine(void *vaddr)
 }
 EXPORT_SYMBOL_GPL(arbitrary_virt_to_machine);
 
-static void xen_flush_tlb_all(void)
+static noinline void xen_flush_tlb_all(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb_all(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 486c0a34d00b..2c30cabfda90 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1310,13 +1310,11 @@ unsigned long xen_read_cr2_direct(void)
 	return this_cpu_read(xen_vcpu_info.arch.cr2);
 }
 
-static void xen_flush_tlb(void)
+static noinline void xen_flush_tlb(void)
 {
 	struct mmuext_op *op;
 	struct multicall_space mcs;
 
-	trace_xen_mmu_flush_tlb(0);
-
 	preempt_disable();
 
 	mcs = xen_mc_entry(sizeof(*op));
diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 7dd8f34c37df..fdcf88bcf0ea 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -352,22 +352,6 @@ DECLARE_EVENT_CLASS(xen_mmu_pgd,
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_pin);
 DEFINE_XEN_MMU_PGD_EVENT(xen_mmu_pgd_unpin);
 
-TRACE_EVENT(xen_mmu_flush_tlb_all,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
-TRACE_EVENT(xen_mmu_flush_tlb,
-	    TP_PROTO(int x),
-	    TP_ARGS(x),
-	    TP_STRUCT__entry(__array(char, x, 0)),
-	    TP_fast_assign((void)x),
-	    TP_printk("%s", "")
-	);
-
 TRACE_EVENT(xen_mmu_flush_tlb_one_user,
 	    TP_PROTO(unsigned long addr),
 	    TP_ARGS(addr),
-- 
2.13.6

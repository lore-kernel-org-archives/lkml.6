Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835365-2-11575581638782221145
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835364; b=YAX5ODpO6dnnuky8kUpIGZMNCui6+f3s4Ubzfmb7IBw6v+r
    LMVAQxCizxTZQAIf2O7LYrP3Y5lIFRh8+UHS7V94oqYRgf0OP+q4Y6qWNJr7+z7Q
    kzmphL1Brpz6gcp3NEhlssgSWZe7GOrYVWip9cRHrIuxoBmxAdEIx3LI9jbJdGcQ
    ZVTnddaRRV4AiFN0vGh3AyW3uWz1drJkdUAvIUfT2x+YoSc8kCSC/aej110Xsn5H
    4z+3KDFGwH1/8iStjaeQJ1TGySsANENxGj/8nxtOYtqK/nFlk7o8IKAeR0kVw/nV
    pXJXdXZEcTn5IptcR2Fkr8mSTE523sj1hymd6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835364; bh=0/kbbz+Zcb4yLltlf2Z
    eyn0X9UHeC3wJ8eFo8o+ulS0=; b=VY4jPLth5zb+0za7dPhSEgGRuejXa/boGgf
    phazkrj8jCaMo4/kGtc20S19DR0Of8Mi4wze44CmLOOykFg9P87qNoLIyO/vXuA/
    RLGiwYQEqrHRTksWV2vWUmLPDOJ6Sjflk2epbmPQYZgc1tx0yrclD0blRIAetOG3
    +ssuKS+4p0PaT9lWD7ogyDzym4XNXvECkG7+BeCOaIGEenHWhxcRUOkQdt73GEdY
    Y9n8j9vBtXxxUtZXr8tpdea5WjQMdFDGv9gGEKVOT1ntKi/L67AbnOYeYorcdKCE
    m10C/IolpAGGSd863tJfOVjJNwEHq+PwKOXSM9bCQrr/hw2JLBg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934553AbeB1QP3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:15:29 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35179 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934622AbeB1QP1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:27 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@imgtec.com>, kvm@vger.kernel.org,
        "James Hogan" <james.hogan@imgtec.com>,
        "Gleb Natapov" <gleb@kernel.org>, linux-mips@linux-mips.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.231882522@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 093/254] MIPS: Clear [MSA]FPE CSR.Cause after
 notify_die()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 64bedffe496820dbb6b53302d80dd0f04db33d8e upstream.

When handling floating point exceptions (FPEs) and MSA FPEs the Cause
bits of the appropriate control and status register (FCSR for FPEs and
MSACSR for MSA FPEs) are read and cleared before enabling interrupts,
presumably so that it doesn't have to go through the pain of restoring
those bits if the process is pre-empted, since writing those bits would
cause another immediate exception while still in the kernel.

The bits aren't normally ever restored again, since userland never
expects to see them set.

However for virtualisation it is necessary for the kernel to be able to
restore these Cause bits, as the guest may have been interrupted in an
FP exception handler but before it could read the Cause bits. This can
be done by registering a die notifier, to get notified of the exception
when such a value is restored, and if the PC was at the instruction
which is used to restore the guest state, the handler can step over it
and continue execution. The Cause bits can then remain set without
causing further exceptions.

For this to work safely a few changes are made:
- __build_clear_fpe and __build_clear_msa_fpe no longer clear the Cause
  bits, and now return from exception level with interrupts disabled
  instead of enabled.
- do_fpe() now clears the Cause bits and enables interrupts after
  notify_die() is called, so that the notifier can chose to return from
  exception without this happening.
- do_msa_fpe() acts similarly, but now actually makes use of the second
  argument (msacsr) and calls notify_die() with the new DIE_MSAFP,
  allowing die notifiers to be informed of MSA FPEs too.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/kdebug.h |  3 ++-
 arch/mips/kernel/genex.S       | 14 ++++----------
 arch/mips/kernel/traps.c       | 16 +++++++++++++++-
 3 files changed, 21 insertions(+), 12 deletions(-)

--- a/arch/mips/include/asm/kdebug.h
+++ b/arch/mips/include/asm/kdebug.h
@@ -10,7 +10,8 @@ enum die_val {
 	DIE_RI,
 	DIE_PAGE_FAULT,
 	DIE_BREAK,
-	DIE_SSTEPBP
+	DIE_SSTEPBP,
+	DIE_MSAFP
 };
 
 #endif /* _ASM_MIPS_KDEBUG_H */
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -360,21 +360,15 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	.set	mips1
 	SET_HARDFLOAT
 	cfc1	a1, fcr31
-	li	a2, ~(0x3f << 12)
-	and	a2, a1
-	ctc1	a2, fcr31
 	.set	pop
-	TRACE_IRQS_ON
-	STI
+	CLI
+	TRACE_IRQS_OFF
 	.endm
 
 	.macro	__build_clear_msa_fpe
 	_cfcmsa	a1, MSA_CSR
-	li	a2, ~(0x3f << 12)
-	and	a1, a1, a2
-	_ctcmsa	MSA_CSR, a1
-	TRACE_IRQS_ON
-	STI
+	CLI
+	TRACE_IRQS_OFF
 	.endm
 
 	.macro	__build_clear_ade
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -744,6 +744,11 @@ asmlinkage void do_fpe(struct pt_regs *r
 	if (notify_die(DIE_FP, "FP exception", regs, 0, regs_to_trapnr(regs),
 		       SIGFPE) == NOTIFY_STOP)
 		goto out;
+
+	/* Clear FCSR.Cause before enabling interrupts */
+	write_32bit_cp1_register(CP1_STATUS, fcr31 & ~FPU_CSR_ALL_X);
+	local_irq_enable();
+
 	die_if_kernel("FP exception in kernel code", regs);
 
 	if (fcr31 & FPU_CSR_UNI_X) {
@@ -1295,13 +1300,22 @@ out:
 	exception_exit(prev_state);
 }
 
-asmlinkage void do_msa_fpe(struct pt_regs *regs)
+asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
 {
 	enum ctx_state prev_state;
 
 	prev_state = exception_enter();
+	if (notify_die(DIE_MSAFP, "MSA FP exception", regs, 0,
+		       regs_to_trapnr(regs), SIGFPE) == NOTIFY_STOP)
+		goto out;
+
+	/* Clear MSACSR.Cause before enabling interrupts */
+	write_msa_csr(msacsr & ~MSA_CSR_CAUSEF);
+	local_irq_enable();
+
 	die_if_kernel("do_msa_fpe invoked from kernel context!", regs);
 	force_sig(SIGFPE, current);
+out:
 	exception_exit(prev_state);
 }
 

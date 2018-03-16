Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214387-2-7701796483676882280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214386; b=or0EZgQg3RASaguOet4DHl0rrcpjSz4esDdbu9HeIgD9qZE
    oNkmMouC9rJg/tfIOglCYTTt+wfojyPna+ezCaO/8SrzL5qBdUs6rH1NFAjkQhn+
    lJhf4AuHYG3/bsKy2zVKoCLbqRToqOUknuDmISCkyR7cWyUiv4pKMtGMhE7vFdD4
    W4d4GNhDjkEtG9vc5w7WM6fdjHn+03+y78l2HSaehwVew/QFmunhOJhCVB59koYU
    AN81GkX/XDOQNQ2O7ANyKh3JQWOzWDwmlLIVbRs2oF46epDt5GNZb2xiH+Ul0Wzp
    UpYI/FW8JUlKY3cbEitdYQ5vYS3O8rF2d5djWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214386; bh=40kHv4yOERG/CTDyfV+2l0DNXr
    i06Jrph0BLv6EkgKg=; b=SrJ6ksatXul1UO2MVxaDTA2Ra0V9cP/ZPEncNRc8yX
    P1WKT/MV6CI6YembSEudX2WAA2xpIz4sU8rEcaWSGIZbZkGZplwcxzMRO61weNgU
    MMVSsBn41FuynMpoHqVvm9UYtDQw9LtNVYZIPlXWCOqQ+3o4vX8kIlGYqHbPG78V
    J5jGJrZbYOxvBBrih3ZMfqxAKCBiEJ5jiFkpKk7Wd6GW7eJzDxdjggD3bQrumpXH
    JjJtqI9Osn2CqYDWzdE9YOGnu1LExLOO0GKguzzxrfqrwZ5nMOa55vK2aBDU45Lm
    AL5GWE6HUCf3Oc4RZro6EkFyAdopqdkt7sSrL0qTRU/A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933312AbeCPPdD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:33:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933619AbeCPPdA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:33:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 46/86] x86/paravirt, objtool: Annotate indirect calls
Date: Fri, 16 Mar 2018 16:23:09 +0100
Message-Id: <20180316152320.543336403@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit 3010a0663fd949d122eca0561b06b0a9453f7866 upstream.

Paravirt emits indirect calls which get flagged by objtool retpoline
checks, annotate it away because all these indirect calls will be
patched out before we start userspace.

This patching happens through alternative_instructions() ->
apply_paravirt() -> pv_init_ops.patch() which will eventually end up
in paravirt_patch_default(). This function _will_ write direct
alternatives.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/paravirt.h       |   16 ++++++++++++----
 arch/x86/include/asm/paravirt_types.h |    5 ++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -6,6 +6,7 @@
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
+#include <asm/nospec-branch.h>
 
 #include <asm/paravirt_types.h>
 
@@ -869,23 +870,27 @@ extern void default_banner(void);
 
 #define INTERRUPT_RETURN						\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret), CLBR_NONE,	\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret))
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret);)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable), clobbers, \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable), clobbers,	\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
 		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #ifdef CONFIG_X86_32
 #define GET_CR0_INTO_EAX				\
 	push %ecx; push %edx;				\
+	ANNOTATE_RETPOLINE_SAFE;				\
 	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
 	pop %edx; pop %ecx
 #else	/* !CONFIG_X86_32 */
@@ -907,11 +912,13 @@ extern void default_banner(void);
  */
 #define SWAPGS								\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), CLBR_NONE,	\
-		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs)		\
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs);		\
 		 )
 
 #define GET_CR2_INTO_RAX				\
-	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2)
+	ANNOTATE_RETPOLINE_SAFE;				\
+	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2);
 
 #define PARAVIRT_ADJUST_EXCEPTION_FRAME					\
 	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_adjust_exception_frame), \
@@ -921,7 +928,8 @@ extern void default_banner(void);
 #define USERGS_SYSRET64							\
 	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
 		  CLBR_NONE,						\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64))
+		  ANNOTATE_RETPOLINE_SAFE;					\
+		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64);)
 #endif	/* CONFIG_X86_32 */
 
 #endif /* __ASSEMBLY__ */
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -42,6 +42,7 @@
 #include <asm/desc_defs.h>
 #include <asm/kmap_types.h>
 #include <asm/pgtable_types.h>
+#include <asm/nospec-branch.h>
 
 struct page;
 struct thread_struct;
@@ -391,7 +392,9 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
-#define PARAVIRT_CALL	"call *%c[paravirt_opptr];"
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt

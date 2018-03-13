Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955689-2-8726869305117950918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520955689; b=DH0T4ECELJFnXpDcSt43w/ftu4IWKORr6qOPH6qy1rgFuA6
    8rxqAEYHBKPRWiUIgzoXecCvtiUeB+b1v5sf3WGa9kr92vB9AiJw0F5OkPH63U96
    JWsFkHNtmx7O30xQM2wmSfwCYSfhNoaDGCl2qUFHdPL1K20SInajoR5++9nHM76L
    pii3ruk7DFSLkj/fPxvZB9oQ0IsEEcOJjuElp/eba63tO7VB3/CGpUycZLOIrMF6
    NfvYUyocQMtoMfJzl3/Qt32AayKHPiHvIQEKEI5JVGwY2iLQGpgeYvOS0HFORvGm
    tWpkVWFvY4dFdTJZbH+guie2jtj3yP05WAQRJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955689; bh=bQKjSmF9rcBBcOEsA6WckxktE9
    T1R5M44FN8ahRlGgY=; b=kvx5pPea51b1I8N0bV+hRx9hsQS3dVUOuY9dGiUb+S
    py8+BN0zqD8iE3o5/M2ZaUw8XcoEHOH8yzT3BFFWW8Udl5HfWCh3LlZXKlqkpoYW
    SL9lPkSKO32Cs7+xYgbB2UBHqPY6gTKdyHu3reRwX76cd3ru2vJYnFrJ+g9lqrwS
    r2o3hhaQp6SmRiiikac7/un1eWK5P1HAKhLPEdciCZcqzSEo0Cgc9BTacUOpj8nB
    RKu+un/4vOWKWcR8hYqLKEVpaQBFUYM0eXAMqS2SUucqolV9DcapkjVl24XmRZP9
    ceBUsdhIaFYPRJ2z5/ZfFno8ZBnP9eYNiSf80I/78nHQ==
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
        id S934570AbeCMPlY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:41:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934398AbeCMPlW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:41:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        arjan.van.de.ven@intel.com, bp@alien8.de, dave.hansen@intel.com,
        jmattson@google.com, karahmed@amazon.de, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 124/140] x86/speculation: Use IBRS if available before calling into firmware
Date: Tue, 13 Mar 2018 16:25:27 +0100
Message-Id: <20180313152506.499694976@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit dd84441a797150dcc49298ec95c459a8891d8bb1 upstream.

Retpoline means the kernel is safe because it has no indirect branches.
But firmware isn't, so use IBRS for firmware calls if it's available.

Block preemption while IBRS is set, although in practice the call sites
already had to be doing that.

Ignore hpwdt.c for now. It's taking spinlocks and calling into firmware
code, from an NMI handler. I don't want to touch that with a bargepole.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: arjan.van.de.ven@intel.com
Cc: bp@alien8.de
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Link: http://lkml.kernel.org/r/1519037457-7643-2-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/apm.h           |    6 +++++
 arch/x86/include/asm/cpufeatures.h   |    1 
 arch/x86/include/asm/efi.h           |   17 +++++++++++++--
 arch/x86/include/asm/nospec-branch.h |   39 ++++++++++++++++++++++++++---------
 arch/x86/kernel/cpu/bugs.c           |   12 +++++++++-
 5 files changed, 63 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/apm.h
+++ b/arch/x86/include/asm/apm.h
@@ -7,6 +7,8 @@
 #ifndef _ASM_X86_MACH_DEFAULT_APM_H
 #define _ASM_X86_MACH_DEFAULT_APM_H
 
+#include <asm/nospec-branch.h>
+
 #ifdef APM_ZERO_SEGS
 #	define APM_DO_ZERO_SEGS \
 		"pushl %%ds\n\t" \
@@ -32,6 +34,7 @@ static inline void apm_bios_call_asm(u32
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -44,6 +47,7 @@ static inline void apm_bios_call_asm(u32
 		  "=S" (*esi)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 }
 
 static inline bool apm_bios_call_simple_asm(u32 func, u32 ebx_in,
@@ -56,6 +60,7 @@ static inline bool apm_bios_call_simple_
 	 * N.B. We do NOT need a cld after the BIOS call
 	 * because we always save and restore the flags.
 	 */
+	firmware_restrict_branch_speculation_start();
 	__asm__ __volatile__(APM_DO_ZERO_SEGS
 		"pushl %%edi\n\t"
 		"pushl %%ebp\n\t"
@@ -68,6 +73,7 @@ static inline bool apm_bios_call_simple_
 		  "=S" (si)
 		: "a" (func), "b" (ebx_in), "c" (ecx_in)
 		: "memory", "cc");
+	firmware_restrict_branch_speculation_end();
 	return error;
 }
 
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -211,6 +211,7 @@
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
 
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
+#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -6,6 +6,7 @@
 #include <asm/pgtable.h>
 #include <asm/processor-flags.h>
 #include <asm/tlb.h>
+#include <asm/nospec-branch.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -36,8 +37,18 @@
 
 extern asmlinkage unsigned long efi_call_phys(void *, ...);
 
-#define arch_efi_call_virt_setup()	kernel_fpu_begin()
-#define arch_efi_call_virt_teardown()	kernel_fpu_end()
+#define arch_efi_call_virt_setup()					\
+({									\
+	kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
+})
+
+#define arch_efi_call_virt_teardown()					\
+({									\
+	firmware_restrict_branch_speculation_end();			\
+	kernel_fpu_end();						\
+})
+
 
 /*
  * Wrap all the virtual calls in a way that forces the parameters on the stack.
@@ -73,6 +84,7 @@ struct efi_scratch {
 	efi_sync_low_kernel_mappings();					\
 	preempt_disable();						\
 	__kernel_fpu_begin();						\
+	firmware_restrict_branch_speculation_start();			\
 									\
 	if (efi_scratch.use_pgd) {					\
 		efi_scratch.prev_cr3 = __read_cr3();			\
@@ -91,6 +103,7 @@ struct efi_scratch {
 		__flush_tlb_all();					\
 	}								\
 									\
+	firmware_restrict_branch_speculation_end();			\
 	__kernel_fpu_end();						\
 	preempt_enable();						\
 })
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -219,17 +219,38 @@ static inline void vmexit_fill_RSB(void)
 #endif
 }
 
+#define alternative_msr_write(_msr, _val, _feature)		\
+	asm volatile(ALTERNATIVE("",				\
+				 "movl %[msr], %%ecx\n\t"	\
+				 "movl %[val], %%eax\n\t"	\
+				 "movl $0, %%edx\n\t"		\
+				 "wrmsr",			\
+				 _feature)			\
+		     : : [msr] "i" (_msr), [val] "i" (_val)	\
+		     : "eax", "ecx", "edx", "memory")
+
 static inline void indirect_branch_prediction_barrier(void)
 {
-	asm volatile(ALTERNATIVE("",
-				 "movl %[msr], %%ecx\n\t"
-				 "movl %[val], %%eax\n\t"
-				 "movl $0, %%edx\n\t"
-				 "wrmsr",
-				 X86_FEATURE_USE_IBPB)
-		     : : [msr] "i" (MSR_IA32_PRED_CMD),
-			 [val] "i" (PRED_CMD_IBPB)
-		     : "eax", "ecx", "edx", "memory");
+	alternative_msr_write(MSR_IA32_PRED_CMD, PRED_CMD_IBPB,
+			      X86_FEATURE_USE_IBPB);
+}
+
+/*
+ * With retpoline, we must use IBRS to restrict branch prediction
+ * before calling into firmware.
+ */
+static inline void firmware_restrict_branch_speculation_start(void)
+{
+	preempt_disable();
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
+			      X86_FEATURE_USE_IBRS_FW);
+}
+
+static inline void firmware_restrict_branch_speculation_end(void)
+{
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
+			      X86_FEATURE_USE_IBRS_FW);
+	preempt_enable();
 }
 
 #endif /* __ASSEMBLY__ */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -300,6 +300,15 @@ retpoline_auto:
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
 		pr_info("Spectre v2 mitigation: Enabling Indirect Branch Prediction Barrier\n");
 	}
+
+	/*
+	 * Retpoline means the kernel is safe because it has no indirect
+	 * branches. But firmware isn't, so use IBRS to protect that.
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBRS)) {
+		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
+		pr_info("Enabling Restricted Speculation for firmware calls\n");
+	}
 }
 
 #undef pr_fmt
@@ -326,8 +335,9 @@ ssize_t cpu_show_spectre_v2(struct devic
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return sprintf(buf, "Not affected\n");
 
-	return sprintf(buf, "%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+	return sprintf(buf, "%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 		       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
+		       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 		       spectre_v2_module_string());
 }
 #endif

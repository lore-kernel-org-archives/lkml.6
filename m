Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519833367-2-1218576694130385172
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
    t=1519833366; b=dRyWZhFM4A5PTJeJVsnpiCfiV7A0LVdiLQ0zxq/ENWW3YzS
    pdwm7zNuhqkAw+ZAL+YTnnbOtSIDDvZ2yhHzyHlQXHRnojULT4C76slulskk+X5u
    zssDiYwdt77etqYCcvcdMLcx2eE7CciYQ7uAAtGybI8fS1NYhkdClzdr6p4HMIb2
    XUkVi1YXyhc3B2hxxsABxLb1YhsKhjnFaKq5utvDkZpiD9JxflRDRY2wrTwHfYe1
    /KbthyXvRhIZvxWNf/0L1Em8+uxugTBy5L5eUv2X6ranaIyhQKYarzjrcGgVaecg
    Q2I2cMBrKzy7ovHL4r9/EjumT6SOLTwt9X4LhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833366; bh=bR+nqPs6KxOgxOuEPXj
    GHa5PtvF9Jk+F8BJQ1795Yk0=; b=U5KHolknQLl22O8KTJDlGfFebFU/9DMkzi+
    iYSMefY0M6M+fCPh6qw1nDnvGjCmOjBbtQKzWtrHCdhwyONuvA8pPuWrrktTrado
    AkU79E1zYyAAmOFEGeVmjY+cxc88jcXLlhsmJ6/oOpla6Z20XSDD/OCHc6RZdiki
    6PaC3n2gqhoizFHCEi1Lh+jiKOQFKEPkn3M3maVoYXAAywckADYiBYB42M+gyM1r
    dxn6jbQ/swajEcf3GaMfTwcuzjdgcRQPNfSnUJzm2eezJVDttNoCjjrLsto3G5AV
    MXWl0ptJnnlnV0pMM33QoIUJkM8lH4gNJQl0pJog077tPIFHOBw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934076AbeB1Pzu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:55:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34488 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934100AbeB1Pzt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:55:49 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "James Hogan" <james.hogan@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "Alex Smith" <alex@alex-smith.me.uk>,
        "Paul Burton" <Paul.Burton@mips.com>,
        "Dave Martin" <Dave.Martin@arm.com>, linux-mips@linux-mips.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.584476819@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 109/254] MIPS: Fix an FCSR access API regression with
 NT_PRFPREG and MSA
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

From: "Maciej W. Rozycki" <macro@mips.com>

commit be07a6a1188372b6d19a3307ec33211fc9c9439d upstream.

Fix a commit 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for
FP regset") public API regression, then activated by commit 1db1af84d6df
("MIPS: Basic MSA context switching support"), that caused the FCSR
register not to be read or written for CONFIG_CPU_HAS_MSA kernel
configurations (regardless of actual presence or absence of the MSA
feature in a given processor) with ptrace(2) PTRACE_GETREGSET and
PTRACE_SETREGSET requests nor recorded in core dumps.

This is because with !CONFIG_CPU_HAS_MSA configurations the whole of
`elf_fpregset_t' array is bulk-copied as it is, which includes the FCSR
in one half of the last, 33rd slot, whereas with CONFIG_CPU_HAS_MSA
configurations array elements are copied individually, and then only the
leading 32 FGR slots while the remaining slot is ignored.

Correct the code then such that only FGR slots are copied in the
respective !MSA and MSA helpers an then the FCSR slot is handled
separately in common code.  Use `ptrace_setfcr31' to update the FCSR
too, so that the read-only mask is respected.

Retrieving a correct value of FCSR is important in debugging not only
for the human to be able to get the right interpretation of the
situation, but for correct operation of GDB as well.  This is because
the condition code bits in FSCR are used by GDB to determine the
location to place a breakpoint at when single-stepping through an FPU
branch instruction.  If such a breakpoint is placed incorrectly (i.e.
with the condition reversed), then it will be missed, likely causing the
debuggee to run away from the control of GDB and consequently breaking
the process of investigation.

Fortunately GDB continues using the older PTRACE_GETFPREGS ptrace(2)
request which is unaffected, so the regression only really hits with
post-mortem debug sessions using a core dump file, in which case
execution, and consequently single-stepping through branches is not
possible.  Of course core files created by buggy kernels out there will
have the value of FCSR recorded clobbered, but such core files cannot be
corrected and the person using them simply will have to be aware that
the value of FCSR retrieved is not reliable.

Which also means we can likely get away without defining a replacement
API which would ensure a correct value of FSCR to be retrieved, or none
at all.

This is based on previous work by Alex Smith, extensively rewritten.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Signed-off-by: James Hogan <james.hogan@mips.com>
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: 72b22bbad1e7 ("MIPS: Don't assume 64-bit FP registers for FP regset")
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17928/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -441,7 +441,7 @@ static int gpr64_set(struct task_struct
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer,
  * !CONFIG_CPU_HAS_MSA variant.  FP context's general register slots
- * correspond 1:1 to buffer slots.
+ * correspond 1:1 to buffer slots.  Only general registers are copied.
  */
 static int fpr_get_fpa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -449,13 +449,14 @@ static int fpr_get_fpa(struct task_struc
 {
 	return user_regset_copyout(pos, count, kbuf, ubuf,
 				   &target->thread.fpu,
-				   0, sizeof(elf_fpregset_t));
+				   0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
 }
 
 /*
  * Copy the floating-point context to the supplied NT_PRFPREG buffer,
  * CONFIG_CPU_HAS_MSA variant.  Only lower 64 bits of FP context's
- * general register slots are copied to buffer slots.
+ * general register slots are copied to buffer slots.  Only general
+ * registers are copied.
  */
 static int fpr_get_msa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -477,20 +478,29 @@ static int fpr_get_msa(struct task_struc
 	return 0;
 }
 
-/* Copy the floating-point context to the supplied NT_PRFPREG buffer.  */
+/*
+ * Copy the floating-point context to the supplied NT_PRFPREG buffer.
+ * Choose the appropriate helper for general registers, and then copy
+ * the FCSR register separately.
+ */
 static int fpr_get(struct task_struct *target,
 		   const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
+	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
 	int err;
 
-	/* XXX fcr31  */
-
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
 		err = fpr_get_fpa(target, &pos, &count, &kbuf, &ubuf);
 	else
 		err = fpr_get_msa(target, &pos, &count, &kbuf, &ubuf);
+	if (err)
+		return err;
+
+	err = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.fpu.fcr31,
+				  fcr31_pos, fcr31_pos + sizeof(u32));
 
 	return err;
 }
@@ -498,7 +508,7 @@ static int fpr_get(struct task_struct *t
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context,
  * !CONFIG_CPU_HAS_MSA variant.   Buffer slots correspond 1:1 to FP
- * context's general register slots.
+ * context's general register slots.  Only general registers are copied.
  */
 static int fpr_set_fpa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -506,13 +516,14 @@ static int fpr_set_fpa(struct task_struc
 {
 	return user_regset_copyin(pos, count, kbuf, ubuf,
 				  &target->thread.fpu,
-				  0, sizeof(elf_fpregset_t));
+				  0, NUM_FPU_REGS * sizeof(elf_fpreg_t));
 }
 
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context,
  * CONFIG_CPU_HAS_MSA variant.  Buffer slots are copied to lower 64
- * bits only of FP context's general register slots.
+ * bits only of FP context's general register slots.  Only general
+ * registers are copied.
  */
 static int fpr_set_msa(struct task_struct *target,
 		       unsigned int *pos, unsigned int *count,
@@ -537,6 +548,8 @@ static int fpr_set_msa(struct task_struc
 
 /*
  * Copy the supplied NT_PRFPREG buffer to the floating-point context.
+ * Choose the appropriate helper for general registers, and then copy
+ * the FCSR register separately.
  *
  * We optimize for the case where `count % sizeof(elf_fpreg_t) == 0',
  * which is supposed to have been guaranteed by the kernel before
@@ -549,18 +562,30 @@ static int fpr_set(struct task_struct *t
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
 {
+	const int fcr31_pos = NUM_FPU_REGS * sizeof(elf_fpreg_t);
+	u32 fcr31;
 	int err;
 
 	BUG_ON(count % sizeof(elf_fpreg_t));
 
-	/* XXX fcr31  */
-
 	init_fp_ctx(target);
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
 		err = fpr_set_fpa(target, &pos, &count, &kbuf, &ubuf);
 	else
 		err = fpr_set_msa(target, &pos, &count, &kbuf, &ubuf);
+	if (err)
+		return err;
+
+	if (count > 0) {
+		err = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &fcr31,
+					 fcr31_pos, fcr31_pos + sizeof(u32));
+		if (err)
+			return err;
+
+		ptrace_setfcr31(target, fcr31);
+	}
 
 	return err;
 }

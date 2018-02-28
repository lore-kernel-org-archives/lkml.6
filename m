Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519836674-2-4525964472224223750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836673; b=DkX69E1jg7U7pzaUxj57CpSxUb1sJ0fJ2JIDwc8wcFrmbcF
    72R190uLydq8ZaOldTxrrYuzuGsKF8nl4FizxuArXDxdpjPsFUrHcDpRILevEjB+
    7JDp+rzWLl3PNuj0IpbY9jIwdxLXMUuaQC5YmTJ2O7rJUOWx4RURS2W+UIX/7B9C
    //v0HuDbqim+gsDj3W/t9gmWxTan7oNEIizFVd3BT0FrRstQlerueVzQ1CdO6rCO
    lPM2C/ihoQYfvnZcc9Pg/bPmwQJ6M0pRwV/piBXwppb2hu7a/7wVcTFD5/rP0rrU
    3DyADs9DQkT7eolRfvrqaMWE1KOuC/7wdFOHynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836673; bh=sLc/U8dSU8ZMx6Kkjjm
    oqZ7hcm29p38qvP4M8LuOHTQ=; b=DZo0zRdENJg3xmvhu0wfMtMsEZqwcGLMIiu
    s4NudiSHYvwEA1CQ3ioBdzY4emoSG9GpD+IgubjE727QQofFMVPl/Pif7WXtM0Si
    U3NJ4vFYwlo96NIRBulWQaSwB934AONb47pbj/VP/BSas+huEWuoyxNjVw9Yude/
    kEtBk0kDsaPfsGS0XF+M3uabAuO/NqcYXq0qKQ7ywJlqjGJFKH+zmpiHqji37Kc/
    IGSx/l1rKSUYBRIhZ4K5rLsjOzoPjHIywU4eAPI+NvFRiTHB4Z/fG9vDJz1M8znL
    vBJnlRzT8uIOgqpmLaIGpgf6/OWqaateKYARaeYVVvrYw0Wjkcw==
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
        id S1752906AbeB1Quy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:50:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34555 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753005AbeB1P6V (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:21 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.898552173@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 098/254] MIPS: Set `si_code' for SIGFPE signals sent
 from emulation too
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

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 304acb717e5b67cf56f05bc5b21123758e1f7ea0 upstream.

Rework `process_fpemu_return' and move IEEE 754 exception interpretation
there, from `do_fpe'.  Record the cause bits set in FCSR before they are
cleared and pass them through to `process_fpemu_return' so as to set
`si_code' correctly too for SIGFPE signals sent from emulation rather
than those issued by hardware with the FPE processor exception only.

For simplicity `mipsr2_decoder' assumes `*fcr31' has been preinitialised
and only sets it to anything if an FPU instruction has been emulated,
which in turn is the only case SIGFPE can be issued for here.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9705/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16:
 - Drop changes in mips-r2-to-r6-emul and simulate_fp()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -65,7 +65,8 @@ extern int do_dsemulret(struct pt_regs *
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 				    struct mips_fpu_struct *ctx, int has_fpu,
 				    void *__user *fault_addr);
-int process_fpemu_return(int sig, void __user *fault_addr);
+int process_fpemu_return(int sig, void __user *fault_addr,
+			 unsigned long fcr31);
 int mm_isBranchInstr(struct pt_regs *regs, struct mm_decoded_insn dec_insn,
 		     unsigned long *contpc);
 
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -707,29 +707,60 @@ asmlinkage void do_ov(struct pt_regs *re
 	exception_exit(prev_state);
 }
 
-int process_fpemu_return(int sig, void __user *fault_addr)
+int process_fpemu_return(int sig, void __user *fault_addr, unsigned long fcr31)
 {
-	if (sig == SIGSEGV || sig == SIGBUS) {
-		struct siginfo si = {0};
+	struct siginfo si = { 0 };
+
+	switch (sig) {
+	case 0:
+		return 0;
+
+	case SIGFPE:
 		si.si_addr = fault_addr;
 		si.si_signo = sig;
-		if (sig == SIGSEGV) {
-			down_read(&current->mm->mmap_sem);
-			if (find_vma(current->mm, (unsigned long)fault_addr))
-				si.si_code = SEGV_ACCERR;
-			else
-				si.si_code = SEGV_MAPERR;
-			up_read(&current->mm->mmap_sem);
-		} else {
-			si.si_code = BUS_ADRERR;
-		}
+		/*
+		 * Inexact can happen together with Overflow or Underflow.
+		 * Respect the mask to deliver the correct exception.
+		 */
+		fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
+			 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
+		if (fcr31 & FPU_CSR_INV_X)
+			si.si_code = FPE_FLTINV;
+		else if (fcr31 & FPU_CSR_DIV_X)
+			si.si_code = FPE_FLTDIV;
+		else if (fcr31 & FPU_CSR_OVF_X)
+			si.si_code = FPE_FLTOVF;
+		else if (fcr31 & FPU_CSR_UDF_X)
+			si.si_code = FPE_FLTUND;
+		else if (fcr31 & FPU_CSR_INE_X)
+			si.si_code = FPE_FLTRES;
+		else
+			si.si_code = __SI_FAULT;
+		force_sig_info(sig, &si, current);
+		return 1;
+
+	case SIGBUS:
+		si.si_addr = fault_addr;
+		si.si_signo = sig;
+		si.si_code = BUS_ADRERR;
+		force_sig_info(sig, &si, current);
+		return 1;
+
+	case SIGSEGV:
+		si.si_addr = fault_addr;
+		si.si_signo = sig;
+		down_read(&current->mm->mmap_sem);
+		if (find_vma(current->mm, (unsigned long)fault_addr))
+			si.si_code = SEGV_ACCERR;
+		else
+			si.si_code = SEGV_MAPERR;
+		up_read(&current->mm->mmap_sem);
 		force_sig_info(sig, &si, current);
 		return 1;
-	} else if (sig) {
+
+	default:
 		force_sig(sig, current);
 		return 1;
-	} else {
-		return 0;
 	}
 }
 
@@ -739,7 +770,8 @@ int process_fpemu_return(int sig, void _
 asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
 {
 	enum ctx_state prev_state;
-	siginfo_t info = {0};
+	void __user *fault_addr;
+	int sig;
 
 	prev_state = exception_enter();
 	if (notify_die(DIE_FP, "FP exception", regs, 0, regs_to_trapnr(regs),
@@ -753,9 +785,6 @@ asmlinkage void do_fpe(struct pt_regs *r
 	die_if_kernel("FP exception in kernel code", regs);
 
 	if (fcr31 & FPU_CSR_UNI_X) {
-		int sig;
-		void __user *fault_addr = NULL;
-
 		/*
 		 * Unimplemented operation exception.  If we've got the full
 		 * software emulator on-board, let's use it...
@@ -772,6 +801,7 @@ asmlinkage void do_fpe(struct pt_regs *r
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
 					       &fault_addr);
+		fcr31 = current->thread.fpu.fcr31;
 
 		/*
 		 * We can't allow the emulated instruction to leave any of
@@ -781,35 +811,13 @@ asmlinkage void do_fpe(struct pt_regs *r
 
 		/* Restore the hardware register state */
 		own_fpu(1);	/* Using the FPU again.	 */
-
-		/* If something went wrong, signal */
-		process_fpemu_return(sig, fault_addr);
-
-		goto out;
+	} else {
+		sig = SIGFPE;
+		fault_addr = (void __user *) regs->cp0_epc;
 	}
 
-	/*
-	 * Inexact can happen together with Overflow or Underflow.
-	 * Respect the mask to deliver the correct exception.
-	 */
-	fcr31 &= (fcr31 & FPU_CSR_ALL_E) <<
-		 (ffs(FPU_CSR_ALL_X) - ffs(FPU_CSR_ALL_E));
-	if (fcr31 & FPU_CSR_INV_X)
-		info.si_code = FPE_FLTINV;
-	else if (fcr31 & FPU_CSR_DIV_X)
-		info.si_code = FPE_FLTDIV;
-	else if (fcr31 & FPU_CSR_OVF_X)
-		info.si_code = FPE_FLTOVF;
-	else if (fcr31 & FPU_CSR_UDF_X)
-		info.si_code = FPE_FLTUND;
-	else if (fcr31 & FPU_CSR_INE_X)
-		info.si_code = FPE_FLTRES;
-	else
-		info.si_code = __SI_FAULT;
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_addr = (void __user *) regs->cp0_epc;
-	force_sig_info(SIGFPE, &info, current);
+	/* Send a signal if required.  */
+	process_fpemu_return(sig, fault_addr, fcr31);
 
 out:
 	exception_exit(prev_state);
@@ -1210,10 +1218,13 @@ asmlinkage void do_cpu(struct pt_regs *r
 	enum ctx_state prev_state;
 	unsigned int __user *epc;
 	unsigned long old_epc, old31;
+	void __user *fault_addr;
 	unsigned int opcode;
+	unsigned long fcr31;
 	unsigned int cpid;
 	int status, err;
 	unsigned long __maybe_unused flags;
+	int sig;
 
 	prev_state = exception_enter();
 	cpid = (regs->cp0_cause >> CAUSEB_CE) & 3;
@@ -1286,22 +1297,22 @@ asmlinkage void do_cpu(struct pt_regs *r
 	case 1:
 		err = enable_restore_fp_context(0);
 
-		if (!raw_cpu_has_fpu || err) {
-			int sig;
-			void __user *fault_addr = NULL;
-			sig = fpu_emulator_cop1Handler(regs,
-						       &current->thread.fpu,
-						       0, &fault_addr);
-
-			/*
-			 * We can't allow the emulated instruction to leave
-			 * any of the cause bits set in $fcr31.
-			 */
-			current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+		if (raw_cpu_has_fpu && !err)
+			break;
 
-			if (!process_fpemu_return(sig, fault_addr) && !err)
-				mt_ase_fp_affinity();
-		}
+		sig = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 0,
+					       &fault_addr);
+		fcr31 = current->thread.fpu.fcr31;
+
+		/*
+		 * We can't allow the emulated instruction to leave
+		 * any of the cause bits set in $fcr31.
+		 */
+		current->thread.fpu.fcr31 &= ~FPU_CSR_ALL_X;
+
+		/* Send a signal if required.  */
+		if (!process_fpemu_return(sig, fault_addr, fcr31) && !err)
+			mt_ase_fp_affinity();
 
 		goto out;
 
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -697,7 +697,7 @@ static void emulate_load_store_insn(stru
 		own_fpu(1);	/* Restore FPU state. */
 
 		/* Signal if something went wrong. */
-		process_fpemu_return(res, fault_addr);
+		process_fpemu_return(res, fault_addr, 0);
 
 		if (res == 0)
 			break;
@@ -1129,7 +1129,7 @@ fpu_emul:
 		own_fpu(1);	/* restore FPU state */
 
 		/* If something went wrong, signal */
-		process_fpemu_return(res, fault_addr);
+		process_fpemu_return(res, fault_addr, 0);
 
 		if (res == 0)
 			goto success;

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-356304-1524840520-3-2221600959527309902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840520; b=RScEW/IpSjeBtpfzxwSYlV/hm6VpGcMhy8m8/pA3+fEmePMYFy
    FX7vq+KJ9QUvQslK60TorBBPZB1wPrBp20hadb9Th/Oa41z8eSvyd+iSXNmho6b2
    s3hoZTaP3vjOq/JR77UWTskliYNH6+tmi2e5NN+uIJVDlCcxomhFmQKkYc/8MR7O
    hLCgeRxtHS0FDJdYpIGknaPIncJiXNmEtA1JcGJaPr1EdPQ6vhvFypDOKObMbI2g
    myfRXvR/lMxOfRFjGR/lceUwXYqEx/jWvw0oHF+F+8M7mrH+p3X5L9tW69am0Gx2
    3jK4D0FI2Cx/c+BOPU8ppYjl6IJItlneSdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840520; bh=MoCYSEVD8HahoSUm7u6GPfUXZqtkEx
    h7/oO1kdFr2i4=; b=R/8AuxSecf9mr4A8tSt2QcBxZvw73k6gJc9H94RkBKiik6
    v+BdCHDrs5JSSzGeaOmpd3udOn4V+/mO0TJsfaFNZm5qpaxzAWjEGRo2v5OSh5Nq
    ywYVDrW3jk4qoAp67THx66od3an8E74l4yJ1IT5mie7KDQ5r+Ii4SAdl2PujmOZ5
    G4qt1r/cvnQW4me/2SHjevzYtmaICvzY0SgG5OQf4b631MWwe1M24CqdYbelQ/eK
    Q4njslxbPBIVVDJFFV99IrYYGUB7xXPnUC4196KiLkKLIi23wTtXWisMKXKjC9dz
    luWPLhvbNamB9gXOczASkHMqXt4M+iRu/H2XyMSA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAUgm8s+6V7zSFnO/WnlvSmr4cVXAD1SdP4DdaT/PUdQhs303G0SR7gM9uxE31bL/3HEgBqoei9LVRqu4BIx3Z++0EoyVXYlo5rqcJLTcRuwW+KEApVE
    WtOTmO6EV4EkJS+RJt28OxtAM8BDDBF615UAXvvd6nGA6/xM82Zr3I3/WWUX1ugR/EYHKpDOD2g0jDeq9Tkn22eN6+ipf+uV0hESl/AuRjh6SXhEjBBjxJLR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=k9N_42FktrODzxzmMIkA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933868AbeD0Ork (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934343AbeD0OHo (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A584C218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.14 48/80] s390: add options to change branch prediction behaviour for the kernel
Date: Fri, 27 Apr 2018 15:58:41 +0200
Message-Id: <20180427135735.397722494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit d768bd892fc8f066cd3aa000eb1867bcf32db0ee ]

Add the PPA instruction to the system entry and exit path to switch
the kernel to a different branch prediction behaviour. The instructions
are added via CPU alternatives and can be disabled with the "nospec"
or the "nobp=0" kernel parameter. If the default behaviour selected
with CONFIG_KERNEL_NOBP is set to "n" then the "nobp=1" parameter can be
used to enable the changed kernel branch prediction.

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                 |   17 +++++++++++++
 arch/s390/include/asm/processor.h |    1 
 arch/s390/kernel/alternative.c    |   23 ++++++++++++++++++
 arch/s390/kernel/early.c          |    2 +
 arch/s390/kernel/entry.S          |   48 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/ipl.c            |    1 
 arch/s390/kernel/smp.c            |    2 +
 7 files changed, 94 insertions(+)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -538,6 +538,23 @@ config ARCH_RANDOM
 
 	  If unsure, say Y.
 
+config KERNEL_NOBP
+	def_bool n
+	prompt "Enable modified branch prediction for the kernel by default"
+	help
+	  If this option is selected the kernel will switch to a modified
+	  branch prediction mode if the firmware interface is available.
+	  The modified branch prediction mode improves the behaviour in
+	  regard to speculative execution.
+
+	  With the option enabled the kernel parameter "nobp=0" or "nospec"
+	  can be used to run the kernel in the normal branch prediction mode.
+
+	  With the option disabled the modified branch prediction mode is
+	  enabled with the "nobp=1" kernel parameter.
+
+	  If unsure, say N.
+
 endmenu
 
 menu "Memory setup"
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -89,6 +89,7 @@ void cpu_detect_mhz_feature(void);
 extern const struct seq_operations cpuinfo_op;
 extern int sysctl_ieee_emulation_warnings;
 extern void execve_tail(void);
+extern void __bpon(void);
 
 /*
  * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -14,6 +14,29 @@ static int __init disable_alternative_in
 
 early_param("noaltinstr", disable_alternative_instructions);
 
+static int __init nobp_setup_early(char *str)
+{
+	bool enabled;
+	int rc;
+
+	rc = kstrtobool(str, &enabled);
+	if (rc)
+		return rc;
+	if (enabled && test_facility(82))
+		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
+	else
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nobp", nobp_setup_early);
+
+static int __init nospec_setup_early(char *str)
+{
+	__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	return 0;
+}
+early_param("nospec", nospec_setup_early);
+
 struct brcl_insn {
 	u16 opc;
 	s32 disp;
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -332,6 +332,8 @@ static noinline __init void setup_facili
 	memcpy(S390_lowcore.alt_stfle_fac_list,
 	       S390_lowcore.stfle_fac_list,
 	       sizeof(S390_lowcore.alt_stfle_fac_list));
+	if (!IS_ENABLED(CONFIG_KERNEL_NOBP))
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
 }
 
 static __init void detect_diag9c(void)
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -158,6 +158,34 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCAL
 		tm	off+\addr, \mask
 	.endm
 
+	.macro BPOFF
+	.pushsection .altinstr_replacement, "ax"
+660:	.long	0xb2e8c000
+	.popsection
+661:	.long	0x47000000
+	.pushsection .altinstructions, "a"
+	.long 661b - .
+	.long 660b - .
+	.word 82
+	.byte 4
+	.byte 4
+	.popsection
+	.endm
+
+	.macro BPON
+	.pushsection .altinstr_replacement, "ax"
+662:	.long	0xb2e8d000
+	.popsection
+663:	.long	0x47000000
+	.pushsection .altinstructions, "a"
+	.long 663b - .
+	.long 662b - .
+	.word 82
+	.byte 4
+	.byte 4
+	.popsection
+	.endm
+
 	.section .kprobes.text, "ax"
 .Ldummy:
 	/*
@@ -170,6 +198,11 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCAL
 	 */
 	nop	0
 
+ENTRY(__bpon)
+	.globl __bpon
+	BPON
+	br	%r14
+
 /*
  * Scheduler resume function, called by switch_to
  *  gpr2 = (task_struct *) prev
@@ -226,8 +259,11 @@ ENTRY(sie64a)
 	jnz	.Lsie_skip
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lsie_skip			# exit if fp/vx regs changed
+	BPON
 .Lsie_entry:
 	sie	0(%r14)
+.Lsie_exit:
+	BPOFF
 .Lsie_skip:
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
@@ -279,6 +315,7 @@ ENTRY(system_call)
 	stpt	__LC_SYNC_ENTER_TIMER
 .Lsysc_stmg:
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
+	BPOFF
 	lg	%r12,__LC_CURRENT
 	lghi	%r13,__TASK_thread
 	lghi	%r14,_PIF_SYSCALL
@@ -325,6 +362,7 @@ ENTRY(system_call)
 	jnz	.Lsysc_work			# check for work
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lsysc_work
+	BPON
 .Lsysc_restore:
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
@@ -522,6 +560,7 @@ ENTRY(kernel_thread_starter)
 
 ENTRY(pgm_check_handler)
 	stpt	__LC_SYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_CURRENT
@@ -626,6 +665,7 @@ ENTRY(pgm_check_handler)
 ENTRY(io_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
@@ -676,9 +716,13 @@ ENTRY(io_int_handler)
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
+	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
+	jno	.Lio_exit_kernel
+	BPON
 .Lio_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
+.Lio_exit_kernel:
 	lmg	%r11,%r15,__PT_R11(%r11)
 	lpswe	__LC_RETURN_PSW
 .Lio_done:
@@ -841,6 +885,7 @@ ENTRY(io_int_handler)
 ENTRY(ext_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r12,__LC_CURRENT
 	larl	%r13,cleanup_critical
@@ -889,6 +934,7 @@ ENTRY(psw_idle)
 .Lpsw_idle_stcctm:
 #endif
 	oi	__LC_CPU_FLAGS+7,_CIF_ENABLED_WAIT
+	BPON
 	STCK	__CLOCK_IDLE_ENTER(%r2)
 	stpt	__TIMER_IDLE_ENTER(%r2)
 .Lpsw_idle_lpsw:
@@ -989,6 +1035,7 @@ load_fpu_regs:
  */
 ENTRY(mcck_int_handler)
 	STCK	__LC_MCCK_CLOCK
+	BPOFF
 	la	%r1,4095		# revalidate r1
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
@@ -1054,6 +1101,7 @@ ENTRY(mcck_int_handler)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
 	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
 	jno	0f
+	BPON
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 0:	lmg	%r11,%r15,__PT_R11(%r11)
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -564,6 +564,7 @@ static struct kset *ipl_kset;
 
 static void __ipl_run(void *unused)
 {
+	__bpon();
 	diag308(DIAG308_LOAD_CLEAR, NULL);
 	if (MACHINE_IS_VM)
 		__cpcmd("IPL", NULL, 0, NULL);
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -334,6 +334,7 @@ static void pcpu_delegate(struct pcpu *p
 	mem_assign_absolute(lc->restart_fn, (unsigned long) func);
 	mem_assign_absolute(lc->restart_data, (unsigned long) data);
 	mem_assign_absolute(lc->restart_source, source_cpu);
+	__bpon();
 	asm volatile(
 		"0:	sigp	0,%0,%2	# sigp restart to target cpu\n"
 		"	brc	2,0b	# busy, try again\n"
@@ -909,6 +910,7 @@ void __cpu_die(unsigned int cpu)
 void __noreturn cpu_die(void)
 {
 	idle_task_exit();
+	__bpon();
 	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), SIGP_STOP, 0);
 	for (;;) ;
 }

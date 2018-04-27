Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-380590-1524842068-2-14518318414914251927
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
    1524842067; b=HQlaDzcz6Bi0ZyElts03sAOBR1asmJr+uPsNOoBNUp5wl9lyD1
    leOJRhwvHL7/ow2pY9ijBZDQUW9pJnUdARISFOMMpKNw3W4yK6KDUDGiTAhldtUR
    KA4i5agsNlKKpe1du99125tk1LXG9G7l5zf1Je2dJpY1g2ipvp6Y+Tj3gr8vwfqp
    k2suTbl86HntvPc1xMtNKyhKw3AD/CjW23ncGtM3SkxjiVuPVzXsXOa89n8k6yfd
    t78ua5PBxBL5Uaj4PpG8bVLKvtlRqxcUvo+V+VEMV8SNa/bz2GctM9WxiwXMC7Wr
    pXDnfmYv5T+f50Mv1qzsxEZrVt7jvpEJ4UMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524842067; bh=4BJzIJiZ8fMrXRG3/9QPEo7a0+iQJf
    sw4try5urksFI=; b=gkiUWwz2YxlWAUPBiYNlgvS8Z78ZMiHPHZ6Nh5vZMerIQg
    t5tTN9nUB8MWx8VLI2lLCAt53MASA6KAY3ZIhVeJBwsIEXeFG2uG/03+Uknq0MwC
    x7DniXbGM+1ibagMdItKduB2WaN+vBQQ+LShv/X1HQ2TXUT6vX/zGhD6FKNQgqC8
    KGIPenT7qTnQSuoOhDWriCG4ShYnkiYGW0XQSXgu2LfFEQXIE749lAf9I+J5MwQn
    TuIYSaY0Jw9XvtE1OdPwqQaLW6FvvEtyc2AMq7TKEacKXx0O5cC8Le4iUPhS8LIs
    JxJrqKyru+qvC4r4k/xgnDSKWcSJvtQitXZbcyIg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfLlP/YV/794SlxdUpRolC5vcsjBserzEvznGS6oy/7bChdIuAhcIO2pNDH6MhxrsyetHLyEzvOkRrsxVMfgJfnM9/jGICVdCKR4gZZtVr8ZZL7LjRyjc
    xUsmlN85qaHLL0bQ7QoJ6Q57qAdObEEZQQcFI9/lkpi+3/cZIYTJ5FREhmi9/JKLlo6GTgNp1MHBgMQFSlWkA3qmkf4AII5vJqx2IA7OZA4u2wpsQHSQv2oX
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=k9N_42FktrODzxzmMIkA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933638AbeD0POJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933188AbeD0ODz (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:03:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736CC21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4.9 34/74] s390: add options to change branch prediction behaviour for the kernel
Date: Fri, 27 Apr 2018 15:58:24 +0200
Message-Id: <20180427135711.344105030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
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
@@ -704,6 +704,23 @@ config SECCOMP
 
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
 
 menu "Power Management"
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -84,6 +84,7 @@ void cpu_detect_mhz_feature(void);
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
@@ -302,6 +302,8 @@ static noinline __init void setup_facili
 	memcpy(S390_lowcore.alt_stfle_fac_list,
 	       S390_lowcore.stfle_fac_list,
 	       sizeof(S390_lowcore.alt_stfle_fac_list));
+	if (!IS_ENABLED(CONFIG_KERNEL_NOBP))
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
 }
 
 static __init void detect_diag9c(void)
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -163,6 +163,34 @@ _PIF_WORK	= (_PIF_PER_TRAP)
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
@@ -175,6 +203,11 @@ _PIF_WORK	= (_PIF_PER_TRAP)
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
@@ -234,7 +267,10 @@ ENTRY(sie64a)
 	jnz	.Lsie_skip
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lsie_skip			# exit if fp/vx regs changed
+	BPON
 	sie	0(%r14)
+.Lsie_exit:
+	BPOFF
 .Lsie_skip:
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
@@ -286,6 +322,7 @@ ENTRY(system_call)
 	stpt	__LC_SYNC_ENTER_TIMER
 .Lsysc_stmg:
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
+	BPOFF
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
 	lghi	%r14,_PIF_SYSCALL
@@ -332,6 +369,7 @@ ENTRY(system_call)
 	jnz	.Lsysc_work			# check for work
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lsysc_work
+	BPON
 .Lsysc_restore:
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
@@ -492,6 +530,7 @@ ENTRY(kernel_thread_starter)
 
 ENTRY(pgm_check_handler)
 	stpt	__LC_SYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_SYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
@@ -590,6 +629,7 @@ ENTRY(pgm_check_handler)
 ENTRY(io_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
@@ -641,9 +681,13 @@ ENTRY(io_int_handler)
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
@@ -775,6 +819,7 @@ ENTRY(io_int_handler)
 ENTRY(ext_int_handler)
 	STCK	__LC_INT_CLOCK
 	stpt	__LC_ASYNC_ENTER_TIMER
+	BPOFF
 	stmg	%r8,%r15,__LC_SAVE_AREA_ASYNC
 	lg	%r10,__LC_LAST_BREAK
 	lg	%r12,__LC_THREAD_INFO
@@ -824,6 +869,7 @@ ENTRY(psw_idle)
 .Lpsw_idle_stcctm:
 #endif
 	oi	__LC_CPU_FLAGS+7,_CIF_ENABLED_WAIT
+	BPON
 	STCK	__CLOCK_IDLE_ENTER(%r2)
 	stpt	__TIMER_IDLE_ENTER(%r2)
 .Lpsw_idle_lpsw:
@@ -931,6 +977,7 @@ load_fpu_regs:
  */
 ENTRY(mcck_int_handler)
 	STCK	__LC_MCCK_CLOCK
+	BPOFF
 	la	%r1,4095		# revalidate r1
 	spt	__LC_CPU_TIMER_SAVE_AREA-4095(%r1)	# revalidate cpu timer
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)# revalidate gprs
@@ -997,6 +1044,7 @@ ENTRY(mcck_int_handler)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
 	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
 	jno	0f
+	BPON
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 0:	lmg	%r11,%r15,__PT_R11(%r11)
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -563,6 +563,7 @@ static struct kset *ipl_kset;
 
 static void __ipl_run(void *unused)
 {
+	__bpon();
 	diag308(DIAG308_LOAD_CLEAR, NULL);
 	if (MACHINE_IS_VM)
 		__cpcmd("IPL", NULL, 0, NULL);
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -304,6 +304,7 @@ static void pcpu_delegate(struct pcpu *p
 	mem_assign_absolute(lc->restart_fn, (unsigned long) func);
 	mem_assign_absolute(lc->restart_data, (unsigned long) data);
 	mem_assign_absolute(lc->restart_source, source_cpu);
+	__bpon();
 	asm volatile(
 		"0:	sigp	0,%0,%2	# sigp restart to target cpu\n"
 		"	brc	2,0b	# busy, try again\n"
@@ -877,6 +878,7 @@ void __cpu_die(unsigned int cpu)
 void __noreturn cpu_die(void)
 {
 	idle_task_exit();
+	__bpon();
 	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), SIGP_STOP, 0);
 	for (;;) ;
 }

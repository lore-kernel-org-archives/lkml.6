Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-348652-1524840452-2-16502466213394054291
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
    1524840452; b=krhIRmNwlwzJR+XCA1l3X9IrfENOWA1SPdBrRbqk1G0ZOAAp/R
    JIKliLZB7J/5Hz4vyU5ibPPzlluzwVyzxEhJfXQ09Wv4+59MN+jieCeQ22Cvem/Q
    LkC67oF0FCC56qVghVmAV8nrlzz/UcHu2rjc+eUO4OqMEQOTMZuNBLcf/utpa6m1
    sli9qLz8XQM0e+657qBer4bxbDFau4kWfMphKqB8JoCd5NYqM5Wgm3lSlCqp2yBk
    Rhd6NhJ6V7nCpxUJnMK80NBcxHY4BP3ZH3JOAibK6vvTLFWcdATm6dDo+zeNF1H0
    R0QEWJUr4g9uecuZsA4deAlOxXPBLC4Bzv0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524840452; bh=w7o8hKa+N8etKso2NaMrGG5Ca7CCF4
    wpef8Kd0GVu98=; b=Gjgr00MheiBIUrhX+rekY/P6vPxuasoNgUwhU0Hvz8sLzY
    EGIcpWNxrqBE6wHV9vaCjxc2KB1S/cvGbrcT8DUAL78Xx7tyFB6JiwvFKQoDpUoz
    f24OpwDzuaHHhPrs9nWF6pxjc5H1xVquDxhc2V39EQai0i2OrzdiRhF5PD+c6v06
    f4y5OK1ClhSIWRfkXu4n5+Mb9Wsvc1dL+zHfydCrFd0CMmEaTzgK5yseGxll/FkZ
    wdPbIV1Bpd1CXqSofIoc8VG2OlsrfX+pB2ONhadqe0B1U6rlaTggSRDDneNJw5WY
    dmzdloqIPK/mhWmrCRs8eKmXCQY3DrkkYwrj72xg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfP4dqDKBHPzjJ6QPAMIwcbaVxsTQQs3mNz3vfek8TNfDU5iU4Lpg0jPvGO5E8PhC7aZ+BLlBwkLeCyXsDjy7fEIA3DHsj9tF3adAnxuYcfPuKkQzcmx0
    LaEfiiUE8MCjvxpCU9A0HcQs85X+T9SDCAk2t5ALeFT0RpmWqwi15Ym27DWN0z/dz+mj4pgoWA60K5enLQm91uuveTFB9BzXNHeBra1sXEVsnrpP4/wLhM1Q
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=sUgPWT0P8X_Y-FyYdoAA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934355AbeD0OHs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933869AbeD0OHr (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:07:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C7621864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 49/80] s390: run user space and KVM guests with modified branch prediction
Date: Fri, 27 Apr 2018 15:58:42 +0200
Message-Id: <20180427135735.447977232@linuxfoundation.org>
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


[ Upstream commit 6b73044b2b0081ee3dd1cd6eaab7dee552601efb ]

Define TIF_ISOLATE_BP and TIF_ISOLATE_BP_GUEST and add the necessary
plumbing in entry.S to be able to run user space and KVM guests with
limited branch prediction.

To switch a user space process to limited branch prediction the
s390_isolate_bp() function has to be call, and to run a vCPU of a KVM
guest associated with the current task with limited branch prediction
call s390_isolate_bp_guest().

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/processor.h   |    3 ++
 arch/s390/include/asm/thread_info.h |    4 ++
 arch/s390/kernel/entry.S            |   51 ++++++++++++++++++++++++++++++++----
 arch/s390/kernel/processor.c        |   18 ++++++++++++
 4 files changed, 71 insertions(+), 5 deletions(-)

--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -378,6 +378,9 @@ extern void memcpy_absolute(void *, void
 	memcpy_absolute(&(dest), &__tmp, sizeof(__tmp));	\
 } while (0)
 
+extern int s390_isolate_bp(void);
+extern int s390_isolate_bp_guest(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_S390_PROCESSOR_H */
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -60,6 +60,8 @@ int arch_dup_task_struct(struct task_str
 #define TIF_GUARDED_STORAGE	4	/* load guarded storage control block */
 #define TIF_PATCH_PENDING	5	/* pending live patching update */
 #define TIF_PGSTE		6	/* New mm's will use 4K page tables */
+#define TIF_ISOLATE_BP		8	/* Run process with isolated BP */
+#define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
 
 #define TIF_31BIT		16	/* 32bit process */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
@@ -80,6 +82,8 @@ int arch_dup_task_struct(struct task_str
 #define _TIF_UPROBE		_BITUL(TIF_UPROBE)
 #define _TIF_GUARDED_STORAGE	_BITUL(TIF_GUARDED_STORAGE)
 #define _TIF_PATCH_PENDING	_BITUL(TIF_PATCH_PENDING)
+#define _TIF_ISOLATE_BP		_BITUL(TIF_ISOLATE_BP)
+#define _TIF_ISOLATE_BP_GUEST	_BITUL(TIF_ISOLATE_BP_GUEST)
 
 #define _TIF_31BIT		_BITUL(TIF_31BIT)
 #define _TIF_SINGLE_STEP	_BITUL(TIF_SINGLE_STEP)
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -106,6 +106,7 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCAL
 	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
 	j	3f
 1:	UPDATE_VTIME %r14,%r15,\timer
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 2:	lg	%r15,__LC_ASYNC_STACK	# load async stack
 3:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	.endm
@@ -186,6 +187,40 @@ _PIF_WORK	= (_PIF_PER_TRAP | _PIF_SYSCAL
 	.popsection
 	.endm
 
+	.macro BPENTER tif_ptr,tif_mask
+	.pushsection .altinstr_replacement, "ax"
+662:	.word	0xc004, 0x0000, 0x0000	# 6 byte nop
+	.word	0xc004, 0x0000, 0x0000	# 6 byte nop
+	.popsection
+664:	TSTMSK	\tif_ptr,\tif_mask
+	jz	. + 8
+	.long	0xb2e8d000
+	.pushsection .altinstructions, "a"
+	.long 664b - .
+	.long 662b - .
+	.word 82
+	.byte 12
+	.byte 12
+	.popsection
+	.endm
+
+	.macro BPEXIT tif_ptr,tif_mask
+	TSTMSK	\tif_ptr,\tif_mask
+	.pushsection .altinstr_replacement, "ax"
+662:	jnz	. + 8
+	.long	0xb2e8d000
+	.popsection
+664:	jz	. + 8
+	.long	0xb2e8c000
+	.pushsection .altinstructions, "a"
+	.long 664b - .
+	.long 662b - .
+	.word 82
+	.byte 8
+	.byte 8
+	.popsection
+	.endm
+
 	.section .kprobes.text, "ax"
 .Ldummy:
 	/*
@@ -240,9 +275,11 @@ ENTRY(__switch_to)
  */
 ENTRY(sie64a)
 	stmg	%r6,%r14,__SF_GPRS(%r15)	# save kernel registers
+	lg	%r12,__LC_CURRENT
 	stg	%r2,__SF_EMPTY(%r15)		# save control block pointer
 	stg	%r3,__SF_EMPTY+8(%r15)		# save guest register save area
 	xc	__SF_EMPTY+16(8,%r15),__SF_EMPTY+16(%r15) # reason code = 0
+	mvc	__SF_EMPTY+24(8,%r15),__TI_flags(%r12) # copy thread flags
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU		# load guest fp/vx registers ?
 	jno	.Lsie_load_guest_gprs
 	brasl	%r14,load_fpu_regs		# load guest fp/vx regs
@@ -259,11 +296,12 @@ ENTRY(sie64a)
 	jnz	.Lsie_skip
 	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
 	jo	.Lsie_skip			# exit if fp/vx regs changed
-	BPON
+	BPEXIT	__SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
 .Lsie_entry:
 	sie	0(%r14)
 .Lsie_exit:
 	BPOFF
+	BPENTER	__SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
 .Lsie_skip:
 	ni	__SIE_PROG0C+3(%r14),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
@@ -324,6 +362,7 @@ ENTRY(system_call)
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)	# pointer to pt_regs
 .Lsysc_vtime:
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	stmg	%r0,%r7,__PT_R0(%r11)
 	# clear user controlled register to prevent speculative use
 	xgr	%r0,%r0
@@ -362,7 +401,7 @@ ENTRY(system_call)
 	jnz	.Lsysc_work			# check for work
 	TSTMSK	__LC_CPU_FLAGS,_CIF_WORK
 	jnz	.Lsysc_work
-	BPON
+	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 .Lsysc_restore:
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
@@ -587,6 +626,7 @@ ENTRY(pgm_check_handler)
 	aghi	%r15,-(STACK_FRAME_OVERHEAD + __PT_SIZE)
 	j	4f
 2:	UPDATE_VTIME %r14,%r15,__LC_SYNC_ENTER_TIMER
+	BPENTER __TI_flags(%r12),_TIF_ISOLATE_BP
 	lg	%r15,__LC_KERNEL_STACK
 	lgr	%r14,%r12
 	aghi	%r14,__TASK_thread	# pointer to thread_struct
@@ -718,7 +758,7 @@ ENTRY(io_int_handler)
 	mvc	__LC_RETURN_PSW(16),__PT_PSW(%r11)
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jno	.Lio_exit_kernel
-	BPON
+	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 .Lio_exit_timer:
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
@@ -1101,7 +1141,7 @@ ENTRY(mcck_int_handler)
 	mvc	__LC_RETURN_MCCK_PSW(16),__PT_PSW(%r11) # move return PSW
 	tm	__LC_RETURN_MCCK_PSW+1,0x01 # returning to user ?
 	jno	0f
-	BPON
+	BPEXIT	__TI_flags(%r12),_TIF_ISOLATE_BP
 	stpt	__LC_EXIT_TIMER
 	mvc	__VDSO_ECTG_BASE(16,%r14),__LC_EXIT_TIMER
 0:	lmg	%r11,%r15,__PT_R11(%r11)
@@ -1228,7 +1268,8 @@ cleanup_critical:
 	clg     %r9,BASED(.Lsie_crit_mcck_length)
 	jh      1f
 	oi      __LC_CPU_FLAGS+7, _CIF_MCCK_GUEST
-1:	lg	%r9,__SF_EMPTY(%r15)		# get control block pointer
+1:	BPENTER __SF_EMPTY+24(%r15),(_TIF_ISOLATE_BP|_TIF_ISOLATE_BP_GUEST)
+	lg	%r9,__SF_EMPTY(%r15)		# get control block pointer
 	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
 	larl	%r9,sie_exit			# skip forward to sie_exit
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -197,3 +197,21 @@ const struct seq_operations cpuinfo_op =
 	.stop	= c_stop,
 	.show	= show_cpuinfo,
 };
+
+int s390_isolate_bp(void)
+{
+	if (!test_facility(82))
+		return -EOPNOTSUPP;
+	set_thread_flag(TIF_ISOLATE_BP);
+	return 0;
+}
+EXPORT_SYMBOL(s390_isolate_bp);
+
+int s390_isolate_bp_guest(void)
+{
+	if (!test_facility(82))
+		return -EOPNOTSUPP;
+	set_thread_flag(TIF_ISOLATE_BP_GUEST);
+	return 0;
+}
+EXPORT_SYMBOL(s390_isolate_bp_guest);

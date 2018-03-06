Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3003213-1520296077-2-13372718667342358486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520296076; b=OwGKqqJIqPgJ09r0D4/KYF0GAqlGjg9HAKke2H5P4gFTiLE
    DA2VgPW6BehlpZNqZ5UEGGJB/o3WX6dyn8Zz2DxdbUo1Kxyo0f3zjJkLlBVC1k8x
    JUvdeY4PKwiTxjtToTUMVeB1edOstlCnYZJ5UY8LQnb2jXHDo5vrEXmSttJDvwsb
    /yJOJp/SmbqxEiYow50h3ZzpYPpk/nyDdmI83uRPpQfGqOsgzOQiKCI5Ti3FRDqT
    qjF1rCtNyev9giE3GsfDOaAhF02E8u/sHZMBpaVAWQdhsMITaefJgWD9hSEfvgAb
    md73qtrnmVHUR24+P31w/IL0+OVujiRaaP3o2VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520296076;
    bh=OaewJI8g4MfwOTnpM+ky4nONLp2IO1IGdaVjpMkiSDo=; b=wOVxVTz4mT6G
    5fR1Jb6YRJ7c7SnUMrAniCw3hd7PZ0RXYJrAj8y+mRQ2eyNkcpQq1qyBy/bYrHbJ
    Ut6dZn4SOYBx0b0C/Gd4zxUfg10ujCDfi4Fx/gcRduaO4F6zqj2ZZtu3C/EQvKKF
    v158FJItK6Ep4pMIGG7CUFE4OqECs3J5BOUDKnoEtrvB3Qv+ov25jbsPYkdPHuJJ
    lrzG6GSglLEdCeuEJdwYfyZykfEgfVVIi9Ld0Gx3HNbKqgiCQWmo1fef8PH48zMx
    rZWF/4sMSl0Y2UAGNb7QSlFnO4IWVqLT88dUq6/qfVesQKS8FEqffNcsRyXtpieO
    CXWwcgKpRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Z6SV7Y8V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Z6SV7Y8V x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeCFA1b (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:27:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56704 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933544AbeCFA1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 19:27:00 -0500
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 64/65] pti: Rename X86_FEATURE_KAISER to X86_FEATURE_PTI
Date: Mon,  5 Mar 2018 19:25:37 -0500
Message-Id: <20180306002538.1761-65-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=852
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060005
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cat /proc/cpuinfo still shows kaiser feature, and want only pti
to be visible to users. Therefore, rename this macro to get
correct user visible output.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Brian Maly <brian.maly@oracle.com>
---
 arch/x86/include/asm/cpufeature.h |  2 +-
 arch/x86/include/asm/kaiser.h     |  6 +++---
 arch/x86/kernel/entry_64.S        | 12 ++++++------
 arch/x86/mm/kaiser.c              |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a22aa8c5903c..fc790e2f0d4e 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -202,7 +202,7 @@
 #define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_KAISER w/o nokaiser */
 
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
-#define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
+#define X86_FEATURE_PTI	( 7*32+31) /* CONFIG_PAGE_TABLE_ISOLATION w/o nopti */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 802bbbdfe143..5d85ddf26166 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -47,14 +47,14 @@ movq \reg, %cr3
 .endm
 
 .macro SWITCH_KERNEL_CR3
-ALTERNATIVE "jmp 8f", "pushq %rax", X86_FEATURE_KAISER
+ALTERNATIVE "jmp 8f", "pushq %rax", X86_FEATURE_PTI
 _SWITCH_TO_KERNEL_CR3 %rax
 popq %rax
 8:
 .endm
 
 .macro SWITCH_USER_CR3
-ALTERNATIVE "jmp 8f", "pushq %rax", X86_FEATURE_KAISER
+ALTERNATIVE "jmp 8f", "pushq %rax", X86_FEATURE_PTI
 _SWITCH_TO_USER_CR3 %rax %al
 popq %rax
 8:
@@ -63,7 +63,7 @@ popq %rax
 .macro SWITCH_KERNEL_CR3_NO_STACK
 ALTERNATIVE "jmp 8f", \
 	__stringify(movq %rax, PER_CPU_VAR(unsafe_stack_register_backup)), \
-	X86_FEATURE_KAISER
+	X86_FEATURE_PTI
 _SWITCH_TO_KERNEL_CR3 %rax
 movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 8:
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 95b57f4393b7..204dfb58c9f0 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1327,7 +1327,7 @@ ENTRY(paranoid_entry)
 	 * unconditionally, but we need to find out whether the reverse
 	 * should be done on return (conveyed to paranoid_exit in %ebx).
 	 */
-	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
+	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_PTI
 	testl	$KAISER_SHADOW_PGD_OFFSET, %eax
 	jz	2f
 	orl	$2, %ebx
@@ -1361,7 +1361,7 @@ ENTRY(paranoid_exit)
 	TRACE_IRQS_OFF_DEBUG
 	TRACE_IRQS_IRETQ_DEBUG
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	/* No ALTERNATIVE for X86_FEATURE_KAISER: paranoid_entry sets %ebx */
+	/* No ALTERNATIVE for X86_FEATURE_PTI: paranoid_entry sets %ebx */
 	testl   $2, %ebx			/* SWITCH_USER_CR3 needed? */
 	jz      paranoid_exit_no_switch
 	SWITCH_USER_CR3
@@ -1567,7 +1567,7 @@ ENTRY(nmi)
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
-	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
+	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_PTI
 	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
 	ALTERNATIVE "", "bts $63, %rax", X86_FEATURE_PCID
 	pushq	%rax
@@ -1583,7 +1583,7 @@ ENTRY(nmi)
 	 * kernel code that needs user CR3, but do we ever return
 	 * to "user mode" where we need the kernel CR3?
 	 */
-	ALTERNATIVE "", "popq %rax; movq %rax, %cr3", X86_FEATURE_KAISER
+	ALTERNATIVE "", "popq %rax; movq %rax, %cr3", X86_FEATURE_PTI
 #endif
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1806,7 +1806,7 @@ end_repeat_nmi:
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
-	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_KAISER
+	ALTERNATIVE "jmp 2f", "movq %cr3, %rax", X86_FEATURE_PTI
 	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
 	ALTERNATIVE "", "bts $63, %rax", X86_FEATURE_PCID
 	pushq	%rax
@@ -1825,7 +1825,7 @@ end_repeat_nmi:
 	 * kernel code that needs user CR3, like just just before
 	 * a sysret.
 	 */
-	ALTERNATIVE "", "popq %rax; movq %rax, %cr3", X86_FEATURE_KAISER
+	ALTERNATIVE "", "popq %rax; movq %rax, %cr3", X86_FEATURE_PTI
 #endif
 
 	testl %ebx,%ebx				/* swapgs needed? */
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 05fb616c9e2a..e37ac77e6cb6 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -289,14 +289,14 @@ skip:
 
 enable:
 	if (enable)
-		setup_force_cpu_cap(X86_FEATURE_KAISER);
+		setup_force_cpu_cap(X86_FEATURE_PTI);
 
 	return;
 
 disable:
 	pr_info("Kernel/User page tables isolation: disabled\n");
 	kaiser_enabled = 0;
-	setup_clear_cpu_cap(X86_FEATURE_KAISER);
+	setup_clear_cpu_cap(X86_FEATURE_PTI);
 }
 
 /*
-- 
2.16.2

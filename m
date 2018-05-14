Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1142023-1526318138-2-2429718309964614968
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526318138; b=a30QtjTITS28a3DuasWWSr8FHOe4/qX/4yZhg1frimbGotuwIS
    q5qGgzNhX58aYLYZMuu+I2T3Lyw4j029IkVurk4MPO6i5zGPt7Xs15X5e5S/vQGe
    FhQW9HyWzrIRx900RLiTC9hy8zsUzeMREkdwERphlBbjIfp4HrT6B7CHMhoUnUuF
    PqbVDr7f1tA9dA31zADSsW3q17mp+87YSmQEGzM5TiWNPUQpLZrkvYu4yr6ykMgn
    z+6mtuYJWPHZ9akeHuXT4xa1cUMmMAJGch5QfcjihHdRvr6OiJEnRtBc4D0J5gpZ
    rF1PZzMiNMFRey4d79uBDWeJ2YWYY30qHxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526318138; bh=
    1uyoZ6LVFVTjMU95I1EPVd6t5TZan6i3pI+UIACUj4M=; b=HkPDQAgtoFhboW/O
    SuW/gyrm7NWbZIiB5kZwzhdHjTW8M0hgrhBgwZZPrp/Z+/uPlbf6c6hHdweVh2Y9
    fX+0gwEet/IX1rzM/8UBuqTTgoIfLlI0CTHhlY/R3iT0UVYc0OHx/+z7f9C5HozH
    g3AaliiDOhsRWXwhjM9cWZKs3EtNg+EqjePoUiFzeZqxcpkFNi/p+imnfzk+81ge
    xZdTzfULzyHlR+ykNMs3kK7n+B1ZH7LRRLa06CY8iqdV/K/VKS3RQfmN+yFquL3W
    eczlhubtgIY+DC6MtjR7fc2hXszxEyV1Zb1u3ISLSRqg+k/R6T4ylTxHTrjwoUy7
    vmKzDA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP/R8hSjnBNI+1rTB9qj+fU4HQ9cv4JeaOj6QKijYM/vomCHTe4uifkeiWONXMybHthQoKT4+jfBIijwFikPHWfniNnwOb3FwoDT0YLMzF3vjZpvPaLo
    kFQc/1KcP/M/XSVHa8zzTkZwfrDr/F8VjbfM0YMA/CipSAPCOaKr9hZEnq8IXONU93Odtyp9YEzq4vYGUwKt79vRl8jvEzIb0dlJOWm9vZTrU0WgjjaFVDmU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=wMNdZWldAAAA:8 a=hGzw-44bAAAA:8 a=GkDeVuoTWdXZXB7EekQA:9
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=FUarYpL4UH3yWsho8X8J:22 a=HvKuF1_PTVFglORKqfwH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754160AbeENRPe (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 13:15:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbeENRPc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 13:15:32 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [RFC PATCH 07/11] powerpc: Move arch-specific prctls out of core code
Date: Mon, 14 May 2018 18:14:23 +0100
Message-Id: <1526318067-4964-8-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch moves the powerpc-specific prctl call implementations
out of core code and removes redundant boilerplate associated with
them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/include/asm/processor.h |  6 ------
 arch/powerpc/kernel/syscalls.c       | 17 +++++++++++++++++
 kernel/sys.c                         | 24 ------------------------
 4 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181..b94323e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -218,6 +218,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PRCTL_ARCH
 	select HAVE_RCU_TABLE_FREE		if SMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 313dec1..e1cd7ec 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -407,15 +407,9 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk)  ((tsk)->thread.regs? (tsk)->thread.regs->gpr[1]: 0)
 
 /* Get/set floating-point exception mode */
-#define GET_FPEXC_CTL(adr) get_fpexc_mode((adr))
-#define SET_FPEXC_CTL(val) set_fpexc_mode((val))
-
 extern int get_fpexc_mode(unsigned long adr);
 extern int set_fpexc_mode(unsigned int val);
 
-#define GET_ENDIAN(adr) get_endian((adr))
-#define SET_ENDIAN(val) set_endian((val))
-
 extern int get_endian(unsigned long adr);
 extern int set_endian(unsigned int val);
 
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 4662165..0d6a914 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -139,3 +139,20 @@ long sys_switch_endian(void)
 
 	return 0;
 }
+
+int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
+	       unsigned long arg4, unsigned long arg5)
+{
+	switch (option) {
+	case PR_SET_FPEXC:
+		return set_fpexc_mode(arg2);
+	case PR_GET_FPEXC:
+		return get_fpexc_mode(arg2);
+	case PR_GET_ENDIAN:
+		return get_endian(arg2);
+	case PR_SET_ENDIAN:
+		return set_endian(arg2);
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/kernel/sys.c b/kernel/sys.c
index 44e1c47..b154561 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -83,18 +83,6 @@
 #ifndef GET_FPEMU_CTL
 # define GET_FPEMU_CTL(a, b)	(-EINVAL)
 #endif
-#ifndef SET_FPEXC_CTL
-# define SET_FPEXC_CTL(a, b)	(-EINVAL)
-#endif
-#ifndef GET_FPEXC_CTL
-# define GET_FPEXC_CTL(a, b)	(-EINVAL)
-#endif
-#ifndef GET_ENDIAN
-# define GET_ENDIAN(b)		(-EINVAL)
-#endif
-#ifndef SET_ENDIAN
-# define SET_ENDIAN(b)		(-EINVAL)
-#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2264,12 +2252,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FPEMU:
 		error = GET_FPEMU_CTL(me, arg2);
 		break;
-	case PR_SET_FPEXC:
-		error = SET_FPEXC_CTL(arg2);
-		break;
-	case PR_GET_FPEXC:
-		error = GET_FPEXC_CTL(arg2);
-		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
 		break;
@@ -2290,12 +2272,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
 			return -EFAULT;
 		break;
-	case PR_GET_ENDIAN:
-		error = GET_ENDIAN(arg2);
-		break;
-	case PR_SET_ENDIAN:
-		error = SET_ENDIAN(arg2);
-		break;
 	case PR_GET_SECCOMP:
 		error = prctl_get_seccomp();
 		break;
-- 
2.1.4

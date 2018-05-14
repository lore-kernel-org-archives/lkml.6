Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146574-1526318375-2-10656649949316569307
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526318374; b=P0SgpSu+jwM+vx3zbXfXoeGiqIeg9TPxlhTVbVmIp9Vqzq66VZ
    6tIjSOdzhK39ziCrB8ZsnSePaeDAEOqaHuou9kykcRVaKT1v8n71lPeb0ll0rG6r
    dw6jNPU1rgvfeeb2PJVU7XW01zp+bdlpewAiIFcT0Mv6xP5Cee5YaEzP2BPcxfbR
    pSVlxQZ+Vb1YPv7ZfidyoPmfhzw7MQVQ6ghWVw1MWqP7VDJGPF4/PJMmr/1o9k8Q
    JY4v3jHbMTkoY4P5Z3fbSU0ot5xbxZN9HvwAMU+9zJ2EMqM5cho9N8Nkx/7DSqeb
    LH1T8bnrCNY9pWIFXxUAeJWW3e91t+KTcK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526318374; bh=
    +bfe/I3v5lg4n6vqdw/d8FttfxrB9tL6F1tvKdrda8I=; b=c30M+TV7OLHBiF+B
    YOLo/7OkGhGo19W6v7DQteIv+3D5+X4UWJcdmP7hpuAZkSpVe+dwhKDjGweGURN1
    FeX/QH2DGrokrBtZcnd8/iOezVNY9VizWQmG6My4aD7qh8cxWd3Yn9LKr+iRj/Bw
    9+qnQS1Os+8j8IsXNgnWg8MCG1LcJHmF9zQV11XcVxMv/qJQ3srKr2jHL7ObpnRU
    BOt97hxVsk56VK/+waNCAcaeZDtam+fo3JgTo/YBEESEoqqFP4s0rXnWZM7xXlar
    jHTCcumEhKNi+FLc4DzMuhrvwVpSkgD4kHBbBJZ1AOwL9ZcRDCz3g/1X6FDpoVZ7
    gob11A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDRfmWj7i2YT0rUk9SINJUw62O9cu6zouu/f1MxwR15KPmOTBclX/F+SBXxBtDD+Rf9sZAHDKOde/asuVZPXCM1x/05f2eqBFzIOwTm6sq7FKTqYWejd
    ZwWxEYqupfqUKMg/693TcH5szVufYcdPt/wIu1kNjUwFOUh+D7xW85i1g9rnOFLgcTDYqu/cGLniNJx+eCKb5BKM5lgEX9Ybczuc+BIVokTkvYOja0ahWaM0
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=7CQSdrXTAAAA:8
    a=t2C2Z1f7rYtBcsmYJ1EA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeENRTd (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 13:19:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46948 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753015AbeENRP0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 13:15:26 -0400
From: Dave Martin <Dave.Martin@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 02/11] arm64: Move arch-specific prctls out of core code
Date: Mon, 14 May 2018 18:14:18 +0100
Message-Id: <1526318067-4964-3-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch moves the arm64-specific prctl call implementations out
of core code and removes redundant boilerplate associated with
them.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/processor.h |  4 ----
 arch/arm64/kernel/sys.c            | 15 +++++++++++++++
 kernel/sys.c                       | 12 ------------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..6b706af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -123,6 +123,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PRCTL_ARCH
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 7675989..b1d262f 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -244,9 +244,5 @@ void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
 void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
 void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
 
-/* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
-#define SVE_SET_VL(arg)	sve_set_current_vl(arg)
-#define SVE_GET_VL()	sve_get_current_vl()
-
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 72981ba..597ff35 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -22,10 +22,12 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/export.h>
+#include <linux/prctl.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <asm/cpufeature.h>
+#include <asm/fpsimd.h>
 
 asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
 			 unsigned long prot, unsigned long flags,
@@ -45,6 +47,19 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	return sys_personality(personality);
 }
 
+int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
+	       unsigned long arg4, unsigned long arg5)
+{
+	switch (option) {
+	case PR_SVE_SET_VL:
+		return sve_set_current_vl(arg2);
+	case PR_SVE_GET_VL:
+		return sve_get_current_vl();
+	default:
+		return -EINVAL;
+	}
+}
+
 /*
  * Wrappers to pass the pt_regs argument.
  */
diff --git a/kernel/sys.c b/kernel/sys.c
index 5077f1e..f917d78 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -113,12 +113,6 @@
 #ifndef SET_FP_MODE
 # define SET_FP_MODE(a,b)	(-EINVAL)
 #endif
-#ifndef SVE_SET_VL
-# define SVE_SET_VL(a)		(-EINVAL)
-#endif
-#ifndef SVE_GET_VL
-# define SVE_GET_VL()		(-EINVAL)
-#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2444,12 +2438,6 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
 		break;
-	case PR_SVE_SET_VL:
-		error = SVE_SET_VL(arg2);
-		break;
-	case PR_SVE_GET_VL:
-		error = SVE_GET_VL();
-		break;
 	default:
 		error = prctl_arch(option, arg2, arg3, arg4, arg5);
 		break;
-- 
2.1.4

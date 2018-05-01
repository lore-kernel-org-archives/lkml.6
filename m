Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2927341-1525170376-2-3265689943193469469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525170375; b=aB0Fr3kbaXNTUWqzYs7Azk3bpbxQbniD/Sixiwx00nI3QkOplz
    8j0pRrructI5mc74GVi2uPax6bE1nr4nXIvKvekYhdwNTLy2tacRijU65nmP8lv7
    gyBh+Z5Hk2z7XUkdxVVcLmo1MgOunWz8ETfrghMHUVj69lu/IlgMQhGJnFqSDR7Z
    lYshZzq30+VO13ehRSCx74x/6tGQmSALuR+4MoXa+GucefBPNFx5EyAtJRT+T1BK
    fyDZTFBGfqStZDDl/S6TF8DKaa80GSg/RHfN/Vxe0Ge8WzNoqURkIcVPQiddtJo5
    1tvw6u0rVjqJ4yPJHROR1nDPna58rA0hh6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525170375; bh=3zWo41vB0WowIpJYC+cD1C753K7iKy
    +cwfyORF6NFNk=; b=nN5s7Ue7zoODdI71tHLfj+Z0wrzAjP+KRgBGzw5VrPJ2e7
    cSAiHS0bbiGY0BjVOYwMm3icN9nDu57UYfHE1T4jA3iniFL8/luGqEM+HAV6GWu1
    Auu+cq3JMeKSBRE0wNuwPowe1kFrh7w4POSIdhNLImMYAUmwjyxCm9qQyvk7Gl2p
    5aRgsC16QcXEouDIvJmZyR1ZMO6lkaSddXibA5wSPQOgYTtxrmyUJX/lAt20qpgN
    eF4XcWU+FSVJlYa+aisXYcHQWFNUpU7503BHydKprXLNKGkWbLYB0YUoX56MNmMm
    rLUiXDRv88/6/pVOi1Xfh9G39wmZD6Vi5SJONa6A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOyejKBp90Dd7PInMBnIzMETNBcBNSpNv2wIfBFlBFG7mCnUQe30jXu2gagRHTqpnaYIaVKS21d32pjtf5+mnlosui9HniZEXM7blME/zC/OwpvjwgCt
    ghto7ec0vfEQBtnM80LPmdlWIy21/7I/kGhWLZwmRRi0Khjf9GxapLnHVsHnNyzA9L6xNZa1CrYLGYfmy5ACmHbJaKHPReXP6Q116/ENXaJsVf3cuyNGp429
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=IrHc8IX0aHDf3ctQ9uYA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeEAK0M (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 06:26:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45158 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeEAK0L (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 1 May 2018 06:26:11 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: stable@vger.kernel.org
Cc: suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, will.deacon@arm.com
Subject: [PATCH] [stable] arm64: Add work around for Arm Cortex-A55 Erratum 1024718
Date: Tue,  1 May 2018 11:26:04 +0100
Message-Id: <1525170364-21032-1-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream

Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
from an erratum 1024718, which causes incorrect updates when DBM/AP
bits in a page table entry is modified without a break-before-make
sequence. The work around is to disable the hardware DBM feature
on the affected cores. The hardware Access Flag management features
is not affected.

The hardware DBM feature is a non-conflicting capability, i.e, the
kernel could handle cores using the feature and those without having
the features running at the same time. So this work around is detected
at early boot time, rather than delaying it until the CPUs are brought
up into the kernel with MMU turned on. This also avoids other complexities
with late CPUs turning online, with or without the hardware DBM features.

Note: The upstream commit is on top of a reworked capability
infrastructure for arm64 heterogeneous systems, which allows
handling this later in the boot process. This backport
is based on the original version of the patch [0]. Folded the 3
patches into this single commit, removing the unncessary bits.

[0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com

Cc: stable@vger.kernel.org # v4.3 to v4.16
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 14 ++++++++++++
 arch/arm64/include/asm/assembler.h     | 40 ++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  2 ++
 arch/arm64/mm/proc.S                   |  5 +++++
 5 files changed, 62 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index c1d520d..3b2f2dd 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -55,6 +55,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 | ARM            | Cortex-A72      | #853709         | N/A                         |
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
+| ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7381eeb..be66576 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -464,6 +464,20 @@ config ARM64_ERRATUM_843419
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1024718
+	bool "Cortex-A55: 1024718: Update of DBM/AP bits without break before make might result in incorrect update"
+	default y
+	help
+	  This option adds work around for Arm Cortex-A55 Erratum 1024718.
+
+	  Affected Cortex-A55 cores (r0p0, r0p1, r1p0) could cause incorrect
+	  update of the hardware dirty bit when the DBM/AP bits are updated
+	  without a break-before-make. The work around is to disable the usage
+	  of hardware DBM locally on the affected cores. CPUs not affected by
+	  erratum will continue to use the feature.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3c78835..a3ca19e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,7 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
+#include <asm/cputype.h>
 #include <asm/debug-monitors.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
@@ -595,4 +596,43 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 #endif
 	.endm
 
+/*
+ * Check the MIDR_EL1 of the current CPU for a given model and a range of
+ * variant/revision. See asm/cputype.h for the macros used below.
+ *
+ *	model:		MIDR_CPU_MODEL of CPU
+ *	rv_min:		Minimum of MIDR_CPU_VAR_REV()
+ *	rv_max:		Maximum of MIDR_CPU_VAR_REV()
+ *	res:		Result register.
+ *	tmp1, tmp2, tmp3: Temporary registers
+ *
+ * Corrupts: res, tmp1, tmp2, tmp3
+ * Returns:  0, if the CPU id doesn't match. Non-zero otherwise
+ */
+	.macro	cpu_midr_match model, rv_min, rv_max, res, tmp1, tmp2, tmp3
+	mrs		\res, midr_el1
+	mov_q		\tmp1, (MIDR_REVISION_MASK | MIDR_VARIANT_MASK)
+	mov_q		\tmp2, MIDR_CPU_MODEL_MASK
+	and		\tmp3, \res, \tmp2	// Extract model
+	and		\tmp1, \res, \tmp1	// rev & variant
+	mov_q		\tmp2, \model
+	cmp		\tmp3, \tmp2
+	cset		\res, eq
+	cbz		\res, .Ldone\@		// Model matches ?
+
+	.if (\rv_min != 0)			// Skip min check if rv_min == 0
+	mov_q		\tmp3, \rv_min
+	cmp		\tmp1, \tmp3
+	cset		\res, ge
+	.endif					// \rv_min != 0
+	/* Skip rv_max check if rv_min == rv_max && rv_min != 0 */
+	.if ((\rv_min != \rv_max) || \rv_min == 0)
+	mov_q		\tmp2, \rv_max
+	cmp		\tmp1, \tmp2
+	cset		\tmp2, le
+	and		\res, \res, \tmp2
+	.endif
+.Ldone\@:
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 350c76a..8e32a6f 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -83,6 +83,7 @@
 #define ARM_CPU_PART_CORTEX_A53		0xD03
 #define ARM_CPU_PART_CORTEX_A73		0xD09
 #define ARM_CPU_PART_CORTEX_A75		0xD0A
+#define ARM_CPU_PART_CORTEX_A55		0xD05
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -102,6 +103,7 @@
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
 #define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
 #define MIDR_CORTEX_A75 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A75)
+#define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c0af476..5244440 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -448,6 +448,11 @@ ENTRY(__cpu_setup)
 	cbz	x9, 2f
 	cmp	x9, #2
 	b.lt	1f
+#ifdef CONFIG_ARM64_ERRATUM_1024718
+	/* Disable hardware DBM on Cortex-A55 r0p0, r0p1 & r1p0 */
+	cpu_midr_match MIDR_CORTEX_A55, MIDR_CPU_VAR_REV(0, 0), MIDR_CPU_VAR_REV(1, 0), x1, x2, x3, x4
+	cbnz	x1, 1f
+#endif
 	orr	x10, x10, #TCR_HD		// hardware Dirty flag update
 1:	orr	x10, x10, #TCR_HA		// hardware Access flag update
 2:
-- 
2.7.4

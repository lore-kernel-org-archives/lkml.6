Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4027354-1526046684-2-6799691675411178019
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
    1526046683; b=aAomy8hL5ntcoR5cZlFRXrKOaUNbI+TLBGcVKTHpvAneWg19e1
    J5yJRRkia3WZPHOC1YZHKbRr/7JG1i9s64wQcRaAjOiP07Y8wKTVek0Tvz994SHB
    LTcqSK6q/ilPRxMB/0p9iyXZO1jpd2XkUB5G8ojjhWp40weunC0pYdJ9tJqzYt7A
    L+8kP87v6hss+W64zZrIUtfofmtuXu3Jxm0wys71jYZ8kgsgPJpamQajPmwpco64
    h8AkrZmT0OHSXpT8Fbo2qUz0E9V2ImHpJgj7zHtBIVUcvW6HnO1hW8xdB2DSBuqO
    bu+1Hx3dni7cJpyXRp5iYli4HLF97/Dyr0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526046683; bh=8jFD7ifaOcB1EDYoSODAJsjHduyhwN
    2LgEOOfJOwwEc=; b=crNL7qxqJD8Mzf6XMOMZCyXZkbIKDpPIqLeSusXdOUCspF
    DJe2Jl7I5BROuve8iChlWf/qax2ryRl2CEQo+cWEnU7e5khV1g1Wz9C935Tv3EYl
    KfosLrueSPOaUiutO7fhRRyg4ZNII0VthaRHArx7Bk5u0uouqvPA0gpydkSvcS3b
    Onw8NpFfLwQpyXsOK4T7zfdEIfRnaJ+Yf6EL97pnAyOhesDwkL+5xo+qnzvJmVbX
    Zr+YQ2EOAHRo3C0Co+3c2QG3KMmf5PWZZ5KsHB4ZZFsH4QFiZJBCxzEOfU2bv9+y
    ZpIcqoSHgWYokyGDgZgLDFmxNDnVxQi4fjsId0OA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfBLEPfg1+TU47d7949C0kZ5w+AeSBY9o5hbqFpWyCnDBsBkETk+QRDoDmelUhgNAKhyFLev3vGjPKnmEVYB4JdzGAFiEuX/FIBR6VjAUiUdFwgofQAHF
    u8FUr8XnxrYoZe4RcZx9Wp8j2rAWvPEqTAVnPNaFw91kaYyd0I9mFsmEmA6zLmxuO9/KomX1jy/3q7bFXL5gAvdpLdELw2M493oMQfbLHrz+vVPwmspTk7aj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=AP7uSENH7LSa6p5_VZoA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeEKNvV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 09:51:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41726 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbeEKNvV (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 09:51:21 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: stable@vger.kernel.org
Cc: suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com
Subject: [PATCH] [stable 4.9] arm64: Add work around for Arm Cortex-A55 Erratum 1024718
Date: Fri, 11 May 2018 14:51:15 +0100
Message-Id: <1526046675-23790-1-git-send-email-suzuki.poulose@arm.com>
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

Cc: stable@vger.kernel.org # v4.9
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Note: The upstream commit is on top of a reworked capability
infrastructure for arm64 heterogeneous systems, which allows
delaying the CPU model checks. This backport is based on the
original version of the patch [0], which checks the affected
CPU models during the early boot.

[0] https://lkml.kernel.org/r/20180116102323.3470-1-suzuki.poulose@arm.com
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 14 ++++++++++++
 arch/arm64/include/asm/assembler.h     | 40 ++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  5 +++++
 arch/arm64/mm/proc.S                   |  5 +++++
 5 files changed, 65 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index d11af52..ac9489f 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -54,6 +54,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #852523         | N/A                         |
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 | ARM            | Cortex-A72      | #853709         | N/A                         |
+| ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 90e58bb..d0df361 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -427,6 +427,20 @@ config ARM64_ERRATUM_843419
 
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
index e60375c..bfcfec3 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -25,6 +25,7 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
+#include <asm/cputype.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -435,4 +436,43 @@ alternative_endif
 	and	\phys, \pte, #(((1 << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
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
index 9ee3038..39d1db6 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -56,6 +56,9 @@
 	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
 	((partnum)		<< MIDR_PARTNUM_SHIFT))
 
+#define MIDR_CPU_VAR_REV(var, rev) \
+	(((var) << MIDR_VARIANT_SHIFT) | (rev))
+
 #define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
 			     MIDR_ARCHITECTURE_MASK)
 
@@ -74,6 +77,7 @@
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
+#define ARM_CPU_PART_CORTEX_A55		0xD05
 #define ARM_CPU_PART_CORTEX_A57		0xD07
 #define ARM_CPU_PART_CORTEX_A72		0xD08
 #define ARM_CPU_PART_CORTEX_A53		0xD03
@@ -89,6 +93,7 @@
 #define BRCM_CPU_PART_VULCAN		0x516
 
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
+#define MIDR_CORTEX_A55 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
 #define MIDR_CORTEX_A73 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A73)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 619da1c..66cce21 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -425,6 +425,11 @@ ENTRY(__cpu_setup)
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

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610692-1526295704-5-5529383637567027259
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526295702; b=CdcemHyv0VM7of4GB5DzZsnP7z654X7s/MuUoffcqkz+1LnMKj
    Hnh0T8Ah/EDB7CsxbQeMvnZpFtkV4Xd/lMiYauah1R21n2vc9pIUVwrkkleJh8UD
    TvQuutgFLZwx6D100w3NBJ3OOy3E+XK32p3kafobrAYc2zp6Nltgwq2gL+rkF3KB
    xKq2yfQpz46pmP9QyAL+BgHprKxTTZ/gNq8rFfRd0flnYbB6+1y1eeKe5CSyVla4
    ouxNztQKjtJWyyIdROwg0RE+Ouh/9Vcnw0ZcLpH1EVc/Bfnmab/Qh8RLzUSs6qvd
    w6VD6LtWMuSYAA+BH+D116Gx6zmW4Q7ZsXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526295702; bh=
    iw4BH/ZOU3sFRcj0tJt9EcU2QxliFGtiESZzOuy/RgA=; b=askr6HDfYlQq/s6q
    pZH89LCGomRi6up0eWIUbwrNqKv3XVhKR6j4wsVDOTylgCr3FS3FAe9/fJBS7spR
    N3hZcu+M7yIXHUgARiI3RFALORBRfFCz82QxE9KliYmT8w20QWXgD+o7mheLi4ri
    9qgH8v13j5OwGLJR/O6/XQ+IMBxci9mxNREFbV/JHUwMODyqXYCpgop9mthrgJWE
    6m4ocX/76LPMMu3QmTy1570reX9HCwg649u/GY30uYYUnAvfzS27SJ0fP4urOjDa
    51oSFlWserQH29BBbK8xtojG2xBY6W5Exh1g0fM/2hXhAl9O22YARLKBBxNER6dh
    Rd59QA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfJfMeTSsWmEBWFatdm5QYIY8BG5cl1IEf0eAAl0D3FpunkpVnGhBKS/eFIxJ3oE3V4jADFWEmEDvnvNA1KHTbL9U466pYo8rlhn8lHpW5jNwY6eQIVX8
    QncZWc4VnGp2Xjv5CQZSGj/KGeRPL677pmDqSCJUm9x+47/c+PHWTab+UWtN9O2MiGn20Gr01l+p37An9dosdFAVbE+t6qlH3ZDVg2rvR4LYe2mwIzoyaoYu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=7CQSdrXTAAAA:8 a=QBHdfG-Sftq2nLuhOi0A:9 a=AjGcO6oz07-iQ99wixmX:22
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeENLBW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 07:01:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40016 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752516AbeENLBM (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 07:01:12 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: stable@vger.kernel.org
Cc: suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, dave.martin@arm.com
Subject: [PATCH 2/2] [stable 4.4] arm64: Add work around for Arm Cortex-A55 Erratum 1024718
Date: Mon, 14 May 2018 12:01:04 +0100
Message-Id: <1526295664-22187-2-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526295664-22187-1-git-send-email-suzuki.poulose@arm.com>
References: <1526295664-22187-1-git-send-email-suzuki.poulose@arm.com>
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

Cc: stable@vger.kernel.org # v4.4
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
 arch/arm64/Kconfig                 | 14 +++++++++++++
 arch/arm64/include/asm/assembler.h | 40 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h   | 11 +++++++++++
 arch/arm64/mm/proc.S               |  5 +++++
 4 files changed, 70 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 02c0867..5b47218 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -375,6 +375,20 @@ config ARM64_ERRATUM_843419
 
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
index 83e2309..f68abb1 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -23,6 +23,7 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
+#include <asm/cputype.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
@@ -224,4 +225,43 @@ lr	.req	x30		// link register
 	movk	\reg, :abs_g0_nc:\val
 	.endm
 
+/*
+ * Check the MIDR_EL1 of the current CPU for a given model and a range of
+ * variant/revision. See asm/cputype.h for the macros used below.
+ *
+ *	model:		MIDR_CPU_PART of CPU
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
+	mov_q		\tmp2, MIDR_CPU_PART_MASK
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
index 1a59493..f43e10c 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -57,6 +57,14 @@
 #define MIDR_IMPLEMENTOR(midr)	\
 	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
 
+#define MIDR_CPU_VAR_REV(var, rev) \
+	(((var) << MIDR_VARIANT_SHIFT) | (rev))
+
+#define MIDR_CPU_PART_MASK	  \
+	(MIDR_IMPLEMENTOR_MASK	| \
+	 MIDR_ARCHITECTURE_MASK | \
+	 MIDR_PARTNUM_MASK)
+
 #define MIDR_CPU_PART(imp, partnum) \
 	(((imp)			<< MIDR_IMPLEMENTOR_SHIFT) | \
 	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
@@ -70,11 +78,14 @@
 #define ARM_CPU_PART_FOUNDATION		0xD00
 #define ARM_CPU_PART_CORTEX_A57		0xD07
 #define ARM_CPU_PART_CORTEX_A53		0xD03
+#define ARM_CPU_PART_CORTEX_A55		0xD05
 
 #define APM_CPU_PART_POTENZA		0x000
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 
+#define MIDR_CORTEX_A55 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A55)
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 18201e9..f096367 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -221,6 +221,11 @@ ENTRY(__cpu_setup)
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

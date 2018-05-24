Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527155020-2-5169026935303748449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155020; b=VLsFxyTiVime8hEHnuyxhhz7eCAVGsy1JIS46roXTBBo8d4lEY
    pOy8rKZKGqh9Kn082FdW/kOkRZd0Oq3R6ZcloC9rB8Amm//zphV8M9MtYoZuYuxp
    z6/yrqNZZcvoyYV0OxDy0QEaQ1bO7Aj6Gdq+JKAh9w6e/ldBaLhdBTflsMQPwG7x
    qFeibF3T3tQKMWtGnq08RPJAENUU5scVCDH0rxCrqGUR5nRgR4RAIYJaMgH9wYwD
    QHadDhG2F8bInI7Ki2MZlNbO/10B3KjK3060Dkas6z1PDwRdpePexZBMVqggVHdW
    MJIeqAN1uEKkAg0ZcWZyFZd8abxDqEASEYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155020; bh=JVqHVSStl05rRMf4wy47ad6sqlqich
    JCXdEePG8PY3w=; b=b5lLi2kF4RsI0CYRFRpSs6Wlj3zM3JJlotIEv7yB80FqF2
    OB0i9K9P/gPKkB1SL/EY1BkCABEYypacuXC2c9EKy9B34Qn/PYgTlWTuNfm0vykx
    VFpBLr8MLsZuqXu7zHCzNpO+wJkyr+k4pVLD9ZS4Os7gcraHh8+xZzQsXv9Jk/XW
    TTrxDkJXz4wB2E0jjbAabQye4afWao82DKpUmztXpU7v+oPNpuv9LY9x4q+ch+eF
    QxgnLGE2yK1FfvuNkSKl9/oOCEsob3a5VsSB/jYipfWUrijP/xnSF5ILXqJtEmzL
    vkooXJ7YxqhmHET1Ho/+Hg9/3bW1/av0v4sTnlRQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Np8e6OdZ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Np8e6OdZ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIenA+Cps+0ULJ9kjdJlD01r+fY9Klib4tUG/9vSI7hsFiVFC6SgKtjDHvfENb+Ms5zDlPiZ4WR+wpyWzAQHB3CoDlX75kXpI3FYkVAm40hxfghnmVxW
    adweSetRKdf/mKvN9GO62+NBBWcGYiO7ZQkXuHi5LdmNMBf3cHBWSZDX/YS/Qykxj9977/TLvvss2pwcwnrcvXkKH8KlFD8CDZJEildDQjKwc58WKoJFr1QB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8 a=QBHdfG-Sftq2nLuhOi0A:9
    a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966217AbeEXJng (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966470AbeEXJnc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        ckadabi@codeaurora.org, Dave Martin <dave.martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.4 23/92] arm64: Add work around for Arm Cortex-A55 Erratum 1024718
Date: Thu, 24 May 2018 11:38:00 +0200
Message-Id: <20180524093201.194544645@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit ece1397cbc89c51914fae1aec729539cfd8bd62b upstream.

Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
from an erratum 1024718, which causes incorrect updates when DBM/AP
bits in a page table entry is modified without a break-before-make
sequence. The work around is to skip enabling the hardware DBM feature
on the affected cores. The hardware Access Flag management features
is not affected. There are some other cores suffering from this
errata, which could be added to the midr_list to trigger the work
around.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: ckadabi@codeaurora.org
Reviewed-by: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/Kconfig                 |   14 ++++++++++++
 arch/arm64/include/asm/assembler.h |   40 +++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h   |   11 ++++++++++
 arch/arm64/mm/proc.S               |    5 ++++
 4 files changed, 70 insertions(+)

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

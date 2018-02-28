Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790656-2-9970881089804452512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790655; b=nwNL8AT/r2axErcBOFF5JVkhfw0GhWedf2ePVj2JvM3UVPI
    fQfe2z7tfjQ8wAmVQajXfaauRdii1hGby8b4sLr3Awgtxn3jJnCwYDlYnfm8j5sM
    2mUTptkrHjT8eZCJH8l/PpFkbO1QjD1+5WULrZ7KiAuisur7VPNuX7aLaeSgCEft
    05g4oj5934rVotARZ9uGfeP80d2oQQcD2RoV/J334Gs75LbZjv+KPeiv7aOp9oAe
    UrKmsnH9HZk5/C4R30NtBy55Gd2MZmcezAHezW8Jk+HglXtzEvlP2K6xn3MZnL/i
    p55Vp4ALz3/FBgK6Dhf2cqswSx6K4j4QKzwBbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790655;
    bh=xF6X5uN03sAA3yMb21/xX2XvZZVdgl9P5oiG1iJTS6M=; b=Vod7mBm2d9yI
    X4ohfPeRkInQfc+ZYptj+t0mbLX3YGhicqbjeyfgBVbLmgpI8vZQ+d2EyK4zWdxH
    naKSXoq1QDD4L4qvAYtwPKRLorvi3zoaHw8VTUJZcc6gEofNMK8nmbtz8VZDAkF5
    3hJcPsG6IyeatCjOLgOYq2nnMs4KF7++wGTDmi59urjZjI5EwtAOfbpC/S03jofg
    ADng48UNA7DTieWPLpLFa0Gv9Ml8J1pfDZu+VfBvd7KImwLP9SzcFFfNqSVlQvSj
    kdWCKiTnxVeoTBVBkPVafAFsELkuMDFOWWbdvSSDrWlVQHmFe+Ixl0DWxOtiBSuR
    QUoCR9ocLQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=B3gaaLmT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qbFxiXqL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=B3gaaLmT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qbFxiXqL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeB1D6m (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:42 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37544 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeB1D6k (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:58:40 -0500
X-Google-Smtp-Source: AH8x2276Ssu5nImPJ5ci7EdlVwXFxyk9sTJtWUEbt7cMTHTBfJ77+Q/xgvioTWL6+4nYqK7RVudQJA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 09/29] arm64: entry: Add exception trampoline page for exceptions from EL0
Date: Wed, 28 Feb 2018 11:56:31 +0800
Message-Id: <1519790211-16582-10-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit c7b9adaf85f8 upstream.

To allow unmapping of the kernel whilst running at EL0, we need to
point the exception vectors at an entry trampoline that can map/unmap
the kernel on entry/exit respectively.

This patch adds the trampoline page, although it is not yet plugged
into the vector table and is therefore unused.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	add asm/mmu.h in entry.S for ASID marco
	add kernel-pgtable.h in entry.S for SWAPPER_DIR_SIZE and
	RESERVED_TTBR0_SIZE
	no SW PAN in vmlinux.lds.S
---
 arch/arm64/include/asm/kernel-pgtable.h |  2 +
 arch/arm64/kernel/entry.S               | 86 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S         | 17 +++++++
 3 files changed, 105 insertions(+)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index e4ddac9..135e829 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -54,6 +54,8 @@
 #define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
 #define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
 
+#define RESERVED_TTBR0_SIZE	(0) /*no CONFIG_ARM64_SW_TTBR0_PAN  introduced */
+
 /* Initial memory map size */
 #if ARM64_SWAPPER_USES_SECTION_MAPS
 #define SWAPPER_BLOCK_SHIFT	SECTION_SHIFT
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 60b202a..f0c6b37 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -29,9 +29,11 @@
 #include <asm/esr.h>
 #include <asm/irq.h>
 #include <asm/memory.h>
+#include <asm/mmu.h>
 #include <asm/thread_info.h>
 #include <asm/asm-uaccess.h>
 #include <asm/unistd.h>
+#include <asm/kernel-pgtable.h>
 
 /*
  * Context tracking subsystem.  Used to instrument transitions
@@ -828,6 +830,90 @@ __ni_sys_trace:
 
 	.popsection				// .entry.text
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+/*
+ * Exception vectors trampoline.
+ */
+	.pushsection ".entry.tramp.text", "ax"
+
+	.macro tramp_map_kernel, tmp
+	mrs	\tmp, ttbr1_el1
+	sub	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	bic	\tmp, \tmp, #USER_ASID_FLAG
+	msr	ttbr1_el1, \tmp
+	.endm
+
+	.macro tramp_unmap_kernel, tmp
+	mrs	\tmp, ttbr1_el1
+	add	\tmp, \tmp, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	orr	\tmp, \tmp, #USER_ASID_FLAG
+	msr	ttbr1_el1, \tmp
+	/*
+	 * We avoid running the post_ttbr_update_workaround here because the
+	 * user and kernel ASIDs don't have conflicting mappings, so any
+	 * "blessing" as described in:
+	 *
+	 *   http://lkml.kernel.org/r/56BB848A.6060603@caviumnetworks.com
+	 *
+	 * will not hurt correctness. Whilst this may partially defeat the
+	 * point of using split ASIDs in the first place, it avoids
+	 * the hit of invalidating the entire I-cache on every return to
+	 * userspace.
+	 */
+	.endm
+
+	.macro tramp_ventry, regsize = 64
+	.align	7
+1:
+	.if	\regsize == 64
+	msr	tpidrro_el0, x30	// Restored in kernel_ventry
+	.endif
+	tramp_map_kernel	x30
+	ldr	x30, =vectors
+	prfm	plil1strm, [x30, #(1b - tramp_vectors)]
+	msr	vbar_el1, x30
+	add	x30, x30, #(1b - tramp_vectors)
+	isb
+	br	x30
+	.endm
+
+	.macro tramp_exit, regsize = 64
+	adr	x30, tramp_vectors
+	msr	vbar_el1, x30
+	tramp_unmap_kernel	x30
+	.if	\regsize == 64
+	mrs	x30, far_el1
+	.endif
+	eret
+	.endm
+
+	.align	11
+ENTRY(tramp_vectors)
+	.space	0x400
+
+	tramp_ventry
+	tramp_ventry
+	tramp_ventry
+	tramp_ventry
+
+	tramp_ventry	32
+	tramp_ventry	32
+	tramp_ventry	32
+	tramp_ventry	32
+END(tramp_vectors)
+
+ENTRY(tramp_exit_native)
+	tramp_exit
+END(tramp_exit_native)
+
+ENTRY(tramp_exit_compat)
+	tramp_exit	32
+END(tramp_exit_compat)
+
+	.ltorg
+	.popsection				// .entry.tramp.text
+#endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
+
 /*
  * Special system call wrappers.
  */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 1105aab..466a43a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -56,6 +56,17 @@ jiffies = jiffies_64;
 #define HIBERNATE_TEXT
 #endif
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+#define TRAMP_TEXT					\
+	. = ALIGN(PAGE_SIZE);				\
+	VMLINUX_SYMBOL(__entry_tramp_text_start) = .;	\
+	*(.entry.tramp.text)				\
+	. = ALIGN(PAGE_SIZE);				\
+	VMLINUX_SYMBOL(__entry_tramp_text_end) = .;
+#else
+#define TRAMP_TEXT
+#endif
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -128,6 +139,7 @@ SECTIONS
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
 			HIBERNATE_TEXT
+			TRAMP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
 		. = ALIGN(16);
@@ -216,6 +228,11 @@ SECTIONS
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
 
+#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
+	tramp_pg_dir = .;
+	. += PAGE_SIZE;
+#endif
+
 	_end = .;
 
 	STABS_DEBUG
-- 
2.7.4

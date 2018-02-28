Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3220176-1519790488-2-16050908896381570103
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
    t=1519790488; b=a3XSlP3PQaKB3+b3u+cguC+C2/zyLY5vpLTSqPvlLnhqPoa
    kM/Ywe6MMaxODu+k/suUYTkIIM/iUlcTUzyDYyT4bbrMwKr/mKArjnjobhgcxRvE
    hA2DxzDkWC+di7yusjsVZwgOCNquo4oh6mgRh8Tp6NXJgY+a6QCdXkVJoWnErDP8
    qw69ABgF9i5rJy071rhieB6/GDLfQ9CU9CJsEi8unbjtR8F4OnypB2RguVdnSE//
    rrtTusic5WkGk4kV6t5ksxdQP/kPrem7kVho2xDUMBt4XPPjJwoBmxXJA0rIiLCO
    tHozsnDajMZ2ot57nyxwM0gw4lSyy74woGxG9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790488;
    bh=bmODirOIrB4Uq31RHiBfVSkaHJATLnMI0vQEAhunKG8=; b=cr9cSqH0GOUS
    RRjpMMpBuuia8psYLNpEHmNtaPkXQfimooS2Kq7jEa9Mc4PQhDdgUuOoKKR/QHZW
    tELuV79YXMoGsD5QcDDfbPYzSIlNScYW7n5chUbProtIPjS8z3q2DySBfeBX/Nb6
    ss2MQnxKN63vVkqWVXOj5axsQKF8azQgfPOXdCiO4UXF9H1IPqfDbyzdbyuvQ/Gm
    BSmvDF/1UEIYFMHgVSWvo6ZpW8nwl5UhhQXcY4perx8JP624Fb7ht66dTam5pk4n
    EHoTOe4De345Ceq8t8xVZfNQz6mPaYzwXAyClA2VOxqwWIC8prUqln5rIRCSYR9T
    CZqvMPA+RQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OFGVOi3h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZKaX9jY5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=OFGVOi3h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZKaX9jY5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeB1EBL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 23:01:11 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36363 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752447AbeB1EBK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 23:01:10 -0500
X-Google-Smtp-Source: AH8x227SuX5WwZFgwfKuExpUc9zfYuA6ARG9YyVBTDtrAM/EiLSQ65zuPy7YXAAGQjCPhcnwvXXmFg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 29/29] arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives
Date: Wed, 28 Feb 2018 11:56:51 +0800
Message-Id: <1519790211-16582-30-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 439e70e27a51 upstream.

The identity map is mapped as both writeable and executable by the
SWAPPER_MM_MMUFLAGS and this is relied upon by the kpti code to manage
a synchronisation flag. Update the .pushsection flags to reflect the
actual mapping attributes.

Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpu-reset.S | 2 +-
 arch/arm64/kernel/head.S      | 2 +-
 arch/arm64/kernel/sleep.S     | 2 +-
 arch/arm64/mm/proc.S          | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 65f42d2..f736a6f 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -16,7 +16,7 @@
 #include <asm/virt.h>
 
 .text
-.pushsection    .idmap.text, "ax"
+.pushsection    .idmap.text, "awx"
 
 /*
  * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 539bebc..fa52817 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -473,7 +473,7 @@ ENDPROC(__primary_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".idmap.text","ax"
+	.section ".idmap.text","awx"
 
 ENTRY(kimage_vaddr)
 	.quad		_text - TEXT_OFFSET
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 1bec41b..0030d69 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -95,7 +95,7 @@ ENTRY(__cpu_suspend_enter)
 	ret
 ENDPROC(__cpu_suspend_enter)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5c268f5..c07d9cc 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -83,7 +83,7 @@ ENDPROC(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -147,7 +147,7 @@ alternative_else_nop_endif
 	ret
 ENDPROC(cpu_do_switch_mm)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, empty_zero_page
@@ -180,7 +180,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	.popsection
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 	.macro	__idmap_kpti_get_pgtable_ent, type
 	dc	cvac, cur_\()\type\()p		// Ensure any existing dirty
@@ -368,7 +368,7 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  *	Initialise the processor for turning the MMU on.  Return in x0 the
  *	value of the SCTLR_EL1 register.
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
-- 
2.7.4

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835525-2-12030858093000368530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835524; b=snnTIYc5clr9zFeMaMAAM5dZIg4zmoFFtnowIxs53O9imY1
    pFwjuPTt+ticibm7bss7op2kaWuXjuzBA+Wxh6ATOsAG7O4m0rJBR+ssFIhmZ6gf
    Yx0LeL/XxoH+IYbVnCWWtFXe1N7B5n/LwZVjqsT5K6m0fuzSrFVj4rvs8VQZ5Ag+
    2qbMYQqcaoCdJknjiY+AGbPMjoCvaR/t9qA6O0OPuw2dtdjh6wry9mOwmVEixGIQ
    lLmLjgWDVjE+6In20FbX+WgEuWvAyDIkH6WK99ji8vHaMQMFov3+d19ow6CwbQrB
    X/pQw90BgVa5p1X76qZG/ygu34lBIv0F82gWMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835524; bh=ZKRNdQ7NGDJHH9ciw47
    2GfNUG+B0yG6FSlrNMgota3M=; b=MokdfXsVKdOHsySqJaxLqo2nX7sl1lY7w5e
    6fUC85gwH3Cze2VpOzdFozh2vD1j9/HGGL1d1bor2lHlW3UByw4xKGBvLCT9wT/Q
    FuNkNf1532e1kApSkOVlq92z4unZfJrU0G18q/XKxcww9U7wN4rVfdoxgNSNzp6r
    kxxNX11ngTUX0OQXty3I7cfhvixyGZgTBpSR9Pix8fm/HruIDXoLI5Vdv0uel7Xk
    I/1A6p6Gly+TMllTNdZw6AM3+UADq2tCbyMW8luNBTeuDFWEWtUOXS2c4kZfBFUD
    behtEdEMj9R0PLlSrl86srYCw9pVDMEG0XlKIDi4ALnlx1J/uWA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932760AbeB1QOy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35129 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933021AbeB1QOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:14:52 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        "Ezequiel Garcia" <ezequiel.garcia@imgtec.com>,
        "Markos Chandras" <Markos.Chandras@imgtec.com>,
        "Paul Martin" <paul.martin@codethink.co.uk>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, "James Hogan" <james.hogan@imgtec.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.158675123@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 101/254] MIPS: Fix a preemption issue with thread's
 FPU defaults
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@linux-mips.org>

commit 03dce595270f22d59a6f37e9170287c1afd94bc2 upstream.

Fix "BUG: using smp_processor_id() in preemptible" reported in accesses
to thread's FPU defaults: the value to initialise FSCR to at program
startup, the FCSR r/w mask and the contents of FIR in full FPU
emulation, removing a regression introduced with 9b26616c [MIPS: Respect
the ISA level in FCSR handling] and f6843626 [MIPS: math-emu: Set FIR
feature flags for full emulation].

Use `boot_cpu_data' to obtain the data from, following the approach that
`cpu_has_*' macros take and avoiding the call to `smp_processor_id' made
in the reference to `current_cpu_data'.  The contents of FSCR have to be
consistent across processors in an SMP system, the settings there must
not change as a thread is migrated across processors.  And the contents
of FIR are guaranteed to be consistent in FPU emulation, by definition.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Tested-by: Paul Martin <paul.martin@codethink.co.uk>
Cc: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10030/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16:
 - Drop change in cop1_cfc()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -277,7 +277,7 @@ do {									\
 									\
 	current->thread.abi = &mips_abi;				\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
 } while (0)
 
 #endif /* CONFIG_32BIT */
@@ -337,7 +337,7 @@ do {									\
 	else								\
 		current->thread.abi = &mips_abi;			\
 									\
-	current->thread.fpu.fcr31 = current_cpu_data.fpu_csr31;		\
+	current->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;		\
 									\
 	p = personality(current->personality);				\
 	if (p != PER_LINUX32 && p != PER_LINUX)				\
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -177,7 +177,7 @@ int ptrace_setfpregs(struct task_struct
 
 	__get_user(value, data + 64);
 	fcr31 = child->thread.fpu.fcr31;
-	mask = current_cpu_data.fpu_msk31;
+	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
 
 	/* FIR may not be written.  */
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -934,7 +934,7 @@ emul:
 				 * Preserve read-only bits,
 				 * and convert to ieee library modes
 				 */
-				mask = current_cpu_data.fpu_msk31;
+				mask = boot_cpu_data.fpu_msk31;
 				ctx->fcr31 = (value & ~(mask | FPU_CSR_RM)) |
 					     (ctx->fcr31 & mask) |
 					     modeindex(value);

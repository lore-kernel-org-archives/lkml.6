Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387443-1519634268-2-455146893846663400
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519634267; b=DD0Kh5Aehz/iqVVIawbJHTnmatU0aHR2kZNmCVbrFhas7hh
    woY8cVjXEJddqcF40I8Sligpe6v2gnCV/HEhj/jVpSuNIC6Jb9PwOcjdgzLiT2tC
    4pf+gISG7DiQA9l2aGIpgGfWkiHRQeVH7Dwf75/YmqPKrxQ+69nrINa3myq3meLz
    xCHR1U9Rg+43v05PVwMPPJD2g8erjJhtoEz17eFGLAiiXfW/r/GfKYph9UsiUcVV
    U9239QCwlDe/O1izHbuZ1qcmtEi77/Uaz2CGvncdGJw7UstMDsBE8rNZrDMvZnxL
    tkL9gsdvJ7tTPfkoH9bjtTXENLL2Jch0bvqWCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634267;
    bh=taE8mK2Ip25XXu3tH/TfrJ9TiKkrcCk7pgR93VQ9+cc=; b=HQRzWIbMwimO
    8veOMIjL1lDCFRXhN/w4eCpl5mENUDrDln8k38ZAc3UKNeoF02GznGL7HQL2ajkK
    avA9kSMKlXImL5Mu8GCySrFA9h1X0imPuUe1RO0vUBS9DaC2JVLkQbdEnfzv9o/o
    PrYKbva7oZoaiNJmecXmuH/UkiKKGhc+KepMNGVgaDfXd5PpamBXceVT5/9QhTkH
    ifsN8yTJhDTyYkwpvVjuljKG1ynNsiETzjq3yF9I3Z6VDxlKfv4Ht0iPvDhqjFKG
    StLszy3gfiBgqk2ekiydJzDD/2zLAqTPA2k7iRgkHb5L7x7Q0HWBXAWVw8aW/jSZ
    docF/ByVuw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=MDioq7zh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eY6CvPdt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=MDioq7zh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eY6CvPdt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeBZIWl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:22:41 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39962 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbeBZIWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:22:35 -0500
X-Google-Smtp-Source: AH8x227cgyhkICptFyc3f3w+5c5qFNMjmqE0Lofohde7V156XP1zHpApYtehiI2PCxrjfZoWjTWzAA==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 12/52] arm64: entry: Ensure branch through syscall table is bounded under speculation
Date: Mon, 26 Feb 2018 16:19:46 +0800
Message-Id: <1519633227-29832-13-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 6314d90e6493 upstream.

In a similar manner to array_index_mask_nospec, this patch introduces an
assembly macro (mask_nospec64) which can be used to bound a value under
speculation. This macro is then used to ensure that the indirect branch
through the syscall table is bounded under speculation, with out-of-range
addresses speculating as calls to sys_io_setup (0).

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/assembler.h | 11 +++++++++++
 arch/arm64/kernel/entry.S          |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ab3a179..a109d30 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -94,6 +94,17 @@
 	.endm
 
 /*
+ * Sanitise a 64-bit bounded index wrt speculation, returning zero if out
+ * of bounds.
+ */
+	.macro	mask_nospec64, idx, limit, tmp
+	sub	\tmp, \idx, \limit
+	bic	\tmp, \tmp, \idx
+	and	\idx, \idx, \tmp, asr #63
+	csdb
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 48c41ff..0a27e12 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -233,6 +233,7 @@ alternative_else_nop_endif
  * x7 is reserved for the system call number in 32-bit mode.
  */
 wsc_nr	.req	w25		// number of system calls
+xsc_nr	.req	x25		// number of system calls (zero-extended)
 wscno	.req	w26		// syscall number
 xscno	.req	x26		// syscall number (zero-extended)
 stbl	.req	x27		// syscall table pointer
@@ -754,6 +755,7 @@ el0_svc_naked:					// compat entry point
 	b.ne	__sys_trace
 	cmp     wscno, wsc_nr			// check upper syscall limit
 	b.hs	ni_sys
+	mask_nospec64 xscno, xsc_nr, x19	// enforce bounds for syscall number
 	ldr	x16, [stbl, xscno, lsl #3]	// address in the syscall table
 	blr	x16				// call sys_* routine
 	b	ret_fast_syscall
-- 
2.7.4

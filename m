Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909634-2-17972401592411552590
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
    t=1519909634; b=SX0ObdUuN8UVIP8rYBsmAGoWNSo/a497tggCsGpHI3YFAqu
    P3zdwfkImwVoxhEz+VIkU9P3ojmQ9fb6c+f+ZBjsCtFVl7XYEsj2mOQFk6Y+3elj
    12S6rrMeQqP5pSMpembpuANhuxJIT57sVbAOI8c1XmWx4CSQXSdNMkwJRE9xa4L1
    NOJvtG0vl8NRy7R4eEL/AkK3Z61vd+VyAwQtpWXkkPXRccl7ni2U8iVFzRBLz+0y
    M/HWVmA8p+cCnWkm9kLnFPxj+CNXKseAUZys4u947YkLkC9t64VvB2x38E8Jwkr/
    VMDeyaQ0UjlbkLVsES966TZWmPXBlE5ri4WMODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909634;
    bh=taE8mK2Ip25XXu3tH/TfrJ9TiKkrcCk7pgR93VQ9+cc=; b=CfQPuB+B32di
    sJwv0Z/NeoJlEySOcx/ZPq1rwAQsR05oEuLV3O0vY7+YhkCGPJbCx4PBklMzILwI
    rh4WHB7DxyFn4h2EmgOlb6y8XBMP4m2mmVjBxo11mybymEmnLXqpO0HOCY2skZ69
    aB1qXTAO3JY1HghB9JotSXX6ib9QNo1gKsWgfbKkLGJW7EdaZv4Y7ANUZCCStHzb
    6JP1UWhjlDMP6N9UuH9xoRL9a8kI2HUM2mMA8GyLQkxFDIDysGxgsK738bGHMWVL
    MVaY5cNwDppVT6zoZK6aBygtH+HfKymF0SBo/GPxEy8k2dDG71Z0idigVisaCvmf
    9y3tqOjYHg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kIYle+vW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fDW9KDk/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kIYle+vW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fDW9KDk/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030759AbeCAM4u (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 07:56:50 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43814 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030574AbeCAM4q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:56:46 -0500
X-Google-Smtp-Source: AG47ELuv/FAMQWZcYlhzO6Tl8vm2lDOXrqruvSvHD/K8ItNBJDPZ+WHb46Z1AT35qz85SQeACgfeZg==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 12/45] arm64: entry: Ensure branch through syscall table is bounded under speculation
Date: Thu,  1 Mar 2018 20:53:49 +0800
Message-Id: <1519908862-11425-13-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
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

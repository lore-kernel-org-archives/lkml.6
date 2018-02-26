Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387525-1519634340-2-10647451957789628596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519634340; b=HXaU+fkLL0v0MxOT0F0ZCE0+h5Sf10YDpwfNkuT/Bt3zeZq
    +feDCRKEP7u/A/CNFjD8arHJBOm9r3dE5tsMZUC/r/ljwQCZgjhEMzcESOgQ8NOW
    bAhjxu3X2hYr/V7OnJrt4Cs+PamPuhhcucipFG/ocIJ6Ez/9mAW8TtvOQ9Md8R8q
    7T1jnn/gu79qMSq9nbS+RHKxcR5rH3Dx2/fiTLSVgwCgkUQHFHFH9B5+bAG0OEAr
    ao14lcH6z6rn36POW6zJyR6oJ8lLN1AIGUm+pQ0DXeRJpbbXPQUFocZshyyqQ/e7
    g6PNdpLoE8KLJLC+6zp+hvlucbKFERdglSfl13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519634340;
    bh=5jc9doNqehmWExc3XoeNI1qQ6N7FZfbJliUkP3bf70M=; b=lkycZWm4AQXd
    j/3k7LcDYaWsSl7sdVMyU0+VkJE3rD7p7kOYWjDFq/fIHK/7rZlT1pA+4KvfU4DR
    q3OtZErAM7NYdytJJVFCoTK/g7OVnJEu6htANx8hfziALuAkP8AoGBRLbW1uz/LS
    bwXqpJHzpVzv8Bc/2R1PO8CpAk114ygIXD55u3tnO/CBvMAf2aMTOuI037727sMb
    6qJl6PpyhqFvWalseYYEj7bGJXk10RCuaL96kAYmLGZPa7LfUi5fd0Je/XQzeBYA
    3G3k/YJCXr7a6e5EicEsdZPZbmgj4QiedgH/JWErqm4HYl5ujoH8WIACFCfUVRDQ
    P+sJ6ObABA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=KoMrLdBO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BPCPB447;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=KoMrLdBO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BPCPB447;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeBZIVb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 03:21:31 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37488 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbeBZIV1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 03:21:27 -0500
X-Google-Smtp-Source: AH8x225B51oXuwk6vZ099Vq5O/ubenMS+Eu4pPYS3bGu0x32d3UhNlP3EJ25dl2otJBuezKpkDt6QQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/52] arm64: barrier: Add CSDB macros to control data-value prediction
Date: Mon, 26 Feb 2018 16:19:37 +0800
Message-Id: <1519633227-29832-4-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 669474e772b9 upstream.

For CPUs capable of data value prediction, CSDB waits for any outstanding
predictions to architecturally resolve before allowing speculative execution
to continue. Provide macros to expose it to the arch code.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>

Conflicts:
	arch/arm64/include/asm/assembler.h
	no psb_csync in arch/arm64/include/asm/barrier.h
---
 arch/arm64/include/asm/assembler.h | 7 +++++++
 arch/arm64/include/asm/barrier.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 851290d..8760300 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -87,6 +87,13 @@
 	.endm
 
 /*
+ * Value prediction barrier
+ */
+	.macro	csdb
+	hint	#20
+	.endm
+
+/*
  * NOP sequence
  */
 	.macro	nops, num
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 0fe7e43..c68fdc5 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -31,6 +31,8 @@
 #define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
+#define csdb()		asm volatile("hint #20" : : : "memory")
+
 #define mb()		dsb(sy)
 #define rmb()		dsb(ld)
 #define wmb()		dsb(st)
-- 
2.7.4

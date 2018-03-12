Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3235374-1520820158-2-18217900240915564426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  RCVD_IN_SBL 0.141, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520820157; b=SCyAgiCBFxV0s0bidSa6NLE30tuMgAL3cRpCwZyQrGkJmK6
    QPb0N7XOtRJHsvFL3ZzUs8HjL5A0GoRKbx6shCjLf/I8fIVgQ3gZzqRuQIrrU9/K
    uRU7+O7LsbuKLG+O0mdVMu1h67VIvDmCnmmQHFWDgWBZ7096YzylIR/2XO9igKdo
    ZXbVW+N1Q4x4fZ6/YXdrVPkESnDjG8cvLhdZ7vvo1P7T2hCTZtKrXq8GlxfZjche
    5RNiM0F+LHysqwkOkfA2k9M5sRgD/qCyimXDZfeqQ1MbYB0+ozRiwwphGEXIs57n
    qtDgqaKsG6n1NR1Ma2V0UkH9uahpB1Xv8ooGUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520820157; bh=MFIDtUr/Kn1dn/r/qzotSMa5Wu
    YQqNv14xsckZ/fSJ8=; b=umMjWLxPtYvm5KTGoSK2YlMUsgcnn2/jlp2GMOO0+j
    JwmfX6+k36nHXnM6g4PFju8FYMLqM04EQFboaDty8Fra1BROx1md6b4ovDTDafY9
    xyUNiOAli5uyzN3MkmRN3MNwmSlbaWrXzbeyeUostZfndOwPXOIKxPTi5hnkTseR
    tXtBTPrgaojy+02hB73US0RN/FX3PsIDkggsGgclLXvWnpZqAzyQ71IX4btMDBve
    mjZPbmeTN8wspL7/zeSIiRsHUoOvbq8ZA1c1zuExV1/q8SNmmcqMG8l/FptBpDZi
    bc5GFiNF/uxOnvfetbhx5W1VaQcgjjwSaVfmmW/xicMw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uJE7VJRD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lemote.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PVttYG+o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lemote.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uJE7VJRD x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lemote.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PVttYG+o;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lemote.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932490AbeCLCCd (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 22:02:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45364 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932419AbeCLCCc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 22:02:32 -0400
X-Google-Smtp-Source: AG47ELuWcL3AW8nEXKYfgRZ6AphkpwoaHIu92OifbQ1iyp5a2HLfwsTHrjmtmHehnM8FaS0WsbUOfA==
From: Huacai Chen <chenhc@lemote.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2] ZBOOT: fix stack protector in compressed boot phase
Date: Mon, 12 Mar 2018 10:04:17 +0800
Message-Id: <1520820258-19225-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Call __stack_chk_guard_setup() in decompress_kernel() is too late that
stack checking always fails for decompress_kernel() itself. So remove
__stack_chk_guard_setup() and initialize __stack_chk_guard before we
call decompress_kernel().

Original code comes from ARM but also used for MIPS and SH, so fix them
together. If without this fix, compressed booting of these archs will
fail because stack checking is enabled by default (>=4.16).

V2: Fix build on ARM.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/arm/boot/compressed/head.S        | 4 ++++
 arch/arm/boot/compressed/misc.c        | 7 -------
 arch/mips/boot/compressed/decompress.c | 7 -------
 arch/mips/boot/compressed/head.S       | 4 ++++
 arch/sh/boot/compressed/head_32.S      | 4 ++++
 arch/sh/boot/compressed/head_64.S      | 4 ++++
 arch/sh/boot/compressed/misc.c         | 7 -------
 7 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 45c8823..bae1fc6 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -547,6 +547,10 @@ not_relocated:	mov	r0, #0
 		bic	r4, r4, #1
 		blne	cache_on
 
+		ldr	r0, =__stack_chk_guard
+		ldr	r1, =0x000a0dff
+		str	r1, [r0]
+
 /*
  * The C runtime environment should now be setup sufficiently.
  * Set up some pointers, and start decompressing.
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 16a8a80..e518ef5 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -130,11 +130,6 @@ asmlinkage void __div0(void)
 
 unsigned long __stack_chk_guard;
 
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
-
 void __stack_chk_fail(void)
 {
 	error("stack-protector: Kernel stack is corrupted\n");
@@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 {
 	int ret;
 
-	__stack_chk_guard_setup();
-
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index fdf99e9..5ba431c 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -78,11 +78,6 @@ void error(char *x)
 
 unsigned long __stack_chk_guard;
 
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
-
 void __stack_chk_fail(void)
 {
 	error("stack-protector: Kernel stack is corrupted\n");
@@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
 {
 	unsigned long zimage_start, zimage_size;
 
-	__stack_chk_guard_setup();
-
 	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
 	    (unsigned long)(&__image_begin);
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
index 409cb48..00d0ee0 100644
--- a/arch/mips/boot/compressed/head.S
+++ b/arch/mips/boot/compressed/head.S
@@ -32,6 +32,10 @@ start:
 	bne	a2, a0, 1b
 	 addiu	a0, a0, 4
 
+	PTR_LA	a0, __stack_chk_guard
+	PTR_LI	a1, 0x000a0dff
+	sw	a1, 0(a0)
+
 	PTR_LA	a0, (.heap)	     /* heap address */
 	PTR_LA	sp, (.stack + 8192)  /* stack address */
 
diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
index 7bb1681..a3fdb05 100644
--- a/arch/sh/boot/compressed/head_32.S
+++ b/arch/sh/boot/compressed/head_32.S
@@ -76,6 +76,10 @@ l1:
 	mov.l	init_stack_addr, r0
 	mov.l	@r0, r15
 
+	mov.l	__stack_chk_guard, r0
+	mov	#0x000a0dff, r1
+	mov.l	r1, @r0
+
 	/* Decompress the kernel */
 	mov.l	decompress_kernel_addr, r0
 	jsr	@r0
diff --git a/arch/sh/boot/compressed/head_64.S b/arch/sh/boot/compressed/head_64.S
index 9993113..8b4d540 100644
--- a/arch/sh/boot/compressed/head_64.S
+++ b/arch/sh/boot/compressed/head_64.S
@@ -132,6 +132,10 @@ startup:
 	addi	r22, 4, r22
 	bne	r22, r23, tr1
 
+	movi	datalabel __stack_chk_guard, r0
+	movi	0x000a0dff, r1
+	st.l	r0, 0, r1
+
 	/*
 	 * Decompress the kernel.
 	 */
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index 627ce8e..fe4c079 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -106,11 +106,6 @@ static void error(char *x)
 
 unsigned long __stack_chk_guard;
 
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
-
 void __stack_chk_fail(void)
 {
 	error("stack-protector: Kernel stack is corrupted\n");
@@ -130,8 +125,6 @@ void decompress_kernel(void)
 {
 	unsigned long output_addr;
 
-	__stack_chk_guard_setup();
-
 #ifdef CONFIG_SUPERH64
 	output_addr = (CONFIG_MEMORY_START + 0x2000);
 #else
-- 
2.7.0

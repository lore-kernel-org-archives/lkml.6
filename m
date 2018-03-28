Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886210-1522226817-2-12108896383863247610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  RCVD_IN_SBL 0.141, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522226816; b=J1nV1LjC1LB5yNpArVHhx8AMDybBtrD7LvT55bfJy76pw0Q
    ReuR6Oe9n5NW7qOC/MURAj1e2TEPenwS2tT1srITZ80o+zckkTkaoHfcAV3PFoYE
    4P+bmpBhNLexYDaTvxAsi45KpKAuoH9ruF6YWDiLN6hixGnKjoBxr7ZR/e+MEXhU
    QRqv0n5zO6WXoBSKYZsg1tKA470VlcQtRYLfXhdZtJ7TEeiBT7XQSMPyhwuwPF9F
    0CDyN8u+eDwbdmwzlwNPNddxy7b8AA+ftWtx/ll9QCh4WrUoXZPXTzG9WOtwvGnf
    598c430CKmw9Mf7FY9t/bvpmSFiBOg4VmYGvqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522226816; bh=8GZGcSurecrsTVxb6yqZqI1ILc
    Yj7HVhPQ9TN4Nh43A=; b=bzpG0V3xdbEQoZ4ccTIjT2fuH5TmpxffQPVMNeJesu
    nHKtTh+gfiT6785oKHP/7aMg5ntmvx3+oNo+wEMvd6D8NJeRxCvYa0ryu2aviQ/3
    5uPcXKfgkq+lDUS+Lu99SM17w87CJtt/1ldTQiKKUjqvjb2B5Yxc6ZX7vxAxqQKu
    FP7Wfx28yTniGbyUrdP7oyWqgrJgq08EkltotTTgXCz+FrAMNcwxdslvZGTFQa7U
    U4Uo4/lwcpOaJomBdV2Uses0QnJ97TP+0E2QGroWSuTCTMCRb9d4pWJFvDdzwHyI
    3Bnos/YDjvhCTOI1reRQNovAYlBclVCEgtYPHp20y/bA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SXqdOjdv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lemote.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TBylv0M8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lemote.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SXqdOjdv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lemote.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TBylv0M8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lemote.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPl7AbGCUMYzH5CtpL1cFOGMd4GEdotp33kI6lLV3lcfWXLhuoyPxBh5oYvxdquYSHlspnNvz33sxEVTa9CA/nyC8fA8DXIpoQjsszOIQe6Rph48/RQG
    w8e4SWsPaj2UBWsgbwG6aENGTwU0dKlS0AJxtIdyY6l90eC5QKAZmjLBLtm06rrKmgk/0mXoPv4W24o321tei8G13IFST9k6PYsTwpfqJPQ/+OxrxZYZz/TY
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=nAebDoNsAAAA:8 a=DSKLSbsUSFY9NT6ptBgA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=ego-_vB8GfJOOuXVi8J-:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeC1Iqx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 04:46:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33174 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeC1Iqu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 04:46:50 -0400
X-Google-Smtp-Source: AIpwx48SvZNB4jyj+PD3m9/aAdKaemhU/kkK1WiQNLrkyJdYSx0e1kXisr32kYr0r6hWEgKTzY/qag==
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
Subject: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot phase
Date: Wed, 28 Mar 2018 16:48:53 +0800
Message-Id: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
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

V1 -> V2: Fix build on ARM.
V2 -> V3: Fix build on SuperH.
V3 -> V4: Initialize __stack_chk_guard in C code as a constant.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/arm/boot/compressed/misc.c        | 9 +--------
 arch/mips/boot/compressed/decompress.c | 9 +--------
 arch/sh/boot/compressed/misc.c         | 9 +--------
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 16a8a80..e8fe51f 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -128,12 +128,7 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -150,8 +145,6 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 {
 	int ret;
 
-	__stack_chk_guard_setup();
-
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
index fdf99e9..81df904 100644
--- a/arch/mips/boot/compressed/decompress.c
+++ b/arch/mips/boot/compressed/decompress.c
@@ -76,12 +76,7 @@ void error(char *x)
 #include "../../../../lib/decompress_unxz.c"
 #endif
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
@@ -92,8 +87,6 @@ void decompress_kernel(unsigned long boot_heap_start)
 {
 	unsigned long zimage_start, zimage_size;
 
-	__stack_chk_guard_setup();
-
 	zimage_start = (unsigned long)(&__image_begin);
 	zimage_size = (unsigned long)(&__image_end) -
 	    (unsigned long)(&__image_begin);
diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index 627ce8e..c15cac9 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -104,12 +104,7 @@ static void error(char *x)
 	while(1);	/* Halt */
 }
 
-unsigned long __stack_chk_guard;
-
-void __stack_chk_guard_setup(void)
-{
-	__stack_chk_guard = 0x000a0dff;
-}
+const unsigned long __stack_chk_guard = 0x000a0dff;
 
 void __stack_chk_fail(void)
 {
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

Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3218881-1519790677-2-3727163227296623719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519790676; b=eegwPvbLO/xHWvP7MSuIsXFZjAdFfrbejAhR01/Kq3i8FEq
    v8dIss6qSVvr1jJJ2EUDiTPlEZUiGaKKbaxGoAwIl82mA/8oNDGVxaquQUHQudSo
    Z+IBtzrOxC7yMBrSfiuNJ5odd9MTgwl5F9sQL1xkRqWEYEYxapu6qKz6rcPvSkN8
    psMF6g8xWd3X8dsSlpuJ1VrxA3J3IUygAxJauyVgtXCl73FBTELNNeKbPi9ogZlo
    9r7FcZ1u3t487su00e0glKGB+8EOZ1CvkXz2ZP81LGtg4sAzHguKOYCWmEPgMuZX
    LqBAnm2NxX4SnvIt+fnKg/QgxhU/3CoF9Iya7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519790676;
    bh=CnBAWrPsMy6/oPLDU3/iiTfetB2B2cU6YnCOS/tfJT8=; b=tWrG3XRawo/w
    znqIfpxLguVnEEy0wiNv4suIIXW7LhOzEdc+StLREZFRq/2Nwso342fbutfu4HkI
    tss0spnPrT3H7gU8WXaOAwWbks5R61wMjEjXPeJ3w/uG7QvUSKj63RRM3Uxco88Y
    ooZX/HwaBdP/pJxx8dz0IMMySQ+905DF4Rb+Ui9JvPA/+uS7ZpE6wmj2vZv3oqHi
    K7ic1838b6dao7y05VHZaAUXN5Z5MPIlon9ubOr/FO6sByoaHQ27Rd0YO6IkbSJl
    a9FfI/ibWaDGKJ+oBfFPNhzfT+Xl9MeMLioxCDjXdq5kdveJNJBj4FURiV8senBc
    xFU69BH62g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=h7zHUAXD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pZeyR1v2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=h7zHUAXD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pZeyR1v2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeB1D6I (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 22:58:08 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44052 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeB1D6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 22:58:06 -0500
X-Google-Smtp-Source: AH8x227F1dSnjXMRA88Vt6JAODMuHBKSWux92ZhhgqDd0QuvLKDWH6wRr2fjgQo1KtKzALsca7cb6w==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 05/29] arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
Date: Wed, 28 Feb 2018 11:56:27 +0800
Message-Id: <1519790211-16582-6-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Will Deacon <will.deacon@arm.com>

commit 9b0de864b5bc upstream.

Since an mm has both a kernel and a user ASID, we need to ensure that
broadcast TLB maintenance targets both address spaces so that things
like CoW continue to work with the uaccess primitives in the kernel.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Tested-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/tlbflush.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index deab523..ad6bd8b 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -23,6 +23,7 @@
 
 #include <linux/sched.h>
 #include <asm/cputype.h>
+#include <asm/mmu.h>
 
 /*
  * Raw TLBI operations.
@@ -42,6 +43,11 @@
 
 #define __tlbi(op, ...)		__TLBI_N(op, ##__VA_ARGS__, 1, 0)
 
+#define __tlbi_user(op, arg) do {						\
+	if (arm64_kernel_unmapped_at_el0())					\
+		__tlbi(op, (arg) | USER_ASID_FLAG);				\
+} while (0)
+
 /*
  *	TLB Management
  *	==============
@@ -103,6 +109,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
 
 	dsb(ishst);
 	__tlbi(aside1is, asid);
+	__tlbi_user(aside1is, asid);
 	dsb(ish);
 }
 
@@ -113,6 +120,7 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
 
 	dsb(ishst);
 	__tlbi(vale1is, addr);
+	__tlbi_user(vale1is, addr);
 	dsb(ish);
 }
 
@@ -139,10 +147,13 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 
 	dsb(ishst);
 	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
-		if (last_level)
+		if (last_level) {
 			__tlbi(vale1is, addr);
-		else
+			__tlbi_user(vale1is, addr);
+		} else {
 			__tlbi(vae1is, addr);
+			__tlbi_user(vae1is, addr);
+		}
 	}
 	dsb(ish);
 }
@@ -182,6 +193,7 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
 	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
 
 	__tlbi(vae1is, addr);
+	__tlbi_user(vae1is, addr);
 	dsb(ish);
 }
 
-- 
2.7.4

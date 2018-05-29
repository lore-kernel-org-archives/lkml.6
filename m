Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524644-1527568689-2-5589553082020997401
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527568689; b=bozCH5Hag5H3TKt0ecoE2ihw6DGy1iqg/I+OVGQEP6BRk7p192
    ib6eeCjC5e865drnKzrdJHDCXXg+ufkLFLtwu0qzGD42y/z6lDvsDKJRlUxjdHyf
    Cb1HvpcygvwmItEPRzXspuBZtIWxmD6Qu9XKxdDtwHM3WOVlhaqTZ9a4sTOIPHJl
    p1PR9iTlMyuoNhPHQtuR7N9mhOTcsfPalh7fJtqYTE8DJm97zFd1I0JHU4FOPZPT
    NOoqX/qFNwtwFI6EFuY0wq33kh/QEgZ45R+G9INChwx1E9N250MbXLnK/kWifaPF
    /+XlhOtPCdqvQHq77LiC9gpk3tZgbduoXQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527568689; bh=eVKWuin8ojDTyu/ISjUjLwp+q5dCJF
    2UCAv3aRecJIo=; b=kjhozvTwsUy8gjb9bQmAPcXJ7NforS9cW14cVNJH1KwjCg
    NcsVFdHm9moeeTGgKg6MHG3tQIe8ws+/qx6VGIvoSZs9BxWgeDv3G3zXzFijbIta
    dOtbNgddWLzJVN3YwcC7+RozXRFyeGKltLc14Q1okHm1kIBsQa6npgtcVgHqffnY
    cRr8D4EaUKvhjcI94KVeKKrg6pffq/NYAjWuZD1cO1uh4OSceW/Ul3+2SrW9JfRJ
    RmVz9SkQbzGeIOIPg8WZEkFL9aI3l8ZlVljo/mMw4lRWF7ky9+KL/mvsTEy/a5IP
    aTUgTka69CLvjgVAbfegQvQWp3y0SHNR3d5VWiZQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Fo1pQZTX
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=WSrw+VOS;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Fo1pQZTX
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=WSrw+VOS;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPjDEi20nrRl9idHm6nOtmyh0FVOe5GiDEJ8tGZhOZL3zaUYzltTVl5RcLbYbT+mlL5UMTQrt/cl1xEkUNI4b8b4ob61UuL4Ruwp1rROx9+YwBS9vuf7
    H8BvxeD7GG7x5COGmPLZ05x1GASgBUDocKZCjMuq9UE2RMepejPuH5p4G8cHG5CLuEM001SMhoyT2n4EgE4SVvDLuIsPKB2C7ghKA8kj/wGjoTNfEho/O8td
    KxF0MYlBfQL0HDSDuC772Q==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=agizdKYkGd8A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=JdCCw2yMBO0zwpTDC10A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeE2EiF (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 00:38:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38857 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754541AbeE2EiB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 00:38:01 -0400
X-Google-Smtp-Source: ADUXVKKfcKuikrhJ/PjJLTBgbVjrov9LmJalFk2zAsaeb/WUdtjv0CHyvaqSgOd385nUoBpkdb+N6A==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: [PATCH 2/4] migrate swapper_pg_dir
Date: Tue, 29 May 2018 12:37:54 +0800
Message-Id: <20180529043754.27843-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduce a variable to record new virtual address of
 swapper_pg_dir.

---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/include/asm/pgtable.h     | 1 +
 arch/arm64/mm/kasan_init.c           | 2 +-
 arch/arm64/mm/mmu.c                  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 3eddb871f251..481c2d16adeb 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -57,7 +57,7 @@ static inline void cpu_set_reserved_ttbr0(void)
 
 static inline void cpu_switch_mm(pgd_t *pgd, struct mm_struct *mm)
 {
-	BUG_ON(pgd == swapper_pg_dir);
+	BUG_ON(pgd == new_swapper_pg_dir);
 	cpu_set_reserved_ttbr0();
 	cpu_do_switch_mm(virt_to_phys(pgd),mm);
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 14ba344b1af7..7abec25cedd2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -723,6 +723,7 @@ extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 extern phys_addr_t __pa_swapper_pg_dir;
+extern pgd_t *new_swapper_pg_dir;
 
 /*
  * Encode and decode a swap entry:
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index dd4f28c19165..08bcaae4725e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -197,7 +197,7 @@ void __init kasan_init(void)
 	 * tmp_pg_dir used to keep early shadow mapped until full shadow
 	 * setup will be finished.
 	 */
-	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
+	memcpy(tmp_pg_dir, new_swapper_pg_dir, sizeof(tmp_pg_dir));
 	dsb(ishst);
 	cpu_replace_ttbr1(__pa_symbol(tmp_pg_dir));
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 41eee333f91a..26ba3e70a91c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -56,6 +56,7 @@ u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
 phys_addr_t __pa_swapper_pg_dir;
+pgd_t *new_swapper_pg_dir = swapper_pg_dir;
 
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
-- 
2.17.0


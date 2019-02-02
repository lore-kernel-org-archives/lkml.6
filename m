Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A92C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D8F21904
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V05dsxDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfBBJlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:41:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41326 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfBBJld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:41:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so7454023edc.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Feb 2019 01:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VnHL/tmyQ/nmJdmXB8BwoJMtf/z3HpXcbnlekvTL8qE=;
        b=V05dsxDKpEJx8VqkofrBqNtw0L9sGiPN/nfAWcCVkL8lv5z5E7e4MJ1g3i381ft3mF
         f13PIu4aRvvoneCN440k082S5FYCrwoPGgHKQRqOX3TGjyUXHqlosrxJSuZC5Qnm5AP6
         glxgzKTwH4ZgjyGX/oqDoj3IH4yxKeunsukOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VnHL/tmyQ/nmJdmXB8BwoJMtf/z3HpXcbnlekvTL8qE=;
        b=kXZhSzyZZeYXovhw8o3ks9O2eRfI2Lzb/9D4WOkCvolBtGnjnBFNpR/M0XaO/VPckS
         4d+TG/TI2YagZzMzwhGuO0Vkv4vIKHxfb/rPD4r89+5FDWiZd+p/aru3FOBlXGjq5zJT
         7JKk6EfJO89y9jovR8t4DOpp7/ySaNWX4JX79qdwSUM/GKmqHSap5XF26oRonq6Y7dGn
         Yk1RDbeCgm+uBjrnbupGxRahKl3VfHLP+F01av7CGQOxm0KrSWRgGtJm0oxqQIlZDOWc
         e4a9J2+uZzLeqMboBgPVWjoa4kDzsLs0aWL6QgV+bt9aw5TZDWn9ZF0Aursnck5Fnu39
         HqNQ==
X-Gm-Message-State: AJcUukcgMjfl6PSIvsaVJiIeX2FefoJqDCt0VOsIx9gYEqfaKl5jK8GI
        mQFOrnsRwvUGOMN0ccKq9ihk/FPHcvyz1A==
X-Google-Smtp-Source: ALg8bN4OqT14rk7qX83yFPAUI+ANjjhu68o07gK5MfeAa3PbYVR+CpX09Z6kycUhl9eKqYN7fEP4kA==
X-Received: by 2002:a50:c2d9:: with SMTP id u25mr42951775edf.280.1549100490160;
        Sat, 02 Feb 2019 01:41:30 -0800 (PST)
Received: from mba13.c.hoisthospitality.com ([109.236.135.164])
        by smtp.gmail.com with ESMTPSA id l41sm2608824eda.83.2019.02.02.01.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 01:41:28 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 02/10] x86/efi: Return error status if mapping EFI regions fail
Date:   Sat,  2 Feb 2019 10:41:11 +0100
Message-Id: <20190202094119.13230-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

efi_map_region() creates VA mappings for an given EFI region using any one
of the two helper functions (namely __map_region() and old_map_region()).
These helper functions *could* fail while creating mappings and presently
their return value is not checked. Not checking for the return value of
these functions might create issues because after these functions return
"md->virt_addr" is set to the requested virtual address (so it's assumed
that these functions always succeed which is not quite true). This
assumption leads to "md->virt_addr" having invalid mapping should any of
__map_region() or old_map_region() fail.

Hence, check for the return value of these functions and if indeed they
fail, turn off EFI Runtime Services forever because kernel cannot
prioritize among EFI regions.

This also fixes the comment "FIXME: add error handling" in
kexec_enter_virtual_mode().

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/efi.h     |  6 +++---
 arch/x86/platform/efi/efi.c    | 21 +++++++++++++-----
 arch/x86/platform/efi/efi_32.c |  6 +++---
 arch/x86/platform/efi/efi_64.c | 39 ++++++++++++++++++++++------------
 4 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 107283b1eb1e..a37378f986ec 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -125,12 +125,12 @@ extern pgd_t * __init efi_call_phys_prolog(void);
 extern void __init efi_call_phys_epilog(pgd_t *save_pgd);
 extern void __init efi_print_memmap(void);
 extern void __init efi_memory_uc(u64 addr, unsigned long size);
-extern void __init efi_map_region(efi_memory_desc_t *md);
-extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
+extern int __init efi_map_region(efi_memory_desc_t *md);
+extern int __init efi_map_region_fixed(efi_memory_desc_t *md);
 extern void efi_sync_low_kernel_mappings(void);
 extern int __init efi_alloc_page_tables(void);
 extern int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages);
-extern void __init old_map_region(efi_memory_desc_t *md);
+extern int __init old_map_region(efi_memory_desc_t *md);
 extern void __init runtime_code_page_mkexec(void);
 extern void __init efi_runtime_update_mappings(void);
 extern void __init efi_dump_pagetable(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e1cb01a22fa8..3d43ec58775b 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -581,7 +581,7 @@ void __init efi_memory_uc(u64 addr, unsigned long size)
 	set_memory_uc(addr, npages);
 }
 
-void __init old_map_region(efi_memory_desc_t *md)
+int __init old_map_region(efi_memory_desc_t *md)
 {
 	u64 start_pfn, end_pfn, end;
 	unsigned long size;
@@ -601,10 +601,14 @@ void __init old_map_region(efi_memory_desc_t *md)
 		va = efi_ioremap(md->phys_addr, size,
 				 md->type, md->attribute);
 
-	md->virt_addr = (u64) (unsigned long) va;
-	if (!va)
+	if (!va) {
 		pr_err("ioremap of 0x%llX failed!\n",
 		       (unsigned long long)md->phys_addr);
+		return -ENOMEM;
+	}
+
+	md->virt_addr = (u64)(unsigned long)va;
+	return 0;
 }
 
 /* Merge contiguous regions of the same type and attribute */
@@ -797,7 +801,9 @@ static void * __init efi_map_regions(int *count, int *pg_shift)
 		if (!should_map_region(md))
 			continue;
 
-		efi_map_region(md);
+		if (efi_map_region(md))
+			return NULL;
+
 		get_systab_virt_addr(md);
 
 		if (left < desc_size) {
@@ -849,7 +855,12 @@ static void __init kexec_enter_virtual_mode(void)
 	* fixed addr which was used in first kernel of a kexec boot.
 	*/
 	for_each_efi_memory_desc(md) {
-		efi_map_region_fixed(md); /* FIXME: add error handling */
+		if (efi_map_region_fixed(md)) {
+			pr_err("Error mapping EFI regions, EFI runtime non-functional!\n");
+			clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+			return;
+		}
+
 		get_systab_virt_addr(md);
 	}
 
diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
index 9959657127f4..4d369118391a 100644
--- a/arch/x86/platform/efi/efi_32.c
+++ b/arch/x86/platform/efi/efi_32.c
@@ -58,12 +58,12 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-void __init efi_map_region(efi_memory_desc_t *md)
+int __init efi_map_region(efi_memory_desc_t *md)
 {
-	old_map_region(md);
+	return old_map_region(md);
 }
 
-void __init efi_map_region_fixed(efi_memory_desc_t *md) {}
+int __init efi_map_region_fixed(efi_memory_desc_t *md) { return 0; }
 void __init parse_efi_setup(u64 phys_addr, u32 data_len) {}
 
 pgd_t * __init efi_call_phys_prolog(void)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index cf0347f61b21..ba83e2e2664b 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -408,7 +408,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 	return 0;
 }
 
-static void __init __map_region(efi_memory_desc_t *md, u64 va)
+static int __init __map_region(efi_memory_desc_t *md, u64 va)
 {
 	unsigned long flags = _PAGE_RW;
 	unsigned long pfn;
@@ -421,12 +421,16 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
-	if (kernel_map_pages_in_pgd(pgd, pfn, va, md->num_pages, flags))
-		pr_warn("Error mapping PA 0x%llx -> VA 0x%llx!\n",
-			   md->phys_addr, va);
+	if (kernel_map_pages_in_pgd(pgd, pfn, va, md->num_pages, flags)) {
+		pr_err("Error mapping PA 0x%llx -> VA 0x%llx!\n",
+		       md->phys_addr, va);
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
-void __init efi_map_region(efi_memory_desc_t *md)
+int __init efi_map_region(efi_memory_desc_t *md)
 {
 	unsigned long size = md->num_pages << PAGE_SHIFT;
 	u64 pa = md->phys_addr;
@@ -439,7 +443,8 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	 * firmware which doesn't update all internal pointers after switching
 	 * to virtual mode and would otherwise crap on us.
 	 */
-	__map_region(md, md->phys_addr);
+	if (__map_region(md, md->phys_addr))
+		return -ENOMEM;
 
 	/*
 	 * Enforce the 1:1 mapping as the default virtual address when
@@ -448,7 +453,7 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	 */
 	if (!efi_is_native () && IS_ENABLED(CONFIG_EFI_MIXED)) {
 		md->virt_addr = md->phys_addr;
-		return;
+		return 0;
 	}
 
 	efi_va -= size;
@@ -468,13 +473,16 @@ void __init efi_map_region(efi_memory_desc_t *md)
 	}
 
 	if (efi_va < EFI_VA_END) {
-		pr_warn(FW_WARN "VA address range overflow!\n");
-		return;
+		pr_err(FW_WARN "VA address range overflow!\n");
+		return -ENOMEM;
 	}
 
 	/* Do the VA map */
-	__map_region(md, efi_va);
+	if (__map_region(md, efi_va))
+		return -ENOMEM;
+
 	md->virt_addr = efi_va;
+	return 0;
 }
 
 /*
@@ -482,10 +490,15 @@ void __init efi_map_region(efi_memory_desc_t *md)
  * md->virt_addr is the original virtual address which had been mapped in kexec
  * 1st kernel.
  */
-void __init efi_map_region_fixed(efi_memory_desc_t *md)
+int __init efi_map_region_fixed(efi_memory_desc_t *md)
 {
-	__map_region(md, md->phys_addr);
-	__map_region(md, md->virt_addr);
+	if (__map_region(md, md->phys_addr))
+		return -ENOMEM;
+
+	if (__map_region(md, md->virt_addr))
+		return -ENOMEM;
+
+	return 0;
 }
 
 void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
-- 
2.17.1


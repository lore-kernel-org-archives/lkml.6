Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE48C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F8218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 23:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oz6Vj4Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfBRXNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 18:13:40 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55310 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730739AbfBRXN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 18:13:28 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so1857693itf.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ptp8Fjet112pFAX81FwzCfRXujZdfs3mZO2hPYz+OK0=;
        b=oz6Vj4Z9Eu13inGGnH5X0txN4tIEXnED3IA3SA+DL8Hs6lXNzNnfm18np5LEndb7ZA
         voPhslSSyKSjUqu885dvRfDAXX/PbCgZmQFNVkOsVEN+4xI1ESCcr1mz5xtEvA5kvars
         09wiPRS+Hwsa+5nu9xpAsdZrJaodFZfBOg3XimOLubN9MU2y8MKftP9YelUNkAzC/6g9
         QAcyLa4Y+3B7hEfLJ2RdQBWvCjW1fk05ykLXknVMZlQjFrReHBgkwhMkb22PovOrMA07
         3g+h9qiMKm7CgJHN837fmuTIcRUGWB9IqflxYJVAswPy/99fhVawSTjRKNSbOu0mCQwq
         hz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ptp8Fjet112pFAX81FwzCfRXujZdfs3mZO2hPYz+OK0=;
        b=DyVyeNhR4XPTorsd9YH+p0XDcUJLGM4TWWde0W5/iHtgQ8aSMTmAX1qcJE3iumhbnn
         VfMesp+pXz6sQJxuPqXHsZS6/dIV/ennfvvZd2GvOSYCC//BhGZlurzoZwf1mR7kS2c5
         dfOsNw7Wm71Y1yGrf9YLSdWKHJJn5hL0D86wQ8sC6yEeEIGD5DIyLHF5nT0AVwY+kzeb
         qHfNieltFoBE/EWM9jSfd6fuQV13XErIoVZQOlPAwdFvgV0nf8h602SSIRVZ2q53kaCt
         8RSMuVSb1vSNsSr32todw0TlaWnTvihu1IKsYDGic7ywI0cYE3hTO7apttqu7yrcqO6X
         jpZw==
X-Gm-Message-State: AHQUAuZ9p7zpZBFIX0rzjIKTdGfrGt7E9AsllWj/GhfYMfheWfAoBqTa
        1y/PUnckAeFgupAzzeLg6WNMwQ==
X-Google-Smtp-Source: AHgI3IacpXhp7hqR4gpLOYb6jmTOiOS9RIZiMJQCPu5S8CRxsY3H9kPVQ0HReFAyHwtbAO1IIUX12g==
X-Received: by 2002:a5d:8545:: with SMTP id b5mr15973963ios.288.1550531607332;
        Mon, 18 Feb 2019 15:13:27 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id x23sm6541463ion.38.2019.02.18.15.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 15:13:26 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jun Yao <yaojun8558363@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2 3/3] arm64: mm: enable per pmd page table lock
Date:   Mon, 18 Feb 2019 16:13:19 -0700
Message-Id: <20190218231319.178224-3-yuzhao@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190218231319.178224-1-yuzhao@google.com>
References: <20190214211642.2200-1-yuzhao@google.com>
 <20190218231319.178224-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from per mm_struct to per pmd page table lock by enabling
ARCH_ENABLE_SPLIT_PMD_PTLOCK. This provides better granularity for
large system.

I'm not sure if there is contention on mm->page_table_lock. Given
the option comes at no cost (apart from initializing more spin
locks), why not enable it now.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/pgalloc.h | 12 +++++++++++-
 arch/arm64/include/asm/tlb.h     |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4168d366127..8dbfa49d926c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,9 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_ENABLE_SPLIT_PMD_PTLOCK
+	def_bool y if PGTABLE_LEVELS > 2
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	---help---
diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c73bf0..dabba4b2c61f 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -33,12 +33,22 @@
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	struct page *page;
+
+	page = alloc_page(PGALLOC_GFP);
+	if (!page)
+		return NULL;
+	if (!pgtable_pmd_page_ctor(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	return page_address(page);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
 {
 	BUG_ON((unsigned long)pmdp & (PAGE_SIZE-1));
+	pgtable_pmd_page_dtor(virt_to_page(pmdp));
 	free_page((unsigned long)pmdp);
 }
 
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 106fdc951b6e..4e3becfed387 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -62,7 +62,10 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	tlb_remove_table(tlb, virt_to_page(pmdp));
+	struct page *page = virt_to_page(pmdp);
+
+	pgtable_pmd_page_dtor(page);
+	tlb_remove_table(tlb, page);
 }
 #endif
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog


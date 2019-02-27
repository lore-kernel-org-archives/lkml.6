Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AE5C00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB01218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfB0RHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:07:44 -0500
Received: from foss.arm.com ([217.140.101.70]:36416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbfB0RHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:07:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E822174E;
        Wed, 27 Feb 2019 09:07:41 -0800 (PST)
Received: from e112269-lin.arm.com (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5CD3F738;
        Wed, 27 Feb 2019 09:07:37 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     linux-mm@kvack.org
Cc:     Steven Price <steven.price@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v3 19/34] sh: mm: Add p?d_large() definitions
Date:   Wed, 27 Feb 2019 17:05:53 +0000
Message-Id: <20190227170608.27963-20-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
References: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For sh, we don't support large pages, so add stubs returning 0.

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/sh/include/asm/pgtable-3level.h | 1 +
 arch/sh/include/asm/pgtable_32.h     | 1 +
 arch/sh/include/asm/pgtable_64.h     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 7d8587eb65ff..9d8b2b002582 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -48,6 +48,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 #define pud_present(x)	(pud_val(x))
 #define pud_clear(xp)	do { set_pud(xp, __pud(0)); } while (0)
 #define	pud_bad(x)	(pud_val(x) & ~PAGE_MASK)
+#define pud_large(x)	(0)
 
 /*
  * (puds are folded into pgds so this doesn't get actually called,
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 29274f0e428e..61186aa11021 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -329,6 +329,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 #define pmd_present(x)	(pmd_val(x))
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	(pmd_val(x) & ~PAGE_MASK)
+#define pmd_large(x)	(0)
 
 #define pages_to_mb(x)	((x) >> (20-PAGE_SHIFT))
 #define pte_page(x)	pfn_to_page(pte_pfn(x))
diff --git a/arch/sh/include/asm/pgtable_64.h b/arch/sh/include/asm/pgtable_64.h
index 1778bc5971e7..80fe9264babf 100644
--- a/arch/sh/include/asm/pgtable_64.h
+++ b/arch/sh/include/asm/pgtable_64.h
@@ -64,6 +64,7 @@ static __inline__ void set_pte(pte_t *pteptr, pte_t pteval)
 #define pmd_clear(pmd_entry_p)	(set_pmd((pmd_entry_p), __pmd(_PMD_EMPTY)))
 #define pmd_none(pmd_entry)	(pmd_val((pmd_entry)) == _PMD_EMPTY)
 #define pmd_bad(pmd_entry)	((pmd_val(pmd_entry) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define pmd_large(pmd_entry)	(0)
 
 #define pmd_page_vaddr(pmd_entry) \
 	((unsigned long) __va(pmd_val(pmd_entry) & PAGE_MASK))
-- 
2.20.1


Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49dPr+1Cwy+9mV38ZCQ6d+1wwp/VD2fGGEJsUzeuCFsT9orSpdywFba4hOhQ56Kpu2Elfii
ARC-Seal: i=1; a=rsa-sha256; t=1523892350; cv=none;
        d=google.com; s=arc-20160816;
        b=DTeOsl7KX4PrcEXfT5KdvsSMepqr94tfWm6xik62ULTwUE3B5/uEZ5SQRW7qo53pTk
         kiGx79djVfYwGLelLrlREUU79Hr/R3t3yAmY+ZN05XLQP3ElCbtVFGzttr8pSOKVsp5R
         6+4LAAeec59wZfhvcI7feVrdYT94CCD5ERjT0yiz25v6lfa6e4qUbT279ElDhR9w1Gtn
         i6gDgXxnez2TgHO4WCsuvGEW35WusuxIL3vF2E65H6/puvIoJlpfg+yYm8A0gj4GVZOi
         dglOSOu4U1u+Fffr/gjz1SNuW6Ymn0EKNLRvDWL7wFSm5OaIXIO/GUiQVSaFbR7v8T7R
         ZWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GK2wtNYvu99snReQv/yOmwwXWYsOB6fIn7Q/P/8Qs78=;
        b=Wm4XuMNQl85SKVE+qZwfgv3/S5Pt/RPcGka7nY5JvJL0ODEpA9ezbWQZ7iVY/hzKms
         Heb9QDNtTRLX4rrMfXr9PvRKPm2dym2rE1gqHnOwaMHbvzhIRAXbnpWITV2+qpgk+I/O
         RtYYS2gl6dhQcG133uffWwoIpuJCy0J8+1sTX6ItA5p3X6APfayin+VOtraxO7PGTyFM
         JM8KJIG1nVmHt5poHjYyyHY195JLizzeOk3LW1IkUCKt0VDImO2aPG0zB1U8exuNIe7K
         wTp5QhevUGFnlOG396cOh1ZaqnrGVm+EOOPGkyF4FWBkV1t7LKW3HStXCN3W+XCf4/Nf
         QGKg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NPClk9yp;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=NPClk9yp;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 30/35] x86/ldt: Define LDT_END_ADDR
Date: Mon, 16 Apr 2018 17:25:18 +0200
Message-Id: <1523892323-14741-31-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916945397412555?=
X-GMAIL-MSGID: =?utf-8?q?1597916945397412555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

It marks the end of the address-space range reserved for the
LDT. The LDT-code will use it when unmapping the LDT for
user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_32_types.h | 2 ++
 arch/x86/include/asm/pgtable_64_types.h | 1 +
 arch/x86/kernel/ldt.c                   | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index 1fa76c9..6d5f795 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -53,6 +53,8 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
 #define LDT_BASE_ADDR		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
 
+#define LDT_END_ADDR		(LDT_BASE_ADDR + PMD_SIZE)
+
 #define PKMAP_BASE		\
 	((LDT_BASE_ADDR - PAGE_SIZE) & PMD_MASK)
 
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 355b488..f78ded7 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -104,6 +104,7 @@ extern unsigned int ptrs_per_p4d;
 #define LDT_PGD_ENTRY_L5	-112UL
 #define LDT_PGD_ENTRY		(pgtable_l5_enabled ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
+#define LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
 
 #define __VMALLOC_BASE_L4	0xffffc90000000000
 #define __VMALLOC_BASE_L5 	0xffa0000000000000
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index d41d896..46c349c 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -206,7 +206,7 @@ static void free_ldt_pgtables(struct mm_struct *mm)
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 	struct mmu_gather tlb;
 	unsigned long start = LDT_BASE_ADDR;
-	unsigned long end = start + (1UL << PGDIR_SHIFT);
+	unsigned long end = LDT_END_ADDR;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
-- 
2.7.4

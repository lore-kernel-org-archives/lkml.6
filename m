Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68265ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A3020684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A3020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeGTAWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:22:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51353 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeGTAWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:22:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNaH3u2454473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:36:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNaH1s2454469;
        Thu, 19 Jul 2018 16:36:17 -0700
Date:   Thu, 19 Jul 2018 16:36:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-8195d869d118bc30bf0be8d0c5d8849d6f58529b@git.kernel.org>
Cc:     bp@alien8.de, eduval@amazon.com, jgross@suse.com,
        dhgutteridge@sympatico.ca, jpoimboe@redhat.com,
        dave.hansen@intel.com, pavel@ucw.cz, luto@kernel.org,
        will.deacon@arm.com, David.Laight@aculab.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, brgerst@gmail.com, mingo@kernel.org,
        jkosina@suse.cz, tglx@linutronix.de, hpa@zytor.com,
        boris.ostrovsky@oracle.com, peterz@infradead.org,
        torvalds@linux-foundation.org, dvlasenk@redhat.com,
        llong@redhat.com, jroedel@suse.de, gregkh@linuxfoundation.org
Reply-To: mingo@kernel.org, brgerst@gmail.com,
          linux-kernel@vger.kernel.org, aarcange@redhat.com,
          will.deacon@arm.com, luto@kernel.org, David.Laight@aculab.com,
          dave.hansen@intel.com, pavel@ucw.cz, jpoimboe@redhat.com,
          bp@alien8.de, eduval@amazon.com, jgross@suse.com,
          dhgutteridge@sympatico.ca, gregkh@linuxfoundation.org,
          llong@redhat.com, jroedel@suse.de, dvlasenk@redhat.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          boris.ostrovsky@oracle.com, hpa@zytor.com, jkosina@suse.cz,
          tglx@linutronix.de
In-Reply-To: <1531906876-13451-35-git-send-email-joro@8bytes.org>
References: <1531906876-13451-35-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/ldt: Define LDT_END_ADDR
Git-Commit-ID: 8195d869d118bc30bf0be8d0c5d8849d6f58529b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8195d869d118bc30bf0be8d0c5d8849d6f58529b
Gitweb:     https://git.kernel.org/tip/8195d869d118bc30bf0be8d0c5d8849d6f58529b
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:47 +0200

x86/ldt: Define LDT_END_ADDR

It marks the end of the address-space range reserved for the LDT. The
LDT-code will use it when unmapping the LDT for user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-35-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable_32_types.h | 2 ++
 arch/x86/include/asm/pgtable_64_types.h | 1 +
 arch/x86/kernel/ldt.c                   | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index 7297810747cf..b0bc0fff5f1f 100644
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
index 066e0ab9ffab..04edd2d58211 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -115,6 +115,7 @@ extern unsigned int ptrs_per_p4d;
 #define LDT_PGD_ENTRY_L5	-112UL
 #define LDT_PGD_ENTRY		(pgtable_l5_enabled() ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
+#define LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
 
 #define __VMALLOC_BASE_L4	0xffffc90000000000UL
 #define __VMALLOC_BASE_L5 	0xffa0000000000000UL
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index c9b14020f4dd..e921b3d494d5 100644
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

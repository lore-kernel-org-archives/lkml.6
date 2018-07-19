Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0190320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0190320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbeGTAWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:22:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbeGTAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:22:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNZmv12454285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:35:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNZl4a2454282;
        Thu, 19 Jul 2018 16:35:47 -0700
Date:   Thu, 19 Jul 2018 16:35:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-f3e48e546c42e31c0c095a6f917a4ad64668608c@git.kernel.org>
Cc:     jpoimboe@redhat.com, will.deacon@arm.com, jgross@suse.com,
        boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, jroedel@suse.de, brgerst@gmail.com,
        torvalds@linux-foundation.org, bp@alien8.de, dave.hansen@intel.com,
        pavel@ucw.cz, dvlasenk@redhat.com, llong@redhat.com,
        aarcange@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, dhgutteridge@sympatico.ca,
        David.Laight@aculab.com, luto@kernel.org, jkosina@suse.cz,
        eduval@amazon.com
Reply-To: jpoimboe@redhat.com, will.deacon@arm.com, jgross@suse.com,
          boris.ostrovsky@oracle.com, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org, jroedel@suse.de,
          torvalds@linux-foundation.org, brgerst@gmail.com,
          dave.hansen@intel.com, bp@alien8.de, pavel@ucw.cz,
          llong@redhat.com, dvlasenk@redhat.com, aarcange@redhat.com,
          gregkh@linuxfoundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, dhgutteridge@sympatico.ca,
          David.Laight@aculab.com, luto@kernel.org, eduval@amazon.com,
          jkosina@suse.cz
In-Reply-To: <1531906876-13451-34-git-send-email-joro@8bytes.org>
References: <1531906876-13451-34-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/ldt: Reserve address-space range on 32 bit for
 the LDT
Git-Commit-ID: f3e48e546c42e31c0c095a6f917a4ad64668608c
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

Commit-ID:  f3e48e546c42e31c0c095a6f917a4ad64668608c
Gitweb:     https://git.kernel.org/tip/f3e48e546c42e31c0c095a6f917a4ad64668608c
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:10 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:47 +0200

x86/ldt: Reserve address-space range on 32 bit for the LDT

Reserve 2MB/4MB of address-space for mapping the LDT to user-space on 32
bit PTI kernels.

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
Link: https://lkml.kernel.org/r/1531906876-13451-34-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable_32_types.h | 7 +++++--
 arch/x86/mm/dump_pagetables.c           | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_32_types.h b/arch/x86/include/asm/pgtable_32_types.h
index d9a001a4a872..7297810747cf 100644
--- a/arch/x86/include/asm/pgtable_32_types.h
+++ b/arch/x86/include/asm/pgtable_32_types.h
@@ -50,13 +50,16 @@ extern bool __vmalloc_start_set; /* set once high_memory is set */
 	((FIXADDR_TOT_START - PAGE_SIZE * (CPU_ENTRY_AREA_PAGES + 1))   \
 	 & PMD_MASK)
 
-#define PKMAP_BASE		\
+#define LDT_BASE_ADDR		\
 	((CPU_ENTRY_AREA_BASE - PAGE_SIZE) & PMD_MASK)
 
+#define PKMAP_BASE		\
+	((LDT_BASE_ADDR - PAGE_SIZE) & PMD_MASK)
+
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE - 2 * PAGE_SIZE)
 #else
-# define VMALLOC_END	(CPU_ENTRY_AREA_BASE - 2 * PAGE_SIZE)
+# define VMALLOC_END	(LDT_BASE_ADDR - 2 * PAGE_SIZE)
 #endif
 
 #define MODULES_VADDR	VMALLOC_START
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e6fd0cdef9ad..ccd92c4da57c 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -122,6 +122,9 @@ enum address_markers_idx {
 	VMALLOC_END_NR,
 #ifdef CONFIG_HIGHMEM
 	PKMAP_BASE_NR,
+#endif
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	LDT_NR,
 #endif
 	CPU_ENTRY_AREA_NR,
 	FIXADDR_START_NR,
@@ -135,6 +138,9 @@ static struct addr_marker address_markers[] = {
 	[VMALLOC_END_NR]	= { 0UL,		"vmalloc() End" },
 #ifdef CONFIG_HIGHMEM
 	[PKMAP_BASE_NR]		= { 0UL,		"Persistent kmap() Area" },
+#endif
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+	[LDT_NR]		= { 0UL,		"LDT remap" },
 #endif
 	[CPU_ENTRY_AREA_NR]	= { 0UL,		"CPU entry area" },
 	[FIXADDR_START_NR]	= { 0UL,		"Fixmap area" },
@@ -609,6 +615,9 @@ static int __init pt_dump_init(void)
 # endif
 	address_markers[FIXADDR_START_NR].start_address = FIXADDR_START;
 	address_markers[CPU_ENTRY_AREA_NR].start_address = CPU_ENTRY_AREA_BASE;
+# ifdef CONFIG_MODIFY_LDT_SYSCALL
+	address_markers[LDT_NR].start_address = LDT_BASE_ADDR;
+# endif
 #endif
 	return 0;
 }

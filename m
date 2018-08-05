Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A6EC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06113218C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06113218C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeHEWiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:38:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeHEWiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:38:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w75KWQW0590261
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 5 Aug 2018 13:32:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w75KWPvL590258;
        Sun, 5 Aug 2018 13:32:25 -0700
Date:   Sun, 5 Aug 2018 13:32:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-6ea2738e0ca0e626c75202fb051c1e88d7a950fa@git.kernel.org>
Cc:     ak@linux.intel.com, hpa@zytor.com, aarcange@redhat.com,
        gregkh@linuxfoundation.org, jgross@suse.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        hughd@google.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, keescook@google.com, dave.hansen@linux.intel.com,
        mingo@kernel.org, jpoimboe@redhat.com, luto@kernel.org
Reply-To: jgross@suse.com, gregkh@linuxfoundation.org, aarcange@redhat.com,
          ak@linux.intel.com, hpa@zytor.com, hughd@google.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          keescook@google.com, bp@alien8.de, jpoimboe@redhat.com,
          dave.hansen@linux.intel.com, mingo@kernel.org, luto@kernel.org
In-Reply-To: <20180802225829.FE0E32EA@viggo.jf.intel.com>
References: <20180802225829.FE0E32EA@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/init: Add helper for freeing kernel image
 pages
Git-Commit-ID: 6ea2738e0ca0e626c75202fb051c1e88d7a950fa
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

Commit-ID:  6ea2738e0ca0e626c75202fb051c1e88d7a950fa
Gitweb:     https://git.kernel.org/tip/6ea2738e0ca0e626c75202fb051c1e88d7a950fa
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Thu, 2 Aug 2018 15:58:29 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 5 Aug 2018 22:21:03 +0200

x86/mm/init: Add helper for freeing kernel image pages

When chunks of the kernel image are freed, free_init_pages() is used
directly.  Consolidate the three sites that do this.  Also update the
string to give an incrementally better description of that memory versus
what was there before.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@google.com
Cc: aarcange@redhat.com
Cc: jgross@suse.com
Cc: jpoimboe@redhat.com
Cc: gregkh@linuxfoundation.org
Cc: peterz@infradead.org
Cc: hughd@google.com
Cc: torvalds@linux-foundation.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: ak@linux.intel.com
Cc: Kees Cook <keescook@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20180802225829.FE0E32EA@viggo.jf.intel.com

---
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/mm/init.c               | 15 ++++++++++++---
 arch/x86/mm/init_64.c            |  4 ++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cfd29ee8c3da..59663c08c949 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -966,6 +966,7 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
 
 extern unsigned long arch_align_stack(unsigned long sp);
 extern void free_init_pages(char *what, unsigned long begin, unsigned long end);
+extern void free_kernel_image_pages(void *begin, void *end);
 
 void default_idle(void);
 #ifdef	CONFIG_XEN
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index cee58a972cb2..bc11dedffc45 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -773,13 +773,22 @@ void free_init_pages(char *what, unsigned long begin, unsigned long end)
 	}
 }
 
+/*
+ * begin/end can be in the direct map or the "high kernel mapping"
+ * used for the kernel image only.  free_init_pages() will do the
+ * right thing for either kind of address.
+ */
+void free_kernel_image_pages(void *begin, void *end)
+{
+	free_init_pages("unused kernel image",
+			(unsigned long)begin, (unsigned long)end);
+}
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
 
-	free_init_pages("unused kernel",
-			(unsigned long)(&__init_begin),
-			(unsigned long)(&__init_end));
+	free_kernel_image_pages(&__init_begin, &__init_end);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 73158655c4a7..68c292cb1ebf 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1283,8 +1283,8 @@ void mark_rodata_ro(void)
 	set_memory_ro(start, (end-start) >> PAGE_SHIFT);
 #endif
 
-	free_init_pages("unused kernel", text_end, rodata_start);
-	free_init_pages("unused kernel", rodata_end, _sdata);
+	free_kernel_image_pages((void *)text_end, (void *)rodata_start);
+	free_kernel_image_pages((void *)rodata_end, (void *)_sdata);
 
 	debug_checkwx();
 

Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2990120673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2990120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbeGTAMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:12:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeGTAMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:12:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNQFQJ2453170
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:26:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNQFAr2453167;
        Thu, 19 Jul 2018 16:26:15 -0700
Date:   Thu, 19 Jul 2018 16:26:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-23b772883d1ddcf7fdf883614b88b2a6205db4da@git.kernel.org>
Cc:     dhgutteridge@sympatico.ca, peterz@infradead.org, llong@redhat.com,
        gregkh@linuxfoundation.org, aarcange@redhat.com, eduval@amazon.com,
        jroedel@suse.de, dvlasenk@redhat.com, David.Laight@aculab.com,
        pavel@ucw.cz, jpoimboe@redhat.com, tglx@linutronix.de,
        boris.ostrovsky@oracle.com, brgerst@gmail.com, luto@kernel.org,
        mingo@kernel.org, hpa@zytor.com, will.deacon@arm.com,
        torvalds@linux-foundation.org, bp@alien8.de,
        linux-kernel@vger.kernel.org, jkosina@suse.cz, jgross@suse.com,
        dave.hansen@intel.com
Reply-To: dave.hansen@intel.com, jgross@suse.com, jkosina@suse.cz,
          bp@alien8.de, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          will.deacon@arm.com, hpa@zytor.com, luto@kernel.org,
          brgerst@gmail.com, boris.ostrovsky@oracle.com, pavel@ucw.cz,
          jpoimboe@redhat.com, tglx@linutronix.de, dvlasenk@redhat.com,
          David.Laight@aculab.com, jroedel@suse.de, eduval@amazon.com,
          gregkh@linuxfoundation.org, aarcange@redhat.com,
          llong@redhat.com, dhgutteridge@sympatico.ca, peterz@infradead.org
In-Reply-To: <1531906876-13451-16-git-send-email-joro@8bytes.org>
References: <1531906876-13451-16-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pgtable: Rename pti_set_user_pgd() to
 pti_set_user_pgtbl()
Git-Commit-ID: 23b772883d1ddcf7fdf883614b88b2a6205db4da
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

Commit-ID:  23b772883d1ddcf7fdf883614b88b2a6205db4da
Gitweb:     https://git.kernel.org/tip/23b772883d1ddcf7fdf883614b88b2a6205db4da
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:40 +0200

x86/pgtable: Rename pti_set_user_pgd() to pti_set_user_pgtbl()

The way page-table folding is implemented on 32 bit, these functions are
not only setting, but also PUDs and even PMDs. Give the function a more
generic name to reflect that.

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
Link: https://lkml.kernel.org/r/1531906876-13451-16-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable_64.h | 12 ++++++------
 arch/x86/mm/pti.c                 |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 3c5385f9a88f..9406c4fe1d38 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -196,21 +196,21 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 }
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd);
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
 
 /*
  * Take a PGD location (pgdp) and a pgd value that needs to be set there.
  * Populates the user and returns the resulting PGD that must be set in
  * the kernel copy of the page tables.
  */
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return pgd;
-	return __pti_set_user_pgd(pgdp, pgd);
+	return __pti_set_user_pgtbl(pgdp, pgd);
 }
 #else
-static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	return pgd;
 }
@@ -226,7 +226,7 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	}
 
 	pgd = native_make_pgd(native_p4d_val(p4d));
-	pgd = pti_set_user_pgd((pgd_t *)p4dp, pgd);
+	pgd = pti_set_user_pgtbl((pgd_t *)p4dp, pgd);
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
@@ -237,7 +237,7 @@ static inline void native_p4d_clear(p4d_t *p4d)
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp = pti_set_user_pgd(pgdp, pgd);
+	*pgdp = pti_set_user_pgtbl(pgdp, pgd);
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 9277e9ba92b5..71fba17c9d7c 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -117,7 +117,7 @@ enable:
 	setup_force_cpu_cap(X86_FEATURE_PTI);
 }
 
-pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
+pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 {
 	/*
 	 * Changes to the high (kernel) portion of the kernelmode page

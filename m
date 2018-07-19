Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784C7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3944020673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3944020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeGTAQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:16:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37049 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeGTAQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:16:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNUYHW2453791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:30:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNUYp22453788;
        Thu, 19 Jul 2018 16:30:34 -0700
Date:   Thu, 19 Jul 2018 16:30:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-1f40a46cf47c12d93a5ad9dccd82bd36ff8f956a@git.kernel.org>
Cc:     dhgutteridge@sympatico.ca, dvlasenk@redhat.com, jroedel@suse.de,
        hpa@zytor.com, gregkh@linuxfoundation.org, peterz@infradead.org,
        David.Laight@aculab.com, jgross@suse.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, brgerst@gmail.com, bp@alien8.de,
        llong@redhat.com, dave.hansen@intel.com, aarcange@redhat.com,
        pavel@ucw.cz, eduval@amazon.com, will.deacon@arm.com,
        mingo@kernel.org, torvalds@linux-foundation.org, jkosina@suse.cz,
        jpoimboe@redhat.com, tglx@linutronix.de, boris.ostrovsky@oracle.com
Reply-To: bp@alien8.de, llong@redhat.com, brgerst@gmail.com,
          linux-kernel@vger.kernel.org, jgross@suse.com, luto@kernel.org,
          David.Laight@aculab.com, peterz@infradead.org,
          gregkh@linuxfoundation.org, hpa@zytor.com, dvlasenk@redhat.com,
          jroedel@suse.de, dhgutteridge@sympatico.ca, tglx@linutronix.de,
          boris.ostrovsky@oracle.com, jpoimboe@redhat.com, jkosina@suse.cz,
          torvalds@linux-foundation.org, will.deacon@arm.com,
          mingo@kernel.org, eduval@amazon.com, pavel@ucw.cz,
          aarcange@redhat.com, dave.hansen@intel.com
In-Reply-To: <1531906876-13451-24-git-send-email-joro@8bytes.org>
References: <1531906876-13451-24-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/legacy: Populate the user page-table with user
 pgd's
Git-Commit-ID: 1f40a46cf47c12d93a5ad9dccd82bd36ff8f956a
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

Commit-ID:  1f40a46cf47c12d93a5ad9dccd82bd36ff8f956a
Gitweb:     https://git.kernel.org/tip/1f40a46cf47c12d93a5ad9dccd82bd36ff8f956a
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:43 +0200

x86/mm/legacy: Populate the user page-table with user pgd's

Also populate the user-spage pgd's in the user page-table.

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
Link: https://lkml.kernel.org/r/1531906876-13451-24-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable-2level.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-2level.h b/arch/x86/include/asm/pgtable-2level.h
index 685ffe8a0eaf..c399ea5eea41 100644
--- a/arch/x86/include/asm/pgtable-2level.h
+++ b/arch/x86/include/asm/pgtable-2level.h
@@ -19,6 +19,9 @@ static inline void native_set_pte(pte_t *ptep , pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pmd.pud.p4d.pgd = pti_set_user_pgtbl(&pmdp->pud.p4d.pgd, pmd.pud.p4d.pgd);
+#endif
 	*pmdp = pmd;
 }
 
@@ -58,6 +61,9 @@ static inline pte_t native_ptep_get_and_clear(pte_t *xp)
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgtbl(&xp->pud.p4d.pgd, __pgd(0));
+#endif
 	return __pmd(xchg((pmdval_t *)xp, 0));
 }
 #else
@@ -67,6 +73,9 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 #ifdef CONFIG_SMP
 static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgtbl(&xp->p4d.pgd, __pgd(0));
+#endif
 	return __pud(xchg((pudval_t *)xp, 0));
 }
 #else

Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71121ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF0D20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF0D20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbeGTAQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:16:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56427 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeGTAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:16:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNU0gY2453595
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:30:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNU0jO2453592;
        Thu, 19 Jul 2018 16:30:00 -0700
Date:   Thu, 19 Jul 2018 16:30:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-9b7b8bbd7f6ba4ef7caa5a078ead70237e12d045@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, jpoimboe@redhat.com,
        hpa@zytor.com, David.Laight@aculab.com, llong@redhat.com,
        jgross@suse.com, boris.ostrovsky@oracle.com, mingo@kernel.org,
        jroedel@suse.de, luto@kernel.org, will.deacon@arm.com,
        eduval@amazon.com, dave.hansen@intel.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, dhgutteridge@sympatico.ca,
        dvlasenk@redhat.com, gregkh@linuxfoundation.org, pavel@ucw.cz,
        torvalds@linux-foundation.org, jkosina@suse.cz, bp@alien8.de,
        brgerst@gmail.com
Reply-To: boris.ostrovsky@oracle.com, mingo@kernel.org, jgross@suse.com,
          llong@redhat.com, David.Laight@aculab.com, hpa@zytor.com,
          tglx@linutronix.de, peterz@infradead.org, jpoimboe@redhat.com,
          bp@alien8.de, brgerst@gmail.com, dhgutteridge@sympatico.ca,
          dvlasenk@redhat.com, jkosina@suse.cz,
          torvalds@linux-foundation.org, pavel@ucw.cz,
          gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com, aarcange@redhat.com, luto@kernel.org,
          jroedel@suse.de, eduval@amazon.com, will.deacon@arm.com
In-Reply-To: <1531906876-13451-23-git-send-email-joro@8bytes.org>
References: <1531906876-13451-23-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pae: Populate the user page-table with user
 pgd's
Git-Commit-ID: 9b7b8bbd7f6ba4ef7caa5a078ead70237e12d045
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

Commit-ID:  9b7b8bbd7f6ba4ef7caa5a078ead70237e12d045
Gitweb:     https://git.kernel.org/tip/9b7b8bbd7f6ba4ef7caa5a078ead70237e12d045
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:43 +0200

x86/mm/pae: Populate the user page-table with user pgd's

When a PGD entry is populated, make sure to populate it in the user
page-table too.

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
Link: https://lkml.kernel.org/r/1531906876-13451-23-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pgtable-3level.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index f24df59c40b2..f2ca3139ca22 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -98,6 +98,9 @@ static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pud.p4d.pgd = pti_set_user_pgtbl(&pudp->p4d.pgd, pud.p4d.pgd);
+#endif
 	set_64bit((unsigned long long *)(pudp), native_pud_val(pud));
 }
 
@@ -229,6 +232,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 {
 	union split_pud res, *orig = (union split_pud *)pudp;
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgtbl(&pudp->p4d.pgd, __pgd(0));
+#endif
+
 	/* xchg acts as a barrier before setting of the high bits */
 	res.pud_low = xchg(&orig->pud_low, 0);
 	res.pud_high = orig->pud_high;

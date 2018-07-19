Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7651ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737D020684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737D020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGTAUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:20:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGTAUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:20:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNYJFM2454198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:34:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNYIB82454195;
        Thu, 19 Jul 2018 16:34:18 -0700
Date:   Thu, 19 Jul 2018 16:34:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-ba0364e260ab37c02975557dbecc014a26072236@git.kernel.org>
Cc:     David.Laight@aculab.com, mingo@kernel.org, hpa@zytor.com,
        dhgutteridge@sympatico.ca, pavel@ucw.cz, dvlasenk@redhat.com,
        brgerst@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        jkosina@suse.cz, bp@alien8.de, luto@kernel.org,
        jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        aarcange@redhat.com, will.deacon@arm.com,
        torvalds@linux-foundation.org, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jroedel@suse.de, llong@redhat.com, eduval@amazon.com,
        jgross@suse.com
Reply-To: gregkh@linuxfoundation.org, aarcange@redhat.com,
          will.deacon@arm.com, dave.hansen@intel.com,
          torvalds@linux-foundation.org, boris.ostrovsky@oracle.com,
          linux-kernel@vger.kernel.org, jroedel@suse.de, jgross@suse.com,
          llong@redhat.com, eduval@amazon.com, mingo@kernel.org,
          David.Laight@aculab.com, hpa@zytor.com,
          dhgutteridge@sympatico.ca, pavel@ucw.cz, dvlasenk@redhat.com,
          jkosina@suse.cz, peterz@infradead.org, tglx@linutronix.de,
          brgerst@gmail.com, luto@kernel.org, bp@alien8.de,
          jpoimboe@redhat.com
In-Reply-To: <1531906876-13451-31-git-send-email-joro@8bytes.org>
References: <1531906876-13451-31-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Clone entry-text again in pti_finalize()
Git-Commit-ID: ba0364e260ab37c02975557dbecc014a26072236
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

Commit-ID:  ba0364e260ab37c02975557dbecc014a26072236
Gitweb:     https://git.kernel.org/tip/ba0364e260ab37c02975557dbecc014a26072236
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:45 +0200

x86/mm/pti: Clone entry-text again in pti_finalize()

The mapping for entry-text might have changed in the kernel after it was
cloned to the user page-table. Clone again to update the user page-table to
bring the mapping in sync with the kernel again.

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
Link: https://lkml.kernel.org/r/1531906876-13451-31-git-send-email-joro@8bytes.org

---
 arch/x86/mm/pti.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index fcfb815d420f..a536ecc91847 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -404,7 +404,7 @@ static void __init pti_setup_espfix64(void)
 /*
  * Clone the populated PMDs of the entry and irqentry text and force it RO.
  */
-static void __init pti_clone_entry_text(void)
+static void pti_clone_entry_text(void)
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
 			(unsigned long) __irqentry_text_end,
@@ -528,13 +528,18 @@ void __init pti_init(void)
 }
 
 /*
- * Finalize the kernel mappings in the userspace page-table.
+ * Finalize the kernel mappings in the userspace page-table. Some of the
+ * mappings for the kernel image might have changed since pti_init()
+ * cloned them. This is because parts of the kernel image have been
+ * mapped RO and/or NX.  These changes need to be cloned again to the
+ * userspace page-table.
  */
 void pti_finalize(void)
 {
 	/*
-	 * Do this after all of the manipulation of the
-	 * kernel text page tables are complete.
+	 * We need to clone everything (again) that maps parts of the
+	 * kernel image.
 	 */
+	pti_clone_entry_text();
 	pti_clone_kernel_text();
 }

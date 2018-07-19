Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AF220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AF220673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGTAR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:17:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeGTAR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:17:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNVbk72453862
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:31:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNVbnd2453859;
        Thu, 19 Jul 2018 16:31:37 -0700
Date:   Thu, 19 Jul 2018 16:31:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-2c1b9fbe83412598d2dccdd448147336b085e0c6@git.kernel.org>
Cc:     peterz@infradead.org, brgerst@gmail.com, jgross@suse.com,
        dvlasenk@redhat.com, gregkh@linuxfoundation.org, jkosina@suse.cz,
        jpoimboe@redhat.com, eduval@amazon.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, hpa@zytor.com,
        dhgutteridge@sympatico.ca, torvalds@linux-foundation.org,
        boris.ostrovsky@oracle.com, llong@redhat.com, tglx@linutronix.de,
        will.deacon@arm.com, jroedel@suse.de, aarcange@redhat.com,
        David.Laight@aculab.com, mingo@kernel.org, luto@kernel.org,
        pavel@ucw.cz
Reply-To: jgross@suse.com, peterz@infradead.org, brgerst@gmail.com,
          jpoimboe@redhat.com, jkosina@suse.cz, dave.hansen@intel.com,
          eduval@amazon.com, dvlasenk@redhat.com,
          gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
          dhgutteridge@sympatico.ca, bp@alien8.de, hpa@zytor.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          boris.ostrovsky@oracle.com, llong@redhat.com,
          aarcange@redhat.com, will.deacon@arm.com, jroedel@suse.de,
          luto@kernel.org, pavel@ucw.cz, mingo@kernel.org,
          David.Laight@aculab.com
In-Reply-To: <1531906876-13451-26-git-send-email-joro@8bytes.org>
References: <1531906876-13451-26-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on
 x86_32
Git-Commit-ID: 2c1b9fbe83412598d2dccdd448147336b085e0c6
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

Commit-ID:  2c1b9fbe83412598d2dccdd448147336b085e0c6
Gitweb:     https://git.kernel.org/tip/2c1b9fbe83412598d2dccdd448147336b085e0c6
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:02 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:44 +0200

x86/mm/pti: Define X86_CR3_PTI_PCID_USER_BIT on x86_32

Move it out of the X86_64 specific processor defines so that its visible
for 32bit too.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
Link: https://lkml.kernel.org/r/1531906876-13451-26-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/processor-flags.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 625a52a5594f..02c2cbda4a74 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -39,10 +39,6 @@
 #define CR3_PCID_MASK	0xFFFull
 #define CR3_NOFLUSH	BIT_ULL(63)
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-# define X86_CR3_PTI_PCID_USER_BIT	11
-#endif
-
 #else
 /*
  * CR3_ADDR_MASK needs at least bits 31:5 set on PAE systems, and we save
@@ -53,4 +49,8 @@
 #define CR3_NOFLUSH	0
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+# define X86_CR3_PTI_PCID_USER_BIT	11
+#endif
+
 #endif /* _ASM_X86_PROCESSOR_FLAGS_H */

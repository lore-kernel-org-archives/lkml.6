Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0EFECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770C420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770C420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbeGTAYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:24:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbeGTAYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:24:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNcM3r2454639
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:38:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNcLNm2454636;
        Thu, 19 Jul 2018 16:38:21 -0700
Date:   Thu, 19 Jul 2018 16:38:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-5e8105950a8b3e03e805299b4d05020ee4eda31a@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, llong@redhat.com, bp@alien8.de,
        David.Laight@aculab.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, jgross@suse.com, jroedel@suse.de,
        aarcange@redhat.com, brgerst@gmail.com, dvlasenk@redhat.com,
        jkosina@suse.cz, jpoimboe@redhat.com, hpa@zytor.com,
        eduval@amazon.com, tglx@linutronix.de, dave.hansen@intel.com,
        mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        dhgutteridge@sympatico.ca, pavel@ucw.cz, luto@kernel.org,
        boris.ostrovsky@oracle.com
Reply-To: pavel@ucw.cz, luto@kernel.org, will.deacon@arm.com,
          mingo@kernel.org, dhgutteridge@sympatico.ca,
          peterz@infradead.org, boris.ostrovsky@oracle.com,
          jgross@suse.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, David.Laight@aculab.com,
          dvlasenk@redhat.com, jroedel@suse.de, brgerst@gmail.com,
          aarcange@redhat.com, llong@redhat.com,
          gregkh@linuxfoundation.org, bp@alien8.de, dave.hansen@intel.com,
          jkosina@suse.cz, jpoimboe@redhat.com, hpa@zytor.com,
          tglx@linutronix.de, eduval@amazon.com
In-Reply-To: <1531906876-13451-39-git-send-email-joro@8bytes.org>
References: <1531906876-13451-39-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Add Warning when booting on a PCID
 capable CPU
Git-Commit-ID: 5e8105950a8b3e03e805299b4d05020ee4eda31a
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

Commit-ID:  5e8105950a8b3e03e805299b4d05020ee4eda31a
Gitweb:     https://git.kernel.org/tip/5e8105950a8b3e03e805299b4d05020ee4eda31a
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:48 +0200

x86/mm/pti: Add Warning when booting on a PCID capable CPU

Warn the user in case the performance can be significantly improved by
switching to a 64-bit kernel.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
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
Link: https://lkml.kernel.org/r/1531906876-13451-39-git-send-email-joro@8bytes.org

---
 arch/x86/mm/pti.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index a536ecc91847..7b1c85759005 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -517,6 +517,28 @@ void __init pti_init(void)
 
 	pr_info("enabled\n");
 
+#ifdef CONFIG_X86_32
+	/*
+	 * We check for X86_FEATURE_PCID here. But the init-code will
+	 * clear the feature flag on 32 bit because the feature is not
+	 * supported on 32 bit anyway. To print the warning we need to
+	 * check with cpuid directly again.
+	 */
+	if (cpuid_ecx(0x1) && BIT(17)) {
+		/* Use printk to work around pr_fmt() */
+		printk(KERN_WARNING "\n");
+		printk(KERN_WARNING "************************************************************\n");
+		printk(KERN_WARNING "** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **\n");
+		printk(KERN_WARNING "**                                                        **\n");
+		printk(KERN_WARNING "** You are using 32-bit PTI on a 64-bit PCID-capable CPU. **\n");
+		printk(KERN_WARNING "** Your performance will increase dramatically if you     **\n");
+		printk(KERN_WARNING "** switch to a 64-bit kernel!                             **\n");
+		printk(KERN_WARNING "**                                                        **\n");
+		printk(KERN_WARNING "** WARNING! WARNING! WARNING! WARNING! WARNING! WARNING!  **\n");
+		printk(KERN_WARNING "************************************************************\n");
+	}
+#endif
+
 	pti_clone_user_shared();
 
 	/* Undo all global bits from the init pagetables in head_64.S: */

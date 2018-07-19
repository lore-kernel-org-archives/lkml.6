Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E49ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83E9205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83E9205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeGTAYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:24:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeGTAYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:24:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNbmeJ2454583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:37:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNbmaQ2454580;
        Thu, 19 Jul 2018 16:37:48 -0700
Date:   Thu, 19 Jul 2018 16:37:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-7757d607c6b31867777de42e1fb0210b9c5d8b70@git.kernel.org>
Cc:     jpoimboe@redhat.com, hpa@zytor.com, aarcange@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, brgerst@gmail.com, bp@alien8.de,
        jgross@suse.com, luto@kernel.org, jkosina@suse.cz,
        peterz@infradead.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, jroedel@suse.de,
        dhgutteridge@sympatico.ca, David.Laight@aculab.com,
        dvlasenk@redhat.com, mingo@kernel.org, eduval@amazon.com,
        gregkh@linuxfoundation.org, llong@redhat.com, pavel@ucw.cz,
        dave.hansen@intel.com
Reply-To: hpa@zytor.com, aarcange@redhat.com, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
          tglx@linutronix.de, brgerst@gmail.com, bp@alien8.de,
          jkosina@suse.cz, luto@kernel.org, peterz@infradead.org,
          jgross@suse.com, will.deacon@arm.com,
          torvalds@linux-foundation.org, dhgutteridge@sympatico.ca,
          jroedel@suse.de, mingo@kernel.org, David.Laight@aculab.com,
          dvlasenk@redhat.com, llong@redhat.com,
          gregkh@linuxfoundation.org, pavel@ucw.cz, dave.hansen@intel.com,
          eduval@amazon.com
In-Reply-To: <1531906876-13451-38-git-send-email-joro@8bytes.org>
References: <1531906876-13451-38-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32
Git-Commit-ID: 7757d607c6b31867777de42e1fb0210b9c5d8b70
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

Commit-ID:  7757d607c6b31867777de42e1fb0210b9c5d8b70
Gitweb:     https://git.kernel.org/tip/7757d607c6b31867777de42e1fb0210b9c5d8b70
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:48 +0200

x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32

Allow PTI to be compiled on x86_32.

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
Link: https://lkml.kernel.org/r/1531906876-13451-38-git-send-email-joro@8bytes.org

---
 security/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..afa91c6f06bb 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -57,7 +57,7 @@ config SECURITY_NETWORK
 config PAGE_TABLE_ISOLATION
 	bool "Remove the kernel mapping in user mode"
 	default y
-	depends on X86_64 && !UML
+	depends on X86 && !UML
 	help
 	  This feature reduces the number of hardware side channels by
 	  ensuring that the majority of kernel addresses are not mapped

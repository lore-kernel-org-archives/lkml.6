Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05934ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C5C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C5C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGTAH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:07:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbeGTAH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:07:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNL0Z72451024
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:21:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNL0iI2451017;
        Thu, 19 Jul 2018 16:21:00 -0700
Date:   Thu, 19 Jul 2018 16:21:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-8e676ced31e9d1448d3ffc4159586a259cc67f30@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com, hpa@zytor.com,
        jgross@suse.com, aarcange@redhat.com, luto@kernel.org,
        dvlasenk@redhat.com, jpoimboe@redhat.com, mingo@kernel.org,
        dhgutteridge@sympatico.ca, brgerst@gmail.com, eduval@amazon.com,
        llong@redhat.com, David.Laight@aculab.com, tglx@linutronix.de,
        bp@alien8.de, pavel@ucw.cz, gregkh@linuxfoundation.org,
        jroedel@suse.de, jkosina@suse.cz, peterz@infradead.org,
        dave.hansen@intel.com, torvalds@linux-foundation.org,
        boris.ostrovsky@oracle.com
Reply-To: will.deacon@arm.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          jgross@suse.com, aarcange@redhat.com, luto@kernel.org,
          dvlasenk@redhat.com, jpoimboe@redhat.com, mingo@kernel.org,
          dhgutteridge@sympatico.ca, brgerst@gmail.com, eduval@amazon.com,
          llong@redhat.com, David.Laight@aculab.com, tglx@linutronix.de,
          bp@alien8.de, jroedel@suse.de, pavel@ucw.cz,
          gregkh@linuxfoundation.org, jkosina@suse.cz,
          peterz@infradead.org, dave.hansen@intel.com,
          boris.ostrovsky@oracle.com, torvalds@linux-foundation.org
In-Reply-To: <1531906876-13451-6-git-send-email-joro@8bytes.org>
References: <1531906876-13451-6-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/entry/32: Unshare NMI return path
Git-Commit-ID: 8e676ced31e9d1448d3ffc4159586a259cc67f30
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

Commit-ID:  8e676ced31e9d1448d3ffc4159586a259cc67f30
Gitweb:     https://git.kernel.org/tip/8e676ced31e9d1448d3ffc4159586a259cc67f30
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:40:42 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:36 +0200

x86/entry/32: Unshare NMI return path

NMI will no longer use most of the shared return path, because NMI needs
special handling when the CR3 switches for PTI are added. Prepare for that
change.

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
Link: https://lkml.kernel.org/r/1531906876-13451-6-git-send-email-joro@8bytes.org

---
 arch/x86/entry/entry_32.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index ef7d65315e8e..43641310b6e3 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1017,7 +1017,7 @@ ENTRY(nmi)
 
 	/* Not on SYSENTER stack. */
 	call	do_nmi
-	jmp	.Lrestore_all_notrace
+	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
 	/*
@@ -1028,7 +1028,11 @@ ENTRY(nmi)
 	movl	PER_CPU_VAR(cpu_current_top_of_stack), %esp
 	call	do_nmi
 	movl	%ebx, %esp
-	jmp	.Lrestore_all_notrace
+
+.Lnmi_return:
+	CHECK_AND_APPLY_ESPFIX
+	RESTORE_REGS 4
+	jmp	.Lirq_return
 
 #ifdef CONFIG_X86_ESPFIX32
 .Lnmi_espfix_stack:

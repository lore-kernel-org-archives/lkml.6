Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052DDC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90982694D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:33:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90982694D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964951AbeFZKdA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:33:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933784AbeFZKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:32:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5QAWZi81649134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 26 Jun 2018 03:32:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5QAWZmj1649128;
        Tue, 26 Jun 2018 03:32:35 -0700
Date:   Tue, 26 Jun 2018 03:32:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-236f0cd286b67291796362feeac4f342900cfa82@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        JBeulich@suse.com, jbeulich@suse.com, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, luto@kernel.org,
          peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, JBeulich@suse.com, jbeulich@suse.com
In-Reply-To: <5B30C24702000078001CD6A6@prv1-mh.provo.novell.com>
References: <5B30C24702000078001CD6A6@prv1-mh.provo.novell.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/32: Add explicit 'l' instruction suffix
Git-Commit-ID: 236f0cd286b67291796362feeac4f342900cfa82
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

Commit-ID:  236f0cd286b67291796362feeac4f342900cfa82
Gitweb:     https://git.kernel.org/tip/236f0cd286b67291796362feeac4f342900cfa82
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 25 Jun 2018 04:21:59 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 26 Jun 2018 09:20:31 +0200

x86/entry/32: Add explicit 'l' instruction suffix

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream GAS in the
future (mine does already).

Add the single missing 'l' suffix here.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/5B30C24702000078001CD6A6@prv1-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2582881d19ce..c371bfee137a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -477,7 +477,7 @@ ENTRY(entry_SYSENTER_32)
 	 * whereas POPF does not.)
 	 */
 	addl	$PT_EFLAGS-PT_DS, %esp	/* point esp at pt_regs->flags */
-	btr	$X86_EFLAGS_IF_BIT, (%esp)
+	btrl	$X86_EFLAGS_IF_BIT, (%esp)
 	popfl
 
 	/*

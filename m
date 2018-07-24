Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D087ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3731420856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbeGXQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:09:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388248AbeGXQJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:09:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6OF20ee032167
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 24 Jul 2018 08:02:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6OF20Z4032164;
        Tue, 24 Jul 2018 08:02:00 -0700
Date:   Tue, 24 Jul 2018 08:02:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for zhong jiang <tipbot@zytor.com>
Message-ID: <tip-387048f51aecaa083e660fe0f15ad339354b116e@git.kernel.org>
Cc:     riel@redhat.com, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        zhongjiang@huawei.com
Reply-To: hpa@zytor.com, peterz@infradead.org, riel@redhat.com,
          zhongjiang@huawei.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org
In-Reply-To: <1532159732-22939-1-git-send-email-zhongjiang@huawei.com>
References: <1532159732-22939-1-git-send-email-zhongjiang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Make clear_asid_other() static
Git-Commit-ID: 387048f51aecaa083e660fe0f15ad339354b116e
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

Commit-ID:  387048f51aecaa083e660fe0f15ad339354b116e
Gitweb:     https://git.kernel.org/tip/387048f51aecaa083e660fe0f15ad339354b116e
Author:     zhong jiang <zhongjiang@huawei.com>
AuthorDate: Sat, 21 Jul 2018 15:55:32 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 24 Jul 2018 09:52:32 +0200

x86/mm/tlb: Make clear_asid_other() static

Fixes the following sparse warning:

  arch/x86/mm/tlb.c:38:6: warning: symbol 'clear_asid_other' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: kirill.shutemov@linux.intel.com
Cc: tim.c.chen@linux.intel.com
Link: http://lkml.kernel.org/r/1532159732-22939-1-git-send-email-zhongjiang@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f086195f644c..752dbf4e0e50 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -36,7 +36,7 @@
  * necessary invalidation by clearing out the 'ctx_id' which
  * forces a TLB flush when the context is loaded.
  */
-void clear_asid_other(void)
+static void clear_asid_other(void)
 {
 	u16 asid;
 

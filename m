Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EDFC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A29208AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A29208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeHTTop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:44:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeHTTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:44:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7KGRt832130852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Aug 2018 09:27:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7KGRtPq2130849;
        Mon, 20 Aug 2018 09:27:55 -0700
Date:   Mon, 20 Aug 2018 09:27:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-b639186ffe9168fd1d2f95a1fff8571720739126@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        gustavo@embeddedor.com, dvhart@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          gustavo@embeddedor.com, dvhart@infradead.org, hpa@zytor.com,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <20180816172124.GA2407@embeddedor.com>
References: <20180816172124.GA2407@embeddedor.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] futex: Mark expected switch fall-throughs
Git-Commit-ID: b639186ffe9168fd1d2f95a1fff8571720739126
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

Commit-ID:  b639186ffe9168fd1d2f95a1fff8571720739126
Gitweb:     https://git.kernel.org/tip/b639186ffe9168fd1d2f95a1fff8571720739126
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Thu, 16 Aug 2018 12:21:24 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 20 Aug 2018 18:23:00 +0200

futex: Mark expected switch fall-throughs

In preparation of enabling -Wimplicit-fallthrough, mark switch cases which
fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Link: https://lkml.kernel.org/r/20180816172124.GA2407@embeddedor.com

---
 kernel/futex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 1f450e092c74..11fc3bb456d6 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3523,10 +3523,12 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;
+		/* fall through */
 	case FUTEX_WAIT_BITSET:
 		return futex_wait(uaddr, flags, val, timeout, val3);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
+		/* fall through */
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:

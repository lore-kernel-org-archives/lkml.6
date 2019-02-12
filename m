Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAFFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A031222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991885;
	bh=c+0DwPz99uwBmEp1hQncI61vkRWMzCxlvKcbci5Ch38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gLWxsNTJ/DbBlxTtj7I17s7wr3puqxtfK11Oc7n6YNV121ZnhrxmPhsvFyIy59lCR
	 8+SUhGqOXpHBgZFnYUF7vDQxVXfG9yUxLMl4RW1Gq6RdwJQt8Z/5Wy0bdmY7DWxId/
	 NARNLVd2WRroS/tKgjQvS/tMxvSO0KMxbeQhStHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfBLRSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:18:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729955AbfBLRPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:45 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13230222B0;
        Tue, 12 Feb 2019 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991744;
        bh=c+0DwPz99uwBmEp1hQncI61vkRWMzCxlvKcbci5Ch38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rdwbh8v74cAyr9jmp9tPPDmvdgGxpd/05lf/Fad0IZnjkkYJUiNh/eXXjOPmTJrpP
         e9g48KbOKCK8iyL7otCY8YiKAU/gvvWvvvrp3JsZaiVk8dp6AOcBWi8i1Q2Ipx38nC
         AWMQYY4Xj3xQ7x8MPUvsIP55/kuWJCc5xzZgl6xo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 23/32] softirq: Remove stale comment
Date:   Tue, 12 Feb 2019 18:14:14 +0100
Message-Id: <20190212171423.8308-24-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__local_bh_disable_ip() is neither for strict internal use nor does it
require the caller to disable hardirqs. Probaby a celebration for ancient
behaviour.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/softirq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index a2257a5aaa0b..5fea9e299caf 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -102,10 +102,6 @@ static bool ksoftirqd_running(unsigned long pending)
  * softirq and whether we just have bh disabled.
  */
 
-/*
- * This one is for softirq.c-internal use,
- * where hardirqs are disabled legitimately:
- */
 #ifdef CONFIG_TRACE_IRQFLAGS
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
-- 
2.17.1


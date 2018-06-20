Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63387C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E0E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E0E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbeFTJkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:40:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754423AbeFTJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:40:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K9dnPC3448379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 02:39:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K9dmh63448376;
        Wed, 20 Jun 2018 02:39:48 -0700
Date:   Wed, 20 Jun 2018 02:39:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-6519750210d9d3330e85d12e0128652edde448d2@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180612083909.157076812@infradead.org>
References: <20180612083909.157076812@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/swait: Remove __prepare_to_swait
Git-Commit-ID: 6519750210d9d3330e85d12e0128652edde448d2
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

Commit-ID:  6519750210d9d3330e85d12e0128652edde448d2
Gitweb:     https://git.kernel.org/tip/6519750210d9d3330e85d12e0128652edde448d2
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 12 Jun 2018 10:34:50 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 11:35:56 +0200

sched/swait: Remove __prepare_to_swait

There is no public user of this API, remove it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bigeasy@linutronix.de
Cc: oleg@redhat.com
Cc: paulmck@linux.vnet.ibm.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180612083909.157076812@infradead.org

---
 include/linux/swait.h | 1 -
 kernel/sched/swait.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index bf8cb0dee23c..d6a5e949e4ca 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -161,7 +161,6 @@ extern void swake_up(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
 
-extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
 extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
 
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index b6fb2c3b3ff7..e68bb1398b05 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -69,7 +69,7 @@ void swake_up_all(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_all);
 
-void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
+static void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	wait->task = current;
 	if (list_empty(&wait->task_list))

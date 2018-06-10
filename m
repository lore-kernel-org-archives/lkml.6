Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id idPRHXWmHFtLbAAAmS7hNA
	; Sun, 10 Jun 2018 04:19:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A1BC260795; Sun, 10 Jun 2018 04:19:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0C8E56074D;
	Sun, 10 Jun 2018 04:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C8E56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeFJES5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 00:18:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeFJES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 00:18:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5A4Iktc3241665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 9 Jun 2018 21:18:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5A4Ij4Q3241662;
        Sat, 9 Jun 2018 21:18:45 -0700
Date: Sat, 9 Jun 2018 21:18:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-ec84b27f9b3b569f9235413d1945a2006b97b0aa@git.kernel.org>
Cc: ebiederm@xmission.com, anna-maria@linutronix.de,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
          anna-maria@linutronix.de, ebiederm@xmission.com
In-Reply-To: <20180525090507.22248-2-anna-maria@linutronix.de>
References: <20180525090507.22248-2-anna-maria@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] rcu: Update documentation of rcu_read_unlock()
Git-Commit-ID: ec84b27f9b3b569f9235413d1945a2006b97b0aa
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

Commit-ID:  ec84b27f9b3b569f9235413d1945a2006b97b0aa
Gitweb:     https://git.kernel.org/tip/ec84b27f9b3b569f9235413d1945a2006b97b0aa
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Fri, 25 May 2018 11:05:06 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Jun 2018 06:14:01 +0200

rcu: Update documentation of rcu_read_unlock()

Since commit b4abf91047cf ("rtmutex: Make wait_lock irq safe") the
explanation in rcu_read_unlock() documentation about irq unsafe rtmutex
wait_lock is no longer valid.

Remove it to prevent kernel developers reading the documentation to rely on
it.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: bigeasy@linutronix.de
Link: https://lkml.kernel.org/r/20180525090507.22248-2-anna-maria@linutronix.de

---
 include/linux/rcupdate.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e679b175b411..65163aa0bb04 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -652,9 +652,7 @@ static inline void rcu_read_lock(void)
  * Unfortunately, this function acquires the scheduler's runqueue and
  * priority-inheritance spinlocks.  This means that deadlock could result
  * if the caller of rcu_read_unlock() already holds one of these locks or
- * any lock that is ever acquired while holding them; or any lock which
- * can be taken from interrupt context because rcu_boost()->rt_mutex_lock()
- * does not disable irqs while taking ->wait_lock.
+ * any lock that is ever acquired while holding them.
  *
  * That said, RCU readers are never priority boosted unless they were
  * preempted.  Therefore, one way to avoid deadlock is to make sure

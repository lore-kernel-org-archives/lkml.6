Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeEMOBm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 10:01:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37059 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751260AbeEMOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 10:01:28 -0400
Date: Sun, 13 May 2018 07:00:46 -0700
From: tip-bot for Mauro Carvalho Chehab <tipbot@zytor.com>
Message-ID: <tip-bf9c96bec76fbc4424b4c70be563af4107d8044f@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, john.stultz@linaro.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, sboyd@kernel.org,
        mchehab@infradead.org, mchehab+samsung@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: corbet@lwn.net, sboyd@kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mchehab@infradead.org, mchehab+samsung@kernel.org, mingo@kernel.org,
        hpa@zytor.com, john.stultz@linaro.org
In-Reply-To: <f02e6a0ce27f3b5e33415d92d07a40598904b3ee.1525684985.git.mchehab+samsung@kernel.org>
References: <f02e6a0ce27f3b5e33415d92d07a40598904b3ee.1525684985.git.mchehab+samsung@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timers: Adjust a kernel-doc comment
Git-Commit-ID: bf9c96bec76fbc4424b4c70be563af4107d8044f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bf9c96bec76fbc4424b4c70be563af4107d8044f
Gitweb:     https://git.kernel.org/tip/bf9c96bec76fbc4424b4c70be563af4107d8044f
Author:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
AuthorDate: Mon, 7 May 2018 06:35:48 -0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:55:43 +0200

timers: Adjust a kernel-doc comment

Those three warnings can easily solved by using :: to indicate a
code block:

	./kernel/time/timer.c:1259: WARNING: Unexpected indentation.
	./kernel/time/timer.c:1261: WARNING: Unexpected indentation.
	./kernel/time/timer.c:1262: WARNING: Block quote ends without a blank line; unexpected unindent.

While here, align the lines at the block.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/f02e6a0ce27f3b5e33415d92d07a40598904b3ee.1525684985.git.mchehab%2Bsamsung@kernel.org

---
 kernel/time/timer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4a4fd567fb26..cc2d23e6ff61 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1251,18 +1251,18 @@ EXPORT_SYMBOL(try_to_del_timer_sync);
  *
  * Note: For !irqsafe timers, you must not hold locks that are held in
  *   interrupt context while calling this function. Even if the lock has
- *   nothing to do with the timer in question.  Here's why:
+ *   nothing to do with the timer in question.  Here's why::
  *
  *    CPU0                             CPU1
  *    ----                             ----
- *                                   <SOFTIRQ>
- *                                   call_timer_fn();
- *                                     base->running_timer = mytimer;
- *  spin_lock_irq(somelock);
+ *                                     <SOFTIRQ>
+ *                                       call_timer_fn();
+ *                                       base->running_timer = mytimer;
+ *    spin_lock_irq(somelock);
  *                                     <IRQ>
  *                                        spin_lock(somelock);
- *  del_timer_sync(mytimer);
- *   while (base->running_timer == mytimer);
+ *    del_timer_sync(mytimer);
+ *    while (base->running_timer == mytimer);
  *
  * Now del_timer_sync() will never return and never release somelock.
  * The interrupt on the other CPU is waiting to grab somelock but

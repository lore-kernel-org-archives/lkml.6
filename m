Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeEBOPq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:15:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34743 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeEBOPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:15:40 -0400
Date: Wed, 2 May 2018 07:15:22 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-7dba33c6346c337aac3f7cd188137d4a6d3d1f3a@git.kernel.org>
Cc: hpa@zytor.com, rafael.j.wysocki@intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: rafael.j.wysocki@intel.com, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180430100344.656525644@infradead.org>
References: <20180430100344.656525644@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource: Rework stale comment
Git-Commit-ID: 7dba33c6346c337aac3f7cd188137d4a6d3d1f3a
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

Commit-ID:  7dba33c6346c337aac3f7cd188137d4a6d3d1f3a
Gitweb:     https://git.kernel.org/tip/7dba33c6346c337aac3f7cd188137d4a6d3d1f3a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 30 Apr 2018 12:00:14 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 16:10:41 +0200

clocksource: Rework stale comment

AFAICS the hotplug code no longer uses this function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Link: https://lkml.kernel.org/r/20180430100344.656525644@infradead.org

---
 kernel/time/clocksource.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 605656df16c4..84f37420fcf5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -173,10 +173,8 @@ static void __clocksource_unstable(struct clocksource *cs)
  * clocksource_mark_unstable - mark clocksource unstable via watchdog
  * @cs:		clocksource to be marked unstable
  *
- * This function is called instead of clocksource_change_rating from
- * cpu hotplug code to avoid a deadlock between the clocksource mutex
- * and the cpu hotplug mutex. It defers the update of the clocksource
- * to the watchdog thread.
+ * This function is called by the x86 TSC code to mark clocksources as unstable;
+ * it defers demotion and re-selection to a kthread.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {

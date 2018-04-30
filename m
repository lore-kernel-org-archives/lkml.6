Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbeD3KFc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:05:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60116 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeD3KEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:04:51 -0400
Message-Id: <20180430100344.656525644@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 12:00:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH v2 6/7] clocksource: Rework stale comment
References: <20180430100008.503783478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-7.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICS the hotplug code no longer uses this function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/clocksource.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -173,10 +173,8 @@ static void __clocksource_unstable(struc
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

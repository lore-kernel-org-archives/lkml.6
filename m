Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeEULMw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 07:12:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41194 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeEULMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 07:12:51 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PM: wakeup: Make the "aborting suspend" message debug
Date: Mon, 21 May 2018 13:12:12 +0200
Message-ID: <24631155.j0D4AbJmQY@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The message printed by pm_wakeup_pending() on wakeup detection is
not very useful if someone is not interested specifically in
debugging wakeup, so turn it into a pm_debug() one.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -853,7 +853,7 @@ bool pm_wakeup_pending(void)
 	spin_unlock_irqrestore(&events_lock, flags);
 
 	if (ret) {
-		pr_info("PM: Wakeup pending, aborting suspend\n");
+		pr_debug("PM: Wakeup pending, aborting suspend\n");
 		pm_print_active_wakeup_sources();
 	}
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbeDQPW0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:22:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:22:25 -0400
Date: Tue, 17 Apr 2018 08:22:13 -0700
From: tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-4450dc0ae2c18a0ac6dce560215c7a1fa12122b5@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, fweisbec@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        geert+renesas@glider.be
Reply-To: mingo@kernel.org, hpa@zytor.com, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, fweisbec@gmail.com
In-Reply-To: <1522942018-14471-1-git-send-email-geert+renesas@glider.be>
References: <1522942018-14471-1-git-send-email-geert+renesas@glider.be>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clockevents: Fix kernel messages split across
 multiple lines
Git-Commit-ID: 4450dc0ae2c18a0ac6dce560215c7a1fa12122b5
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

Commit-ID:  4450dc0ae2c18a0ac6dce560215c7a1fa12122b5
Gitweb:     https://git.kernel.org/tip/4450dc0ae2c18a0ac6dce560215c7a1fa12122b5
Author:     Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate: Thu, 5 Apr 2018 17:26:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 17:18:04 +0200

clockevents: Fix kernel messages split across multiple lines

Convert the clockevents driver from old-style printk() to pr_info() and
pr_cont(), to fix split kernel messages like below:

    Clockevents: could not switch to one-shot mode:
     dummy_timer is not functional.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://lkml.kernel.org/r/1522942018-14471-1-git-send-email-geert%2Brenesas@glider.be

---
 kernel/time/tick-oneshot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index c1f518e7aa80..6fe615d57ebb 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -82,16 +82,15 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 	if (!dev || !(dev->features & CLOCK_EVT_FEAT_ONESHOT) ||
 		    !tick_device_is_functional(dev)) {
 
-		printk(KERN_INFO "Clockevents: "
-		       "could not switch to one-shot mode:");
+		pr_info("Clockevents: could not switch to one-shot mode:");
 		if (!dev) {
-			printk(" no tick device\n");
+			pr_cont(" no tick device\n");
 		} else {
 			if (!tick_device_is_functional(dev))
-				printk(" %s is not functional.\n", dev->name);
+				pr_cont(" %s is not functional.\n", dev->name);
 			else
-				printk(" %s does not support one-shot mode.\n",
-				       dev->name);
+				pr_cont(" %s does not support one-shot mode.\n",
+					dev->name);
 		}
 		return -EINVAL;
 	}

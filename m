Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeEPUY5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:24:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38273 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeEPUYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:24:55 -0400
Date: Wed, 16 May 2018 13:24:45 -0700
From: tip-bot for Mathieu Malaterre <tipbot@zytor.com>
Message-ID: <tip-db6f9e55c8d80a4a1a329b9b68a1d370bffb6aad@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, sboyd@kernel.org,
        john.stultz@linaro.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        malat@debian.org
Reply-To: malat@debian.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org
In-Reply-To: <20180516195943.31924-1-malat@debian.org>
References: <20180516195943.31924-1-malat@debian.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource: Move inline keyword to the beginning
 of function declarations
Git-Commit-ID: db6f9e55c8d80a4a1a329b9b68a1d370bffb6aad
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

Commit-ID:  db6f9e55c8d80a4a1a329b9b68a1d370bffb6aad
Gitweb:     https://git.kernel.org/tip/db6f9e55c8d80a4a1a329b9b68a1d370bffb6aad
Author:     Mathieu Malaterre <malat@debian.org>
AuthorDate: Wed, 16 May 2018 21:59:43 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 16 May 2018 22:21:32 +0200

clocksource: Move inline keyword to the beginning of function declarations

The inline keyword was not at the beginning of the function declarations.
Fix the following warnings triggered when using W=1:

  kernel/time/clocksource.c:456:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
  kernel/time/clocksource.c:457:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/20180516195943.31924-1-malat@debian.org

---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 56fd2239674f..f89a78e2792b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -442,8 +442,8 @@ static inline int __clocksource_watchdog_work(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
-static void inline clocksource_watchdog_lock(unsigned long *flags) { }
-static void inline clocksource_watchdog_unlock(unsigned long *flags) { }
+static inline void clocksource_watchdog_lock(unsigned long *flags) { }
+static inline void clocksource_watchdog_unlock(unsigned long *flags) { }
 
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 

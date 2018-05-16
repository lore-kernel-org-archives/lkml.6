Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbeEPT7t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:59:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52186 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbeEPT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:59:47 -0400
X-Google-Smtp-Source: AB8JxZq7n+ur9nGr86d9ySDJiS8wUOz+oTEcRkUehH0YF9ijrxr0VtDozNMeN1USUnKIS1F6rsmNAQ==
From: Mathieu Malaterre <malat@debian.org>
To: John Stultz <john.stultz@linaro.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Move the inline keyword at the beginning of function declarations
Date: Wed, 16 May 2018 21:59:43 +0200
Message-Id: <20180516195943.31924-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline keyword was not at the beginning of the function declarations.
Fix the following warnings triggered when using W=1:

  kernel/time/clocksource.c:456:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
  kernel/time/clocksource.c:457:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 kernel/time/clocksource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 84f37420fcf5..e0ff8f94f237 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -453,8 +453,8 @@ static inline int __clocksource_watchdog_kthread(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
-static void inline clocksource_watchdog_lock(unsigned long *flags) { }
-static void inline clocksource_watchdog_unlock(unsigned long *flags) { }
+static inline void clocksource_watchdog_lock(unsigned long *flags) { }
+static inline void clocksource_watchdog_unlock(unsigned long *flags) { }
 
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 
-- 
2.11.0

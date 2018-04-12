Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeDLHJe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:09:34 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37655 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbeDLHJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:09:26 -0400
X-Google-Smtp-Source: AIpwx48WCwgx+Z08GcaATh+wNhKxYgiLrjpx7+U+GE0OC2XI8iplN3T4mpaQhzq3oQjcviDZKaDE7g==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nohz: Align types to bool for tick_nohz_tick_stopped()
Date: Thu, 12 Apr 2018 09:09:18 +0200
Message-Id: <1523516959-5761-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent was likely to also make the inline version a bool, so let's
change this.

Fixes: a364298359e7 ("nohz: Convert tick_nohz_tick_stopped() to bool")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Rebased on top of Linus' latest master to apply cleanly.

---
 include/linux/tick.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 55388ab..4132eba 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -137,7 +137,7 @@ static inline void tick_nohz_idle_stop_tick_protected(void)
 
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
-static inline int tick_nohz_tick_stopped(void) { return 0; }
+static inline bool tick_nohz_tick_stopped(void) { return false; }
 static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
 static inline void tick_nohz_idle_stop_tick(void) { }
 static inline void tick_nohz_idle_retain_tick(void) { }
-- 
2.7.4

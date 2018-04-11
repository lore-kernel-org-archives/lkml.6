Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeDKLBr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 07:01:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45588 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeDKLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 07:01:46 -0400
X-Google-Smtp-Source: AIpwx4/yRX0M4EFeTxHLsuV26JYWFRZVlKUKDHyxSVlnoP2wQFCJ9wNshB3OlRa/htdiRzfwaaDNUg==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nohz: Align types to bool for tick_nohz_tick_stopped()
Date: Wed, 11 Apr 2018 13:01:32 +0200
Message-Id: <1523444493-12665-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent was likely to also make the inline version a bool, so let's
change this.

Fixes: a364298359e7 ("nohz: Convert tick_nohz_tick_stopped() to bool")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tick.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7f8c9a1..f9070b9 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -125,7 +125,7 @@ extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
-static inline int tick_nohz_tick_stopped(void) { return 0; }
+static inline bool tick_nohz_tick_stopped(void) { return false; }
 static inline int tick_nohz_tick_stopped_cpu(int cpu) { return 0; }
 static inline void tick_nohz_idle_enter(void) { }
 static inline void tick_nohz_idle_exit(void) { }
-- 
2.7.4

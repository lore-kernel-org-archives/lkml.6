Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbeBHNsy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:48:54 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46765 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeBHNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:48:42 -0500
X-Google-Smtp-Source: AH8x224W44Wi+oJtPiUjLuVQfM2iWOZSni5zbey2cYVpws3BDRMi2Vkwjl904kM4KsF8c/AJJvyoqA==
From: Leo Yan <leo.yan@linaro.org>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Leo Yan <leo.yan@linaro.org>,
        Vikram Mulukutla <markivx@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] sched/cpufreq: Remove unused macro SUGOV_KTHREAD_PRIORITY
Date: Thu,  8 Feb 2018 21:48:22 +0800
Message-Id: <1518097702-9665-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since schedutil kernel thread directly set priority to 0, the macro
SUGOV_KTHREAD_PRIORITY is not used.  So remove it.

Cc: Vikram Mulukutla <markivx@codeaurora.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index dd062a1..7936f54 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -19,8 +19,6 @@
 
 #include "sched.h"
 
-#define SUGOV_KTHREAD_PRIORITY	50
-
 struct sugov_tunables {
 	struct gov_attr_set attr_set;
 	unsigned int rate_limit_us;
-- 
2.7.4

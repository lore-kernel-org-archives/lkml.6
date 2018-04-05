Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeDEQRU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:17:20 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38562 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeDEQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:17:18 -0400
X-Google-Smtp-Source: AIpwx48ie3pMoMftSdjmmxRiGotGMCRMMLVnKGu/fQfFPI/ejR+3E4cs+mTtq0xrGL3hVVWXJB9RUQ==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: viresh.kumar@linaro.org, edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3 7/7] cpuidle/drivers/cpuidle-arm: Register the cooling device
Date: Thu,  5 Apr 2018 18:16:44 +0200
Message-Id: <1522945005-7165-8-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the ARM generic cpuidle driver as a cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index ddee1b6..44b4fe3 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -172,6 +173,8 @@ static int __init arm_idle_init(void)
 			goto out_fail;
 	}
 
+	cpuidle_cooling_register();
+
 	return 0;
 
 out_fail:
-- 
2.7.4

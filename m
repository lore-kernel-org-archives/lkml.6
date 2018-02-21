Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938354AbeBUPaJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:30:09 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39530 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938327AbeBUPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:30:02 -0500
X-Google-Smtp-Source: AH8x225/yfYdbX0DfCYIgOiX7qqjMposNRzt0xvkW/r84LOI5yCDPDcPYavCakhyc7a1MPr/FIU30w==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH V2 7/7] cpuidle/drivers/cpuidle-arm: Register the cooling device
Date: Wed, 21 Feb 2018 16:29:28 +0100
Message-Id: <1519226968-19821-8-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the ARM generic cpuidle driver as a cooling device.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index ddee1b6..c100915 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -11,6 +11,7 @@
 
 #define pr_fmt(fmt) "CPUidle arm: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -172,6 +173,10 @@ static int __init arm_idle_init(void)
 			goto out_fail;
 	}
 
+	ret = cpuidle_cooling_register();
+	if (ret)
+		pr_warn("Failed to register the cpuidle cooling device\n");
+
 	return 0;
 
 out_fail:
-- 
2.7.4

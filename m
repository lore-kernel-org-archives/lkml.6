Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85119C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BA920651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5Cga2c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BA920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeJWEtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:49:06 -0400
Received: from mail-ot1-f73.google.com ([209.85.210.73]:48625 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeJWEtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 00:49:06 -0400
Received: by mail-ot1-f73.google.com with SMTP id 30so19731767ota.15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JagOLnWKBbMiEEr6b0nEo5A7+QFScixLH/s9yI7p3Hc=;
        b=Z5Cga2c47YOzY2FcS05xmXyAJEloSPvBWc6Hlg8KzUmiP70vpEGkzF3z2EYxua5Q8t
         HpCnVJk3I8cBvY/rIXwxi/uXvduDyjQB5NkdWiwTqZvQtuijzr6Bs3LlECCSBR9k4HYU
         Blj6Nr/uUra6BkTSgV61MHvSOx/9slCXVyaLkv/u0kug4P+PBYFefvwbJqsb7GIWuG9x
         Dk0G19ckQ/7RgtsHL8fvpONAA0OxBYUhBeT094oOJPJbIInDf9PuyOUJdJdTQUnG0K2z
         rm90wezQfvMoKDSVApQ/LENpssNk9mU5X47EPgUc413B7TZDg/cI/SKsfwpoo53sN8fC
         iOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JagOLnWKBbMiEEr6b0nEo5A7+QFScixLH/s9yI7p3Hc=;
        b=ThrweSpbsLWq5G80+txTYXzI91PysLz53ofkEzhJHrYOVjO3ddTdetrnT9/bOE8aSj
         a1nIYo05Q+y4NWAcVRycFYjWemcrg9FpFqWpv+P8i5KruB7APg/XPSkUQ24i8eNPlrMZ
         BItPgfIyIOJHhn/S8ZDBKD0ZYPcH91K9Kb0TwQeccw/4bTT0VzdlgeDiMLU55NI9VKaW
         5XVIgGZS0OD7HT0IXWTIZp9KL0AyJVTstTTLQoaZq2o0FaerKL393ewNWPBpafNRJcZh
         +ND2w67QY/CHdTii3CbUIfvjLBzrtpVkz5mUQhoGO7Y7/Zbc1gPlVLHtA9WsZ658c7Qs
         VjDQ==
X-Gm-Message-State: ABuFfogqNtBfqRXwOMn2bjyPLoOCXFzEbXiY7ZPIvkBrOmKU3wMkRLwa
        W1O1WCThKe9mhg0RsIIyLnw+rMP9/JNBIiHdbu61vWsehYHXHrWHMzfS3iE9ab7/i5INtyqZUFi
        nWhFTqa481hkeTZhMthvu0pG3EpH/saRH6gJ/pnWIStjJZg8lGU0JpfaDkUk5gvelZStoMdVQ
X-Google-Smtp-Source: ACcGV61M4afbVPLGv0WTPaIhbl2+VJyKBXYOJLm1lnHYswmcxI1N/7Ck8GMfSIL/Nfrgf2fXONgG5PuYPttz
X-Received: by 2002:a9d:b9:: with SMTP id w54mr37581097oti.30.1540240145386;
 Mon, 22 Oct 2018 13:29:05 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:29:01 -0600
Message-Id: <20181022202901.1654-1-zwisler@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH] thermal: add ratelimited thermal and power logging
From:   Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ricky Liang <jcliang@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Stephen Barber <smbarber@chromium.org>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricky Liang <jcliang@chromium.org>

Add thermal logs in devfreq_cooling and cpu_cooling.  Also add logging to
power_allocator when it starts to control power.

These changes can lead to excessive log spam when running up against
thermal limits, so have this logging ratelimited to allow only 1 log each
30 seconds from each of those subsystems.

Signed-off-by: Ricky Liang <jcliang@chromium.org>
Co-authored-by: Stephen Barber <smbarber@chromium.org>
Signed-off-by: Stephen Barber <smbarber@chromium.org>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
[ rez: squashed initial implementation & fixes, updated changelog for
  upstream. ]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/thermal/cpu_cooling.c     | 16 ++++++++++++++++
 drivers/thermal/devfreq_cooling.c | 12 ++++++++++++
 drivers/thermal/power_allocator.c | 17 +++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778a..d8d1855d7d991 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -31,9 +31,17 @@
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/cpu_cooling.h>
+#include <linux/ratelimit.h>
 
 #include <trace/events/thermal.h>
 
+static DEFINE_RATELIMIT_STATE(cpu_cooling_ratelimit_state, 30 * HZ, 1);
+
+static int cpu_cooling_ratelimit(void)
+{
+	return __ratelimit(&cpu_cooling_ratelimit_state);
+}
+
 /*
  * Cooling state <-> CPUFreq frequency
  *
@@ -389,6 +397,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	unsigned int clip_freq;
+	struct device *cpu_dev;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -404,6 +413,13 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
 
+	if (cpu_cooling_ratelimit()) {
+		cpu_dev = get_cpu_device(cpufreq_cdev->policy->cpu);
+		dev_info(cpu_dev,
+			 "Cooling state set to %lu. New max freq = %u\n",
+			 state, clip_freq);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256887ff6..f95c7f513f05a 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/pm_opp.h>
 #include <linux/thermal.h>
+#include <linux/ratelimit.h>
 
 #include <trace/events/thermal.h>
 
@@ -32,6 +33,13 @@
 
 static DEFINE_IDA(devfreq_ida);
 
+static DEFINE_RATELIMIT_STATE(devfreq_cooling_ratelimit_state, 30 * HZ, 1);
+
+static int devfreq_cooling_ratelimit(void)
+{
+	return __ratelimit(&devfreq_cooling_ratelimit_state);
+}
+
 /**
  * struct devfreq_cooling_device - Devfreq cooling device
  * @id:		unique integer value corresponding to each
@@ -150,6 +158,10 @@ static int devfreq_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 
 	dfc->cooling_state = state;
 
+	if (devfreq_cooling_ratelimit())
+		dev_info(dev, "Cooling state set to %lu. New max freq = %u\n",
+			 state, dfc->freq_table[state]);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 3055f9a12a170..5140a07fe60aa 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -15,6 +15,7 @@
 
 #define pr_fmt(fmt) "Power allocator: " fmt
 
+#include <linux/ratelimit.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 #include <linux/thermal.h>
@@ -30,6 +31,13 @@
 #define int_to_frac(x) ((x) << FRAC_BITS)
 #define frac_to_int(x) ((x) >> FRAC_BITS)
 
+static DEFINE_RATELIMIT_STATE(power_allocator_ratelimit_state, 30 * HZ, 1);
+
+static int power_allocator_ratelimit(void)
+{
+	return __ratelimit(&power_allocator_ratelimit_state);
+}
+
 /**
  * mul_frac() - multiply two fixed-point numbers
  * @x:	first multiplicand
@@ -443,6 +451,15 @@ static int allocate_power(struct thermal_zone_device *tz,
 				      max_allocatable_power, tz->temperature,
 				      control_temp - tz->temperature);
 
+	if (total_granted_power < total_req_power &&
+			power_allocator_ratelimit()) {
+		dev_info(&tz->device, "Controlling power: control_temp=%d "
+			 "last_temp=%d, curr_temp=%d total_requested_power=%d "
+			 "total_granted_power=%d\n", control_temp,
+			 tz->last_temperature, tz->temperature,
+			 total_req_power, total_granted_power);
+	}
+
 	kfree(req_power);
 unlock:
 	mutex_unlock(&tz->lock);
-- 
2.19.1.568.g152ad8e336-goog


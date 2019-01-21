Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E41C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0087320870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCtyzqGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfAUPnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:43:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40150 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbfAUPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:43:38 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so11190256wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6nK5Z7skk0g3LC/CfG1f/AiMAh85ZzuJOt+3kzqjet0=;
        b=BCtyzqGCEaRnpexFp/8u0S0xLLNlc/eLc1RE+1luRPpgO2HLYQY+VS2oWTHdcc0HQ3
         4jh6sm6O35/GKcPGP0A+eYmGY1PVK7xR2w9iULuvIWlZgTcZNuJgD4TQoD9hELoHNXTV
         Ffh+LqclWWKwo+HtTeTnZv0GYrSmMHfCI4wGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6nK5Z7skk0g3LC/CfG1f/AiMAh85ZzuJOt+3kzqjet0=;
        b=m+sw8jOVVhUiNfgHoEH2vlrThxiYM5XkZHiMYjIdLnOmSa6dEDqLPUBqYSH3XNvbcD
         8NQT0Evn4HPLadXih0ffK+TMrB8CeEVhV9j5M4SVLedfRvIJUvSepQeAJcxhw4FqLN9C
         UPr4awC/CwTouYsIlw0x9lYrwjVTXbg5WBM6U5fT0cEww/t3nMk6KAkGcgSECs1ABkqh
         7PpgdDYdiXW+DcOnPnyGTz0YaVenZAaivGpnp2i2j7xxpllXdcIImlXVBdvWL9+gUGrg
         AsncKixmEyDFE0qtN+4dEHsOkF+R7/srl6liUknP2eUkeA+8cHXMV51c33Ipc+PRLpoc
         fNjA==
X-Gm-Message-State: AJcUukc92KbJvoy3OMQD3gLUAkp7Ckvlxg4kSvo6q0Y6+ZKzOrIBRZW+
        zzZNdQ7DPEA7DZlwyDV32mEULC9WRtU=
X-Google-Smtp-Source: ALg8bN6I88MxOM7njkA7lOhPxp8KzvrOmjChQXyjD7+grSL1kJXEwy1L6wnz8lUISdyDXDZgTfFuOQ==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr24971901wmc.42.1548085415973;
        Mon, 21 Jan 2019 07:43:35 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id n15sm76230608wrt.21.2019.01.21.07.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:43:35 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/9] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date:   Mon, 21 Jan 2019 21:10:27 +0530
Message-Id: <0036de796308b8919eac74a9a910f0d7b9c0cbf8.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All cpufreq drivers do similar things to register as a cooling device.
Provide a cpufreq driver flag so drivers can just ask the cpufreq core
to register the cooling device on their behalf. This allows us to get
rid of duplicated code in the drivers.

In order to allow this, we add a struct thermal_cooling_device pointer
to struct cpufreq_policy so that drivers don't need to store it in a
private data structure.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/cpufreq/cpufreq.c |  6 ++++++
 include/linux/cpufreq.h   | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bc..cf1be057caf4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1318,6 +1318,9 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
+		register_cooling_device(policy);
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1405,6 +1408,9 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
+		unregister_cooling_device(policy);
+
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bd7fbd6a4478..02fc9f210aee 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
@@ -151,6 +152,11 @@ struct cpufreq_policy {
 
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
+
+#ifdef CONFIG_CPU_THERMAL
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
+#endif
 };
 
 /* Only for ACPI */
@@ -386,6 +392,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
+/*
+ * Set by drivers that want the core to automatically register the cpufreq
+ * driver as a thermal cooling device.
+ */
+#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
@@ -415,6 +427,19 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
 			policy->cpuinfo.max_freq);
 }
 
+#ifdef CONFIG_CPU_THERMAL
+static inline void register_cooling_device(struct cpufreq_policy *policy) {
+	policy->cdev = of_cpufreq_cooling_register(policy);
+}
+
+static inline void unregister_cooling_device(struct cpufreq_policy *policy) {
+	cpufreq_cooling_unregister(policy->cdev);
+	policy->cdev = NULL;
+}
+#else
+static inline void register_cooling_device(struct cpufreq_policy *policy) {}
+static inline void unregister_cooling_device(struct cpufreq_policy *policy) {}
+#endif
 #ifdef CONFIG_CPU_FREQ
 void cpufreq_suspend(void);
 void cpufreq_resume(void);
-- 
2.17.1


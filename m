Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB75C2F43D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B25720870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZrUCGY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfAUPpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:45:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45578 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbfAUPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:45:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so23861799wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
        b=WZrUCGY19DdCA1w3IHmK8oICHtgLdphKhOGUd5vevBnrBwrSzPdnkuBmbMvPX8lyUJ
         gl2gYp4z2QWp6fpzF4xTqXXp1aWdW4A1icNf4057BL7T6Y0JC6fajhO44w6GvSJzq9kh
         mo+iF/5MENrCUeILCAUvYs9e1ty9iNJS79FpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
        b=X03XW0IGgZQI55AkvFkrxdM5tk9KI8drBxuzFTTKXbA4qrbbO8263nqe3V6Rf6Ztcw
         WxuP08Pceqh7NGMUS4RvBdK8qw/LC54qzmGTgAxCFUFns6qrN2T30Ivgf1TAWl9d8Cqx
         inRb87BZHdlvpJo2XXN0YZRSkpioe7FPN6S2yeNlxTN86sxbC951UJNUZKfsx6Ac2zR1
         gsHPbBs2ORQmrvZJG4VXAUuNWej7aLk3eGDx/TiMux/Uc9vKVPhYk506zOV4xWr2fJwc
         b4EfWLzqFt1wjiqB4NHHVg3wYjCsQMOVJG0JiIiYj7CaNrWtKxxJFehF9jW0KTLCnCz6
         UHOA==
X-Gm-Message-State: AJcUukeU8AMx1St5a76I/EK51qwi6xyU81WU78od2EGra89mzjtLkQku
        t6sfnZSMU+JzZAlZr76qr0zCHauzyUc=
X-Google-Smtp-Source: ALg8bN6vWF75HLhXc63FN75VVMGq8sjmo7J7dYzSKP/6RsvGbhhuiONu2VRLaImfOVzYYKxTUis/LQ==
X-Received: by 2002:adf:f785:: with SMTP id q5mr28138392wrp.9.1548085514799;
        Mon, 21 Jan 2019 07:45:14 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id r12sm105023879wrq.3.2019.01.21.07.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:45:14 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 6/9] cpufreq: mediatek: Use auto-registration of thermal cooling device
Date:   Mon, 21 Jan 2019 21:10:31 +0530
Message-Id: <4253d7a24e9c85ca24cceef599ab8da8682e0bee.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d39818..9a937f4c63e7 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -14,7 +14,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/module.h>
@@ -48,7 +47,6 @@ struct mtk_cpu_dvfs_info {
 	struct regulator *sram_reg;
 	struct clk *cpu_clk;
 	struct clk *inter_clk;
-	struct thermal_cooling_device *cdev;
 	struct list_head list_head;
 	int intermediate_voltage;
 	bool need_voltage_tracking;
@@ -307,13 +305,6 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 #define DYNAMIC_POWER "dynamic-power-coefficient"
 
-static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct mtk_cpu_dvfs_info *info = policy->driver_data;
-
-	info->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 {
 	struct device *cpu_dev;
@@ -472,7 +463,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 
-	cpufreq_cooling_unregister(info->cdev);
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
 
 	return 0;
@@ -480,13 +470,13 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_set_target,
 	.get = cpufreq_generic_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
-	.ready = mtk_cpufreq_ready,
 	.name = "mtk-cpufreq",
 	.attr = cpufreq_generic_attr,
 };
-- 
2.17.1


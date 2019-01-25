Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2309C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3A22184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sbigyd7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfAYHD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:03:27 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40622 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbfAYHD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:03:26 -0500
Received: by mail-yb1-f196.google.com with SMTP id i6so3446184ybo.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
        b=Sbigyd7JmgLIlZ+I8Oa1biLl04Yqaku8qwP4GxQjehESlXzS4ZDj06HZsdDus/h5jp
         6pchh/E0nJernzSmSS/DQOTeRvMl0jDrvFSc6TyL3twTCmUGu1Nc01rRiSKUv5Oj0qBY
         ouKw3DMoqh48jdgClJF2nCqK3oD35XsPX3Y10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
        b=bnpBcTNNDWmhY5U7kkQkb4hjqu7RbKRC+DihG/yVuKIZSf+3NC95j9AzjZ0T4aIM5C
         KeoLJCLmKuOgIJUO1eu8Aws8SO7vUE9rScEOZx88LltOhPMAmBkQgIe8GXqR38ZTaxW7
         lsgI87igKfovW9Wu+3MRZZNWzOK24PIrwCO1U7Wto5zV3zEEkdHceQfdM7bZ/t1IB71X
         1jdL0OFKRWW9REtNBUUpfJJTfShSNKEe0fXX5E5Debp5Ig5+GDvCRJNC6skixI+ZbUkz
         fPiGaz96/3W9vxQ4xlrfQUdo3TR8s2cxQ9HgVzSGYz4n9hsOlrj2rMh1spGKaYnyVFX1
         4EIQ==
X-Gm-Message-State: AJcUukfuFcpJstBSa+C88L2m09GgKYcwfultFVFdrjvuzpfuwrkGsTzI
        9X1olUrbBbumZGCCiJgz2lbGRmIyH34=
X-Google-Smtp-Source: ALg8bN58EbqqRRNEU3mB7QLSSmV6TAP0kmLn1/+IwmGM/Dg7drlFTgOUGrtSJLqTJKTTjCRc3wyIog==
X-Received: by 2002:a5b:412:: with SMTP id m18mr9106264ybp.243.1548399805154;
        Thu, 24 Jan 2019 23:03:25 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id f62sm10310024ywd.68.2019.01.24.23.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:03:24 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCHv3 6/9] cpufreq: mediatek: Use auto-registration of thermal cooling device
Date:   Fri, 25 Jan 2019 12:32:26 +0530
Message-Id: <fee6f634d8966a8493f13c1a06735d81d8170e26.1548398851.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
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


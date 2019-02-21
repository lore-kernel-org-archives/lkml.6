Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE96C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C462086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="knkqd6Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfBULaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:30:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42046 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfBUL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:29:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id s1so14033095plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 03:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUSOtrKC0cvgq0LNDb8X2IQi37D42NUAt00uzjw6vNU=;
        b=knkqd6Qc6jhM3C6HkRhK0/1smujaW0vqStekQ6oQB0TS7nJlnyGIja7CsK4cuKj/xD
         M9Mg4EAIsd+gKPA/F2yZBXkXq975oIkd9pKL4M2TBhNjaElkLPHZj0lb+uL9ORop4CJ5
         p4PGV9SykN4Syt07PdGwHR3imdqCksGG0QiTUCGrWZrMxwtEACkrIBb1XmMKsJAH1VzM
         UszuZ4ydcV6Y5mWlYuGtECgyPHvI1yneLw7cVVzswPvT/jwWx2d66i6Qx7KmLhJ/PpSV
         sT5J1AQg7WhyFBm9A1qHUMLYcCVrETBn5eyoDaEnFr/quEgurhAaZEQP1CpXoEhuar2K
         Qg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUSOtrKC0cvgq0LNDb8X2IQi37D42NUAt00uzjw6vNU=;
        b=h36Ew584Eq2wgdYT3E2Ej1CI1REEbQXmp0d21VJAi5gjsHwSztcJwnSATJ/wRiifmo
         2asTGQySz6Ox8jQe3zEcPOOsVM4/HMGXVOLARWebGF3ZYWD7J5oy8av9QuEtjZTFXgSm
         /A4soSO/3nPR3p9+cV08oUhbNeOBQFJghxDOSdsGBH33Bd34Fas5ZgYE0TmLC3RDn4PG
         udRKFJ87r2f9IZ2WUkRtnFLBuRGXImSp4y3b1rK/kub54oelf3CqfCS5z3ZBGpLmjgAm
         qEcQOpnhuuaHl7fUT08fbSk3zSZ3aKqjQ3dqHCsZIhmsSeAxPI6CMBpXON4i96G/7zfj
         z8Vw==
X-Gm-Message-State: AHQUAubZRAYco/t6cTTTK98vzfC+fAK8Kr/HWLl63lvGG9ODo1Ftx6k6
        KM/Xo+pSy9SimqHulTya48KerQ==
X-Google-Smtp-Source: AHgI3IbDVbtMd17X44exx+48u2pMdnj2viUmaHRWh5y8cOBEmxjZ1+uIxJo4jlLAdUNGKz+LVeL4Zg==
X-Received: by 2002:a17:902:aa06:: with SMTP id be6mr21663518plb.57.1550748598779;
        Thu, 21 Feb 2019 03:29:58 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id h64sm6614216pfj.40.2019.02.21.03.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:29:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, Qais.Yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS framework
Date:   Thu, 21 Feb 2019 16:59:30 +0530
Message-Id: <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1550748118.git.viresh.kumar@linaro.org>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This registers the notifiers for min/max frequency constraints with the
PM QoS framework. The constraints are also taken into consideration in
cpufreq_set_policy().

This also relocates cpufreq_policy_put_kobj() as it is required to be
called from cpufreq_policy_alloc() now.

No constraints are added until now though.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 135 +++++++++++++++++++++++++++++++-------
 include/linux/cpufreq.h   |   4 ++
 2 files changed, 116 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e626b00053b..d615bf35ac00 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
@@ -1082,11 +1083,77 @@ static void handle_update(struct work_struct *work)
 	cpufreq_update_policy(cpu);
 }
 
+static void cpufreq_update_freq_work(struct work_struct *work)
+{
+	struct cpufreq_policy *policy =
+		container_of(work, struct cpufreq_policy, req_work);
+	struct cpufreq_policy new_policy = *policy;
+
+	/* We should read constraint values from QoS layer */
+	new_policy.min = 0;
+	new_policy.max = UINT_MAX;
+
+	down_write(&policy->rwsem);
+
+	if (!policy_is_inactive(policy))
+		cpufreq_set_policy(policy, &new_policy);
+
+	up_write(&policy->rwsem);
+}
+
+static int cpufreq_update_freq(struct cpufreq_policy *policy)
+{
+	schedule_work(&policy->req_work);
+	return 0;
+}
+
+static int cpufreq_notifier_min(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_min);
+
+	return cpufreq_update_freq(policy);
+}
+
+static int cpufreq_notifier_max(struct notifier_block *nb, unsigned long freq,
+				void *data)
+{
+	struct cpufreq_policy *policy = container_of(nb, struct cpufreq_policy, nb_max);
+
+	return cpufreq_update_freq(policy);
+}
+
+static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
+{
+	struct kobject *kobj;
+	struct completion *cmp;
+
+	down_write(&policy->rwsem);
+	cpufreq_stats_free_table(policy);
+	kobj = &policy->kobj;
+	cmp = &policy->kobj_unregister;
+	up_write(&policy->rwsem);
+	kobject_put(kobj);
+
+	/*
+	 * We need to make sure that the underlying kobj is
+	 * actually not referenced anymore by anybody before we
+	 * proceed with unloading.
+	 */
+	pr_debug("waiting for dropping of refcount\n");
+	wait_for_completion(cmp);
+	pr_debug("wait complete\n");
+}
+
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 {
 	struct cpufreq_policy *policy;
+	struct device *dev = get_cpu_device(cpu);
 	int ret;
 
+	if (!dev)
+		return NULL;
+
 	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
 	if (!policy)
 		return NULL;
@@ -1103,20 +1170,45 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
-		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		dev_err(dev, "%s: failed to init policy->kobj: %d\n", __func__, ret);
 		goto err_free_real_cpus;
 	}
 
+	policy->nb_min.notifier_call = cpufreq_notifier_min;
+	policy->nb_max.notifier_call = cpufreq_notifier_max;
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
+				      DEV_PM_QOS_MIN_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_kobj_remove;
+	}
+
+	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
+				      DEV_PM_QOS_MAX_FREQUENCY);
+	if (ret) {
+		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
+			ret, cpumask_pr_args(policy->cpus));
+		goto err_min_qos_notifier;
+	}
+
 	INIT_LIST_HEAD(&policy->policy_list);
 	init_rwsem(&policy->rwsem);
 	spin_lock_init(&policy->transition_lock);
 	init_waitqueue_head(&policy->transition_wait);
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update);
+	INIT_WORK(&policy->req_work, cpufreq_update_freq_work);
 
 	policy->cpu = cpu;
 	return policy;
 
+err_min_qos_notifier:
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
+err_kobj_remove:
+	cpufreq_policy_put_kobj(policy);
 err_free_real_cpus:
 	free_cpumask_var(policy->real_cpus);
 err_free_rcpumask:
@@ -1129,30 +1221,9 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	return NULL;
 }
 
-static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
-{
-	struct kobject *kobj;
-	struct completion *cmp;
-
-	down_write(&policy->rwsem);
-	cpufreq_stats_free_table(policy);
-	kobj = &policy->kobj;
-	cmp = &policy->kobj_unregister;
-	up_write(&policy->rwsem);
-	kobject_put(kobj);
-
-	/*
-	 * We need to make sure that the underlying kobj is
-	 * actually not referenced anymore by anybody before we
-	 * proceed with unloading.
-	 */
-	pr_debug("waiting for dropping of refcount\n");
-	wait_for_completion(cmp);
-	pr_debug("wait complete\n");
-}
-
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
+	struct device *dev = get_cpu_device(policy->cpu);
 	unsigned long flags;
 	int cpu;
 
@@ -1164,6 +1235,10 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
+				   DEV_PM_QOS_MAX_FREQUENCY);
+	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
+				   DEV_PM_QOS_MIN_FREQUENCY);
 	cpufreq_policy_put_kobj(policy);
 	free_cpumask_var(policy->real_cpus);
 	free_cpumask_var(policy->related_cpus);
@@ -2239,6 +2314,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	unsigned long min, max;
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2253,11 +2330,23 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (new_policy->min > new_policy->max)
 		return -EINVAL;
 
+	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
+	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
+
+	if (min > new_policy->min)
+		new_policy->min = min;
+	if (max < new_policy->max)
+		new_policy->max = max;
+
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
 	if (ret)
 		return ret;
 
+	/*
+	 * The notifier-chain shall be removed once all the users of
+	 * CPUFREQ_ADJUST are moved to use the QoS framework.
+	 */
 	/* adjust if necessary - all reasons */
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 			CPUFREQ_ADJUST, new_policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b160e98076e3..f8f48d8a9b52 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -90,6 +90,7 @@ struct cpufreq_policy {
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
+	struct work_struct	req_work;
 
 	struct cpufreq_user_policy user_policy;
 	struct cpufreq_frequency_table	*freq_table;
@@ -154,6 +155,9 @@ struct cpufreq_policy {
 
 	/* Pointer to the cooling device if used for thermal mitigation */
 	struct thermal_cooling_device *cdev;
+
+	struct notifier_block nb_min;
+	struct notifier_block nb_max;
 };
 
 /* Only for ACPI */
-- 
2.21.0.rc0.269.g1a574e7a288b


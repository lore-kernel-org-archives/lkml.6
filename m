Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062E5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6C021773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLqDVeIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfBLHG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:06:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39384 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:06:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so855141pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 23:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7lnsNfda5EyHahbpmzYfHt2btioT/RL3iWR+Fw03tg=;
        b=WLqDVeIqMJBVp5hNV5D1l5ZycFPOTbvys7yMtu0CyCGNBlD+e5ZLbRICCwKrpqGAXb
         bgXZ8g6eQY3wf2ZgqmiQLPNa3qvk9+yg+dyRm5rzjTCEVtB34kmNtIGsztDTHRf+Fuat
         p1Q8uBeabL9pHG+WlTHwzQI9j/KrzJO895FV1gHF0Lygl/U8tkRRffNV3WJPlWT/x3aj
         J3QVCV/r5j8mbUoPM0ezOGKiRPhMyNx/Fvx+DeUfF+PC8MapBEwDBB+VEtiqDbrTDB1t
         j9bLJsO8jjt7ztgIU9cQoWCd8PRjoOQkkqa6bdUMG7JiLDROO7GpO89oiIQkhtgRXs/w
         S29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7lnsNfda5EyHahbpmzYfHt2btioT/RL3iWR+Fw03tg=;
        b=nZ5EL34NuxXgvqnhz5Xvpov/v9OZRFbyqEJHyqW2yLjtX1EuUd816nbt0Bd13tln+X
         2ylEJ9WgNPNauGODVzn0y7swBqo0qLhSaqQ4967043w+AY4RCFwtYgpa5xZFS+2+AN8A
         H0ZvtZxi2I7dVFsfxSD0Q3yYtbZ8Xl2VERmUTSXfZbDlv1mTIaLNtnSRGBjTk2mNX9Tx
         FeAD/afLdJ1WS1XPXtwPHDSISK2u9Wk/P5fgGJN326GtPju8Zu9jS6r1oWHkiDN+AgHt
         zP2/JNn2KmFWTmST4wxWVQtcc+c04Ls8XRRtN21+qqaH4j4hvCJ/yC1IJCytcKBRraOH
         JgFA==
X-Gm-Message-State: AHQUAubcMwE5yjQqM3YaYXg1ONai+++hAry5zLq4J24BO+tGrq7jcSKg
        2LWynP5NI//aIewofSYRbDfSEA==
X-Google-Smtp-Source: AHgI3IYt3BhEobnqyYIdZ63zzhIoEgHFDH1kABML2CYDbVInZYnmGBO2FC8BYQ7aGn7EKiuWAJ0vaA==
X-Received: by 2002:a17:902:b20d:: with SMTP id t13mr925676plr.41.1549955216547;
        Mon, 11 Feb 2019 23:06:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id o25sm17290490pfk.185.2019.02.11.23.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 23:06:55 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] cpufreq: Allow light-weight tear down and bring up of CPUs
Date:   Tue, 12 Feb 2019 12:36:46 +0530
Message-Id: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <cover.1549955027.git.viresh.kumar@linaro.org>
References: <cover.1549955027.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core doesn't remove the cpufreq policy anymore on CPU
offline operation, rather that happens when the CPU device gets
unregistered from the kernel. This allows faster recovery when the CPU
comes back online. This is also very useful during system wide
suspend/resume where we offline all non-boot CPUs during suspend and
then bring them back on resume.

This commit takes the same idea a step ahead to allow drivers to do
light weight tear-down and bring-up during CPU offline and online
operations.

A new set of callbacks is introduced, online/offline(). online() gets
called when the first CPU of an inactive policy is brought up and
offline() gets called when all the CPUs of a policy are offlined.

The existing init/exit() callback get called on policy
creation/destruction. They also get called instead of online/offline()
callbacks if the online/offline() callbacks aren't provided.

This also moves around some code to get executed only for the new-policy
case going forward.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 55 +++++++++++++++++++++++++--------------
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 96a69c67a545..2b3e9d501f49 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1201,28 +1201,39 @@ static int cpufreq_online(unsigned int cpu)
 			return -ENOMEM;
 	}
 
-	cpumask_copy(policy->cpus, cpumask_of(cpu));
+	if (!new_policy && cpufreq_driver->online) {
+		ret = cpufreq_driver->online(policy);
+		if (ret) {
+			pr_debug("%s: %d: initialization failed\n", __func__,
+				 __LINE__);
+			goto out_exit_policy;
+		}
 
-	/* call driver. From then on the cpufreq must be able
-	 * to accept all calls to ->verify and ->setpolicy for this CPU
-	 */
-	ret = cpufreq_driver->init(policy);
-	if (ret) {
-		pr_debug("initialization failed\n");
-		goto out_free_policy;
-	}
+		/* Recover policy->cpus using related_cpus */
+		cpumask_copy(policy->cpus, policy->related_cpus);
+	} else {
+		cpumask_copy(policy->cpus, cpumask_of(cpu));
 
-	ret = cpufreq_table_validate_and_sort(policy);
-	if (ret)
-		goto out_exit_policy;
+		/*
+		 * Call driver. From then on the cpufreq must be able
+		 * to accept all calls to ->verify and ->setpolicy for this CPU.
+		 */
+		ret = cpufreq_driver->init(policy);
+		if (ret) {
+			pr_debug("%s: %d: initialization failed\n", __func__,
+				 __LINE__);
+			goto out_free_policy;
+		}
 
-	down_write(&policy->rwsem);
+		ret = cpufreq_table_validate_and_sort(policy);
+		if (ret)
+			goto out_exit_policy;
 
-	if (new_policy) {
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
 
+	down_write(&policy->rwsem);
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1421,11 +1432,12 @@ static int cpufreq_offline(unsigned int cpu)
 		cpufreq_exit_governor(policy);
 
 	/*
-	 * Perform the ->exit() even during light-weight tear-down,
-	 * since this is a core component, and is essential for the
-	 * subsequent light-weight ->init() to succeed.
+	 * Perform the ->offline() during light-weight tear-down, as
+	 * that allows fast recovery when the CPU comes back.
 	 */
-	if (cpufreq_driver->exit) {
+	if (cpufreq_driver->offline) {
+		cpufreq_driver->offline(policy);
+	} else if (cpufreq_driver->exit) {
 		cpufreq_driver->exit(policy);
 		policy->freq_table = NULL;
 	}
@@ -1454,8 +1466,13 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	cpumask_clear_cpu(cpu, policy->real_cpus);
 	remove_cpu_dev_symlink(policy, dev);
 
-	if (cpumask_empty(policy->real_cpus))
+	if (cpumask_empty(policy->real_cpus)) {
+		/* We did light-weight exit earlier, do full tear down now */
+		if (cpufreq_driver->offline)
+			cpufreq_driver->exit(policy);
+
 		cpufreq_policy_free(policy);
+	}
 }
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9db074ecbbd7..b160e98076e3 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -325,6 +325,8 @@ struct cpufreq_driver {
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
+	int		(*online)(struct cpufreq_policy *policy);
+	int		(*offline)(struct cpufreq_policy *policy);
 	int		(*exit)(struct cpufreq_policy *policy);
 	void		(*stop_cpu)(struct cpufreq_policy *policy);
 	int		(*suspend)(struct cpufreq_policy *policy);
-- 
2.20.1.321.g9e740568ce00


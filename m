Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F45C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5ABA21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7zr7M1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfBLLGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:06:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36178 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfBLLGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:06:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so1140266pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eInlvY5FKDw6XUYNat+PshXZTd4NDkDRgZK+3JHQYNc=;
        b=X7zr7M1mBBhPgZRnWEr8FDlVXEw2I+jreFQ6+3EzulF10/Y4ubePPASDVHZXEZmQGI
         VvWNDiJMM3PXmULr9CmCYhGg5oRcRVuVIgpdqLag0wnm4jguulaJIoM3/dXvVWeISycZ
         lC0uwqV7TkVRvVEzbitBhyqa6QSdCwmyr1zJitLc4joWCdlqJGBuWfFSE9R4W7GXPqAq
         pXZ8aKLOXpMpXKGnLCBI3b5W6fPfKQ8dhMms9Vw/xX9vr7oU+6JFh9vYpmXF1HY0m1go
         Kxm8GiFr9tAW8VewcZ1SzTWubsRGC9oGG4bmCRqSjCsv+zgKOfes9H2fiRDHldWSiDve
         iAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eInlvY5FKDw6XUYNat+PshXZTd4NDkDRgZK+3JHQYNc=;
        b=Fto3aQZbTOTLOYQ0/cg4/n1VDt80QMonxHDKDCCcf80QIao9ia9lSiS0jSQjV2QhrB
         Mn3QMH/xcbyfBZmuqX0PHec7/lEaVCgbqgaqNXJ5IywPOipZkkP3cIEkKDphad7F5fbp
         xLJ8OPdQ71kg6+UTP7FB1I33xMojSOaPrHFLAJzvU9I8LN27qyeMav6KKX+PgRTHQ/yM
         L8BUyd7yZ45xrxKLmu3zHcKhmsQhTI/k4L67oRNg5Bj5F36730F7k5RAi0VtWZV1BumC
         zpUaTTU8dy5UnjdBH/GWe9uI6cOGt3jQcJTAdVxUxuqoyYnaD2dCxwtRrMoDHTU6gDj8
         SK7A==
X-Gm-Message-State: AHQUAubaXaNLCt4BdefFDhL4Lw8Hdnt/ArkMavv+5dlPE/jbGWY9HLIq
        lqjIiSWvY8U6j2ocB1y/telaWHIHL9o=
X-Google-Smtp-Source: AHgI3IZslvoLWef9ODVpER9JiEQpbdkzX084iTzcLeKO3doYlQYVbyMd2KZszN3fubqxZSQxRYmPdQ==
X-Received: by 2002:a63:481f:: with SMTP id v31mr3127660pga.29.1549969571419;
        Tue, 12 Feb 2019 03:06:11 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id c7sm24160206pfa.24.2019.02.12.03.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:06:10 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] cpufreq: Allow light-weight tear down and bring up of CPUs
Date:   Tue, 12 Feb 2019 16:36:04 +0530
Message-Id: <7fcdface56ccc5df0e50738253eb3e696b2f8980.1549969209.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org>
References: <f48f04ddfe3bd072f40154cdd971079199db0e4b.1549955027.git.viresh.kumar@linaro.org>
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
V3->V4:
- Use != instead of ^

 drivers/cpufreq/cpufreq.c | 58 +++++++++++++++++++++++++--------------
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 96a69c67a545..55e9795801a4 100644
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
@@ -2488,7 +2505,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 		    driver_data->target) ||
 	     (driver_data->setpolicy && (driver_data->target_index ||
 		    driver_data->target)) ||
-	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate))
+	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
+	     (!driver_data->online != !driver_data->offline))
 		return -EINVAL;
 
 	pr_debug("trying to register driver %s\n", driver_data->name);
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


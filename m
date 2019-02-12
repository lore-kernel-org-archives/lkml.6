Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8EEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710CB214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inhuhWGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfBLKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:47:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33964 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbfBLKrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:47:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id i130so818393pgd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrR1J+07tkcuXFrAjAe757NRChCh4Hlp4/iCb5VavpI=;
        b=inhuhWGCrSZ3DFpnaAPbHFS36LMgii2Ibg1yOjFQxWUjArRG8iyuGmRDXl0f2Dv4Ez
         zvUDmWr5FRGxqjPtew3I2FWtuRL4LaaRw9NcsgJivYkWP4acSQgln0Thc3DIw+x/r+kz
         Py5PEZ1sER9Hu67qukoGrvNFQsnXdKJwWGuQu1cUMLk+/D6A3RgS2WiNmrzboCT0/RNP
         sgiR/daEWA4Y28yoKF4fXGn98anYdRgrnfKgPvM1jH+iQeEzQR9bpQxFbK0Mbxd/la6F
         2XnNIjXcKdNm1nI326ZKw9Sq/LxLL737FbO8Xynxu96KXvEOfmx7nVvpeVo0tZYIPGmC
         JuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrR1J+07tkcuXFrAjAe757NRChCh4Hlp4/iCb5VavpI=;
        b=P22Myl0NAemQfpS4R7MY3N4RyTMfHJXRVJLwSQVJm0j0TFzYmlWyLkG7n+B0i2T7Wn
         m0N+LuN6xOOSP+RcpTO1sc+ibSMfmq1XfJynGfKOrEu5Dx/FjONjL5ypPimiom7rZen6
         6EsofNy9CV5hvz5eVYnyWsAcGf1jtox+oi89f1E+tsfe0x2XR+T6sZGreaJWrCSZR6iM
         uNPKCKLJzCYa+aPFt4gzGnxovy3jezGCIuPSjcX8cXgX8QfS4u/TG9xwKbdWFbe3t4CY
         6Ag76RN0D0xJL8gW3oR1PCGgINHcsuNGSnV52bhB8Gul1FxoU4umwQMeNQphtwP2HoPe
         E3uw==
X-Gm-Message-State: AHQUAuZhAD3+hWDScJoP0m3PlM5apXuiC+e6WHhbQ6FYd2q9wqAA5+DQ
        8u0n2YDF9uIbVhOum1nRddgeQA==
X-Google-Smtp-Source: AHgI3IYuakpw9oS8uvZjDk5BdCfSFkJW2aSkRiqHQI/8BRsMT36LJvO4aSxvl/s0AfgXskfhQObvjQ==
X-Received: by 2002:a63:d444:: with SMTP id i4mr3023735pgj.237.1549968466614;
        Tue, 12 Feb 2019 02:47:46 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id u66sm28915946pfi.115.2019.02.12.02.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:47:45 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] cpufreq: Allow light-weight tear down and bring up of CPUs
Date:   Tue, 12 Feb 2019 16:17:33 +0530
Message-Id: <15c641e4139d0b9a7d7540eefced1c012b608e91.1549968315.git.viresh.kumar@linaro.org>
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
V2->V3:
- Additional check in cpufreq_register_driver().

 drivers/cpufreq/cpufreq.c | 58 +++++++++++++++++++++++++--------------
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 96a69c67a545..dd7626c5eb85 100644
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
+	     (!driver_data->online ^ !driver_data->offline))
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


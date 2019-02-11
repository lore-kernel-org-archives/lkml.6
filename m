Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED2C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C16A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqhiGIbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBKIlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:41:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46300 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfBKIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:41:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so1017535pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f2xUPJ0VeEmUdzCbdA+JjT7JZvX3sMGSKBadMB0TcQ4=;
        b=OqhiGIbXtzXUVI1C8avuY43tRwF3EkVCzY5e8qsW3p7NCUzasvuP1LktlvReVFTRpx
         aeulSPvVltElImwNXVUGO8kmYv4UnEXPD3x2Dt8APpdYQOWIUnjyAno2yl5Hue7o1+8C
         ygWbSPu+oVq015orwnRXaeuSdiMitSarbmy+Awgd4qzMnzA6cy7HYbkNNgeRqk2LpItS
         0Tq1ZOg8XxGP3F442j/fiuua/Ygsq/3Q1tpj+qbqKPnxMT902PWqJZR5imWcrdsnOJEn
         ucVNHl3qajdtkuzSx2jBJ/zqrjvHYRPN0SosL5SWB24Vm6/GdB6QvxIRcBOUZSpxMEWX
         O+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f2xUPJ0VeEmUdzCbdA+JjT7JZvX3sMGSKBadMB0TcQ4=;
        b=DMF1XcgeZnPZzTB89lfXx4+QYqfp8fjkCBA61OY8hx6ZBV6J7bO7TOnfReBwn2pAUt
         zPxBsSIjUCYUDRdinr66IbA0qx3Ty5Wr0G9y2/CsQpH7WxflzuU6beux88VvARPO6n4w
         YgrIxLfZ9j6Z0vzAqRBXxHYNA/jjbnxupohsx+SjEhLkWseuwrNcAuleM1UM7tcYBHcU
         Uk1vMFgpiE9VZyVWIpA2113ZN2/M9YAbjQJl/KJeMULSzJbg596G1fJQkZQoaoBTccVv
         k09oDSC/9634hUFhZw1Sh0hQlCq5rOSABXgrt1EBZLaPHCIENutfIGgWayHAPtXADtTO
         lERA==
X-Gm-Message-State: AHQUAuZMqFr2sW1JeIeWtEZTIfjVURKrOqino5pFbsSG0LBDV/oP2ejl
        jayZdhDedbc5yVhTDpkqaS7fpQ==
X-Google-Smtp-Source: AHgI3IaU1MNPbuSVZNCOYzHA5l8dfEqhq0rbN2Tgc2WmCaFSTeR9DAP7jRa77Jhd/J66FF2yewZQEg==
X-Received: by 2002:a65:5c4b:: with SMTP id v11mr17775297pgr.333.1549874509763;
        Mon, 11 Feb 2019 00:41:49 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id n10sm14833460pfj.14.2019.02.11.00.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:41:49 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: Allow light-weight tear down on CPU offline operation
Date:   Mon, 11 Feb 2019 14:11:35 +0530
Message-Id: <03ac36a174f6c28be0b3af9d2db8631d56695f1d.1549874368.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <cover.1549874368.git.viresh.kumar@linaro.org>
References: <cover.1549874368.git.viresh.kumar@linaro.org>
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
light weight tear-down during CPU offline operation.

A new callback is introduced, light_weight_exit(), which gets called
when all the CPUs of a policy are removed/offlined and the existing
exit() callback gets called when the policy gets freed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 16 +++++++++++-----
 include/linux/cpufreq.h   |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 96a69c67a545..215a8bfc78bb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1421,11 +1421,12 @@ static int cpufreq_offline(unsigned int cpu)
 		cpufreq_exit_governor(policy);
 
 	/*
-	 * Perform the ->exit() even during light-weight tear-down,
-	 * since this is a core component, and is essential for the
-	 * subsequent light-weight ->init() to succeed.
+	 * Perform the ->light_weight_exit() during light-weight tear-down, as
+	 * that allows fast recovery when the CPU comes back.
 	 */
-	if (cpufreq_driver->exit) {
+	if (cpufreq_driver->light_weight_exit) {
+		cpufreq_driver->light_weight_exit(policy);
+	} else if (cpufreq_driver->exit) {
 		cpufreq_driver->exit(policy);
 		policy->freq_table = NULL;
 	}
@@ -1454,8 +1455,13 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	cpumask_clear_cpu(cpu, policy->real_cpus);
 	remove_cpu_dev_symlink(policy, dev);
 
-	if (cpumask_empty(policy->real_cpus))
+	if (cpumask_empty(policy->real_cpus)) {
+		/* We did light-weight exit earlier, do full tear down now */
+		if (cpufreq_driver->light_weight_exit)
+			cpufreq_driver->exit(policy);
+
 		cpufreq_policy_free(policy);
+	}
 }
 
 /**
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9db074ecbbd7..36ce31516041 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -325,6 +325,7 @@ struct cpufreq_driver {
 	/* optional */
 	int		(*bios_limit)(int cpu, unsigned int *limit);
 
+	int		(*light_weight_exit)(struct cpufreq_policy *policy);
 	int		(*exit)(struct cpufreq_policy *policy);
 	void		(*stop_cpu)(struct cpufreq_policy *policy);
 	int		(*suspend)(struct cpufreq_policy *policy);
-- 
2.20.1.321.g9e740568ce00


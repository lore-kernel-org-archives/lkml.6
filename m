Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeEQSCb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:02:31 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36866 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeEQSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:20 -0400
X-Google-Smtp-Source: AB8JxZpJmNexhdEQvYTzhcRv3bBNEWlczrltVlUoocvlje4dDEJWq1quEQZoh/WhRN68wSMIg6NBMg==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 06/11] cpufreq: tegra20: Remove unneeded check in tegra_cpu_init
Date: Thu, 17 May 2018 21:00:51 +0300
Message-Id: <20180517180056.13336-7-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove checking of the CPU number for consistency as it won't ever fail
unless there is a severe bug in the cpufreq core.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 61f00d1cba26..147ae3e14f18 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -32,8 +32,6 @@ static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = CPUFREQ_TABLE_END },
 };
 
-#define NUM_CPUS	2
-
 static struct clk *cpu_clk;
 static struct clk *pll_x_clk;
 static struct clk *pll_p_clk;
@@ -119,9 +117,6 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (policy->cpu >= NUM_CPUS)
-		return -EINVAL;
-
 	clk_prepare_enable(cpu_clk);
 
 	/* FIXME: what's the actual transition time? */
-- 
2.17.0

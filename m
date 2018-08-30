Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F59C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D553820835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skciQvBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D553820835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeH3Xun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:50:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45209 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeH3Xun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:50:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so8142372lff.12;
        Thu, 30 Aug 2018 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6GFkJgIko56TQksR/BsAqKZFuBijnMvkpCNMpYoaJ+k=;
        b=skciQvBWKfpoRdEtj8FAsxeuAjrn3O0degJ3eJ2D9hPwLWc09YfemF3oZ738iJD7qB
         hcxRiE+44OYljzwvVtIXTDUCZaU4EfM87LhFGJKexf85FeAimY66Hl5c1T5vhYtByOZ4
         lBZScWB/S7ga4eccuyloAWEdb1QtA8SFfKBsrh+K2y0MpDoxcj6yoZhVhEmDp9+4Zgbn
         fN1ekJRobTT3jrvzvmKXP2SBZKrmPRBpgy6Locpp4gy2r9XtXgaAV1CR3FJHBPz/8PZ+
         h0FYT9s8ZAtqvpH6ltENhGxQDYaCfEqerrCmwXtiqv1Ti6B9eY/HuU/nM4SxOED/X9hC
         Zoog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6GFkJgIko56TQksR/BsAqKZFuBijnMvkpCNMpYoaJ+k=;
        b=ShoE+AAronzYX/zpBipFTn7tRRYeOBZePUTBAPYOoUAyUypmr1bvyaJLsBoFjgDzeC
         C3Zb5tbWUEPDcjfUY7WcCq96nOuk/WBET+3aszCXfeksSkEFzns2C5k8UBLiJt/4tJ50
         iigUdK76FLFbBllyb3IDIyfkmZaK+6SsIzm0RP9O2th+OJttIMQfGOeb/UDVqTCrJQ2A
         An7tQwYwlPdQ/7psvRHQpSiX/3gwTFi5VjA45vc3jqxVRhoxathTMURAFVIyY+UvHU+k
         7ODhuQrU+7Vdk4MQ5gFIGfnQwh3GxjyFZXGwgrU4NTLOZjgNPmNEPllw7tM7CrCWz/Fg
         /8Tw==
X-Gm-Message-State: APzg51AaL7Bz6UqLVQvtqT8KMDE9p2e3O2ZW7ONoQnAYfjFTbkeAcJUg
        6eWDzsaKIpzo8xruYOzkorA=
X-Google-Smtp-Source: ANB0Vda7P4yeKRWHrYTzPTqojpUCkPzJEe9sWiMXuKQAHlxou/a0QyMeLtDat17RrJO4BjqmmDXc+w==
X-Received: by 2002:a19:2c8e:: with SMTP id s136-v6mr2444878lfs.78.1535658413523;
        Thu, 30 Aug 2018 12:46:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id x3-v6sm1381191ljb.25.2018.08.30.12.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 12:46:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] cpufreq: tegra20: Support OPP, thermal cooling and Tegra30
Date:   Thu, 30 Aug 2018 22:43:53 +0300
Message-Id: <20180830194356.14059-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830194356.14059-1-digetx@gmail.com>
References: <20180830194356.14059-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for thermal throttling and Operating Performance Points.
Driver now relies on OPP's supplied via device tree and therefore will
work only on devices that use the updated device tree. The generalization
of the driver allows to transparently support Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/Kconfig.arm          |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 drivers/cpufreq/tegra20-cpufreq.c    | 334 ++++++++++++++++++++-------
 3 files changed, 257 insertions(+), 81 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0cd8eb76ad59..78795d108f5e 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -262,7 +262,9 @@ config ARM_TANGO_CPUFREQ
 
 config ARM_TEGRA20_CPUFREQ
 	tristate "Tegra20 CPUFreq support"
+	depends on !CPU_THERMAL || THERMAL
 	depends on ARCH_TEGRA
+	select PM_OPP
 	default y
 	help
 	  This adds the CPUFreq driver support for Tegra20 SOCs.
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index fe14c57de6ca..3c4709159995 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -114,6 +114,8 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 
+	{ .compatible = "nvidia,tegra20", },
+	{ .compatible = "nvidia,tegra30", },
 	{ .compatible = "nvidia,tegra124", },
 
 	{ .compatible = "qcom,apq8096", },
diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 05f57dcd5215..fd6c40a64175 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -17,163 +17,347 @@
  */
 
 #include <linux/clk.h>
+#include <linux/cpu.h>
+#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/types.h>
 
-static struct cpufreq_frequency_table freq_table[] = {
-	{ .frequency = 216000 },
-	{ .frequency = 312000 },
-	{ .frequency = 456000 },
-	{ .frequency = 608000 },
-	{ .frequency = 760000 },
-	{ .frequency = 816000 },
-	{ .frequency = 912000 },
-	{ .frequency = 1000000 },
-	{ .frequency = CPUFREQ_TABLE_END },
-};
+#define PLLX_PREPARE		BIT(0)
+#define PLLX_PREPARED		BIT(1)
 
 struct tegra20_cpufreq {
 	struct device *dev;
+	struct device *cpu_dev;
+	struct cpumask cpu_mask;
 	struct cpufreq_driver driver;
+	struct thermal_cooling_device *cdev;
+	struct cpufreq_frequency_table *freq_table;
 	struct clk *cpu_clk;
 	struct clk *pll_x_clk;
-	struct clk *pll_p_clk;
-	bool pll_x_prepared;
+	struct clk *backup_clk;
+	unsigned long backup_rate;
+	unsigned int state;
 };
 
 static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 					   unsigned int index)
 {
 	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
+	struct clk *cpu_parent = clk_get_parent(cpufreq->cpu_clk);
+	unsigned long new_rate = cpufreq->freq_table[index].frequency * 1000;
+	int err;
+
+	/*
+	 * Make sure that backup clock rate stays consistent during
+	 * transition by entering into critical section of the backup clock.
+	 */
+	err = clk_rate_exclusive_get(cpufreq->backup_clk);
+	/* this shouldn't fail */
+	WARN_ON_ONCE(err);
 
 	/*
-	 * Don't switch to intermediate freq if:
-	 * - we are already at it, i.e. policy->cur == ifreq
-	 * - index corresponds to ifreq
+	 * When target rate is equal to backup rate, we don't need to
+	 * switch to backup clock and so the intermediate routine isn't
+	 * called.  Also, we wouldn't be using PLLX anymore and must not
+	 * take extra reference to it, as it can be disabled to save some
+	 * power.
 	 */
-	if (freq_table[index].frequency == ifreq || policy->cur == ifreq)
+	cpufreq->backup_rate = clk_get_rate(cpufreq->backup_clk);
+
+	if (new_rate == cpufreq->backup_rate)
+		cpufreq->state &= ~PLLX_PREPARE;
+	else
+		cpufreq->state |= PLLX_PREPARE;
+
+	/* don't switch to intermediate freq if we are already at it */
+	if (clk_is_match(cpu_parent, cpufreq->backup_clk))
 		return 0;
 
-	return ifreq;
+	return cpufreq->backup_rate / 1000;
 }
 
 static int tegra_target_intermediate(struct cpufreq_policy *policy,
 				     unsigned int index)
 {
 	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	int ret;
+	unsigned int state = cpufreq->state;
+	int err;
 
 	/*
-	 * Take an extra reference to the main pll so it doesn't turn
-	 * off when we move the cpu off of it as enabling it again while we
-	 * switch to it from tegra_target() would take additional time.
-	 *
-	 * When target-freq is equal to intermediate freq we don't need to
-	 * switch to an intermediate freq and so this routine isn't called.
-	 * Also, we wouldn't be using pll_x anymore and must not take extra
-	 * reference to it, as it can be disabled now to save some power.
+	 * Take an extra reference to the main PLLX so it doesn't turn off
+	 * when we move the CPU clock to backup clock as enabling it again
+	 * while we switch to it from tegra_target() would take additional
+	 * time.
 	 */
-	clk_prepare_enable(cpufreq->pll_x_clk);
+	if ((state & (PLLX_PREPARED | PLLX_PREPARE)) == PLLX_PREPARE) {
+		err = clk_prepare_enable(cpufreq->pll_x_clk);
+		if (err)
+			goto err_exclusive_put;
 
-	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
-	if (ret)
+		cpufreq->state |= PLLX_PREPARED;
+	}
+
+	err = clk_set_parent(cpufreq->cpu_clk, cpufreq->backup_clk);
+	if (err)
+		goto err_exclusive_put;
+
+	return 0;
+
+err_exclusive_put:
+	clk_rate_exclusive_put(cpufreq->backup_clk);
+
+	if (cpufreq->state & PLLX_PREPARED) {
 		clk_disable_unprepare(cpufreq->pll_x_clk);
-	else
-		cpufreq->pll_x_prepared = true;
+		cpufreq->state &= ~PLLX_PREPARED;
+	}
 
-	return ret;
+	/* this shouldn't fail */
+	return WARN_ON_ONCE(err);
 }
 
 static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	unsigned long rate = freq_table[index].frequency;
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
+	unsigned long new_rate = cpufreq->freq_table[index].frequency * 1000;
+	unsigned int state = cpufreq->state;
 	int ret;
 
 	/*
-	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
-	 * as it isn't used anymore.
+	 * Drop refcount to PLLX only if we switched to backup clock earlier
+	 * during transitioning to a target frequency and we are going to
+	 * stay with the backup clock.
 	 */
-	if (rate == ifreq)
-		return clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
+	if ((state & (PLLX_PREPARED | PLLX_PREPARE)) == PLLX_PREPARED) {
+		clk_disable_unprepare(cpufreq->pll_x_clk);
+		state &= ~PLLX_PREPARED;
+	}
 
-	ret = clk_set_rate(cpufreq->pll_x_clk, rate * 1000);
-	/* Restore to earlier frequency on error, i.e. pll_x */
+	/*
+	 * Switch to new OPP, note that this will change PLLX rate and
+	 * not the CCLK.
+	 */
+	ret = dev_pm_opp_set_rate(cpufreq->cpu_dev, new_rate);
 	if (ret)
-		dev_err(cpufreq->dev, "Failed to change pll_x to %lu\n", rate);
+		goto exclusive_put;
+
+	/*
+	 * Target rate == backup rate leaves PLLX turned off, CPU is kept
+	 * running off the backup clock. This should save us some power by
+	 * keeping one more PLL disabled because the backup clock assumed
+	 * to be always-on. In this case PLLX_PREPARE flag will be omitted.
+	 */
+	if (state & PLLX_PREPARE) {
+		/*
+		 * CCF doesn't return error if clock-enabling fails on
+		 * re-parent, hence enable it now.
+		 */
+		ret = clk_prepare_enable(cpufreq->pll_x_clk);
+		if (ret)
+			goto exclusive_put;
+
+		ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_x_clk);
 
-	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_x_clk);
-	/* This shouldn't fail while changing or restoring */
-	WARN_ON(ret);
+		clk_disable_unprepare(cpufreq->pll_x_clk);
+	}
 
 	/*
-	 * Drop count to pll_x clock only if we switched to intermediate freq
-	 * earlier while transitioning to a target frequency.
+	 * Drop refcount to PLLX only if we switched to backup clock earlier
+	 * during transitioning to a target frequency.
 	 */
-	if (cpufreq->pll_x_prepared) {
+	if (state & PLLX_PREPARED) {
 		clk_disable_unprepare(cpufreq->pll_x_clk);
-		cpufreq->pll_x_prepared = false;
+		state &= ~PLLX_PREPARED;
 	}
 
+exclusive_put:
+	clk_rate_exclusive_put(cpufreq->backup_clk);
+
+	cpufreq->state = state;
+
+	/* this shouldn't fail */
+	return WARN_ON_ONCE(ret);
+}
+
+static int tegra_cpu_setup_opp(struct tegra20_cpufreq *cpufreq)
+{
+	struct device *dev = cpufreq->cpu_dev;
+	int err;
+
+	err = dev_pm_opp_of_cpumask_add_table(cpu_possible_mask);
+	if (err)
+		return err;
+
+	err = dev_pm_opp_init_cpufreq_table(dev, &cpufreq->freq_table);
+	if (err)
+		goto err_remove_table;
+
+	return 0;
+
+err_remove_table:
+	dev_pm_opp_of_cpumask_remove_table(cpu_possible_mask);
+
+	return err;
+}
+
+static void tegra_cpu_release_opp(struct tegra20_cpufreq *cpufreq)
+{
+	dev_pm_opp_free_cpufreq_table(cpufreq->cpu_dev, &cpufreq->freq_table);
+	dev_pm_opp_of_cpumask_remove_table(cpu_possible_mask);
+}
+
+static int tegra_cpu_init_clk(struct tegra20_cpufreq *cpufreq)
+{
+	unsigned long backup_rate;
+	int ret;
+
+	ret = clk_rate_exclusive_get(cpufreq->backup_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->backup_clk);
+	if (ret)
+		goto exclusive_put;
+
+	backup_rate = clk_get_rate(cpufreq->backup_clk);
+
+	/*
+	 * The CCLK has its own clock divider, that divider isn't getting
+	 * disabled on clock reparent. Hence set CCLK parent to backup clock
+	 * in order to disable the divider if it happens to be enabled,
+	 * otherwise clk_set_rate() has no effect.
+	 */
+	ret = clk_set_rate(cpufreq->cpu_clk, backup_rate);
+
+exclusive_put:
+	clk_rate_exclusive_put(cpufreq->backup_clk);
+
 	return ret;
 }
 
 static int tegra_cpu_init(struct cpufreq_policy *policy)
 {
 	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	int ret;
+	struct device *cpu = cpufreq->cpu_dev;
+	int err;
 
-	clk_prepare_enable(cpufreq->cpu_clk);
+	err = tegra_cpu_setup_opp(cpufreq);
+	if (err) {
+		dev_err(cpufreq->dev, "Failed to setup OPP: %d\n", err);
+		return err;
+	}
 
-	/* FIXME: what's the actual transition time? */
-	ret = cpufreq_generic_init(policy, freq_table, 300 * 1000);
-	if (ret) {
-		clk_disable_unprepare(cpufreq->cpu_clk);
-		return ret;
+	err = clk_prepare_enable(cpufreq->cpu_clk);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to enable CPU clock: %d\n", err);
+		goto er_release_opp;
 	}
 
+	err = clk_prepare_enable(cpufreq->backup_clk);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to enable backup clock: %d\n", err);
+		goto err_cpu_disable;
+	}
+
+	err = clk_rate_exclusive_get(cpufreq->cpu_clk);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to make CPU clock exclusive: %d\n", err);
+		goto err_backup_disable;
+	}
+
+	err = tegra_cpu_init_clk(cpufreq);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to initialize CPU clock: %d\n", err);
+		goto err_exclusive_put;
+	}
+
+	err = cpufreq_generic_init(policy, cpufreq->freq_table,
+				   dev_pm_opp_get_max_transition_latency(cpu));
+	if (err)
+		goto err_exclusive_put;
+
 	policy->clk = cpufreq->cpu_clk;
-	policy->suspend_freq = freq_table[0].frequency;
+	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(cpu) / 1000;
+
 	return 0;
+
+err_exclusive_put:
+	clk_rate_exclusive_put(cpufreq->cpu_clk);
+err_backup_disable:
+	clk_disable_unprepare(cpufreq->backup_clk);
+err_cpu_disable:
+	clk_disable_unprepare(cpufreq->cpu_clk);
+er_release_opp:
+	tegra_cpu_release_opp(cpufreq);
+
+	return err;
 }
 
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
 
+	cpufreq_cooling_unregister(cpufreq->cdev);
+	clk_rate_exclusive_put(cpufreq->cpu_clk);
+	clk_disable_unprepare(cpufreq->backup_clk);
 	clk_disable_unprepare(cpufreq->cpu_clk);
+	tegra_cpu_release_opp(cpufreq);
+
 	return 0;
 }
 
+static void tegra_cpu_ready(struct cpufreq_policy *policy)
+{
+	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
+
+	cpufreq->cdev = of_cpufreq_cooling_register(policy);
+}
+
 static int tegra20_cpufreq_probe(struct platform_device *pdev)
 {
 	struct tegra20_cpufreq *cpufreq;
+	struct device_node *np;
 	int err;
 
 	cpufreq = devm_kzalloc(&pdev->dev, sizeof(*cpufreq), GFP_KERNEL);
 	if (!cpufreq)
 		return -ENOMEM;
 
-	cpufreq->cpu_clk = clk_get_sys(NULL, "cclk");
-	if (IS_ERR(cpufreq->cpu_clk))
-		return PTR_ERR(cpufreq->cpu_clk);
+	cpufreq->cpu_dev = get_cpu_device(0);
+	if (!cpufreq->cpu_dev)
+		return -ENODEV;
+
+	np = cpufreq->cpu_dev->of_node;
 
-	cpufreq->pll_x_clk = clk_get_sys(NULL, "pll_x");
+	cpufreq->cpu_clk = devm_get_clk_from_child(&pdev->dev, np, "cpu");
+	if (IS_ERR(cpufreq->cpu_clk)) {
+		err = PTR_ERR(cpufreq->cpu_clk);
+		dev_err(&pdev->dev, "Failed to get cpu clock: %d\n", err);
+		dev_err(&pdev->dev, "Please update your device tree\n");
+		return err;
+	}
+
+	cpufreq->pll_x_clk = devm_get_clk_from_child(&pdev->dev, np, "pll_x");
 	if (IS_ERR(cpufreq->pll_x_clk)) {
 		err = PTR_ERR(cpufreq->pll_x_clk);
-		goto put_cpu;
+		dev_err(&pdev->dev, "Failed to get pll_x clock: %d\n", err);
+		return err;
 	}
 
-	cpufreq->pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(cpufreq->pll_p_clk)) {
-		err = PTR_ERR(cpufreq->pll_p_clk);
-		goto put_pll_x;
+	cpufreq->backup_clk = devm_get_clk_from_child(&pdev->dev, np, "backup");
+	if (IS_ERR(cpufreq->backup_clk)) {
+		err = PTR_ERR(cpufreq->backup_clk);
+		dev_err(&pdev->dev, "Failed to get backup clock: %d\n", err);
+		return err;
 	}
 
 	cpufreq->dev = &pdev->dev;
@@ -181,6 +365,7 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 	cpufreq->driver.attr = cpufreq_generic_attr;
 	cpufreq->driver.init = tegra_cpu_init;
 	cpufreq->driver.exit = tegra_cpu_exit;
+	cpufreq->driver.ready = tegra_cpu_ready;
 	cpufreq->driver.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK;
 	cpufreq->driver.verify = cpufreq_generic_frequency_table_verify;
 	cpufreq->driver.suspend = cpufreq_generic_suspend;
@@ -192,20 +377,11 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 
 	err = cpufreq_register_driver(&cpufreq->driver);
 	if (err)
-		goto put_pll_p;
+		return err;
 
 	platform_set_drvdata(pdev, cpufreq);
 
 	return 0;
-
-put_pll_p:
-	clk_put(cpufreq->pll_p_clk);
-put_pll_x:
-	clk_put(cpufreq->pll_x_clk);
-put_cpu:
-	clk_put(cpufreq->cpu_clk);
-
-	return err;
 }
 
 static int tegra20_cpufreq_remove(struct platform_device *pdev)
@@ -214,10 +390,6 @@ static int tegra20_cpufreq_remove(struct platform_device *pdev)
 
 	cpufreq_unregister_driver(&cpufreq->driver);
 
-	clk_put(cpufreq->pll_p_clk);
-	clk_put(cpufreq->pll_x_clk);
-	clk_put(cpufreq->cpu_clk);
-
 	return 0;
 }
 
-- 
2.18.0


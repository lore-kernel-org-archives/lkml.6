Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A094EECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447532082C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drGtZ/LK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447532082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJVFNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38243 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbeJVFNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id k11-v6so3122751lja.5;
        Sun, 21 Oct 2018 13:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/fgFmXtBak1Bd1yGq4kzY0apIYIQmbImrdzBLqCEb0=;
        b=drGtZ/LK7XNX3S4gel0xUBHqBAjDpTMvwLPMHQqVCs0doxfSQR2NUKpNphDHaBKmhl
         XXmM0nLykT7/452k5pYh3OIvL3SA4CQS2uZAbeTwfO6PQbk+K/mkzghDnMgx1Ed2oLXI
         z53hq7HHe7xmVy+eH9YSDPmyZXEk/j4zOwNfJ0UvPiADUI4fFnkVUvrkh78Xr6wLWpS+
         xLW0iDzuNmAvHXZR4Xzw4vwXnhloXMgZuilq88llzWmQD8jJM0IPpj/p5UUbmTUXruhQ
         u5aLj4tQzC1MvSnd2uVI3VfsJ1bEnxzCM6ZhrtWE1c6U6musSXlgT5uC97O9aPQ1LPoo
         7f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/fgFmXtBak1Bd1yGq4kzY0apIYIQmbImrdzBLqCEb0=;
        b=jWYpiwAfF7rAM023P25BbaYJY6ttBSVsObrP7NBF6LWP3zBf6gCxmjdgvwujnnRkFi
         SWJ3aYDQ5TUQzb9LuOtk1v1xQNGseaT5JjcXpN2nYvlcCKvSTLR/ICOARpJ0DXXfNPvK
         pW8qxoP32Ak2shJH0T61TvyzKWvtaCcAwm2m77sCq8fiF/A1J5omWYIaq2KRrGGvGFhH
         4JrWleDYuYKCXvVOR2Kq9DP5wi1WrQjVqAlr1SLpaZ1G2EorwsDw6Twq8Y/ejlY1Gr8Z
         dP0v8Ks61Lk/aRs4uIz60gvDju6k4HYy/TVZmWIZVZ5dRKQwmb9FV4JtgzOwDHrZ26EO
         OVAA==
X-Gm-Message-State: ABuFfogc0k7ZaxaHpykZn1fbbEEWF0lcrowfvk5d+JKeybKpDcfRgXxe
        Ftfl5TQju8oo6U+gbiucCB2PbrtD
X-Google-Smtp-Source: ACcGV61cQL3QIW5dYxsewRDfHnU+WHe3fanBKBNbuYgKxaYcCCSl4whuzXobW0sO0UUoTEeHSZmBRA==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr30206347ljc.14.1540155488279;
        Sun, 21 Oct 2018 13:58:08 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 04/17] cpufreq: tegra20: Support OPP, thermal cooling, DVFS and Tegra30
Date:   Sun, 21 Oct 2018 23:54:48 +0300
Message-Id: <20181021205501.23943-5-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for thermal throttling, Operating Performance Points and DVFS.
Driver now relies on OPP's supplied via device tree and therefore will
work only on devices that use the updated device tree. The generalization
of the driver allows to transparently support Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/Kconfig.arm          |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 drivers/cpufreq/tegra20-cpufreq.c    | 832 +++++++++++++++++++++++----
 3 files changed, 734 insertions(+), 102 deletions(-)

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
index b1c5468dca16..ecc4d3d14850 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -118,6 +118,8 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
 
+	{ .compatible = "nvidia,tegra20", },
+	{ .compatible = "nvidia,tegra30", },
 	{ .compatible = "nvidia,tegra124", },
 
 	{ .compatible = "qcom,apq8096", },
diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 05f57dcd5215..a7d1c2899e3c 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -17,220 +17,848 @@
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
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
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
+#include <soc/tegra/fuse.h>
+
+#define PLLX_PREPARE		BIT(0)
+#define PLLX_PREPARED		BIT(1)
 
-struct tegra20_cpufreq {
+struct tegra_cpufreq {
 	struct device *dev;
+	struct device *cpu_dev;
+	struct regulator *reg_cpu;
+	struct regulator *reg_core;
+	struct regulator *reg_rtc;
+	struct opp_table *opp_table;
 	struct cpufreq_driver driver;
+	struct thermal_cooling_device *cdev;
+	struct cpufreq_frequency_table *freq_table;
 	struct clk *cpu_clk;
 	struct clk *pll_x_clk;
-	struct clk *pll_p_clk;
-	bool pll_x_prepared;
+	struct clk *intermediate_clk;
+	unsigned long intermediate_rate;
+	unsigned int state;
+	unsigned int chip;
+	int cpu_speedo_id;
+
+	/* deferred voltage change */
+	struct delayed_work work;
+	struct dev_pm_opp_supply supply_cpu;
+	unsigned long actual_cpu_uV;
 };
 
+static unsigned int voltage_drop_interval_ms = 500;
+
 static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 					   unsigned int index)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
+	struct clk *cpu_parent = clk_get_parent(cpufreq->cpu_clk);
+	unsigned long new_rate = cpufreq->freq_table[index].frequency * 1000;
+	int err;
 
 	/*
-	 * Don't switch to intermediate freq if:
-	 * - we are already at it, i.e. policy->cur == ifreq
-	 * - index corresponds to ifreq
+	 * Make sure that intermediate clock rate stays consistent during
+	 * transition by entering into critical section of the intermediate
+	 * clock.
 	 */
-	if (freq_table[index].frequency == ifreq || policy->cur == ifreq)
+	err = clk_rate_exclusive_get(cpufreq->intermediate_clk);
+	/* this shouldn't fail */
+	WARN_ON_ONCE(err);
+
+	/*
+	 * When target rate is equal to intermediate rate, we don't need to
+	 * switch to intermediate clock and so the intermediate routine isn't
+	 * called. Also, we wouldn't be using PLLX anymore and must not
+	 * take extra reference to it, as it can be disabled to save some
+	 * power.
+	 */
+	cpufreq->intermediate_rate = clk_get_rate(cpufreq->intermediate_clk);
+
+	if (new_rate == cpufreq->intermediate_rate)
+		cpufreq->state &= ~PLLX_PREPARE;
+	else
+		cpufreq->state |= PLLX_PREPARE;
+
+	/* don't switch to intermediate freq if we are already at it */
+	if (clk_is_match(cpu_parent, cpufreq->intermediate_clk))
 		return 0;
 
-	return ifreq;
+	return cpufreq->intermediate_rate / 1000;
 }
 
 static int tegra_target_intermediate(struct cpufreq_policy *policy,
 				     unsigned int index)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	int ret;
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
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
+	 * when we move the CPU clock to intermediate clock as enabling it
+	 * again  while we switch to it from tegra_target() would take
+	 * additional time.
 	 */
-	clk_prepare_enable(cpufreq->pll_x_clk);
+	if ((state & (PLLX_PREPARED | PLLX_PREPARE)) == PLLX_PREPARE) {
+		err = clk_prepare_enable(cpufreq->pll_x_clk);
+		if (WARN_ON_ONCE(err))
+			goto err_exclusive_put;
 
-	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
-	if (ret)
+		cpufreq->state |= PLLX_PREPARED;
+	}
+
+	err = clk_set_parent(cpufreq->cpu_clk, cpufreq->intermediate_clk);
+	if (WARN_ON_ONCE(err))
+		goto err_exclusive_put;
+
+	return 0;
+
+err_exclusive_put:
+	clk_rate_exclusive_put(cpufreq->intermediate_clk);
+
+	if (cpufreq->state & PLLX_PREPARED) {
 		clk_disable_unprepare(cpufreq->pll_x_clk);
-	else
-		cpufreq->pll_x_prepared = true;
+		cpufreq->state &= ~PLLX_PREPARED;
+	}
 
-	return ret;
+	return err;
 }
 
 static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	unsigned long rate = freq_table[index].frequency;
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
+	unsigned long new_rate = cpufreq->freq_table[index].frequency * 1000;
+	unsigned int state = cpufreq->state;
 	int ret;
 
 	/*
-	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
-	 * as it isn't used anymore.
+	 * Drop refcount to PLLX only if we switched to intermediate clock
+	 * earlier during transitioning to a target frequency and we are going
+	 * to stay with the intermediate clock.
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
 
-	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_x_clk);
-	/* This shouldn't fail while changing or restoring */
-	WARN_ON(ret);
+	/*
+	 * Target rate == intermediate rate leaves PLLX turned off, CPU is
+	 * kept running off the intermediate clock. This should save us some
+	 * power by keeping one more PLL disabled because the intermediate
+	 * clock assumed to be always-on. In this case PLLX_PREPARE flag will
+	 * be omitted.
+	 */
+	if (state & PLLX_PREPARE) {
+		/*
+		 * CCF doesn't return error if clock-enabling fails on
+		 * re-parent, hence enable it now.
+		 */
+		ret = clk_prepare_enable(cpufreq->pll_x_clk);
+		if (WARN_ON_ONCE(ret))
+			goto exclusive_put;
+
+		ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_x_clk);
+
+		clk_disable_unprepare(cpufreq->pll_x_clk);
+	}
 
 	/*
-	 * Drop count to pll_x clock only if we switched to intermediate freq
-	 * earlier while transitioning to a target frequency.
+	 * Drop refcount to PLLX only if we switched to intermediate clock
+	 * earlier during transitioning to a target frequency.
 	 */
-	if (cpufreq->pll_x_prepared) {
+	if (state & PLLX_PREPARED) {
 		clk_disable_unprepare(cpufreq->pll_x_clk);
-		cpufreq->pll_x_prepared = false;
+		state &= ~PLLX_PREPARED;
 	}
 
+exclusive_put:
+	clk_rate_exclusive_put(cpufreq->intermediate_clk);
+
+	cpufreq->state = state;
+
 	return ret;
 }
 
-static int tegra_cpu_init(struct cpufreq_policy *policy)
+static int tegra_cpu_opp_set_core_voltage(struct tegra_cpufreq *cpufreq,
+					  struct dev_pm_opp_supply *cpu_supply)
+{
+	int min_core_uV = INT_MAX, max_core_uV = INT_MIN;
+	int min_rtc_uV = INT_MAX, max_rtc_uV = INT_MIN;
+	int err;
+
+	if (cpufreq->chip == TEGRA20) {
+		/* only Tegra20 require to adjust RTC domain voltage */
+		min_core_uV = cpu_supply->u_volt_min + 125000;
+		max_core_uV = 1300000;
+		min_rtc_uV  = cpu_supply->u_volt_min + 125000;
+		max_rtc_uV  = 1300000;
+	} else {
+		/*
+		 * On Tegra30 min CORE voltage vary depending on the CPU
+		 * voltage and grade of HW. Note that we assume here that
+		 * the default (validated) CPU voltages are being used.
+		 */
+		switch (cpu_supply->u_volt_min) {
+		case 0 ... 799999:
+			min_core_uV = 950000;
+			break;
+
+		case 800000 ... 899999:
+			min_core_uV = 1000000;
+			break;
+
+		case 900000 ... 999999:
+			min_core_uV = 1100000;
+			break;
+
+		case 1000000 ... 1099999:
+			min_core_uV = 1200000;
+			break;
+
+		case 1100000 ... 1250000:
+			switch (cpufreq->cpu_speedo_id) {
+			case 0 ... 1:
+			case 4:
+			case 7:
+			case 8:
+				min_core_uV = 1200000;
+				break;
+
+			default:
+				min_core_uV = 1300000;
+				break;
+			}
+			break;
+
+		default:
+			return -EINVAL;
+		}
+
+		max_core_uV = 1350000;
+	}
+
+	/*
+	 * TODO: CORE and RTC voltages also depend on the status of
+	 * different peripherals in the system. Currently DVFS is
+	 * implemented only for CPU in the kernel, hence limit CORE
+	 * and RTC voltages to the max for now and remove the
+	 * limitations once system-wide DVFS will become available.
+	 */
+	min_core_uV = max_core_uV;
+	min_rtc_uV  = max_rtc_uV;
+
+	err = regulator_set_voltage(cpufreq->reg_core,
+				    min_core_uV, max_core_uV);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to set CORE voltage (%d %d): %d\n",
+			min_core_uV, max_core_uV, err);
+		return err;
+	}
+
+	if (cpufreq->chip == TEGRA20) {
+		err = regulator_set_voltage(cpufreq->reg_rtc,
+					    min_rtc_uV, max_rtc_uV);
+		if (err) {
+			dev_err(cpufreq->dev,
+				"Failed to set RTC voltage (%d %d): %d\n",
+				min_rtc_uV, max_rtc_uV, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int tegra_cpu_opp_set_cpu_voltage(struct tegra_cpufreq *cpufreq,
+					 struct dev_pm_opp_supply *supply)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
 	int ret;
 
-	clk_prepare_enable(cpufreq->cpu_clk);
+	ret = regulator_set_voltage_triplet(cpufreq->reg_cpu,
+					    supply->u_volt_min,
+					    supply->u_volt,
+					    supply->u_volt_max);
+	if (ret)
+		dev_err(cpufreq->dev,
+			"Failed to set CPU voltage (%lu %lu %lu mV): %d\n",
+			supply->u_volt_min, supply->u_volt,
+			supply->u_volt_max, ret);
 
-	/* FIXME: what's the actual transition time? */
-	ret = cpufreq_generic_init(policy, freq_table, 300 * 1000);
-	if (ret) {
-		clk_disable_unprepare(cpufreq->cpu_clk);
-		return ret;
+	return ret;
+}
+
+static void tegra_cpu_deferred_voltage_drop(struct work_struct *work)
+{
+	struct tegra_cpufreq *cpufreq = container_of(work, struct tegra_cpufreq,
+						     work.work);
+	int err;
+
+	err = tegra_cpu_opp_set_cpu_voltage(cpufreq, &cpufreq->supply_cpu);
+	if (err)
+		return;
+
+	err = tegra_cpu_opp_set_core_voltage(cpufreq, &cpufreq->supply_cpu);
+	if (err)
+		return;
+
+	cpufreq->actual_cpu_uV = cpufreq->supply_cpu.u_volt;
+}
+
+static int tegra_cpu_opp_raise_voltage(struct tegra_cpufreq *cpufreq,
+				       struct dev_pm_opp_supply *supply_cpu)
+{
+	int err;
+
+	err = tegra_cpu_opp_set_core_voltage(cpufreq, supply_cpu);
+	if (err)
+		return err;
+
+	err = tegra_cpu_opp_set_cpu_voltage(cpufreq, supply_cpu);
+	if (err)
+		return err;
+
+	cpufreq->actual_cpu_uV = supply_cpu->u_volt;
+
+	return 0;
+}
+
+static void tegra_cpu_opp_schedule_voltage_drop(
+					struct tegra_cpufreq *cpufreq,
+					struct dev_pm_opp_supply *supply_cpu)
+{
+	cpufreq->supply_cpu = *supply_cpu;
+
+	schedule_delayed_work(&cpufreq->work,
+			      msecs_to_jiffies(voltage_drop_interval_ms));
+}
+
+static int tegra_cpu_set_opp(struct dev_pm_set_opp_data *data)
+{
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
+	struct dev_pm_opp_supply *supply_cpu;
+	int err;
+
+	cancel_delayed_work_sync(&cpufreq->work);
+
+	supply_cpu = &data->new_opp.supplies[0];
+
+	/* Scaling up? Scale voltage before frequency */
+	if (data->old_opp.rate < data->new_opp.rate) {
+		if (cpufreq->actual_cpu_uV < supply_cpu->u_volt) {
+			err = tegra_cpu_opp_raise_voltage(cpufreq, supply_cpu);
+			if (err)
+				return err;
+		} else {
+			tegra_cpu_opp_schedule_voltage_drop(cpufreq,
+							    supply_cpu);
+		}
 	}
 
-	policy->clk = cpufreq->cpu_clk;
-	policy->suspend_freq = freq_table[0].frequency;
+	err = clk_set_rate(data->clk, data->new_opp.rate);
+	if (err) {
+		dev_err(cpufreq->dev, "Failed to change PLLX clock rate: %d\n",
+			err);
+		return err;
+	}
+
+	if (data->old_opp.rate > data->new_opp.rate)
+		tegra_cpu_opp_schedule_voltage_drop(cpufreq, supply_cpu);
+
 	return 0;
 }
 
-static int tegra_cpu_exit(struct cpufreq_policy *policy)
+static int tegra_cpu_setup_opp(struct tegra_cpufreq *cpufreq)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
+	const char * const regulators[] = { "cpu" };
+	struct device *dev = cpufreq->cpu_dev;
+	struct opp_table *opp_table;
+	u32 versions[2];
+	int err;
+
+	if (cpufreq->chip == TEGRA20) {
+		versions[0] = BIT(tegra_sku_info.cpu_process_id);
+		versions[1] = BIT(tegra_sku_info.soc_speedo_id);
+	} else {
+		versions[0] = BIT(tegra_sku_info.cpu_process_id);
+		versions[1] = BIT(tegra_sku_info.cpu_speedo_id);
+	}
+
+	cpufreq->opp_table = dev_pm_opp_set_supported_hw(dev, versions, 2);
+	if (IS_ERR(cpufreq->opp_table)) {
+		err = PTR_ERR(cpufreq->opp_table);
+		dev_err(cpufreq->dev,
+			"Failed to setup OPP supported HW: %d\n", err);
+		return err;
+	}
+
+	opp_table = dev_pm_opp_set_regulators(dev, regulators, 1, true);
+	if (IS_ERR(opp_table)) {
+		err = PTR_ERR(opp_table);
+		dev_err(dev,
+			"Failed to setup OPP regulators: %d\n", err);
+		goto err_put_supported_hw;
+	}
+
+	opp_table = dev_pm_opp_register_set_opp_helper(dev, tegra_cpu_set_opp);
+	if (IS_ERR(opp_table)) {
+		err = PTR_ERR(opp_table);
+		dev_err(cpufreq->dev,
+			"Failed to set OPP helper: %d\n", err);
+		goto err_put_regulators;
+	}
+
+	err = dev_pm_opp_of_cpumask_add_table(cpu_possible_mask);
+	if (err) {
+		dev_err(cpufreq->dev, "Failed to add OPP table: %d\n", err);
+		goto err_unregister_opp_helper;
+	}
+
+	err = dev_pm_opp_init_cpufreq_table(dev, &cpufreq->freq_table);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to initialize OPP table: %d\n", err);
+		goto err_remove_table;
+	}
 
-	clk_disable_unprepare(cpufreq->cpu_clk);
 	return 0;
+
+err_remove_table:
+	dev_pm_opp_of_cpumask_remove_table(cpu_possible_mask);
+
+err_unregister_opp_helper:
+	dev_pm_opp_unregister_set_opp_helper(cpufreq->opp_table);
+
+err_put_regulators:
+	dev_pm_opp_put_regulators(cpufreq->opp_table);
+
+err_put_supported_hw:
+	dev_pm_opp_put_supported_hw(cpufreq->opp_table);
+
+	return err;
 }
 
-static int tegra20_cpufreq_probe(struct platform_device *pdev)
+static void tegra_cpu_release_opp(struct tegra_cpufreq *cpufreq)
+{
+	dev_pm_opp_free_cpufreq_table(cpufreq->cpu_dev, &cpufreq->freq_table);
+	dev_pm_opp_of_cpumask_remove_table(cpu_possible_mask);
+	dev_pm_opp_unregister_set_opp_helper(cpufreq->opp_table);
+	dev_pm_opp_put_regulators(cpufreq->opp_table);
+	dev_pm_opp_put_supported_hw(cpufreq->opp_table);
+}
+
+static int tegra_cpu_init_clocks(struct tegra_cpufreq *cpufreq)
+{
+	unsigned long intermediate_rate;
+	int ret;
+
+	ret = clk_rate_exclusive_get(cpufreq->intermediate_clk);
+	if (ret) {
+		dev_err(cpufreq->dev,
+			"Failed to make intermediate clock exclusive: %d\n",
+			ret);
+		goto err_exclusive_put_intermediate;
+	}
+
+	ret = clk_set_parent(cpufreq->cpu_clk, cpufreq->intermediate_clk);
+	if (ret) {
+		dev_err(cpufreq->dev,
+			"Failed to switch CPU to intermediate clock: %d\n",
+			ret);
+		goto err_exclusive_put_intermediate;
+	}
+
+	intermediate_rate = clk_get_rate(cpufreq->intermediate_clk);
+
+	/*
+	 * The CCLK has its own clock divider, that divider isn't getting
+	 * disabled on clock reparent. Hence set CCLK parent to intermediate
+	 * clock in order to disable the divider if it happens to be enabled,
+	 * otherwise clk_set_rate() has no effect.
+	 */
+	ret = clk_set_rate(cpufreq->cpu_clk, intermediate_rate);
+	if (ret) {
+		dev_err(cpufreq->dev,
+			"Failed to change CPU clock rate: %d\n", ret);
+		goto err_exclusive_put_intermediate;
+	}
+
+err_exclusive_put_intermediate:
+	clk_rate_exclusive_put(cpufreq->intermediate_clk);
+
+	return ret;
+}
+
+static int tegra_cpu_get_regulators(struct tegra_cpufreq *cpufreq)
 {
-	struct tegra20_cpufreq *cpufreq;
 	int err;
 
-	cpufreq = devm_kzalloc(&pdev->dev, sizeof(*cpufreq), GFP_KERNEL);
-	if (!cpufreq)
-		return -ENOMEM;
+	cpufreq->reg_cpu = regulator_get(cpufreq->cpu_dev, "cpu");
+	if (IS_ERR(cpufreq->reg_cpu)) {
+		err = PTR_ERR(cpufreq->reg_cpu);
+		dev_err(cpufreq->dev,
+			"Failed to get CPU regulator: %d\n", err);
+		return err;
+	}
+
+	cpufreq->reg_core = regulator_get(cpufreq->cpu_dev, "core");
+	if (IS_ERR(cpufreq->reg_core)) {
+		err = PTR_ERR(cpufreq->reg_core);
+		dev_err(cpufreq->dev,
+			"Failed to get CORE regulator: %d\n", err);
+		goto err_reg_cpu_put;
+	}
+
+	if (cpufreq->chip == TEGRA20) {
+		cpufreq->reg_rtc = regulator_get(cpufreq->cpu_dev, "rtc");
+		if (IS_ERR(cpufreq->reg_rtc)) {
+			err = PTR_ERR(cpufreq->reg_rtc);
+			dev_err(cpufreq->dev,
+				"Failed to get RTC regulator: %d\n", err);
+			goto err_reg_core_put;
+		}
+	}
+
+	return 0;
+
+err_reg_core_put:
+	regulator_put(cpufreq->reg_core);
+
+err_reg_cpu_put:
+	regulator_put(cpufreq->reg_cpu);
 
-	cpufreq->cpu_clk = clk_get_sys(NULL, "cclk");
-	if (IS_ERR(cpufreq->cpu_clk))
-		return PTR_ERR(cpufreq->cpu_clk);
+	return err;
+}
+
+static void tegra_cpu_put_regulators(struct tegra_cpufreq *cpufreq)
+{
+	if (cpufreq->chip == TEGRA20)
+		regulator_put(cpufreq->reg_rtc);
+
+	regulator_put(cpufreq->reg_core);
+	regulator_put(cpufreq->reg_cpu);
+}
+
+static int tegra_cpu_enable_regulators(struct tegra_cpufreq *cpufreq)
+{
+	int err;
+
+	if (cpufreq->chip == TEGRA20) {
+		err = regulator_enable(cpufreq->reg_rtc);
+		if (err) {
+			dev_err(cpufreq->dev,
+				"Failed to enable RTC regulator: %d\n", err);
+			return err;
+		}
+	}
+
+	err = regulator_enable(cpufreq->reg_core);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to enable CORE regulator: %d\n", err);
+		goto err_reg_rtc_disable;
+	}
+
+	err = regulator_enable(cpufreq->reg_cpu);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to enable CPU regulator: %d\n", err);
+		goto err_reg_core_disable;
+	}
+
+	return 0;
+
+err_reg_rtc_disable:
+	if (cpufreq->chip == TEGRA20)
+		regulator_put(cpufreq->reg_rtc);
 
-	cpufreq->pll_x_clk = clk_get_sys(NULL, "pll_x");
+err_reg_core_disable:
+	regulator_put(cpufreq->reg_core);
+
+	return err;
+}
+
+static void tegra_cpu_disable_regulators(struct tegra_cpufreq *cpufreq)
+{
+	regulator_disable(cpufreq->reg_cpu);
+	regulator_disable(cpufreq->reg_core);
+
+	if (cpufreq->chip == TEGRA20)
+		regulator_disable(cpufreq->reg_rtc);
+}
+
+static int tegra_cpu_get_clocks(struct tegra_cpufreq *cpufreq)
+{
+	int err;
+
+	cpufreq->cpu_clk = clk_get(cpufreq->cpu_dev, "cclk");
+	if (IS_ERR(cpufreq->cpu_clk)) {
+		err = PTR_ERR(cpufreq->cpu_clk);
+		dev_err(cpufreq->dev, "Failed to get CPU clock: %d\n", err);
+		dev_err(cpufreq->dev, "Please update your device tree\n");
+		return err;
+	}
+
+	cpufreq->pll_x_clk = clk_get(cpufreq->cpu_dev, "pll_x");
 	if (IS_ERR(cpufreq->pll_x_clk)) {
 		err = PTR_ERR(cpufreq->pll_x_clk);
-		goto put_cpu;
+		dev_err(cpufreq->dev, "Failed to get PLLX clock: %d\n", err);
+		goto err_clk_cpu_put;
+	}
+
+	cpufreq->intermediate_clk = clk_get(cpufreq->cpu_dev, "intermediate");
+	if (IS_ERR(cpufreq->intermediate_clk)) {
+		err = PTR_ERR(cpufreq->intermediate_clk);
+		dev_err(cpufreq->dev, "Failed to get intermediate clock: %d\n",
+			err);
+		goto err_clk_pll_x_put;
+	}
+
+	return 0;
+
+err_clk_pll_x_put:
+	clk_put(cpufreq->pll_x_clk);
+
+err_clk_cpu_put:
+	clk_put(cpufreq->cpu_clk);
+
+	return err;
+}
+
+static void tegra_cpu_put_clocks(struct tegra_cpufreq *cpufreq)
+{
+	clk_put(cpufreq->intermediate_clk);
+	clk_put(cpufreq->pll_x_clk);
+	clk_put(cpufreq->cpu_clk);
+}
+
+static int tegra_cpu_enable_clocks(struct tegra_cpufreq *cpufreq)
+{
+	int err;
+
+	err = clk_prepare_enable(cpufreq->cpu_clk);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to enable CPU clock: %d\n", err);
+		return err;
 	}
 
-	cpufreq->pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(cpufreq->pll_p_clk)) {
-		err = PTR_ERR(cpufreq->pll_p_clk);
-		goto put_pll_x;
+	err = clk_prepare_enable(cpufreq->intermediate_clk);
+	if (err) {
+		dev_err(cpufreq->dev,
+			"Failed to enable intermediate clock: %d\n", err);
+		goto err_clk_cpu_disable;
 	}
 
+	return 0;
+
+err_clk_cpu_disable:
+	clk_disable_unprepare(cpufreq->cpu_clk);
+
+	return err;
+}
+
+static void tegra_cpu_disable_clocks(struct tegra_cpufreq *cpufreq)
+{
+	clk_disable_unprepare(cpufreq->intermediate_clk);
+	clk_disable_unprepare(cpufreq->cpu_clk);
+}
+
+static int tegra_cpu_get_resources(struct tegra_cpufreq *cpufreq)
+{
+	int err;
+
+	err = tegra_cpu_get_clocks(cpufreq);
+	if (err)
+		return err;
+
+	err = tegra_cpu_enable_clocks(cpufreq);
+	if (err)
+		goto err_put_clocks;
+
+	err = tegra_cpu_get_regulators(cpufreq);
+	if (err)
+		goto err_disable_clocks;
+
+	err = tegra_cpu_enable_regulators(cpufreq);
+	if (err)
+		goto err_put_regulators;
+
+	err = tegra_cpu_init_clocks(cpufreq);
+	if (err)
+		goto err_disable_regulators;
+
+	return 0;
+
+err_disable_regulators:
+	tegra_cpu_disable_regulators(cpufreq);
+
+err_put_regulators:
+	tegra_cpu_put_regulators(cpufreq);
+
+err_disable_clocks:
+	tegra_cpu_disable_clocks(cpufreq);
+
+err_put_clocks:
+	tegra_cpu_put_clocks(cpufreq);
+
+	return err;
+}
+
+static void tegra_cpu_release_resources(struct tegra_cpufreq *cpufreq)
+{
+	tegra_cpu_disable_regulators(cpufreq);
+	tegra_cpu_put_regulators(cpufreq);
+	tegra_cpu_disable_clocks(cpufreq);
+	tegra_cpu_put_clocks(cpufreq);
+}
+
+static int tegra_cpu_init(struct cpufreq_policy *policy)
+{
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
+	struct device *cpu = cpufreq->cpu_dev;
+	int err;
+
+	err = tegra_cpu_get_resources(cpufreq);
+	if (err)
+		return err;
+
+	err = tegra_cpu_setup_opp(cpufreq);
+	if (err)
+		goto err_release_resources;
+
+	err = cpufreq_generic_init(policy, cpufreq->freq_table,
+				   dev_pm_opp_get_max_clock_latency(cpu));
+	if (err)
+		goto err_release_opp;
+
+	policy->clk = cpufreq->cpu_clk;
+	policy->suspend_freq = dev_pm_opp_get_suspend_opp_freq(cpu) / 1000;
+
+	return 0;
+
+err_release_opp:
+	tegra_cpu_release_opp(cpufreq);
+
+err_release_resources:
+	tegra_cpu_release_resources(cpufreq);
+
+	return err;
+}
+
+static int tegra_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
+
+	flush_delayed_work(&cpufreq->work);
+	cpufreq_cooling_unregister(cpufreq->cdev);
+	tegra_cpu_release_opp(cpufreq);
+	tegra_cpu_release_resources(cpufreq);
+
+	return 0;
+}
+
+static void tegra_cpu_ready(struct cpufreq_policy *policy)
+{
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
+
+	cpufreq->cdev = of_cpufreq_cooling_register(policy);
+}
+
+static int tegra_cpu_suspend(struct cpufreq_policy *policy)
+{
+	struct tegra_cpufreq *cpufreq = cpufreq_get_driver_data();
+	int err;
+
+	err = cpufreq_generic_suspend(policy);
+	if (err)
+		return err;
+
+	flush_delayed_work(&cpufreq->work);
+
+	return 0;
+}
+
+static int tegra_cpufreq_probe(struct platform_device *pdev)
+{
+	struct tegra_cpufreq *cpufreq;
+	int err;
+
+	cpufreq = devm_kzalloc(&pdev->dev, sizeof(*cpufreq), GFP_KERNEL);
+	if (!cpufreq)
+		return -ENOMEM;
+
 	cpufreq->dev = &pdev->dev;
+	cpufreq->cpu_dev = get_cpu_device(0);
+	cpufreq->cpu_speedo_id = tegra_sku_info.cpu_speedo_id;
+	cpufreq->chip = tegra_get_chip_id();
 	cpufreq->driver.get = cpufreq_generic_get;
 	cpufreq->driver.attr = cpufreq_generic_attr;
 	cpufreq->driver.init = tegra_cpu_init;
 	cpufreq->driver.exit = tegra_cpu_exit;
+	cpufreq->driver.ready = tegra_cpu_ready;
 	cpufreq->driver.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK;
 	cpufreq->driver.verify = cpufreq_generic_frequency_table_verify;
-	cpufreq->driver.suspend = cpufreq_generic_suspend;
+	cpufreq->driver.suspend = tegra_cpu_suspend;
 	cpufreq->driver.driver_data = cpufreq;
 	cpufreq->driver.target_index = tegra_target;
 	cpufreq->driver.get_intermediate = tegra_get_intermediate;
 	cpufreq->driver.target_intermediate = tegra_target_intermediate;
 	snprintf(cpufreq->driver.name, CPUFREQ_NAME_LEN, "tegra");
+	INIT_DELAYED_WORK(&cpufreq->work, tegra_cpu_deferred_voltage_drop);
 
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
 
-static int tegra20_cpufreq_remove(struct platform_device *pdev)
+static int tegra_cpufreq_remove(struct platform_device *pdev)
 {
-	struct tegra20_cpufreq *cpufreq = platform_get_drvdata(pdev);
+	struct tegra_cpufreq *cpufreq = platform_get_drvdata(pdev);
 
 	cpufreq_unregister_driver(&cpufreq->driver);
 
-	clk_put(cpufreq->pll_p_clk);
-	clk_put(cpufreq->pll_x_clk);
-	clk_put(cpufreq->cpu_clk);
-
 	return 0;
 }
 
-static struct platform_driver tegra20_cpufreq_driver = {
-	.probe		= tegra20_cpufreq_probe,
-	.remove		= tegra20_cpufreq_remove,
+static struct platform_driver tegra_cpufreq_driver = {
+	.probe		= tegra_cpufreq_probe,
+	.remove		= tegra_cpufreq_remove,
 	.driver		= {
 		.name	= "tegra20-cpufreq",
 	},
 };
-module_platform_driver(tegra20_cpufreq_driver);
+module_platform_driver(tegra_cpufreq_driver);
+
+module_param(voltage_drop_interval_ms, uint, 0644);
 
 MODULE_ALIAS("platform:tegra20-cpufreq");
 MODULE_AUTHOR("Colin Cross <ccross@android.com>");
+MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.19.0


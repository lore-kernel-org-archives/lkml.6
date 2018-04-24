Return-Path: <krzk@kernel.org>
X-Google-Smtp-Source: AB8JxZp8dT36QwLwuoypG3Cq+SOYMYNIVz+q4WufbaxK14y69R0rs8ukEUaKso1lS+joFQftMH8/
ARC-Seal: i=1; a=rsa-sha256; t=1524602012; cv=none;
        d=google.com; s=arc-20160816;
        b=A7cK1J36oSnrk9X+6AdqlVtBRW2Ve1wTjy7hMx29K99cvLdGpqIdu//4u0nDhL9ITf
         JDzHX0FgDd51dQRhDslE4KEgUKfw8qzq+nk2W+5gP8X8HqsSI4YnmZC27m2fhSlCvVoK
         c/Qf4rRD2AiPdvaLVcrj9nFqx0rMkQIv2irHXhVKMa4l3f7swYsgXH0Mk20Dte/4zenF
         azsovYn4ovtpRhIgjKidTp2dEPmUYc2uirwmbFkD0rpI/fqUryzaSq6pD4GtvbToMUzr
         mVg7JnVXel13p6yyvhS1NxblCoU225vnFF/Sx4JM2boxI6IhubiJ8ZvttnMpeZTpNsM/
         TduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=NX2O8gAVVNhoS+vzmi4yfGJ8TVw79HTMVqi6pBKUmVU=;
        b=hpmZK5AhL9+/2CLUmia/tBpte2cQfwsEzvY+JjIQP5a2pfsRRgLqlQpwxc/IpOaA+x
         oO4av+jn3rPQLKDT/l+T7eJwdlCyBAOd2WPrR7c1AlYEfNbHY0k/eD6hPjUBHh4+kwag
         aOaWh2pH3oqAi1ZImQ6st6lU55CAQW9N71BFSko/7blD4FerGonDhp/OXb3jbKbSK5ss
         INsonwK6qiTF9mjgVJ/t8gqzXS+l1KWhyVp1BGOOxko5loOYKKlN734mxS7zw8Rl5WZw
         xGBlf4xJw8lCwssVfg77BZO2jU/LkzgF4F40FXOVMsp2A/JmumqwmFeua1hVdtuUAozg
         YTLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of krzk@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=krzk@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909C0217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tejun Heo <tj@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andi Shyti <andi@etezian.org>,
	Mark Brown <broonie@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC 03/10] cpufreq: exynos: Remove support for Exynos5440
Date: Tue, 24 Apr 2018 22:32:32 +0200
Message-Id: <20180424203239.21885-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180424203239.21885-1-krzk@kernel.org>
References: <20180424203239.21885-1-krzk@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598661079695051015?=
X-GMAIL-MSGID: =?utf-8?q?1598661079695051015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Exynos5440 is not actively developed, there are no development
boards available and probably there are no real products with it.
Remove wide-tree support for Exynos5440.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/cpufreq/cpufreq-exynos5440.txt        |  28 --
 drivers/cpufreq/Kconfig.arm                        |  14 -
 drivers/cpufreq/Makefile                           |   1 -
 drivers/cpufreq/exynos5440-cpufreq.c               | 452 ---------------------
 4 files changed, 495 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
 delete mode 100644 drivers/cpufreq/exynos5440-cpufreq.c

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
deleted file mode 100644
index caff1a57436f..000000000000
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos5440.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-
-Exynos5440 cpufreq driver
--------------------
-
-Exynos5440 SoC cpufreq driver for CPU frequency scaling.
-
-Required properties:
-- interrupts: Interrupt to know the completion of cpu frequency change.
-- operating-points: Table of frequencies and voltage CPU could be transitioned into,
-	in the decreasing order. Frequency should be in KHz units and voltage
-	should be in microvolts.
-
-Optional properties:
-- clock-latency: Clock monitor latency in microsecond.
-
-All the required listed above must be defined under node cpufreq.
-
-Example:
---------
-	cpufreq@160000 {
-		compatible = "samsung,exynos5440-cpufreq";
-		reg = <0x160000 0x1000>;
-		interrupts = <0 57 0>;
-		operating-points = <
-				1000000 975000
-				800000  925000>;
-		clock-latency = <100000>;
-	};
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 7f56fe5183f2..538a4004a2c5 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -81,20 +81,6 @@ config ARM_BRCMSTB_AVS_CPUFREQ_DEBUG
 
 	  If in doubt, say N.
 
-config ARM_EXYNOS5440_CPUFREQ
-	tristate "SAMSUNG EXYNOS5440"
-	depends on SOC_EXYNOS5440
-	depends on HAVE_CLK && OF
-	select PM_OPP
-	default y
-	help
-	  This adds the CPUFreq driver for Samsung EXYNOS5440
-	  SoC. The nature of exynos5440 clock controller is
-	  different than previous exynos controllers so not using
-	  the common exynos framework.
-
-	  If in doubt, say N.
-
 config ARM_HIGHBANK_CPUFREQ
 	tristate "Calxeda Highbank-based"
 	depends on ARCH_HIGHBANK && CPUFREQ_DT && REGULATOR
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d24ade3bd02..56724f867f78 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -56,7 +56,6 @@ obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
 obj-$(CONFIG_ACPI_CPPC_CPUFREQ)		+= cppc_cpufreq.o
 obj-$(CONFIG_ARCH_DAVINCI)		+= davinci-cpufreq.o
-obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
 obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
deleted file mode 100644
index 932caa386ece..000000000000
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ /dev/null
@@ -1,452 +0,0 @@
-/*
- * Copyright (c) 2013 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Amit Daniel Kachhap <amit.daniel@samsung.com>
- *
- * EXYNOS5440 - CPU frequency scaling support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/clk.h>
-#include <linux/cpu.h>
-#include <linux/cpufreq.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/pm_opp.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-/* Register definitions */
-#define XMU_DVFS_CTRL		0x0060
-#define XMU_PMU_P0_7		0x0064
-#define XMU_C0_3_PSTATE		0x0090
-#define XMU_P_LIMIT		0x00a0
-#define XMU_P_STATUS		0x00a4
-#define XMU_PMUEVTEN		0x00d0
-#define XMU_PMUIRQEN		0x00d4
-#define XMU_PMUIRQ		0x00d8
-
-/* PMU mask and shift definations */
-#define P_VALUE_MASK		0x7
-
-#define XMU_DVFS_CTRL_EN_SHIFT	0
-
-#define P0_7_CPUCLKDEV_SHIFT	21
-#define P0_7_CPUCLKDEV_MASK	0x7
-#define P0_7_ATBCLKDEV_SHIFT	18
-#define P0_7_ATBCLKDEV_MASK	0x7
-#define P0_7_CSCLKDEV_SHIFT	15
-#define P0_7_CSCLKDEV_MASK	0x7
-#define P0_7_CPUEMA_SHIFT	28
-#define P0_7_CPUEMA_MASK	0xf
-#define P0_7_L2EMA_SHIFT	24
-#define P0_7_L2EMA_MASK		0xf
-#define P0_7_VDD_SHIFT		8
-#define P0_7_VDD_MASK		0x7f
-#define P0_7_FREQ_SHIFT		0
-#define P0_7_FREQ_MASK		0xff
-
-#define C0_3_PSTATE_VALID_SHIFT	8
-#define C0_3_PSTATE_CURR_SHIFT	4
-#define C0_3_PSTATE_NEW_SHIFT	0
-
-#define PSTATE_CHANGED_EVTEN_SHIFT	0
-
-#define PSTATE_CHANGED_IRQEN_SHIFT	0
-
-#define PSTATE_CHANGED_SHIFT		0
-
-/* some constant values for clock divider calculation */
-#define CPU_DIV_FREQ_MAX	500
-#define CPU_DBG_FREQ_MAX	375
-#define CPU_ATB_FREQ_MAX	500
-
-#define PMIC_LOW_VOLT		0x30
-#define PMIC_HIGH_VOLT		0x28
-
-#define CPUEMA_HIGH		0x2
-#define CPUEMA_MID		0x4
-#define CPUEMA_LOW		0x7
-
-#define L2EMA_HIGH		0x1
-#define L2EMA_MID		0x3
-#define L2EMA_LOW		0x4
-
-#define DIV_TAB_MAX	2
-/* frequency unit is 20MHZ */
-#define FREQ_UNIT	20
-#define MAX_VOLTAGE	1550000 /* In microvolt */
-#define VOLTAGE_STEP	12500	/* In microvolt */
-
-#define CPUFREQ_NAME		"exynos5440_dvfs"
-#define DEF_TRANS_LATENCY	100000
-
-enum cpufreq_level_index {
-	L0, L1, L2, L3, L4,
-	L5, L6, L7, L8, L9,
-};
-#define CPUFREQ_LEVEL_END	(L7 + 1)
-
-struct exynos_dvfs_data {
-	void __iomem *base;
-	struct resource *mem;
-	int irq;
-	struct clk *cpu_clk;
-	unsigned int latency;
-	struct cpufreq_frequency_table *freq_table;
-	unsigned int freq_count;
-	struct device *dev;
-	bool dvfs_enabled;
-	struct work_struct irq_work;
-};
-
-static struct exynos_dvfs_data *dvfs_info;
-static DEFINE_MUTEX(cpufreq_lock);
-static struct cpufreq_freqs freqs;
-
-static int init_div_table(void)
-{
-	struct cpufreq_frequency_table *pos, *freq_tbl = dvfs_info->freq_table;
-	unsigned int tmp, clk_div, ema_div, freq, volt_id, idx;
-	struct dev_pm_opp *opp;
-
-	cpufreq_for_each_entry_idx(pos, freq_tbl, idx) {
-		opp = dev_pm_opp_find_freq_exact(dvfs_info->dev,
-					pos->frequency * 1000, true);
-		if (IS_ERR(opp)) {
-			dev_err(dvfs_info->dev,
-				"failed to find valid OPP for %u KHZ\n",
-				pos->frequency);
-			return PTR_ERR(opp);
-		}
-
-		freq = pos->frequency / 1000; /* In MHZ */
-		clk_div = ((freq / CPU_DIV_FREQ_MAX) & P0_7_CPUCLKDEV_MASK)
-					<< P0_7_CPUCLKDEV_SHIFT;
-		clk_div |= ((freq / CPU_ATB_FREQ_MAX) & P0_7_ATBCLKDEV_MASK)
-					<< P0_7_ATBCLKDEV_SHIFT;
-		clk_div |= ((freq / CPU_DBG_FREQ_MAX) & P0_7_CSCLKDEV_MASK)
-					<< P0_7_CSCLKDEV_SHIFT;
-
-		/* Calculate EMA */
-		volt_id = dev_pm_opp_get_voltage(opp);
-
-		volt_id = (MAX_VOLTAGE - volt_id) / VOLTAGE_STEP;
-		if (volt_id < PMIC_HIGH_VOLT) {
-			ema_div = (CPUEMA_HIGH << P0_7_CPUEMA_SHIFT) |
-				(L2EMA_HIGH << P0_7_L2EMA_SHIFT);
-		} else if (volt_id > PMIC_LOW_VOLT) {
-			ema_div = (CPUEMA_LOW << P0_7_CPUEMA_SHIFT) |
-				(L2EMA_LOW << P0_7_L2EMA_SHIFT);
-		} else {
-			ema_div = (CPUEMA_MID << P0_7_CPUEMA_SHIFT) |
-				(L2EMA_MID << P0_7_L2EMA_SHIFT);
-		}
-
-		tmp = (clk_div | ema_div | (volt_id << P0_7_VDD_SHIFT)
-			| ((freq / FREQ_UNIT) << P0_7_FREQ_SHIFT));
-
-		__raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 * idx);
-		dev_pm_opp_put(opp);
-	}
-
-	return 0;
-}
-
-static void exynos_enable_dvfs(unsigned int cur_frequency)
-{
-	unsigned int tmp, cpu;
-	struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
-	struct cpufreq_frequency_table *pos;
-	/* Disable DVFS */
-	__raw_writel(0,	dvfs_info->base + XMU_DVFS_CTRL);
-
-	/* Enable PSTATE Change Event */
-	tmp = __raw_readl(dvfs_info->base + XMU_PMUEVTEN);
-	tmp |= (1 << PSTATE_CHANGED_EVTEN_SHIFT);
-	__raw_writel(tmp, dvfs_info->base + XMU_PMUEVTEN);
-
-	/* Enable PSTATE Change IRQ */
-	tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQEN);
-	tmp |= (1 << PSTATE_CHANGED_IRQEN_SHIFT);
-	__raw_writel(tmp, dvfs_info->base + XMU_PMUIRQEN);
-
-	/* Set initial performance index */
-	cpufreq_for_each_entry(pos, freq_table)
-		if (pos->frequency == cur_frequency)
-			break;
-
-	if (pos->frequency == CPUFREQ_TABLE_END) {
-		dev_crit(dvfs_info->dev, "Boot up frequency not supported\n");
-		/* Assign the highest frequency */
-		pos = freq_table;
-		cur_frequency = pos->frequency;
-	}
-
-	dev_info(dvfs_info->dev, "Setting dvfs initial frequency = %uKHZ",
-						cur_frequency);
-
-	for (cpu = 0; cpu < CONFIG_NR_CPUS; cpu++) {
-		tmp = __raw_readl(dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
-		tmp &= ~(P_VALUE_MASK << C0_3_PSTATE_NEW_SHIFT);
-		tmp |= ((pos - freq_table) << C0_3_PSTATE_NEW_SHIFT);
-		__raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + cpu * 4);
-	}
-
-	/* Enable DVFS */
-	__raw_writel(1 << XMU_DVFS_CTRL_EN_SHIFT,
-				dvfs_info->base + XMU_DVFS_CTRL);
-}
-
-static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
-{
-	unsigned int tmp;
-	int i;
-	struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
-
-	mutex_lock(&cpufreq_lock);
-
-	freqs.old = policy->cur;
-	freqs.new = freq_table[index].frequency;
-
-	cpufreq_freq_transition_begin(policy, &freqs);
-
-	/* Set the target frequency in all C0_3_PSTATE register */
-	for_each_cpu(i, policy->cpus) {
-		tmp = __raw_readl(dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
-		tmp &= ~(P_VALUE_MASK << C0_3_PSTATE_NEW_SHIFT);
-		tmp |= (index << C0_3_PSTATE_NEW_SHIFT);
-
-		__raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
-	}
-	mutex_unlock(&cpufreq_lock);
-	return 0;
-}
-
-static void exynos_cpufreq_work(struct work_struct *work)
-{
-	unsigned int cur_pstate, index;
-	struct cpufreq_policy *policy = cpufreq_cpu_get(0); /* boot CPU */
-	struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
-
-	/* Ensure we can access cpufreq structures */
-	if (unlikely(dvfs_info->dvfs_enabled == false))
-		goto skip_work;
-
-	mutex_lock(&cpufreq_lock);
-	freqs.old = policy->cur;
-
-	cur_pstate = __raw_readl(dvfs_info->base + XMU_P_STATUS);
-	if (cur_pstate >> C0_3_PSTATE_VALID_SHIFT & 0x1)
-		index = (cur_pstate >> C0_3_PSTATE_CURR_SHIFT) & P_VALUE_MASK;
-	else
-		index = (cur_pstate >> C0_3_PSTATE_NEW_SHIFT) & P_VALUE_MASK;
-
-	if (likely(index < dvfs_info->freq_count)) {
-		freqs.new = freq_table[index].frequency;
-	} else {
-		dev_crit(dvfs_info->dev, "New frequency out of range\n");
-		freqs.new = freqs.old;
-	}
-	cpufreq_freq_transition_end(policy, &freqs, 0);
-
-	cpufreq_cpu_put(policy);
-	mutex_unlock(&cpufreq_lock);
-skip_work:
-	enable_irq(dvfs_info->irq);
-}
-
-static irqreturn_t exynos_cpufreq_irq(int irq, void *id)
-{
-	unsigned int tmp;
-
-	tmp = __raw_readl(dvfs_info->base + XMU_PMUIRQ);
-	if (tmp >> PSTATE_CHANGED_SHIFT & 0x1) {
-		__raw_writel(tmp, dvfs_info->base + XMU_PMUIRQ);
-		disable_irq_nosync(irq);
-		schedule_work(&dvfs_info->irq_work);
-	}
-	return IRQ_HANDLED;
-}
-
-static void exynos_sort_descend_freq_table(void)
-{
-	struct cpufreq_frequency_table *freq_tbl = dvfs_info->freq_table;
-	int i = 0, index;
-	unsigned int tmp_freq;
-	/*
-	 * Exynos5440 clock controller state logic expects the cpufreq table to
-	 * be in descending order. But the OPP library constructs the table in
-	 * ascending order. So to make the table descending we just need to
-	 * swap the i element with the N - i element.
-	 */
-	for (i = 0; i < dvfs_info->freq_count / 2; i++) {
-		index = dvfs_info->freq_count - i - 1;
-		tmp_freq = freq_tbl[i].frequency;
-		freq_tbl[i].frequency = freq_tbl[index].frequency;
-		freq_tbl[index].frequency = tmp_freq;
-	}
-}
-
-static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
-{
-	policy->clk = dvfs_info->cpu_clk;
-	return cpufreq_generic_init(policy, dvfs_info->freq_table,
-			dvfs_info->latency);
-}
-
-static struct cpufreq_driver exynos_driver = {
-	.flags		= CPUFREQ_STICKY | CPUFREQ_ASYNC_NOTIFICATION |
-				CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= cpufreq_generic_frequency_table_verify,
-	.target_index	= exynos_target,
-	.get		= cpufreq_generic_get,
-	.init		= exynos_cpufreq_cpu_init,
-	.name		= CPUFREQ_NAME,
-	.attr		= cpufreq_generic_attr,
-};
-
-static const struct of_device_id exynos_cpufreq_match[] = {
-	{
-		.compatible = "samsung,exynos5440-cpufreq",
-	},
-	{},
-};
-MODULE_DEVICE_TABLE(of, exynos_cpufreq_match);
-
-static int exynos_cpufreq_probe(struct platform_device *pdev)
-{
-	int ret = -EINVAL;
-	struct device_node *np;
-	struct resource res;
-	unsigned int cur_frequency;
-
-	np = pdev->dev.of_node;
-	if (!np)
-		return -ENODEV;
-
-	dvfs_info = devm_kzalloc(&pdev->dev, sizeof(*dvfs_info), GFP_KERNEL);
-	if (!dvfs_info) {
-		ret = -ENOMEM;
-		goto err_put_node;
-	}
-
-	dvfs_info->dev = &pdev->dev;
-
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret)
-		goto err_put_node;
-
-	dvfs_info->base = devm_ioremap_resource(dvfs_info->dev, &res);
-	if (IS_ERR(dvfs_info->base)) {
-		ret = PTR_ERR(dvfs_info->base);
-		goto err_put_node;
-	}
-
-	dvfs_info->irq = irq_of_parse_and_map(np, 0);
-	if (!dvfs_info->irq) {
-		dev_err(dvfs_info->dev, "No cpufreq irq found\n");
-		ret = -ENODEV;
-		goto err_put_node;
-	}
-
-	ret = dev_pm_opp_of_add_table(dvfs_info->dev);
-	if (ret) {
-		dev_err(dvfs_info->dev, "failed to init OPP table: %d\n", ret);
-		goto err_put_node;
-	}
-
-	ret = dev_pm_opp_init_cpufreq_table(dvfs_info->dev,
-					    &dvfs_info->freq_table);
-	if (ret) {
-		dev_err(dvfs_info->dev,
-			"failed to init cpufreq table: %d\n", ret);
-		goto err_free_opp;
-	}
-	dvfs_info->freq_count = dev_pm_opp_get_opp_count(dvfs_info->dev);
-	exynos_sort_descend_freq_table();
-
-	if (of_property_read_u32(np, "clock-latency", &dvfs_info->latency))
-		dvfs_info->latency = DEF_TRANS_LATENCY;
-
-	dvfs_info->cpu_clk = devm_clk_get(dvfs_info->dev, "armclk");
-	if (IS_ERR(dvfs_info->cpu_clk)) {
-		dev_err(dvfs_info->dev, "Failed to get cpu clock\n");
-		ret = PTR_ERR(dvfs_info->cpu_clk);
-		goto err_free_table;
-	}
-
-	cur_frequency = clk_get_rate(dvfs_info->cpu_clk);
-	if (!cur_frequency) {
-		dev_err(dvfs_info->dev, "Failed to get clock rate\n");
-		ret = -EINVAL;
-		goto err_free_table;
-	}
-	cur_frequency /= 1000;
-
-	INIT_WORK(&dvfs_info->irq_work, exynos_cpufreq_work);
-	ret = devm_request_irq(dvfs_info->dev, dvfs_info->irq,
-				exynos_cpufreq_irq, IRQF_TRIGGER_NONE,
-				CPUFREQ_NAME, dvfs_info);
-	if (ret) {
-		dev_err(dvfs_info->dev, "Failed to register IRQ\n");
-		goto err_free_table;
-	}
-
-	ret = init_div_table();
-	if (ret) {
-		dev_err(dvfs_info->dev, "Failed to initialise div table\n");
-		goto err_free_table;
-	}
-
-	exynos_enable_dvfs(cur_frequency);
-	ret = cpufreq_register_driver(&exynos_driver);
-	if (ret) {
-		dev_err(dvfs_info->dev,
-			"%s: failed to register cpufreq driver\n", __func__);
-		goto err_free_table;
-	}
-
-	of_node_put(np);
-	dvfs_info->dvfs_enabled = true;
-	return 0;
-
-err_free_table:
-	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
-err_free_opp:
-	dev_pm_opp_of_remove_table(dvfs_info->dev);
-err_put_node:
-	of_node_put(np);
-	dev_err(&pdev->dev, "%s: failed initialization\n", __func__);
-	return ret;
-}
-
-static int exynos_cpufreq_remove(struct platform_device *pdev)
-{
-	cpufreq_unregister_driver(&exynos_driver);
-	dev_pm_opp_free_cpufreq_table(dvfs_info->dev, &dvfs_info->freq_table);
-	dev_pm_opp_of_remove_table(dvfs_info->dev);
-	return 0;
-}
-
-static struct platform_driver exynos_cpufreq_platdrv = {
-	.driver = {
-		.name	= "exynos5440-cpufreq",
-		.of_match_table = exynos_cpufreq_match,
-	},
-	.probe		= exynos_cpufreq_probe,
-	.remove		= exynos_cpufreq_remove,
-};
-module_platform_driver(exynos_cpufreq_platdrv);
-
-MODULE_AUTHOR("Amit Daniel Kachhap <amit.daniel@samsung.com>");
-MODULE_DESCRIPTION("Exynos5440 cpufreq driver");
-MODULE_LICENSE("GPL");
-- 
2.14.1

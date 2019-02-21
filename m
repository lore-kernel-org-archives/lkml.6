Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E388C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4AF214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UM7yX3CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfBUJM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:12:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34135 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfBUJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:12:25 -0500
Received: by mail-pl1-f195.google.com with SMTP id d15so6718856plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 01:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W1IrwtHLuzseuHMSYeuvZ+Js5MN5EU/sXWHReRqX9s4=;
        b=UM7yX3CEgFkpqoz7UzXAuGlbBeMhFEvPPve2yLkY0+tkGcJW/Vibm8ETCDrGRCDBoz
         9+pTGB+9aiKFc7Fh9AbvHzF8z3t68QcXrXTuBUJztPRDkkkRtOPmdLN3pFiSYjlm61ak
         L3szGDQeWHiF6rNDaPSG4Z/Ivq1bgKz/aXgpYNw1amZojtr2bWNcb/SMBRb5QSzG1z86
         J7TfQRYbB6wbJdOVrj5nk1C9TOnYG+34ciTtBbUIFyUZnKtGpqctou7hhr5PO7CjIBOg
         wzarUuVVGw4mdDQJfqdJbb5T0SoLrZqVN7YK+hzESxgCtG+1gPW/oX5mtNTF69JzjDwV
         DkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1IrwtHLuzseuHMSYeuvZ+Js5MN5EU/sXWHReRqX9s4=;
        b=ttQO5qQEg7YmY9s6sVc3eNsZTT014DH66zQWs+UaobHSqddAVOdgIF6K81nBnhhNU8
         87OTFD0jO4tLM3YSTgB+gw8zTDQCc5bm6vRkmoAi5i09ovP2IX6LZRh0VWuxHeivBbmb
         URB6DYKVNUFk78Pmj2k2cY52JtMIYJiAzvJR1NmwvKxcFKQ97wPhob5sK8WJG5ZbFzhf
         aWMXJOe3xQ2NPOOh5Y6K0Cq4I01v5dk/iF2VnW7RK+Q32bYp1lJViMWfVm9AVYSENEOs
         v6T+Zz4V2tD5jK6b1q1eVD8p+jQQ24hIHral1DRGHSpb/Bj/muI40QhBIJ1yPQ0VHmXT
         DxHg==
X-Gm-Message-State: AHQUAuZNnccGUASiLu8T4h4L+mMpXGB3kjUjnVc6sAyGQcV7oRkdWEf1
        aZd6qQTYDmYE0mdRKvYUGlu1bw==
X-Google-Smtp-Source: AHgI3IbcMEnQp/hih6hbcLgIUHQ+x+HpYphUf3SXDfev68F2JF09oK90v73rjNcLotL+5zQlVQrgpA==
X-Received: by 2002:a17:902:7c8d:: with SMTP id y13mr23342975pll.336.1550740344765;
        Thu, 21 Feb 2019 01:12:24 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id i71sm66145208pfi.170.2019.02.21.01.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Feb 2019 01:12:23 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v7 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date:   Thu, 21 Feb 2019 14:41:41 +0530
Message-Id: <1550740301-10097-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
References: <1550740301-10097-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a PWM driver for PWM chip present in SiFive's HiFive Unleashed SoC.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
[Atish: Various fixes and code cleanup]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sifive.c | 346 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 drivers/pwm/pwm-sifive.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..4a61d1a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -380,6 +380,17 @@ config PWM_SAMSUNG
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-samsung.
 
+config PWM_SIFIVE
+	tristate "SiFive PWM support"
+	depends on OF
+	depends on COMMON_CLK
+	depends on RISCV || COMPILE_TEST
+	help
+	  Generic PWM framework driver for SiFive SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sifive.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9c676a0..30089ca 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
+obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
 obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
new file mode 100644
index 0000000..8f29283d
--- /dev/null
+++ b/drivers/pwm/pwm-sifive.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2018 SiFive
+ * For SiFive's PWM IP block documentation please refer Chapter 14 of
+ * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we cannot prevent in
+ *   software that the output might produce a period with mixed
+ *   settings (new period length and old duty cycle).
+ * - The hardware cannot generate a 100% duty cycle.
+ * - The hardware generaets only inverted output.
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+/* Register offsets */
+#define PWM_SIFIVE_PWMCFG		0x0
+#define PWM_SIFIVE_PWMCOUNT		0x8
+#define PWM_SIFIVE_PWMS			0x10
+#define PWM_SIFIVE_PWMCMP0		0x20
+
+/* PWMCFG fields */
+#define PWM_SIFIVE_PWMCFG_SCALE		0
+#define PWM_SIFIVE_PWMCFG_STICKY	8
+#define PWM_SIFIVE_PWMCFG_ZERO_CMP	9
+#define PWM_SIFIVE_PWMCFG_DEGLITCH	10
+#define PWM_SIFIVE_PWMCFG_EN_ALWAYS	BIT(12)
+#define PWM_SIFIVE_PWMCFG_EN_ONCE	13
+#define PWM_SIFIVE_PWMCFG_CENTER	16
+#define PWM_SIFIVE_PWMCFG_GANG		24
+#define PWM_SIFIVE_PWMCFG_IP		28
+
+/* PWM_SIFIVE_SIZE_PWMCMP is used to calculate offset for pwmcmpX registers */
+#define PWM_SIFIVE_SIZE_PWMCMP		4
+#define PWM_SIFIVE_CMPWIDTH		16
+
+struct pwm_sifive_ddata {
+	struct pwm_chip	chip;
+	struct mutex lock; /* lock to protect user_count and active_user */
+	struct notifier_block notifier;
+	struct clk *clk;
+	void __iomem *regs;
+	unsigned int real_period;
+	int user_count;
+	int active_user;
+};
+
+static inline
+struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *c)
+{
+	return container_of(c, struct pwm_sifive_ddata, chip);
+}
+
+static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *dev)
+{
+	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
+
+	mutex_lock(&pwm->lock);
+	pwm->user_count++;
+	mutex_unlock(&pwm->lock);
+
+	return 0;
+}
+
+static void pwm_sifive_free(struct pwm_chip *chip, struct pwm_device *dev)
+{
+	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
+
+	mutex_lock(&pwm->lock);
+	pwm->user_count--;
+	mutex_unlock(&pwm->lock);
+}
+
+static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
+				    unsigned long rate)
+{
+	u32 val;
+	unsigned long num;
+	/* (1 << (PWM_SIFIVE_CMPWIDTH+scale)) * 10^9/rate = real_period */
+	unsigned long scale_pow =
+			div64_ul(pwm->real_period * (u64)rate, NSEC_PER_SEC);
+	int scale = clamp(ilog2(scale_pow) - PWM_SIFIVE_CMPWIDTH, 0, 0xf);
+
+	val = PWM_SIFIVE_PWMCFG_EN_ALWAYS | (scale << PWM_SIFIVE_PWMCFG_SCALE);
+	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
+
+	/* As scale <= 15 the shift operation cannot overflow. */
+	num = 1000000000ULL << (PWM_SIFIVE_CMPWIDTH + scale);
+	pwm->real_period = div64_ul(num, rate);
+	dev_dbg(pwm->chip.dev, "New real_period = %u ns\n", pwm->real_period);
+}
+
+static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *dev,
+				 struct pwm_state *state)
+{
+	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
+	u32 duty, val;
+	unsigned long num;
+
+	duty = readl(pwm->regs + PWM_SIFIVE_PWMCMP0 +
+		     dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
+
+	val = readl(pwm->regs + PWM_SIFIVE_PWMCFG);
+	state->enabled = duty > 0;
+
+	val &= 0x0F;
+	num = 1000000000ULL << (PWM_SIFIVE_CMPWIDTH + val);
+	pwm->real_period = div64_ul(num, clk_get_rate(pwm->clk));
+
+	state->period = pwm->real_period;
+	state->duty_cycle =
+		(u64)duty * pwm->real_period >> PWM_SIFIVE_CMPWIDTH;
+	state->polarity = PWM_POLARITY_INVERSED;
+}
+
+static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
+{
+	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
+	int val, ret;
+
+	if (enable) {
+		ret = clk_enable(pwm->clk);
+		if (ret) {
+			dev_err(pwm->chip.dev, "Enable clk failed:%d\n", ret);
+			return ret;
+		}
+	}
+
+	val = readl(pwm->regs + PWM_SIFIVE_PWMCFG);
+
+	if (enable)
+		val |= PWM_SIFIVE_PWMCFG_EN_ALWAYS;
+	else
+		val &= ~PWM_SIFIVE_PWMCFG_EN_ALWAYS;
+
+	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
+
+	if (!enable)
+		clk_disable(pwm->clk);
+
+	return 0;
+}
+
+static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *dev,
+			    struct pwm_state *state)
+{
+	struct pwm_sifive_ddata *pwm = pwm_sifive_chip_to_ddata(chip);
+	unsigned int duty_cycle, x;
+	u32 frac;
+	struct pwm_state cur_state;
+	bool enabled;
+	int ret;
+	unsigned long num;
+
+	pwm_get_state(dev, &cur_state);
+	enabled = cur_state.enabled;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (state->period != cur_state.period) {
+		mutex_lock(&pwm->lock);
+		if (pwm->user_count != 1) {
+			mutex_unlock(&pwm->lock);
+			return -EINVAL;
+		}
+		pwm->real_period = state->period;
+		pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
+		mutex_unlock(&pwm->lock);
+	}
+
+	duty_cycle = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycle = 0;
+
+	x = 1U << PWM_SIFIVE_CMPWIDTH;
+	num = (u64)duty_cycle * x + x / 2;
+	frac = div_u64(num, state->period);
+	/* The hardware cannot generate a 100% duty cycle */
+	frac = min(frac, x - 1);
+
+	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 +
+	       dev->hwpwm * PWM_SIFIVE_SIZE_PWMCMP);
+
+	if (!state->enabled && enabled) {
+		mutex_lock(&pwm->lock);
+		if (pwm->active_user == 1) {
+			ret = pwm_sifive_enable(chip, false);
+			if (ret) {
+				mutex_unlock(&pwm->lock);
+				return ret;
+			}
+		}
+		pwm->active_user--;
+		mutex_unlock(&pwm->lock);
+		enabled = false;
+	}
+
+	if (state->enabled != enabled) {
+		mutex_lock(&pwm->lock);
+		if (pwm->active_user == 0) {
+			ret = pwm_sifive_enable(chip, state->enabled);
+			if (ret) {
+				mutex_unlock(&pwm->lock);
+				return ret;
+			}
+		}
+		pwm->active_user++;
+		mutex_unlock(&pwm->lock);
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_sifive_ops = {
+	.request = pwm_sifive_request,
+	.free = pwm_sifive_free,
+	.get_state = pwm_sifive_get_state,
+	.apply = pwm_sifive_apply,
+	.owner = THIS_MODULE,
+};
+
+static int pwm_sifive_clock_notifier(struct notifier_block *nb,
+				     unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct pwm_sifive_ddata *pwm =
+		container_of(nb, struct pwm_sifive_ddata, notifier);
+
+	if (event == POST_RATE_CHANGE)
+		pwm_sifive_update_clock(pwm, ndata->new_rate);
+
+	return NOTIFY_OK;
+}
+
+static int pwm_sifive_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_sifive_ddata *pwm;
+	struct pwm_chip *chip;
+	struct resource *res;
+	int ret;
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	mutex_init(&pwm->lock);
+	chip = &pwm->chip;
+	chip->dev = dev;
+	chip->ops = &pwm_sifive_ops;
+	chip->of_pwm_n_cells = 3;
+	chip->base = -1;
+	chip->npwm = 4;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwm->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(pwm->regs)) {
+		dev_err(dev, "Unable to map IO resources\n");
+		return PTR_ERR(pwm->regs);
+	}
+
+	pwm->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwm->clk)) {
+		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Unable to find controller clock\n");
+		return PTR_ERR(pwm->clk);
+	}
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock for pwm: %d\n", ret);
+		return ret;
+	}
+
+	/* Watch for changes to underlying clock frequency */
+	pwm->notifier.notifier_call = pwm_sifive_clock_notifier;
+	ret = clk_notifier_register(pwm->clk, &pwm->notifier);
+	if (ret) {
+		dev_err(dev, "failed to register clock notifier: %d\n", ret);
+		goto disable_clk;
+	}
+
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "cannot register PWM: %d\n", ret);
+		goto unregister_clk;
+	}
+
+	/* Enable PWM */
+	ret = pwm_sifive_enable(chip, true);
+	if (ret)
+		dev_warn(dev, "cannot Enable PWM: %d\n", ret);
+
+	if (!pwm_is_enabled(pwm->chip.pwms))
+		clk_disable(pwm->clk);
+
+	platform_set_drvdata(pdev, pwm);
+	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
+
+	return 0;
+
+unregister_clk:
+	clk_notifier_unregister(pwm->clk, &pwm->notifier);
+disable_clk:
+	clk_disable_unprepare(pwm->clk);
+
+	return ret;
+}
+
+static int pwm_sifive_remove(struct platform_device *dev)
+{
+	struct pwm_sifive_ddata *pwm = platform_get_drvdata(dev);
+	int ret;
+
+	ret = pwmchip_remove(&pwm->chip);
+	clk_notifier_unregister(pwm->clk, &pwm->notifier);
+	if (!pwm_is_enabled(pwm->chip.pwms))
+		clk_disable(pwm->clk);
+	clk_unprepare(pwm->clk);
+	return ret;
+}
+
+static const struct of_device_id pwm_sifive_of_match[] = {
+	{ .compatible = "sifive,pwm0" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pwm_sifive_of_match);
+
+static struct platform_driver pwm_sifive_driver = {
+	.probe = pwm_sifive_probe,
+	.remove = pwm_sifive_remove,
+	.driver = {
+		.name = "pwm-sifive",
+		.of_match_table = pwm_sifive_of_match,
+	},
+};
+module_platform_driver(pwm_sifive_driver);
+
+MODULE_DESCRIPTION("SiFive PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1


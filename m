Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E934C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AC020880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R7jDvlbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfA2MDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:03:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36089 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfA2Lnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so9547778pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OTY2BuJSQoKUfD3g6smJXjeUei0ZivPpGTG9C8k2s60=;
        b=R7jDvlbFl9hLE2f6dK/HrO6j5AMtEIVrIhPrXk1VR29aOVuXtZ5mr8KuHkb/40IN/n
         cVP0fuP/Buf9WdZZsbvG434qbN6oaGP1v7dFB2c4Ul8EfDdg1Riq/+/otWq6Jm/GrQLv
         fdH5SSlrMcTIA6wPCHAZiwbSozrYDQB6huuXuR+9vtEmT1DII7WVrXXUH1NRn64Rxqf7
         DUYi4RigB8MgMctjUGnWT52SAAYHlBSApUX+MQLx9ERIyWOnZ8704EqCI5+qghiapa93
         c6vcM+6i6jewvlb0aR2daPGnLZzHu2q2JsCcSMtsR4XTUJFWo+CavPazDHnbcDeNmT4n
         tFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OTY2BuJSQoKUfD3g6smJXjeUei0ZivPpGTG9C8k2s60=;
        b=VDQfyfJiX+y4eY8W42B58FSDIaQhKvDsTxf3kz+a99fEJhrOna35EUAIeb5GbFmUDY
         h0TqQaeebGGJae8lkEv3yL34dG4Tvas/aR/Xq0ZqxxB8GumY6Uc4QZromqXvh7UshZiy
         3Tr9CGAx2n2WM4GRaodbkrLHhoW7O3PqNN/0MCrjZgz1g3T50JjE+dLO6XH0iwgHfOe6
         vOgsNM7r5EJp29pLA+HwxVUzhfMuSxLA/2Iby7gXgcwY5KQsGbeDaJle42TVveICapFn
         QYbSHdgS6AC8bYoGD9ZAtQfPQJtOBU5IYrYaTHRxOHfnCA7I6IGL+wed176G/TT27bOb
         36Jg==
X-Gm-Message-State: AJcUukfuFWqzUAosgKr1BExDyEe5RW9PSBTTegxVw1IVSB7O1HzimPEI
        hcPcYj2QPVk1ejEExjfr5DGAwQ==
X-Google-Smtp-Source: ALg8bN7Uk8F2yM9GpfvElQDXCJR194zrJ8z6K9iafzMNmeBHiypGtGBH92+n2CdSHXJLIfwV16DGTQ==
X-Received: by 2002:a63:d005:: with SMTP id z5mr23317265pgf.64.1548762229778;
        Tue, 29 Jan 2019 03:43:49 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p2sm48755717pfp.125.2019.01.29.03.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 03:43:49 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v5 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date:   Tue, 29 Jan 2019 17:13:19 +0530
Message-Id: <1548762199-7065-3-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
References: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
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
 drivers/pwm/pwm-sifive.c | 261 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)
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
index 0000000..2b516f7
--- /dev/null
+++ b/drivers/pwm/pwm-sifive.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2018 SiFive
+ * For SiFive's PWM IP block documentation please refer Chapter 14 of
+ * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
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
+#define PWM_SIFIVE_PWMCFG_EN_ALWAYS	12
+#define PWM_SIFIVE_PWMCFG_EN_ONCE	13
+#define PWM_SIFIVE_PWMCFG_CENTER	16
+#define PWM_SIFIVE_PWMCFG_GANG		24
+#define PWM_SIFIVE_PWMCFG_IP		28
+
+/* SIZE_PWMCMP is used to calculate the offset for pwmcmpX registers */
+#define SIZE_PWMCMP		4
+#define CMPWIDTH		16
+
+struct pwm_sifive_ddata {
+	struct pwm_chip	chip;
+	struct notifier_block notifier;
+	struct clk *clk;
+	void __iomem *regs;
+	unsigned int approx_period;
+	unsigned int real_period;
+};
+
+static inline struct pwm_sifive_ddata *to_pwm_sifive_chip(struct pwm_chip *c)
+{
+	return container_of(c, struct pwm_sifive_ddata, chip);
+}
+
+static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *dev,
+				 struct pwm_state *state)
+{
+	struct pwm_sifive_ddata *pwm = to_pwm_sifive_chip(chip);
+	u32 duty;
+
+	duty = readl(pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
+
+	state->period = pwm->real_period;
+	state->duty_cycle = ((u64)duty * pwm->real_period) >> CMPWIDTH;
+	state->polarity = PWM_POLARITY_INVERSED;
+	state->enabled = duty > 0;
+}
+
+static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *dev,
+			    struct pwm_state *state)
+{
+	struct pwm_sifive_ddata *pwm = to_pwm_sifive_chip(chip);
+	unsigned int duty_cycle;
+	u32 frac, val;
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (state->period != pwm->real_period)
+		return -EINVAL;
+
+	duty_cycle = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycle = 0;
+
+	frac = div_u64((u64)duty_cycle * 0xFFFF, state->period);
+	frac = min(frac, 0xFFFFU);
+
+	val = readl(pwm->regs + PWM_SIFIVE_PWMCFG);
+	val |= (1 << PWM_SIFIVE_PWMCFG_DEGLITCH);
+	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
+
+	writel(frac, pwm->regs + PWM_SIFIVE_PWMCMP0 + dev->hwpwm * SIZE_PWMCMP);
+
+	val &= ~(1 << PWM_SIFIVE_PWMCFG_DEGLITCH);
+	writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
+
+	pwm_sifive_get_state(chip, dev, state);
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_sifive_ops = {
+	.get_state = pwm_sifive_get_state,
+	.apply = pwm_sifive_apply,
+	.owner = THIS_MODULE,
+};
+
+static struct pwm_device *pwm_sifive_xlate(struct pwm_chip *chip,
+					   const struct of_phandle_args *args)
+{
+	struct pwm_sifive_ddata *pwm = to_pwm_sifive_chip(chip);
+	struct pwm_device *dev;
+
+	if (args->args[0] >= chip->npwm)
+		return ERR_PTR(-EINVAL);
+
+	dev = pwm_request_from_chip(chip, args->args[0], NULL);
+	if (IS_ERR(dev))
+		return dev;
+
+	/* The period cannot be changed on a per-PWM basis */
+	dev->args.period = pwm->real_period;
+	dev->args.polarity = PWM_POLARITY_NORMAL;
+	if (args->args[1] & PWM_POLARITY_INVERSED)
+		dev->args.polarity = PWM_POLARITY_INVERSED;
+
+	return dev;
+}
+
+static void pwm_sifive_update_clock(struct pwm_sifive_ddata *pwm,
+				    unsigned long rate)
+{
+	/* (1 << (16+scale)) * 10^9/rate = real_period */
+	unsigned long scale_pow =
+			(pwm->approx_period * (u64)rate) / NSEC_PER_SEC;
+	int scale = clamp(ilog2(scale_pow) - 16, 0, 0xf);
+
+	writel((1 << PWM_SIFIVE_PWMCFG_EN_ALWAYS) | (scale <<
+	       PWM_SIFIVE_PWMCFG_SCALE), pwm->regs + PWM_SIFIVE_PWMCFG);
+
+	/* As scale <= 15 the shift operation cannot overflow. */
+	pwm->real_period = div64_ul(1000000000ULL << (16 + scale), rate);
+	dev_dbg(pwm->chip.dev, "New real_period = %u ns\n", pwm->real_period);
+}
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
+	struct device_node *node = pdev->dev.of_node;
+	struct pwm_sifive_ddata *pwm;
+	struct pwm_chip *chip;
+	struct resource *res;
+	int ret;
+
+	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	chip = &pwm->chip;
+	chip->dev = dev;
+	chip->ops = &pwm_sifive_ops;
+	chip->of_xlate = pwm_sifive_xlate;
+	chip->of_pwm_n_cells = 2;
+	chip->base = -1;
+	chip->npwm = 4;
+
+	ret = of_property_read_u32(node, "sifive,period-ns",
+				   &pwm->approx_period);
+
+	if (ret < 0) {
+		dev_err(dev, "Unable to read sifive,period-ns from DTS\n");
+		return ret;
+	}
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
+	/* Initialize PWM config */
+	pwm_sifive_update_clock(pwm, clk_get_rate(pwm->clk));
+
+	ret = pwmchip_add(chip);
+	if (ret < 0) {
+		dev_err(dev, "cannot register PWM: %d\n", ret);
+		goto unregister_clk;
+	}
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
+	clk_disable_unprepare(pwm->clk);
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


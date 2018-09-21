Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC068C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4874421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqjKw20O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4874421547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390379AbeIUQOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40539 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbeIUQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207-v6so2622978wme.5;
        Fri, 21 Sep 2018 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=he3Ec7sexXHsgPdIRlBtWqRvsvBcL2achJtpOO06EBQ=;
        b=iqjKw20O/VZpUpkf1NIz22DKHtEknxpbkn+8vwuxzXsxtUYbMaLdl6IQTJCqkDCnRh
         EgGS9dww3u3POhMBpPbkEI03YBznRoPYPm1ljMqNlu6nfwzEUXFHX47CxEe9zViRoiPA
         qePKCzwJKlSL3M510Bq/+9jLf0MpV8EgHdIKjLh+xgPz1j3875ctWS1jorb1+SedIkzJ
         2QMvH91eAGkCEQQ01LI4hZDZ5f4eycwLILDcaqJwV46LQz2gVLXO7bwa4sclokOpGe6q
         cauw7l/DaEMVNdbtoch4C2sjo4JVB81E2mNB+40kWMi05omXDWRBN+8EhFd6Z5QO5u05
         4X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=he3Ec7sexXHsgPdIRlBtWqRvsvBcL2achJtpOO06EBQ=;
        b=jWMCaZqfXeELHB9CxPgaCuuMxPgByqKAk8+vKScaa1qElEij0qQ0SMRSEYMNQFDY0M
         tKZRzT5xEZqoGtzZcQv1RXOs65vsysmnzCVBAQzQH0cf1iXMOrh6QYDpW7fmep6S5ZtV
         6x2cyqMcao9nzrql6kWqbZlusnnOCu6R1g2tMbEA/L+BqCKg44op1sU9ZtcjFVSxQ2ej
         M0yJg5UYrAfX+53kg8CS9JnQlMoIjudCr9fkanuI7awuQh0R6xMKTks9pJXgD81Kh+im
         iwlysNUlJvKH45QBb0hS37YO8e6KKZFE5oHSH8iEsfGzTgna3j4XcyEPgPWen1qBx/py
         WDGA==
X-Gm-Message-State: APzg51BS2EwavOLLSViXxkJhrYQP9iHSuVg4IEJtei70ZCqi17wtGO9F
        oS0V1McA5UZU6fiIDkOm0ko=
X-Google-Smtp-Source: ANB0Vda8vZop2bpLWosQOTHYuqT7nWdEow2QZ2xbf5xzo8TL9/3yTc8CjNQn1/j4LZVeulkvwEF8iQ==
X-Received: by 2002:a1c:6705:: with SMTP id b5-v6mr6695507wmc.78.1537525553272;
        Fri, 21 Sep 2018 03:25:53 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id 60-v6sm31243592wre.82.2018.09.21.03.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:52 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] soc/tegra: pmc: Add wake event support
Date:   Fri, 21 Sep 2018 12:25:40 +0200
Message-Id: <20180921102546.12745-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921102546.12745-1-thierry.reding@gmail.com>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The power management controller has top-level controls that allow
certain interrupts (such as from the RTC or a subset of GPIOs) to
wake the system from sleep. Implement infrastructure to support
these wake events.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 230 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 230 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index c08f0b942020..eeef5a1f2837 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -29,9 +29,12 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
+#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinconf.h>
@@ -48,6 +51,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/pmc.h>
 
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 
 #define PMC_CNTRL			0x0
@@ -126,6 +130,18 @@
 #define GPU_RG_CNTRL			0x2d4
 
 /* Tegra186 and later */
+#define WAKE_AOWAKE_CNTRL(x) (0x000 + ((x) << 2))
+#define WAKE_AOWAKE_CNTRL_LEVEL (1 << 3)
+#define WAKE_AOWAKE_MASK_W(x) (0x180 + ((x) << 2))
+#define WAKE_AOWAKE_MASK_R(x) (0x300 + ((x) << 2))
+#define WAKE_AOWAKE_STATUS_W(x) (0x30c + ((x) << 2))
+#define WAKE_AOWAKE_STATUS_R(x) (0x48c + ((x) << 2))
+#define WAKE_AOWAKE_TIER1_CTRL 0x4ac
+#define WAKE_AOWAKE_TIER2_CTRL 0x4b0
+#define WAKE_AOWAKE_TIER0_ROUTING(x) (0x4b4 + ((x) << 2))
+#define WAKE_AOWAKE_TIER1_ROUTING(x) (0x4c0 + ((x) << 2))
+#define WAKE_AOWAKE_TIER2_ROUTING(x) (0x4cc + ((x) << 2))
+
 #define WAKE_AOWAKE_CTRL 0x4f4
 #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
 
@@ -153,6 +169,38 @@ struct tegra_pmc_regs {
 	unsigned int dpd2_status;
 };
 
+struct tegra_wake_event {
+	const char *name;
+	unsigned int id;
+	unsigned int irq;
+	struct {
+		unsigned int instance;
+		unsigned int pin;
+	} gpio;
+};
+
+#define TEGRA_WAKE_IRQ(_name, _id, _irq)		\
+	{						\
+		.name = _name,				\
+		.id = _id,				\
+		.irq = _irq,				\
+		.gpio = {				\
+			.instance = UINT_MAX,		\
+			.pin = UINT_MAX,		\
+		},					\
+	}
+
+#define TEGRA_WAKE_GPIO(_name, _id, _instance, _pin)	\
+	{						\
+		.name = _name,				\
+		.id = _id,				\
+		.irq = 0,				\
+		.gpio = {				\
+			.instance = _instance,		\
+			.pin = _pin,			\
+		},					\
+	}
+
 struct tegra_pmc_soc {
 	unsigned int num_powergates;
 	const char *const *powergates;
@@ -175,6 +223,9 @@ struct tegra_pmc_soc {
 	void (*setup_irq_polarity)(struct tegra_pmc *pmc,
 				   struct device_node *np,
 				   bool invert);
+
+	const struct tegra_wake_event *wake_events;
+	unsigned int num_wake_events;
 };
 
 /**
@@ -230,6 +281,9 @@ struct tegra_pmc {
 	struct mutex powergates_lock;
 
 	struct pinctrl_dev *pctl_dev;
+
+	struct irq_domain *domain;
+	struct irq_chip irq;
 };
 
 static struct tegra_pmc *pmc = &(struct tegra_pmc) {
@@ -1543,6 +1597,178 @@ static int tegra_pmc_pinctrl_init(struct tegra_pmc *pmc)
 	return err;
 }
 
+static int tegra_pmc_irq_translate(struct irq_domain *domain,
+				   struct irq_fwspec *fwspec,
+				   unsigned long *hwirq,
+				   unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int tegra_pmc_irq_alloc(struct irq_domain *domain, unsigned int virq,
+			       unsigned int num_irqs, void *data)
+{
+	struct tegra_pmc *pmc = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	unsigned int i;
+	int err = 0;
+
+	for (i = 0; i < pmc->soc->num_wake_events; i++) {
+		const struct tegra_wake_event *event = &pmc->soc->wake_events[i];
+
+		if (fwspec->param_count == 2) {
+			struct irq_fwspec spec;
+
+			if (event->id != fwspec->param[0])
+				continue;
+
+			err = irq_domain_set_hwirq_and_chip(domain, virq,
+							    event->id,
+							    &pmc->irq, pmc);
+			if (err < 0)
+				break;
+
+			spec.fwnode = &pmc->dev->of_node->fwnode;
+			spec.param_count = 3;
+			spec.param[0] = GIC_SPI;
+			spec.param[1] = event->irq;
+			spec.param[2] = fwspec->param[1];
+
+			err = irq_domain_alloc_irqs_parent(domain, virq,
+							   num_irqs, &spec);
+
+			break;
+		}
+
+		if (fwspec->param_count == 3) {
+			if (event->gpio.instance != fwspec->param[0] ||
+			    event->gpio.pin != fwspec->param[1])
+				continue;
+
+			err = irq_domain_set_hwirq_and_chip(domain, virq,
+							    event->id,
+							    &pmc->irq, pmc);
+
+			break;
+		}
+	}
+
+	if (i == pmc->soc->num_wake_events)
+		err = irq_domain_set_hwirq_and_chip(domain, virq, ULONG_MAX,
+						    &pmc->irq, pmc);
+
+	return err;
+}
+
+static const struct irq_domain_ops tegra_pmc_irq_domain_ops = {
+	.translate = tegra_pmc_irq_translate,
+	.alloc = tegra_pmc_irq_alloc,
+};
+
+static int tegra_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
+	unsigned int offset, bit;
+	u32 value;
+
+	offset = data->hwirq / 32;
+	bit = data->hwirq % 32;
+
+	/* clear wake status */
+	writel(0x1, pmc->wake + WAKE_AOWAKE_STATUS_W(data->hwirq));
+
+	/* route wake to tier 2 (XXX conditionally enable this) */
+	value = readl(pmc->wake + WAKE_AOWAKE_TIER2_CTRL);
+	writel(0x1, pmc->wake + WAKE_AOWAKE_TIER2_CTRL);
+
+	value = readl(pmc->wake + WAKE_AOWAKE_TIER2_ROUTING(offset));
+
+	if (!on)
+		value &= ~(1 << bit);
+	else
+		value |= 1 << bit;
+
+	writel(value, pmc->wake + WAKE_AOWAKE_TIER2_ROUTING(offset));
+
+	/* enable wakeup event */
+	writel(!!on, pmc->wake + WAKE_AOWAKE_MASK_W(data->hwirq));
+
+	return 0;
+}
+
+static int tegra_pmc_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
+	u32 value;
+
+	if (data->hwirq == ULONG_MAX)
+		return 0;
+
+	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		value |= WAKE_AOWAKE_CNTRL_LEVEL;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_LOW:
+		value &= ~WAKE_AOWAKE_CNTRL_LEVEL;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
+		value ^= WAKE_AOWAKE_CNTRL_LEVEL;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
+
+	return 0;
+}
+
+static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
+{
+	struct irq_domain *parent = NULL;
+	struct device_node *np;
+
+	np = of_irq_find_parent(pmc->dev->of_node);
+	if (np) {
+		parent = irq_find_host(np);
+		of_node_put(np);
+	}
+
+	if (parent) {
+		pmc->irq.name = dev_name(pmc->dev);
+		pmc->irq.irq_mask = irq_chip_mask_parent;
+		pmc->irq.irq_unmask = irq_chip_unmask_parent;
+		pmc->irq.irq_eoi = irq_chip_eoi_parent;
+		pmc->irq.irq_set_affinity = irq_chip_set_affinity_parent;
+		pmc->irq.irq_set_type = tegra_pmc_irq_set_type;
+		pmc->irq.irq_set_wake = tegra_pmc_irq_set_wake;
+
+		pmc->domain = irq_domain_add_hierarchy(parent, 0, 96,
+						       pmc->dev->of_node,
+						       &tegra_pmc_irq_domain_ops,
+						       pmc);
+		if (!pmc->domain) {
+			dev_err(pmc->dev, "failed to allocate domain\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int tegra_pmc_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -1629,6 +1855,10 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	if (err)
 		goto cleanup_restart_handler;
 
+	err = tegra_pmc_irq_init(pmc);
+	if (err < 0)
+		goto cleanup_restart_handler;
+
 	mutex_lock(&pmc->powergates_lock);
 	iounmap(pmc->base);
 	pmc->base = base;
-- 
2.19.0


Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6C4C18E01
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7E92145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U14rOLFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7E92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbeK3EJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:09:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39802 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbeK3EJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:09:28 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so2505972edt.6;
        Thu, 29 Nov 2018 09:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ix64ba3qE6bf56FtJQQ46GtQUtqu2IsrVRbRUpi4nKs=;
        b=U14rOLFiU1eTuMNpchYkXa2z+fnYfOCgkcutaiaBJuJYUeOwjKpatTpiX+ITS5w3QS
         8jQQiqeLCJOML9d+oJHHm49jYv8wS+rL31sFzJhJDbYiOcqvhue+q5mJcuECQFHGJUq9
         5BcXJbCbIvvMl0EVpxSglanv2AiAnUU33CV40H/k3ZZqB/GhAt3wJ1FD+2Zc+nwdJWbn
         hfnkLC44Nu71lL7Cz7oMV90cgIqi6ETINp51g7R90rU8OcFywxMvbdu/S/FjSQoS6U3q
         aHfHpEPYnggFT6hiFoBMlNwZe7TgvBrBd2bEYz+NGuwvnnvPfQUN1WxKFUqvHTBMZmr6
         xFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ix64ba3qE6bf56FtJQQ46GtQUtqu2IsrVRbRUpi4nKs=;
        b=KOZ5iwuAic6BiTRktZFszDHTBBQ5DgfT26CoQN9XXcySM3Rx962BJ6UsQ6DpKe2zLj
         lX8SrhyNNjajgQ1oQK2j8g+ve9O9DsHtOZRYWYkG+6+HWy1I88VrLnFq0ACZaNWvtWxG
         q354bQe4g8mHf0JsS5i++kdtfpJsKhrgZVVKvwQaHD5ZIm6NrqJoJHzqBDDE9Po/lCyZ
         5m9G3gE5ap8a856yg549xqeqFhPUO1fuAbbrT6rTU7w9AWnlsYUFRmIesfMRRq3DORCK
         z4KPuesFIpWlFerbyCTmpF62MTGaJQNfe3sf2Ku0mSzZgQ3V/L05LEV9JWQbhRqgizCB
         reFw==
X-Gm-Message-State: AA+aEWYuT5FZxDjET3wDS1EuJDqpbWfDDUCa+MK+DLot1mNo4tBoL7iM
        knRCiYzlp5JxY6LZwbQSIrrVPYu1
X-Google-Smtp-Source: AFSGD/VcQPETQDSiOLcGk8SmEYrE6RUimeNpamJWhOl5unSwh1sZAW6S8WBEypX+D4zkEU3Nz0XB6Q==
X-Received: by 2002:a50:b006:: with SMTP id i6mr2402428edd.84.1543511002889;
        Thu, 29 Nov 2018 09:03:22 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w28sm779656edd.38.2018.11.29.09.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:03:22 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] gpio: tegra186: Use valid mask instead of sparse number space
Date:   Thu, 29 Nov 2018 18:03:12 +0100
Message-Id: <20181129170312.23625-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129170312.23625-1-thierry.reding@gmail.com>
References: <20181129170312.23625-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

While the sparse number space has the advantage of only providing (and
therefore allocating) the GPIOs (and interrupts) that really exist for
the given SoC, it also requires special cases in various callbacks.

Using the valid masks for GPIOs and interrupts enables reusing more of
the code provided by gpiolib at the expense of allocating more GPIOs
and interrupts than necessary.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 171 ++++++++++++-----------------------
 1 file changed, 59 insertions(+), 112 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 1215e08ffe02..69bcc057db26 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -70,35 +70,12 @@ struct tegra_gpio {
 	void __iomem *base;
 };
 
-static const struct tegra_gpio_port *
-tegra186_gpio_get_port(struct tegra_gpio *gpio, unsigned int *pin)
-{
-	unsigned int start = 0, i;
-
-	for (i = 0; i < gpio->soc->num_ports; i++) {
-		const struct tegra_gpio_port *port = &gpio->soc->ports[i];
-
-		if (*pin >= start && *pin < start + port->pins) {
-			*pin -= start;
-			return port;
-		}
-
-		start += port->pins;
-	}
-
-	return NULL;
-}
-
 static void __iomem *tegra186_gpio_get_base(struct tegra_gpio *gpio,
 					    unsigned int pin)
 {
-	const struct tegra_gpio_port *port;
-
-	port = tegra186_gpio_get_port(gpio, &pin);
-	if (!port)
-		return NULL;
+	const struct tegra_gpio_port *port = &gpio->soc->ports[pin / 8];
 
-	return gpio->base + port->offset + pin * 0x20;
+	return gpio->base + port->offset + (pin % 8) * 0x20;
 }
 
 static int tegra186_gpio_get_direction(struct gpio_chip *chip,
@@ -208,68 +185,6 @@ static void tegra186_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	writel(value, base + TEGRA186_GPIO_OUTPUT_VALUE);
 }
 
-static int tegra186_gpio_of_xlate(struct gpio_chip *chip,
-				  const struct of_phandle_args *spec,
-				  u32 *flags)
-{
-	struct tegra_gpio *gpio = gpiochip_get_data(chip);
-	unsigned int port, pin, i, offset = 0;
-
-	if (WARN_ON(chip->of_gpio_n_cells < 2))
-		return -EINVAL;
-
-	if (WARN_ON(spec->args_count < chip->of_gpio_n_cells))
-		return -EINVAL;
-
-	port = spec->args[0] / 8;
-	pin = spec->args[0] % 8;
-
-	if (port >= gpio->soc->num_ports) {
-		dev_err(chip->parent, "invalid port number: %u\n", port);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < port; i++)
-		offset += gpio->soc->ports[i].pins;
-
-	if (flags)
-		*flags = spec->args[1];
-
-	return offset + pin;
-}
-
-static int tegra186_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
-{
-	struct tegra_gpio *gpio = gpiochip_get_data(chip);
-	struct irq_domain *domain = chip->irq.domain;
-
-	if (!gpiochip_irqchip_irq_valid(chip, offset))
-		return -ENXIO;
-
-	if (irq_domain_is_hierarchy(domain)) {
-		struct irq_fwspec spec;
-		unsigned int i;
-
-		for (i = 0; i < gpio->soc->num_ports; i++) {
-			if (offset < gpio->soc->ports[i].pins)
-				break;
-
-			offset -= gpio->soc->ports[i].pins;
-		}
-
-		offset += i * 8;
-
-		spec.fwnode = domain->fwnode;
-		spec.param_count = 2;
-		spec.param[0] = offset;
-		spec.param[1] = 0;
-
-		return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec);
-	}
-
-	return irq_create_mapping(domain, offset);
-}
-
 static void tegra186_irq_ack(struct irq_data *data)
 {
 	struct tegra_gpio *gpio = irq_data_get_irq_chip_data(data);
@@ -372,7 +287,7 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
 	struct irq_domain *domain = gpio->gpio.irq.domain;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int parent = irq_desc_get_irq(desc);
-	unsigned int i, offset = 0;
+	unsigned int i;
 
 	chained_irq_enter(chip, desc);
 
@@ -384,20 +299,17 @@ static void tegra186_gpio_irq(struct irq_desc *desc)
 
 		/* skip ports that are not associated with this controller */
 		if (parent != gpio->irq[port->irq])
-			goto skip;
+			continue;
 
 		value = readl(base + TEGRA186_GPIO_INTERRUPT_STATUS(1));
 
 		for_each_set_bit(pin, &value, port->pins) {
-			irq = irq_find_mapping(domain, offset + pin);
+			irq = irq_find_mapping(domain, i * 8 + pin);
 			if (WARN_ON(irq == 0))
 				continue;
 
 			generic_handle_irq(irq);
 		}
-
-skip:
-		offset += port->pins;
 	}
 
 	chained_irq_exit(chip, desc);
@@ -409,7 +321,7 @@ static int tegra186_gpio_irq_domain_translate(struct irq_domain *domain,
 					      unsigned int *type)
 {
 	struct tegra_gpio *gpio = gpiochip_get_data(domain->host_data);
-	unsigned int port, pin, i, offset = 0;
+	unsigned int port, pin;
 
 	if (WARN_ON(gpio->gpio.of_gpio_n_cells < 2))
 		return -EINVAL;
@@ -423,11 +335,8 @@ static int tegra186_gpio_irq_domain_translate(struct irq_domain *domain,
 	if (port >= gpio->soc->num_ports)
 		return -EINVAL;
 
-	for (i = 0; i < port; i++)
-		offset += gpio->soc->ports[i].pins;
-
 	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
-	*hwirq = offset + pin;
+	*hwirq = port * 8 + pin;
 
 	return 0;
 }
@@ -466,6 +375,43 @@ static const struct irq_domain_ops tegra186_gpio_irq_domain_ops = {
 	.unmap = gpiochip_irq_unmap,
 };
 
+static void tegra186_gpio_set_valid_mask(struct tegra_gpio *gpio,
+					 unsigned long *mask)
+{
+	unsigned int i;
+
+	bitmap_zero(mask, gpio->gpio.ngpio);
+
+	for (i = 0; i < gpio->soc->num_ports; i++) {
+		const struct tegra_gpio_port *port = &gpio->soc->ports[i];
+
+		bitmap_set(mask, i * 8, port->pins);
+	}
+}
+
+static int tegra186_gpio_init_valid_mask(struct gpio_chip *chip)
+{
+	struct tegra_gpio *gpio = gpiochip_get_data(chip);
+
+	tegra186_gpio_set_valid_mask(gpio, chip->valid_mask);
+
+	return 0;
+}
+
+static unsigned long *tegra186_gpio_setup_valid_mask(struct tegra_gpio *gpio)
+{
+	unsigned long *mask;
+
+	mask = devm_kcalloc(gpio->gpio.parent, BITS_TO_LONGS(gpio->gpio.ngpio),
+			    sizeof(*mask), GFP_KERNEL);
+	if (!mask)
+		return ERR_PTR(-ENOMEM);
+
+	tegra186_gpio_set_valid_mask(gpio, mask);
+
+	return mask;
+}
+
 static const struct of_device_id tegra186_pmc_of_match[] = {
 	{ .compatible = "nvidia,tegra186-pmc" },
 	{ .compatible = "nvidia,tegra194-pmc" },
@@ -474,11 +420,11 @@ static const struct of_device_id tegra186_pmc_of_match[] = {
 
 static int tegra186_gpio_probe(struct platform_device *pdev)
 {
-	unsigned int i, j, offset;
 	struct gpio_irq_chip *irq;
 	struct tegra_gpio *gpio;
 	struct device_node *np;
 	struct resource *res;
+	unsigned int i, j;
 	char **names;
 	int err;
 
@@ -521,17 +467,15 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->gpio.get = tegra186_gpio_get,
 	gpio->gpio.set = tegra186_gpio_set;
 
+	gpio->gpio.ngpio = gpio->soc->num_ports * 8;
 	gpio->gpio.base = -1;
 
-	for (i = 0; i < gpio->soc->num_ports; i++)
-		gpio->gpio.ngpio += gpio->soc->ports[i].pins;
-
 	names = devm_kcalloc(gpio->gpio.parent, gpio->gpio.ngpio,
 			     sizeof(*names), GFP_KERNEL);
 	if (!names)
 		return -ENOMEM;
 
-	for (i = 0, offset = 0; i < gpio->soc->num_ports; i++) {
+	for (i = 0; i < gpio->soc->num_ports; i++) {
 		const struct tegra_gpio_port *port = &gpio->soc->ports[i];
 		char *name;
 
@@ -541,18 +485,17 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 			if (!name)
 				return -ENOMEM;
 
-			names[offset + j] = name;
+			names[i * 8 + j] = name;
 		}
-
-		offset += port->pins;
 	}
 
 	gpio->gpio.names = (const char * const *)names;
 
 	gpio->gpio.of_node = pdev->dev.of_node;
 	gpio->gpio.of_gpio_n_cells = 2;
-	gpio->gpio.of_xlate = tegra186_gpio_of_xlate;
-	gpio->gpio.to_irq = tegra186_gpio_to_irq;
+
+	gpio->gpio.init_valid_mask = tegra186_gpio_init_valid_mask;
+	gpio->gpio.need_valid_mask = true;
 
 	gpio->intc.name = pdev->dev.of_node->name;
 	gpio->intc.irq_ack = tegra186_irq_ack;
@@ -580,18 +523,22 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 			return -EPROBE_DEFER;
 	}
 
+	irq->valid_mask = tegra186_gpio_setup_valid_mask(gpio);
+	if (IS_ERR(irq->valid_mask))
+		return PTR_ERR(irq->valid_mask);
+
+	irq->need_valid_mask = true;
+
 	irq->map = devm_kcalloc(&pdev->dev, gpio->gpio.ngpio,
 				sizeof(*irq->map), GFP_KERNEL);
 	if (!irq->map)
 		return -ENOMEM;
 
-	for (i = 0, offset = 0; i < gpio->soc->num_ports; i++) {
+	for (i = 0; i < gpio->soc->num_ports; i++) {
 		const struct tegra_gpio_port *port = &gpio->soc->ports[i];
 
 		for (j = 0; j < port->pins; j++)
-			irq->map[offset + j] = irq->parents[port->irq];
-
-		offset += port->pins;
+			irq->map[i * 8 + j] = irq->parents[port->irq];
 	}
 
 	platform_set_drvdata(pdev, gpio);
-- 
2.19.1


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD759C169D4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1A220868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkha8kPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1A220868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeK3EJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:09:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42378 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbeK3EJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:09:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so2491760edp.9;
        Thu, 29 Nov 2018 09:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZMv/bs8gGkEcUoSwp4Btp1MlTjwqxKCbjw9I6MQ2VM=;
        b=Rkha8kPXXfjjlA775S+mbtRGzUz96ggQ0GTBkFUu/kImP+KNNfZh9YfPX6Ggyw8PTP
         hS7D0OPOWtiCZNyRgebbdn5tUI+VB2e28/B5s54Y8tDGxXWrDLf2518/r6XbSq056O/8
         ADEThB0pRoJpa53jDQ4mRclAM3GRnns8Azjw3fEJna4MWrqACSTcwWxmmRviy5zTGa6D
         yfzCh/T/Int8E5X5AtnICd33yiZLXLCk+kUdrs5ZDn7NhLzUR1FtBRYgKTLoMJwfyjp/
         +tC8R0PTLdTPn87xm41jOPSSx/SqeRmgCwZz7yhbJJWqPllLyfFUNdmvTNiR427EvzDJ
         LDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZMv/bs8gGkEcUoSwp4Btp1MlTjwqxKCbjw9I6MQ2VM=;
        b=UdJkdxnL68WDSG9duSzpDRRIEVpyNfv4QAdizZMbz9lmNsKGJrc00Vg2Za+OQ4ajfg
         azRN/2efcON7tiERRqVGW+f12ETZPilO4bLvpa2UVLjr6aRKeA5ERZnWwEn+DdeKp6By
         hH0rXKs7yaUUQdBDqirBM9incUA8OmpeH5o9U7gC7un26eB5FpPNpgE8IA4lf8jICrS1
         xMjzCZ6S4gD07SKwffZ0o3nl+wFqeFAgQrip8EByRtcknvdTM3VsewKpgUe5rjX0Dans
         TU+gIOdxEcq3dukhefXXpe4XD246yd7BbG252hPglyUKYuCNdC843dZtnx+PcQkGEvRf
         6hOw==
X-Gm-Message-State: AA+aEWaVcFK7YexTlEzEQhUSHiU0C2q1LWq2zGI+xg2xQT7omVl1AeG0
        6hc8mU3sqhk7GNBT7CMy9ZzMWug0
X-Google-Smtp-Source: AFSGD/Vi04sPZIZUrgfL/1k/FtJjHdjImh1ilbRA1/XR7ZD+/gDmYbOKGGRtLENXpNay//07kbUtnQ==
X-Received: by 2002:a50:e045:: with SMTP id g5mr2444553edl.152.1543510996152;
        Thu, 29 Nov 2018 09:03:16 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y53sm710823edd.84.2018.11.29.09.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:03:15 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] gpio: Add support for hierarchical IRQ domains
Date:   Thu, 29 Nov 2018 18:03:08 +0100
Message-Id: <20181129170312.23625-2-thierry.reding@gmail.com>
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

Hierarchical IRQ domains can be used to stack different IRQ controllers
on top of each other. One specific use-case where this can be useful is
if a power management controller has top-level controls for wakeup
interrupts. In such cases, the power management controller can be a
parent to other interrupt controllers and program additional registers
when an IRQ has its wake capability enabled or disabled.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- select IRQ_DOMAIN_HIERARCHY to avoid build failure
- move more code into the gpiolib core

 drivers/gpio/Kconfig        |  2 +-
 drivers/gpio/gpiolib.c      | 33 +++++++++++++++++++++++++++++----
 include/linux/gpio/driver.h |  6 ++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 587e5f005b61..1d8abaab09f7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -43,7 +43,7 @@ config GPIO_ACPI
 	depends on ACPI
 
 config GPIOLIB_IRQCHIP
-	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 	bool
 
 config DEBUG_GPIO
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index cd84315ad586..247ca4c1241f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1777,9 +1777,22 @@ static const struct irq_domain_ops gpiochip_domain_ops = {
 
 static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
 {
+	struct irq_domain *domain = chip->irq.domain;
+
 	if (!gpiochip_irqchip_irq_valid(chip, offset))
 		return -ENXIO;
 
+	if (irq_domain_is_hierarchy(domain)) {
+		struct irq_fwspec spec;
+
+		spec.fwnode = domain->fwnode;
+		spec.param_count = 2;
+		spec.param[0] = offset;
+		spec.param[1] = 0;
+
+		return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &spec);
+	}
+
 	return irq_create_mapping(chip->irq.domain, offset);
 }
 
@@ -1888,7 +1901,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
 		type = IRQ_TYPE_NONE;
 	}
 
-	gpiochip->to_irq = gpiochip_to_irq;
+	/*
+	 * Allow GPIO chips to override the ->to_irq() if they really need to.
+	 * This should only be very rarely needed, the majority should be fine
+	 * with gpiochip_to_irq().
+	 */
+	if (!gpiochip->to_irq)
+		gpiochip->to_irq = gpiochip_to_irq;
+
 	gpiochip->irq.default_type = type;
 	gpiochip->irq.lock_key = lock_key;
 	gpiochip->irq.request_key = request_key;
@@ -1898,9 +1918,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
 	else
 		ops = &gpiochip_domain_ops;
 
-	gpiochip->irq.domain = irq_domain_add_simple(np, gpiochip->ngpio,
-						     gpiochip->irq.first,
-						     ops, gpiochip);
+	if (gpiochip->irq.parent_domain)
+		gpiochip->irq.domain = irq_domain_add_hierarchy(gpiochip->irq.parent_domain,
+								0, gpiochip->ngpio,
+								np, ops, gpiochip);
+	else
+		gpiochip->irq.domain = irq_domain_add_simple(np, gpiochip->ngpio,
+							     gpiochip->irq.first,
+							     ops, gpiochip);
 	if (!gpiochip->irq.domain)
 		return -EINVAL;
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 9c8d5d491680..eb8b35f1d8b6 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -47,6 +47,12 @@ struct gpio_irq_chip {
 	 */
 	const struct irq_domain_ops *domain_ops;
 
+	/**
+	 * @parent_domain:
+	 *
+	 */
+	struct irq_domain *parent_domain;
+
 	/**
 	 * @handler:
 	 *
-- 
2.19.1


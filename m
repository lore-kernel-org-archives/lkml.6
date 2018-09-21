Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD5AECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7327206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAGNz1Jo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7327206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbeIUQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:14:13 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54830 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390390AbeIUQOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:14:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id c14-v6so2493696wmb.4;
        Fri, 21 Sep 2018 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uGioRpmWHw5HmBGBMYla/FtUi6hl7emhEwjHohddII=;
        b=KAGNz1JotYwpwgKedqzNuJSQpZZabk2WAg1RdGTll1ITafzjPx8xL+1RrPkDNc7vNc
         erhT6L8fB1A+hab7uAtSQDVyV4uMS0hwJ7lQ57CtZBMTw1Txoan1sf0plCFfykWJOqcT
         696kgx25ng6ctz/gTrKoQg8iUsI6jWfcxw1dx0+Zq3lnjRJ7pTL4Zo+eD7tqkFemB6Qe
         cr3XmAsWaWvrI8Fdg2TMYKgYbeyDuia2GwJ98e5A4JvnieD52cLmk4gbyZ5vrFdvTSXc
         Fa36TdtSbG5Cd81jboptQ90aKTMoEooj77pJRPIWFsBFCSfu55HKMpsYwa/gdi5Al2mh
         tk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uGioRpmWHw5HmBGBMYla/FtUi6hl7emhEwjHohddII=;
        b=AvNSIESkslfSRTHBzN5Bg6YqAbFcjw1hKS/UKRknHZWaxTo4JB3vygeiRiADTFcKb8
         76R2ZQbNjfmsEtPqV6TqHqMjS/z3TZVRhx8SUcZmsJe1tVhoXcaSqzmwr/AQr3Z61ac8
         zKzn60o7RWIvduLbhb2Fk85p8c97TGRcUw8G2XY1Fnx+wNXQQJUTbYUrN4WTqqQKjAOb
         4WQUwnRwPVMVU2kdSNPfPVEfkiz8kaprktyfBu6qcIoTJe/2bQH/lGFQQfQzLN0JgUg2
         zuPjlzKAPx/a3S6W8Moru/vfH0BN98hn0SC3IJ2XDcS1cEu2vPCxzDVAIYJRc5b0Nizz
         0pyQ==
X-Gm-Message-State: APzg51C447UqGqpC6tKCq2ysLhNbjScn1SFuzY9MWf9MT0+4bd1gP8nV
        TzKK04zycdA4HGmW2+gIqnE=
X-Google-Smtp-Source: ACcGV63EuhjidxUB6Uv8yfATh85hxgoid0pNzlBZ7CyrdBXFrfCjeK9zqiG064Y8JxRKKdxle1vpYw==
X-Received: by 2002:a1c:7704:: with SMTP id t4-v6mr6133479wmi.136.1537525557530;
        Fri, 21 Sep 2018 03:25:57 -0700 (PDT)
Received: from localhost (pD9E515A3.dip0.t-ipconnect.de. [217.229.21.163])
        by smtp.gmail.com with ESMTPSA id i125-v6sm6341423wmd.23.2018.09.21.03.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 03:25:57 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] gpio: Add support for hierarchical IRQ domains
Date:   Fri, 21 Sep 2018 12:25:43 +0200
Message-Id: <20180921102546.12745-7-thierry.reding@gmail.com>
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

Hierarchical IRQ domains can be used to stack different IRQ controllers
on top of each other. One specific use-case where this can be useful is
if a power management controller has top-level controls for wakeup
interrupts. In such cases, the power management controller can be a
parent to other interrupt controllers and program additional registers
when an IRQ has its wake capability enabled or disabled.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpiolib.c      | 15 +++++++++++----
 include/linux/gpio/driver.h |  6 ++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a53d17745d21..94146093ee95 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1918,7 +1918,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
 		type = IRQ_TYPE_NONE;
 	}
 
-	gpiochip->to_irq = gpiochip_to_irq;
+	if (!gpiochip->to_irq)
+		gpiochip->to_irq = gpiochip_to_irq;
+
 	gpiochip->irq.default_type = type;
 	gpiochip->irq.lock_key = lock_key;
 	gpiochip->irq.request_key = request_key;
@@ -1928,9 +1930,14 @@ static int gpiochip_add_irqchip(struct gpio_chip *gpiochip,
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
index d8dcd0e44cab..fcd09a396d76 100644
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
2.19.0


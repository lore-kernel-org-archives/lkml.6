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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BA6C18DF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F65A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anUATYX4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F65A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbeK3EJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:09:24 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33848 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbeK3EJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:09:23 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so2525218ede.1;
        Thu, 29 Nov 2018 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bNOZAm8mLmN4GrWYE3MVavhv9O35OLHpBIsgEZYx4E=;
        b=anUATYX4O3u8O5zJ/Xtpx+SgJ96H04wm7Kk5f4kHXWnd8PtHRc/Nxqc5zb7TCmr9TE
         /EyyoifteJKh2jKQP7tPDaJ0JpEBjiUREPGBsUtWkZGziCrN9Tv4xaZb0Ml3ytP7DcIf
         M7jGSAbqX7VsH7mM869ncTKQZVHEyPjNG5eN/4WmTlDDRYjuxwGwRXdXaA7R3hKRElZU
         gEc09ga5SiPIAHtbk8lWJDoSltrgLGYDecQBCsxCD5Q0VOR8R/lN787S14e+s0myGrU3
         G90LT9SyZt6L5pV2NcdQpglj7lshqXNQ3moU5pNt9YgUYXH9nfm/yraOxD9cKKOikCkL
         gX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bNOZAm8mLmN4GrWYE3MVavhv9O35OLHpBIsgEZYx4E=;
        b=dvnXdUabjxPL9JhOvaWetBu/olxOGl+RjbFGRgqJK7oEjywTgdWY6xhmJTUfzYJ+hv
         ZPRnVNA8yszdwckWmJjO1kIcdui/FSESsp+z8/1+mqsf7FDj/T9vNSrC87RFZabOfesp
         YSrGSfTvqo5GO2tEs83ACQi26Z+HiNhj9tmqroH0D61n6+9uUlv53clCkOUZksBHKl7/
         Wi6wfnIL+JqPsHSfzE+bIEJ906bfMUW1dMewQL82fiiBmFZxnatmlN9rZyK4uVWJ6sVL
         HX2VrfOd/G3CuJ/euRs8VadVgN4sULZjXCfwVkcUI99DpaJpRnLAPOKNwtpOsnqq0ayA
         cCDA==
X-Gm-Message-State: AA+aEWYnJKAixq6zFrWDriu1NqYwu2jjAgBYMI1oPzw4N5JmCNAemdxh
        dADkoyyafq9JtUDmJbO4BTE=
X-Google-Smtp-Source: AFSGD/WZlrnueLMGhwxJDXtGiAVTyy3kgoyM06jINYmNFli7s72l/xqaugb6vzaU6I5REqy7OmJFPw==
X-Received: by 2002:a50:b3b8:: with SMTP id s53mr2418153edd.122.1543510999215;
        Thu, 29 Nov 2018 09:03:19 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h51sm771210edh.17.2018.11.29.09.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 09:03:18 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] gpio: tegra186: Rename flow variable to type
Date:   Thu, 29 Nov 2018 18:03:10 +0100
Message-Id: <20181129170312.23625-4-thierry.reding@gmail.com>
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

The IRQ core code refers to the interrupt type by that name, whereas the
term flow is almost never used. Some GPIO controllers use the term
flow_type, but it is most consistent to just go with the IRQ core
terminology.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 9d0292c8a199..66ec38bb7954 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -279,7 +279,7 @@ static void tegra186_irq_unmask(struct irq_data *data)
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
 }
 
-static int tegra186_irq_set_type(struct irq_data *data, unsigned int flow)
+static int tegra186_irq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct tegra_gpio *gpio = irq_data_get_irq_chip_data(data);
 	void __iomem *base;
@@ -293,7 +293,7 @@ static int tegra186_irq_set_type(struct irq_data *data, unsigned int flow)
 	value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_TYPE_MASK;
 	value &= ~TEGRA186_GPIO_ENABLE_CONFIG_TRIGGER_LEVEL;
 
-	switch (flow & IRQ_TYPE_SENSE_MASK) {
+	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_NONE:
 		break;
 
@@ -325,7 +325,7 @@ static int tegra186_irq_set_type(struct irq_data *data, unsigned int flow)
 
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
 
-	if ((flow & IRQ_TYPE_EDGE_BOTH) == 0)
+	if ((type & IRQ_TYPE_EDGE_BOTH) == 0)
 		irq_set_handler_locked(data, handle_level_irq);
 	else
 		irq_set_handler_locked(data, handle_edge_irq);
-- 
2.19.1


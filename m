Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D975C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492A720815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7QSqxF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfACK0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:26:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32899 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfACK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:26:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so22868470lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 02:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCkmiAP8S9ZZbT+z0TEDeb0o/vMWXpH9gtHQdazv0rU=;
        b=G7QSqxF8SqHHMPGUtd/z7WfsCVzoDqmtFXT9FFGqTYsKNautb68on7RtQQ5/1TOGKG
         2MZB5lrt5MruasVZYAuc4yQZmBBvoOEsYw7iueDTwIumea+JIXmWM0ZgiQ0mCjdJORKA
         DpGwD9eGKkH9pxyY1Q5DzH4AZf9BhwLYW6Gm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCkmiAP8S9ZZbT+z0TEDeb0o/vMWXpH9gtHQdazv0rU=;
        b=KczBDU1jLG9vtNb9OkjX3VLcZxEi0lgsWhB2nFjGwIqdxwQd2XZ47RywgjTCZGeB5C
         90xYpWYxENvxdCOXsmmFdcR5iLL5j/V/kBqyyVCC4PrFt/J7MaX7xskw75xjEp30qrCJ
         JeiaYzzwpMwiBH7KG6t2D/bLYwYKHYFo5FHpDULpkJ1NlK/b9PPBBRBP4500kE19YWpr
         QHgGE2e4/SeXW90scK1oqY/UkN5i4a4w8oCKCg6xnxbpa2HbkEIelLaio1JisWH4QN3C
         cwu1ZHkn/RjcQc2rthZ8waG4SsOSJOZlZRIENxg9KFIlrhedWSV0KLERoEwKyllavCp0
         uhqA==
X-Gm-Message-State: AA+aEWZXLGaHiJJS1iJ7S04yMAkCKp2OOvRJT+lqnAOpvhq0H0370sVn
        4pt2KvRHwfUN5+BFO0rlZGGJng==
X-Google-Smtp-Source: AFSGD/XsFefdqT/onE5fDpCzeMRCfT+1/LCB3vEWYLSsUYFnAP5bdWiLxzEUIPAHI/dbGwSbG/gctw==
X-Received: by 2002:a19:9904:: with SMTP id b4mr22249540lfe.95.1546511191435;
        Thu, 03 Jan 2019 02:26:31 -0800 (PST)
Received: from linux.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id e5-v6sm11571859ljj.91.2019.01.03.02.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 02:26:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] irqchip: madera: Drop GPIO includes
Date:   Thu,  3 Jan 2019 11:26:23 +0100
Message-Id: <20190103102623.29685-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This irqchip does not use anything GPIO-related so drop
the GPIO includes.

Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/irqchip/irq-madera.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index e9256dee1a45..8b81271c823c 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -16,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/irqchip/irq-madera.h>
 #include <linux/mfd/madera/core.h>
-- 
2.19.2


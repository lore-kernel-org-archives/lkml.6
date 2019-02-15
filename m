Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DD1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6BD21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM7xDQn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392536AbfBOVnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:43:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55157 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392493AbfBOVnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:43:14 -0500
Received: by mail-it1-f195.google.com with SMTP id f10so4150784ita.4;
        Fri, 15 Feb 2019 13:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FKlJddmruO7nWtXJzDCxYpJZ2hrqaK8J0+Kc3s0oyqc=;
        b=RM7xDQn0GhUSXYzAlz1axfY3Nxt/DMX/kJD+y0as0A9xZkCNUuViQkLYVnmFv+P0Ww
         oRE8i7K/rwDaORZX1LJVovorQw8R6QugE0liVhSDQkAjoLEl569XZFJdrcmGjFiWalpC
         sUTVwi7pjMKR3/vySUXDm+mafS6Muzq1hr62IISIgVGb7e/FvZot3Er/RQ6GHYARXtkW
         z8P+kyT3QoW5sUdD6OnalW8PtG9kyMMzJ+nfEroyVC/XBW211/saxmL8nuNnRdKLyF9L
         mf0OM/MLdC8qwj4EkKVkFzQArMdAfAhMA5Zz7glF0faVzxXtlEzJfg9SKFMwTS7Q/ENw
         skqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FKlJddmruO7nWtXJzDCxYpJZ2hrqaK8J0+Kc3s0oyqc=;
        b=stNWDHmHnPd/qmq0e/mx56t0HZiRy3YPwkh9PoNviwsESuiypezA8oXzsLpBZ6/gzT
         V4QYAxK8SuShJ7tTFtL6uwKUF2sGvo7h/MJdlf84+IAKl61BIza8y5eR+dAgQEQMVDe8
         i0AvTpENgPEVkDgizoPtdQHu0K138rf7CFyowgZ7Jgpc+Mi4ncdy6iBFQFoVBWwXS4az
         WW8NfyuAx3o9b7q6NNPfRcGjI2/ut7BJhiw105NbpFdHKdlxjPeX9LO1QAvOI5DM+/Er
         8GctGkRVanDDI/M/zxMpbJmfdz1McdD9v2eEQePCbN38drXbIhUMHx5H8XG0MjTgDK4t
         cL4Q==
X-Gm-Message-State: AHQUAuYn+hUVDZJxAMFlWpBy1lxUNRE6j632p0Ut1xJQClfi3mfaOeuu
        k8V23qX65BzcQEm3XpT9NOfOHtxE
X-Google-Smtp-Source: AHgI3IbmuQC8I7xlv2PRMYEwzbxb4VQ3KQxq83c4UdC6ZszpGTEj3SZb/8ATLEAUK+7qwf/trAxARA==
X-Received: by 2002:a02:4084:: with SMTP id n126mr2545109jaa.78.1550266992602;
        Fri, 15 Feb 2019 13:43:12 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id t64sm3301431itb.5.2019.02.15.13.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 13:43:11 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Kurz <akurz@blala.de>
Subject: [PATCH 1/2] power: supply: max14656: fix potential use-before-alloc
Date:   Fri, 15 Feb 2019 16:43:02 -0500
Message-Id: <20190215214303.7274-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call order on probe():
- max14656_hw_init() enables interrupts on the chip
- devm_request_irq() starts processing interrupts, isr
  could be called immediately
-    isr: schedules delayed work (irq_work)
-    irq_work: calls power_supply_changed()
- devm_power_supply_register() registers the power supply

Depending on timing, it's possible that power_supply_changed()
is called on an unregistered power supply structure.

Fix by registering the power supply before requesting the irq.

Cc: Alexander Kurz <akurz@blala.de>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/power/supply/max14656_charger_detector.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index b91b1d2999dc..d19307f791c6 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -280,6 +280,13 @@ static int max14656_probe(struct i2c_client *client,
 
 	INIT_DELAYED_WORK(&chip->irq_work, max14656_irq_worker);
 
+	chip->detect_psy = devm_power_supply_register(dev,
+		       &chip->psy_desc, &psy_cfg);
+	if (IS_ERR(chip->detect_psy)) {
+		dev_err(dev, "power_supply_register failed\n");
+		return -EINVAL;
+	}
+
 	ret = devm_request_irq(dev, chip->irq, max14656_irq,
 			       IRQF_TRIGGER_FALLING,
 			       MAX14656_NAME, chip);
@@ -289,13 +296,6 @@ static int max14656_probe(struct i2c_client *client,
 	}
 	enable_irq_wake(chip->irq);
 
-	chip->detect_psy = devm_power_supply_register(dev,
-		       &chip->psy_desc, &psy_cfg);
-	if (IS_ERR(chip->detect_psy)) {
-		dev_err(dev, "power_supply_register failed\n");
-		return -EINVAL;
-	}
-
 	schedule_delayed_work(&chip->irq_work, msecs_to_jiffies(2000));
 
 	return 0;
-- 
2.17.1


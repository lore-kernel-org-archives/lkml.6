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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6E6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A11421B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwaQcZEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392610AbfBOVnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:43:17 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39389 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfBOVnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:43:14 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so14148121iti.4;
        Fri, 15 Feb 2019 13:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1tD3XdrjTvGx7PG6lPxNTPREFZ0oaZ7N/X4nuzbJyQY=;
        b=KwaQcZEGKC+do3YQu80T0QPaRLk5AZLoMsLnnvewxJdmtoeXeMcYd+UinXhOzD6hIT
         uB9ANYQPHCZ1F/lyzbfkigmy7/LtOSICbof08tkl3+33NKiGwRCSwFQq42ZFlMyfTyZR
         WG3NTgt4azyUjTfu3sIx3PFyNoRhcEAz2TwfIPjgTplFh4Lg2MKLjwZ6xU1FG54e6nga
         ZOUoTubiKD6mIjHawPZ05yelhveXgd+b6lTY728Qj10KhIB89WrlKOPdHCfjytXOJ3UE
         +x+BtA5A8YAavIOm5Zh85otkKpK62gUePr3tqhlR+Z5dQhD7ex0GPv1C31O6Dl50hF4w
         2sSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1tD3XdrjTvGx7PG6lPxNTPREFZ0oaZ7N/X4nuzbJyQY=;
        b=h0LTYtPb3uP/pIdqYDRcDQbpb3I5vFToLyVIX8gERSWAySsZvYutg2/T+licWmDDbX
         CxFQbpSgPAi9iYoV8c2S+XuhKoDPKXl7HWbdXSklj2S9Z7YViMHKnGSwK7VzNZyXMYcU
         L7wc+HGOJdqcgBggz3XiZZH3OkHnVPrW92LYSOaeDtGhXQkuBYPZYWuNdbmo7gPGS5Ix
         MQe4sX5bH5/mL8ekSpr4RggNdwyNePWNadCbKt6y0BUZYHqjoG4QRfGIxyIt7C2JBQbF
         WHxiw2DR5M/LXY/nIGMqcBNcGCQlOz8QCYnXrx4mm5wRfWpTGGU/s8Ogzr4QkRCjfk+x
         Vqug==
X-Gm-Message-State: AHQUAuZyAdFBJKCYeKEND26V9OWQ/odw9AmamvwTcCx2aA0bTSy8EqKB
        tJORyQgnNQSyQaxLVr6ZRcg=
X-Google-Smtp-Source: AHgI3Ia6zljpLgl/9TUqSkGZmTCNFqXcFzZ+5cPWWiRMRW7qZfb/58jA2ibAT3g2Mh09XUH5FxL2kQ==
X-Received: by 2002:a24:d288:: with SMTP id z130mr1616060itf.171.1550266993455;
        Fri, 15 Feb 2019 13:43:13 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id t64sm3301431itb.5.2019.02.15.13.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 13:43:12 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Kurz <akurz@blala.de>
Subject: [PATCH 2/2] power: supply: max14656: fix potential use-after-free
Date:   Fri, 15 Feb 2019 16:43:03 -0500
Message-Id: <20190215214303.7274-2-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215214303.7274-1-TheSven73@gmail.com>
References: <20190215214303.7274-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly cancel/sync the irq_work delayed work, otherwise
there's a chance that it will run after the device is removed,
which would result in a use-after-free.

Note that cancel/sync should happen:
- after irq's have been disabled, as the isr re-schedules the work
- before the power supply is unregistered, because the work func
    uses the power supply handle.

Cc: Alexander Kurz <akurz@blala.de>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 .../power/supply/max14656_charger_detector.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index d19307f791c6..9e6472834e37 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -240,6 +240,14 @@ static enum power_supply_property max14656_battery_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
+static void stop_irq_work(void *data)
+{
+	struct max14656_chip *chip = data;
+
+	cancel_delayed_work_sync(&chip->irq_work);
+}
+
+
 static int max14656_probe(struct i2c_client *client,
 			  const struct i2c_device_id *id)
 {
@@ -278,8 +286,6 @@ static int max14656_probe(struct i2c_client *client,
 	if (ret)
 		return -ENODEV;
 
-	INIT_DELAYED_WORK(&chip->irq_work, max14656_irq_worker);
-
 	chip->detect_psy = devm_power_supply_register(dev,
 		       &chip->psy_desc, &psy_cfg);
 	if (IS_ERR(chip->detect_psy)) {
@@ -287,6 +293,13 @@ static int max14656_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	INIT_DELAYED_WORK(&chip->irq_work, max14656_irq_worker);
+	ret = devm_add_action(dev, stop_irq_work, chip);
+	if (ret) {
+		dev_err(dev, "devm_add_action %d failed\n", ret);
+		return ret;
+	}
+
 	ret = devm_request_irq(dev, chip->irq, max14656_irq,
 			       IRQF_TRIGGER_FALLING,
 			       MAX14656_NAME, chip);
-- 
2.17.1


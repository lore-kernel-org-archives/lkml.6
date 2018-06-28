Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C33278DD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 20:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kresin-me.20150623.gappssmtp.com header.i=@kresin-me.20150623.gappssmtp.com header.b="rzZH7UZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C33278DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kresin.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965757AbeF1UCM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 16:02:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54102 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935080AbeF1UCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 16:02:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so4892457wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8xTgjlnzHzKXTR34WzoaNnu7pwiH36F9/CHlALit1Gk=;
        b=rzZH7UZvXyBJttmQ/zLERC8Fn5QkW1ZgRp9EBRfCfL8d9Bot+vfTUwVBuWvk6CJgCv
         dzYgsxsUW2yanegdb24OE8CXkn7yh2GmpA3j8JJvQGTRIryGgVmb6Ov6vrqdJKd0i68+
         /EB2iZQSAU5zcx2SFtHu+JmBPKG8f4u8vbkX8dq8fDExcCwiiZmLu/LhLUFVR1tPFz6r
         nBFQHgzxoie6YmsZsVmyN6ecg5qIz0NKKRfaYfnG0iuUJucUT8TIkoy8CFHjKspBx0uK
         EmcuHEnm16VTSvixqa2/6nGKoBXXder6/HaH6SNM9d4/3SEODUvrZcZ75wayXtFnZ4Wa
         3/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8xTgjlnzHzKXTR34WzoaNnu7pwiH36F9/CHlALit1Gk=;
        b=gyJYp/DyXFjkz1q3M7lkb3ZdYY8c3la2HO6obCL2a48u+jVCbvT+zoZIt1APo1FnFn
         7xIL365k1hoF/FSeC1+gw6Nqcycy3WgoVeWyDWZSP6Nu6rdvYQWDgLrJLU/vJ6rdumEd
         R47KGZCMe/RjMdKa/txPogWC6C1jbiZAX9G4DKDYm3pFY5z7WuqqqX7WZEp0DsWdi9sa
         x0PkIZboY4s/YASlaa2zKtHKql0ooJxgBpYLycWe+X3ajhWYzyI5UrWKNj9BkR3egUuM
         EgGcgHOJW4Hqh4aSYssYugitD6n/V1w7dPCbvTFcW35Dlpqvw0cbxc39209+3DAGQPq7
         rQ7A==
X-Gm-Message-State: APt69E2z2u1akuTyy2SQb6er1TQsACL5H0ZBKjRTF5znYu0lALL198WW
        Q4wbymyrQla01Q+1rgSChLbBOw==
X-Google-Smtp-Source: AAOMgpcerEWkHfgnR5eLyhLbfS096ZHEt3RCy3AbLfR1vcndyMEWH+dUMejKhcjjXTDte16hpBSctg==
X-Received: by 2002:a1c:64d5:: with SMTP id y204-v6mr36998wmb.14.1530216129494;
        Thu, 28 Jun 2018 13:02:09 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p200300EC2BC6E30040B8FF52E7C5D1B8.dip0.t-ipconnect.de. [2003:ec:2bc6:e300:40b8:ff52:e7c5:d1b8])
        by smtp.gmail.com with ESMTPSA id 16-v6sm12878387wmi.36.2018.06.28.13.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 13:02:08 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     linus.walleij@linaro.org, john@phrozen.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     martin.blumenstingl@googlemail.com
Subject: [PATCH] gpio: stp-xway: Implement get callback
Date:   Thu, 28 Jun 2018 21:57:40 +0200
Message-Id: <1530215860-25549-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an implementation to get the current GPIO state.

The callback is used by the leds-gpio driver for example, in case the
current LED/GPIO state should be kept during driver load.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 drivers/gpio/gpio-stp-xway.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpio-stp-xway.c b/drivers/gpio/gpio-stp-xway.c
index c07385b..63c708c 100644
--- a/drivers/gpio/gpio-stp-xway.c
+++ b/drivers/gpio/gpio-stp-xway.c
@@ -91,6 +91,20 @@ struct xway_stp {
 };
 
 /**
+ * xway_stp_get() - gpio_chip->get - get gpios.
+ * @gc:     Pointer to gpio_chip device structure.
+ * @gpio:   GPIO signal number.
+ *
+ * Gets the shadow value.
+ */
+static int xway_stp_get(struct gpio_chip *gc, unsigned int gpio)
+{
+	struct xway_stp *chip = gpiochip_get_data(gc);
+
+	return (xway_stp_r32(chip->virt, XWAY_STP_CPU0) & BIT(gpio));
+}
+
+/**
  * xway_stp_set() - gpio_chip->set - set gpios.
  * @gc:     Pointer to gpio_chip device structure.
  * @gpio:   GPIO signal number.
@@ -215,6 +229,7 @@ static int xway_stp_probe(struct platform_device *pdev)
 	chip->gc.parent = &pdev->dev;
 	chip->gc.label = "stp-xway";
 	chip->gc.direction_output = xway_stp_dir_out;
+	chip->gc.get = xway_stp_get;
 	chip->gc.set = xway_stp_set;
 	chip->gc.request = xway_stp_request;
 	chip->gc.base = -1;
-- 
2.7.4


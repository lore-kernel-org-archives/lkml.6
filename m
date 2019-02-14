Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBA5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CBB222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sv75zeUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438897AbfBNNnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:43:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38756 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394860AbfBNNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:43:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so6140998wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nnfjvlRfLgBJ7Ayp1DnO3Th2WGXGDjW3+e0QMn8VLk=;
        b=sv75zeUZH9XenpuYZKa8BEPQoCatl7veeElc9xWqKoE2vSxBqRrJ0Vh8rHoLM5zlcf
         K3Ev1xdW91zbrODHWYugDa20fRrGWMxc3SvYy3jfnLs0w1ZXaS6YQnFRBkWIi1ZHZ9wH
         3k63B7PAjU9j20LwSEDPiHc+Mfln9PcjrE7cgEV8/J4i/Ikb89K7mE/mqPB5AeKdfxA2
         mg5jFTuOzQBCUThn7dfvhaUgLsd8Dvqsm+4Uwgu3cPhmOrQ6b0UGHYYIVrYaUGU1cf4C
         ABzWpInPMqbl5WBpGU7W5tWgoKIQTognZxHTBmODtVDJSRZJWzHkaA6AoOMFmxThamY8
         fS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nnfjvlRfLgBJ7Ayp1DnO3Th2WGXGDjW3+e0QMn8VLk=;
        b=Z8WN3bIYWmszR/5vbrsLlZysIPSjaHISFvDLxduzidepb6+esBcNFW0T0QWCTZtQLu
         UNxLSv8K5g3RSG649EomTw85WgDgzr2yNBIN1RaNGhYi01P/6hGgshfB58Q4lUN0838Z
         qWBSbrVIgUHcDJjTljR2YB7Grw8JgBZnNmhcuD2NnQ7lq9lETk5WnUApSt6UCkxfXy67
         oi2nQe+2gc5/CbDn8hlz+xtro9DCenVCJwYHm9NkPciNlmKDB6lYSjAC3saNbxk7X6Oa
         0KlF/4a8wvrSdsXjAEi80RP6qtIQRFR+AptCmSpppkSnmXRCHx6oUgXpGiyDrJVA5Z/8
         gi0w==
X-Gm-Message-State: AHQUAub1ctFqHmdixeyRZipi/cxF93mcvu0xq8ZqDkWFOQNAnJmX+FyC
        8gyk2nVTLEg15IZCOIu7qFUsuw==
X-Google-Smtp-Source: AHgI3Iby8bmasBr4SX0XXWmV1sB4Y9JPWsPFyjxipnPTbS940m1IVV+0dqD4+4pRo38HVVIZ0DKUHA==
X-Received: by 2002:a1c:44c3:: with SMTP id r186mr2837385wma.63.1550151780349;
        Thu, 14 Feb 2019 05:43:00 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id 62sm4963460wra.46.2019.02.14.05.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 05:42:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 4/7] gpio: mockup: don't create the debugfs link named after the label
Date:   Thu, 14 Feb 2019 14:42:29 +0100
Message-Id: <20190214134232.3821-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214134232.3821-1-brgl@bgdev.pl>
References: <20190214134232.3821-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

User-space tests no longer use it and we're breaking the interface
anyway.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 6deed33dbbef..9d279d641374 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -234,7 +234,7 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 				      struct gpio_mockup_chip *chip)
 {
 	struct gpio_mockup_dbgfs_private *priv;
-	struct dentry *evfile, *link;
+	struct dentry *evfile;
 	struct gpio_chip *gc;
 	const char *devname;
 	char *name;
@@ -247,10 +247,6 @@ static void gpio_mockup_debugfs_setup(struct device *dev,
 	if (IS_ERR_OR_NULL(chip->dbg_dir))
 		goto err;
 
-	link = debugfs_create_symlink(gc->label, gpio_mockup_dbg_dir, devname);
-	if (IS_ERR_OR_NULL(link))
-		goto err;
-
 	for (i = 0; i < gc->ngpio; i++) {
 		name = devm_kasprintf(dev, GFP_KERNEL, "%d", i);
 		if (!name)
-- 
2.20.1


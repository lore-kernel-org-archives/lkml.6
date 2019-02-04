Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870EAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FBD2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQA2N5QC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfBDWKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:10:14 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:32971 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfBDWKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:10:00 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so12783982itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=no1CQYYZfwWp6SvKdMZoJZxgBc8oWBoFZAog9MiYL2M=;
        b=ZQA2N5QCanNKCfayOHnpV8NXqP8kqGDUUlYcjIo+L1oCvlSxXyBPhDwGsDAndccR2o
         7kvq1IZony2+5RTCCrD0DNwrXkeLSK5wgozaLzyfayknqedcOQHQjoJrld5tD+QEFh/x
         WZ8sc/Mz8TSyJfUShvXLBtRffzWLSFj5lCvVVubONbAzbWCzkHEoe/AWBTo7z9kGlwH/
         aPqQQs63NuMNijJbVcrAmCJPeD7AXyyeduBheImjdTjZ/LIkIEFomHC5VkwcKsoXcILC
         2O6DC28nPnEZc7I8huMVHMAJheYmMYvyVLv+eBHV0BI+Qu8k5n6hs5JTCqiVoe49YtbT
         wc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=no1CQYYZfwWp6SvKdMZoJZxgBc8oWBoFZAog9MiYL2M=;
        b=U8g7PMG8SEC5EcaTgGjp2gDuKUaq2l2E8Lhcacw2Lawn3E83Ggwy/+Q3Tdj9cWa9QK
         1ZjWx4pCVnP0hvs9w+OIoA+xfYreGxgVI3HVfddsFGAWjWjmKQ1kiTlx2sh+CSdX+4eR
         +urj57JdkXUMJRNbkRxVcu2P6VVJrpTrJByLYF9M70bwgs3Y7HbYX6LAAb6vwaBjQjch
         YuAb1h1N/9XYYng4vwgV9q1cZRiv0fr04kwlYIFFnYYcgAhj0o4KPEK5x7AECviq3XXW
         sUNB9joBOdTAO4S2d6L2msjG/4KNqV6UoOQ0uGxpBuOJDdN7JhXEqARldXU2g4RYsML5
         l6Lw==
X-Gm-Message-State: AHQUAuZTqDAHGB21/gzSc9+5BLQ8FvWwPKFrDyE4aNWT8nF51GxYZE95
        skykfwlTwvX3SygU6lKeybwzW3Yn
X-Google-Smtp-Source: AHgI3IbpH30oKl7g5CNExoUshzGXNtWp7NE2ovEI5RHuobyr0obEY3/0B92f3sOhKmL3o0aRLy+00Q==
X-Received: by 2002:a02:a589:: with SMTP id b9mr910418jam.113.1549318199312;
        Mon, 04 Feb 2019 14:09:59 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id z1sm531602ioi.77.2019.02.04.14.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 14:09:58 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [RFC v1 3/3] cap11xx: fix potential user-after-free on module unload
Date:   Mon,  4 Feb 2019 17:09:52 -0500
Message-Id: <20190204220952.30761-4-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190204220952.30761-1-TheSven73@googlemail.com>
References: <20190204220952.30761-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The work which is scheduled by led_classdev->brightness_set() is
potentially left pending or running until after the driver module
is unloaded.

Fix by using resource-controlled version of INIT_WORK().

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 drivers/input/keyboard/cap11xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 312916f99597..a92dd8ee9ed7 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -312,7 +312,11 @@ static int cap11xx_init_leds(struct device *dev,
 		led->reg = reg;
 		led->priv = priv;
 
-		INIT_WORK(&led->work, cap11xx_led_work);
+		error = devm_init_work(dev, &led->work, cap11xx_led_work);
+		if (error) {
+			of_node_put(child);
+			return error;
+		}
 
 		error = devm_led_classdev_register(dev, &led->cdev);
 		if (error) {
-- 
2.17.1


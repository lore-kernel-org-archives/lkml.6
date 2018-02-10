Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeBJUhG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 15:37:06 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42030 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeBJUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 15:36:42 -0500
X-Google-Smtp-Source: AH8x224T8Auyl/Vjs5a4Q/oWtXwlE1NS32maiujfqHYo2TriZ0VtQWO8+uLSEBwbVVOv7pvJJUtSfQ==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] watchdog: gpio: change order for setting default timeout
Date: Sat, 10 Feb 2018 21:36:22 +0100
Message-Id: <20180210203623.17832-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180210203623.17832-1-marcus.folkesson@gmail.com>
References: <20180210203623.17832-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

watchdog_init_timeout() will preserve wdd->timeout value if
no parameter nor timeout-secs dt property is set.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/gpio_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index cb66c2f99ff1..d0e8203f7a60 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -156,9 +156,9 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
 	priv->wdd.max_hw_heartbeat_ms = hw_margin;
 	priv->wdd.parent	= &pdev->dev;
+	priv->wdd.timeout = SOFT_TIMEOUT_DEF;
 
-	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
-		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
+	watchdog_init_timeout(&priv->wdd, 0, &pdev->dev);
 
 	watchdog_stop_on_reboot(&priv->wdd);
 
-- 
2.15.1

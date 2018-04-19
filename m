Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDSPNB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:13:01 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43995 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeDSPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:12:58 -0400
X-Google-Smtp-Source: AIpwx4+F0SScbeo+bW5l8IoKIs8mOdoxp59nVLlIxmt6/i3fQBxXf5KkGzf5HxZqIfR1BuPDMlITuA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/2] memory: aemif: don't rely on kbuild for driver's name
Date: Thu, 19 Apr 2018 17:12:51 +0200
Message-Id: <20180419151252.26212-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419151252.26212-1-brgl@bgdev.pl>
References: <20180419151252.26212-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to use aemif from board files. Use a static name in the
driver's code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/memory/ti-aemif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 2744b1b91b57..588e58d40d1b 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -422,7 +422,7 @@ static struct platform_driver aemif_driver = {
 	.probe = aemif_probe,
 	.remove = aemif_remove,
 	.driver = {
-		.name = KBUILD_MODNAME,
+		.name = "ti-aemif",
 		.of_match_table = of_match_ptr(aemif_of_match),
 	},
 };
-- 
2.17.0

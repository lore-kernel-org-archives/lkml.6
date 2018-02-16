Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161300AbeBPQsk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:48:40 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40741 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161098AbeBPQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:47:23 -0500
X-Google-Smtp-Source: AH8x224SJUHUFQAyevXeL8H7AwWDHvojcepSrhsCFB3ecEn5ILhrUs1lxuNg3+RQnuGZNaZTCib6ww==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/6] memory: aemif: don't rely on kbuild for driver's name
Date: Fri, 16 Feb 2018 17:47:09 +0100
Message-Id: <20180216164712.25898-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180216164712.25898-1-brgl@bgdev.pl>
References: <20180216164712.25898-1-brgl@bgdev.pl>
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
2.16.1

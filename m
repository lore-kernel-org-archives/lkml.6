Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161137AbeBPQrY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:47:24 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36314 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161071AbeBPQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:47:20 -0500
X-Google-Smtp-Source: AH8x225IE4pLO/mlltxrqRV8tOYy3FRoUIz2SK3a4U6sl4rBX+SoUFycT+K7SaBxZiWO+6astyk/hA==
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
Subject: [PATCH 1/6] nand: davinci: rename the platform driver
Date: Fri, 16 Feb 2018 17:47:07 +0100
Message-Id: <20180216164712.25898-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180216164712.25898-1-brgl@bgdev.pl>
References: <20180216164712.25898-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock
lookup table") broke the nand support in board file mode for
da850-based boards. Instead of reverting it and breaking the DT users
in the process (due to clock lookup), rename the driver to match the
clock table before renaming the users.

Fixes: d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock lookup table")
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mtd/nand/davinci_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index ccc8c43abcff..4fb143bf1872 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -865,7 +865,7 @@ static struct platform_driver nand_davinci_driver = {
 	.probe		= nand_davinci_probe,
 	.remove		= nand_davinci_remove,
 	.driver		= {
-		.name	= "davinci_nand",
+		.name	= "davinci-nand",
 		.of_match_table = of_match_ptr(davinci_nand_of_match),
 	},
 };
-- 
2.16.1

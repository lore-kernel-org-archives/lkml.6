Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeB0MOt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:14:49 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42451 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbeB0MOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:14:47 -0500
X-Google-Smtp-Source: AH8x2264Mo1mEfrSpzYkVXsQuefmhOUlPLXQ5gIHlxczXU9k1/YjbG54dzCAuEPa5sLJZwQEeIBFuA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] ARM: davinci: fix the GPIO lookup for omapl138-hawk
Date: Tue, 27 Feb 2018 13:14:43 +0100
Message-Id: <20180227121443.3191-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
mmc can correctly lookup the wp and cp gpios.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a3e78074be70..62eb7d668890 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -127,8 +127,8 @@ static struct gpiod_lookup_table mmc_gpios_table = {
 	.dev_id = "da830-mmc.0",
 	.table = {
 		/* CD: gpio3_12: gpio60: chip 1 contains gpio range 32-63*/
-		GPIO_LOOKUP("davinci_gpio.1", 28, "cd", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("davinci_gpio.1", 29, "wp", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", 28, "cd", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("davinci_gpio.0", 29, "wp", GPIO_ACTIVE_LOW),
 	},
 };
 
-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932532AbeE3VsL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:48:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeE3VsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:48:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ieee802154: mcr20a: add missing includes
Date: Wed, 30 May 2018 23:47:09 +0200
Message-Id: <20180530214732.1021121-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:0xFqkxSVUKFqwwzauiKdYi9LMCMj06QJQP+ytzKRPBVVrh21etT
 m+ZXyLHyCaDBYfXsEifyyUEU56Ccx4gYxw34lu9nMgxYdH9dI/WK/DYZBV9Vzt6NzaVccWb
 o29iGgSXoHow6YPndyGaLBTV5p5K2Tv1ui9HH8wgIF3vEl55d1nLoufTIboweVxZ5iVHuJv
 DWO2xVJIw95Tbz/hzjzPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uBFACPNlAcA=:fVEJLM/+Lqe2JanEmvqI9Q
 zvlnkFPAQXEMa54QFUwH/IdSRqai+Yvdmt+MmGR/5yDgEXLPq+zSA9nyFooF+bbpZvATP65Yd
 /rd57Bg6yqWhJ5JNtH9cBQpNS8ACGoALQubwT/UTdkqutflc+c+ad9vhU7glDT6/htKbSMw4X
 hQusyyDQ/9EGNUNN5ogUj1s+oTKGvCZFvTJp3uaS8IJ+NhXmrn+w84A3UZ6TQykQLlP6szX2C
 wNUdg0XyKo9Z1wlnhQhpLrTreQRoo87nzSb/ue6So3NoWfbarckmgiJACewIu2VmuEPyLoTt+
 3hsNea6W+vBPb1kzCjmV4FPWbXDPXNZbX/wXrED2rqmCCM6bhNveYZgrSm6OI1Y97kiwbYHC/
 cYfsdZY4bW1VMLiKI8py4IArcUsTPArUPT7UhEFtnxxXs+iBmxlMvzvnnnyIQVyKS2rFXaQwH
 CR2ECFMMS8gW0fQq5cFGpcxE0NxU8hy42mXlYUC6w5T73/h0JHRbeM8KPFgWm5wXuXDRpZKWu
 QRu0RzLoenB0lwnUOX8r55PQTPnY5XTAd6fGi4vo9Cn+fu7gopV5XWP+Qx7tPaAYi75HtsZD1
 DTwZ4C2Vl8lPX3BWWUQTwvJljwCU0Jh9Cu/BL0cQFGc9jwdODAbO/thG5chGs8VQdMjpDYTe1
 BA0qTYNHKJSRoVCn+IGl5trbbQZ+VUETAX0DaK8AOl3i/MZ+Z0nk3cKZS3X2IY6UlHtk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_GPIOLIB, some headers are not included implicitly,
leading to a build failure:

drivers/net/ieee802154/mcr20a.c: In function 'mcr20a_probe':
drivers/net/ieee802154/mcr20a.c:1347:13: error: implicit declaration of function 'irq_get_trigger_type'; did you mean 'irq_get_irqchip_state'? [-Werror=implicit-function-declaration]

This includes gpio/consumer.h and irq.h directly rather through the
gpiolib header.

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ieee802154/mcr20a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index de0d7f28a181..e428277781ac 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -15,10 +15,11 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/skbuff.h>
 #include <linux/of_gpio.h>
 #include <linux/regmap.h>
-- 
2.9.0

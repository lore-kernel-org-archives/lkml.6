Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeBWOzX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:55:23 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:52700 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeBWOzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:55:22 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH] Revert "gpio: winbond: fix ISA_BUS_API dependency"
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-gpio@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <9a55e8b3-bf34-d8a4-f5a6-01e86374f42f@maciej.szmigiero.name>
Date: Fri, 23 Feb 2018 15:55:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 92a8046c9d952a2a7d21dfcd3afadc72a0bc0f72.

Now that the patch series changing ISA_BUS_API dependency to selection
was merged this reversion will do the same for gpio-winbond driver to
make it consistent with other ISA bus gpio drivers.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index dff99871bca8..6d481ef03623 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -722,7 +722,7 @@ config GPIO_TS5500
 
 config GPIO_WINBOND
 	tristate "Winbond Super I/O GPIO support"
-	depends on ISA_BUS_API
+	select ISA_BUS_API
 	help
 	  This option enables support for GPIOs found on Winbond Super I/O
 	  chips.

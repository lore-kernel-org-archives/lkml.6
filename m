Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753516AbeDSUAv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:00:51 -0400
Received: from sauhun.de ([88.99.104.3]:48050 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeDSUAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:00:48 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] i2c: i2c-mux-gpio: move header to platform_data
Date: Thu, 19 Apr 2018 22:00:08 +0200
Message-Id: <20180419200015.15095-3-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header only contains platform_data. Move it to the proper directory.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/i2c/muxes/i2c-mux-gpio             | 4 ++--
 MAINTAINERS                                      | 2 +-
 drivers/i2c/busses/i2c-i801.c                    | 2 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                 | 2 +-
 include/linux/{ => platform_data}/i2c-mux-gpio.h | 0
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename include/linux/{ => platform_data}/i2c-mux-gpio.h (100%)

diff --git a/Documentation/i2c/muxes/i2c-mux-gpio b/Documentation/i2c/muxes/i2c-mux-gpio
index 7a8d7d261632..893ecdfe6e43 100644
--- a/Documentation/i2c/muxes/i2c-mux-gpio
+++ b/Documentation/i2c/muxes/i2c-mux-gpio
@@ -30,12 +30,12 @@ i2c-mux-gpio uses the platform bus, so you need to provide a struct
 platform_device with the platform_data pointing to a struct
 i2c_mux_gpio_platform_data with the I2C adapter number of the master
 bus, the number of bus segments to create and the GPIO pins used
-to control it. See include/linux/i2c-mux-gpio.h for details.
+to control it. See include/linux/platform_data/i2c-mux-gpio.h for details.
 
 E.G. something like this for a MUX providing 4 bus segments
 controlled through 3 GPIO pins:
 
-#include <linux/i2c-mux-gpio.h>
+#include <linux/platform_data/i2c-mux-gpio.h>
 #include <linux/platform_device.h>
 
 static const unsigned myboard_gpiomux_gpios[] = {
diff --git a/MAINTAINERS b/MAINTAINERS
index 7aad64b62102..44b4bb5cf94e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5879,7 +5879,7 @@ M:	Peter Korsgaard <peter.korsgaard@barco.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	drivers/i2c/muxes/i2c-mux-gpio.c
-F:	include/linux/i2c-mux-gpio.h
+F:	include/linux/platform_data/i2c-mux-gpio.h
 F:	Documentation/i2c/muxes/i2c-mux-gpio
 
 GENERIC HDLC (WAN) DRIVERS
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index e0d59e9ff3c6..bff160d1ce3f 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -106,7 +106,7 @@
 
 #if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
 #include <linux/gpio.h>
-#include <linux/i2c-mux-gpio.h>
+#include <linux/platform_data/i2c-mux-gpio.h>
 #endif
 
 /* I801 SMBus address offsets */
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 1a9973ede443..15a7cc0459fb 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -10,7 +10,7 @@
 
 #include <linux/i2c.h>
 #include <linux/i2c-mux.h>
-#include <linux/i2c-mux-gpio.h>
+#include <linux/platform_data/i2c-mux-gpio.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/include/linux/i2c-mux-gpio.h b/include/linux/platform_data/i2c-mux-gpio.h
similarity index 100%
rename from include/linux/i2c-mux-gpio.h
rename to include/linux/platform_data/i2c-mux-gpio.h
-- 
2.11.0

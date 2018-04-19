Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeDSUAx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 16:00:53 -0400
Received: from sauhun.de ([88.99.104.3]:48062 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753486AbeDSUAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 16:00:52 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Peter Korsgaard <jacmet@sunsite.dk>,
        Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] i2c: i2c-ocores: move header to platform_data
Date: Thu, 19 Apr 2018 22:00:09 +0200
Message-Id: <20180419200015.15095-4-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419200015.15095-1-wsa@the-dreams.de>
References: <20180419200015.15095-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header only contains platform_data. Move it to the proper directory.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 Documentation/i2c/busses/i2c-ocores            | 2 +-
 drivers/i2c/busses/i2c-ocores.c                | 2 +-
 drivers/mfd/timberdale.c                       | 2 +-
 include/linux/{ => platform_data}/i2c-ocores.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{ => platform_data}/i2c-ocores.h (100%)

diff --git a/Documentation/i2c/busses/i2c-ocores b/Documentation/i2c/busses/i2c-ocores
index c269aaa2f26a..c12fa9d3b050 100644
--- a/Documentation/i2c/busses/i2c-ocores
+++ b/Documentation/i2c/busses/i2c-ocores
@@ -18,7 +18,7 @@ Usage
 i2c-ocores uses the platform bus, so you need to provide a struct
 platform_device with the base address and interrupt number. The
 dev.platform_data of the device should also point to a struct
-ocores_i2c_platform_data (see linux/i2c-ocores.h) describing the
+ocores_i2c_platform_data (see linux/platform_data/i2c-ocores.h) describing the
 distance between registers and the input clock speed.
 There is also a possibility to attach a list of i2c_board_info which
 the i2c-ocores driver will add to the bus upon creation.
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 8c42ca7107b2..d7da9adf7ee1 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -21,7 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/wait.h>
-#include <linux/i2c-ocores.h>
+#include <linux/platform_data/i2c-ocores.h>
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/log2.h>
diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index cd4a6d7d6750..118d7ef727e6 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -30,7 +30,7 @@
 #include <linux/timb_gpio.h>
 
 #include <linux/i2c.h>
-#include <linux/i2c-ocores.h>
+#include <linux/platform_data/i2c-ocores.h>
 #include <linux/i2c-xiic.h>
 
 #include <linux/spi/spi.h>
diff --git a/include/linux/i2c-ocores.h b/include/linux/platform_data/i2c-ocores.h
similarity index 100%
rename from include/linux/i2c-ocores.h
rename to include/linux/platform_data/i2c-ocores.h
-- 
2.11.0

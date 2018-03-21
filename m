Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeCUOau (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:30:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39630 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCUOak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:30:40 -0400
X-Google-Smtp-Source: AG47ELvbWk+IrHh5jig/y0pyZKnum5lEQG/Ycs/AHOl+INqDSHRXYCkdFu/hN9U8oRM9JUirrnTbuQ==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 11/11] Move cdc ad7746 driver out of staging to mainline iio
Date: Wed, 21 Mar 2018 11:28:59 -0300
Message-Id: <1521642539-4845-12-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also modify the proper Kconfigs and move documentation.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 .../devicetree/bindings/{staging => }/iio/cdc/ad7746.txt |  0
 drivers/iio/Kconfig                                      |  1 +
 drivers/iio/cdc/Kconfig                                  | 16 ++++++++++++++++
 drivers/{staging => }/iio/cdc/ad7746.c                   |  2 +-
 drivers/staging/iio/cdc/Kconfig                          | 10 ----------
 {drivers/staging => include/linux}/iio/cdc/ad7746.h      |  4 ----
 6 files changed, 18 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/{staging => }/iio/cdc/ad7746.txt (100%)
 create mode 100644 drivers/iio/cdc/Kconfig
 rename drivers/{staging => }/iio/cdc/ad7746.c (99%)
 rename {drivers/staging => include/linux}/iio/cdc/ad7746.h (88%)

diff --git a/Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt b/Documentation/devicetree/bindings/iio/cdc/ad7746.txt
similarity index 100%
rename from Documentation/devicetree/bindings/staging/iio/cdc/ad7746.txt
rename to Documentation/devicetree/bindings/iio/cdc/ad7746.txt
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b3c8c6e..d1c309b 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -71,6 +71,7 @@ config IIO_TRIGGERED_EVENT
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
+source "drivers/iio/cdc/Kconfig"
 source "drivers/iio/chemical/Kconfig"
 source "drivers/iio/common/Kconfig"
 source "drivers/iio/counter/Kconfig"
diff --git a/drivers/iio/cdc/Kconfig b/drivers/iio/cdc/Kconfig
new file mode 100644
index 0000000..d3a8600
--- /dev/null
+++ b/drivers/iio/cdc/Kconfig
@@ -0,0 +1,16 @@
+#
+# CDC drivers
+#
+menu "Capacitance to digital converters"
+
+config AD7746
+	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7746.
+
+endmenu
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
similarity index 99%
rename from drivers/staging/iio/cdc/ad7746.c
rename to drivers/iio/cdc/ad7746.c
index c1f76fc..23c9f61 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -18,8 +18,8 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/cdc/ad7746.h>
 
-#include "ad7746.h"
 
 /*
  * AD7746 Register Definition
diff --git a/drivers/staging/iio/cdc/Kconfig b/drivers/staging/iio/cdc/Kconfig
index 80211df..a170ab3 100644
--- a/drivers/staging/iio/cdc/Kconfig
+++ b/drivers/staging/iio/cdc/Kconfig
@@ -23,14 +23,4 @@ config AD7152
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7152.
 
-config AD7746
-	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7746.
-
 endmenu
diff --git a/drivers/staging/iio/cdc/ad7746.h b/include/linux/iio/cdc/ad7746.h
similarity index 88%
rename from drivers/staging/iio/cdc/ad7746.h
rename to include/linux/iio/cdc/ad7746.h
index 2fbcee8..46ff25e 100644
--- a/drivers/staging/iio/cdc/ad7746.h
+++ b/include/linux/iio/cdc/ad7746.h
@@ -9,10 +9,6 @@
 #ifndef IIO_CDC_AD7746_H_
 #define IIO_CDC_AD7746_H_
 
-/*
- * TODO: struct ad7746_platform_data needs to go into include/linux/iio
- */
-
 struct ad7746_platform_data {
 	unsigned char exclvl;	/*Excitation Voltage Level */
 	bool exca_en;		/* enables EXCA pin as the excitation output */
-- 
2.7.4

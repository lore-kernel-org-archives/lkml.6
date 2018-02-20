Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeBTFZ1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:25:27 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42835 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBTFZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:25:10 -0500
X-Google-Smtp-Source: AH8x226dXAH5xVVRFDPgf91fyCB7eMAZy2qVOrsc4muZ+xAJMOCFu/pI8SF0aDm2DFrFZiiQw727ow==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] platform/x86: fujitsu-laptop: Clean up constants
Date: Tue, 20 Feb 2018 06:24:54 +0100
Message-Id: <20180220052454.11134-8-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
References: <20180220052454.11134-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align all constant values defined in the module to a common indentation.
Rename ACPI_FUJITSU_NOTIFY_CODE1 to ACPI_FUJITSU_NOTIFY_CODE as there is
only one ACPI notification code used throughout the driver.  Define all
bitmasks using the BIT() macro.  Clean up comments.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 66 ++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 6b0484cbdcf2..13bcdfea5349 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -53,6 +53,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/bitops.h>
 #include <linux/dmi.h>
 #include <linux/backlight.h>
 #include <linux/fb.h>
@@ -63,9 +64,9 @@
 #include <linux/platform_device.h>
 #include <acpi/video.h>
 
-#define FUJITSU_DRIVER_VERSION "0.6.0"
+#define FUJITSU_DRIVER_VERSION		"0.6.0"
 
-#define FUJITSU_LCD_N_LEVELS 8
+#define FUJITSU_LCD_N_LEVELS		8
 
 #define ACPI_FUJITSU_CLASS		"fujitsu"
 #define ACPI_FUJITSU_BL_HID		"FUJ02B1"
@@ -75,46 +76,47 @@
 #define ACPI_FUJITSU_LAPTOP_DRIVER_NAME	"Fujitsu laptop FUJ02E3 ACPI hotkeys driver"
 #define ACPI_FUJITSU_LAPTOP_DEVICE_NAME	"Fujitsu FUJ02E3"
 
-#define ACPI_FUJITSU_NOTIFY_CODE1     0x80
+#define ACPI_FUJITSU_NOTIFY_CODE	0x80
 
 /* FUNC interface - command values */
-#define FUNC_FLAGS	0x1000
-#define FUNC_LEDS	0x1001
-#define FUNC_BUTTONS	0x1002
-#define FUNC_BACKLIGHT  0x1004
+#define FUNC_FLAGS			BIT(12)
+#define FUNC_LEDS			(BIT(12) | BIT(0))
+#define FUNC_BUTTONS			(BIT(12) | BIT(1))
+#define FUNC_BACKLIGHT			(BIT(12) | BIT(2))
 
 /* FUNC interface - responses */
-#define UNSUPPORTED_CMD 0x80000000
+#define UNSUPPORTED_CMD			BIT(31)
 
 /* FUNC interface - status flags */
-#define FLAG_RFKILL	0x020
-#define FLAG_LID	0x100
-#define FLAG_DOCK	0x200
+#define FLAG_RFKILL			BIT(5)
+#define FLAG_LID			BIT(8)
+#define FLAG_DOCK			BIT(9)
 
 /* FUNC interface - LED control */
-#define FUNC_LED_OFF	0x1
-#define FUNC_LED_ON	0x30001
-#define KEYBOARD_LAMPS	0x100
-#define LOGOLAMP_POWERON 0x2000
-#define LOGOLAMP_ALWAYS  0x4000
-#define RADIO_LED_ON	0x20
-#define ECO_LED	0x10000
-#define ECO_LED_ON	0x80000
+#define FUNC_LED_OFF			BIT(0)
+#define FUNC_LED_ON			(BIT(0) | BIT(16) | BIT(17))
+#define LOGOLAMP_POWERON		BIT(13)
+#define LOGOLAMP_ALWAYS			BIT(14)
+#define KEYBOARD_LAMPS			BIT(8)
+#define RADIO_LED_ON			BIT(5)
+#define ECO_LED				BIT(16)
+#define ECO_LED_ON			BIT(19)
 
 /* FUNC interface - backlight power control */
-#define BACKLIGHT_PARAM_POWER	0x4
-#define BACKLIGHT_OFF	0x3
-#define BACKLIGHT_ON	0x0
+#define BACKLIGHT_PARAM_POWER		BIT(2)
+#define BACKLIGHT_OFF			(BIT(0) | BIT(1))
+#define BACKLIGHT_ON			0
 
-/* Hotkey details */
-#define KEY1_CODE	0x410	/* codes for the keys in the GIRB register */
-#define KEY2_CODE	0x411
-#define KEY3_CODE	0x412
-#define KEY4_CODE	0x413
-#define KEY5_CODE	0x420
+/* Scancodes read from the GIRB register */
+#define KEY1_CODE			0x410
+#define KEY2_CODE			0x411
+#define KEY3_CODE			0x412
+#define KEY4_CODE			0x413
+#define KEY5_CODE			0x420
 
-#define MAX_HOTKEY_RINGBUFFER_SIZE 100
-#define RINGBUFFERSIZE 40
+/* Hotkey ringbuffer limits */
+#define MAX_HOTKEY_RINGBUFFER_SIZE	100
+#define RINGBUFFERSIZE			40
 
 /* Module parameters */
 static int use_alt_lcd_levels = -1;
@@ -428,7 +430,7 @@ static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 event)
 	struct fujitsu_bl *priv = acpi_driver_data(device);
 	int oldb, newb;
 
-	if (event != ACPI_FUJITSU_NOTIFY_CODE1) {
+	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
 		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
 				 event);
 		sparse_keymap_report_event(priv->input, -1, 1, true);
@@ -902,7 +904,7 @@ static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
 	int scancode, i = 0;
 	unsigned int irb;
 
-	if (event != ACPI_FUJITSU_NOTIFY_CODE1) {
+	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
 		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
 				 event);
 		sparse_keymap_report_event(priv->input, -1, 1, true);
-- 
2.16.1

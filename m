Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBTF0g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:26:36 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40047 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeBTFZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:25:03 -0500
X-Google-Smtp-Source: AH8x227Vvm5Um3pakqNoDM8rDL7AEzgy/sXJ2mrAby8otUElslPi2lswapZP53oq48oU524lIwp3Ng==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] platform/x86: fujitsu-laptop: Unify local variable naming
Date: Tue, 20 Feb 2018 06:24:48 +0100
Message-Id: <20180220052454.11134-2-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
References: <20180220052454.11134-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Different functions in the module use varying names (error, result,
status) for a local variable storing the return value of a function call
that has to be checked for errors.  Use a common name (ret) for all
these local variables to improve code consistency.  Merge integer
variable declarations in acpi_fujitsu_laptop_add() into one line.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 85 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 2cfbd3fa5136..b5f782807bfa 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -385,7 +385,7 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 static int acpi_fujitsu_bl_add(struct acpi_device *device)
 {
 	struct fujitsu_bl *priv;
-	int error;
+	int ret;
 
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return -ENODEV;
@@ -399,9 +399,9 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
 	device->driver_data = priv;
 
-	error = acpi_fujitsu_bl_input_setup(device);
-	if (error)
-		return error;
+	ret = acpi_fujitsu_bl_input_setup(device);
+	if (ret)
+		return ret;
 
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
@@ -410,9 +410,9 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 		priv->max_brightness = FUJITSU_LCD_N_LEVELS;
 	get_lcd_level(device);
 
-	error = fujitsu_backlight_register(device);
-	if (error)
-		return error;
+	ret = fujitsu_backlight_register(device);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -693,7 +693,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 	struct led_classdev *led;
-	int result;
+	int ret;
 
 	if (call_fext_func(device,
 			   FUNC_LEDS, 0x0, 0x0, 0x0) & LOGOLAMP_POWERON) {
@@ -704,9 +704,9 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 		led->name = "fujitsu::logolamp";
 		led->brightness_set_blocking = logolamp_set;
 		led->brightness_get = logolamp_get;
-		result = devm_led_classdev_register(&device->dev, led);
-		if (result)
-			return result;
+		ret = devm_led_classdev_register(&device->dev, led);
+		if (ret)
+			return ret;
 	}
 
 	if ((call_fext_func(device,
@@ -719,9 +719,9 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 		led->name = "fujitsu::kblamps";
 		led->brightness_set_blocking = kblamps_set;
 		led->brightness_get = kblamps_get;
-		result = devm_led_classdev_register(&device->dev, led);
-		if (result)
-			return result;
+		ret = devm_led_classdev_register(&device->dev, led);
+		if (ret)
+			return ret;
 	}
 
 	/*
@@ -742,9 +742,9 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 		led->brightness_set_blocking = radio_led_set;
 		led->brightness_get = radio_led_get;
 		led->default_trigger = "rfkill-any";
-		result = devm_led_classdev_register(&device->dev, led);
-		if (result)
-			return result;
+		ret = devm_led_classdev_register(&device->dev, led);
+		if (ret)
+			return ret;
 	}
 
 	/* Support for eco led is not always signaled in bit corresponding
@@ -762,9 +762,9 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 		led->name = "fujitsu::eco_led";
 		led->brightness_set_blocking = eco_led_set;
 		led->brightness_get = eco_led_get;
-		result = devm_led_classdev_register(&device->dev, led);
-		if (result)
-			return result;
+		ret = devm_led_classdev_register(&device->dev, led);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -773,8 +773,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv;
-	int error;
-	int i;
+	int ret, i = 0;
 
 	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -789,23 +788,22 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 
 	/* kfifo */
 	spin_lock_init(&priv->fifo_lock);
-	error = kfifo_alloc(&priv->fifo, RINGBUFFERSIZE * sizeof(int),
-			    GFP_KERNEL);
-	if (error) {
+	ret = kfifo_alloc(&priv->fifo, RINGBUFFERSIZE * sizeof(int),
+			  GFP_KERNEL);
+	if (ret) {
 		pr_err("kfifo_alloc failed\n");
 		goto err_stop;
 	}
 
-	error = acpi_fujitsu_laptop_input_setup(device);
-	if (error)
+	ret = acpi_fujitsu_laptop_input_setup(device);
+	if (ret)
 		goto err_free_fifo;
 
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
 
-	i = 0;
-	while (call_fext_func(device, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0
-		&& (i++) < MAX_HOTKEY_RINGBUFFER_SIZE)
+	while (call_fext_func(device, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0 &&
+	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
 		; /* No action, result is discarded */
 	acpi_handle_debug(device->handle, "Discarded %i ringbuffer entries\n",
 			  i);
@@ -835,12 +833,12 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 			fujitsu_bl->bl_device->props.power = FB_BLANK_UNBLANK;
 	}
 
-	error = acpi_fujitsu_laptop_leds_register(device);
-	if (error)
+	ret = acpi_fujitsu_laptop_leds_register(device);
+	if (ret)
 		goto err_free_fifo;
 
-	error = fujitsu_laptop_platform_add(device);
-	if (error)
+	ret = fujitsu_laptop_platform_add(device);
+	if (ret)
 		goto err_free_fifo;
 
 	return 0;
@@ -848,7 +846,7 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 err_free_fifo:
 	kfifo_free(&priv->fifo);
 err_stop:
-	return error;
+	return ret;
 }
 
 static int acpi_fujitsu_laptop_remove(struct acpi_device *device)
@@ -865,11 +863,11 @@ static int acpi_fujitsu_laptop_remove(struct acpi_device *device)
 static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
-	int status;
+	int ret;
 
-	status = kfifo_in_locked(&priv->fifo, (unsigned char *)&scancode,
-				 sizeof(scancode), &priv->fifo_lock);
-	if (status != sizeof(scancode)) {
+	ret = kfifo_in_locked(&priv->fifo, (unsigned char *)&scancode,
+			      sizeof(scancode), &priv->fifo_lock);
+	if (ret != sizeof(scancode)) {
 		dev_info(&priv->input->dev, "Could not push scancode [0x%x]\n",
 			 scancode);
 		return;
@@ -882,13 +880,12 @@ static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
 static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
-	int scancode, status;
+	int scancode, ret;
 
 	while (true) {
-		status = kfifo_out_locked(&priv->fifo,
-					  (unsigned char *)&scancode,
-					  sizeof(scancode), &priv->fifo_lock);
-		if (status != sizeof(scancode))
+		ret = kfifo_out_locked(&priv->fifo, (unsigned char *)&scancode,
+				       sizeof(scancode), &priv->fifo_lock);
+		if (ret != sizeof(scancode))
 			return;
 		sparse_keymap_report_event(priv->input, scancode, 0, false);
 		dev_dbg(&priv->input->dev,
-- 
2.16.1

Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03253C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A0D22B72
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0D22B72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932894AbeGCPx5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:53:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37508 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932357AbeGCPx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:53:56 -0400
Received: from localhost ([91.52.186.254]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0LhGOe-1fwG1h313A-00mdcB; Tue, 03 Jul 2018 17:53:29 +0200
Date:   Tue, 3 Jul 2018 17:53:28 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, ak@it-klinger.de,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v2] leds: ledtrig-morse: send out morse code
Message-ID: <20180703155328.GA18299@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:TLVbpNk+rGYqLwODsCkGal2S6JipqKI7wPSzdjBg2ruvCwmieMr
 UDLqk3YPeSI3SoWRrMDZr+ee8XK7pJtVSb5kCXDrozKqSO2wvYm+FjF0zHAVYmlvi+HHXBH
 ix4YcFXfRRLTyuJDgA+zG1w9CspZp/kFSzObOF5t+VG038M9s+oNztJgQsjZPiRuZWriSrV
 anihUcU/QkSSUSUDzXnRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MZp3Jvqn47k=:BKk5I4356kFdepbs/+Gd7e
 z9H+i8WrzEBipmZLOn9Nieb+AGu4vCev86wWr93t5fDUAqoo2+tf51mjppxYlAJUFUt3atsuP
 cotOvfutWpqQWB2qMRolfKvOhVfCa19agKjv9ZblmhkGyXns89tILPiUK1182THBjDUJBhXZK
 7Th3iYJcanFQMdWbz59LiVNOFZpgxknEUsfpXS8hORtm0ftiEXVprIVGn9kgOvuhAktGpY3KW
 7wOdpn67Syd5K6VcWHdXYDTwQycaevYQ73LQ40+DxAFH9Bqrvf5N7S+URkxGe4d8E9j0DaCnX
 bGYt+eaaABJpeLQucY5wKqNgoTNivQJ2pT6gtD2yNclbsWOTT5baKpRUPJyWQs5tisEWaciXz
 yllV4EStfuw3kncQ8cKHX63Mh6mfDwRcZpMipCkkd4Z0OYZIZyp7Hr/WfRCfT/K9m7fOEVKaL
 NL5HoivfFIYod8HcYmsUdUbQozyKmHy47GYqvP5byQ5hCHEgxHDWAfwnOcP38v3mfUH9z0U3N
 k9mngILsgGu7xXlm6P48x+2JF8ol+8bX4INkBDdxNGVr8Q37TYJj13rciuBPw14u1rMKk5v9m
 dwLN28T4xHEzOW89hvFnZsy/vwFioXVgx5k2aVJeZ3DcjkLxzRRzQrnoOmrdzF+E60ThrwsOa
 sc9gLY+wuQKe4F57Zw2Wb4HH/L2Nt0Y5egvngVOpihjKKI0h3y3bukh9GtAywiTPQIBY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send out a morse code by using LEDs.

This is useful especially on embedded systems without displays to tell the
user about error conditions and status information.

The trigger will be called "morse"

The string to be send is written into the file morse_string and sent out
with a workqueue. Supported are letters and digits.

With the file dot_unit the minimal time unit can be adjusted in
milliseconds.

Also add documentation for the morse led trigger

Thanks to Greg and Geert for suggesting improvements

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../ABI/testing/sysfs-class-led-trigger-morse      |  16 ++
 drivers/leds/trigger/Kconfig                       |  10 +
 drivers/leds/trigger/Makefile                      |   1 +
 drivers/leds/trigger/ledtrig-morse.c               | 298 +++++++++++++++++++++
 4 files changed, 325 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-morse
 create mode 100644 drivers/leds/trigger/ledtrig-morse.c

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-morse b/Documentation/ABI/testing/sysfs-class-led-trigger-morse
new file mode 100644
index 000000000000..dd858e18aef5
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-morse
@@ -0,0 +1,16 @@
+What:		/sys/class/leds/<led>/morse_string
+Date:		Jul 2018
+KernelVersion:	4.19
+Contact:	linux-leds@vger.kernel.org
+Description:
+		A string containing alphanumeric characters written to this
+		file is send out as morse code through a LED
+
+What:		/sys/class/leds/<led>/dot_unit
+Date:		Jul 2018
+KernelVersion:	4.19
+Contact:	linux-leds@vger.kernel.org
+Description:
+		Specifies the smallest amount of time in milliseconds of
+		the morse code sent out.
+		Default is 500 ms
diff --git a/drivers/leds/trigger/Kconfig b/drivers/leds/trigger/Kconfig
index a2559b4fdfff..ea706ef2354c 100644
--- a/drivers/leds/trigger/Kconfig
+++ b/drivers/leds/trigger/Kconfig
@@ -142,4 +142,14 @@ config LEDS_TRIGGER_NETDEV
 	  This allows LEDs to be controlled by network device activity.
 	  If unsure, say Y.
 
+config LEDS_TRIGGER_MORSE
+	tristate "LED Morse Trigger"
+	depends on LEDS_TRIGGERS
+	help
+	  This allows to send a morse code through LEDs.
+	  It is useful especially in embedded systems when there is only
+	  little interface to tell the user error or status codes. Sending
+	  a morse code can be an alternative here.
+	  If unsure, say Y.
+
 endif # LEDS_TRIGGERS
diff --git a/drivers/leds/trigger/Makefile b/drivers/leds/trigger/Makefile
index f3cfe1950538..5735381cc3d3 100644
--- a/drivers/leds/trigger/Makefile
+++ b/drivers/leds/trigger/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_LEDS_TRIGGER_TRANSIENT)	+= ledtrig-transient.o
 obj-$(CONFIG_LEDS_TRIGGER_CAMERA)	+= ledtrig-camera.o
 obj-$(CONFIG_LEDS_TRIGGER_PANIC)	+= ledtrig-panic.o
 obj-$(CONFIG_LEDS_TRIGGER_NETDEV)	+= ledtrig-netdev.o
+obj-$(CONFIG_LEDS_TRIGGER_MORSE)	+= ledtrig-morse.o
diff --git a/drivers/leds/trigger/ledtrig-morse.c b/drivers/leds/trigger/ledtrig-morse.c
new file mode 100644
index 000000000000..46f1b9d38310
--- /dev/null
+++ b/drivers/leds/trigger/ledtrig-morse.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ledtrig-morse: LED Morse Trigger
+ *
+ * send a string as morse code out through LEDs
+ *
+ * can be used to send error codes or messages
+ *
+ * string to be send is written into morse_string
+ * supported are letters and digits
+ *
+ * Author: Andreas Klinger <ak@it-klinger.de>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/ctype.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/leds.h>
+
+
+#define MORSE_DOT_UNIT_DEFAULT	500
+#define MORSE_TELEGRAM_SIZE	100
+
+struct morse_data {
+	unsigned int		dot_unit;
+	struct led_classdev	*led_cdev;
+	struct work_struct	work;
+	char			telegram[MORSE_TELEGRAM_SIZE];
+	unsigned int		telegram_size;
+	struct mutex		lock;
+};
+
+struct morse_char {
+	char	c;
+	char	*z;
+};
+
+static struct morse_char morse_table[] = {
+	{'a', ".-"},
+	{'b', "-..."},
+	{'c', "-.-."},
+	{'d', "-.."},
+	{'e', "."},
+	{'f', "..-."},
+	{'g', "--."},
+	{'h', "...."},
+	{'i', ".."},
+	{'j', ".---"},
+	{'k', "-.-"},
+	{'l', ".-.."},
+	{'m', "--"},
+	{'n', "-."},
+	{'o', "---"},
+	{'p', ".--."},
+	{'q', "--.-"},
+	{'r', ".-."},
+	{'s', "..."},
+	{'t', "-"},
+	{'u', "..-"},
+	{'v', "...-"},
+	{'w', ".--"},
+	{'x', "-..-"},
+	{'y', "-.--"},
+	{'z', "--.."},
+	{'1', ".----"},
+	{'2', "..---"},
+	{'3', "...--"},
+	{'4', "....-"},
+	{'5', "....."},
+	{'6', "-...."},
+	{'7', "--..."},
+	{'8', "---.."},
+	{'9', "----."},
+	{'0', "-----"},
+	{0, NULL},
+};
+
+static void morse_long(struct led_classdev *led_cdev)
+{
+	struct morse_data *data = led_cdev->trigger_data;
+
+	led_set_brightness(led_cdev, LED_ON);
+	msleep(3 * data->dot_unit);
+	led_set_brightness(led_cdev, LED_OFF);
+	msleep(data->dot_unit);
+}
+
+static void morse_short(struct led_classdev *led_cdev)
+{
+	struct morse_data *data = led_cdev->trigger_data;
+
+	led_set_brightness(led_cdev, LED_ON);
+	msleep(data->dot_unit);
+	led_set_brightness(led_cdev, LED_OFF);
+	msleep(data->dot_unit);
+}
+
+static void morse_letter_space(struct led_classdev *led_cdev)
+{
+	struct morse_data *data = led_cdev->trigger_data;
+	/*
+	 * Pause: 3 dot spaces
+	 * 1 dot space already there from morse character
+	 */
+	msleep(2 * data->dot_unit);
+}
+
+static void morse_word_space(struct led_classdev *led_cdev)
+{
+	struct morse_data *data = led_cdev->trigger_data;
+	/*
+	 * Pause: 7 dot spaces
+	 * 1 dot space already there from morse character
+	 * 2 dot spaces already there from letter space
+	 */
+	msleep(4 * data->dot_unit);
+}
+
+static void morse_send_char(struct led_classdev *led_cdev, char ch)
+{
+	unsigned int i = 0;
+
+	while ((morse_table[i].c) && (morse_table[i].c != tolower(ch)))
+		i++;
+
+	if (morse_table[i].c) {
+		unsigned int j = 0;
+
+		while (morse_table[i].z[j]) {
+			switch (morse_table[i].z[j]) {
+			case '.':
+				morse_short(led_cdev);
+				break;
+			case '-':
+				morse_long(led_cdev);
+				break;
+			}
+			j++;
+		}
+		morse_letter_space(led_cdev);
+	} else {
+		/*
+		 * keep it simple:
+		 * whenever there is an unrecognized character make a word
+		 * space
+		 */
+		morse_word_space(led_cdev);
+	}
+}
+
+static void morse_work(struct work_struct *work)
+{
+	struct morse_data *data = container_of(work, struct morse_data, work);
+	unsigned int i;
+
+	mutex_lock(&data->lock);
+
+	for (i = 0; i < data->telegram_size; i++)
+		morse_send_char(data->led_cdev, data->telegram[i]);
+
+	mutex_unlock(&data->lock);
+}
+
+static ssize_t morse_string_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct morse_data *data = led_cdev->trigger_data;
+
+	if (size >= sizeof(data->telegram))
+		return -E2BIG;
+
+	mutex_lock(&data->lock);
+
+	memcpy(data->telegram, buf, size);
+	data->telegram_size = size;
+
+	mutex_unlock(&data->lock);
+
+	schedule_work(&data->work);
+
+	return size;
+}
+
+static DEVICE_ATTR_WO(morse_string);
+
+static ssize_t dot_unit_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct morse_data *data = led_cdev->trigger_data;
+
+	return sprintf(buf, "%u\n", data->dot_unit);
+}
+
+static ssize_t dot_unit_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct morse_data *data = led_cdev->trigger_data;
+	unsigned long dot_unit;
+	ssize_t ret = -EINVAL;
+
+	ret = kstrtoul(buf, 10, &dot_unit);
+	if (ret)
+		return ret;
+
+	data->dot_unit = dot_unit;
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(dot_unit);
+
+static void morse_trig_activate(struct led_classdev *led_cdev)
+{
+	int rc;
+	struct morse_data *data;
+
+	data = kzalloc(sizeof(struct morse_data), GFP_KERNEL);
+	if (!data) {
+		dev_err(led_cdev->dev, "unable to allocate morse trigger\n");
+		return;
+	}
+
+	led_cdev->trigger_data = data;
+	data->led_cdev = led_cdev;
+	data->dot_unit = MORSE_DOT_UNIT_DEFAULT;
+
+	rc = device_create_file(led_cdev->dev, &dev_attr_morse_string);
+	if (rc)
+		goto err_out_data;
+
+	rc = device_create_file(led_cdev->dev, &dev_attr_dot_unit);
+	if (rc)
+		goto err_out_morse_string;
+
+	INIT_WORK(&data->work, morse_work);
+
+	mutex_init(&data->lock);
+
+	led_set_brightness(led_cdev, LED_OFF);
+	led_cdev->activated = true;
+
+	return;
+
+err_out_data:
+	kfree(data);
+err_out_morse_string:
+	device_remove_file(led_cdev->dev, &dev_attr_morse_string);
+}
+
+static void morse_trig_deactivate(struct led_classdev *led_cdev)
+{
+	struct morse_data *data = led_cdev->trigger_data;
+
+	if (led_cdev->activated) {
+
+		cancel_work_sync(&data->work);
+
+		device_remove_file(led_cdev->dev, &dev_attr_morse_string);
+		device_remove_file(led_cdev->dev, &dev_attr_dot_unit);
+
+		kfree(data);
+
+		led_cdev->trigger_data = NULL;
+		led_cdev->activated = false;
+	}
+}
+
+static struct led_trigger morse_led_trigger = {
+	.name     = "morse",
+	.activate = morse_trig_activate,
+	.deactivate = morse_trig_deactivate,
+};
+
+static int __init morse_trig_init(void)
+{
+	return led_trigger_register(&morse_led_trigger);
+}
+
+static void __exit morse_trig_exit(void)
+{
+	led_trigger_unregister(&morse_led_trigger);
+}
+
+module_init(morse_trig_init);
+module_exit(morse_trig_exit);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("Morse code LED trigger");
+MODULE_LICENSE("GPL");
-- 
2.1.4

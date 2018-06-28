Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BF4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9EB2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9EB2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966203AbeF1Nm4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:42:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33254 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965245AbeF1Nmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:42:54 -0400
Received: from localhost ([109.250.161.29]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MBG3l-1fOs1R43Xx-00AE51; Thu, 28 Jun 2018 15:42:29 +0200
Date:   Thu, 28 Jun 2018 15:42:27 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz, ben.whitten@gmail.com,
        geert+renesas@glider.be, w@1wt.eu, ak@it-klinger.de,
        pombredanne@nexb.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH] leds: ledtrig-morse: send out morse code
Message-ID: <20180628134227.GA1719@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:R2ydNbmH4FtQeSwoXj0OmDACqrb6nGRhxTRpnEbcHFLv16wtCK/
 5Jy50NZGl7bAI6FYIFDf9vGBxdfz0QgssU0HAY12QKIXTFIxj94hMznvFXLJN/JnPeweX1i
 a2cUP/yUHz73kpu8c34L8UNbCNyn8KV6bdbg4bSJHVZInnKoXaop1Mdf+aIAawTWga+t44v
 a/CUla2Nv7xpkbqkCkWSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XUW0VNBnNVM=:TgCucpuo+q7aCV0W5WB/hJ
 MOQGDbUK/r1NiCH4ucfBvyKowmOhWiohJ6Yt9Kg+Sr1FIjH4iA7sNWLi1XVDhiMovD9QV6Yy9
 jG3d9bp4sn5RMB4xTaHlhnaf6ocZforR8FC+pcQ98x8UrGUAJpSf2B8YIItx45QHlPSm1SfYu
 UxM+RpKAwU2Q3EMrLK4CcDubMr+tfL69HFw/3qEB9N7/kE0mIiCS82/20Xs9JOsayk2O4c7Vp
 Wmfi6MJ1EiRYrKqm9i5WJSY4vKjwqaia4QjXyElrL6i76UNFaVbDqxmRRtGzt0ikGPE3ZXecu
 x0BHOphnPN/xerO5vLglCIZULYFZjZCSgnRvJqD2LgngiDWN5GMob9I0CZHWIf9M3J9ElcKwl
 HDCe7NSRt+HU6bVC6wK3CkhnFh9lpWpKeUB7Gq/tw/O1Ef/wpM7FXNxbbS84gb7+Ug8FCNAyH
 2xuvpbsPkmhi8aDMzqMso+YdDfLjgIhj66/XvR0b/siGDm2AwE6HL7QgQWwZ1dTf5VWUGieJF
 TjrhbznO71taFcN0umT74EBoLQi/niS29OSR82U8uMhAH4HKRn300oOpFkhgLjaIcE5VJwIg1
 NhD/lQ8HlNZIHHVe52IaCzrrdFZ82Lns4EDTdKceZ5ZWHvqWZ5TrfOzGQgCNqsfMCdq9ZHzZP
 Q+nhVyZGxfIz3zAXJK1WEZSBfiiFq02loLQXf21xqTQaBsWM2O5ZWRknmVGQZSc8V2ao=
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

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/leds/trigger/Kconfig         |  10 ++
 drivers/leds/trigger/Makefile        |   1 +
 drivers/leds/trigger/ledtrig-morse.c | 298 +++++++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+)
 create mode 100644 drivers/leds/trigger/ledtrig-morse.c

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
index 000000000000..77f6ee502ebe
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
+	{'a', ".-S"},
+	{'b', "-...S"},
+	{'c', "-.-.S"},
+	{'d', "-..S"},
+	{'e', ".S"},
+	{'f', "..-.S"},
+	{'g', "--.S"},
+	{'h', "....S"},
+	{'i', "..S"},
+	{'j', ".---S"},
+	{'k', "-.-S"},
+	{'l', ".-..S"},
+	{'m', "--S"},
+	{'n', "-.S"},
+	{'o', "---S"},
+	{'p', ".--.S"},
+	{'q', "--.-S"},
+	{'r', ".-.S"},
+	{'s', "...S"},
+	{'t', "-S"},
+	{'u', "..-S"},
+	{'v', "...-S"},
+	{'w', ".--S"},
+	{'x', "-..-S"},
+	{'y', "-.--S"},
+	{'z', "--..S"},
+	{'1', ".----S"},
+	{'2', "..---S"},
+	{'3', "...--S"},
+	{'4', "....-S"},
+	{'5', ".....S"},
+	{'6', "-....S"},
+	{'7', "--...S"},
+	{'8', "---..S"},
+	{'9', "----.S"},
+	{'0', "-----S"},
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
+	int i = 0;
+
+	while ((morse_table[i].c) && (morse_table[i].c != tolower(ch)))
+		i++;
+
+	if (morse_table[i].c) {
+		int j = 0;
+
+		while (morse_table[i].z[j] != 'S') {
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
+	int i;
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

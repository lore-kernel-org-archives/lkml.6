Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD38213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJh1ms3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfBYQ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:58:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35832 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfBYQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:58:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id m73so1858498lfa.2;
        Mon, 25 Feb 2019 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdwfebtoOmH5KX+9AXhnrkP2tj7MSVN2ZpppR7mmxVY=;
        b=hJh1ms3QX/SHVBP/JM2fzMUySkprJ2dRqoVY5TLtyNoJ2VsRO6RnOELXRR+9H9/Tp2
         KojrnR5slLHkwy7LAB+nGxVF48RDSWOvjRxl6vxgC/7rsyM3Z9EeA405Gh8NH2uaRGqf
         YOqo/pReMOosPGx4v+xrgTrZZpJR235Nth9NCo0XWp7iSXEyzdjT1Vi7B3y9khjApxff
         TCpwoMFHrGBRDmP/aoRq81QlmeiBhjg8gDXaR7AQrSV7kp/oxPxQ0ZRPwcuoWkWx+b2F
         XEZnN/Kv+mIB8JgQe10hyc3ACZNYOuvg3rPoFY1o0ARkZnZ0IvtqUnxUH55zeclt02DO
         O1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdwfebtoOmH5KX+9AXhnrkP2tj7MSVN2ZpppR7mmxVY=;
        b=LR8DQOKFtVkdlZoz1NJFxUDt/liUdFwgev1qkQfiQhvalWgZlMp/hO7seaN1kVlc6X
         TaYpN7RCXe78Mn6UAApTuDlD9qACy9XB4dkulexQuZQCEK7PxH/tlhFUX9jencBKisBM
         elHV9jT/G80fsk+vuwCznZZJgBp46tvq0vDKwtPi9cOrpj2N7Qr9zrWA9rsQ24ZJdZG2
         BR9jENzcQiyH1mrJ2SeKFrzBMn/4vX2e/t9PHY3V8CQCb9/GcYyru4LnONxoauFik5o1
         FTeg0qNpksUtfpGlc2zy2Ud+hp9nL3YZZUDNPLTgA4xqxR7xw4PXOTDxZIQZHjrwUfq8
         8WoQ==
X-Gm-Message-State: AHQUAuZuwxb0CgEykJR3eXjDJ0K2pNvN+zwrTSiIqgZ3d/NbIZ5ai/5R
        c/HJFuFINCEe2mp6Plk5Qoc=
X-Google-Smtp-Source: AHgI3IYGBWY3Fo07Ym/KJYu2VC8BPafxu65aAp5iBN0l88arV5AO5LOKsrZBuNgKiVlaMG5Px4+CdA==
X-Received: by 2002:a19:c409:: with SMTP id u9mr4030007lff.32.1551113909992;
        Mon, 25 Feb 2019 08:58:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:780d:6cb1:e20:559d])
        by smtp.googlemail.com with ESMTPSA id l30sm2597575lfk.83.2019.02.25.08.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 08:58:29 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/2] extcon: Add fsa9480 extcon driver
Date:   Mon, 25 Feb 2019 17:58:22 +0100
Message-Id: <20190225165822.2770-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190225165822.2770-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds extcon driver for Fairchild Semiconductor FSA9480
microUSB switch.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/extcon/Kconfig          |  10 +
 drivers/extcon/Makefile         |   1 +
 drivers/extcon/extcon-fsa9480.c | 473 ++++++++++++++++++++++++++++++++
 3 files changed, 484 insertions(+)
 create mode 100644 drivers/extcon/extcon-fsa9480.c

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index de15bf55895b..9904f993d39a 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -36,6 +36,16 @@ config EXTCON_AXP288
 	  Say Y here to enable support for USB peripheral detection
 	  and USB MUX switching by X-Power AXP288 PMIC.
 
+config EXTCON_FSA9480
+	tristate "FSA9480 EXTCON Support"
+	depends on INPUT
+	help
+	  If you say yes here you get support for the Fairchild Semiconductor
+	  FSA9480 microUSB switch and accessory detector chip. The FSA9480 is a USB
+	  port accessory detector and switch. The FSA9480 is fully controlled using
+	  I2C and enables USB data, stereo and mono audio, video, microphone
+	  and UART data to use a common connector port.
+
 config EXTCON_GPIO
 	tristate "GPIO extcon support"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index 0888fdeded72..0a3a96d92a28 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -8,6 +8,7 @@ extcon-core-objs		+= extcon.o devres.o
 obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
 obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
 obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
+obj-$(CONFIG_EXTCON_FSA9480)	+= extcon-fsa9480.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
 obj-$(CONFIG_EXTCON_INTEL_INT3496) += extcon-intel-int3496.o
 obj-$(CONFIG_EXTCON_INTEL_CHT_WC) += extcon-intel-cht-wc.o
diff --git a/drivers/extcon/extcon-fsa9480.c b/drivers/extcon/extcon-fsa9480.c
new file mode 100644
index 000000000000..5c58f3e3f0e4
--- /dev/null
+++ b/drivers/extcon/extcon-fsa9480.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * extcon-fsa9480.c - Fairchild Semiconductor FSA9480 extcon driver
+ *
+ * Copyright (c) 2014 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Loosely based on old fsa9480 misc-device driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/kobject.h>
+#include <linux/extcon-provider.h>
+#include <linux/irqdomain.h>
+
+/* FSA9480 I2C registers */
+#define FSA9480_REG_DEVID               0x01
+#define FSA9480_REG_CTRL                0x02
+#define FSA9480_REG_INT1                0x03
+#define FSA9480_REG_INT2                0x04
+#define FSA9480_REG_INT1_MASK           0x05
+#define FSA9480_REG_INT2_MASK           0x06
+#define FSA9480_REG_ADC                 0x07
+#define FSA9480_REG_TIMING1             0x08
+#define FSA9480_REG_TIMING2             0x09
+#define FSA9480_REG_DEV_T1              0x0a
+#define FSA9480_REG_DEV_T2              0x0b
+#define FSA9480_REG_BTN1                0x0c
+#define FSA9480_REG_BTN2                0x0d
+#define FSA9480_REG_CK                  0x0e
+#define FSA9480_REG_CK_INT1             0x0f
+#define FSA9480_REG_CK_INT2             0x10
+#define FSA9480_REG_CK_INTMASK1         0x11
+#define FSA9480_REG_CK_INTMASK2         0x12
+#define FSA9480_REG_MANSW1              0x13
+#define FSA9480_REG_MANSW2              0x14
+
+/* Control */
+#define CON_SWITCH_OPEN         (1 << 4)
+#define CON_RAW_DATA            (1 << 3)
+#define CON_MANUAL_SW           (1 << 2)
+#define CON_WAIT                (1 << 1)
+#define CON_INT_MASK            (1 << 0)
+#define CON_MASK                (CON_SWITCH_OPEN | CON_RAW_DATA | \
+				 CON_MANUAL_SW | CON_WAIT)
+
+/* Device Type 1 */
+#define DEV_USB_OTG             7
+#define DEV_DEDICATED_CHG       6
+#define DEV_USB_CHG             5
+#define DEV_CAR_KIT             4
+#define DEV_UART                3
+#define DEV_USB                 2
+#define DEV_AUDIO_2             1
+#define DEV_AUDIO_1             0
+
+#define DEV_T1_USB_MASK         (DEV_USB_OTG | DEV_USB)
+#define DEV_T1_UART_MASK        (DEV_UART)
+#define DEV_T1_CHARGER_MASK     (DEV_DEDICATED_CHG | DEV_USB_CHG)
+
+/* Device Type 2 */
+#define DEV_AV                  14
+#define DEV_TTY                 13
+#define DEV_PPD                 12
+#define DEV_JIG_UART_OFF        11
+#define DEV_JIG_UART_ON         10
+#define DEV_JIG_USB_OFF         9
+#define DEV_JIG_USB_ON          8
+
+#define DEV_T2_USB_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON)
+#define DEV_T2_UART_MASK        (DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
+#define DEV_T2_JIG_MASK         (DEV_JIG_USB_OFF | DEV_JIG_USB_ON | \
+				 DEV_JIG_UART_OFF | DEV_JIG_UART_ON)
+
+/*
+ * Manual Switch
+ * D- [7:5] / D+ [4:2]
+ * 000: Open all / 001: USB / 010: AUDIO / 011: UART / 100: V_AUDIO
+ */
+#define SW_VAUDIO               ((4 << 5) | (4 << 2))
+#define SW_UART                 ((3 << 5) | (3 << 2))
+#define SW_AUDIO                ((2 << 5) | (2 << 2))
+#define SW_DHOST                ((1 << 5) | (1 << 2))
+#define SW_AUTO                 ((0 << 5) | (0 << 2))
+
+/* Interrupt 1 */
+#define INT1_MASK               (0xff << 0)
+#define INT_DETACH              (1 << 1)
+#define INT_ATTACH              (1 << 0)
+
+/* Interrupt 2 mask */
+#define INT2_MASK               (0x1f << 0)
+
+/* Timing Set 1 */
+#define TIMING1_ADC_500MS       (0x6 << 0)
+
+struct fsa9480_usbsw {
+	struct i2c_client *client;
+	struct extcon_dev *edev;
+	u16 dev;
+	u16 mansw;
+};
+
+static const unsigned int fsa9480_extcon_cable[] = {
+	EXTCON_USB_HOST,
+	EXTCON_USB,
+	EXTCON_CHG_USB_DCP,
+	EXTCON_CHG_USB_SDP,
+	EXTCON_CHG_USB_ACA,
+	EXTCON_JACK_LINE_OUT,
+	EXTCON_JACK_VIDEO_OUT,
+	EXTCON_JIG,
+
+	EXTCON_NONE,
+};
+
+static const u64 cable_types[] = {
+	[DEV_USB_OTG] = BIT_ULL(EXTCON_USB_HOST),
+	[DEV_DEDICATED_CHG] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_DCP),
+	[DEV_USB_CHG] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
+	[DEV_CAR_KIT] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP)
+			| BIT_ULL(EXTCON_JACK_LINE_OUT),
+	[DEV_UART] = BIT_ULL(EXTCON_JIG),
+	[DEV_USB] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_CHG_USB_SDP),
+	[DEV_AUDIO_2] = BIT_ULL(EXTCON_JACK_LINE_OUT),
+	[DEV_AUDIO_1] = BIT_ULL(EXTCON_JACK_LINE_OUT),
+	[DEV_AV] = BIT_ULL(EXTCON_JACK_LINE_OUT)
+		   | BIT_ULL(EXTCON_JACK_VIDEO_OUT),
+	[DEV_TTY] = BIT_ULL(EXTCON_JIG),
+	[DEV_PPD] = BIT_ULL(EXTCON_JACK_LINE_OUT) | BIT_ULL(EXTCON_CHG_USB_ACA),
+	[DEV_JIG_UART_OFF] = BIT_ULL(EXTCON_JIG),
+	[DEV_JIG_UART_ON] = BIT_ULL(EXTCON_JIG),
+	[DEV_JIG_USB_OFF] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
+	[DEV_JIG_USB_ON] = BIT_ULL(EXTCON_USB) | BIT_ULL(EXTCON_JIG),
+};
+
+static int fsa9480_write_reg(struct i2c_client *client, int reg, int value)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, reg, value);
+	if (ret < 0)
+		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int fsa9480_read_reg(struct i2c_client *client, int reg)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, reg);
+	if (ret < 0)
+		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int fsa9480_read_irq(struct i2c_client *client, int *value)
+{
+	u8 regs[2];
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, FSA9480_REG_INT1, 2, regs);
+	if (ret < 0)
+		dev_err(&client->dev, "%s: err %d\n", __func__, ret);
+
+	*value = regs[1] << 8 | regs[0];
+	return ret;
+}
+
+static void fsa9480_set_switch(struct i2c_client *client, const char *buf)
+{
+	struct  fsa9480_usbsw *usbsw = i2c_get_clientdata(client);
+	unsigned int value;
+	unsigned int path = 0;
+
+	value = fsa9480_read_reg(client, FSA9480_REG_CTRL);
+
+	if (!strncmp(buf, "VAUDIO", 6)) {
+		path = SW_VAUDIO;
+		value &= ~CON_MANUAL_SW;
+	} else if (!strncmp(buf, "UART", 4)) {
+		path = SW_UART;
+		value &= ~CON_MANUAL_SW;
+	} else if (!strncmp(buf, "AUDIO", 5)) {
+		path = SW_AUDIO;
+		value &= ~CON_MANUAL_SW;
+	} else if (!strncmp(buf, "DHOST", 5)) {
+		path = SW_DHOST;
+		value &= ~CON_MANUAL_SW;
+	} else if (!strncmp(buf, "AUTO", 4)) {
+		path = SW_AUTO;
+		value |= CON_MANUAL_SW;
+	} else {
+		dev_err(&client->dev, "Wrong command\n");
+		return;
+	}
+
+	usbsw->mansw = path;
+	fsa9480_write_reg(client, FSA9480_REG_MANSW1, path);
+	fsa9480_write_reg(client, FSA9480_REG_CTRL, value);
+}
+
+static ssize_t fsa9480_get_switch(struct i2c_client *client, char *buf)
+{
+	unsigned int value;
+
+	value = fsa9480_read_reg(client, FSA9480_REG_MANSW1);
+
+	if (value == SW_VAUDIO)
+		return sprintf(buf, "VAUDIO\n");
+	else if (value == SW_UART)
+		return sprintf(buf, "UART\n");
+	else if (value == SW_AUDIO)
+		return sprintf(buf, "AUDIO\n");
+	else if (value == SW_DHOST)
+		return sprintf(buf, "DHOST\n");
+	else if (value == SW_AUTO)
+		return sprintf(buf, "AUTO\n");
+	else
+		return sprintf(buf, "%x", value);
+}
+
+static ssize_t fsa9480_manualsw_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return fsa9480_get_switch(client, buf);
+
+}
+
+static ssize_t fsa9480_manualsw_set(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	fsa9480_set_switch(client, buf);
+
+	return count;
+}
+
+static DEVICE_ATTR(switch, 0644,
+		   fsa9480_manualsw_show, fsa9480_manualsw_set);
+
+static struct attribute *fsa9480_attributes[] = {
+	&dev_attr_switch.attr,
+	NULL
+};
+
+static const struct attribute_group fsa9480_group = {
+	.attrs	= fsa9480_attributes,
+};
+
+static void fsa9480_handle_change(struct fsa9480_usbsw *usbsw,
+				  u16 mask, bool attached)
+{
+	while (mask) {
+		int dev = fls64(mask) - 1;
+		u64 cables = cable_types[dev];
+
+		while (cables) {
+			int cable = fls64(cables) - 1;
+
+			extcon_set_state_sync(usbsw->edev, cable, attached);
+			cables &= ~BIT_ULL(cable);
+		}
+
+		mask &= ~BIT_ULL(dev);
+	}
+}
+
+static void fsa9480_detect_dev(struct fsa9480_usbsw *usbsw)
+{
+	struct i2c_client *client = usbsw->client;
+	int val1, val2;
+	u16 val;
+
+	val1 = fsa9480_read_reg(client, FSA9480_REG_DEV_T1);
+	val2 = fsa9480_read_reg(client, FSA9480_REG_DEV_T2);
+	if (val1 < 0 || val2 < 0) {
+		dev_err(&client->dev, "%s: failed to read registers", __func__);
+		return;
+	}
+	val = val2 << 8 | val1;
+
+	dev_info(&client->dev, "dev1: 0x%x, dev2: 0x%x\n", val1, val2);
+
+	if (usbsw->mansw && (val1 & DEV_T1_USB_MASK || val2 & DEV_T2_USB_MASK))
+		fsa9480_write_reg(client, FSA9480_REG_MANSW1, usbsw->mansw);
+
+	/* handle detached cables first */
+	fsa9480_handle_change(usbsw, usbsw->dev & ~val, false);
+
+	/* then handle attached ones */
+	fsa9480_handle_change(usbsw, val & ~usbsw->dev, true);
+
+	usbsw->dev = val;
+}
+
+static irqreturn_t fsa9480_irq_handler(int irq, void *data)
+{
+	struct fsa9480_usbsw *usbsw = data;
+	struct i2c_client *client = usbsw->client;
+	int intr = 0;
+
+	/* clear interrupt */
+	fsa9480_read_irq(client, &intr);
+	if (!intr)
+		return IRQ_NONE;
+
+	/* device detection */
+	fsa9480_detect_dev(usbsw);
+
+	return IRQ_HANDLED;
+}
+
+static int fsa9480_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct fsa9480_usbsw *info;
+	int ret;
+
+	if (!client->irq) {
+		dev_err(&client->dev, "no interrupt provided\n");
+		return -EINVAL;
+	}
+
+	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->client = client;
+
+	i2c_set_clientdata(client, info);
+
+	/* External connector */
+	info->edev = devm_extcon_dev_allocate(&client->dev,
+					      fsa9480_extcon_cable);
+	if (IS_ERR(info->edev)) {
+		dev_err(&client->dev, "failed to allocate memory for extcon\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	ret = devm_extcon_dev_register(&client->dev, info->edev);
+	if (ret) {
+		dev_err(&client->dev, "failed to register extcon device\n");
+		return ret;
+	}
+
+	/* ADC Detect Time: 500ms */
+	fsa9480_write_reg(client, FSA9480_REG_TIMING1, TIMING1_ADC_500MS);
+
+	/* configure automatic switching */
+	fsa9480_write_reg(client, FSA9480_REG_CTRL, CON_MASK);
+
+	/* unmask interrupt (attach/detach only) */
+	fsa9480_write_reg(client, FSA9480_REG_INT1_MASK,
+			  INT1_MASK & ~(INT_ATTACH | INT_DETACH));
+	fsa9480_write_reg(client, FSA9480_REG_INT2_MASK, INT2_MASK);
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					fsa9480_irq_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"fsa9480", info);
+	if (ret) {
+		dev_err(&client->dev, "failed to request IRQ\n");
+		return ret;
+	}
+
+	device_init_wakeup(&client->dev, true);
+	fsa9480_detect_dev(info);
+
+	ret = sysfs_create_group(&client->dev.kobj, &fsa9480_group);
+	if (ret) {
+		dev_err(&client->dev,
+			"failed to create fsa9480 attribute group\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fsa9480_remove(struct i2c_client *client)
+{
+	sysfs_remove_group(&client->dev.kobj, &fsa9480_group);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int fsa9480_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev) && client->irq)
+		enable_irq_wake(client->irq);
+
+	return 0;
+}
+
+static int fsa9480_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev) && client->irq)
+		disable_irq_wake(client->irq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops fsa9480_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fsa9480_suspend, fsa9480_resume)
+};
+
+static const struct i2c_device_id fsa9480_id[] = {
+	{ "fsa9480", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, fsa9480_id);
+
+static const struct of_device_id fsa9480_of_match[] = {
+	{ .compatible = "fcs,fsa9480", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, fsa9480_of_match);
+
+static struct i2c_driver fsa9480_i2c_driver = {
+	.driver			= {
+		.name		= "fsa9480",
+		.pm		= &fsa9480_pm_ops,
+		.of_match_table = fsa9480_of_match,
+	},
+	.probe			= fsa9480_probe,
+	.remove			= fsa9480_remove,
+	.id_table		= fsa9480_id,
+};
+
+static int __init fsa9480_module_init(void)
+{
+	return i2c_add_driver(&fsa9480_i2c_driver);
+}
+subsys_initcall(fsa9480_module_init);
+
+static void __exit fsa9480_module_exit(void)
+{
+	i2c_del_driver(&fsa9480_i2c_driver);
+}
+module_exit(fsa9480_module_exit);
+
+MODULE_DESCRIPTION("Fairchild Semiconductor FSA9480 extcon driver");
+MODULE_AUTHOR("Tomasz Figa <tomasz.figa@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1


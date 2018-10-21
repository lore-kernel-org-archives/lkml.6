Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C8ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5E2083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWrS1LlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F5E2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbeJVBOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:14:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42619 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJVBOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:14:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8-v6so2838265wro.9;
        Sun, 21 Oct 2018 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hW4eq5yoL7c+M8DZtz7QZpHJNuSOPfjAK/388zFTNBk=;
        b=LWrS1LlP0q0R0Irtombr9GnUtQeiA5cce+VInw70EQqiwf3hW3asRuh3UEHGOHugZo
         Y7tvENjkoFkgbC4QKsPS8PfRH6DVvPXNC+tYATl50qxwe9CGYq0rJvBWgdJ/64fudet6
         OW0E7JdizW/XhmPRx0Ms18czrLVTUtvGCniJP4LTfHzvOYVkeyJOQQMECqw1M8UnXSdD
         RMy3qm9GkdcZVGVN9/ru3yb760O6DbUACD7pplyyrih6xyQj4Gm/o3hzbcEIW3G+aod1
         U99rr5Z8jMUogOclI6ZRjH5qrPYL9KZcurHYU8uRsmBS9Yx/qT59+QkGiG94zdvW0qrF
         5ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hW4eq5yoL7c+M8DZtz7QZpHJNuSOPfjAK/388zFTNBk=;
        b=H3+6SmuwUmT93vEzc7TrGHkcYmjD27Bdbrx7pBsJUKwXsDPRvzghFae3TCdwF1znJQ
         PCG8J5qbcKvSHfBB6BKguiqr5o/ZaoETVA8GF7a774K7DRBPjj/mzKsjO60CwHO6FwLt
         8/FHpYvFg/MJi1l59EpceNrd/hldlfDFqDv9nTfl/v8YKlw9PdjfukrYtOTQbZ6FqnET
         yWumQGQ9MmoRNUbTg0uG1Zpc8Y7tpCRwYrc/nEH1YkF5Qtnpn1qIkc3rGTDmTRdWaSpq
         IAsdIoeIcfpVbGyQpabYx9ID5Z/emoQ1FVE6jHhjsceoKQh7CaOh4cdcLmGsbKfAc8zO
         Xekg==
X-Gm-Message-State: ABuFfoiLPluLcgtvdLUASyu0FPKs4iMfaRL6MlYSzXkNzpuBw9l6R6nL
        0qULMwEwotnknb4aISV0Vvo=
X-Google-Smtp-Source: ACcGV60LzKiFC6awsjvFpxm/UuZ7Rwtap6Sc+J9I456nGnv0Tjp9yn94GKK8RJCabuWViZvao5oC0Q==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr44938811wrq.189.1540141176363;
        Sun, 21 Oct 2018 09:59:36 -0700 (PDT)
Received: from localhost.localdomain (175-235-243-213.terrecablate.net. [213.243.235.175])
        by smtp.gmail.com with ESMTPSA id b71-v6sm13437230wma.13.2018.10.21.09.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 09:59:35 -0700 (PDT)
From:   ektor5 <ek5.chimenti@gmail.com>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sean@mess.org, sakari.ailus@linux.intel.com,
        Ettore Chimenti <ek5.chimenti@gmail.com>, jacopo@jmondi.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v4 1/2] media: add SECO cec driver
Date:   Sun, 21 Oct 2018 18:58:19 +0200
Message-Id: <078191bb589ee1c13f9858b053c7ee0b051ed582.1539963738.git.ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1539963738.git.ek5.chimenti@gmail.com>
References: <cover.1539963738.git.ek5.chimenti@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ettore Chimenti <ek5.chimenti@gmail.com>

This patch adds support to the CEC device implemented with a STM32
microcontroller in X86 SECO Boards, including UDOO X86.

The communication is achieved via Braswell integrated SMBus
(i2c-i801). The driver use direct access to the PCI addresses, due to
the limitations of the specific driver in presence of ACPI calls.

The basic functionalities are tested with success with cec-ctl and
cec-compliance.

Inspired by cros-ec-cec implementation, attaches to i915 driver
cec-notifier.

Signed-off-by: Ettore Chimenti <ek5.chimenti@gmail.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 MAINTAINERS                                |   6 +
 drivers/media/platform/Kconfig             |  12 +
 drivers/media/platform/Makefile            |   2 +
 drivers/media/platform/seco-cec/Makefile   |   1 +
 drivers/media/platform/seco-cec/seco-cec.c | 672 +++++++++++++++++++++
 drivers/media/platform/seco-cec/seco-cec.h | 130 ++++
 6 files changed, 823 insertions(+)
 create mode 100644 drivers/media/platform/seco-cec/Makefile
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.c
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..1062912a5ff4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12972,6 +12972,12 @@ L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 F:	drivers/mmc/host/sdricoh_cs.c
 
+SECO BOARDS CEC DRIVER
+M:	Ettore Chimenti <ek5.chimenti@gmail.com>
+S:	Maintained
+F:	drivers/media/platform/seco-cec/seco-cec.c
+F:	drivers/media/platform/seco-cec/seco-cec.h
+
 SECURE COMPUTING
 M:	Kees Cook <keescook@chromium.org>
 R:	Andy Lutomirski <luto@amacapital.net>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 94c1fe0e9787..51cd1fd005e3 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -613,6 +613,18 @@ config VIDEO_TEGRA_HDMI_CEC
 	 The CEC bus is present in the HDMI connector and enables communication
 	 between compatible devices.
 
+config VIDEO_SECO_CEC
+	tristate "SECO Boards HDMI CEC driver"
+	depends on (X86 || IA64) || COMPILE_TEST
+	depends on PCI && DMI
+	select CEC_CORE
+	select CEC_NOTIFIER
+	help
+	  This is a driver for SECO Boards integrated CEC interface.
+	  Selecting it will enable support for this device.
+	  CEC bus is present in the HDMI connector and enables communication
+	  between compatible devices.
+
 endif #CEC_PLATFORM_DRIVERS
 
 menuconfig SDR_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 41322ab65802..5d2b06c4c68a 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -53,6 +53,8 @@ obj-$(CONFIG_VIDEO_TEGRA_HDMI_CEC)	+= tegra-cec/
 
 obj-y					+= stm32/
 
+obj-$(CONFIG_VIDEO_SECO_CEC)		+= seco-cec/
+
 obj-y					+= davinci/
 
 obj-$(CONFIG_VIDEO_SH_VOU)		+= sh_vou.o
diff --git a/drivers/media/platform/seco-cec/Makefile b/drivers/media/platform/seco-cec/Makefile
new file mode 100644
index 000000000000..09900b087d02
--- /dev/null
+++ b/drivers/media/platform/seco-cec/Makefile
@@ -0,0 +1 @@
+obj-y += seco-cec.o
diff --git a/drivers/media/platform/seco-cec/seco-cec.c b/drivers/media/platform/seco-cec/seco-cec.c
new file mode 100644
index 000000000000..85ef161742d8
--- /dev/null
+++ b/drivers/media/platform/seco-cec/seco-cec.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * CEC driver for SECO X86 Boards
+ *
+ * Author:  Ettore Chimenti <ek5.chimenti@gmail.com>
+ * Copyright (C) 2018, SECO SpA.
+ * Copyright (C) 2018, Aidilab Srl.
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+/* CEC Framework */
+#include <media/cec.h>
+
+#include "seco-cec.h"
+
+struct secocec_data {
+	struct device *dev;
+	struct platform_device *pdev;
+	struct cec_adapter *cec_adap;
+	struct cec_notifier *notifier;
+	int irq;
+};
+
+#define smb_wr16(cmd, data) smb_word_op(CMD_WORD_DATA, SECOCEC_MICRO_ADDRESS, \
+					     cmd, data, SMBUS_WRITE, NULL)
+#define smb_rd16(cmd, res) smb_word_op(CMD_WORD_DATA, SECOCEC_MICRO_ADDRESS, \
+				       cmd, 0, SMBUS_READ, res)
+
+static int smb_word_op(short data_format, u16 slave_addr, u8 cmd, u16 data,
+		       u8 operation, u16 *result)
+{
+	unsigned int count;
+	short _data_format;
+	int status = 0;
+
+	switch (data_format) {
+	case CMD_BYTE_DATA:
+		_data_format = BRA_SMB_CMD_BYTE_DATA;
+		break;
+	case CMD_WORD_DATA:
+		_data_format = BRA_SMB_CMD_WORD_DATA;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Active wait until ready */
+	for (count = 0; count <= SMBTIMEOUT; ++count) {
+		if (!(inb(HSTS) & BRA_INUSE_STS))
+			break;
+		udelay(SMB_POLL_UDELAY);
+	}
+
+	if (count > SMBTIMEOUT)
+		/* Reset the lock instead of failing */
+		outb(0xff, HSTS);
+
+	outb(0x00, HCNT);
+	outb((u8)(slave_addr & 0xfe) | operation, XMIT_SLVA);
+	outb(cmd, HCMD);
+	inb(HCNT);
+
+	if (operation == SMBUS_WRITE) {
+		outb((u8)data, HDAT0);
+		outb((u8)(data >> 8), HDAT1);
+	}
+
+	outb(BRA_START + _data_format, HCNT);
+
+	for (count = 0; count <= SMBTIMEOUT; count++) {
+		if (!(inb(HSTS) & BRA_HOST_BUSY))
+			break;
+		udelay(SMB_POLL_UDELAY);
+	}
+
+	if (count > SMBTIMEOUT) {
+		status = -EBUSY;
+		goto err;
+	}
+
+	if (inb(HSTS) & BRA_HSTS_ERR_MASK) {
+		status = -EIO;
+		goto err;
+	}
+
+	if (operation == SMBUS_READ)
+		*result = ((inb(HDAT0) & 0xff) + ((inb(HDAT1) & 0xff) << 8));
+
+err:
+	outb(0xff, HSTS);
+	return status;
+}
+
+static int secocec_adap_enable(struct cec_adapter *adap, bool enable)
+{
+	struct secocec_data *cec = cec_get_drvdata(adap);
+	struct device *dev = cec->dev;
+	u16 val = 0;
+	int status;
+
+	if (enable) {
+		/* Clear the status register */
+		status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
+		if (status)
+			goto err;
+
+		status = smb_wr16(SECOCEC_STATUS_REG_1, val);
+		if (status)
+			goto err;
+
+		/* Enable the interrupts */
+		status = smb_rd16(SECOCEC_ENABLE_REG_1, &val);
+		if (status)
+			goto err;
+
+		status = smb_wr16(SECOCEC_ENABLE_REG_1,
+				  val | SECOCEC_ENABLE_REG_1_CEC);
+		if (status)
+			goto err;
+
+		dev_dbg(dev, "Device enabled");
+	} else {
+		/* Clear the status register */
+		status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
+		status = smb_wr16(SECOCEC_STATUS_REG_1, val);
+
+		/* Disable the interrupts */
+		status = smb_rd16(SECOCEC_ENABLE_REG_1, &val);
+		status = smb_wr16(SECOCEC_ENABLE_REG_1, val &
+				  ~SECOCEC_ENABLE_REG_1_CEC &
+				  ~SECOCEC_ENABLE_REG_1_IR);
+
+		dev_dbg(dev, "Device disabled");
+	}
+
+	return 0;
+err:
+	return status;
+}
+
+static int secocec_adap_log_addr(struct cec_adapter *adap, u8 logical_addr)
+{
+	u16 enable_val = 0;
+	int status;
+
+	/* Disable device */
+	status = smb_rd16(SECOCEC_ENABLE_REG_1, &enable_val);
+	if (status)
+		return status;
+
+	status = smb_wr16(SECOCEC_ENABLE_REG_1,
+			  enable_val & ~SECOCEC_ENABLE_REG_1_CEC);
+	if (status)
+		return status;
+
+	/* Write logical address
+	 * NOTE: CEC_LOG_ADDR_INVALID is mapped to the 'Unregistered' LA
+	 */
+	status = smb_wr16(SECOCEC_DEVICE_LA, logical_addr & 0xf);
+	if (status)
+		return status;
+
+	/* Re-enable device */
+	status = smb_wr16(SECOCEC_ENABLE_REG_1,
+			  enable_val | SECOCEC_ENABLE_REG_1_CEC);
+	if (status)
+		return status;
+
+	return 0;
+}
+
+static int secocec_adap_transmit(struct cec_adapter *adap, u8 attempts,
+				 u32 signal_free_time, struct cec_msg *msg)
+{
+	u16 payload_len, payload_id_len, destination, val = 0;
+	u8 *payload_msg;
+	int status;
+	u8 i;
+
+	/* Device msg len already accounts for header */
+	payload_id_len = msg->len - 1;
+
+	/* Send data length */
+	status = smb_wr16(SECOCEC_WRITE_DATA_LENGTH, payload_id_len);
+	if (status)
+		goto err;
+
+	/* Send Operation ID if present */
+	if (payload_id_len > 0) {
+		status = smb_wr16(SECOCEC_WRITE_OPERATION_ID, msg->msg[1]);
+		if (status)
+			goto err;
+	}
+	/* Send data if present */
+	if (payload_id_len > 1) {
+		/* Only data; */
+		payload_len = msg->len - 2;
+		payload_msg = &msg->msg[2];
+
+		/* Copy message into registers */
+		for (i = 0; i < payload_len; i += 2) {
+			/* hi byte */
+			val = payload_msg[i + 1] << 8;
+
+			/* lo byte */
+			val |= payload_msg[i];
+
+			status = smb_wr16(SECOCEC_WRITE_DATA_00 + i / 2, val);
+			if (status)
+				goto err;
+		}
+	}
+	/* Send msg source/destination and fire msg */
+	destination = msg->msg[0];
+	status = smb_wr16(SECOCEC_WRITE_BYTE0, destination);
+	if (status)
+		goto err;
+
+	return 0;
+
+err:
+	return status;
+}
+
+static void secocec_tx_done(struct cec_adapter *adap, u16 status_val)
+{
+	if (status_val & SECOCEC_STATUS_TX_ERROR_MASK) {
+		if (status_val & SECOCEC_STATUS_TX_NACK_ERROR)
+			cec_transmit_attempt_done(adap, CEC_TX_STATUS_NACK);
+		else
+			cec_transmit_attempt_done(adap, CEC_TX_STATUS_ERROR);
+	} else {
+		cec_transmit_attempt_done(adap, CEC_TX_STATUS_OK);
+	}
+
+	/* Reset status reg */
+	status_val = SECOCEC_STATUS_TX_ERROR_MASK |
+		SECOCEC_STATUS_MSG_SENT_MASK |
+		SECOCEC_STATUS_TX_NACK_ERROR;
+	smb_wr16(SECOCEC_STATUS, status_val);
+}
+
+static void secocec_rx_done(struct cec_adapter *adap, u16 status_val)
+{
+	struct secocec_data *cec = cec_get_drvdata(adap);
+	struct device *dev = cec->dev;
+	struct cec_msg msg = { };
+	bool flag_overflow = false;
+	u8 payload_len, i = 0;
+	u8 *payload_msg;
+	u16 val = 0;
+	int status;
+
+	if (status_val & SECOCEC_STATUS_RX_OVERFLOW_MASK) {
+		/* NOTE: Untested, it also might not be necessary */
+		dev_warn(dev, "Received more than 16 bytes. Discarding");
+		flag_overflow = true;
+	}
+
+	if (status_val & SECOCEC_STATUS_RX_ERROR_MASK) {
+		dev_warn(dev, "Message received with errors. Discarding");
+		status = -EIO;
+		goto rxerr;
+	}
+
+	/* Read message length */
+	status = smb_rd16(SECOCEC_READ_DATA_LENGTH, &val);
+	if (status)
+		return;
+
+	/* Device msg len already accounts for the header */
+	msg.len = min(val + 1, CEC_MAX_MSG_SIZE);
+
+	/* Read logical address */
+	status = smb_rd16(SECOCEC_READ_BYTE0, &val);
+	if (status)
+		return;
+
+	/* device stores source LA and destination */
+	msg.msg[0] = val;
+
+	/* Read operation ID */
+	status = smb_rd16(SECOCEC_READ_OPERATION_ID, &val);
+	if (status)
+		return;
+
+	msg.msg[1] = val;
+
+	/* Read data if present */
+	if (msg.len > 1) {
+		payload_len = msg.len - 2;
+		payload_msg = &msg.msg[2];
+
+		/* device stores 2 bytes in every 16-bit val */
+		for (i = 0; i < payload_len; i += 2) {
+			status = smb_rd16(SECOCEC_READ_DATA_00 + i / 2, &val);
+			if (status)
+				return;
+
+			/* low byte, skipping header */
+			payload_msg[i] = val & 0x00ff;
+
+			/* hi byte */
+			payload_msg[i + 1] = (val & 0xff00) >> 8;
+		}
+	}
+
+	cec_received_msg(cec->cec_adap, &msg);
+
+	/* Reset status reg */
+	status_val = SECOCEC_STATUS_MSG_RECEIVED_MASK;
+	if (flag_overflow)
+		status_val |= SECOCEC_STATUS_RX_OVERFLOW_MASK;
+
+	status = smb_wr16(SECOCEC_STATUS, status_val);
+
+	return;
+
+rxerr:
+	/* Reset error reg */
+	status_val = SECOCEC_STATUS_MSG_RECEIVED_MASK |
+		SECOCEC_STATUS_RX_ERROR_MASK;
+	if (flag_overflow)
+		status_val |= SECOCEC_STATUS_RX_OVERFLOW_MASK;
+	smb_wr16(SECOCEC_STATUS, status_val);
+}
+
+struct cec_adap_ops secocec_cec_adap_ops = {
+	/* Low-level callbacks */
+	.adap_enable = secocec_adap_enable,
+	.adap_log_addr = secocec_adap_log_addr,
+	.adap_transmit = secocec_adap_transmit,
+};
+
+static irqreturn_t secocec_irq_handler(int irq, void *priv)
+{
+	struct secocec_data *cec = priv;
+	struct device *dev = cec->dev;
+	u16 status_val, cec_val, val = 0;
+	int status;
+
+	/*  Read status register */
+	status = smb_rd16(SECOCEC_STATUS_REG_1, &status_val);
+	if (status)
+		goto err;
+
+	if (status_val & SECOCEC_STATUS_REG_1_CEC) {
+		/* Read CEC status register */
+		status = smb_rd16(SECOCEC_STATUS, &cec_val);
+		if (status)
+			goto err;
+
+		if (cec_val & SECOCEC_STATUS_MSG_RECEIVED_MASK)
+			secocec_rx_done(cec->cec_adap, cec_val);
+
+		if (cec_val & SECOCEC_STATUS_MSG_SENT_MASK)
+			secocec_tx_done(cec->cec_adap, cec_val);
+
+		if ((~cec_val & SECOCEC_STATUS_MSG_SENT_MASK) &&
+		    (~cec_val & SECOCEC_STATUS_MSG_RECEIVED_MASK))
+			dev_warn_once(dev,
+				      "Message not received or sent, but interrupt fired");
+
+		val = SECOCEC_STATUS_REG_1_CEC;
+	}
+
+	if (status_val & SECOCEC_STATUS_REG_1_IR) {
+		val |= SECOCEC_STATUS_REG_1_IR;
+		/* TODO IRDA RX */
+	}
+
+	/*  Reset status register */
+	status = smb_wr16(SECOCEC_STATUS_REG_1, val);
+	if (status)
+		goto err;
+
+	return IRQ_HANDLED;
+
+err:
+	dev_err_once(dev, "IRQ: R/W SMBus operation failed (%d)", status);
+
+	/*  Reset status register */
+	val = SECOCEC_STATUS_REG_1_CEC | SECOCEC_STATUS_REG_1_IR;
+	smb_wr16(SECOCEC_STATUS_REG_1, val);
+
+	return IRQ_HANDLED;
+}
+
+struct cec_dmi_match {
+	char *sys_vendor;
+	char *product_name;
+	char *devname;
+	char *conn;
+};
+
+static const struct cec_dmi_match secocec_dmi_match_table[] = {
+	/* UDOO X86 */
+	{ "SECO", "UDOO x86", "0000:00:02.0", "Port B" },
+};
+
+static int secocec_cec_get_notifier(struct cec_notifier **notify)
+{
+	int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(secocec_dmi_match_table) ; ++i) {
+		const struct cec_dmi_match *m = &secocec_dmi_match_table[i];
+
+		if (dmi_match(DMI_SYS_VENDOR, m->sys_vendor) &&
+		    dmi_match(DMI_PRODUCT_NAME, m->product_name)) {
+			struct device *d;
+
+			/* Find the device, bail out if not yet registered */
+			d = bus_find_device_by_name(&pci_bus_type, NULL,
+						    m->devname);
+			if (!d)
+				return -EPROBE_DEFER;
+
+			*notify = cec_notifier_get_conn(d, m->conn);
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int secocec_acpi_probe(struct secocec_data *sdev)
+{
+	struct device *dev = sdev->dev;
+	struct gpio_desc *gpio;
+	int irq = 0;
+
+	gpio = devm_gpiod_get(dev, NULL, GPIOF_IN);
+	if (IS_ERR(gpio)) {
+		dev_err(dev, "Cannot request interrupt gpio");
+		return PTR_ERR(gpio);
+	}
+
+	irq = gpiod_to_irq(gpio);
+	if (irq < 0) {
+		dev_err(dev, "Cannot find valid irq");
+		return -ENODEV;
+	}
+	dev_dbg(dev, "irq-gpio is bound to IRQ %d", irq);
+
+	sdev->irq = irq;
+
+	return 0;
+}
+
+static int secocec_probe(struct platform_device *pdev)
+{
+	struct secocec_data *secocec;
+	struct device *dev = &pdev->dev;
+	int ret;
+	u16 val;
+
+	secocec = devm_kzalloc(dev, sizeof(*secocec), GFP_KERNEL);
+	if (!secocec)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, secocec);
+
+	/* Request SMBus regions */
+	if (!request_muxed_region(BRA_SMB_BASE_ADDR, 7, "CEC00001")) {
+		dev_err(dev, "Request memory region failed");
+		return -ENXIO;
+	}
+
+	secocec->pdev = pdev;
+	secocec->dev = dev;
+
+	if (!has_acpi_companion(dev)) {
+		dev_dbg(dev, "Cannot find any ACPI companion");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ret = secocec_acpi_probe(secocec);
+	if (ret) {
+		dev_err(dev, "Cannot assign gpio to IRQ");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/* Firmware version check */
+	ret = smb_rd16(SECOCEC_VERSION, &val);
+	if (ret) {
+		dev_err(dev, "Cannot check fw version");
+		goto err;
+	}
+	if (val < SECOCEC_LATEST_FW) {
+		dev_err(dev, "CEC Firmware not supported (v.%04x). Use ver > v.%04x",
+			val, SECOCEC_LATEST_FW);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = secocec_cec_get_notifier(&secocec->notifier);
+	if (ret) {
+		dev_err(dev, "no CEC notifier available\n");
+		goto err;
+	}
+
+	ret = devm_request_threaded_irq(dev,
+					secocec->irq,
+					NULL,
+					secocec_irq_handler,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					dev_name(&pdev->dev), secocec);
+
+	if (ret) {
+		dev_err(dev, "Cannot request IRQ %d", secocec->irq);
+		ret = -EIO;
+		goto err;
+	}
+
+	/* Allocate CEC adapter */
+	secocec->cec_adap = cec_allocate_adapter(&secocec_cec_adap_ops,
+						 secocec,
+						 dev_name(dev),
+						 CEC_CAP_DEFAULTS,
+						 SECOCEC_MAX_ADDRS);
+
+	if (IS_ERR(secocec->cec_adap)) {
+		ret = PTR_ERR(secocec->cec_adap);
+		goto err;
+	}
+
+	ret = cec_register_adapter(secocec->cec_adap, dev);
+	if (ret)
+		goto err_delete_adapter;
+
+	if (secocec->notifier)
+		cec_register_cec_notifier(secocec->cec_adap, secocec->notifier);
+
+	platform_set_drvdata(pdev, secocec);
+
+	dev_dbg(dev, "Device registered");
+
+	return ret;
+
+err_delete_adapter:
+	cec_delete_adapter(secocec->cec_adap);
+err:
+	dev_err(dev, "%s device probe failed\n", dev_name(dev));
+
+	return ret;
+}
+
+static int secocec_remove(struct platform_device *pdev)
+{
+	struct secocec_data *secocec = platform_get_drvdata(pdev);
+
+	cec_unregister_adapter(secocec->cec_adap);
+
+	if (secocec->notifier)
+		cec_notifier_put(secocec->notifier);
+
+	release_region(BRA_SMB_BASE_ADDR, 7);
+
+	dev_dbg(&pdev->dev, "CEC device removed");
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int secocec_suspend(struct device *dev)
+{
+	int status;
+	u16 val;
+
+	dev_dbg(dev, "Device going to suspend, disabling");
+
+	/* Clear the status register */
+	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
+	if (status)
+		goto err;
+
+	status = smb_wr16(SECOCEC_STATUS_REG_1, val);
+	if (status)
+		goto err;
+
+	/* Disable the interrupts */
+	status = smb_rd16(SECOCEC_ENABLE_REG_1, &val);
+	if (status)
+		goto err;
+
+	status = smb_wr16(SECOCEC_ENABLE_REG_1, val &
+			  ~SECOCEC_ENABLE_REG_1_CEC & ~SECOCEC_ENABLE_REG_1_IR);
+	if (status)
+		goto err;
+
+	return 0;
+
+err:
+	dev_err(dev, "Suspend failed (err: %d)", status);
+	return status;
+}
+
+static int secocec_resume(struct device *dev)
+{
+	int status;
+	u16 val;
+
+	dev_dbg(dev, "Resuming device from suspend");
+
+	/* Clear the status register */
+	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
+	if (status)
+		goto err;
+
+	status = smb_wr16(SECOCEC_STATUS_REG_1, val);
+	if (status)
+		goto err;
+
+	/* Enable the interrupts */
+	status = smb_rd16(SECOCEC_ENABLE_REG_1, &val);
+	if (status)
+		goto err;
+
+	status = smb_wr16(SECOCEC_ENABLE_REG_1, val | SECOCEC_ENABLE_REG_1_CEC);
+	if (status)
+		goto err;
+
+	dev_dbg(dev, "Device resumed from suspend");
+
+	return 0;
+
+err:
+	dev_err(dev, "Resume failed (err: %d)", status);
+	return status;
+}
+
+static SIMPLE_DEV_PM_OPS(secocec_pm_ops, secocec_suspend, secocec_resume);
+#define SECOCEC_PM_OPS (&secocec_pm_ops)
+#else
+#define SECOCEC_PM_OPS NULL
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id secocec_acpi_match[] = {
+	{"CEC00001", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, secocec_acpi_match);
+#endif
+
+static struct platform_driver secocec_driver = {
+	.driver = {
+		   .name = SECOCEC_DEV_NAME,
+		   .acpi_match_table = ACPI_PTR(secocec_acpi_match),
+		   .pm = SECOCEC_PM_OPS,
+	},
+	.probe = secocec_probe,
+	.remove = secocec_remove,
+};
+
+module_platform_driver(secocec_driver);
+
+MODULE_DESCRIPTION("SECO CEC X86 Driver");
+MODULE_AUTHOR("Ettore Chimenti <ek5.chimenti@gmail.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/media/platform/seco-cec/seco-cec.h b/drivers/media/platform/seco-cec/seco-cec.h
new file mode 100644
index 000000000000..be5a657ae462
--- /dev/null
+++ b/drivers/media/platform/seco-cec/seco-cec.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * SECO X86 Boards CEC register defines
+ *
+ * Author:  Ettore Chimenti <ek5.chimenti@gmail.com>
+ * Copyright (C) 2018, SECO Spa.
+ * Copyright (C) 2018, Aidilab Srl.
+ */
+
+#ifndef __SECO_CEC_H__
+#define __SECO_CEC_H__
+
+#define SECOCEC_MAX_ADDRS		1
+#define SECOCEC_DEV_NAME		"secocec"
+#define SECOCEC_LATEST_FW		0x0f0b
+
+#define SMBTIMEOUT			0xfff
+#define SMB_POLL_UDELAY			10
+
+#define SMBUS_WRITE			0
+#define SMBUS_READ			1
+
+#define CMD_BYTE_DATA			0
+#define CMD_WORD_DATA			1
+
+/*
+ * SMBus definitons for Braswell
+ */
+
+#define BRA_DONE_STATUS			BIT(7)
+#define BRA_INUSE_STS			BIT(6)
+#define BRA_FAILED_OP			BIT(4)
+#define BRA_BUS_ERR			BIT(3)
+#define BRA_DEV_ERR			BIT(2)
+#define BRA_INTR			BIT(1)
+#define BRA_HOST_BUSY			BIT(0)
+#define BRA_HSTS_ERR_MASK   (BRA_FAILED_OP | BRA_BUS_ERR | BRA_DEV_ERR)
+
+#define BRA_PEC_EN			BIT(7)
+#define BRA_START			BIT(6)
+#define BRA_LAST__BYTE			BIT(5)
+#define BRA_INTREN			BIT(0)
+#define BRA_SMB_CMD			(7 << 2)
+#define BRA_SMB_CMD_QUICK		(0 << 2)
+#define BRA_SMB_CMD_BYTE		(1 << 2)
+#define BRA_SMB_CMD_BYTE_DATA		(2 << 2)
+#define BRA_SMB_CMD_WORD_DATA		(3 << 2)
+#define BRA_SMB_CMD_PROCESS_CALL	(4 << 2)
+#define BRA_SMB_CMD_BLOCK		(5 << 2)
+#define BRA_SMB_CMD_I2CREAD		(6 << 2)
+#define BRA_SMB_CMD_BLOCK_PROCESS	(7 << 2)
+
+#define BRA_SMB_BASE_ADDR  0x2040
+#define HSTS               (BRA_SMB_BASE_ADDR + 0)
+#define HCNT               (BRA_SMB_BASE_ADDR + 2)
+#define HCMD               (BRA_SMB_BASE_ADDR + 3)
+#define XMIT_SLVA          (BRA_SMB_BASE_ADDR + 4)
+#define HDAT0              (BRA_SMB_BASE_ADDR + 5)
+#define HDAT1              (BRA_SMB_BASE_ADDR + 6)
+
+/*
+ * Microcontroller Address
+ */
+
+#define SECOCEC_MICRO_ADDRESS		0x40
+
+/*
+ * STM32 SMBus Registers
+ */
+
+#define SECOCEC_VERSION			0x00
+#define SECOCEC_ENABLE_REG_1		0x01
+#define SECOCEC_ENABLE_REG_2		0x02
+#define SECOCEC_STATUS_REG_1		0x03
+#define SECOCEC_STATUS_REG_2		0x04
+
+#define SECOCEC_STATUS			0x28
+#define SECOCEC_DEVICE_LA		0x29
+#define SECOCEC_READ_OPERATION_ID	0x2a
+#define SECOCEC_READ_DATA_LENGTH	0x2b
+#define SECOCEC_READ_DATA_00		0x2c
+#define SECOCEC_READ_DATA_02		0x2d
+#define SECOCEC_READ_DATA_04		0x2e
+#define SECOCEC_READ_DATA_06		0x2f
+#define SECOCEC_READ_DATA_08		0x30
+#define SECOCEC_READ_DATA_10		0x31
+#define SECOCEC_READ_DATA_12		0x32
+#define SECOCEC_READ_BYTE0		0x33
+#define SECOCEC_WRITE_OPERATION_ID	0x34
+#define SECOCEC_WRITE_DATA_LENGTH	0x35
+#define SECOCEC_WRITE_DATA_00		0x36
+#define SECOCEC_WRITE_DATA_02		0x37
+#define SECOCEC_WRITE_DATA_04		0x38
+#define SECOCEC_WRITE_DATA_06		0x39
+#define SECOCEC_WRITE_DATA_08		0x3a
+#define SECOCEC_WRITE_DATA_10		0x3b
+#define SECOCEC_WRITE_DATA_12		0x3c
+#define SECOCEC_WRITE_BYTE0		0x3d
+
+#define SECOCEC_IR_READ_DATA		0x3e
+
+/*
+ * Enabling register
+ */
+
+#define SECOCEC_ENABLE_REG_1_CEC		0x1000
+#define SECOCEC_ENABLE_REG_1_IR			0x2000
+#define SECOCEC_ENABLE_REG_1_IR_PASSTHROUGH	0x4000
+
+/*
+ * Status register
+ */
+
+#define SECOCEC_STATUS_REG_1_CEC	SECOCEC_ENABLE_REG_1_CEC
+#define SECOCEC_STATUS_REG_1_IR		SECOCEC_ENABLE_REG_1_IR
+#define SECOCEC_STATUS_REG_1_IR_PASSTHR	SECOCEC_ENABLE_REG_1_IR_PASSTHR
+
+/*
+ * Status data
+ */
+
+#define SECOCEC_STATUS_MSG_RECEIVED_MASK	BIT(0)
+#define SECOCEC_STATUS_RX_ERROR_MASK		BIT(1)
+#define SECOCEC_STATUS_MSG_SENT_MASK		BIT(2)
+#define SECOCEC_STATUS_TX_ERROR_MASK		BIT(3)
+
+#define SECOCEC_STATUS_TX_NACK_ERROR		BIT(4)
+#define SECOCEC_STATUS_RX_OVERFLOW_MASK		BIT(5)
+
+#endif /* __SECO_CEC_H__ */
-- 
2.18.0


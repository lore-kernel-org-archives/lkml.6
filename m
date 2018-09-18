Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E307AECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FECE2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 08:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoFEV1KJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FECE2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeIRN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:56:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34088 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbeIRN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:56:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so665727pgv.1;
        Tue, 18 Sep 2018 01:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rJuzf5H04oeGWLXt7aCRE+Y943qmSO/k3ZAGrEXxWpQ=;
        b=JoFEV1KJNyErQQLGCyQQABOtgMQOl3JJ7zW0gomooH6JY8IQytttQKHGeIYmaRG6WW
         ltCL3Xga5hf4H/e6O0cXajHWQlJ+mIUdL2fSmydGcOn9k2JGA2z/qeCH4NIKr4peoIQJ
         yyNIKjmwOVDeAXLpCBXw2VP1Ok1tm1jaO1LxeYHwRjLwq+qudxQrbJsr5wB7F8WKWoYw
         MOLRdExnnfex5JTfaZ889OTL3OYeJesqy5LQXduByxaJ7CaYLHXcSG5bQ+Jxq/PAFA70
         1JVugF4Vj71edT/JGFujW4FFTZ93ZzvPrrw1RvlewgCnbDGMHqaO89EZIvb6puS1dSSy
         Sjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rJuzf5H04oeGWLXt7aCRE+Y943qmSO/k3ZAGrEXxWpQ=;
        b=oI9VvuKlH7dTS5f7bnmessHcVxt9YhswhcUWNZWg7bDCbGPk2Q8fzd8sSASCkxxahe
         bHlWd6/OEfgR5x1jrTLWTqs8DSXvgYlIY2Zr8VqOjcT7SZPi+sTXaqrEJAKPV74CPyCx
         R/iGRckSEczjNlGpFblmuy8W41TD9TbQRbyJt3wPb8/VCtoR3k5JnKecgQkKQFnixgEE
         qJNZJCXYijjDQXDvQCt8XykwPyD6C5aUA/0a4pBBkO4A7ddx9JF+WpmjGGKS3KvQ0/kJ
         lXljkPqBC3SQqAAq30+/tL+8TOcqOoJ7eVFknYZ2JUqAk1UzjrNsZIHiWZvxjyGWFMyY
         oA4g==
X-Gm-Message-State: APzg51DROrEqiiil4QGcjVcmxcuDPFl/1RQ2SxMEXcBnjhlguXgmUzWM
        ojMM6wXfov0G/zkUnYeianw=
X-Google-Smtp-Source: ANB0VdawgYQA0JKT7ygVGNVcH0ME6oQ8O3HVHa0/h6jBJttPo/rX+ZQdrHJclxXPciyFZyu/+CB0gg==
X-Received: by 2002:a62:3306:: with SMTP id z6-v6mr29499600pfz.85.1537259075803;
        Tue, 18 Sep 2018 01:24:35 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id p19-v6sm33896921pgh.60.2018.09.18.01.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 01:24:35 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v6 2/2] iio: proximity: vl53l0x: add interrupt support
Date:   Tue, 18 Sep 2018 16:24:22 +0800
Message-Id: <20180918082422.13050-2-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180918082422.13050-1-songqiang1304521@gmail.com>
References: <20180918082422.13050-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first version of this driver issues a measuring request and polling
for a status register in the device for measuring completes.
vl53l0x support configuring GPIO1 on it to generate interrupt to
indicate that new measurement is ready. This patch adds support for
using this mechanisim to reduce cpu cost.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 .../bindings/iio/proximity/vl53l0x.txt        |  14 +-
 drivers/iio/proximity/vl53l0x-i2c.c           | 135 +++++++++++++++---
 2 files changed, 129 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
index ab9a9539fec4..40290f8dd70f 100644
--- a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
+++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
@@ -4,9 +4,21 @@ Required properties:
 	- compatible: must be "st,vl53l0x-i2c"
 	- reg: i2c address where to find the device
 
+Optional properties:
+	- interrupts : Interrupt line receiving GPIO1's measuring complete
+	  output, supports IRQ_TYPE_EDGE_FALLING only.
+
+	Refer to interrupt-controller/interrupts.txt for generic
+	interrupt client node bindings.
+
 Example:
 
 vl53l0x@29 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vl53l0x_pins>;
+
 	compatible = "st,vl53l0x-i2c";
 	reg = <0x29>;
-};
+	interrupt-parent = <&gpio3>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+}
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 1aad45df8d95..a5cff11f41de 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -10,18 +10,21 @@
  *
  * Default 7-bit i2c slave address 0x29.
  *
- * TODO: FIFO buffer, continuous mode, interrupts, range selection,
- * sensor ID check.
+ * TODO: FIFO buffer, continuous mode, range selection.
  */
 
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 
 #include <linux/iio/iio.h>
 
+#include <stdbool.h>
+
 #define VL_REG_SYSRANGE_START				0x00
 
+/* Mode configuration registers. */
 #define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
 #define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
 #define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
@@ -29,14 +32,61 @@
 #define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
 #define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
 
+/* Result registers. */
 #define VL_REG_RESULT_INT_STATUS			0x13
 #define VL_REG_RESULT_RANGE_STATUS			0x14
 #define VL_REG_RESULT_RANGE_STATUS_COMPLETE		BIT(0)
 
+/* GPIO function configuration registers. */
+#define VL_REG_GPIO_HV_MUX_ACTIVE_GIGH			0x84
+#define VL_REG_SYS_INT_CFG_GPIO				0x0A
+#define VL_GPIOFUNC_NEW_MEASURE_RDY			BIT(2)
+
+/* Interrupt configuration registers. */
+#define VL_REG_SYS_INT_CLEAR				0x0B
+#define VL_REG_RESULT_INT_STATUS			0x13
+#define VL_INT_POLARITY_LOW				0x00
+#define VL_INT_POLARITY_HIGH				BIT(0)
+
+/* Should be 0xEE if connection is fine. */
+#define VL_REG_MODEL_ID					0xC0
+
 struct vl53l0x_data {
 	struct i2c_client *client;
+	struct completion measuring_done;
+	bool use_interrupt;
 };
 
+static int vl53l0x_clear_interrupt(struct vl53l0x_data *data)
+{
+	int ret;
+	u8 cnt = 0;
+
+	do {
+		/* bit 0 for measuring interrupt, bit 1 for error interrupt.  */
+		i2c_smbus_write_byte_data(data->client,
+			VL_REG_SYS_INT_CLEAR, 1);
+		i2c_smbus_write_byte_data(data->client,
+			VL_REG_SYS_INT_CLEAR, 0);
+		ret = i2c_smbus_read_byte_data(data->client,
+			VL_REG_RESULT_INT_STATUS);
+		cnt++;
+	} while ((ret & 0x07) && (cnt < 3));
+	if (cnt > 2)
+		return -ETIMEDOUT;
+	else
+		return 0;
+}
+
+static irqreturn_t vl53l0x_irq_handler(int irq, void *d)
+{
+	struct vl53l0x_data *data = d;
+
+	complete(&data->measuring_done);
+
+	return IRQ_HANDLED;
+}
+
 static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 				  const struct iio_chan_spec *chan,
 				  int *val)
@@ -46,23 +96,31 @@ static int vl53l0x_read_proximity(struct vl53l0x_data *data,
 	u8 buffer[12];
 	int ret;
 
-	ret = i2c_smbus_write_byte_data(client, VL_REG_SYSRANGE_START, 1);
-	if (ret < 0)
-		return ret;
-
-	do {
-		ret = i2c_smbus_read_byte_data(client,
-			VL_REG_RESULT_RANGE_STATUS);
-		if (ret < 0)
-			return ret;
-
-		if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
-			break;
-
-		usleep_range(1000, 5000);
-	} while (--tries);
-	if (!tries)
-		return -ETIMEDOUT;
+	if (data->use_interrupt)
+		reinit_completion(&data->measuring_done);
+
+	i2c_smbus_write_byte_data(client, VL_REG_SYSRANGE_START, 1);
+
+	/* In usual case the longest valid conversion time is less than 70ms. */
+	if (data->use_interrupt) {
+		ret = wait_for_completion_timeout(&data->measuring_done,
+			msecs_to_jiffies(100));
+		if (!ret)
+			return -ETIMEDOUT;
+		vl53l0x_clear_interrupt(data);
+	} else {
+		do {
+			ret = i2c_smbus_read_byte_data(client,
+				VL_REG_RESULT_RANGE_STATUS);
+
+			if (ret & VL_REG_RESULT_RANGE_STATUS_COMPLETE)
+				break;
+
+			usleep_range(1000, 5000);
+		} while (--tries);
+		if (!tries)
+			return -ETIMEDOUT;
+	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, VL_REG_RESULT_RANGE_STATUS,
 		12, buffer);
@@ -110,10 +168,21 @@ static const struct iio_info vl53l0x_info = {
 	.read_raw = vl53l0x_read_raw,
 };
 
+/* Congigure the GPIO1 pin to generate interrupt for measurement ready,
+ * default polarity is level low.
+ */
+static int vl53l0x_config_irq(struct vl53l0x_data *data)
+{
+	i2c_smbus_write_byte_data(data->client, VL_REG_SYS_INT_CFG_GPIO,
+		VL_GPIOFUNC_NEW_MEASURE_RDY);
+	return vl53l0x_clear_interrupt(data);
+}
+
 static int vl53l0x_probe(struct i2c_client *client)
 {
 	struct vl53l0x_data *data;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -134,6 +203,34 @@ static int vl53l0x_probe(struct i2c_client *client)
 	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (!client->irq)
+		data->use_interrupt = false;
+	else {
+		data->use_interrupt = true;
+		ret = devm_request_irq(&client->dev,
+			client->irq,
+			vl53l0x_irq_handler,
+			IRQF_TRIGGER_FALLING,
+			indio_dev->name,
+			data);
+		if (ret < 0) {
+			dev_err(&client->dev,
+			"request irq line failed.");
+			return -EINVAL;
+		}
+		vl53l0x_config_irq(data);
+		init_completion(&data->measuring_done);
+	}
+
+	/* After checking this, assuming write and read byte operations should
+	 *  never fails.
+	 */
+	ret = i2c_smbus_read_byte_data(client, VL_REG_MODEL_ID);
+	if (ret != 0xEE) {
+		dev_err(&client->dev, "device not found. ");
+		return -EREMOTEIO;
+	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.17.1


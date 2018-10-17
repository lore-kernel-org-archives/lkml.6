Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9098ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8172820645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAVXuee8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8172820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeJRFb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:31:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46582 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeJRFb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:31:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id n11-v6so31226962wru.13;
        Wed, 17 Oct 2018 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCCY9OWuOAGMjHXYJ+Pmd53l0COCy7NXrn05gl9StOM=;
        b=aAVXuee8x554ergYvOUa5XAjumrVr4YHx10romgcP/X9zczc8lWpUNlRnaT9nDBCc6
         UASf0blglcNWB1qgrFhTU+JWYzUqGMP2Dr3cmOAF2HvTd7eemzBd37N23u/oS8WZh+my
         FaYCDz6rAuvk42NppILWbNMY3taeMqhV1e3j1YnZzTJ+t/Jd+bcKPXVKWbS3sAVwmpNe
         F6x6BHHkxqqJ8cMOefzYtdDLOhEwn+mfSyL0kvenj4vQHrNJhOav1dUuBXDzEsKoWrdG
         ErRCytcmFTUFlvVgH7vTkhxjEHAq5ChCpAYkRynrzWuRNQEBv4qsHYvBQIZQCnzPX6wo
         A/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HCCY9OWuOAGMjHXYJ+Pmd53l0COCy7NXrn05gl9StOM=;
        b=kTVShP//LatfMm56WklRkzeosY6oAjPA6dnGbWJLaFIiPN/kh8sDD+ji5l7AIpUWi/
         /wXtz9KJq8GdxSUQPT3Q7UxEpsQpYDOnzcqqkJW1CUcMfK1XJsG9L/vACkWW+A4Qtnhm
         1Zw2XhpUuc558qVjQX32omIwtMAZ786uYDWWetBqVPWsfd62Xdy31whAKPVw2mnROfGZ
         v+LENX0YUiBgMoIudkJHCNGwuOnG5JaHaayuIx4zB6LBzxiAtKGhHjtWQyC6HsV4vjIn
         1TrZyX0T2fqOd//3AyC8W3XZtMAcpIxwwQ7Sz63YRvrzNp1Bq31+/UsuMlBjH6vgPx9r
         zK5Q==
X-Gm-Message-State: ABuFfogOmWbKFuyqqS23Uwq9dh+kBv3KWSn2fPfJQvoh0obJMVf/zb8r
        zU8uxlwi7SjnkNMesGuT9uM=
X-Google-Smtp-Source: ACcGV61W/+EsSuDrKdLsAVh0T7iy02Vd3rpHBojGsdN1ZltBFO/SgwOgqWAvSOkoEDPHJtIPqVe6zg==
X-Received: by 2002:a5d:4409:: with SMTP id z9-v6mr23879140wrq.227.1539812029850;
        Wed, 17 Oct 2018 14:33:49 -0700 (PDT)
Received: from localhost.localdomain (164-235-243-213.terrecablate.net. [213.243.235.164])
        by smtp.gmail.com with ESMTPSA id 4-v6sm3623962wmt.16.2018.10.17.14.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 14:33:49 -0700 (PDT)
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
        Todor Tomov <todor.tomov@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 2/2] seco-cec: add Consumer-IR support
Date:   Wed, 17 Oct 2018 23:31:42 +0200
Message-Id: <0529aedcfa366f6f228dd334b0915aeb828fbe6b.1539807092.git.ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1539807092.git.ek5.chimenti@gmail.com>
References: <cover.1539807092.git.ek5.chimenti@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ettore Chimenti <ek5.chimenti@gmail.com>

Introduce support for Consumer-IR into seco-cec driver, as it shares the
same interrupt for receiving messages.
The device decodes RC5 signals only, defaults to hauppauge mapping.
It will spawn an input interface using the RC framework (like CEC
device).

Signed-off-by: Ettore Chimenti <ek5.chimenti@gmail.com>
Reviewed-by: Sean Young <sean@mess.org>
---
 drivers/media/platform/Kconfig             |  10 ++
 drivers/media/platform/seco-cec/seco-cec.c | 125 ++++++++++++++++++++-
 drivers/media/platform/seco-cec/seco-cec.h |  11 ++
 3 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 51cd1fd005e3..e6b45da2af6d 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -625,6 +625,16 @@ config VIDEO_SECO_CEC
 	  CEC bus is present in the HDMI connector and enables communication
 	  between compatible devices.
 
+config VIDEO_SECO_RC
+	bool "SECO Boards IR RC5 support"
+	depends on VIDEO_SECO_CEC
+	select RC_CORE
+	help
+	  If you say yes here you will get support for the
+	  SECO Boards Consumer-IR in seco-cec driver.
+	  The embedded controller supports RC5 protocol only, default mapping
+	  is set to rc-hauppauge.
+
 endif #CEC_PLATFORM_DRIVERS
 
 menuconfig SDR_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/seco-cec/seco-cec.c b/drivers/media/platform/seco-cec/seco-cec.c
index 9ac9a1f36bc0..c5af913d4715 100644
--- a/drivers/media/platform/seco-cec/seco-cec.c
+++ b/drivers/media/platform/seco-cec/seco-cec.c
@@ -26,6 +26,8 @@ struct secocec_data {
 	struct platform_device *pdev;
 	struct cec_adapter *cec_adap;
 	struct cec_notifier *notifier;
+	struct rc_dev *ir;
+	char ir_input_phys[32];
 	int irq;
 };
 
@@ -364,6 +366,114 @@ struct cec_adap_ops secocec_cec_adap_ops = {
 	.adap_transmit = secocec_adap_transmit,
 };
 
+#ifdef CONFIG_VIDEO_SECO_RC
+static int secocec_ir_probe(void *priv)
+{
+	struct secocec_data *cec = priv;
+	struct device *dev = cec->dev;
+	int status;
+	u16 val;
+
+	/* Prepare the RC input device */
+	cec->ir = devm_rc_allocate_device(dev, RC_DRIVER_SCANCODE);
+	if (!cec->ir)
+		return -ENOMEM;
+
+	snprintf(cec->ir_input_phys, sizeof(cec->ir_input_phys),
+		 "%s/input0", dev_name(dev));
+
+	cec->ir->device_name = dev_name(dev);
+	cec->ir->input_phys = cec->ir_input_phys;
+	cec->ir->input_id.bustype = BUS_HOST;
+	cec->ir->input_id.vendor = 0;
+	cec->ir->input_id.product = 0;
+	cec->ir->input_id.version = 1;
+	cec->ir->driver_name = SECOCEC_DEV_NAME;
+	cec->ir->allowed_protocols = RC_PROTO_BIT_RC5;
+	cec->ir->priv = cec;
+	cec->ir->map_name = RC_MAP_HAUPPAUGE;
+	cec->ir->timeout = MS_TO_NS(100);
+
+	/* Clear the status register */
+	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
+	if (status != 0)
+		goto err;
+
+	status = smb_wr16(SECOCEC_STATUS_REG_1, val);
+	if (status != 0)
+		goto err;
+
+	/* Enable the interrupts */
+	status = smb_rd16(SECOCEC_ENABLE_REG_1, &val);
+	if (status != 0)
+		goto err;
+
+	status = smb_wr16(SECOCEC_ENABLE_REG_1,
+			  val | SECOCEC_ENABLE_REG_1_IR);
+	if (status != 0)
+		goto err;
+
+	dev_dbg(dev, "IR enabled");
+
+	status = devm_rc_register_device(dev, cec->ir);
+
+	if (status) {
+		dev_err(dev, "Failed to prepare input device");
+		cec->ir = NULL;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	smb_rd16(SECOCEC_ENABLE_REG_1, &val);
+
+	smb_wr16(SECOCEC_ENABLE_REG_1,
+		 val & ~SECOCEC_ENABLE_REG_1_IR);
+
+	dev_dbg(dev, "IR disabled");
+	return status;
+}
+
+static int secocec_ir_rx(struct secocec_data *priv)
+{
+	struct secocec_data *cec = priv;
+	struct device *dev = cec->dev;
+	u16 val, status, key, addr, toggle;
+
+	if (!cec->ir)
+		return -ENODEV;
+
+	status = smb_rd16(SECOCEC_IR_READ_DATA, &val);
+	if (status != 0)
+		goto err;
+
+	key = val & SECOCEC_IR_COMMAND_MASK;
+	addr = (val & SECOCEC_IR_ADDRESS_MASK) >> SECOCEC_IR_ADDRESS_SHL;
+	toggle = (val & SECOCEC_IR_TOGGLE_MASK) >> SECOCEC_IR_TOGGLE_SHL;
+
+	rc_keydown(cec->ir, RC_PROTO_RC5, RC_SCANCODE_RC5(addr, key), toggle);
+
+	dev_dbg(dev, "IR key pressed: 0x%02x addr 0x%02x toggle 0x%02x", key,
+		addr, toggle);
+
+	return 0;
+
+err:
+	dev_err(dev, "IR Receive message failed (%d)", status);
+	return -EIO;
+}
+#else
+static void secocec_ir_rx(struct secocec_data *priv)
+{
+}
+
+static int secocec_ir_probe(void *priv)
+{
+	return 0;
+}
+#endif
+
 static irqreturn_t secocec_irq_handler(int irq, void *priv)
 {
 	struct secocec_data *cec = priv;
@@ -399,7 +509,8 @@ static irqreturn_t secocec_irq_handler(int irq, void *priv)
 	if (status_val & SECOCEC_STATUS_REG_1_IR) {
 		dev_dbg(dev, "IR RC5 Interrupt Caught");
 		val |= SECOCEC_STATUS_REG_1_IR;
-		/* TODO IRDA RX */
+
+		secocec_ir_rx(cec);
 	}
 
 	/*  Reset status register */
@@ -569,6 +680,10 @@ static int secocec_probe(struct platform_device *pdev)
 	if (secocec->notifier)
 		cec_register_cec_notifier(secocec->cec_adap, secocec->notifier);
 
+	ret = secocec_ir_probe(secocec);
+	if (ret)
+		goto err_delete_adapter;
+
 	platform_set_drvdata(pdev, secocec);
 
 	dev_dbg(dev, "Device registered");
@@ -586,7 +701,15 @@ static int secocec_probe(struct platform_device *pdev)
 static int secocec_remove(struct platform_device *pdev)
 {
 	struct secocec_data *secocec = platform_get_drvdata(pdev);
+	u16 val;
+
+	if (secocec->ir) {
+		smb_rd16(SECOCEC_ENABLE_REG_1, &val);
 
+		smb_wr16(SECOCEC_ENABLE_REG_1, val & ~SECOCEC_ENABLE_REG_1_IR);
+
+		dev_dbg(&pdev->dev, "IR disabled");
+	}
 	cec_unregister_adapter(secocec->cec_adap);
 
 	if (secocec->notifier)
diff --git a/drivers/media/platform/seco-cec/seco-cec.h b/drivers/media/platform/seco-cec/seco-cec.h
index 93020900935e..3f1aad89b073 100644
--- a/drivers/media/platform/seco-cec/seco-cec.h
+++ b/drivers/media/platform/seco-cec/seco-cec.h
@@ -99,6 +99,17 @@
 
 #define SECOCEC_IR_READ_DATA		0x3e
 
+/*
+ * IR
+ */
+
+#define SECOCEC_IR_COMMAND_MASK		0x007F
+#define SECOCEC_IR_COMMAND_SHL		0
+#define SECOCEC_IR_ADDRESS_MASK		0x1F00
+#define SECOCEC_IR_ADDRESS_SHL		7
+#define SECOCEC_IR_TOGGLE_MASK		0x8000
+#define SECOCEC_IR_TOGGLE_SHL		15
+
 /*
  * Enabling register
  */
-- 
2.18.0


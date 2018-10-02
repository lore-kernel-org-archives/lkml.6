Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE577C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624112064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5H1rMPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624112064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbeJBXyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:54:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeJBXyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:54:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so3079775wru.8;
        Tue, 02 Oct 2018 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q+dlI8HK8BngHo0+qey1wriLHh/zvWIhoDmJxPVwz2c=;
        b=N5H1rMPCqOpxbSHCOyHR+oiufXpS1jUcoh4rlUmxLsYTQTcZzWlfobJi5VlFq2FntZ
         yEKTYRi6njjXjaDXc+s/MwnPTj0E5JCp5Vr2wQ5odYtXmEjBjaqjRuxX8vt+koU5c5xn
         1Z46Pa+asAM8UoHaECaxvyi3ngkZEGZvWZVIc71x+QN1EqoGRbv0sgN1Ap+KOCRukTeK
         pIyen0SdoEaJPAVPwQxu3ut2Xfs0GgSVBwV/O+1+c1M/9qbazZJsenILXNG2GBnd0I7q
         CAlR6NQ+VbI5zqJZ4ycgf/0D0nE2kFweAYp/HT1u/v1luaroITIahyMQGW99uZlWme4x
         fVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q+dlI8HK8BngHo0+qey1wriLHh/zvWIhoDmJxPVwz2c=;
        b=Ul2XebKGBlbqHsLAfOUTim/qag9MVNnjmq4m6YB4QfuZ72nR25oJTbq6aNhwC3tw7W
         VzGds5LHqrJoqPqAc+5dGokMav8Kr2/TAcOn/Az+LtZOVE8BmaXQsz8vICM0E2oXqZWl
         GmpZeyfAuyvA24srbQvEY7LsWkDiZb6n33y9oR9EnLUIEktAcEXkVXEVfzNm/8JCHVKQ
         KslT+18koUuP4s7x5bHMAVzggtGzm/S1F7KrxLUJZ0eaSiNNta7utDmfml1BMAngXZWX
         A3VWK6z+5jyxda22TqLvxpiekQuYbZq1MiPcWpUpXfuwFptU2XYpErxxbOOm0H6icpSB
         TF8g==
X-Gm-Message-State: ABuFfoh7butvrCnREOHElgD3Lnv/WNFvZYgg0TGVGGgcC6n8P7/3/3dk
        fN2c8UBv9gQlvNC///so2pc=
X-Google-Smtp-Source: ACcGV60gg7/5/BxEXrFHaAKEv5qe/9X+BpSuakhI9Xv1Iv4hv7AwEzW84sKW/Pke8AdK8oakHq0A1A==
X-Received: by 2002:adf:dd83:: with SMTP id x3-v6mr11099097wrl.212.1538500175617;
        Tue, 02 Oct 2018 10:09:35 -0700 (PDT)
Received: from localhost.localdomain (generic-nat1.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id c19-v6sm16799508wre.86.2018.10.02.10.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 10:09:35 -0700 (PDT)
From:   ektor5 <ek5.chimenti@gmail.com>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sean@mess.org, sakari.ailus@linux.intel.com,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 2/2] seco-cec: add Consumer-IR support
Date:   Tue,  2 Oct 2018 18:59:56 +0200
Message-Id: <beeab2fa9a2906ecaebb225dc88ca4c0c88dd14b.1538474121.git.ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538474121.git.ek5.chimenti@gmail.com>
References: <cover.1538474121.git.ek5.chimenti@gmail.com>
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
---
 drivers/media/platform/Kconfig             |  10 ++
 drivers/media/platform/seco-cec/seco-cec.c | 136 ++++++++++++++++++++-
 drivers/media/platform/seco-cec/seco-cec.h |  11 ++
 3 files changed, 154 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f477764b902a..5833f488eef8 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -624,6 +624,16 @@ config VIDEO_SECO_CEC
          CEC bus is present in the HDMI connector and enables communication
          between compatible devices.
 
+config VIDEO_SECO_RC
+       bool "SECO Boards IR RC5 support"
+       depends on VIDEO_SECO_CEC
+       select RC_CORE
+       help
+	 If you say yes here you will get support for the
+	 SECO Boards Consumer-IR in seco-cec driver.
+         The embedded controller supports RC5 protocol only, default mapping
+         is set to rc-hauppauge.
+
 endif #CEC_PLATFORM_DRIVERS
 
 menuconfig SDR_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/seco-cec/seco-cec.c b/drivers/media/platform/seco-cec/seco-cec.c
index ba3b7c144a87..ee1949395cf4 100644
--- a/drivers/media/platform/seco-cec/seco-cec.c
+++ b/drivers/media/platform/seco-cec/seco-cec.c
@@ -28,6 +28,9 @@ struct secocec_data {
 	struct platform_device *pdev;
 	struct cec_adapter *cec_adap;
 	struct cec_notifier *notifier;
+	struct rc_dev *irda_rc;
+	char irda_input_name[32];
+	char irda_input_phys[32];
 	int irq;
 };
 
@@ -383,6 +386,119 @@ struct cec_adap_ops secocec_cec_adap_ops = {
 	.adap_transmit = secocec_adap_transmit,
 };
 
+#ifdef CONFIG_VIDEO_SECO_RC
+static int secocec_irda_probe(void *priv)
+{
+	struct secocec_data *cec = priv;
+	struct device *dev = cec->dev;
+	int status;
+	u16 val;
+
+	/* Prepare the RC input device */
+	cec->irda_rc = devm_rc_allocate_device(dev, RC_DRIVER_SCANCODE);
+	if (!cec->irda_rc) {
+		dev_err(dev, "Failed to allocate memory for rc_dev");
+		return -ENOMEM;
+	}
+
+	snprintf(cec->irda_input_name, sizeof(cec->irda_input_name),
+		 "IrDA RC for %s", dev_name(dev));
+	snprintf(cec->irda_input_phys, sizeof(cec->irda_input_phys),
+		 "%s/input0", dev_name(dev));
+
+	cec->irda_rc->device_name = cec->irda_input_name;
+	cec->irda_rc->input_phys = cec->irda_input_phys;
+	cec->irda_rc->input_id.bustype = BUS_HOST;
+	cec->irda_rc->input_id.vendor = 0;
+	cec->irda_rc->input_id.product = 0;
+	cec->irda_rc->input_id.version = 1;
+	cec->irda_rc->driver_name = SECOCEC_DEV_NAME;
+	cec->irda_rc->allowed_protocols = RC_PROTO_BIT_RC5;
+	cec->irda_rc->enabled_protocols = RC_PROTO_BIT_RC5;
+	cec->irda_rc->priv = cec;
+	cec->irda_rc->map_name = RC_MAP_HAUPPAUGE;
+	cec->irda_rc->timeout = MS_TO_NS(100);
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
+	status = devm_rc_register_device(dev, cec->irda_rc);
+
+	if (status) {
+		dev_err(dev, "Failed to prepare input device");
+		cec->irda_rc = NULL;
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
+static int secocec_irda_rx(struct secocec_data *priv)
+{
+	struct secocec_data *cec = priv;
+	struct device *dev = cec->dev;
+	u16 val, status, key, addr, toggle;
+
+	if (!cec->irda_rc)
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
+	rc_keydown(cec->irda_rc, RC_PROTO_RC5, key, toggle);
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
+static void secocec_irda_rx(struct secocec_data *priv)
+{
+}
+
+static int secocec_irda_probe(void *priv)
+{
+	return 0;
+}
+#endif
+
 static irqreturn_t secocec_irq_handler(int irq, void *priv)
 {
 	struct secocec_data *cec = priv;
@@ -420,7 +536,8 @@ static irqreturn_t secocec_irq_handler(int irq, void *priv)
 	if (status_val & SECOCEC_STATUS_REG_1_IR) {
 		dev_dbg(dev, "IR RC5 Interrupt Caught");
 		val |= SECOCEC_STATUS_REG_1_IR;
-		/* TODO IRDA RX */
+
+		secocec_irda_rx(cec);
 	}
 
 	/*  Reset status register */
@@ -595,6 +712,10 @@ static int secocec_probe(struct platform_device *pdev)
 	if (secocec->notifier)
 		cec_register_cec_notifier(secocec->cec_adap, secocec->notifier);
 
+	ret = secocec_irda_probe(secocec);
+	if (ret)
+		goto err_delete_adapter;
+
 	platform_set_drvdata(pdev, secocec);
 
 	dev_dbg(dev, "Device registered");
@@ -614,7 +735,16 @@ static int secocec_probe(struct platform_device *pdev)
 static int secocec_remove(struct platform_device *pdev)
 {
 	struct secocec_data *secocec = platform_get_drvdata(pdev);
+	u16 val;
+
+	if (secocec->irda_rc) {
+		smb_rd16(SECOCEC_ENABLE_REG_1, &val);
 
+		smb_wr16(SECOCEC_ENABLE_REG_1,
+			 val & ~SECOCEC_ENABLE_REG_1_IR);
+
+		dev_dbg(&pdev->dev, "IR disabled");
+	}
 	cec_unregister_adapter(secocec->cec_adap);
 
 	if (secocec->notifier)
@@ -632,8 +762,8 @@ static int secocec_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int secocec_suspend(struct device *dev)
 {
-	u16 val;
 	int status;
+	u16 val;
 
 	dev_dbg(dev, "Device going to suspend, disabling");
 
@@ -665,8 +795,8 @@ static int secocec_suspend(struct device *dev)
 
 static int secocec_resume(struct device *dev)
 {
-	u16 val;
 	int status;
+	u16 val;
 
 	dev_dbg(dev, "Resuming device from suspend");
 
diff --git a/drivers/media/platform/seco-cec/seco-cec.h b/drivers/media/platform/seco-cec/seco-cec.h
index cc7f0cba8e9e..c00660104a3e 100644
--- a/drivers/media/platform/seco-cec/seco-cec.h
+++ b/drivers/media/platform/seco-cec/seco-cec.h
@@ -101,6 +101,17 @@
 
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


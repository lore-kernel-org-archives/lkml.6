Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lSqABOxiHlu3WgAAmS7hNA
	; Mon, 11 Jun 2018 11:54:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BEB0160792; Mon, 11 Jun 2018 11:54:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RANv3zPP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 351A9601C3;
	Mon, 11 Jun 2018 11:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 351A9601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933292AbeFKLyi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:54:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35672 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933193AbeFKLxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so19795871lfc.2;
        Mon, 11 Jun 2018 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Km7hK8QIdn2ncv5EakjPSi0LKzKQ4/VXQjW2Pxz1Rg=;
        b=RANv3zPP2qXa4P9hJYP4evHbeKol2nfhjTdwsCuBO7SKmcAcNIjr9XcLvlPyZfBNLq
         mfcC3bljhZG5P+/+lzkmPcOsICV9TWtwKOdMWIwHVu4uokiVcYfo7qnrv6C5Y/OXlUjp
         3kg+/i2yCNiox3KYId4Opne+zeMFBSjY7YfPiNVnIqZZiOdCdI3w74JYM1zSZ7getqSH
         16uU23wBPgLHwfE9/WxYDD6F+FzoLlBxI/e5A9vjjO1Tq0Uy3214VNu3tGhypUW4Q/uP
         XN5dw8SsRV9iZBIdi1DeVIpTlxvlGC3BbTWGorSnRjYxnMRis1KgWA/sfdTP2Ude5tLf
         lveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Km7hK8QIdn2ncv5EakjPSi0LKzKQ4/VXQjW2Pxz1Rg=;
        b=fVamGczBpB0NmQ6Ykq63ARdgcEdZWNIQYU+WyigmixSaEfhQFex/9GHxvrePa+HeSA
         x1kxEpp0lpz6ion6IxyH5CNmAfVuW4WcsrqXsYKG/eEI7okPTPkdCOIFJorvo0Y7tLpb
         npNvUb28VjeigOqSKaLvuGqku6ptcLKRijET69PSCcekFfyKp4GD9cz0WyIUk3Tmn6Lk
         o1oTizwgllop+8BcQB//7AA5cjhqlrjY6fj8FaXB9LnZuzA+PRjdJcRi8HZKxjVTm0fM
         bUZ4WLMrMDYkoK7bjq9AXsgTnpBgfc61vELnTBGQT0tUSgHPuGJT0MQKAckTskRXVUXW
         18tw==
X-Gm-Message-State: APt69E0NYD3Jokd+zf64Cg/KeyJt2UMSd+0oXx8hec6WAIqA2Eva9Z3e
        mk4upahXBGcUV3IXZH34lf082WYY
X-Google-Smtp-Source: ADUXVKL4PSTB9udamdt6v9Udw3WWq9ngl/eLUUyoZ4Nh4jRRG3j65FjYojTNz7mLixmsNDwhLODD0Q==
X-Received: by 2002:a19:8f1d:: with SMTP id r29-v6mr10645029lfd.88.1528718010510;
        Mon, 11 Jun 2018 04:53:30 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:29 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 21/24] rave-sp: Support for variants on modalias drivers
Date: Mon, 11 Jun 2018 13:52:37 +0200
Message-Id: <20180611115240.32606-22-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rave-sp behaves differently based on the device variant.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mfd/rave-sp.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index c0ecfbc16dca..d33cb9d914e8 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -654,14 +654,30 @@ static const struct serdev_device_ops rave_sp_serdev_device_ops = {
 	.write_wakeup = serdev_device_write_wakeup,
 };
 
+static struct serdev_device_id rave_sp_serdev_id[] = {
+	{ "rave-sp", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-niu", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-mezz", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-esb", (kernel_ulong_t) &rave_sp_legacy},
+	{ "rave-sp-rdu1", (kernel_ulong_t) &rave_sp_rdu1},
+	{ "rave-sp-rdu2", (kernel_ulong_t) &rave_sp_rdu2},
+	{}
+};
+MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
+
 static int rave_sp_probe(struct serdev_device *serdev)
 {
 	struct device *dev = &serdev->dev;
+	const struct serdev_device_id *id;
 	struct rave_sp *sp;
 	u32 baud;
 	int ret;
 
-	if (of_property_read_u32(dev->of_node, "current-speed", &baud)) {
+	if (!dev->of_node) {
+		/* Baudrate at zii,rave-sp.txt */
+		baud = 1000000;
+	} else if (of_property_read_u32(dev->of_node,
+					"current-speed", &baud)) {
 		dev_err(dev,
 			"'current-speed' is not specified in device node\n");
 		return -EINVAL;
@@ -675,6 +691,12 @@ static int rave_sp_probe(struct serdev_device *serdev)
 	dev_set_drvdata(dev, sp);
 
 	sp->variant = of_device_get_match_data(dev);
+	if (!sp->variant) {
+		id = serdev_match_id(rave_sp_serdev_id, serdev);
+		if (id)
+			sp->variant = (const struct rave_sp_variant *)
+							id->driver_data;
+	}
 	if (!sp->variant)
 		return -ENODEV;
 
@@ -694,12 +716,6 @@ static int rave_sp_probe(struct serdev_device *serdev)
 
 MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
 
-static struct serdev_device_id rave_sp_serdev_id[] = {
-	{ "rave-sp", },
-	{}
-};
-MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
-
 static struct serdev_device_driver rave_sp_drv = {
 	.probe			= rave_sp_probe,
 	.driver = {
-- 
2.17.1

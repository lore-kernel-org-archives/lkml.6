Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C932070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gObyBCe4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfBVUFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42834 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfBVUFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so1572501pfi.9;
        Fri, 22 Feb 2019 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqLLLZ7SNRbhZcaZxD3tUMVt6ASJUlU3TajMCB0kElk=;
        b=gObyBCe4QBfTlzpYe9OKwBa9Twj4xooPPwGYrIxh5l7qTTwFx5whq4T/qCnkmvISnP
         WJj0T5a3mxGq26W0LEz8LbcNgQciVL7T/Fs61U6YZ9x4EoWQuaEDyLUb333zolm+q30t
         G4c0O/9TTdwfeCcz5e1xkSc5UDH8wJYO9cZTN1ve8TKGwaR7SsLar78UL6dffS33igFi
         yP9BuASa8wh6k/HqRrD5qt8u5tZN1T7HOUOu8vVHAg6NkJzhzzAdop7tFn5Gb/zhe/lF
         c2dn9bn/V8ld4kdcUQOW0Z8q9blVfD5k+YYrIyN1xVCgGailEHiZjP/jPSYJNkU22QdE
         JDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqLLLZ7SNRbhZcaZxD3tUMVt6ASJUlU3TajMCB0kElk=;
        b=pkEXG9M+nZ7KoFEOcHYNPqWZtaWLgB1/m1r2GGlUTRpjSZN0OLDkIq1NXZamWXCctr
         RL6ECIeK6/z/WeQfGwAp5KBNPCp3vmXxqAWjdy+tWjOdr1pyN0sUJ4AbSD3DJBVxLGuM
         WqUUU1v20QffvZIBTlZAFnG/gtEKr2W38NYPbYwaY/cjU7xDi9L1mZ2kX4zXnz7QFSGu
         wezG2MrctnMRLd3nAFT2Db2zO5L2/a0lMFguOh37QAfe9hBaX/3C80ibfyaKD38htr37
         Du3fWQb/WTEN54IA1Nm3XMS/HuXN8Z0v3g+4p1b9L0IxiB5cSe09QCtRa9yfsDaUsS4J
         4S3Q==
X-Gm-Message-State: AHQUAuYKorH1OiUI4KDMzyJwf7gDU7rp1iqVAFs3D/pns5A3Sc/oEOJc
        awdJ2xa//t8ViK8Orf+XDM5GTfHn
X-Google-Smtp-Source: AHgI3IaLSgzhU5mgYIzLEAEAwXC8gAgqhwTdZwNxoZH5nvnVpGxwdOzBrgpR4wfSYkyiV61dU1vi8Q==
X-Received: by 2002:a65:63c1:: with SMTP id n1mr5494974pgv.339.1550865932193;
        Fri, 22 Feb 2019 12:05:32 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:31 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] thermal: qoriq: Convert driver to use devm_ioremap()
Date:   Fri, 22 Feb 2019 12:05:04 -0800
Message-Id: <20190222200508.26325-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use devm_ioremap() to simplify memory deallocation
and error handling code. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index a3ddb55740e4..4f9a2543f9c3 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -192,6 +192,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct resource *io;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
@@ -200,7 +201,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
-	data->regs = of_iomap(np, 0);
+	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!io) {
+		dev_err(dev, "Failed to get memory region\n");
+		return -ENODEV;
+	}
+
+	data->regs = devm_ioremap(dev, io->start, resource_size(io));
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
 		return -ENODEV;
@@ -210,23 +217,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
-		goto err_tmu;
+		return ret;
 
 	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	platform_set_drvdata(pdev, data);
 
 	return 0;
-
-err_tmu:
-	iounmap(data->regs);
-
-	return ret;
 }
 
 static int qoriq_tmu_remove(struct platform_device *pdev)
@@ -236,7 +237,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-	iounmap(data->regs);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.20.1


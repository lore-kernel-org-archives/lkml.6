Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C507C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A841217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjNKfqqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfBRTML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:11 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33508 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfBRTMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:08 -0500
Received: by mail-pg1-f182.google.com with SMTP id h11so6560018pgl.0;
        Mon, 18 Feb 2019 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DeiicEMgTNNDXmv9VFBWv0NLs52ELmzeLlmAN97MkhY=;
        b=fjNKfqqj/FzICc/YOAr9PB8rRoEk/c1KFLlRAYyd62uhV7u4JKnM6mBSDycEwGM87W
         UArXN2i5yxjtcVv5zC+oOWPlOLxg+jwWo1tVGfKwGu0SzN0aX9N2fGISr+Q8txd27F7G
         c/JRi/+UUf2q2pngdbZ7JHpmX4AiS2RzEVwnxyDmwxMwPxvKE3qdmbrfjVVSFFxfZpR+
         HjAVwBJTMrycS05qvNvIlc2m4H7fvrQlo4hhjpLMsZjgXTRH1p7/lOrwCS6oTxSKZU2G
         Foon8YlAqo+VnET5x+0WMU8iETmv4cbqcGIXv1xPnIJpjiXpyg0DDZUIU0Jc/nqSu/qL
         AcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DeiicEMgTNNDXmv9VFBWv0NLs52ELmzeLlmAN97MkhY=;
        b=kjlAD6m/sVNONl8FVWTjv5LaZjxpyG+DLK2NPJDh2l56ejmjr6rdj37KTNGurE3hzV
         dO+SHtIssno1fuAVscs8b7OtTdz3xSaSebQyCvgQB09t07ZectKcKPGxjK8CKidZyRpj
         mREmI7tu9ZMwzyYgZbU3A9a393XHz8TX8m/AJx+s3isu2myz0S9OySoi9R4t3vqxiNLi
         AAAgmCHZvwF2rTu9SaDUdBlvp6UbCqvDirJs73KiD0+V1Sr8xSrqvm3kJG3DewVypyx9
         td154uyV4h3PnRUMJsUyVLwKafIDEvWyH5f+FjPA293Mk6ceYTygx1MFR5GQIPa94d1H
         ZT5w==
X-Gm-Message-State: AHQUAuZxR1+G027/nlVAC9jK8H/3RKUkvFso2YG+Dy0XFLszq/FTZgyl
        TMmars6EAUAglmECQTbGrI4EQe7J
X-Google-Smtp-Source: AHgI3IaQVpXnaz63akuwJm0/LH/evwSdpMtlHXcstLPBhcBLJjXdaWpAXVK6m562uZl7JNaO7z0B+g==
X-Received: by 2002:a63:6ec2:: with SMTP id j185mr23988244pgc.341.1550517126518;
        Mon, 18 Feb 2019 11:12:06 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:05 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] thermal: qoriq: Convert driver to use devm_ioremap()
Date:   Mon, 18 Feb 2019 11:11:34 -0800
Message-Id: <20190218191141.3729-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 9bae001e8264..472594fca03b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -188,6 +188,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct resource *io;
 	u32 site;
 
 	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
@@ -203,7 +204,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
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
@@ -213,7 +220,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
-		goto err_tmu;
+		return ret;
 
 	data->tz = devm_thermal_zone_of_sensor_register(dev,
 							data->sensor_id,
@@ -222,7 +229,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->tz);
 		dev_err(dev, "Failed to register thermal zone device %d\n",
 			ret);
-		goto err_tmu;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -232,11 +239,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
 
 	return 0;
-
-err_tmu:
-	iounmap(data->regs);
-
-	return ret;
 }
 
 static int qoriq_tmu_remove(struct platform_device *pdev)
@@ -246,7 +248,6 @@ static int qoriq_tmu_remove(struct platform_device *pdev)
 	/* Disable monitoring */
 	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
 
-	iounmap(data->regs);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
2.20.1


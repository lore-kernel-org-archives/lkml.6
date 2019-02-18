Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F5521773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHzWjj0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfBRTMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35844 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfBRTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so9193714plo.3;
        Mon, 18 Feb 2019 11:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc/u/VuNKfP8g2qvvHU2FxhsXY6Y2Hqv0zrQmbupw/s=;
        b=YHzWjj0wVwV11iaUNXTj+NPB2YpyyuXkUVX2Pvp4oy8Gk7ifkFKKRy+3RmgnbVlLOs
         NwX+tS4mWW4yIWPrGIiSIEH0JaNj51UJclX6SlVa+ineTYnRJHY6fNGXBK8qmc77lgwE
         wqxsgDypBba/ZF5uzgc4YMsmmU3t8+D1oq66bB9Wq5JqTcbAGHeJjhe0ZIB8gqD8f4xX
         xdcIST/kjt3drYfa7CTbyRuati15W+dU0b/JqeUhON2Y4cWcS+xwrBRZEEXOm2lq6Bw2
         GjDmmjL07Z3O2iWqD0lO3cuSmGLbJiiKBAOylPZE5iF7DGp+PN77iNizmGgynlH+LNBB
         jHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc/u/VuNKfP8g2qvvHU2FxhsXY6Y2Hqv0zrQmbupw/s=;
        b=E0DWzWmDihRATupSwN/oKDIAyUo+JE/0mT9ecOCS+loXmDbHLFN1Bof7OOuTwANpDD
         J2lXy3MMzaICRB7PxbT1kMBKVoTG5+p+NtzSgQIxEIdQnIMNDsjbXl2V+8x093NDmbcI
         nZcUV2FXiRNlaeQIkKayvon5l/ycFQ0CSnAQRFeNEa5u3e4CorxVnkx14cijCuLQMXpz
         NVEXDR9a5xwYqFq1oc8CU6T6FQpuJ9CWBjpVlGCGocb1e/opdV+X5QUdFHQoXqiT7Ibp
         ZHGyEZtQbNICg0FIiv4qliDYLeVwskwhDjZKBRZdcFnEu4zUuRE5vPjEUAJY172NguQf
         //iA==
X-Gm-Message-State: AHQUAuYzdbbLNZ3dV6XPD0lDCdDMidNtmUOnfGyldABtXkVq0aY9g7WJ
        2saMWWzQfv0J4YJdeEIv/i3dfDfb
X-Google-Smtp-Source: AHgI3IYslZ6vXzVJOws6v4XkMHK4nyyilwux8yHpbVBOV+JwD3hxaUDowdpLGOg7RRgMAFQSwtA1Nw==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr26992694plb.312.1550517125360;
        Mon, 18 Feb 2019 11:12:05 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:04 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] thermal: qoriq: Don't pass platform_device to qoriq_tmu_calibration()
Date:   Mon, 18 Feb 2019 11:11:33 -0800
Message-Id: <20190218191141.3729-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify error cleanup code if instead of passing a "struct
platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
pointers from it, we pass those pointers directly. This way we won't
be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
and consequently would be able to drop the "err_iomap" error path.

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
 drivers/thermal/qoriq_thermal.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index c24629b1b8c2..9bae001e8264 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -131,16 +131,16 @@ static int qoriq_tmu_get_sensor_id(void)
 	return id;
 }
 
-static int qoriq_tmu_calibration(struct platform_device *pdev)
+static int qoriq_tmu_calibration(struct device *dev,
+				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
 	u32 range[4];
 	const u32 *calibration;
-	struct device_node *np = pdev->dev.of_node;
-	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
+	struct device_node *np = dev->of_node;
 
 	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
-		dev_err(&pdev->dev, "missing calibration range.\n");
+		dev_err(dev, "missing calibration range.\n");
 		return -ENODEV;
 	}
 
@@ -152,7 +152,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-		dev_err(&pdev->dev, "invalid calibration data.\n");
+		dev_err(dev, "invalid calibration data.\n");
 		return -ENODEV;
 	}
 
@@ -195,27 +195,23 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
-
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
 	data->sensor_id = qoriq_tmu_get_sensor_id();
 	if (data->sensor_id < 0) {
 		dev_err(dev, "Failed to get sensor id\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
-	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
+	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
 		goto err_tmu;
 
@@ -229,6 +225,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_tmu;
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	/* Enable monitoring */
 	site = 0x1 << (15 - data->sensor_id);
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
@@ -238,9 +236,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 err_tmu:
 	iounmap(data->regs);
 
-err_iomap:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
-- 
2.20.1


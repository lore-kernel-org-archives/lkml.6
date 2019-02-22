Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0012075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXfl028O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfBVUFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43857 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfBVUFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id q17so1565066pfh.10;
        Fri, 22 Feb 2019 12:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DF+U7jec2vwBq5RISWjZK21z6pkE4cy5vtWadcx9fKU=;
        b=OXfl028OrtCJoksAex41Ke6wdyAeILRlnOcHwkK4adqj6xM8fKuBBzo61SNPHnTnKQ
         //DroY0NhcSt1w7cueIAIfGR8Pi9UTwCPdpTWjf3GtT5cqRO42LAjlyp8U2JLB7eGoUk
         VCyKbhbxmgufTJwhb5GTCHxT95Xalc3hXnaweYtYVpeGkYLad6W1X4kCIEH8lJFxoK5z
         zMEch/9uWaBiKa3bk7TD82DUxYhEEgKEqzjNV0ZeIb/jJdgo874LsxUEEb8UPCO+Q+gF
         TyEPIaLr03/ZSyO02eODQOWWjXO8ly7bK7CAFrqA8nZS1baSz2NBKQIlN8yu4il7Ijgc
         XGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DF+U7jec2vwBq5RISWjZK21z6pkE4cy5vtWadcx9fKU=;
        b=WRKlsoNy0Z0cQ62M/hW3nHTt9Qgugt/Wgswj+jA90Dlq1WrFxMknooKVSyeyKC7gMu
         ZGwwWlI4S10SzfpTHtl865TgnAojF7nZr5euzcSIhRJ64LVya0hyr3YH/U0uLhClIash
         S/4GPZksQcf4c28zmzoT5nPrR5pOBqLTVhtSgau19DmlvZOSW1q+eH6mykr4dXv3RdFt
         yXMSpAfcDUeU3iKc3VJOu8B0eUvp0juy/i878ySKrwsEUrvdkR3Wc09brBxyvYORkDNL
         t75VvdOVckjiHHpSV8dpV4+MZszBnyyRhu1zwX/p6oSXrKQK//VuAYWSPvj30oDRBVBv
         tTZA==
X-Gm-Message-State: AHQUAuabRHnmKJ6xHhdKqlfVIEib9porKvZ5UJ6UhxLs/XGr/v7jOt4H
        PEFTZRCrm8+SVV4LVGr+SxBwWHnp
X-Google-Smtp-Source: AHgI3IY4nNdUeEGR7BAfsxd0YjXL3R+WhU/LfTn2q6Brs95UZueR/hJfdf6jc6jOXc92TSSfD7nUgg==
X-Received: by 2002:a63:2905:: with SMTP id p5mr5639170pgp.178.1550865930950;
        Fri, 22 Feb 2019 12:05:30 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:30 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Fri, 22 Feb 2019 12:05:03 -0800
Message-Id: <20190222200508.26325-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 24a2a57f61c9..a3ddb55740e4 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -139,16 +139,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 	return 0;
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
 
@@ -160,7 +160,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-		dev_err(&pdev->dev, "invalid calibration data.\n");
+		dev_err(dev, "invalid calibration data.\n");
 		return -ENODEV;
 	}
 
@@ -198,20 +198,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
-
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
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
 
@@ -222,14 +219,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_iomap;
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 
 err_tmu:
 	iounmap(data->regs);
 
-err_iomap:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
-- 
2.20.1


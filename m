Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF07C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D350421773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T18h4qgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfBRTNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:13:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37960 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfBRTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so6654263pgl.5;
        Mon, 18 Feb 2019 11:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eb7kE3DHvy3VK3/mYaHKYpiE8Yr6d8ijyZ/9XxxBzBk=;
        b=T18h4qgXHAV7nzWw1T+X9pd9x15pu5Vu2tTkQvdImXQocuNo4fc6WU+dUIhJPj6ZHg
         1nE4zcuW0Kl1LdKLDG9f+7vi+fzq616nL8INBtKwmRYg2lW2a1cCfT519ETQBQOYM1Pv
         X7wuesIKMm4fKl1e/Bo+2aY2YogA9DaooZFTPcxMbpoOFMrhYtoMAlkjqbRKlEgjgf9/
         2vZWU2ojn04um5J27kq1JSrFsmhvQhFPZ9FAHcbE560jxo/zC0kd+NKVulNWTr2bvahT
         /KrDvKA+L9pVkxnaSXfuFCeI37/1z+nOw51MxRVgNZPxCA+7saR2RV4lm66+1CnZfJ6f
         h3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb7kE3DHvy3VK3/mYaHKYpiE8Yr6d8ijyZ/9XxxBzBk=;
        b=DPydy0gEEoLcmO8zKuLqfxKkh7ox1kXqmRCYeiMfF0sCs/K681n9l7z4a8ZIqLHpFh
         eLkMIEmmb8boornr966RvZWNs73NL2JxGJvrfOSKHDat5GpdaPLPchEUwXWdahDCFFnX
         PN/TcZwg5f2EdFRIE3/iSpNFH5clj9UDyKbWYHEYA2gHu3B1buGeLST+MT02eYT7UMxW
         nTdSYJkpSiuOBM8EhRr5HbvRElZplqkJvf7da++DNA+/pbHZKSDTt8OKMg7y+qbFsH+G
         YgUiUFAV5KkfocRZMXd0r2196ez/oncXaRhMCHNgZ1KAzITVGUny/KkIDtq3st1y6gZr
         ENrg==
X-Gm-Message-State: AHQUAuaEKEDLRpjWzkMvFvo9FU3ZQXTIx1xJe9RZvKDhzPIk/8Po/yXt
        41/nnYNtTLcu7rDJ4yZH3UQOwz+5
X-Google-Smtp-Source: AHgI3IZyNnuIwjLe2Y4pgNQvrTQrd2XO3sT8ILERWDh6EqGC+m+ETz1bLzkBivaz+cr16FeOJUnL4w==
X-Received: by 2002:a65:608d:: with SMTP id t13mr20610143pgu.129.1550517124083;
        Mon, 18 Feb 2019 11:12:04 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:03 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] thermal: qoriq: Add local struct device pointer in qoriq_tmu_probe()
Date:   Mon, 18 Feb 2019 11:11:32 -0800
Message-Id: <20190218191141.3729-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct device *dev" for brevity. No functional change
intended.

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
 drivers/thermal/qoriq_thermal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3e147f856bf5..c24629b1b8c2 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -187,9 +187,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	u32 site;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -200,14 +201,14 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->sensor_id = qoriq_tmu_get_sensor_id();
 	if (data->sensor_id < 0) {
-		dev_err(&pdev->dev, "Failed to get sensor id\n");
+		dev_err(dev, "Failed to get sensor id\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
@@ -218,13 +219,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	data->tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
+	data->tz = devm_thermal_zone_of_sensor_register(dev,
 							data->sensor_id,
 							data, &tmu_tz_ops);
 	if (IS_ERR(data->tz)) {
 		ret = PTR_ERR(data->tz);
-		dev_err(&pdev->dev,
-			"Failed to register thermal zone device %d\n", ret);
+		dev_err(dev, "Failed to register thermal zone device %d\n",
+			ret);
 		goto err_tmu;
 	}
 
-- 
2.20.1


Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA97BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980B72070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+I8V6XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfBVUFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfBVUF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so1609193pgd.1;
        Fri, 22 Feb 2019 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnHZREnbOOJnUFH9pYZUBx2fu83ZLA3vaVq7g/VF7bA=;
        b=S+I8V6XSdYXv5tgFuS+k/2JOP5txTH4/mbLCyjS3o4pe0dkLMRmPTiLW+Zxjadi2sD
         Ql1FJWgLqy2mbS/yl4dU74/g/hkQeP4Bly7bncccYPXTSlBHVzoa/40nxLsPwAdIs7X9
         Tg+hF4O1FD6hzRQ9eAin2of9IUDQOBXVtXuBEHrkjzis7aUXSazEpWHZbZ72+v1zoAtO
         RFtpA00wDoBWt3UC7fxTHNxVvzqndDReU0mGK0FoLQs2o1qU9q/nXQ27PqlJuVvakk4v
         WElPlxjyBasBGsUHTRkQtcgYD85lmTlZRGyNg7EXMrs5ZO4/QLNHRfK4BTII8gtYAvhH
         x9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnHZREnbOOJnUFH9pYZUBx2fu83ZLA3vaVq7g/VF7bA=;
        b=jFLQS/Ih7Jt0GqRJ03CUZcARS6wrnE0oa3daQe4KBecvY3DYJ8Uawpw/iVZrWnUQsT
         zfu9+bO4wuKY6fMm+dvUD28myFxgX+C4G4ijlUAF5Nw41HAqBvUGO1ypw0ZJPDkSSPfr
         Dyq4Kxfwf8zmhagO0r8us9WTtOIwYPrHWZxxLA6iFb26H8owbo9oIt3C320bd52Rz5DQ
         3szec7aTzN9xewdnpMBIaT4cprmk71Nhw/NBhGgM8FGKmO3Ia1TGm4BxZagWlvcJXn0f
         LjcQCzkOf142gZVFoXyITL2dYEMMMjMY/21L7kll25pJIgdV/Wj8+oJoiw0F/R3dauDw
         Z4Bw==
X-Gm-Message-State: AHQUAuYxtSCnJldsc/wJXuho4EdkZhO31sdDEnChMtN9Oq7dfB/prDdr
        GePVlk/WB3rlZg+8gT1SGG6zVoQn
X-Google-Smtp-Source: AHgI3IYfAGmzaioulXIit52im69zsV2p8Ve1Y4NZCy7R9x0cXzyc3RV5NlhpQABZ7vAC/a6ikAnTag==
X-Received: by 2002:a62:e716:: with SMTP id s22mr5880116pfh.35.1550865925893;
        Fri, 22 Feb 2019 12:05:25 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:25 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] thermal: qoriq: Don't store struct thermal_zone_device reference
Date:   Fri, 22 Feb 2019 12:04:59 -0800
Message-Id: <20190222200508.26325-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Struct thermal_zone_device reference stored as sensor's private data
isn't really used anywhere in the code. Drop it.

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
 drivers/thermal/qoriq_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 91f9f49d2776..6d40b9788266 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -65,7 +65,6 @@ struct qoriq_tmu_data;
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct thermal_zone_device	*tzd;
 	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
@@ -114,6 +113,8 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
+		struct thermal_zone_device *tzd;
+
 		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
@@ -121,13 +122,15 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		qdata->sensor[id]->id = id;
 		qdata->sensor[id]->qdata = qdata;
-		qdata->sensor[id]->tzd = devm_thermal_zone_of_sensor_register(
-				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
-		if (IS_ERR(qdata->sensor[id]->tzd)) {
-			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
+
+		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+							   qdata->sensor[id],
+							   &tmu_tz_ops);
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
 			else
-				return PTR_ERR(qdata->sensor[id]->tzd);
+				return PTR_ERR(tzd);
 		}
 
 		sites |= 0x1 << (15 - id);
-- 
2.20.1


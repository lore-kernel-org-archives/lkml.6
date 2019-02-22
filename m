Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A407BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0AC2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nytu5cWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBVUGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:06:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42655 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfBVUF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so1586845pgl.9;
        Fri, 22 Feb 2019 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWap+FuDLTMKjkkjOi856/2EP8no+rnORSM8vdjyhGk=;
        b=nytu5cWUYGTsm2lexTtlcz7tRK69/DUdBZQLx9a/8ytSV5UkFejUY3OWn9OVauNaZT
         nadLem7uMy3uzYL4px1T4mchKiKZ2H+KEkpvAdOLWDkgejNKtIxvGTz7pQAboJUPHper
         IkkIrkGu+FVaFseOnVaKxc3ybLfMxgiiEtWDRhx3ALoM6zKzb/p+jqDchv9ofZDtr7iD
         NK7rWij6oIwSrKhOtHSGP/Ff3bxswo96XW8lKgWqlIz88NInl8U1rWGXKKYQWajoD/L1
         eR2Rs8W4hzsm7p64fi8boPvpj9mGCrq7Cd/fr5qVqGtUvxM8TTYk3tvcPcS3MWymOQF5
         i1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWap+FuDLTMKjkkjOi856/2EP8no+rnORSM8vdjyhGk=;
        b=ND5EtAyepWNhiWXRiTyhIsfm3pz2z+9ZwWekvBCfvXT1qNtIlYC4GZ0jvtDbbOduOa
         H8vSzoB4FFHImeJJ7rJsu7aXVuA21QMK+iL62hpxi27phn81ko3Z8pE5w2Txav+fgP02
         2EsTNXaDrFTm35MIFZw2pIVbOzGVwoqmS4h9k7EK0wI9NOFdE7sSCwcLIjKnZetEIlS9
         YkfdrzDn1pZ5qOTArrNB82Cc2+eFsxbF1jk+913gIUEVh+jSGmsyq4VFW7CZfQ/CdDV3
         gqb8sixs7jAIwbWQkvFD+mywGROnr0sHGRU7PU5aL+Fkd/ezZA4GDE36hpijrYyYtkJ2
         ITvg==
X-Gm-Message-State: AHQUAuZkFRw2az61I8e3D4b/Sy1rbmPvY1CIo4oR1pOkdf3NsUG6+wlr
        eQVMwZmfoZotvkB21ypnEk9uDzr3
X-Google-Smtp-Source: AHgI3IbACW3QSG1YtiZ7CDnN1/W5V9ccVTj8CF/NkDzxaDIl4XgUTpUnGJR4MvM1qrBU1u4PZ3HrXg==
X-Received: by 2002:a62:4254:: with SMTP id p81mr5907115pfa.185.1550865927035;
        Fri, 22 Feb 2019 12:05:27 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:26 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] thermal: qoriq: Add local struct qoriq_sensor pointer
Date:   Fri, 22 Feb 2019 12:05:00 -0800
Message-Id: <20190222200508.26325-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add local struct qoriq_sensor pointer in qoriq_tmu_register_tmu_zone()
for brevity.

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
 drivers/thermal/qoriq_thermal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 6d40b9788266..e281bdcfa11f 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -114,18 +114,18 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
+		struct qoriq_sensor *s;
 
-		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
+		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
 				sizeof(struct qoriq_sensor), GFP_KERNEL);
 		if (!qdata->sensor[id])
 			return -ENOMEM;
 
-		qdata->sensor[id]->id = id;
-		qdata->sensor[id]->qdata = qdata;
+		s->id = id;
+		s->qdata = qdata;
 
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
-							   qdata->sensor[id],
-							   &tmu_tz_ops);
+							   s, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
 				continue;
-- 
2.20.1


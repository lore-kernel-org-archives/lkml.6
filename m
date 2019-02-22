Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710822070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZWNJvg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfBVUGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:06:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37903 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVUFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id n125so1582334pfn.5;
        Fri, 22 Feb 2019 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALuml21G4Ywv24KAK+ARP7cSE7V/ZSRKsgQgFppFhh4=;
        b=ZZWNJvg3hqsz05snIRPVgmaTz0NZgjNRccITxPHB1kJx9x7OFr7e1plWvM9zyzHorl
         o7QHiCQbcxgmZoYuPfg1ULbs4lfFQCDLRkS7TYmX+l6+QxVWtJsTfdAkK+Z3LHzOo/1W
         YEq92g105HyLBlvA5MsTQrJ+TT3rfkAmS4UaTv4r4/imQyYSWPpHtkOw5rZlumIxhUPV
         5A+SU2FwshSbm7VyM7Vj3r4cL3ZFBCAHbWqhQVqD0n9hzLgS/XZ7KI17abmT2+iOvqT9
         UJAC4YECOl3oHuh+F25nbbBPgKrluXkvNf2COsakAxZgqUFTG3tW5hXGbsg17U1YP2uj
         rRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALuml21G4Ywv24KAK+ARP7cSE7V/ZSRKsgQgFppFhh4=;
        b=mt5xSJ4QoHqfQNPd3J7gnbxhfe9b7K+7duJTECE6L5De8qwJHjcKwaAK6JJ8LVJOri
         XODfWLFFK07xGj/TKl6RQDOm9pREi9SBpMKpvQur88vViEEj+91sPsnJdAQsgSfjTZWm
         iGhFEn02Wb0x0YADZN6eH298b76XYgD+ERf6gnTf97YY/b8XKdJ8LgydRkcwf861gUuw
         tpOlpox0vw4Wj64IqEOEpcNqi0HBhlpv8kpoKZtm7DcBzU0N5UpgrEIq8IObKUemIMv9
         67dTSh0B/cOaMwQpPQLw5SWsosfqEr1rvQ8jdM5TpB1zBTaibyvHoeZNKP8CHMVC8P5S
         WxQQ==
X-Gm-Message-State: AHQUAuboqvAHIT0+46kKT9QRZl4MidU9QJ6Tdip4GiKVsVt8xnuJJNOA
        hWFZP+Q7ggDLYo54llcCvmHwlM1N
X-Google-Smtp-Source: AHgI3Ibs+kB9zPHap4S1m9JJu8qclZ3NET8P1DEm3UrU+NnOlgyGQXNb62AYqW+1HnyEO4/zBI4IzQ==
X-Received: by 2002:a62:1981:: with SMTP id 123mr5893014pfz.69.1550865929795;
        Fri, 22 Feb 2019 12:05:29 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:29 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/13] thermal: qoriq: Pass data to qoriq_tmu_register_tmu_zone() directly
Date:   Fri, 22 Feb 2019 12:05:02 -0800
Message-Id: <20190222200508.26325-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass all necessary data to qoriq_tmu_register_tmu_zone() directly
instead of passing a paltform device and then deriving it. This is
done as a first step to simplify resource deallocation code.

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
 drivers/thermal/qoriq_thermal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index deb5cb6a0baf..24a2a57f61c9 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -109,9 +109,9 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 	.get_temp = tmu_get_temp,
 };
 
-static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
+static int qoriq_tmu_register_tmu_zone(struct device *dev,
+				       struct qoriq_tmu_data *qdata)
 {
-	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
 	int id, sites = 0;
 
 	for (id = 0; id < SITES_MAX; id++) {
@@ -120,7 +120,7 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 		s->id = id;
 
-		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
+		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   s, &tmu_tz_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV)
@@ -215,7 +215,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_tmu;
 
-	ret = qoriq_tmu_register_tmu_zone(pdev);
+	ret = qoriq_tmu_register_tmu_zone(dev, data);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
-- 
2.20.1


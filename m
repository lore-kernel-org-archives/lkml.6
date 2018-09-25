Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A866C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE2D20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dI792yem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE2D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeIYPLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:11:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42368 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbeIYPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:11:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id b11-v6so6264093wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 02:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2c10kVYZmaRE2YAvTe8xN2YzBOeCiX1ots/Bs3skCvA=;
        b=dI792yemZWGQzfz6P+lbysSZCE+Qgm0Rv/p1vw0/yIWguhd24AI/9xNBXL9QAOe8qi
         WmZ2mtf3GKG2j1FO+o/ZogAfHEpMC4FUXdtEOO9K5a54yUzDUgIdJ5g6rJuz2bxVn08M
         y9PhFzkYxxDDrDOe9lyWawRU33so4h6KCxHzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2c10kVYZmaRE2YAvTe8xN2YzBOeCiX1ots/Bs3skCvA=;
        b=FOasH9CCmrG0+xPnbW+sg+5l+gPjotLMEKbSPLWehwuT0xsnw85zk0hP5pX7A9X3IY
         dx5KQBNS9gt/e2ZVSO58qx2NGLRTcIsNS1jlYRpRwL5ZbLy7LbcLgyX6afGNZibx6y6k
         0sj+6Y6zzS2xoTg/CuTFWPPDQ1/jxx4vRUBSobJ9RnF0P/zgMbdSIbK6/3Vdzd03efFT
         Nc+6EwqJBWyEmQ1uLhCmmKqVhIzovYSUQ+A6X1Onoi/Lt06cQsv2pCY52MO/DxVrCayr
         kSZBMTm5qUCsZoSR+rithpzuFp9SOeG0Madc0HFO9id/biYpzR7+rUYUggFVYjq4un72
         LNXA==
X-Gm-Message-State: ABuFfohaw3CFomzMG5efQ1bwMNf7gettow+zC9B5Bm1ujhgB5kWH5QG7
        TKbvwtyiCeaK5AI3k6x8KyjU/pDXLBA=
X-Google-Smtp-Source: ACcGV60+/ljwuO8yKwpnFa1rZygDRXkqLMIjt5uOCwQfhX0TEWu0l/iLM3Fv9x6PKzml8z6VIhaLMA==
X-Received: by 2002:a5d:5391:: with SMTP id d17-v6mr14805wrv.191.1537866300122;
        Tue, 25 Sep 2018 02:05:00 -0700 (PDT)
Received: from localhost.localdomain (251.150.136.77.rev.sfr.net. [77.136.150.251])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1523828wmg.14.2018.09.25.02.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Sep 2018 02:04:59 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, leo.yan@linaro.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 14/14] thermal/drivers/hisi: Add the dual clusters sensors for hi3660
Date:   Tue, 25 Sep 2018 11:03:12 +0200
Message-Id: <1537866192-12320-15-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is ready to support multiple sensors on the hi3660. The DT
defines a thermal zone per cluster.

Add the little cluster sensor and let it bind with the thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index ba89cb9..c4111a9 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -424,14 +424,20 @@ static int hi3660_thermal_probe(struct hisi_thermal_data *data)
 	struct platform_device *pdev = data->pdev;
 	struct device *dev = &pdev->dev;
 
-	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor), GFP_KERNEL);
+	data->nr_sensors = 2;
+
+	data->sensor = devm_kzalloc(dev, sizeof(*data->sensor) *
+				    data->nr_sensors, GFP_KERNEL);
 	if (!data->sensor)
 		return -ENOMEM;
 
 	data->sensor[0].id = HI3660_BIG_SENSOR;
 	data->sensor[0].irq_name = "tsensor_a73";
 	data->sensor[0].data = data;
-	data->nr_sensors = 1;
+
+	data->sensor[1].id = HI3660_LITTLE_SENSOR;
+	data->sensor[1].irq_name = "tsensor_a53";
+	data->sensor[1].data = data;
 
 	return 0;
 }
@@ -443,8 +449,8 @@ static int hisi_thermal_get_temp(void *__data, int *temp)
 
 	*temp = data->ops->get_temp(sensor);
 
-	dev_dbg(&data->pdev->dev, "id=%d, temp=%d, thres=%d\n",
-		sensor->id, *temp, sensor->thres_temp);
+	dev_dbg(&data->pdev->dev, "tzd=%p, id=%d, temp=%d, thres=%d\n",
+		sensor->tzd, sensor->id, *temp, sensor->thres_temp);
 
 	return 0;
 }
-- 
2.7.4


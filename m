Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084FC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283C520850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RqdCl40+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283C520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLCNcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:32:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41965 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeLCNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:32:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so13639303qto.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 05:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZD4wbyF9EkTu7UJQPBSAQZkCQxHDTNWUeyHRP/NGb0=;
        b=RqdCl40+FY0B7VOb00rNWAsUW79xJnjUbWFl9432NeXaHrFrMLS22igSW/VN5fO+dZ
         d5kyIhP1b9LYcCssPBO56MppAcop1HMxmy3zxlmNs8NDcB5V0FDFVJpP4pLv3R1EMUuG
         TDvef2QUf6mcJcNybq7ZsfEWGwKA+DZUWk2WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZD4wbyF9EkTu7UJQPBSAQZkCQxHDTNWUeyHRP/NGb0=;
        b=fkICBJUHD/En0V4IdQ80Q8+0CPmzK4HwUp8ZR0SGBOkqzAxQ1EWk7IBKbLqEyOKPJc
         WsNCjxcvlvnDkcHeNGBNSAyjrAPHnFYO9B9MoGTwdUd17zZ02DtIKXvy5JuVaB21mBy/
         5PjF3Zyj9SZ32vaMUYEGgvCxsnO/TgUB8MBsOTAQaci9sQVVC3+kXBSOHxzPxozExKDA
         h/KFZDnjp9IS/ZB88kpIE6GWxafmQNYmK6LON3skngOQ7B6aXMLSwHjr+CHOxhDyfhDt
         pfhUCA2IEPQOLo6G8T8J+mv1ra6vIea4JSzG3+29BOREPjHGSME1s6HSBXysx8HCkG1Z
         q2Lw==
X-Gm-Message-State: AA+aEWaL8876OOAAuwprYwIt7yeA7OFSctP8AL/mI4mBKdFdBeYg+U5v
        s9ckY5ulVVBfcsSWd3I+ro0luw==
X-Google-Smtp-Source: AFSGD/WA+2wO+V8/5inhe+vN47ZjrjQqoGPXOblhwtSdvGP8vbeID6j9S08KauKaDO8R7E77SMcPSA==
X-Received: by 2002:a0c:878d:: with SMTP id 13mr15631294qvj.8.1543843878814;
        Mon, 03 Dec 2018 05:31:18 -0800 (PST)
Received: from workstation.celeiro.br ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id r56sm8619112qtj.30.2018.12.03.05.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 05:31:18 -0800 (PST)
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     sashal@kernel.org
Cc:     rafael.tinoco@linaro.org, gregkh@linuxfoundation.org,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/5] thermal/drivers/hisi: Remove pointless lock
Date:   Mon,  3 Dec 2018 11:31:04 -0200
Message-Id: <20181203133107.4002-3-rafael.tinoco@linaro.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181203133107.4002-1-rafael.tinoco@linaro.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit 2d4fa7b4c6f8080ced2e8237c9f46fb1fc110d64 upstream.

The threaded interrupt inspect the sensors structure to look in the temp
threshold field, but this field is read-only in all the code, except in the
probe function before the threaded interrupt is set. In other words there
is not race window in the threaded interrupt when reading the field value.

Link: https://bugs.linaro.org/show_bug.cgi?id=4053 (PATCH 2/5)
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
(cherry picked from commit 2d4fa7b4c6f8080ced2e8237c9f46fb1fc110d64)
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index aecbfe9fc8f2..0c2966c285b1 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -221,14 +221,10 @@ static irqreturn_t hisi_thermal_alarm_irq(int irq, void *dev)
 static irqreturn_t hisi_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct hisi_thermal_data *data = dev;
-	struct hisi_thermal_sensor *sensor;
-
-	mutex_lock(&data->thermal_lock);
-	sensor = &data->sensors;
+	struct hisi_thermal_sensor *sensor = &data->sensors;
 
 	dev_crit(&data->pdev->dev, "THERMAL ALARM: T > %d\n",
 		 sensor->thres_temp);
-	mutex_unlock(&data->thermal_lock);
 
 	thermal_zone_device_update(data->sensors.tzd,
 				   THERMAL_EVENT_UNSPECIFIED);
-- 
2.20.0.rc1


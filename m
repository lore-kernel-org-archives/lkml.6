Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A9C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A732084C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb4c7RWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A732084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeH1Rbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:31:39 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35567 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbeH1Rbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:31:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id y20-v6so1409948edq.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6G1iNig0jk2gQ+OjSL4nzNGU4I6h5Na2kNfcgaBgtf0=;
        b=Eb4c7RWQ0HDnwb0imz+jUBeT9ObIiZTeMJ/D6aRlYTsxAZyAsK0Jo7s2HZjtXRZLXA
         hNI4zmcpMsp8YgL9M7Drnulj/ZuldFOZdMm3zH7/A8X/i6Jo0OTRTtD4cR52SePyZkAQ
         ULCfs5OpjNm3HJeg9JQfnP0ntsDl/l8vpBS5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6G1iNig0jk2gQ+OjSL4nzNGU4I6h5Na2kNfcgaBgtf0=;
        b=nuRn+XTRWrKuabVcPfBQMWNbF2eoSqFKdSaypTI36+T73p5+IcZlpnNQHXYU42htzE
         tfdVjligr3Hw9kHUd5nYkegZK3KANNI5BxZoxoCfTuiF8pO7NBq8CIwqMuSR7SsW2FXZ
         iocP2jt6YzJB+6cSyHzVaVeee9kcwBMvrA2mRev61t0hLR4XIT0dOzMstemxuLUNPlpA
         w15jSCG8/DUG+5Ez25NAEdtvEmq9GKpFlKp9g676FlfFjvVBepsFhxAYG8XzcZAdwAuI
         DAqAVwwOE3yp/Il2YF2dHldGXbXAJzDEARfJW/E2nu1rxPb9PvBYn93lRVkQZkTILclG
         IEYw==
X-Gm-Message-State: APzg51BBsqjSuvsu53GdFPP+EgztFRvR9pGsbiFXNBJmv6TJ3ovaUE+u
        ezYsKRW08TmV8SsfRZEBWHA6TyfMSNU=
X-Google-Smtp-Source: ANB0VdaDXMrumDArDMCtZ2kpJl3FTV4Q5ad5f0rmvuZGKEeVrvcUAStgKOLCt3FFUipCnUi+U8Nl9w==
X-Received: by 2002:a50:9943:: with SMTP id l3-v6mr2570012edb.198.1535463594773;
        Tue, 28 Aug 2018 06:39:54 -0700 (PDT)
Received: from localhost ([49.248.200.109])
        by smtp.gmail.com with ESMTPSA id b39-v6sm598635edb.82.2018.08.28.06.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 06:39:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, andy.gross@linaro.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 09/11] thermal: tsens: Get rid of 'id' field
Date:   Tue, 28 Aug 2018 19:08:38 +0530
Message-Id: <6c23d113e19a9ddf9dc9def18943eaf7f5ad4d79.1535462942.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1535462942.git.amit.kucheria@linaro.org>
References: <cover.1535462942.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hw_id field in 'struct tsens_sensor' can do the job of tracking
unique ids for each sensor connected to each tsens device instance. It
also allows hw_ids to be overridden (e.g. 8916) in cases where some
sensors in a sequence are disabled on a particular platform.

Use the hw_id field instead of the id field consistently across the
tsens code.

While we're at it, document the fields of struct tsens_sensor.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/thermal/qcom/tsens.c |  5 ++---
 drivers/thermal/qcom/tsens.h | 10 +++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 9a8e8f7b4ae1..fb728ec5d77f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -17,7 +17,7 @@ static int tsens_get_temp(void *data, int *temp)
 	const struct tsens_sensor *s = data;
 	struct tsens_device *tmdev = s->tmdev;
 
-	return tmdev->ops->get_temp(tmdev, s->id, temp);
+	return tmdev->ops->get_temp(tmdev, s->hw_id, temp);
 }
 
 static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
@@ -26,7 +26,7 @@ static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
 	struct tsens_device *tmdev = s->tmdev;
 
 	if (tmdev->ops->get_trend)
-		return  tmdev->ops->get_trend(tmdev, s->id, trend);
+		return  tmdev->ops->get_trend(tmdev, s->hw_id, trend);
 
 	return -ENOTSUPP;
 }
@@ -83,7 +83,6 @@ static int tsens_register(struct tsens_device *tmdev)
 
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
-		tmdev->sensor[i].id = i;
 		tzd = devm_thermal_zone_of_sensor_register(tmdev->dev, i,
 							   &tmdev->sensor[i],
 							   &tsens_of_ops);
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index b9c4bcf255fa..2a3174dfc1a9 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,11 +14,19 @@
 
 struct tsens_device;
 
+/**
+ * struct tsens_sensor - sensor-specific data
+ * @tmdev: tsens device instance this sensor is connected to
+ * @tzd: thermal zone corresponding to this sensor
+ * @offset: offset from calibration data to convert ADC data to degrees
+ * @hw_id: unique sensor ID for each sensor connected to tsens device instance
+ * @slope: slope from calibration data to convert ADC data to degrees
+ * @status: 8960-specific status register addresses
+ */
 struct tsens_sensor {
 	struct tsens_device		*tmdev;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	int				id;
 	int				hw_id;
 	int				slope;
 	u32				status;
-- 
2.17.1


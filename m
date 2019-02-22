Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D139C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0F12070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+RtnnP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfBVUFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33368 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfBVUFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id h11so1612190pgl.0;
        Fri, 22 Feb 2019 12:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9Jtz6lUZ8zvE49R0g+j0hAfOMHqUfJpKroDSjnezYI=;
        b=G+RtnnP2059nxXdAP1uzqYwGhaG1D4eT8ihA5zUWsAxCvZfOepCIJQcEpcOAQs6OBy
         PfqzwWTue07Lojz2w7KQD0ldnxxuxQRH+QS6+e84ifhpoTAeadxcFDn5Q+RTO8arFpj1
         f18TEYdRnbc2cfDf+NDk3r9a6MvfaXVGtQY5ifBxfIbPyAv+7SQ66QPzG6L6Po19k79k
         90BjzJtsZ1TwR7mjeSOKS9rv06FNMpr/DAHv14DTDPcgLYzygNwSw+WvVl7oS9IDE+y5
         r30/mSp6RDgMksGm1Z/161FlhxIdiHLRqQMvxu5Byf+7uQoacQH7bt/aKRFUEE1ZOC71
         eRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9Jtz6lUZ8zvE49R0g+j0hAfOMHqUfJpKroDSjnezYI=;
        b=IDOA7y5oziroecXTrRdf6oVBsU8ZO8E5fFctK9Ibjkn6NvuXWnSkVEuF2zPaunZDsO
         HBzK/ieb6PiTHPSQVWqiOe5u9wYljAZPGvW8FQa9lpXpAmOUWW6FFIftqiL4FdEfVdRx
         1A++aIJuN7itk1Yer/vTeNJnmXm1BmzMcI9VtArkJW2kxZbYRlJFcKaCM7i8pf0OR68H
         pmVSduvVyLCWU0ktwbUfHpPCy0p1y5gjkdoJwOP8Zi31nXkEMaPt+WYti8IKCO5C3D3B
         bwNkAeW4H0rFlUNUjKi0EMZHNwjCYGWAyMmRLO8YF7W6B6FZwF73TvNsacHkc2pg9TE2
         78Sw==
X-Gm-Message-State: AHQUAuastTHgB4BoTg4GqIY4WmofY06edg3K0WC+zeV9Ebd9P+fEYVwS
        piNMlLxH0DyhjJdsYCTE/h15j8NQ
X-Google-Smtp-Source: AHgI3IaEjJDnDq/8Rj+bm2dEUwKyfK5BMjDQbOXZl2pviF0iCj1WCqcsc2uCiNXe63G8OSo5B65kGA==
X-Received: by 2002:a63:4b12:: with SMTP id y18mr5648431pga.340.1550865934956;
        Fri, 22 Feb 2019 12:05:34 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:34 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] thermal: qoriq: Enable all sensors before registering them
Date:   Fri, 22 Feb 2019 12:05:06 -0800
Message-Id: <20190222200508.26325-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tmu_get_temp will get called as a part of sensor registration via
devm_thermal_zone_of_sensor_register(). To prevent it from retruning
bogus data we need to enable sensor monitoring before that. Looking at
the datasheet (i.MX8MQ RM) there doesn't seem to be any harm in
enabling them all, so, for the sake of simplicity, change the code to
do just that.

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
 drivers/thermal/qoriq_thermal.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index a909acee4354..7ff93dfcd68b 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -23,6 +23,7 @@
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
 #define TMR_ALPF	0x0c000000
+#define TMR_MSITE_ALL	GENMASK(15, 0)
 
 #define REGS_TMTMIR	0x008	/* Temperature measurement interval Register */
 #define TMTMIR_DEFAULT	0x0000000f
@@ -75,7 +76,10 @@ static const struct thermal_zone_of_device_ops tmu_tz_ops = {
 static int qoriq_tmu_register_tmu_zone(struct device *dev,
 				       struct qoriq_tmu_data *qdata)
 {
-	int id, sites = 0;
+	int id, ret;
+
+	regmap_write(qdata->regmap, REGS_TMR,
+		     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
@@ -85,21 +89,18 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 
 		tzd = devm_thermal_zone_of_sensor_register(dev, id,
 							   s, &tmu_tz_ops);
-		if (IS_ERR(tzd)) {
-			if (PTR_ERR(tzd) == -ENODEV)
-				continue;
-			else
-				return PTR_ERR(tzd);
+		ret = PTR_ERR_OR_ZERO(tzd);
+		switch (ret) {
+		case -ENODEV:
+			continue;
+		case 0:
+			break;
+		default:
+			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
+			return ret;
 		}
-
-		sites |= 0x1 << (15 - id);
 	}
 
-	/* Enable monitoring */
-	if (sites != 0)
-		regmap_write(qdata->regmap, REGS_TMR,
-			     sites | TMR_ME | TMR_ALPF);
-
 	return 0;
 }
 
-- 
2.20.1


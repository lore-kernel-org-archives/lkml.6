Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F75A21904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UW7wDvRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfBGM5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:57:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44427 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfBGM5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:57:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so4722153pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LGT7LQl8gaAE8g7SLNcOrp2SekffeeOyL7EISGdXlo4=;
        b=UW7wDvRVOihlVKEznr9sylhbDeWllZuHdLaOawFFbBC1vK3uFe+DvIm7n7BqhR710X
         A8qXbzhKm7yMjFgCSHDvTq38KcCg0TWVxo57NvSh7m7sjsFYRehMqKycMJEKOaRCg2+l
         VRGxQxH4JVG2V/8/rwy3WBXfUFDL2Oym350ol8uU2qXHBnXQqAT0WgBdSsfF97LUpcSJ
         UhJ2Qg0QQ6cdVHtUOKzSH5JFyO4NunFk2+/QaCXx6JFUynhBXIW6gqjfGpXIAv9AZWkE
         q1LybO+o/rst7YowjEpZa3E5pfTUW/5tdmTaWeya7DkHFldQyU0jxuFPqBSF1YVjs++9
         n1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LGT7LQl8gaAE8g7SLNcOrp2SekffeeOyL7EISGdXlo4=;
        b=ec99qrLQXjnfojqCwGl2sLDE7HnN9qM6aD87ezUwDuGxt7Wtsg6ie7vHt8aRtZolsE
         Fb4J+EWtI0SBpQbc1bBts1qiDbPHiOTmLQIL15+oNnQQXZ8DsAsksKrn4YveOXGmHX4U
         NT7/FJ7IqMSeX2NS09gUdo2MdxU8nzCRcAseX7qiTUONIugO0UjffY9S1jXsjoLZomQg
         Umrj0Y9L5emM/HC+I27WlN1w/syRBl1KPj5e2WtnYBVmQ0E4VlHllqI3cUaWQNQDiWrU
         R6UOwj63XElHZ4KG1I7JSsKn90R6X+YqBDa8muis3EJhCNw/Sii+RVy1rBI7MmKeWJJd
         ywRA==
X-Gm-Message-State: AHQUAuZpunbbHDkg4iy07t9k/JLrVAB6eRLlDC0Hq/6eV7nPO5T+5JGA
        Ut1WBH3t9wOuy4A4XT7goxvwygDyHpU=
X-Google-Smtp-Source: AHgI3IZvISlmMUv7DspDKGkXf1feo036TwXlnaWiK9ISg9Zs3+bx/pBHTqs4tagAOSn1rvjMECidFA==
X-Received: by 2002:a62:425b:: with SMTP id p88mr16177244pfa.137.1549544260931;
        Thu, 07 Feb 2019 04:57:40 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id b24sm2380667pfe.136.2019.02.07.04.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:57:40 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 24/24] drivers: thermal: tsens: Move calibration constants to header file
Date:   Thu,  7 Feb 2019 16:19:42 +0530
Message-Id: <99a7e1fca9db203b2784fcbe0f8cab6993e51a39.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow calibration routines to correctly include the constants
from anywhere and allow more code sharing.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 5 -----
 drivers/thermal/qcom/tsens.h        | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index a935d2335eea..35e82aaaef59 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,11 +12,6 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-#define CAL_DEGC_PT1		30
-#define CAL_DEGC_PT2		120
-#define SLOPE_FACTOR		1000
-#define SLOPE_DEFAULT		3200
-
 char *qfprom_read(struct device *dev, const char *cname)
 {
 	struct nvmem_cell *cell;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 4ed07e607cbc..8a747ab892f5 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -9,6 +9,11 @@
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
+#define CAL_DEGC_PT1		30
+#define CAL_DEGC_PT2		120
+#define SLOPE_FACTOR		1000
+#define SLOPE_DEFAULT		3200
+
 
 #include <linux/thermal.h>
 #include <linux/regmap.h>
-- 
2.17.1


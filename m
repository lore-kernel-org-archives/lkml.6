Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D315FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1D821902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woMmpAbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfBGKuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:50:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38175 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfBGKuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:50:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so10995477wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=H2crl7RmZMvIJT00kHO5k98tCahG1bLmtk7Nv322/6A=;
        b=woMmpAbvOB6OAKBWoHY/WgFkqOflUkOdg3Vm0er4QEBoZU7IqZm1lCqnEx7Y96OPaK
         iH+F7H4/gwJCqvko0pwphaML5ZFTF8p472cuMSj9KUx55y/S3obdknFha/JWtdBc5MYH
         HciZLy7gx0VqnRRZUQbdAeK5rtjlhoPfZPDg7STgYZZiEnEJBMH5l2dppVr/m/sAlN4u
         A+zenUaj6QahFzLwhUGMib6Pgv6tJjUHWALyQPp/ziCXbqZvFFGpdAVOpomACsPmrKbW
         sp1EgUSSdzffKRcAM5lXIwniD0ExKTkcbL8gPnYXQ+6SGzwV2K+/Y7uL9K6daKNmd+9K
         R4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=H2crl7RmZMvIJT00kHO5k98tCahG1bLmtk7Nv322/6A=;
        b=oTsAALHirGbZTLvqOOhLFB5VJWO1fI3E2rli0LDLpzv3y4pQ1BJ3SMKyE0w9FU7Swb
         K5MhiztpLwTJ6NeT7plw/eb7wgL4OiQigPfgQHxjHZyEuhPSVURAD1DZRhr4+kEgINjK
         K9oliLHM9+oikjn8UWPc30DYb6xYk8VKHGcdWTO8lHHkdOq4/llaAl1vjkXOWo8tF+By
         iqGEa2rvmA3pycJlEvmBW4KCAvjChiZg4CLGko4Hab0S3RbUY9XiDMuM0ENzkk8gRZ1N
         Zks+sWKa2lkr+d+Y7eatMMkAV8BH6rR6Su0/RQudU2lRM/jnnyBurxY8ccf1FggktFC6
         u//A==
X-Gm-Message-State: AHQUAubfxFiWAYEcpkESx23YRXRF+PiAeETZuRDEeE8dpcb9rYw0jUAX
        nUGMzNp071mrXo4Ln6or8jsIgbgAabk=
X-Google-Smtp-Source: AHgI3Iat+Abn4qc0mXn6/0b0ujcT/x+ZFVj0KtmB5KVeD65d3Rgs/xtM7xBVL/Xh/hbC3304qgflPg==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr12013788wru.272.1549536600901;
        Thu, 07 Feb 2019 02:50:00 -0800 (PST)
Received: from localhost ([49.248.196.115])
        by smtp.gmail.com with ESMTPSA id a62sm24387481wmf.47.2019.02.07.02.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:50:00 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 01/24] drivers: thermal: tsens: Document the data structures
Date:   Thu,  7 Feb 2019 16:19:19 +0530
Message-Id: <ab0571b9d3059342361522b8ae0df69990385547.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe how the TSENS device and the various sensors connected to it
are described in the driver

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b7feee5dc46..89318523c848 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,6 +14,16 @@
 
 struct tsens_device;
 
+/**
+ * struct tsens_sensor - data for each sensor connected to the tsens device
+ * @tmdev: tsens device instance that this sensor is connected to
+ * @tzd: pointer to the thermal zone that this sensor is in
+ * @offset: offset of temperature adjustment curve
+ * @id: Sensor ID
+ * @hw_id: HW ID can be used in case of platform-specific IDs
+ * @slope: slope of temperature adjustment curve
+ * @status: 8960-specific variable to track 8960 and 8660 status register offset
+ */
 struct tsens_sensor {
 	struct tsens_device		*tmdev;
 	struct thermal_zone_device	*tzd;
@@ -55,8 +65,8 @@ enum reg_list {
 };
 
 /**
- * struct tsens_data - tsens instance specific data
- * @num_sensors: Max number of sensors supported by platform
+ * struct tsens_data - tsens platform data
+ * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
  * @reg_offsets: Register offsets for commonly used registers
@@ -68,12 +78,27 @@ struct tsens_data {
 	unsigned int		*hw_ids;
 };
 
-/* Registers to be saved/restored across a context loss */
+/**
+ * struct tsens_context - Registers to be saved/restored across a context loss
+ */
 struct tsens_context {
 	int	threshold;
 	int	control;
 };
 
+/**
+ * struct tsens_device - private data for each instance of the tsens IP
+ * @dev: pointer to struct device
+ * @num_sensors: number of sensors enabled on this device
+ * @tm_map: pointer to TM register address space
+ * @srot_map: pointer to SROT register address space
+ * @tm_offset: deal with old device trees that don't address TM and SROT
+ *             address space separately
+ * @reg_offsets: array of offsets to important regs for this version of IP
+ * @ctx: registers to be saved and restored during suspend/resume
+ * @ops: pointer to list of callbacks supported by this device
+ * @sensor: list of sensors attached to this device
+ */
 struct tsens_device {
 	struct device			*dev;
 	u32				num_sensors;
-- 
2.17.1


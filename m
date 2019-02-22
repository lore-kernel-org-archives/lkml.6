Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6242C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CD82075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpwPN0Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfBVUFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33351 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfBVUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id i19so1596815pfd.0;
        Fri, 22 Feb 2019 12:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0pYFSAaqv8YmpHjz4zN9DJVKi8lncigdWYz/AZsmcg=;
        b=mpwPN0Kc0p/MZAhZYMe9m23U3xvgjYkZjKo1Mwg3j709MqhdMfd2Ao8GGOAZm/pXS7
         elil07Z7EWVrWucjRrLrWz44vXc42iDgpOjR2vpzrzJWPGJsOD56DTSwF+XA7hKwFHdn
         7yNpAjYJSQN5AiXfwZsWDb3myhvH5d7SYLMG06W90rFC9RJuBltvEEZ3M6gUZqcDVWvd
         zQ7pTehqBvRw202ZiaFG3O7+NWjhw7or+mEahFOhw5Ked/hsXFW1OiQ5kAPQEDmjEWpm
         zkstyWhtMscLNELFe2cRxtINwuSuNJTpcqiEGNEGHhuIsVoZJMP2Sd7rLaQRyMYarg8e
         +Vgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0pYFSAaqv8YmpHjz4zN9DJVKi8lncigdWYz/AZsmcg=;
        b=W24nptMikaoMPBZTl31sjyb943q1Lcso2bnR6T3sX8C71q0pvagcziQjCchyAJhvbb
         QHtRrZZJ4XNwV+Mau5KkxL73fbeS5aevkiwTjhLcg7ECF0AZyByQai/jGg6VNa+6sU2e
         tWrbAHt/4LrKMisHhgrv3zrSvkxBRvWcHs+ZvzMdM8ImJ1m1v4u+oY5256YEuQqtl1dz
         wtdzc81E6QYlu9RHEB0n+QiImKT9crIRX+WWxs1iAJUiG8uXfjNDYV2d1JIBfzLHD2dP
         WKRLdBW613D0vqO7D9gxK/3cJKCnEdmqxJHmS0UckglGoJpf6UtfazN2XGT/v3lxvgqk
         239w==
X-Gm-Message-State: AHQUAuZjUi8/CDmfV10+IjA/AigwhkQEV2p8xjwbnPFxd3STDHfjesyW
        4CiLvi8lMQAwnKuTbPH8x4NAaNaD
X-Google-Smtp-Source: AHgI3Ia/EeEatRvu7IOJZZIAXFB6rbgBiKgNR0Z7Psmo1aU+ddXHCE9C3E7svVXNldJmSKXFGINZ4w==
X-Received: by 2002:a63:1a5d:: with SMTP id a29mr5189910pgm.369.1550865937733;
        Fri, 22 Feb 2019 12:05:37 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:36 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] thermal: qoriq: Add hwmon support
Date:   Fri, 22 Feb 2019 12:05:08 -0800
Message-Id: <20190222200508.26325-14-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose thermal readings as a HWMON device, so that it could be
accessed using lm-sensors.

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
 drivers/thermal/qoriq_thermal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 9d227654f879..7fb9321a0d8c 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX	16
 
@@ -103,7 +104,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 		case -ENODEV:
 			continue;
 		case 0:
-			break;
+			ret = devm_thermal_add_hwmon_sysfs(tzd);
+			if (!ret)
+				break;
+			/* fallthrough */
 		default:
 			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
 			return ret;
-- 
2.20.1


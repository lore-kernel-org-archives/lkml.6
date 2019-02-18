Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE3D21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqR1Syao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfBRTMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39629 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfBRTMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so9180041pld.6;
        Mon, 18 Feb 2019 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qkK84rhf9eI19WkazDOBz4QwYf9dy5ZGSMeUUd/NAc=;
        b=qqR1SyaoY/706E968CMaFBLiwWsKZDtSII1o/E3olng330+PU+3bMw0SGhQbrS8IfB
         YPWP6UdXAFokcATLbVnFqrqYbddAwv522Xp+58yO3nbcn5usyOrosvVylnWKcX0Dh3r4
         i3EjD8tuYJ5xt5E8oBYpWbw09oGeQNTNr4KuYacfAyVJddJ/A9hHIbY/wAQkBgGQhihA
         EXSBR9Rx0zQs1tLMRuq2KElr1FDNXVoPNLg7v2PxeA4F2tMQu/Jjh/fiFoLdf0by5W9T
         li6clDlfH6kWfr5qJ60m4gq7vBZZMGrgI4lQTyIDPh802UntMBIw7XL//54qjj2TgrJF
         3Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qkK84rhf9eI19WkazDOBz4QwYf9dy5ZGSMeUUd/NAc=;
        b=YhK38/rUoNzesYRTmeMrHUfMmsDv/v9cEPYeVVBbuFn9p6wTt+KZgATPoRCOjc9DQN
         xwactQhkI1ssEiTKsT0rRB56DQ/RAWw2hkCa5lA+iB83nNtCQK1xcadGLJ8LzrAudtNl
         XHckFoV2dp9z5AgD5VhUS1yCk81DtdxijqHaaoy7kG5U5kraPC1rHKibGUbyV5nLQYfC
         eaGNZv10tsiCy9qzKKw+ICTx+oCHTMI6OgnNCvHN9hjAb8TghdK+7IRefnxTNSBeCsIn
         6RGgYh3S3lv5Zu7GCq+GHbSQVBStWWGvnXxkYwAIHbnp+XHa828+6/b9ayVBASvhoaaN
         8izA==
X-Gm-Message-State: AHQUAuaVnrce5lWpYq/zG8xoDLgJ3/osug7g4+TyC/aCQjkDD/SZOu3D
        sKd3IFEL6Kve5nvVRxO72kprB0JO
X-Google-Smtp-Source: AHgI3IbbcDs5WoQoS60beRy4gEXb/578MwZ4CWf+CM6YaYUUFuIKSYAy4/jGkpzvSViN50wq+v25DQ==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr26001683plp.19.1550517127711;
        Mon, 18 Feb 2019 11:12:07 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:07 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] thermal: qoriq: Add hwmon support
Date:   Mon, 18 Feb 2019 11:11:35 -0800
Message-Id: <20190218191141.3729-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
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
 drivers/thermal/qoriq_thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 472594fca03b..90af4c4caa52 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -11,6 +11,7 @@
 #include <linux/thermal.h>
 
 #include "thermal_core.h"
+#include "thermal_hwmon.h"
 
 #define SITES_MAX	16
 
@@ -232,6 +233,10 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_thermal_add_hwmon_sysfs(data->tz);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, data);
 
 	/* Enable monitoring */
-- 
2.20.1


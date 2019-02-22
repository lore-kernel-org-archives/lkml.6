Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E739CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EE02070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3vJ8k+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfBVUF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34700 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfBVUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so1576772plr.1;
        Fri, 22 Feb 2019 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqQYEbw7qbcQ28zx/GP+6Ye+6dDiNruhORDqLkZOxE8=;
        b=R3vJ8k+C9OVEboCHMWNc4Q7K/T7zZRXlbOe2u/h+7v+sF6lBRjM3U+f6OmVdr0Avtv
         Tuv1+/ycxtXk5KEy74if8AeVY02hB9FGWnd7fbocLcsXYykh/634rdfg2doXb9Ll+V0A
         sId4JuWclDHaxzQItj82Zvmv8nqRskvwyDT+waQj0Q4ft4nyR7kuU42WdbnwFLhPu3kt
         jhyc3soXeYu5E6mHcFp+lbpPLcjv65AhPBU41scG6PIUL/a+RJSsigKXpT3SMTScxxJK
         ml8ctffygWGei30whbAtLS6lgB2gL6bgsEYXezO6trz9yHlm1qphDIG77V0EcmtErQxy
         NH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqQYEbw7qbcQ28zx/GP+6Ye+6dDiNruhORDqLkZOxE8=;
        b=NcnxafDUBAQFM9Fnm6E9oo+fccG0hjrFi/1h89XruMmtw0Equ/wemPz63b8mEdKDPn
         LQKYgRukoYMQkd84/l2/AS6ucKpIXZF0Tf4+M5FcuV9i+eNQ67JrXf4aEbn+z9B6q/Xq
         1y28eHOgn0E9jynFialo6SG1ee/r+trbor1AaSp3RycpxY9A2avkL71/CwP2S0PVdQ9A
         FoPlYYLnShdapw9jVDDWoZKoicd2vY039EgXRUl0FbBkmVUPPwHTYc5Y02/VjIwp5bsf
         2oWGQ9QZgjSU9e+hI6fjeS+4mNzfAv/ogPJGpa6b0BMYj5jStld1B6odDaEh7R04iJK7
         cLqg==
X-Gm-Message-State: AHQUAuYKG89986wCujkjrSgESjmRnl9o3Ea3fUibHPB+kuurgGe+pwxU
        ibWy3n1LjdpjBXSXvzmDwlNYAwdo
X-Google-Smtp-Source: AHgI3IbFBbJXwmtzqZ9nZo7TyoqGYKujDjaxmey9BbzXC9pLOK1NLvlpWrdoonnVNXQyOnD5nLz8nA==
X-Received: by 2002:a17:902:b615:: with SMTP id b21mr5943165pls.338.1550865924694;
        Fri, 22 Feb 2019 12:05:24 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:23 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] thermal: qoriq: Add local struct device pointer
Date:   Fri, 22 Feb 2019 12:04:58 -0800
Message-Id: <20190222200508.26325-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct device *dev" for brevity. No functional change
intended.

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
 drivers/thermal/qoriq_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7b364933bfb1..91f9f49d2776 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -192,8 +192,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -204,7 +205,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
@@ -217,7 +218,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_register_tmu_zone(pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register sensors\n");
+		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
-- 
2.20.1


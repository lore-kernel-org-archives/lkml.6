Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56397C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2316F2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tK9hd+ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfBVUGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:06:10 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33359 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfBVUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so1612067pgl.0;
        Fri, 22 Feb 2019 12:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8IpqrOjtcHvSHZzGSsy3LrpVR3xBgwuw+n4I/t+wAj8=;
        b=tK9hd+yam+zxDMwJOulwwlm/sH5qBgOKWE2uxObg8BBMfHWJIFM68fK3kCWdvtFc+l
         bJrEjhqleW909qYiq0g+JbisXJ8+efN31sPhSAjtSIsxCQ8vaMYhuf0+9T8uF2Dq8rdh
         zoqLqZIZqFbesmDDjhEH4CYaw/HYaOm/WxIF+C3mpyLk8OuwKPpcjteQvwOQ7HBmECao
         uJAvI4pFjQPeWoox0hhTtzdnWZ9wdxvY+Dr19q3TAdavR1YO7zgn+kzU4M/hjc7CtQB5
         RnJwhWnZC6eKJlMZRRMtoZ1CstfE6oBnO/XMnb6fJk3eAmQetkoM7aF1aSsdl/3aRsri
         2+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8IpqrOjtcHvSHZzGSsy3LrpVR3xBgwuw+n4I/t+wAj8=;
        b=ofURtS1oPHiKjnjymem73210LWCI9QUrt5wYmAS4OipAchU005LLYEHdEHRW09Sbk/
         D/ztEeq39ROY1KQRiAv101uTDiSMYIvLh+Xt9H84eUkvT0AA2KK00RIfnL93R8axGmrr
         SZ/Av4a4UVLbto4e92+2YcJNMWvxlHdPHuMcq2MabRLD/gGe1f/hqJk9aCtrZVEOP4b5
         Ooy2b9gZRqdASTkc1748OiLrmMuIrhV9dA6/Ps1C5yyUPcoBHLICzQNRAatiEoFPOQ/Z
         IV1+Ms5hd2aaCfi/cfW5MrR8L2bBNgwxQNf5XS+kegRuT+bw/Bu8Yhjr6OIWr9Ut1U+C
         faXg==
X-Gm-Message-State: AHQUAubLLD3xeWwFohJ6aot/V+jQMk390CKY6bQWPE4BUkgfZfMcGPvh
        f0O4/COZCTnKKTxES6opKqsZUOW9
X-Google-Smtp-Source: AHgI3IY+yogH+r8S+nP917T5Bfx7tVf/DHo7Yz/3ha9F80VsfBnSDfiHV98TNBcGXcMu07EdnCXDnQ==
X-Received: by 2002:a62:6ec3:: with SMTP id j186mr6143508pfc.89.1550865928260;
        Fri, 22 Feb 2019 12:05:28 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:27 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] thermal: qoriq: Embed per-sensor data into struct qoriq_tmu_data
Date:   Fri, 22 Feb 2019 12:05:01 -0800
Message-Id: <20190222200508.26325-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Embed per-sensor data into struct qoriq_tmu_data so we can drop the
code allocating it. This also allows us to get rid of per-sensor back
reference to struct qoriq_tmu_data since now its address can be
caluclated using container_of().

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
 drivers/thermal/qoriq_thermal.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index e281bdcfa11f..deb5cb6a0baf 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -59,22 +59,24 @@ struct qoriq_tmu_regs {
 	u32 ttr3cr;		/* Temperature Range 3 Control Register */
 };
 
-struct qoriq_tmu_data;
-
 /*
  * Thermal zone data
  */
 struct qoriq_sensor {
-	struct qoriq_tmu_data		*qdata;
 	int				id;
 };
 
 struct qoriq_tmu_data {
 	struct qoriq_tmu_regs __iomem *regs;
 	bool little_endian;
-	struct qoriq_sensor	*sensor[SITES_MAX];
+	struct qoriq_sensor	sensor[SITES_MAX];
 };
 
+static struct qoriq_tmu_data *qoriq_sensor_to_data(struct qoriq_sensor *s)
+{
+	return container_of(s, struct qoriq_tmu_data, sensor[s->id]);
+}
+
 static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem *addr)
 {
 	if (p->little_endian)
@@ -94,7 +96,7 @@ static u32 tmu_read(struct qoriq_tmu_data *p, void __iomem *addr)
 static int tmu_get_temp(void *p, int *temp)
 {
 	struct qoriq_sensor *qsensor = p;
-	struct qoriq_tmu_data *qdata = qsensor->qdata;
+	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
 
 	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
@@ -114,15 +116,9 @@ static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
 
 	for (id = 0; id < SITES_MAX; id++) {
 		struct thermal_zone_device *tzd;
-		struct qoriq_sensor *s;
-
-		s = qdata->sensor[id] = devm_kzalloc(&pdev->dev,
-				sizeof(struct qoriq_sensor), GFP_KERNEL);
-		if (!qdata->sensor[id])
-			return -ENOMEM;
+		struct qoriq_sensor *s = &qdata->sensor[id];
 
 		s->id = id;
-		s->qdata = qdata;
 
 		tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, id,
 							   s, &tmu_tz_ops);
-- 
2.20.1


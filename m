Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C692C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38B92070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpISwQAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfBVUFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43420 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfBVUFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id m10so1547261plt.10;
        Fri, 22 Feb 2019 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qSERywaINMPqAGwa9/fatFleAtT30FJ6wQLulWvU9+A=;
        b=ZpISwQARa+YVCNctjLgHN31bGJb7tGIvTz6FzVb4PdQRBrIQsaJE66ohYyjqwQrf9K
         9U+/YLdDgeJHmDSkeGT1QJGsN15mmN5RdbT/JeQa7E3Ei7Nun3rV1RSDzBIPwXbUdq0E
         uQ/sD50s/76PgK3k/ZexnokUyjIR1CqBcww3DfEUr3TXSM5oKGJhFVJvVxNXV4AwuHsd
         orHOGpmfuTOq5cBiyj8rFd2iYmakyZ1HkBcH1/Owgd2z7Juf+7CbVbjgkb6DBJzZ5D+l
         5sKl7KbEtqFuPikBO+erJt9+lIHr+27lz4D7WSUk5MjjFm1LVHInp/LXubeby3xkq6h9
         GL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSERywaINMPqAGwa9/fatFleAtT30FJ6wQLulWvU9+A=;
        b=L8Et5ZK7XEsV3pTBkPLxN2XSmV6g5/QjZTuoFxVQ3GC0EEyNxxO6ytCj1FyK/+cjZb
         EFAYbsJiCtDGfdPo1hh+WLqZo2G8R/mwaqMFCxt2oUxB5aTn4ZmH2xS1bTZNxfOvl8CG
         f9x6Tb+a7fbqcbo8mrOYs3S2LpsVzUXXictnhwdIEeG8Nohng0qvMbvn+oAPiPCECpz6
         cZt+mtQDCC5O5/cdzmyTKzWf7riqyKr9qjgXHtjfiRCwi9I9QELK3pj6/4Z3L17bbFkv
         BsVm8F8Kix1c8YRtCUQuxzeHPtLjj2Pn1zBXukPCQiJnzZvFFOKi+tU7mnxJ0oAW866W
         ieRQ==
X-Gm-Message-State: AHQUAuYbIeHoyKENp4wHvlwJ8506Dm4F7QWeAttX5gVDLnEQaiwmt8/+
        ecT+bwDsDjMTOkIS6+RUoj5VskIG
X-Google-Smtp-Source: AHgI3IaoZ+7RqEY9SQKZ2JeJHa49PuhtRutbCVESOfl2Hk2RHe7zgXjOCUwBrX222ivKaZD6z2Uorg==
X-Received: by 2002:a17:902:684:: with SMTP id 4mr5869459plh.3.1550865936419;
        Fri, 22 Feb 2019 12:05:36 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:35 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] thermal: qoriq: Do not report invalid temperature reading
Date:   Fri, 22 Feb 2019 12:05:07 -0800
Message-Id: <20190222200508.26325-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before returning measured temperature data to upper layer we need to
make sure that the reading was marked as "valid" to avoid reporting
bogus data.

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
 drivers/thermal/qoriq_thermal.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7ff93dfcd68b..9d227654f879 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -37,6 +37,7 @@
 #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
 					    * Site Register
 					    */
+#define TRITSR_V	BIT(31)
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -62,10 +63,18 @@ static int tmu_get_temp(void *p, int *temp)
 	struct qoriq_sensor *qsensor = p;
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
 	u32 val;
+	int ret;
 
-	regmap_read(qdata->regmap, REGS_TRITSR(qsensor->id), &val);
-	*temp = (val & 0xff) * 1000;
+	ret = regmap_read_poll_timeout(qdata->regmap,
+				       REGS_TRITSR(qsensor->id),
+				       val,
+				       val & TRITSR_V,
+				       USEC_PER_MSEC,
+				       10 * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
+	*temp = (val & 0xff) * 1000;
 	return 0;
 }
 
-- 
2.20.1


Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49193C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200F261BD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QKNkNME6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200F261BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030316AbeF3KdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:33:05 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35482 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936856AbeF3Kc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:32:57 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5UAWtha083319;
        Sat, 30 Jun 2018 05:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530354775;
        bh=gzDI0sw0rI2UKbapVWGlswjFDi0wjfbG86Oq4Z8JJlw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QKNkNME67bs1yBiH2AnpyPF2zm+qf+r6vf6Ru1Bq1ZmckxWmurfVGrSyx1h9wdu2L
         f9vpxvNdDHT6hxW9FAx1Q2pJLT7/TMkl+67XtbincHpTazxSQXgvsfwHW/qkcAdjOU
         yKBeL8zY+8Ut2Ka+TOSgnJYSPaW9CLxucf92exis=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWtoO026173;
        Sat, 30 Jun 2018 05:32:55 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 30
 Jun 2018 05:32:55 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 30 Jun 2018 05:32:55 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWd6X013640;
        Sat, 30 Jun 2018 05:32:53 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: [PATCH 5/5] Input: ti_am335x_tsc: Mark IRQ as wakeup capable
Date:   Sat, 30 Jun 2018 16:03:18 +0530
Message-ID: <20180630103318.25355-6-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
References: <20180630103318.25355-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AM335x, ti_am335x_tsc can wake up the system from suspend, mark the
IRQ as wakeup capable, so that device irq is not disabled during system
suspend.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index a4f25a915ffc..9e8684ab48f4 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/sort.h>
+#include <linux/pm_wakeirq.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 
@@ -439,6 +440,9 @@ static int titsc_probe(struct platform_device *pdev)
 	}
 
 	device_init_wakeup(&pdev->dev, true);
+	err = dev_pm_set_wake_irq(&pdev->dev, ts_dev->irq);
+	if (err)
+		dev_err(&pdev->dev, "irq wake enable failed.\n");
 
 	titsc_writel(ts_dev, REG_IRQSTATUS, TSC_IRQENB_MASK);
 	titsc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO0THRES);
@@ -471,6 +475,7 @@ static int titsc_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_irq:
+	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 err_free_mem:
@@ -484,6 +489,7 @@ static int titsc_remove(struct platform_device *pdev)
 	struct titsc *ts_dev = platform_get_drvdata(pdev);
 	u32 steps;
 
+	dev_pm_clear_wake_irq(&pdev->dev);
 	device_init_wakeup(&pdev->dev, false);
 	free_irq(ts_dev->irq, ts_dev);
 
-- 
2.18.0


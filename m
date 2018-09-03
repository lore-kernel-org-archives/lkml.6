Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F911C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42812086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="FNGFIMLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42812086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeICRbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33813 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeICRbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id g33-v6so651401wrd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vUJIU/oycKpUavEMI7cnrlQPvFWatIHlTatXEyH0+aA=;
        b=FNGFIMLGXYRRLPxW41klBDDgvWIpWQ8Wp7GL5yc6hCPIO1zZTwuWpjgLocWGqc6gBI
         i1H6T9fOwbe5zTOnBun/oCE+QHZnrsipyGZFEps42vzV9HPPAXfzGD7OaSXNbHnjjkRY
         oj/vHRpTBZfEH0ACGk8+0J1FQePnXRt7vduRdKgWssLQet6ZxbSWk/X89AwE7vksrj3K
         zxpfUUlbMvsIAPdzUgn4TcQI661kBQqOlft5xWZqR/gDASBtSK8HEfJJuPo0MOfSK73y
         daZhBZznpq3WBIMhRWXdKqJ4r4BUPizruj3CfzDxmLIVIZAy90Jey0RUuW1KPA2U7T0w
         gYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=vUJIU/oycKpUavEMI7cnrlQPvFWatIHlTatXEyH0+aA=;
        b=Gf5Eeg8nRIpFxocDlT+qaCD6jk46FDs422ahrfCpzZiypGLWhN6V1Bx2CcuzUYNl5T
         mr9F8xd6I6LE62K67AMZTKDgrY2yPZOLeIWtHcJw+OGJvYnE2g/hXW+hlAn12nkYQCRV
         k2mxEcvU8m2j6lMEbq5CfYT2apgbFj77Xw2lMn4PpRLRyZ3qpMlh1m0x4Jl5wvkhU90I
         nHVKsg2yd67QWPjDuogtKWntA+7cN8J3faDS+cq/A/kuAFBU34z27suK/F4GnQsh77hs
         V5VkqGx8icAtexfQkUfLxVSjVhvmAn34flkza55zqGirOYrKd1kA3D9nBn3O1QY3fARm
         8Bjg==
X-Gm-Message-State: APzg51BydH3nYFFnsdTREylqw7A8UGvSLuFTgvEbCkoX16SQC222GLJx
        VjbCBuoXtigTKHrGONdk8BKBhHCHs4Z2Ew==
X-Google-Smtp-Source: ANB0VdaM9wEPe/dEsMlVEhEfZfmqV+9pmkc3Cr6k5PHmhjoubjzW5lPIFZF70EbOXl3pwfYvB9HGeA==
X-Received: by 2002:a5d:4648:: with SMTP id j8-v6mr18447306wrs.52.1535980269278;
        Mon, 03 Sep 2018 06:11:09 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v16-v6sm14975923wrw.12.2018.09.03.06.11.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:08 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 06/10] serial: uartps: Move register to probe based on run time detection
Date:   Mon,  3 Sep 2018 15:10:54 +0200
Message-Id: <0ffd804b18c15b60a64aecadcf32b0036e6cbcdb.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register uart driver in probe to be able to register one device with
unique major/minor separately. Also calculate number of instances of
this driver to be able to call uart_unregister_driver() when there is no
instance.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- Fix uart_unregister_driver() in error path or when driver is removed.
- Change commit message

Changes in v2:
- Remove nr field logic

Discussed here: https://patchwork.kernel.org/patch/9738445/

The same solution is done in pl011 driver.

---
 drivers/tty/serial/xilinx_uartps.c | 42 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a3e97ccb376d..54735a7f9960 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1393,6 +1393,9 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
+/* Temporary variable for storing number of instances */
+static int instances;
+
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1425,6 +1428,14 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (!cdns_uart_uart_driver.state) {
+		rc = uart_register_driver(&cdns_uart_uart_driver);
+		if (rc < 0) {
+			dev_err(&pdev->dev, "Failed to register driver\n");
+			return rc;
+		}
+	}
+
 	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
@@ -1442,7 +1453,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 	if (IS_ERR(cdns_uart_data->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
-		return PTR_ERR(cdns_uart_data->pclk);
+		rc = PTR_ERR(cdns_uart_data->pclk);
+		goto err_out_unregister_driver;
 	}
 
 	cdns_uart_data->uartclk = devm_clk_get(&pdev->dev, "uart_clk");
@@ -1453,13 +1465,14 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 	if (IS_ERR(cdns_uart_data->uartclk)) {
 		dev_err(&pdev->dev, "uart_clk clock not found.\n");
-		return PTR_ERR(cdns_uart_data->uartclk);
+		rc = PTR_ERR(cdns_uart_data->uartclk);
+		goto err_out_unregister_driver;
 	}
 
 	rc = clk_prepare_enable(cdns_uart_data->pclk);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to enable pclk clock.\n");
-		return rc;
+		goto err_out_unregister_driver;
 	}
 	rc = clk_prepare_enable(cdns_uart_data->uartclk);
 	if (rc) {
@@ -1538,6 +1551,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	instances++;
 	return 0;
 
 err_out_pm_disable:
@@ -1552,7 +1566,9 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 err_out_clk_dis_pclk:
 	clk_disable_unprepare(cdns_uart_data->pclk);
-
+err_out_unregister_driver:
+	if (!instances)
+		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
@@ -1580,6 +1596,8 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!--instances)
+		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
 
@@ -1595,28 +1613,14 @@ static int cdns_uart_remove(struct platform_device *pdev)
 
 static int __init cdns_uart_init(void)
 {
-	int retval = 0;
-
-	/* Register the cdns_uart driver with the serial core */
-	retval = uart_register_driver(&cdns_uart_uart_driver);
-	if (retval)
-		return retval;
-
 	/* Register the platform driver */
-	retval = platform_driver_register(&cdns_uart_platform_driver);
-	if (retval)
-		uart_unregister_driver(&cdns_uart_uart_driver);
-
-	return retval;
+	return platform_driver_register(&cdns_uart_platform_driver);
 }
 
 static void __exit cdns_uart_exit(void)
 {
 	/* Unregister the platform driver */
 	platform_driver_unregister(&cdns_uart_platform_driver);
-
-	/* Unregister the cdns_uart driver */
-	uart_unregister_driver(&cdns_uart_uart_driver);
 }
 
 arch_initcall(cdns_uart_init);
-- 
1.9.1


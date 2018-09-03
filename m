Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1537C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3720868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="Xs8AVDnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB3720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeICRbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43127 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeICRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so591965wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=28aWEqk5ccUrLG2mIr/fR9GT68w8zaKxoQ9DZA4uMA8=;
        b=Xs8AVDnn2wmLxjJn/4jfdLQJNXTmnddB0Zqzcy9jcNvnJTTY+xPtDFNWkAN85+ScGm
         mygipDP2bHfDY9pF/vQPiA1gZny2U2E5Mbx9FTSG2v+gIgqDidOOVGraIoK92v71b4hO
         U4ZOv9wQbGY4hPsbD1/e15wAd183Tyhj4zvc1O5kg72x4qUAWmBe4uJfrJCTQLor9tCT
         89NFkQRq1nUo2wv3x2Nd7Jr8A+4hrehXhtQMog5sOZO/4PlkArF2jVhZ1Y6xt6vTj8BD
         AKHfP+XxF585ijhqt31S7M5uNJVIrSlXV3gJlHuyZ9G+2/DY4PczWa7YCq+WGigdFfn0
         tkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=28aWEqk5ccUrLG2mIr/fR9GT68w8zaKxoQ9DZA4uMA8=;
        b=IUj3V/ofdXOQUsAeNMe2sslRh2RnV3kqz3+K1YwBIrc/+09F8qbUUC/29MN9s7xErU
         Pa7ubvc7WeyPDEqYDhGWQ2LOpmp2jZIfqHnQdEIo9wcxv61SoINOnE7020wboWT1X1Wq
         FrgWYM9jMDeAsdwjNvoqncjgLpIoSiWy9R6/GLCZemmNU5ngT7OUra2LpkKyvloK8ovU
         UetFagUq4zTB3Y6oAhdKuUMQeDFpCo+FDz+Tg87mXh+NOeXkioAyP79Z5M0OnepPmb/+
         HoqunnkkhaYgK962c62DMnmI580621a8oooSPricrZVdUwMJWFtbyvg4+V27AGPrpMLW
         vLpg==
X-Gm-Message-State: APzg51As7LC6TA1b0AIzLMkDlLS1/N8KFNi2/+7d9KTmr8wpvHjIaP1N
        Mz2ggGmiAhZWleLMtFUbBUYHYVx74ZARvw==
X-Google-Smtp-Source: ANB0VdYH8gASwdpILad2XoC9CvzoT+vRDN9qm8X3G33eUwmt8HH1qqqZAxS/f01Y0dy+XtqdDR2bKA==
X-Received: by 2002:adf:e6c2:: with SMTP id y2-v6mr19268788wrm.35.1535980267815;
        Mon, 03 Sep 2018 06:11:07 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v1-v6sm13362609wrt.34.2018.09.03.06.11.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:07 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 05/10] serial: uartps: Move alias reading higher in probe()
Date:   Mon,  3 Sep 2018 15:10:53 +0200
Message-Id: <56adfce565f2d743d21d80533ce20218514c7466.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cosmetic change is done only for having next patch much easier to
read. Moving id setup higher in probe is not affecting any usage of this
driver and it also simplify error path.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5bd2b0607df6..a3e97ccb376d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1415,6 +1415,16 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	/* Look for a serialN alias */
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0)
+		id = 0;
+
+	if (id >= CDNS_UART_NR_PORTS) {
+		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
+		return -ENODEV;
+	}
+
 	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
@@ -1476,16 +1486,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 				&cdns_uart_data->clk_rate_change_nb))
 		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
 #endif
-	/* Look for a serialN alias */
-	id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (id < 0)
-		id = 0;
-
-	if (id >= CDNS_UART_NR_PORTS) {
-		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
-		rc = -ENODEV;
-		goto err_out_notif_unreg;
-	}
 
 	/* At this point, we've got an empty uart_port struct, initialize it */
 	spin_lock_init(&port->lock);
@@ -1544,7 +1544,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-err_out_notif_unreg:
 #ifdef CONFIG_COMMON_CLK
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
-- 
1.9.1


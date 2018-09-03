Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E2220867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="SgxAu2rV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E2220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeICRbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38052 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeICRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so628426wrc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xVHVmREQe1YJ/hOcPwmY7D8Tk1cvKWJ1/S6c2AWMoG4=;
        b=SgxAu2rVzvZ7AkcfWcyy9Og6fZgiRL1A9f+IvI9KLvTKoWKVHrF25UWkGy2DmkPD3J
         5l4Maqk8jzDVMJ69Ap/GYApuq/yO5RIhfOzIVKpRFpDWAPD5Di02AInTlFRfab1QyrTK
         md0zZsH0tqLtTZS/8GayoM/1HIj/4V58tgfaPTcMOpHiqoMs709i5XwKDI8bgZQOtrIk
         CIyZEsvyneXuxlHu2K0+AF6cPLEWt8wot2qyRbGBpmILUhe0mJqIcVVzBuESv/H0ngmo
         b6iXCAxlnvMHOHJi9S1XE6YE2USt7hq/KES4s6ylLkeI1AwHKD85xKW3+bseLmCw0UKt
         KeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=xVHVmREQe1YJ/hOcPwmY7D8Tk1cvKWJ1/S6c2AWMoG4=;
        b=WVfsdBwVqINYLglM2phHIjDPnxbpvwEPQdUZiJsupe3q31Bsyw5+7PaHeDch6qFJQd
         1K3TFyWpJnfReIp509/NSkQBuki5ov9nM4AXxVegMhFJEsmdjx9+ntSuGFuQB+m5TI8a
         VddSFTcvOFokXrXvkr/Dib6J/qNpTiwWKcHNzEhmX0GmzXse5dfWXuIVIqn6OolNsRyn
         eyfXVQgGi72QLvCFaJRP4fK8h6af89PjtTr3iJHd2sgsSV69OOKGB4b5ylnkUrbo5CJ8
         jQf0Q+gmBg9XjSI8jJqHcsXi2Og+GFq6ItSi8xFRyAONrtaydZPgx4fp3LixQU1oD2qy
         0T/w==
X-Gm-Message-State: APzg51CplEt0qD/EbkeBveNcDTczt6qkzpxEs8I9mYimOMTOCH+7xAjd
        VswJRanNNIi6/TFWmMqU5ck6Zug0oVUTmg==
X-Google-Smtp-Source: ANB0VdZP1ejnhjjrmz8TAFH2GpAT5zfhBOJW3KSqNGqLz/vgKqCbfCWHJuGbz7s76u/72tI0ylWcoA==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr18268945wre.12.1535980266368;
        Mon, 03 Sep 2018 06:11:06 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b74-v6sm13926847wma.8.2018.09.03.06.11.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:05 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 04/10] serial: uartps: Do not use static struct uart_driver out of probe()
Date:   Mon,  3 Sep 2018 15:10:52 +0200
Message-Id: <f8084742bbd28b7b9bc6e3374ead4294600ee51e.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns_uart_suspend()/resume() and remove() are using static reference
to struct uart_driver. Assign this reference to private data structure
as preparation step for dynamic struct uart_driver allocation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3: None
Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fc0ecaf3615d..5bd2b0607df6 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -180,6 +180,7 @@
  * @port:		Pointer to the UART port
  * @uartclk:		Reference clock
  * @pclk:		APB clock
+ * @cdns_uart_driver:	Pointer to UART driver
  * @baud:		Current baud rate
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
@@ -188,6 +189,7 @@ struct cdns_uart {
 	struct uart_port	*port;
 	struct clk		*uartclk;
 	struct clk		*pclk;
+	struct uart_driver	*cdns_uart_driver;
 	unsigned int		baud;
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
@@ -1272,6 +1274,7 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 static int cdns_uart_suspend(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
+	struct cdns_uart *cdns_uart = port->private_data;
 	int may_wake;
 
 	may_wake = device_may_wakeup(device);
@@ -1295,7 +1298,7 @@ static int cdns_uart_suspend(struct device *device)
 	 * Call the API provided in serial_core.c file which handles
 	 * the suspend.
 	 */
-	return uart_suspend_port(&cdns_uart_uart_driver, port);
+	return uart_suspend_port(cdns_uart->cdns_uart_driver, port);
 }
 
 /**
@@ -1307,6 +1310,7 @@ static int cdns_uart_suspend(struct device *device)
 static int cdns_uart_resume(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
+	struct cdns_uart *cdns_uart = port->private_data;
 	unsigned long flags = 0;
 	u32 ctrl_reg;
 	int may_wake;
@@ -1314,8 +1318,6 @@ static int cdns_uart_resume(struct device *device)
 	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && !may_wake) {
-		struct cdns_uart *cdns_uart = port->private_data;
-
 		clk_enable(cdns_uart->pclk);
 		clk_enable(cdns_uart->uartclk);
 
@@ -1349,7 +1351,7 @@ static int cdns_uart_resume(struct device *device)
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-	return uart_resume_port(&cdns_uart_uart_driver, port);
+	return uart_resume_port(cdns_uart->cdns_uart_driver, port);
 }
 #endif /* ! CONFIG_PM_SLEEP */
 static int __maybe_unused cdns_runtime_suspend(struct device *dev)
@@ -1413,6 +1415,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
+	cdns_uart_data->cdns_uart_driver = &cdns_uart_uart_driver;
+
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
 		const struct cdns_platform_data *data = match->data;
@@ -1570,7 +1574,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	clk_notifier_unregister(cdns_uart_data->uartclk,
 			&cdns_uart_data->clk_rate_change_nb);
 #endif
-	rc = uart_remove_one_port(&cdns_uart_uart_driver, port);
+	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
-- 
1.9.1


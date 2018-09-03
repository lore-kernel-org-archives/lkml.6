Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB35C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678E420652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="1jRsTiSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678E420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeICRb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44712 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeICRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id v16-v6so586196wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Z6LGPRKD7iph6AElFmO944nmWy5WoOUM5jIDdjq14Tg=;
        b=1jRsTiShF23PYuhRzWEaltXcNOGNCZIapBNqWuW0bIWC1P4wy6kfJ1ObDmxiFk/E+X
         0vLb1O4a4zGlL5F+bR4i+YRuwQVk6EX4PyjtdZFpw2vQL9QqRylV5W9wIbSUyVsBbuN+
         Srg6v00FfSaG3Y0VCnTvypa2oW79qCblNr5qMg4Le5vVzbLrv8mylbMOn+d3TDTgT2KH
         dCoCn+V/G7z+CB8/h3TCWwMtKjmeY8h6B+TXJ/JUHuNrPifoAo1aQLRGrRvrKHkk+8h0
         Vo5KgVAC0Ul2gznrCX6zGPVzVlUQ61+sks2D5r55kZuD2qlWzYYL7pIX6K4GJudBc7/8
         c5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=Z6LGPRKD7iph6AElFmO944nmWy5WoOUM5jIDdjq14Tg=;
        b=fWJL/lV10M4QYypGyjylnVk+fqItePWZic4IVd/VKmi9RJAKlxoxGxBpElaZ1jtzfu
         DBDAKpcaRKz9gkmJXZeHRPkhN4Je1UhF23VkbfdaE+zEiGo2Gh/cpFQetPNGsXEj+lFp
         y07EwoTfPGP3LFMVAE3XZcxkj7fMQAPM4DYaH7h302QDuPHqZ55ypOx0R8I94W7xrPNw
         4XkwO1MwNpyhZYS4zOO305tyoMZDqkegltAy8eHtH2f0/DGP3aYOw94+/dJZ6DCmzZ6S
         XNG7ZSvAwp01S3Q9soQmiHhVyCawusNxChOioqjr14WnJRNlbYLRxRZdCBF4sOFyfIKJ
         AG+Q==
X-Gm-Message-State: APzg51DK3HW8oIGiZc5mL1IR9su9hpzU2ZHpjVZeEF2qJIXNbaKWlCTB
        +qSlF8kHf5PHNo1SjfhsJRMMUG2pJXinkw==
X-Google-Smtp-Source: ANB0VdYUmVF98/Z0+gpMfEnEeGtMry6eHDA7/D178yIoU5Fs6/sUabI0dwe/FlhkLHKhlGWKPUqJxQ==
X-Received: by 2002:adf:8367:: with SMTP id 94-v6mr19025085wrd.258.1535980275285;
        Mon, 03 Sep 2018 06:11:15 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w18-v6sm38300796wrc.38.2018.09.03.06.11.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:14 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 10/10] serial: uartps: Move Port ID to device data structure
Date:   Mon,  3 Sep 2018 15:10:58 +0200
Message-Id: <9cda66fc3c143cc2055241802300dc12f5571669.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record port ID in device data structure to be have it connected to
certain instance.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- New patch in series

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index d838612eda6f..71c032744dae 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -181,6 +181,7 @@
  * @pclk:		APB clock
  * @cdns_uart_driver:	Pointer to UART driver
  * @baud:		Current baud rate
+ * @id:			Port ID
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  */
@@ -190,6 +191,7 @@ struct cdns_uart {
 	struct clk		*pclk;
 	struct uart_driver	*cdns_uart_driver;
 	unsigned int		baud;
+	int			id;
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 };
@@ -1376,7 +1378,7 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
  */
 static int cdns_uart_probe(struct platform_device *pdev)
 {
-	int rc, id, irq;
+	int rc, irq;
 	struct uart_port *port;
 	struct resource *res;
 	struct cdns_uart *cdns_uart_data;
@@ -1402,18 +1404,18 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Look for a serialN alias */
-	id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (id < 0)
-		id = 0;
+	cdns_uart_data->id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (cdns_uart_data->id < 0)
+		cdns_uart_data->id = 0;
 
-	if (id >= CDNS_UART_NR_PORTS) {
+	if (cdns_uart_data->id >= CDNS_UART_NR_PORTS) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		return -ENODEV;
 	}
 
 	/* There is a need to use unique driver name */
 	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
-				     CDNS_UART_NAME, id);
+				     CDNS_UART_NAME, cdns_uart_data->id);
 	if (!driver_name)
 		return -ENOMEM;
 
@@ -1421,7 +1423,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_uart_driver->driver_name = driver_name;
 	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
 	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
-	cdns_uart_uart_driver->minor = id;
+	cdns_uart_uart_driver->minor = cdns_uart_data->id;
 	cdns_uart_uart_driver->nr = 1;
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
@@ -1432,7 +1434,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-	cdns_uart_console->index = id;
+	cdns_uart_console->index = cdns_uart_data->id;
 	cdns_uart_console->write = cdns_uart_console_write;
 	cdns_uart_console->device = uart_console_device;
 	cdns_uart_console->setup = cdns_uart_console_setup;
@@ -1454,7 +1456,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * registration because tty_driver structure is not filled.
 	 * name_base is 0 by default.
 	 */
-	cdns_uart_uart_driver->tty_driver->name_base = id;
+	cdns_uart_uart_driver->tty_driver->name_base = cdns_uart_data->id;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
-- 
1.9.1


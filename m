Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6370BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B91120868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="P35ow6rB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B91120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeICRbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39541 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeICRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so1109987wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bs9NcxnSSv/Ae7hcuKd4ij0d/Px3jNTx8MFPf905skA=;
        b=P35ow6rB9nb+ALt/PVEJ2Sx/qex/vJsufG8LQll3mBRs/AKIrvi9f6zQmcimn1yGuu
         nK8TQd5BNvXLnj1JxvLvtoUii87fzBTmxHaysUZj6iY/4tmNcmlX2dPfK3lp9aUHerZd
         Vk2zAJYmX5iLYAAet4qw4kobVZgUq/iTJIdOoVd9f2ZjO8jHmNiOVBEQb8yVbhGIzAw/
         ghTsew/06CGgRuKR/caySeAL9wYYnPQju6xi4NCDGi4KAOvjGZ5lSlXi8OXwG7Zh4W08
         cQySlCz603keM46aNv7kWNSMaQqMXsPdz7VW5yFdL9+2+SxdEqnCiuEL6qswLjwp8Kac
         7vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=bs9NcxnSSv/Ae7hcuKd4ij0d/Px3jNTx8MFPf905skA=;
        b=FbwikCjGc3gJpeS9/EXTGV36TbNRnwP/hyHzrhkvCjaUNEW3XNPM6LW2N2un2Cg4JY
         JaX2qEEkj+mxdkAnZDbNDO74TKVhNR68LICpNinYYYDPmSRCYCgos/gcZWhiA/Rna8Sd
         xznpvwdt72SxtAv2iRdV54cOCQVTcOLJKO/7Nw+znEsUhvGr6l5ulKnOl+8NVqtYOd0i
         9MDRVcxmbeKuK+gMDUuQswZ8Wm99m6DBUQYJLM0VI7c27tWjEjnpqDHR0BW90PiuNZcU
         FOAnv7VprznFwOwwifbVD/LNZhpoC4qVGaZhljXE7y3mCvKngu0tolX0xgbntXMh637z
         uRpg==
X-Gm-Message-State: APzg51B+rsV2AkEfgg5XBqgpMLD5Uay59we1UDABA3RtHsfUN9Rx9ZGC
        5CVIe8CGpHfP5gtfu8sMgkw1FiUPdD9C6w==
X-Google-Smtp-Source: ANB0VdaDP9KScgwZbHeX5mFwsvXi/X9akGQqFAqG4Btknl/lKOnWKKrQ0dQ62LILo5lFmTeS+3gQZw==
X-Received: by 2002:a1c:398b:: with SMTP id g133-v6mr4880491wma.5.1535980270735;
        Mon, 03 Sep 2018 06:11:10 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id h17-v6sm17050587wrq.73.2018.09.03.06.11.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:10 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 07/10] serial: uartps: Fill struct uart_driver in probe()
Date:   Mon,  3 Sep 2018 15:10:55 +0200
Message-Id: <9a2f438e7d7e39b1ce965d09cebd9fb799422479.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation step for dynamic port allocation without
CDNS_UART_NR_PORTS macro. Fill the structure only once at probe.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- s/,/;/ in filling structure
- get cdns_uart_uart_driver out of PS_UART_CONSOLE ifdefs

Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 54735a7f9960..61087233f411 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1099,6 +1099,8 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 #endif
 };
 
+static struct uart_driver cdns_uart_uart_driver;
+
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_putchar - write the character to the FIFO buffer
@@ -1239,8 +1241,6 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver cdns_uart_uart_driver;
-
 static struct console cdns_uart_console = {
 	.name	= CDNS_UART_TTY_NAME,
 	.write	= cdns_uart_console_write,
@@ -1252,18 +1252,6 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 };
 #endif /* CONFIG_SERIAL_XILINX_PS_UART_CONSOLE */
 
-static struct uart_driver cdns_uart_uart_driver = {
-	.owner		= THIS_MODULE,
-	.driver_name	= CDNS_UART_NAME,
-	.dev_name	= CDNS_UART_TTY_NAME,
-	.major		= CDNS_UART_MAJOR,
-	.minor		= CDNS_UART_MINOR,
-	.nr		= CDNS_UART_NR_PORTS,
-#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
-	.cons		= &cdns_uart_console,
-#endif
-};
-
 #ifdef CONFIG_PM_SLEEP
 /**
  * cdns_uart_suspend - suspend event
@@ -1429,6 +1417,16 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	}
 
 	if (!cdns_uart_uart_driver.state) {
+		cdns_uart_uart_driver.owner = THIS_MODULE;
+		cdns_uart_uart_driver.driver_name = CDNS_UART_NAME;
+		cdns_uart_uart_driver.dev_name = CDNS_UART_TTY_NAME;
+		cdns_uart_uart_driver.major = CDNS_UART_MAJOR;
+		cdns_uart_uart_driver.minor = CDNS_UART_MINOR;
+		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+		cdns_uart_uart_driver.cons = &cdns_uart_console;
+#endif
+
 		rc = uart_register_driver(&cdns_uart_uart_driver);
 		if (rc < 0) {
 			dev_err(&pdev->dev, "Failed to register driver\n");
-- 
1.9.1


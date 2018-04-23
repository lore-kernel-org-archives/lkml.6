Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-962895-1524477101-2-3911308248334784615
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524477101; b=VW7z001c3HzIV5eMcJyOx5OjoBrz39RnHRDSOnFD0w/OgVsN4Z
    rd9JMbQp7C6EABJ/UGKri/xeFGJp1xsU0NaRvEZnvPoWWYhOCjPBXkXQoa2ns3Ob
    pv/pR8hxv/b1/BMAmvoo6zKQq1EN/INUYWh53DdQ5kvm3y56730EItOJZlFhpmuu
    TCvO3lDseYhYy236cBe40Y8PqZOdS4qy9LLB56NJRL+3A1cnLbqZwFbMdIgZklM5
    cTyte9Dv7OUooa9hHIubcOW5xbajEgpXzT7hsFLGSVbs2d5XQ4GGBFnvqKrkB6uf
    Z7UDgZVExHN5E1Yi7hw3rcBVpf321DlbpxyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1524477101; bh=XiexYl8fL//7ezL+Eq5USZ2r2VMS9LoiAaqtnYS
    Wdu8=; b=LF6YVxcz3tXF9pr/Mi9l/ortd19fN3xXUuNDUxqeaLIrwUFAu+IbLOu
    PPC+0NMgQQB/RM7XBpPz2hGZbkvB4ddhraApJBcORkwHqN+Lp4oVarmr0VLqWmXL
    yTtpUaQxs4e0XJnSeyaGyFQTZwHsbgFZvWue1uYpmUcj9Jokdw/UkB2enQBBwXbB
    mcJkjmj0vpWrhkvk4TFbrtjFWdGbOTfHHU2V1T3b2u8ReKeuOjGk+iLAdfsxVrfG
    sk9tBy7R8qaZYjTaSLcMn+OaDEwgV9Y3QuCCB1vw8uzxSF55U+Y05uUWOnbZpRBy
    u7DgzzswZe+e+iglGmGt01CbY9srNrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=A1+/s+za x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zbz2vFT1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=A1+/s+za x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zbz2vFT1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC+Tu5bCPItJ6vYKFcbofYXEdE74iClXmTF0vucOQPqwptgeDCTbAOhsVl1VAzh/FVjLQuFK/dMJL9y+gmsjEa7oX3OJDtx0dh6PpBbF9+3Os5vr1DOS
    Q+tCgiGtP5ZHX1zom+jztXqd1NLQ96jjuAFd+uflol9Yu9r+sfoTe/VcVzFUgOJX6nWeA39Z3zQ90XMBnpUKYaZthibpYKCzOTcUCrydZoxtrPyLXtkkZlf5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=-cIClnr2Ar_InRwYfwYA:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeDWJvS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:51:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33250 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754648AbeDWJvI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 05:51:08 -0400
X-Google-Smtp-Source: AIpwx48hKubXfusEzVGK2t5jC0JNZDatHDCJSZPMkt+wZQjZw2xgqagBJE+chcTpeyc+8w7REyp9+g==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] serial: uartps: Use dynamic array for console port
Date: Mon, 23 Apr 2018 11:51:01 +0200
Message-Id: <4878fdc4564d4574b18307f80f1e9a0c00c63111.1524477059.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Driver console functions are using pointer to static array with fixed
size. There can be only one serial console at the time which is found
by register_console(). register_console() is filling cons->index to
port->line value.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/xilinx_uartps.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 932210331484..789423d081ed 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1206,6 +1206,10 @@ OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p8", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "cdns,uart-r1p12", cdns_early_console_setup);
 OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 
+
+/* Static pointer to console port */
+static struct uart_port *console_port;
+
 /**
  * cdns_uart_console_write - perform write operation
  * @co: Console handle
@@ -1215,7 +1219,7 @@ OF_EARLYCON_DECLARE(cdns, "xlnx,zynqmp-uart", cdns_early_console_setup);
 static void cdns_uart_console_write(struct console *co, const char *s,
 				unsigned int count)
 {
-	struct uart_port *port = &cdns_uart_port[co->index];
+	struct uart_port *port = console_port;
 	unsigned long flags;
 	unsigned int imr, ctrl;
 	int locked = 1;
@@ -1261,15 +1265,13 @@ static void cdns_uart_console_write(struct console *co, const char *s,
  */
 static int __init cdns_uart_console_setup(struct console *co, char *options)
 {
-	struct uart_port *port = &cdns_uart_port[co->index];
+	struct uart_port *port = console_port;
+
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
 
-	if (co->index < 0 || co->index >= CDNS_UART_NR_PORTS)
-		return -EINVAL;
-
 	if (!port->membase) {
 		pr_debug("console on " CDNS_UART_TTY_NAME "%i not present\n",
 			 co->index);
@@ -1565,6 +1567,17 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	/*
+	 * If console hasn't been found yet try to assign this port
+	 * because it is required to be assigned for console setup function.
+	 * If register_console() don't assign value, then console_port pointer
+	 * is cleanup.
+	 */
+	if (cdns_uart_uart_driver.cons->index == -1)
+		console_port = port;
+#endif
+
 	rc = uart_add_one_port(&cdns_uart_uart_driver, port);
 	if (rc) {
 		dev_err(&pdev->dev,
@@ -1572,6 +1585,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_pm_disable;
 	}
 
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	/* This is not port which is used for console that's why clean it up */
+	if (cdns_uart_uart_driver.cons->index == -1)
+		console_port = NULL;
+#endif
+
 	return 0;
 
 err_out_pm_disable:
-- 
2.17.0


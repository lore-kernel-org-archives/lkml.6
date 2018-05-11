Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526035070-2-591642966858519832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526035069; b=NtqZISe2sNlt3/bR7hX0Kl16qN2IDsXofZ9ZKsyYGqSr5LRgpC
    Qh/7RXzZVMdDfkvGqszSJYOlJfeYkTs8q6y4OqGJrstY+AbFgniqXNw+YnxO6C1p
    4+Bc/pdN36RnN5+jpUXzAER2Hl3V0LliOb++Z/JDKiOptWOAaMeouILuitJc++Cj
    g1DTpb2U/BSIPkEcilgQiYUtP3w4KXwUAEkxHcqZrH8QJQ0WXXeTEBM8xTAbGvQ0
    JUYg5QWtIJWMx9+4REcNW8oFfP/SsrJuvsDCYJTbjQDGuTTqbZ8SDpMy4XJgCc3M
    EnVPJTmU2KGTF0Xmcb7avA2gJV8Vy3ysmpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526035069; bh=I+lIilTPptdxDEvmkxYf28Qgr4XKdP
    6U6vZIUH+iyp4=; b=W/yuaQ3Ap2WW3yyGVB25GGf/oBvLgTlT6krqg8dYzWkNWf
    ifIWm4xrNXU7dAICokR2HX+KPsOBY8t/Hc8MAHqTDbWgnITCrLJPJvN0aeIqwB25
    pxlKzU/H14VARmWM4c+dqGd2C8sB5IKjxWHAKE+YlOi85EvVQsIkBYH94zeZiFGu
    AKj8GGOQCUG1U189cx3tH6R0lPYyeOjWSXWLGtxmR5fvnbUSizUYR/wIFepavMM+
    nW8q4jFRWLMnu/GpG2K/JoBho63lDkj6BF5qLR43Tdt5D09qRh7+CPPVwagGT5xb
    aGWC3600UtbAFTWCH/B4PY9e9LjwTR8DpRYxpvvQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNvckTbIqirvZE2Ss8J0DILlKjgRNrifyemXt29ClDJaRlTTMQnZ7cbHahjN3/uRkBqwCcpKmdaAwYIJchDpxcDfoMEXUl17u5HeUjv9so6HRdja+56n
    rEOTXPoZ8rHO5NQ3fAoLvtp69jIjd8yKo+iLL7ghpxQy082c11z8jvblTebsPNBEJOZCE/t67cJevA6P4g1B5LWWeO+NdG9/g0CudJ0gWsaQ9Ih3I/ZE9AXU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=0NpaGdu5TIiVLeCDOaAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753092AbeEKKhq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:37:46 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:28551 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeEKKhn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 May 2018 06:37:43 -0400
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="11427339"
From: Radu Pirea <radu.pirea@microchip.com>
To: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <broonie@kernel.org>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work under at91-usart mfd
Date: Fri, 11 May 2018 13:38:22 +0300
Message-ID: <20180511103822.31698-7-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511103822.31698-1-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch modifies the place where resources and device tree properties
are searched.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 drivers/tty/serial/Kconfig        |  1 +
 drivers/tty/serial/atmel_serial.c | 29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3682fd3e960c..25e55332f8b1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -119,6 +119,7 @@ config SERIAL_ATMEL
 	depends on ARCH_AT91 || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
+	select MFD_AT91_USART
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
 	  AT91 processors.
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index df46a9e88c34..6b4494352853 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -193,8 +193,8 @@ static struct console atmel_console;
 
 #if defined(CONFIG_OF)
 static const struct of_device_id atmel_serial_dt_ids[] = {
-	{ .compatible = "atmel,at91rm9200-usart" },
-	{ .compatible = "atmel,at91sam9260-usart" },
+	{ .compatible = "atmel,at91rm9200-usart-serial" },
+	{ .compatible = "atmel,at91sam9260-usart-serial" },
 	{ /* sentinel */ }
 };
 #endif
@@ -1631,7 +1631,7 @@ static void atmel_tasklet_tx_func(unsigned long data)
 static void atmel_init_property(struct atmel_uart_port *atmel_port,
 				struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.parent->of_node;
 
 	/* DMA/PDC usage specification */
 	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
@@ -2223,7 +2223,8 @@ static const char *atmel_type(struct uart_port *port)
 static void atmel_release_port(struct uart_port *port)
 {
 	struct platform_device *pdev = to_platform_device(port->dev);
-	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
+	int size = to_platform_device(pdev->dev.parent)->resource[0].end -
+		to_platform_device(pdev->dev.parent)->resource[0].start + 1;
 
 	release_mem_region(port->mapbase, size);
 
@@ -2239,7 +2240,8 @@ static void atmel_release_port(struct uart_port *port)
 static int atmel_request_port(struct uart_port *port)
 {
 	struct platform_device *pdev = to_platform_device(port->dev);
-	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
+	int size = to_platform_device(pdev->dev.parent)->resource[0].end -
+		to_platform_device(pdev->dev.parent)->resource[0].start + 1;
 
 	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
 		return -EBUSY;
@@ -2345,23 +2347,23 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	atmel_init_property(atmel_port, pdev);
 	atmel_set_ops(port);
 
-	uart_get_rs485_mode(&pdev->dev, &port->rs485);
+	uart_get_rs485_mode(pdev->dev.parent, &port->rs485);
 
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
 	port->ops		= &atmel_pops;
 	port->fifosize		= 1;
 	port->dev		= &pdev->dev;
-	port->mapbase	= pdev->resource[0].start;
-	port->irq	= pdev->resource[1].start;
+	port->mapbase		= to_platform_device(pdev->dev.parent)->resource[0].start;
+	port->irq		= to_platform_device(pdev->dev.parent)->resource[1].start;
 	port->rs485_config	= atmel_config_rs485;
-	port->membase	= NULL;
+	port->membase		= NULL;
 
 	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
 
 	/* for console, the clock could already be configured */
 	if (!atmel_port->clk) {
-		atmel_port->clk = clk_get(&pdev->dev, "usart");
+		atmel_port->clk = clk_get(pdev->dev.parent, "usart");
 		if (IS_ERR(atmel_port->clk)) {
 			ret = PTR_ERR(atmel_port->clk);
 			atmel_port->clk = NULL;
@@ -2656,7 +2658,7 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
 	atmel_port->rts_low = 0;
 	atmel_port->rts_high = 0;
 
-	if (of_property_read_u32(pdev->dev.of_node,
+	if (of_property_read_u32(pdev->dev.parent->of_node,
 				 "atmel,fifo-size",
 				 &atmel_port->fifo_size))
 		return;
@@ -2694,11 +2696,10 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
 static int atmel_serial_probe(struct platform_device *pdev)
 {
 	struct atmel_uart_port *atmel_port;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.parent->of_node;
 	void *data;
 	int ret = -ENODEV;
 	bool rs485_enabled;
-
 	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
 
 	ret = of_alias_get_id(np, "serial");
@@ -2845,7 +2846,7 @@ static struct platform_driver atmel_serial_driver = {
 	.suspend	= atmel_serial_suspend,
 	.resume		= atmel_serial_resume,
 	.driver		= {
-		.name			= "atmel_usart",
+		.name			= "atmel_usart_serial",
 		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
 	},
 };
-- 
2.17.0


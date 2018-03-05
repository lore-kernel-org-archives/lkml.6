Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1487136-1520250480-2-7737617012822399432
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520250479; b=i2tWlWBTnZPCCNGOJtRMW2/6GyGWsb6Y2xtzdgSsgClm1sQ
    MXspau+cPzF+0cPDWUMicJ/+EhiLWNbskahK2dptljZSaCkxYxD8BpIa/Ybi0/BB
    DCgLLI/UmPOtYvpvX86Me8hE8WRxvpgZRKVY6unSsnemS4k2kMUOCbcPg45js+CN
    xl1YZpfpTL1QPsBSEKbuXCKSe6VY5mPHIXUIQ55iMt1A+gn/3yGYU57HPOfFLz0N
    j4Q0aQeY1LNqAT+yriX5nMWmU8FX644AOojsbeBERi7oGVbRQxUt4nEzZIR9pj/b
    YcvwiZgq2SFT1Qg7TpEmqdL8XGIfgL4YhghG/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520250479; bh=CylG0/PssFLF9xZQfOaC7yFBLz
    0B91GcHLZ0vCHs9R8=; b=Wu9eKLsXepr2if2CXLeclCeAYV36480Mr8AVmkgeoJ
    9UBJC7UFcOQdWXsy7wgvRn+llxqHYc68H/biL6GQp7jhX4lvynEl8Pw75yUTofUK
    7dgQE2LVJ9dmbSHUbk1cYA7KPjLBRXSKM7bky9xFRQF0eIIGzzGOqJhCNDbu5cRC
    ZAgUAgD6w8TfTzHEG0ikGXOUSqMrMA6ONnl6SnJhko8NWAnZPJpeLbDvVMLFc3F5
    ZgmfSOeZDp1I/VJDHdFI5dtDcLqMLrqhDuIDjH+aJRl5URcqc4zEnJwEjBI4W1mK
    aF8eZYu+fQHZr/jWyt2XXvt2n1ToHHzBPFjRC0jjR2gA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cdY1jjIL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=jms.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ProAtx4n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=jms.id.au header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cdY1jjIL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=jms.id.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ProAtx4n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=jms.id.au header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934848AbeCELrz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 06:47:55 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42487 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934228AbeCELrt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 06:47:49 -0500
X-Google-Smtp-Source: AG47ELtASy0QzDkxTaZqcPnuKSLYTHHAMIVezT19Cjaw9sByaV68djUzFdFxwBDnmPwU3ldHpyHc/g==
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomer Maimon <tomer.maimon@nuvoton.com>,
        Avi Fishman <Avi.Fishman@nuvoton.com>,
        Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH v2] serial: 8250: Add Nuvoton NPCM UART
Date: Mon,  5 Mar 2018 22:17:38 +1030
Message-Id: <20180305114738.10276-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Nuvoton UART is almost compatible with the 8250 driver when probed
via the 8250_of driver, however it requires some extra configuration
at startup.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Cc: stable <stable@vger.kernel.org>
---
v2:
 Remove redundant whitespace
 Use port number 40 to fill in a gap
v3:
 Remove some whitespace in serial_reg.h
 Move UART_NPCM_TOR and UART_NPCM_TOIE out of userspace header
 Add Rob's review
---
 Documentation/devicetree/bindings/serial/8250.txt |  1 +
 drivers/tty/serial/8250/8250_of.c                 |  1 +
 drivers/tty/serial/8250/8250_port.c               | 33 +++++++++++++++++++++++
 include/uapi/linux/serial_core.h                  |  3 +++
 4 files changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index dad3b2ec66d4..aeb6db4e35c3 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -24,6 +24,7 @@ Required properties:
 	- "ti,da830-uart"
 	- "aspeed,ast2400-vuart"
 	- "aspeed,ast2500-vuart"
+	- "nuvoton,npcm750-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 160b8906d9b9..9835b1c1cbe1 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -316,6 +316,7 @@ static const struct of_device_id of_platform_serial_table[] = {
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
+	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1328c7e70108..804c1af6fd33 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -47,6 +47,10 @@
 #define UART_EXAR_SLEEP		0x8b	/* Sleep mode */
 #define UART_EXAR_DVID		0x8d	/* Device identification */
 
+/* Nuvoton NPCM timeout register */
+#define UART_NPCM_TOR          7
+#define UART_NPCM_TOIE         BIT(7)  /* Timeout Interrupt Enable */
+
 /*
  * Debugging.
  */
@@ -293,6 +297,15 @@ static const struct serial8250_config uart_config[] = {
 				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_NPCM] = {
+		.name		= "Nuvoton 16550",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
+				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
@@ -2140,6 +2153,15 @@ int serial8250_do_startup(struct uart_port *port)
 				UART_DA830_PWREMU_MGMT_FREE);
 	}
 
+	if (port->type == PORT_NPCM) {
+		/*
+		 * Nuvoton calls the scratch register 'UART_TOR' (timeout
+		 * register). Enable it, and set TIOC (timeout interrupt
+		 * comparator) to be 0x20 for correct operation.
+		 */
+		serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
+	}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
 	 * If this is an RSA port, see if we can kick it up to the
@@ -2462,6 +2484,15 @@ static unsigned int xr17v35x_get_divisor(struct uart_8250_port *up,
 	return quot_16 >> 4;
 }
 
+/* Nuvoton NPCM UARTs have a custom divisor calculation */
+static unsigned int npcm_get_divisor(struct uart_8250_port *up,
+		unsigned int baud)
+{
+	struct uart_port *port = &up->port;
+
+	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
+}
+
 static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
 					   unsigned int baud,
 					   unsigned int *frac)
@@ -2482,6 +2513,8 @@ static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
 		quot = 0x8002;
 	else if (up->port.type == PORT_XR17V35X)
 		quot = xr17v35x_get_divisor(up, baud, frac);
+	else if (up->port.type == PORT_NPCM)
+		quot = npcm_get_divisor(up, baud);
 	else
 		quot = uart_get_divisor(port, baud);
 
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 1c8413f93e3d..dce5f9dae121 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -76,6 +76,9 @@
 #define PORT_SUNZILOG	38
 #define PORT_SUNSAB	39
 
+/* Nuvoton UART */
+#define PORT_NPCM	40
+
 /* Intel EG20 */
 #define PORT_PCH_8LINE	44
 #define PORT_PCH_2LINE	45
-- 
2.15.1


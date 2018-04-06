Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022414-2-2914537355015868903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022413; b=Nf4hqIwaUS+ZVKTMIvRYfCtveOgUZJJUSv/xrSqUuc0/H3XGeI
    gh1C3AF4HRmKk681fAKkLxikaOQOkHn/ocjvsRSPPpwFGptKf6cNLYtHauo5zcT8
    +WIo7PS2a0KD4CZsvbP38IXrt/N+q8uzfJeA+fuw00r/s1jkFm1uHCC9+dFauCqk
    JqrAznVAlOvtg4zq3R6iiQ+ipD41O7oAHDMxtfa2N2r5UVbbqAp9MNUlZcEAgSwC
    UWWo0K8vPJqzRF9AP6BSW5gurzfjFWFrBH7iuzfPejFV3WEEHOXuQRLtvQOUc+Om
    4Z7guvk9nVGpZ6B1kLEnNuXBu5CVUCjcIgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022413; bh=yi9PEvzDOwcDy6HFEy5CXpwHHlzD+Q
    OlvQ3q3J9Xx4o=; b=H5/SDHx6n7lXWU7RWpu2hSfFONqqOV8yuWNOuyEo+FxjnZ
    qMWnz7w7ExLuoLHmVXC2q+rdpve6RseFim6nNgfSNj+mDmbq8d9flywCBYUsbJk+
    Jp20dMwbsDCS6X/IdlESQDuXscfD+StZX1bkXtkLsl/KZfQ72kNNMTwHKY2oxfbl
    FkiOPZ0s97CAeLQBOKtDRcgbyxvITGTT2nn2QyTsz3hzxhhxRLoNtRHTAhMYKFMv
    qx0V2GsDs3oIYFJsp316lbzGJw/UVIspDo88KPgjmaTX+KLs6MHpWVRas5dLF4go
    lPOgjEuAiltLlUOOMlDFjwnGfClmmBbV7lEKxSsQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMSVheKISrTi80dZ64zqKW0eB8PUXHL+GIZ+SK7m7EGPxtGjeNdPrmB2+Mv+fRkP0q4wJ4Gj/4uLf1Ot2lENDDOLy85xjy7Bau8umUrSlBMDJ+Mgm6U1
    7z6KF1KaeDMbZlhYTEBtYSpzVRUTfo/CGkM/LdahfgzZH64RG6ftNTGAQ2uAdGQoXf+PDxomElql5vU+2bqtFXLH5SQ5pEsMAvckp38kMmvApKErL6WjZDRe
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=KPUIpJtXZpBGrTvkhY0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeDFNp2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:45:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933065AbeDFNp0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH 4.16 05/31] serial: 8250: Add Nuvoton NPCM UART
Date: Fri,  6 Apr 2018 15:24:30 +0200
Message-Id: <20180406084341.756365710@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>

commit f597fbce38d230af95384f4a04e0a13a1d0ad45d upstream.

The Nuvoton UART is almost compatible with the 8250 driver when probed
via the 8250_of driver, however it requires some extra configuration
at startup.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/serial/8250.txt |    1 
 drivers/tty/serial/8250/8250_of.c                 |    1 
 drivers/tty/serial/8250/8250_port.c               |   33 ++++++++++++++++++++++
 include/uapi/linux/serial_core.h                  |    3 ++
 4 files changed, 38 insertions(+)

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
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -316,6 +316,7 @@ static const struct of_device_id of_plat
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
+	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, of_platform_serial_table);
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
@@ -293,6 +297,15 @@ static const struct serial8250_config ua
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
@@ -2140,6 +2153,15 @@ int serial8250_do_startup(struct uart_po
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
@@ -2462,6 +2484,15 @@ static unsigned int xr17v35x_get_divisor
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
@@ -2482,6 +2513,8 @@ static unsigned int serial8250_get_divis
 		quot = 0x8002;
 	else if (up->port.type == PORT_XR17V35X)
 		quot = xr17v35x_get_divisor(up, baud, frac);
+	else if (up->port.type == PORT_NPCM)
+		quot = npcm_get_divisor(up, baud);
 	else
 		quot = uart_get_divisor(port, baud);
 
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

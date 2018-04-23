Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-962895-1524477113-2-15505256081983615604
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
    1524477112; b=N33jaEMz0CFU84HYtMBES1Q0Im76rn1GrOPVe9ddvikpbrc4FH
    Z+btkWyHwCU7vsms5EeofYpuArkay/XtKK6RT+UA9Z+XQ+neDuzbIF1IHY6mYzLJ
    KLhTUP98RVFT1dRekg7nG7zCsmMhI3YEZyGH52e02SUmYq1M4QvbTKlN/+eeTut2
    ccYtmRcOOwtBYyWIsgyijQJsJXngB9/T53/BxCGWx2lTWQTWW9lu4t+mB69KRx2q
    XLJx7QKdAbHgbMEEklc5J28kbdbsHE948706FeZxj9e/vlRy2VUXFU8jf3C/3Skm
    SKfVyEbhBFxqMnak17qgfaMSCLYGy5OLKs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1524477112; bh=eEKruKKPpjcC4s1CUCo8Pus96qUW5ZfCooTcrsA
    COQ8=; b=IuXDJxOxOvRPu9kTJCUFzRPMIOnTvWN1R2Tz1hHXjZ7OojgrHLcSPxE
    5bGS3j8h07scWWAHgOqYzrkR0IAFcQLKcHjIMwkrZTtDZ+7BFa5SktIgQ/wx4u8A
    YKyl/401BcXe5BGvi64r195aZobkgwBY/bgOLUd7Ii+oCYyE0vZTdd6FqSIouCN6
    56xNjQQ4YtUoiBTTxBkkFB6mFszsD9KNuJC75atI1EtvSLkXFeEDA+5+yEkSmbVv
    +CsEjHf7J3lSmTkIn7lhRukVG4k70u3yYtJnwfGQmJuHpwdkNkwebQwkd6LBnaq0
    vOBycd/Qptef4r+EWS1EGgLfcheYhqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=Z4FiKGti x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Un+T0PpR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=Z4FiKGti x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Un+T0PpR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKL7lz7Fa3Qsp/VDRO1tiNbX2St2CUNHaxL4At0fiax+EAejF6JXw+2w1F0Esi4R0xs3QChyxWuubsJEIpxkf7ql+Vi94yvpoBXg4dSSES+ZIdC1MJK+
    sLAyL28yMYi3HGCj254h8DY4hbscvT21dENzet53iAdwVOfn6mbL4e3ZWVBemNHBCLfkMywovsLE1fd2WMsmdK30tVhe3WIMsxe+4H/HUbG2uwzDRPpYqqF5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=5OLT4FeSjt7c2tSnEXwA:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeDWJvt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:51:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34165 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeDWJvK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 05:51:10 -0400
X-Google-Smtp-Source: AB8JxZpuKncGDq7mRmLjDmhrcV3XdNInPCGGE84bbSRTQiN4ljKtlIVR3s5CtO09dTXPUGbhQBJg/g==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] serial: uartps: Move cnds_uart_get_port to probe
Date: Mon, 23 Apr 2018 11:51:02 +0200
Message-Id: <bc18490d406a470a31e9ca88dbe4f8c6e111174c.1524477059.git.michal.simek@xilinx.com>
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

c&p this function to probe as preparation for removing
cdns_uart_port[] static array.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/xilinx_uartps.c | 61 ++++++++++--------------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 789423d081ed..f7d527a1c532 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1099,43 +1099,6 @@ static const struct uart_ops cdns_uart_ops = {
 
 static struct uart_port cdns_uart_port[CDNS_UART_NR_PORTS];
 
-/**
- * cdns_uart_get_port - Configure the port from platform device resource info
- * @id: Port id
- *
- * Return: a pointer to a uart_port or NULL for failure
- */
-static struct uart_port *cdns_uart_get_port(int id)
-{
-	struct uart_port *port;
-
-	/* Try the given port id if failed use default method */
-	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
-		/* Find the next unused port */
-		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
-			if (cdns_uart_port[id].mapbase == 0)
-				break;
-	}
-
-	if (id >= CDNS_UART_NR_PORTS)
-		return NULL;
-
-	port = &cdns_uart_port[id];
-
-	/* At this point, we've got an empty uart_port struct, initialize it */
-	spin_lock_init(&port->lock);
-	port->membase	= NULL;
-	port->irq	= 0;
-	port->type	= PORT_UNKNOWN;
-	port->iotype	= UPIO_MEM32;
-	port->flags	= UPF_BOOT_AUTOCONF;
-	port->ops	= &cdns_uart_ops;
-	port->fifosize	= CDNS_UART_FIFO_SIZE;
-	port->line	= id;
-	port->dev	= NULL;
-	return port;
-}
-
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_wait_tx - Wait for the TX to be full
@@ -1540,15 +1503,33 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (id < 0)
 		id = 0;
 
-	/* Initialize the port structure */
-	port = cdns_uart_get_port(id);
+	/* Try the given port id if failed use default method */
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
+		/* Find the next unused port */
+		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
+			if (cdns_uart_port[id].mapbase == 0)
+				break;
+	}
 
-	if (!port) {
+	port = &cdns_uart_port[id];
+	if (!port || id >= CDNS_UART_NR_PORTS) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		rc = -ENODEV;
 		goto err_out_notif_unreg;
 	}
 
+	/* At this point, we've got an empty uart_port struct, initialize it */
+	spin_lock_init(&port->lock);
+	port->membase	= NULL;
+	port->irq	= 0;
+	port->type	= PORT_UNKNOWN;
+	port->iotype	= UPIO_MEM32;
+	port->flags	= UPF_BOOT_AUTOCONF;
+	port->ops	= &cdns_uart_ops;
+	port->fifosize	= CDNS_UART_FIFO_SIZE;
+	port->line	= id;
+	port->dev	= NULL;
+
 	/*
 	 * Register the port.
 	 * This function also registers this device with the tty layer
-- 
2.17.0


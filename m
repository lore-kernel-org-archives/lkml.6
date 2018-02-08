Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2609372-1518094534-2-14457877488423187736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518094533; b=CazO53fVrLda3g4GdS5svZfazbMu4oh5fbOlbg47smskIKj
    uxs6d8z+WvkgphkXPEGX6nnLfv1SERzqf0x8KeaFJlZ1MUKEzDodrApa8+Ge77X+
    q+Bz/pq1F3uq+gM1c7CE+3TGlINO3wy3sZnObDqKyEK3IjobIqNQOqWmlbbi6xU2
    WXtLBCOK5+tibinZVCILebgsBYJ/53+ja+pe7LiHiS7PbriLPa1nBEwfgAUNI/CS
    eMQKFlsPTBhEvvqC4l+Lyujb8ZHGcBBBU/Otk6Cl1v4gGyQ8IOfm3FRjWrpNVpNK
    rByzbr7qoSmVlRQlaGApRtJIs2V04ufEXpS1LvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518094533; bh=yigynngqJGcvPIh6bXvzMEzVO1
    SnxHZHpLmePFACyEg=; b=ANxqlfopPdfGOuUXLkWtHr+Qmxcw1w13Vla4tyN4d8
    1c/AQKNUUSymv98OUDlSyv/sLs5i0y27AG70nJCqTl+s1Bd159//FszaHnqN8TZE
    1xTzTFAecIvV13+Bf6ZEake2yHE91DUSiUu4esrJZ8HjpP9Clmo/IeowJBDRMKoN
    lDuwW89uyi4H8G412dApVN3KRIJOY6Cvk9ePmOT/mbwv5PLgiu3Klvi66cNqBge/
    BzRBa783nUcQbSvyRlW+1UYiDjyDmupCPYp1++sudGuPjQ0b5r/0T3uTiESNAtAh
    Jm9UfKAIKUCqOgRYXAKABp/Q7vmIC4z8xcdFZG4a2ioA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=lFg92sjF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=lFg92sjF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBHMzb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 07:55:31 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:38768 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHMz3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Feb 2018 07:55:29 -0500
From: Vignesh R <vigneshr@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] serial: 8250: 8250_omap: Fix throttling when DMA is enabled
Date: Thu, 8 Feb 2018 18:25:42 +0530
Message-ID: <20180208125542.15649-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180208125542.15649-1-vigneshr@ti.com>
References: <20180208125542.15649-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

omap_8250_throttle() is called when tty RX buffer is about to overflow
and can no longer keep up with the rate at which UART is receiving data.
So, the expectation of this callback, is that UART stops RX and asserts
HW flow control to signal the sender to stop sending more data.
omap_8250_throttle() disables RX FIFO interrupts thus FIFO is no longer
serviced, leading to assertion of flow control once RX FIFO is full.
But, this does not work when DMA is enabled as driver keeps queuing new
RX DMA request in completion handler without brothering about throttling
request made by the higher layer.
This patch introduces a flag that can be used to determine whether or
not to queue next RX DMA request based on throttling request.

Without this patch, tty buffer overflows are reported at higher
baudrates.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 57f6eba47f44..624b501fd253 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -114,6 +114,7 @@ struct omap8250_priv {
 	struct uart_8250_dma omap8250_dma;
 	spinlock_t rx_dma_lock;
 	bool rx_dma_broken;
+	bool throttled;
 };
 
 #ifdef CONFIG_SERIAL_8250_DMA
@@ -692,6 +693,7 @@ static void omap_8250_shutdown(struct uart_port *port)
 
 static void omap_8250_throttle(struct uart_port *port)
 {
+	struct omap8250_priv *priv = port->private_data;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
@@ -700,6 +702,7 @@ static void omap_8250_throttle(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	serial_out(up, UART_IER, up->ier);
+	priv->throttled = true;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	pm_runtime_mark_last_busy(port->dev);
@@ -738,12 +741,16 @@ static int omap_8250_rs485_config(struct uart_port *port,
 
 static void omap_8250_unthrottle(struct uart_port *port)
 {
+	struct omap8250_priv *priv = port->private_data;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
 	pm_runtime_get_sync(port->dev);
 
 	spin_lock_irqsave(&port->lock, flags);
+	priv->throttled = false;
+	if (up->dma)
+		up->dma->rx_dma(up);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -788,6 +795,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 static void __dma_rx_complete(void *param)
 {
 	struct uart_8250_port *p = param;
+	struct omap8250_priv *priv = p->port.private_data;
 	struct uart_8250_dma *dma = p->dma;
 	struct dma_tx_state     state;
 	unsigned long flags;
@@ -805,7 +813,8 @@ static void __dma_rx_complete(void *param)
 		return;
 	}
 	__dma_rx_do_complete(p);
-	omap_8250_rx_dma(p);
+	if (!priv->throttled)
+		omap_8250_rx_dma(p);
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
-- 
2.16.1


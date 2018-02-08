Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2609372-1518094572-2-2584026440995333287
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
    t=1518094572; b=gmyhYGHeeLBC1mMSP/g+VKmHFEffaslBbkxxFw11KyTvhm3
    bI5EuKSLFXahSJddQNDc5LT/ZOszBnh/6HsaLfCTmWqVRW4GwUEpZ/8ppHAyokEe
    nKeM2mnfmlaEG9PEoE4xj8iulE9U4AcpK0wgxAFY5PB0QcE/+otBiCnQQ8pdawg9
    8j884nkt9/Kz1jYYOZKN+CHxzOswN7qnVPnHJXrA2ZRf81vvMzIXbIRXtX9WYEca
    3GSSBZKAL1PXYu3JDY2YTkvHVOhEqdach8Gt/1wOmDLgfcW44VRuMo7hcc6HVOrF
    NPys9IJ09bYX0h45gA4hGJ7HNt1aWOSXsao0Auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518094572; bh=v6dw1tNTSdrRFYg2AW8exP7/7U
    akjbYzktVqwU0+0kY=; b=kL8twb9IR/Tef+yUSSqeOqNhgkfsHBqVJtEovHkUrP
    F6JCfdc1sxSle8gsCfdr69PBQDOGW/MHaeiLehjtESHmVRp89xzDgLSFyzkU/pMd
    Zm61BH7gJOzemweTnc0/CarcQ5f6ndpqkFvNmVpS1PXZ45giTXHI1YkqWFTJxfqp
    beMK1d75uHR94dUIl0xd7KUbfmTwUxbV6/GtWBd5GlaPmGnJxeibJHue8hJ+H2L1
    E2PkH/plunQpCCT0Ts64qpN6bVe8YyDs/GWhF5Gn11dO1Q+2HDdPbgexVa2o4lx3
    4Gf1FCuz/BbHwP7tDvOLvVsXYwreR6qNRXyt2Fw8Fqrw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=UmziayKj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=UmziayKj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeBHMz4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 07:55:56 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:38770 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeBHMzc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 8 Feb 2018 07:55:32 -0500
From: Vignesh R <vigneshr@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] serial: 8250: Don't service RX FIFO if interrupts are disabled
Date: Thu, 8 Feb 2018 18:25:41 +0530
Message-ID: <20180208125542.15649-2-vigneshr@ti.com>
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

Currently, data in RX FIFO is read based on UART_LSR register state even
if RDI and RLSI interrupts are disabled in UART_IER register.
This is because when IRQ handler is called due to TX FIFO empty event,
RX FIFO is serviced based on UART_LSR register status instead of
UART_IIR status. This defeats the purpose of disabling UART RX
FIFO interrupts during throttling(see, omap_8250_throttle()) as IRQ
handler continues to drain UART RX FIFO resulting in overflow of buffer
at tty layer.
Fix this by making sure that driver drains UART RX FIFO only when
UART_IIR_RDI is set along with UART_LSR_BI or UART_LSR_DR bits.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1328c7e70108..ffbb955d1c06 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1854,7 +1854,8 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI)) {
+	if (status & (UART_LSR_DR | UART_LSR_BI) &&
+	    iir & UART_IIR_RDI) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}
-- 
2.16.1


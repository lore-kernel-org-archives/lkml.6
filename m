Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158474-2-9951250796811860521
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158473; b=M9PfOy3CI+EFK0UthunzVGf0qEgQB9VE6xcyYaLOimf+XA1X0v
    ti/Cc7snx4leOZl+bLoBv4EfJ7x1nWVzX9ZxXVGHDRW4t9rNZC4d1CXgvPe1IvIJ
    dT+EXwV+XwbutUXgm6kwKLCc8qu43VMNi1qONPJc7uzjApbraLOhwMGHll1TgqeH
    obRbki6SJlYiAnLftofn/I+1WiaAE1wR+gPLzgk0raIxg23v4jvzPILAtjqEBH//
    6qRxa5Tj1dHrm9cfA5wcOK5Jf+Pt2BUsA8gbZh6ynjL/HUL3p6Ant0xkI7PnY8XJ
    4ZltR+x1HiuPRuLagWuRRqL8eNcFe4l3X0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158473; bh=1Iz/Ysao93zHJVcUlins3fLHblCnAc
    rgp9ceBCNbZYg=; b=TJ802BITlTQI9Fpnf/V5QfpkqymWHCWLtveblOqpi/xPGw
    lsDSufDbtZxRDfoONWqtU2LupCQlX2y/cpMAKM9iMoUjRsjBTFrKLjkeR3mSjGbL
    V4KNHYpgTij2+veV4Q30NVZeMVLOA8egXBUhDzX0t3yZIFPEod7vjsVZPoDT/75X
    38E/T8iAmUYDeCetiSi1VEsezMBTif/X8kzvOcqIVGEMorWKq5nGlJ2cIpqPM4Ab
    tQbQwu+djY/0ZWcesla3npHWIX/AohJSeCnmxhWpEGssL9EV2t/Ay1HCyyIchI+8
    P/xfFo9kGdeUX11eoFr6RrsGCBk4XBH6sKL9YU5w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FFZYOrXd x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FFZYOrXd x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDWW6SkM6QYMlxyshXnmD8bFIvVeALwtpk215xW0X8hsSSLyE7JdXCFB4Ajwnts9GT/oY85vZBuTNSxGfneiHfCv4ncZFApR9w/fnhaZD1uMDIq22wxL
    v/UrtoDiQ8EzLAroXcZLrYAQ+ttBeblixm8xDA86M67gpUCLCDNBZb9xZogOmqfPKu3gFbTEiZIJunlDAy3s9YGc5K/R+d0H3RTtxJxcNK6R8EkUGlIGIhyY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=sozttTNsAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=detmJ2bfGwl12fOR2OwA:9
    a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030758AbeEXKk7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030681AbeEXJ6z (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 157/165] serial: 8250: Dont service RX FIFO if interrupts are disabled
Date: Thu, 24 May 2018 11:39:23 +0200
Message-Id: <20180524093628.429607262@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit 2e9fe539108320820016f78ca7704a7342788380 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_port.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1874,7 +1874,8 @@ int serial8250_handle_irq(struct uart_po
 
 	status = serial_port_in(port, UART_LSR);
 
-	if (status & (UART_LSR_DR | UART_LSR_BI)) {
+	if (status & (UART_LSR_DR | UART_LSR_BI) &&
+	    iir & UART_IIR_RDI) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
 	}

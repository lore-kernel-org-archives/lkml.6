Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-421240-1524058346-2-10752807252624943287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524058345; b=J3XFF0YoC+ACoAwaTA5UpU2d7v09Qy+YRRK8Ivr5F2JlrB0Uvt
    WdV2cbiFExFjVeAt2C8huzQHPS2m0Xuz1QfhAIXBzskOttGvRAEmy3Q5NixXcaxD
    LbMWu+QVLRhhGwav33lQV9vQf1NDtEQ/O5K6GTclyI9DD+Mk1PtD+fwvj44GJzMr
    J5AS48aekz/myU+5oqo6DkpPU/FC5Pew2ejhnBgPUT3hbul3Ti8LVh1BmCN9y1PY
    sViKC3IWWpMZUqaSiXqUMsRcX1s8ELDlyJKevyHfMERixwNO/xg6zxHBqH7j1aLx
    B231nuz7o3/VVn3yIZVxh2IiYnzTEPFncSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524058345; bh=xC/mdItR4Q8Va5jQdLp8YwbpaK99Z6
    UUyDTBr6HNCf0=; b=NQJhgFeHSYfGcEeL/WIyWKZD7iWv5YapDpXuW30dt1mz9D
    GVb1L6S7dYWmGD0mS94OxFouyPVkYTWpY7H5pSrVyxEiDlE6WXiR5lvycOVhUjop
    xGcafgRDn7ljn3ykSkbxSFjUOPCwCmAfyM1a0yNOrRdVfXZs06emfBgoTUs9cl9U
    /yV3V/CDTG5rO2ZiMQeCTPwrBlWf248d0YfQ6OxFo/MHoPG/RtEU0eUSxeJhnM+a
    0HdiTkf+kd1Za1ekB2F6oP+7N1DK5yEEEV/0CJSqbVM5BdKtPhz974R/5lDHtFxx
    Hym0frsqptLSFbfvfeX8QODF1yuWeLDVJsO9ZIkA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=c4TzRVOg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=c4TzRVOg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCm/HkP0tJ5O0uA6TZIUxqfMW4DBKdYsMq1ihyAIYjbqIkQiXNrIwcpudcTvchCelz5OCcY2AbOJHCrXRKU8P12U6F0WbrUT59Dq6Mw9EVhHcF/ViIoC
    OwKnC+LXall5c1y9e53f6kIwK3gG22Tp6B3ipVHT2x8nxkE8MlTgt0n2ggDgErUCgIg7Qk6fFlSmbxJGfNlRmfYdBW+4IkPxgp9q4sSA3nNJqDbZjdt2itiy
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Ixy3IGBAaEOUwJuFM9EA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbeDRNcX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 09:32:23 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36878 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRNcW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Apr 2018 09:32:22 -0400
From: Stefan Agner <stefan@agner.ch>
To: gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc: lukas@wunner.de, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] serial: imx: warn user when using unsupported configuration
Date: Wed, 18 Apr 2018 15:32:17 +0200
Message-Id: <20180418133217.14568-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Remote-Spamd-Result: default: False [-2.06 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:13030, ipnet:2001:1620::/32, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_HAS_DN(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.96)[99.85%];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7]
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When using half-duplex mode (which disables receiver during txing)
the RTS signal cannot be driven low during transmission. This seems
to be a limitation of the i.MX UART IP: The RTS (CTS_B) signal is
controlled by the receiver. When the receiver is disabled, the
signal stays in UART logic idle state which is high...

If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
transmission. Since this is the default state of the RTS (CTS_B)
signal when the receiver is off, half-duplex mode in this
configuration works fine.

However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
cannot be generated when the receiver is turned off.

Print an error if the user selects this unsupported configuration
(both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
configure the closest working configuration (set the
SER_RS485_RX_DURING_TX flag).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..1ba7e98ddc76 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1833,6 +1833,10 @@ static int imx_uart_rs485_config(struct uart_port *port,
 		rs485conf->flags &= ~SER_RS485_ENABLED;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
+		/* Enable receiver if low-active RTS signal is requested */
+		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
+			rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
 		/* disable transmitter */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
@@ -2265,6 +2269,17 @@ static int imx_uart_probe(struct platform_device *pdev)
 	    (!sport->have_rtscts && !sport->have_rtsgpio))
 		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
 
+	/*
+	 * The RTS (CTS_B) signal cannot be set low during transmission
+	 * in case the receiver is off (limitation of the i.MX UART IP).
+	 */
+	if (sport->port.rs485.flags & SER_RS485_ENABLED && sport->have_rtscts &&
+	    (!(sport->port.rs485.flags & SER_RS485_RTS_ON_SEND) &&
+	     !(sport->port.rs485.flags & SER_RS485_RX_DURING_TX)))
+		dev_err(&pdev->dev,
+			"low-active RTS not possible when receiver is off, "
+			"enabling receiver\n");
+
 	imx_uart_rs485_config(&sport->port, &sport->port.rs485);
 
 	/* Disable interrupts before requesting them */
-- 
2.17.0


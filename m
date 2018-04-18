Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-536962-1524060407-2-15659311319273380201
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
    1524060406; b=QZFT4JmzZAL/Ij7tKlGu8Kzr9o0qNX4uca/o0uIb4qMXu7tHX/
    LfLcwKAZs5Llzuja+erjOqGCQODFajRIW9d0wyshYj4mWgMIr1TRegemWxFY8d9V
    YsscGIZOVm53UNJBOV18S/MMTtgD/+tYKfNY0QUVH3RzxLWcEUHhsjfe8Vmk4307
    BrENJI8/PmA/J9WH1eHwvHa+ke7JXZoH/3vND4iaCCyMEIidcMm/kU6VXTE6+Xln
    6oGof4GiNU319Y/Gw0Y7DvIXyjXUSntkS27LBrOCQoaPV+dO8K2Aun4GPnvqpfRM
    g+57FC2h1W2I2VXPv89tk8VjBlKmdrki/WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524060406; bh=AE1eLnQGNtjN1d1nSk/T8fwAKFT7jC
    gLMKslK44gsbQ=; b=sDVPeEdAJbfh/FkWrC5csoRAlnLfAKvh2NwvlboIQcfbn9
    tSo3Plw9TeqbQjeXMKweqNOjMhQ2Jw1TwP4z6OBqiQ67UoyAhSykKqY83Z3+j9q0
    apFAnyCH88Ws4UmYcJ+1kMjbpAIUTpPxTqmemO3scCOyhjkM1UQ/DaE8lbQUN03Z
    znrzeHrx+henkyYcJdW9o+kER2IG9wEJblng8WyiQs5BKq8yPuEDsQ/Vaa2sNL5J
    7dg3e6iupsEh0e0sBQ5sCITIVqeFwqG9Yh8dyZW/1+CavOQjh6q7WNxjcQBf24FE
    UL/lXNE9sjIhZfnypKVLkfePXeGl4a3Lg1FW3Kag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=S6E17FCL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=S6E17FCL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCTXmwq0uRZBwE5/IJXo3dnRj8+bWe1xJmSJldpZCtzbp6JNVqg1pum+1pm51xtKYQ7P/fKZ8L2z94BAb1PEe9nTFgJ4x/6awcqkwr1B3286adlyxe39
    tM01HTa0rOWtv5ZCXDN50FaFhWniD590Ou2oA5I5jn3cqB7QBVLFyM3S6NJNq3392PdQy3LTzN4PRgn65lprL6GsySh54P68f16+l7BWvgfgJfUgt24fQEY/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Ixy3IGBAaEOUwJuFM9EA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeDROGo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 10:06:44 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:37254 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbeDROGn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Apr 2018 10:06:43 -0400
From: Stefan Agner <stefan@agner.ch>
To: gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc: lukas@wunner.de, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] serial: imx: warn user when using unsupported configuration
Date: Wed, 18 Apr 2018 16:06:38 +0200
Message-Id: <20180418140638.19331-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Remote-Spamd-Result: default: False [-0.55 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:13030, ipnet:2001:1620::/32, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_HAS_DN(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-1.45)[91.34%];
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
Changes since v1:
- Consistently check for sport->have_rtscts && !(rs485conf->flags &
  SER_RS485_RTS_ON_SEND)
- Don't break printed message

 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..1c1080fc8084 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1833,6 +1833,11 @@ static int imx_uart_rs485_config(struct uart_port *port,
 		rs485conf->flags &= ~SER_RS485_ENABLED;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
+		/* Enable receiver if low-active RTS signal is requested */
+		if (sport->have_rtscts &&
+		    !(rs485conf->flags & SER_RS485_RTS_ON_SEND))
+			rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
 		/* disable transmitter */
 		ucr2 = imx_uart_readl(sport, UCR2);
 		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
@@ -2265,6 +2270,16 @@ static int imx_uart_probe(struct platform_device *pdev)
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
+			"low-active RTS not possible when receiver is off, enabling receiver\n");
+
 	imx_uart_rs485_config(&sport->port, &sport->port.rs485);
 
 	/* Disable interrupts before requesting them */
-- 
2.17.0


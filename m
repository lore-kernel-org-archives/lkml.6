Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524475102-2-10572287226296628287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524475101; b=lzS6cRpHfcOzQ0YOgvsl1TmjP4nsvAAKeaTBx8URheRQD9wDha
    RaxmwNLIV6dkGyc7HiGel98L9pMZ2BWkAtsmWAsO9BaxqX7v6Kg2cwXlXRZX9JxZ
    KeXShHRQcDfDjAT0rA/HnRQ9hJByh+pHqN88Bhn+FU5bOW5eJ0KgiYv3dPGwiY0n
    faUmQHs/XQtVLpRX+z0E3JgKt1SP68/6JGVbuQ0dqEQp4801yMv/UiMx4l37ycHj
    EmOEzQY7ZHN0i6xhew65yZaC1rSs1RRYrH6uOtl3D8K1IQWWH62BNjyIwg+8iE3q
    9UjrWPQlQodWmwwLrAnlNZk5+zcCZHf4iiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524475101; bh=Jvr5jbpM8pTqPIAk9VEWDQa0N/DRZm
    ved4Wq2A2/cLA=; b=oqN8tGDQ27z70sA1WyfkuTpvHKtSIL6ddRlmEcOpsZfHfR
    1axi7w3J6HOJVj4lMyMfucAWsMSPG6qNT9Gl8+TG8YxozvKY48yA8rBoJIvsdQqk
    czXnLEt82W0frqdhTTkMEgHp5Get2SoqgDlHqLgWa33g5wsx2DWtlAtNeyEee7P7
    0lxNhiR0hTNA4QpnGz4UhH6HhIx5wPmcmNLC9BLEO8zJhCbA6Xo1ihEvJoYLY6ZN
    2lZaz22lLPNveqzut6sCOr8T86hDDA6+u+kAermOxqqgOvgeIYiREAwF9LNjF9/h
    l6+dH4uPZUGLj5ikMVTmaSnLcsaFAuRRcdHPBXRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=stJtnZPL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oR2AFL/p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=stJtnZPL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oR2AFL/p;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPe2PZRI75dF1YSoZuQMGo3pS5uHQaSDG/knWW4i8Up1eicRuXhBF+0v7A/3RmqmI6w1EwnREvCRZBTP3UbH6bbii7hWLSh9GPggC70z1QzV+DQ7E3Hf
    Zlhd2YlKVM4obh8lcYeIhXOTuoXIINjF2JW81SF85MgP9+XAD+/06F44F77uepV/Hkydrfu560UzZg1LwZQTAuWmPX17EmzbD6B0Er0lVOsGKmvOPgJ8/iEo
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=Am4ss40yAAAA:8 a=NP_QP1GsO5y32gVhpVIA:9 a=AjGcO6oz07-iQ99wixmX:22
    a=lf-hbUz_c89dky27wAWH:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754350AbeDWJST (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:18:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33749 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbeDWJSN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 05:18:13 -0400
X-Google-Smtp-Source: AIpwx4/C+pNxI+et1GPgM5Da5FY/u0rCVlrZzbqv/G1ZEvyY2vCvEuPCRIzX8n9B01sql4OP3MSeQg==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: stable <stable@vger.kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jiri Slaby <jslaby@suse.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] serial: 8250_early: Setup divider when uartclk is passed
Date: Mon, 23 Apr 2018 11:18:11 +0200
Message-Id: <93a7871c8654a6273b1ab35a8071e9f830e2a0c8.1524475087.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

device->baud is always non zero value because it is checked already in
early_serial8250_setup() before init_port is called.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/8250/8250_early.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index ae6a256524d8..5cd8c36c8fcc 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -122,7 +122,7 @@ static void __init init_port(struct earlycon_device *device)
 	serial8250_early_out(port, UART_FCR, 0);	/* no fifo */
 	serial8250_early_out(port, UART_MCR, 0x3);	/* DTR + RTS */
 
-	if (port->uartclk && device->baud) {
+	if (port->uartclk) {
 		divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * device->baud);
 		c = serial8250_early_in(port, UART_LCR);
 		serial8250_early_out(port, UART_LCR, c | UART_LCR_DLAB);
-- 
2.17.0

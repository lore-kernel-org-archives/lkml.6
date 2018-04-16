Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3502703-1523893018-2-18131494282505676762
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
    1523893017; b=Lehn5g9xJ5F4ua/hTHnasr7DB4wV8+8qiRUkmpcwKGz/nSbkVn
    08Ejy+KMxBdDXkGTJbc4BOx50ORnCEkdbB1vOxE9B/ZogfEStW0845b1YVgOdE3t
    GwhwQUWUtmXWstxDKt+yEWaqVjI7wCJYLOkjMhBOWrBLHmnci5eFWlfMI4UsHYs3
    hVJFWTO8lFiy/CGkxYiqXB09ae6AElqX2UJko2gUVXFCGMsXWgAMOFqLc6TJIqNs
    ds0ShD8pJc/+offBwDgXT/iVX1jQ3od11G9vDyljsx1FoTiFnq56I2ejSf8HE+5/
    HYX/zEswsYs0esHYpsnVzGr26NSCtvkj8q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523893017; bh=Btin0YiTTzJlPGAk2yituWacFCnC1W
    spnF+ZXH44Yds=; b=thQSC5lbX97WEJyHYrw3hRGbTfFezrDTxnVdfcMGU3M+SN
    LQPQyxzCUclah0Gn9XBVjRRt+snEZZl7ILR2C6FO1yyB+HiAEG3cLgHKQRev76qA
    9dERWd/Jf90Mb5gsVMTCwsWralx9XchjuNHIIwDmq7WPrmsMpsxkdZfokmBlXGf0
    fcggNY1agGRxiJiofYVoiy43OFu+IFdMO457wZWvKFXgH6GXV53WijD+HR7kAYX7
    aJxSbEutEEr++MclX5pERhqJmi6RaYh3JcI80b2z7tQGRw91TvG/skrcps9td2tT
    1XUaF88C4C4SL5ajp834knBpGT20sHQds9ukbpBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=DgDZ9J3R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
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
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=DgDZ9J3R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAbVFjQK+ghf0P/Fef0UmMatUEF8eFPlo7s1+FitXVTmmoq5EjRVn2c+gfkPqE1chH6icSoyiMJ3qB2IYKL9SdTZbKMD9E74z7IiSSzZ5MW51fFnMRl3
    PNJdmVBuLFLiy2nTvO1WJ61sYIGflbP3rntQJVoXpsP6rFBiYEpt1L5iCpiZMzayXmwMBlHrMxUpyL1+jDTP+8EjQd51Hwo0yDwAXTUxrFAtBEgPNcqMU+Kl
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=IoFmlQYEO8KAc7pQ7V0A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750979AbeDPPg3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 11:36:29 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41856 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPPg2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Apr 2018 11:36:28 -0400
From: Stefan Agner <stefan@agner.ch>
To: gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc: jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] serial: imx: fix cached UCR2 read on software reset
Date: Mon, 16 Apr 2018 17:35:02 +0200
Message-Id: <20180416153502.11814-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To reset the UART the SRST needs be cleared (low active). According
to the documentation the bit will remain active for 4 module clocks
until it is cleared (set to 1).

Hence the real register need to be read in case the cached register
indcates that the SRST bit is zero.

This bug lead to wrong baudrate because the baud rate register got
restored before reset completed in imx_flush_buffer.

Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 91f3a1a5cb7f..4ff6bd6eb9ab 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -316,7 +316,7 @@ static u32 imx_uart_readl(struct imx_port *sport, u32 offset)
 		 * differ from the value that was last written. As it only
 		 * clears after being set, reread conditionally.
 		 */
-		if (sport->ucr2 & UCR2_SRST)
+		if (!(sport->ucr2 & UCR2_SRST))
 			sport->ucr2 = readl(sport->port.membase + offset);
 		return sport->ucr2;
 		break;
-- 
2.17.0


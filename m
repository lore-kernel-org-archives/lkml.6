Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1573997-1524228259-2-16800818672378882185
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524228258; b=LUAOgElXKEvb7Z8xuAcHhVXBMcpjqABSbBqFXsI8VX+YfkAF4c
    DtCrCIUlVIOW5uldbB8g+OUPBeRbelVt5cAlg/uBWU86pbBceNKMo7GfTChVjd9y
    w2qbCbaYXdUuQ/VTw86o00V3VO9CFCgSnB1I/7/EtFbwPGq0tpAwNp8Ap/GKdIb+
    S3dnJa/De/IW4nrL71dh/52iQ8RJFiXXbPyQS/llnDCQv20FGvsv9FqDjTfGs5eF
    DTLWJqvvhtupTEZWsKqOxMeIZXM60UODqgGvuX26KoNykt43IonjmRhpFVShHRnh
    6DSrgRFmT1FGoqB1WU0EiNq/FrXJrAOfg9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524228258; bh=fO1eydDw5EdL2x4jTesuQiVPSFTMvu
    drQbC1Vm9xU6g=; b=l6N3XIA+k9FD06DbGPFfZ8Y3ywT2M4bUNT+kfYzkDc1KJW
    /2PlcrL09jCGlqFogGWb5qy36qOw6NUcwotPd4JhnxQUGmO6lA/ur+k4rGOcBEqz
    tCAtcdeLIZmqFjCAlCLJqh6YzqoZmZP9VEJx5sIi0FGJlcVoY7rax2T5wu/N1w2a
    kxSYBTs7bcwUr7vEgkA9y6xb8Rc5GQq1vf/sOneL+igkdngZt9snGiISpPQ+YdmM
    joj0+9qYXCIzQeVAj8U0cP25I9jgFUTnZc9ku1ZCS/GMyPL2aDjkNc4lc9013EGc
    szHf0jDLr0alVAqVX3XxOiqH4pbB7DIjhtMFMt+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=vKui75vg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=vKui75vg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD5Lg6uTHnZvUr5i0eHtp5sYqTmuiYf5TE4x56dFYRYlBlOxKZ/1+i8Wq0f8A2QD5R1WA3+Eo5Q7CTIAqQkj9xhEI5gAMBKyVD0Dzd+hAc43KRFnP1O6
    fLD0/3bXaWZ6uJvqb1Wr5zAKwzowpCB4C2xkY9DEOMC8kL5VbvSvcrnFTON4IYpzOEMfkLfEu0tfvX6njllkgFXAnvO/Pty+sjFrL3IuzYixGO2H1cyo82OJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=IoFmlQYEO8KAc7pQ7V0A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbeDTMoO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 08:44:14 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:60670 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754712AbeDTMoM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Apr 2018 08:44:12 -0400
From: Stefan Agner <stefan@agner.ch>
To: gregkh@linuxfoundation.org
Cc: u.kleine-koenig@pengutronix.de, festevam@gmail.com,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2] serial: imx: fix cached UCR2 read on software reset
Date: Fri, 20 Apr 2018 14:44:07 +0200
Message-Id: <20180420124407.12892-1-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Remote-Spamd-Result: default: False [-2.10 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         ASN(0.00)[asn:13030, ipnet:2001:1620::/32, country:CH];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_HAS_DN(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         TO_DN_SOME(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7]
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To reset the UART the SRST needs be cleared (low active). According
to the documentation the bit will remain active for 4 module clocks
until it is cleared (set to 1).

Hence the real register need to be read in case the cached register
indicates that the SRST bit is zero.

This bug lead to wrong baudrate because the baud rate register got
restored before reset completed in imx_flush_buffer.

Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hi Greg,

Since this fixes a regression it should go into v4.17...

--
Stefan


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


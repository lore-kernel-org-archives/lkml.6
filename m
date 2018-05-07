Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1651933-1525729013-2-17539252338794154542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525729012; b=TGrWr/Q200SMwv2Fbn69KzI3iAHullJiwicQQHgIDuqmZ4gvHH
    weVpxZYE6QYTACeI9N+/O7t8iwTUHd8FOzh3bwYUcOVBg7A3NcA2z1SSR1mbDNlU
    20hl8eowPR1F3UX9aZFP/ep6YRXpK363DQqD8b4WJbvpuvKR/17/CrRZHJq7CRgl
    4rzRphtsHcWoqiTgzB5/WXeh8lPlY9HVQh+sjeOplYICzP1nDizDco96Yc5OtMho
    BytS/E3BStsg10wnZkZ/l3o14JDbImRX1EFsG29iG/bfVMCkxIqu0cuhkqmH+pmH
    N+LbB1ng0GxMBjr4Jgi/8m94yxY8VZrJOPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525729012; bh=
    lHpDAjkWRHqzodjXff2oaU09bgReQMkGazRqzibu4pQ=; b=RKIsBS3anef9FcL0
    OQqnfo1L2idRbR7IGY8FPI0Yhk9QcZEZVg4hYeUSTaVHdiNF1TuRoNKR3cyESr+Z
    We2Zc7vaVgM66tLjWq/+VJOWqIe+iizBjGTV3xCDOlWXgDM23Z6uUIFJHp/+terD
    Oa11trbSFId+4MZFfTGUYkTjKaOUHefSQvS2qwaisVZJpP/6vMParaD/7Ppvj1nL
    xrdE4/dFP6kKScd4GsRKqosWQYfUvZKUzIrPg7wukkBMiWx6YvnmcfbYCRsQ+9zV
    pKhEM876BiF8ImBXkkxL5e7DT97yvSk3fUp+/AsC/BSBkDLPKW7GmjvPYN8oSToz
    MWSPiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=collabora.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=collabora.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEIj/C32+wzrqFdNdMIViNk+PuRrcX4wWwOTIieSos55uVX3w9ysYZypmECo9JOnllMl8Aa5L5MuxnRKqT0G/MHRY28K4ewykI+rzPUGY2uL0CheOI8P
    brL9X5g82uG5wnu44hI8b6a8pLht5BbJwDoiBGlXu+SZvYYlfaNPOp12ZweomTpGr9v1Eyt8T9nPU8K7dIbI1dfPzXwOS+jpDhOd9EnB0BfYXkK+GltVfZ3H
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8
    a=gvl4HP8tAAAA:8 a=VwQbUJbxAAAA:8 a=6ZDyq-tEkk-8IfLj3vAA:9 a=x8gzFH9gYPwA:10
    a=X7_D5SgixhGjaE2bLVSS:22 a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeEGVgW (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:36:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43712 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbeEGVgQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 17:36:16 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 1/2] serial: imx: cleanup imx_uart_disable_dma()
Date: Mon,  7 May 2018 23:36:09 +0200
Message-Id: <20180507213610.17330-2-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unrelated CTSC/CTS disabling from imx_uart_disable_dma() and
move it to imx_uart_shutdown(), which is the only user of the DMA
disabling function. This should not change the driver's behaviour,
but improves readability. After this change imx_uart_disable_dma()
does the reverse thing of imx_uart_enable_dma().

Suggested-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c2fc6bef7a6f..3ca767b1162a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1291,18 +1291,13 @@ static void imx_uart_enable_dma(struct imx_port *sport)
 
 static void imx_uart_disable_dma(struct imx_port *sport)
 {
-	u32 ucr1, ucr2;
+	u32 ucr1;
 
 	/* clear UCR1 */
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	/* clear UCR2 */
-	ucr2 = imx_uart_readl(sport, UCR2);
-	ucr2 &= ~(UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
-	imx_uart_writel(sport, ucr2, UCR2);
-
 	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
 	sport->dma_is_enabled = 0;
@@ -1447,7 +1442,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	ucr2 = imx_uart_readl(sport, UCR2);
-	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
+	ucr2 &= ~(UCR2_TXEN | UCR2_CTSC | UCR2_CTS | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2, UCR2);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-- 
2.17.0


Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1682199-1525728983-2-2021527458645602240
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525728983; b=fUag77UkZmQzifAJiHwKcZhh/z9nMhnO1tl2AX75fQlT3E+ldT
    Ov1nEwcPY9NzZSlGy5XE4I51ah9MFaWxx55TyGnv4XxxQBeiVxMoCAciSOipIQZ1
    s4a+lAzClZeDrP+hMsCF2dcjlT5vGGsPW19Yj/YUINXEDQUo4/sCX4sS2HRGF6eV
    BXwaY5KGlVdQwVMjOfNlhOnVUaQ1xlnvLjd3dhktPahsXFyDwL29Ua4ts78kF0bo
    CYSVOsexyTA4HbakAEod8JZIgwQYADVx2zO/5juj1+rLR7yP3J093KvWcLXpslS0
    rivj1GLuxu1UHZfoyb+drDcefOahN5a4FHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525728983; bh=
    oD6nsthF9v9r4f9kpOC+2f7klKdoQWmLOK/0B0OB34E=; b=jU45dHxD82yiKLDL
    N3u92xzY02/or7Rg1QQbnRnTLBDCmwp3l3aNq9nITxXTlQV4KtIg5ee9b2T0VArM
    cx+wDZMoVDnw+h0LjR/CGRLomtA4VEvQw4xCIx+jBu5cPjdeuIxjZmS+7ORDzdxE
    NrnudYXG39PELDd9y9UEzDmVnq4E6Uac5sq5ic6S1JBzTMq4J/GThgvNtDxRRRTV
    nIcYQua1Gx488LiVOq0gLw9H05WfnJ/gNdT11Nx8W5m8mSRL/8XYvju0X8TAkSgY
    gAOqhYAO8qo/C9MX9xl+XJ58Y7XoAjEcTufXa/agfqaDuqAGQzToquFz2l0Ezggs
    1RK69g==
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
X-CM-Envelope: MS4wfK+rFhUigbGKc0OLGBVGhsz4JleSTp9IohNSJHa3M+49RABwiIkCvpa9ODpDUJfUyKtdrYvu9tBrnip80VF9zu3ThpI1SWCHeOzSygMt3wYVFZLcv8yB
    Wc9kl4v2Rqzaeds837ddS2VAgCmgWF5kB1+eq6/4cC38tu07h8imj/mXNXyQhw0+TpjEXo6XWAZAMz0DOucj1D/LaVYjmlKosNl9WbIQQIex/AjNkEiXGQKt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=OScXe70xAAAA:8
    a=gvl4HP8tAAAA:8 a=VwQbUJbxAAAA:8 a=ggMGpG-tzpMdT2HnjMoA:9 a=x8gzFH9gYPwA:10
    a=X7_D5SgixhGjaE2bLVSS:22 a=tRkgsvjveJ3YVe9fnr1q:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbeEGVgV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:36:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43716 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbeEGVgT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 17:36:19 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] serial: imx: dma_unmap_sg buffers on shutdown
Date: Mon,  7 May 2018 23:36:10 +0200
Message-Id: <20180507213610.17330-3-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
References: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This properly unmaps DMA SG on device shutdown.

Reported-by: Nandor Han <nandor.han@ge.com>
Suggested-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 3ca767b1162a..6c53e74244ec 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1425,10 +1425,18 @@ static void imx_uart_shutdown(struct uart_port *port)
 	u32 ucr1, ucr2;
 
 	if (sport->dma_is_enabled) {
-		sport->dma_is_rxing = 0;
-		sport->dma_is_txing = 0;
 		dmaengine_terminate_sync(sport->dma_chan_tx);
+		if (sport->dma_is_txing) {
+			dma_unmap_sg(sport->port.dev, &sport->tx_sgl[0],
+				     sport->dma_tx_nents, DMA_TO_DEVICE);
+			sport->dma_is_txing = 0;
+		}
 		dmaengine_terminate_sync(sport->dma_chan_rx);
+		if (sport->dma_is_rxing) {
+			dma_unmap_sg(sport->port.dev, &sport->rx_sgl,
+				     1, DMA_FROM_DEVICE);
+			sport->dma_is_rxing = 0;
+		}
 
 		spin_lock_irqsave(&sport->port.lock, flags);
 		imx_uart_stop_tx(port);
-- 
2.17.0


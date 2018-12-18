Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E980C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F2A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="GNS6SfUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeLRMTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:19:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38189 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbeLRMSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:18:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so15670236wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=gJ27nswbrpfxVG6qA2cxraDTu06pZ4WKxOLJS8Arquc=;
        b=GNS6SfUpxj34SU85j/K3BuxG0Zrs4chu/XCYqcWqcJyjFrMfSRSyYkfJBlmDXrIxce
         d59pyoiI4dIhRsI/aP0UGwBDu/N6ylueeIVmFMjox1+N3Sg1vXvBtKVT87orSTQM9lyL
         O1jKMyXDsRj1De5lnPreLB7QY9XBDClvjzvtBO4cgpRSzISEF5VsESjSlNr8qyPDOAGk
         FUVezzvflH6RoqwskrHshyXNFNe67kSJCIDkJosVYG/t2STFcZQYnieKzrrfbfKB/OlH
         2WRqrPJL59ICy9FmTnOWsmbH4TxrB0iUb4xI+xR+ZyENkz9eTfwhg9oKG4YB2I2tnlow
         6dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=gJ27nswbrpfxVG6qA2cxraDTu06pZ4WKxOLJS8Arquc=;
        b=GDdwHDnaXoTaqlztIE5LLl5jwQIFhGE1fFURbfbkE66iKpSpZhBF+un5WOhUOZdKeU
         3BLK57qjoBEegjIIjEt26uNJYQtDs2ixA6DbXc90EFhDl74H2jHvKoV6p6dl2tFhOAgZ
         3ka82NvLCj2sYb9bOCQ/CLMX7fTAUhthOyRbXO3mQyKIUcFQzDivFrX4/NBWth5KXah1
         X5KsL5dIR5oAQooTviNQQkO1rCjMZFNm/dkrLvxWPlicxnCHWm7ftkt38AFzLIIP3jBm
         fdZ4A/qOFmWW8KrnXerr/1oJ342LDzIcNSPjMkvd+r8HrcRZqKNApKw72newrhq8IKD0
         HkrA==
X-Gm-Message-State: AA+aEWbDHdAMeEwYFZnRJqhQVYdfA+HElN0PqOsOFF0g3kI31YNd42wX
        03x+ti/pxla7sJ1vT/UK5ctDKPOPBnyF+A==
X-Google-Smtp-Source: AFSGD/U+GdXHuT8ZzbO+PKI2ZZsyetLAgHnmfgmja5FkS8PJGNY/BwJgfkHs0I0m7mECgrCOalo2Cw==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr15173271wro.78.1545135533622;
        Tue, 18 Dec 2018 04:18:53 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w80sm2290393wme.38.2018.12.18.04.18.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 04:18:52 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly
Date:   Tue, 18 Dec 2018 13:18:42 +0100
Message-Id: <b0ec59d6fb0837c316e2365b2361576d0c8a82fd.1545135519.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1545135519.git.michal.simek@xilinx.com>
References: <cover.1545135519.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Correct the RX interrupt mask value to handle the
RX interrupts properly.

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Fix Nava's email address to align with patch email address

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c6d38617d622..094f2958cb2b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -123,7 +123,7 @@
 #define CDNS_UART_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interrupt */
 #define CDNS_UART_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt. */
 #define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
-#define CDNS_UART_IXR_MASK	0x00001FFF /* Valid bit mask */
+#define CDNS_UART_IXR_RXMASK	0x000021e7 /* Valid RX bit mask */
 
 	/*
 	 * Do not enable parity error interrupt for the following
@@ -364,7 +364,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_MASK)
+	if (isrstatus & CDNS_UART_IXR_RXMASK)
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);
-- 
1.9.1


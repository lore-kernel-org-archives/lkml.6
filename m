Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42ACC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6970E2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="SzNKA71C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6970E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeLENVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:21:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45684 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeLENVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:21:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id b14so6078430wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CVYMWDdvwiBrckwCj37kDX9H+rrFevEUnxol0pzn1YQ=;
        b=SzNKA71C3qJ31LdOzTeH3ymqsrEHQ+7+ORRv6ddbziFhWV/B8RqUhRnsEIKmZYTqdY
         N+yog3NLee5Uv9t2hwzeqjfd1pKhTtzWQ/B3VYPNpG74+Ck4RL+Q6nqcvfD7Ci3Pp+j2
         06musafsN6VEKtfRDcF4ZAoe1izY/2fQx5XV8bJmxo90EGkDAxuPHUvlL77SjDNw4R8r
         c7GFKNtvcLy7DJAOikFU5fa+vkuyQeIx40NmRm3+/+vkjDP8nweWG+O5ixkmDZv6hMu1
         SmUEBCjZlv2Ug25tP7b+1djZ462v+wifmwdFsJ8XHfufTxAzM82TuNkeuUbTqG6ANxen
         b/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CVYMWDdvwiBrckwCj37kDX9H+rrFevEUnxol0pzn1YQ=;
        b=Sz6KZrMW02f2nYC+A+a2OTfywZxH3fddl3RK3dHSpWb71M3eTxhCVrDUIN4NFhV+fx
         q2IRrCobdHxfZfsGr9UDe/PEdkZa1IBf0zb7pSxxEMGzvU+ENPnEETucFCcq+mQSOTfe
         Z2JM6c4Ls9p8PgpdAHNCk7Kw/NwGLC0eCfudDtxjUsp25auJSFtEwEyb6n8cPLRt55nu
         weTAx4/c3RMDZoAw+gLLTK0ZpdR7dSjyOw2DV5vLlwBWpNN6V5iTmz30SkwUncj26/U7
         BiCDoz9Z09MdoYXYyo/tsrXb+2XYUGGNz3B7h9yq76ZGd9pA9W3e28CSTotI+BhyERYY
         9OAQ==
X-Gm-Message-State: AA+aEWZvDRNyiRChDL60wtfSQNjESxNLtyQCzjW93LrdFoCQ8qtDfqpW
        lMfluKmzKEOWsefZlYP6i7Za2ZAIoYUsfQ==
X-Google-Smtp-Source: AFSGD/V4gOGFUVKyexB+Ioo7sM/kwGX7RTm3O2ylcZXXtaaXfS3yjRtdMFV5xzD0pplFWmQLdsHwqQ==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr20554177wri.210.1544016090395;
        Wed, 05 Dec 2018 05:21:30 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 6-v6sm13406730wmd.45.2018.12.05.05.21.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 05:21:29 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly
Date:   Wed,  5 Dec 2018 14:21:28 +0100
Message-Id: <903d6b4f614a395d063f95bfc4658a6944526958.1544016085.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

This patch Correct the RX interrupt mask value to handle the
RX interrupts properly.

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

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


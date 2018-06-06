Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="WfUmlMio"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE3CB606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeFFMnZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:43:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40433 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeFFMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:41:46 -0400
X-Google-Smtp-Source: ADUXVKLAJsGs2WdEGDsnTMYAT8PmXYVbXK+hg2VHWIFXWcajJ0S4tLF0bK8+h98QbmxhAkDttWUn8Q==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v2 1/6] serial: uartps: Do not initialize field to zero again
Date: Wed,  6 Jun 2018 14:41:34 +0200
Message-Id: <e8b0169887855a5ef2c1a0456842f650601b451c.1528288895.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1528288895.git.michal.simek@xilinx.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing zero and NULLs to already initialized fields is not needed.
Remove this additional writes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- new patch - it can be sent separately too

 drivers/tty/serial/xilinx_uartps.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8a3e34234e98..5f116f3ecd4a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1510,15 +1510,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 	/* At this point, we've got an empty uart_port struct, initialize it */
 	spin_lock_init(&port->lock);
-	port->membase	= NULL;
-	port->irq	= 0;
 	port->type	= PORT_UNKNOWN;
 	port->iotype	= UPIO_MEM32;
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &cdns_uart_ops;
 	port->fifosize	= CDNS_UART_FIFO_SIZE;
 	port->line	= id;
-	port->dev	= NULL;
 
 	/*
 	 * Register the port.
-- 
1.9.1

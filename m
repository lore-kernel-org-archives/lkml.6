Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B1CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA77E20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="b72F7Yun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA77E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeICRbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeICRbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so574773wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IEO3yDjZVgWsh5LL+iyO+h5Gjo8oaKkP6OuPubrdvDI=;
        b=b72F7YunxZp9VNZw+vhHRA8VxNTCZPReawxwFsgS9Bq6RPbNclo8PlROsNU2UPJqqu
         ttQ6/qApGaBtl0tzUNLOdjphjhM+B5KAfJtABQDLcrdbx86uZ4NKK7o2SENmb3sKzmDA
         dBtpVB8I6+kH4p15MpQxl/yGbxHL3oLdeCfpHGFJNSiSFQ2B//Nu2kBSrQjYEBctaIJP
         bOeHMqautuMHOATUxxRAK+SfuQFknzCwX5rbsy3YNittc5sVNIn4rOcAaU9Cc+hsiUax
         jXK5HC3R5OYWf9rGG5fJOX8w8TJ3LDSrOP+gXht43hpGwYsoyj5BgN7aG8+Uef55v77M
         1xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=IEO3yDjZVgWsh5LL+iyO+h5Gjo8oaKkP6OuPubrdvDI=;
        b=Fh8OhsYz/r/x5r6LIVaepivZQzkXu5wVPCRkN0GBXH3DRnu9wIolQumH/1q1YILf9N
         rxb+Dr/cI76ro9VYjEUXvgFE3pBPDW26qZM+R6fyGGNwX1io4hpg4iwjkQ9iCdKmGme3
         1idNjHpGtqDbc/ov9yl+M5IpP84CEJxk9aDVbZoBwv684rVQMPfRMlHB2YGx4h3steD5
         Ai0uE7sTkROtfIo4+ipNt2wRUQzAifjGIwpNdLul4XZtdxfsrW2QpyvaCw9oc1rdYxcG
         9YQdSmzeq2hD2S9wh+wwh5n8zVbzDuMyvyuPXfLHAxpFAP8Ud73AlOiwumoUW7+Y0/VB
         e0kw==
X-Gm-Message-State: APzg51C1unvQRSvgXe92ejL0AXa6dkUKS6EEfdld3M89jePF+qeGW0iO
        8cuB7pU6mPuCm80G3e41D3NJD+vWxsQiog==
X-Google-Smtp-Source: ANB0VdbbRRV10cJTTFfrFnlVyqpux9vntv7MLfprlRri607PCLGe3WZMv0H7dD3ZDexxpWKF4oMtgg==
X-Received: by 2002:adf:fc83:: with SMTP id g3-v6mr19105157wrr.216.1535980272205;
        Mon, 03 Sep 2018 06:11:12 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e14-v6sm12245995wrv.44.2018.09.03.06.11.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:11 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 08/10] serial: uartps: Change logic how console_port is setup
Date:   Mon,  3 Sep 2018 15:10:56 +0200
Message-Id: <c1bcd6cf73ac60b0ae66cbb3fe859de39ef9df9e.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change logic how console_port is setup by using CON_ENABLED flag
instead of index. There will be unique cdns_uart_console() structures
that's why code can't use id for console_port assignment.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- New patch in series

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 61087233f411..0e578c0a8ce0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1532,7 +1532,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * If register_console() don't assign value, then console_port pointer
 	 * is cleanup.
 	 */
-	if (cdns_uart_uart_driver.cons->index == -1)
+	if (!console_port)
 		console_port = port;
 #endif
 
@@ -1545,7 +1545,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/* This is not port which is used for console that's why clean it up */
-	if (cdns_uart_uart_driver.cons->index == -1)
+	if (console_port == port &&
+	    !(cdns_uart_uart_driver.cons->flags & CON_ENABLED))
 		console_port = NULL;
 #endif
 
@@ -1594,6 +1595,12 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+
+#ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
+	if (console_port == port)
+		console_port = NULL;
+#endif
+
 	if (!--instances)
 		uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
-- 
1.9.1


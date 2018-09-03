Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCE420868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="OAmmz4f+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCE420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeICRbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:31:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41809 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeICRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:31:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so606012wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y8UxnDrErzxaoHSaqXHkoDRD2bv3bmlfTzwBM+V1Aq0=;
        b=OAmmz4f+WbkYQ1097bi5XKeyMZ3U4MNWAR5flZRi6QKa6b1GFGn/mC5L5mbYBpoovp
         38hNKlzImUmyBYwPzEm3GSTCa4fVJ2cxMAlFhqhy5eu8D224b+x20T+WfaHM3clRa7yw
         pTiegdFxTnacsl9CMrjsRpaGMEhG0xQt4xJ6jNV829xZkPI87Lptpu40apPSfVpU6cdo
         4HTbb1WafAR+yOL0gwQfbPpCsd9PnMGg4yHXNQT669+2Vjku65tJy5Jn3RiqFAFJVsCp
         /EnHKEBplQwxYUxskoe2PKDNXrfxs0+7f71eR2MKJgPR2Ux4e7hBUmg+AZsaR4DgH/7L
         VxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=y8UxnDrErzxaoHSaqXHkoDRD2bv3bmlfTzwBM+V1Aq0=;
        b=rkZyQf+RwlHRYpSh1N/GdelJp05+lliFnCeXXsWxBKXkgZx1rT8P4nP2q9pOnd8DMi
         IdKN/Mt3i3locJvJv3p4Ud8unLq3rAglZJRZ8zytDlbm2qY2NNBS6rsb3Tlbq1mSBYEI
         Wr5/5ZNiBQri48GEbBX3yvyrzYKS1eqCdiiL+6B7xK7AvvskwDuu5qLA5Vu5onh6nirF
         F0/PfPnnUYXfevFpFyM9BZEAyhL8r1euZCEuLWmqJsOpHODEfePN+8gTxKe+4Je9/elS
         mFYuOWL2C4aftvrIqGEcywryk4tIhi4efIaKQTQ99RG3QRnMrZ92DvbFntfN+BxP2FMC
         k1xQ==
X-Gm-Message-State: APzg51AdOx2pPepJ/Au293pL16jb0fcxNbXRkEw2zdGnL/8Lwji/aaBD
        kQGSPWXMHgD263vVF8L/wUmPcS4pAw3VpQ==
X-Google-Smtp-Source: ANB0Vdazt/g3oJviGvhnyg9Tzd2SJeE/irkN8Tl+e3d4uBsSn16KK2E85oNBoRtJiI1r9bAVe4lWEg==
X-Received: by 2002:adf:f045:: with SMTP id t5-v6mr19094895wro.92.1535980264715;
        Mon, 03 Sep 2018 06:11:04 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id m68-v6sm18555465wmb.10.2018.09.03.06.11.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:11:04 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 03/10] serial: uartps: Fix suspend functionality
Date:   Mon,  3 Sep 2018 15:10:51 +0200
Message-Id: <26804ea4d2196674a30ddd7dccc068269816b882.1535980253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1535980253.git.michal.simek@xilinx.com>
References: <cover.1535980253.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

The driver's suspend/resume functions were buggy.
If UART node contains any child node in the DT and
the child is established a communication path with
the parent UART. The relevant /dev/ttyPS* node will
be not available for other operations.
If the driver is trying to do any operations like
suspend/resume without checking the tty->dev status
it leads to the kernel crash/hang.

This patch fix this issue by call the device_may_wake()
with the generic parameter of type struct device.
in the uart suspend and resume paths.

It also fixes a race condition in the uart suspend
path(i.e uart_suspend_port() should be called at the
end of cdns_uart_suspend API this path updates the same)

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v3:
- New patch - can be sent separately but there is dependency that's why
  sent in this series

Changes in v2: None

 drivers/tty/serial/xilinx_uartps.c | 41 +++++++++++---------------------------
 1 file changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9a08542cec47..fc0ecaf3615d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1272,24 +1272,11 @@ static int cdns_uart_console_setup(struct console *co, char *options)
 static int cdns_uart_suspend(struct device *device)
 {
 	struct uart_port *port = dev_get_drvdata(device);
-	struct tty_struct *tty;
-	struct device *tty_dev;
-	int may_wake = 0;
-
-	/* Get the tty which could be NULL so don't assume it's valid */
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		tty_dev = tty->dev;
-		may_wake = device_may_wakeup(tty_dev);
-		tty_kref_put(tty);
-	}
+	int may_wake;
 
-	/*
-	 * Call the API provided in serial_core.c file which handles
-	 * the suspend.
-	 */
-	uart_suspend_port(&cdns_uart_uart_driver, port);
-	if (!(console_suspend_enabled && !may_wake)) {
+	may_wake = device_may_wakeup(device);
+
+	if (console_suspend_enabled && may_wake) {
 		unsigned long flags = 0;
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1304,7 +1291,11 @@ static int cdns_uart_suspend(struct device *device)
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
-	return 0;
+	/*
+	 * Call the API provided in serial_core.c file which handles
+	 * the suspend.
+	 */
+	return uart_suspend_port(&cdns_uart_uart_driver, port);
 }
 
 /**
@@ -1318,17 +1309,9 @@ static int cdns_uart_resume(struct device *device)
 	struct uart_port *port = dev_get_drvdata(device);
 	unsigned long flags = 0;
 	u32 ctrl_reg;
-	struct tty_struct *tty;
-	struct device *tty_dev;
-	int may_wake = 0;
-
-	/* Get the tty which could be NULL so don't assume it's valid */
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		tty_dev = tty->dev;
-		may_wake = device_may_wakeup(tty_dev);
-		tty_kref_put(tty);
-	}
+	int may_wake;
+
+	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && !may_wake) {
 		struct cdns_uart *cdns_uart = port->private_data;
-- 
1.9.1


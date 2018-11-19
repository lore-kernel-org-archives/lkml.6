Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7792086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7792086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbeKTC6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34966 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729995AbeKTC6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:10 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gOmUr-0007HG-Bv; Mon, 19 Nov 2018 16:34:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: usb: early: clean up indentation, remove extraneous tabs
Date:   Mon, 19 Nov 2018 16:34:00 +0000
Message-Id: <20181119163400.16991-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a hunk of code that is indented too much by one level, fix
this by removing the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/early/ehci-dbgp.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
index d633c2abe5a4..ea0d531c63e2 100644
--- a/drivers/usb/early/ehci-dbgp.c
+++ b/drivers/usb/early/ehci-dbgp.c
@@ -631,28 +631,28 @@ static int ehci_reset_port(int port)
 		if (!(portsc & PORT_RESET))
 			break;
 	}
-		if (portsc & PORT_RESET) {
-			/* force reset to complete */
-			loop = 100 * 1000;
-			writel(portsc & ~(PORT_RWC_BITS | PORT_RESET),
-				&ehci_regs->port_status[port - 1]);
-			do {
-				udelay(1);
-				portsc = readl(&ehci_regs->port_status[port-1]);
-			} while ((portsc & PORT_RESET) && (--loop > 0));
-		}
+	if (portsc & PORT_RESET) {
+		/* force reset to complete */
+		loop = 100 * 1000;
+		writel(portsc & ~(PORT_RWC_BITS | PORT_RESET),
+			&ehci_regs->port_status[port - 1]);
+		do {
+			udelay(1);
+			portsc = readl(&ehci_regs->port_status[port-1]);
+		} while ((portsc & PORT_RESET) && (--loop > 0));
+	}
 
-		/* Device went away? */
-		if (!(portsc & PORT_CONNECT))
-			return -ENOTCONN;
+	/* Device went away? */
+	if (!(portsc & PORT_CONNECT))
+		return -ENOTCONN;
 
-		/* bomb out completely if something weird happened */
-		if ((portsc & PORT_CSC))
-			return -EINVAL;
+	/* bomb out completely if something weird happened */
+	if ((portsc & PORT_CSC))
+		return -EINVAL;
 
-		/* If we've finished resetting, then break out of the loop */
-		if (!(portsc & PORT_RESET) && (portsc & PORT_PE))
-			return 0;
+	/* If we've finished resetting, then break out of the loop */
+	if (!(portsc & PORT_RESET) && (portsc & PORT_PE))
+		return 0;
 	return -EBUSY;
 }
 
-- 
2.19.1


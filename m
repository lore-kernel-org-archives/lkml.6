Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E342082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="nh9fJbbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E342082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeLENUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:20:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42353 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLENUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:20:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so19645845wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 05:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=gcRaEiI2nC450w3C4tg9ZcO2U8hEoUurJuHUy1B1tnA=;
        b=nh9fJbbPfMM+03IQICApNkluLYl9gRxhI1R5pdJJ1PgLLgQIYKb3To1l5vmpdtlxz/
         H5SjLtCT1i9rtirb2iUlqE3KcYgai+2W9zBqJhyuY83UhrOJDaso+x63EfEJM5Q3wpjj
         dT29NlmMILIP5OVgAayThZBCxgLXIBU9CzGFfVYXUSS2ly5KSyiH7t+wEBvbXqyf9obM
         HkQKZAim31IGNUGCHP5KtFoqC1JEunJeM6/ezMAOzxEfyuDYmwhg4wzqSnt3RRoptCMs
         dypCG3IMRgxXGfxUbQD/fH2EhWeLbcYfjDrjZPgGzvPf0vGU+XOzWF5G4+emozHwXbF8
         QGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=gcRaEiI2nC450w3C4tg9ZcO2U8hEoUurJuHUy1B1tnA=;
        b=q8xJZeIKvuRZTXJ9jQnjOxlk0Ow2C5jDxmOKkMUn10xzugo+3tc9U+9QQLooOUcs2d
         bemI6Av1GqGjYQv2WPflYZdSBtiLZtky8oSD8DTyTwHAgL4PY2n2++vhp5/d47nO5sRX
         yuR1YYXomeNz+bwwqQxjKqG0chtf9Y58QvPKzmysPAzEhHAo4uSfgzjzWeqUzOSGisp9
         mykeuUcwed541bPeBEVaaFiB1yeKZesVZQ0k94e0atIN6iBiETfSrA9Wwxv8Jn9zKvkL
         igEWZBaEHKD447QBm1hpx8Kty58XZbUTdbabRDV654E+p11qYx7d4QxVyZ4x8n1MGClK
         W4dg==
X-Gm-Message-State: AA+aEWbBBzdaIYZsxSPZOa3zXQweA+IfwS8u+tHrlxqQZ1ag3BtSIu1V
        IRkh4f4/SpiRcUm6PvKmH/pJgd8ZV+/h3g==
X-Google-Smtp-Source: AFSGD/Wmots0zroiwZ1vgBo9yJOj/elNLlX0Yh62PsRqEOeEb0YgQygZdagqNvYUfhGmDL68kiT+nw==
X-Received: by 2002:adf:9521:: with SMTP id 30mr20586373wrs.192.1544016039444;
        Wed, 05 Dec 2018 05:20:39 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g188sm13552096wmf.32.2018.12.05.05.20.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 05:20:38 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: uartps: Check if the device is a console
Date:   Wed,  5 Dec 2018 14:20:38 +0100
Message-Id: <ad7c37027afef738fcda5d978a73cc4c595ef412.1544016036.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

While checking for console_suspend_enabled also check if the
device is a console.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 0140644391df..9cdc36be5b13 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1255,7 +1255,7 @@ static int cdns_uart_suspend(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && may_wake) {
+	if (console_suspend_enabled && uart_console(port) && may_wake) {
 		unsigned long flags = 0;
 
 		spin_lock_irqsave(&port->lock, flags);
@@ -1293,7 +1293,7 @@ static int cdns_uart_resume(struct device *device)
 
 	may_wake = device_may_wakeup(device);
 
-	if (console_suspend_enabled && !may_wake) {
+	if (console_suspend_enabled && uart_console(port) && !may_wake) {
 		clk_enable(cdns_uart->pclk);
 		clk_enable(cdns_uart->uartclk);
 
-- 
1.9.1


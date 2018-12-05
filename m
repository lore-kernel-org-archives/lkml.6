Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C02C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3271E2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 13:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="VVDRDjQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3271E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeLENUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 08:20:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54684 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLENUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 08:20:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id z18so13263412wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 05:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2/kWzSPXQ+g9IzAwdqQK9pspdaUmQmZp604OR3Ol9F4=;
        b=VVDRDjQMAiePU/UmXAewImUcYfIee8a8aSVG4rqENqzYNbnohBj0g1ESMboIMYBogq
         vBV8qi5GYKN1ZJsGMyuTCurU3jGPE1021E5uSRrSVygd6QSI2WRV+p+XmAdEB2RDlQ12
         4r2Bq3T3PuHWPvlIgDATYskppM7LRK1K9Tfz7u/Y1OtURQbvjr0O/YB71dPXNAHdvt5b
         UbHQX3croqJ/J5RUT3iRc9rL+i+oWvJ5R/eTucEUjnVmc54zsfNaejfqKfyZ7F3OwmpJ
         dDDN49fs2L4XKh2E2KgALp20nud6jmF0x/NQgl6FvDcnprj6h4sQBR978yzVOyvN6ICl
         +mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=2/kWzSPXQ+g9IzAwdqQK9pspdaUmQmZp604OR3Ol9F4=;
        b=nRkDqO8W5j+w4jJ6df+LhOKFWgIpq4hN+ybbMEi+C9uDV6htqaw8rUmrCVjM4NdCTf
         nObANFMUTQOcd3Xw0f9StqpGlTSlPmYTxoz2JAcCE9W7g0Yb1F4j6AvJMyGkcflixXSf
         YsKVy1FIl00F5vK8LzD7fC1bJUt1TRqn5C00s339S+ynL3BCVYzRku6t4vugfoU95AHn
         c4iJm3SZ1ZlI9VnIS1VslfQ+OMhdcAyCnTI9Dlnj+avYgo7UxLqxFmGVrW2lJdtYCCja
         3wgO3P1qu4WESfRv/iQ3ziYK8BY1go6ja0EhSNC8MtYlFX4Y3SFJ0pTpeiuuLamX24HY
         mo7g==
X-Gm-Message-State: AA+aEWbNOSHq+848csUYvDmyxQxd+AtOTkWI/uaP61shN4GsB0R2NEwG
        jSI7pTuAsmwY2Fz6eBAV0E5ED0VhXJxpNQ==
X-Google-Smtp-Source: AFSGD/VXWvI0GfqkOkDTNp4gngw3LRwT7uq+xj32X1p6Ti9G4UMPxZP8l/VyD72swxO0r/Bl4az+vQ==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr16640399wmf.97.1544016013563;
        Wed, 05 Dec 2018 05:20:13 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id j8sm17913635wmd.0.2018.12.05.05.20.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 05:20:13 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: uartps: Add the device_init_wakeup
Date:   Wed,  5 Dec 2018 14:20:11 +0100
Message-Id: <ec9fdbdf1c444dc60edfc75a31583630e76a9b72.1544016009.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Initialise the device wakeup.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 379242b96790..0140644391df 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1624,6 +1624,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+	device_init_wakeup(port->dev, true);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	/*
@@ -1702,6 +1703,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	if (console_port == port)
-- 
1.9.1


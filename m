Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9336C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6A92184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="WaWVojt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfAaEcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:32:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43182 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfAaEcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:32:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so814622pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 20:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g4AXKZkVOkKEJvtwQToCZBCJ6LVxp0WMyaajG/+RkQo=;
        b=WaWVojt4IJIkln6YmervJiqsTo+3hTUjBIXCyvz2usgvakGN+euVrdsilVIXVLEIVg
         ed3j4BqjAvXkXHPx95Z8liXTODoLMljFPIld6+q8PlWAbMbUFYMaYcqJxAReBOe9FKu9
         QpbuQTfED0MY39lMEpeP8LuZN9rbp1eU+nQ8CCIzUPUnWCuttW7KoU0bWcWMfL/BtVaE
         nToE+EyqrhadgIna46uaMVqBEHiqfRqP1mLVk9y+YhHCMzyOLD4hoX3W+b2geB35zAzd
         RHVnXxR+ztl2rVZ4w3iysM9GIk5Gr0Lp40UbjANCvvQhacnrrW7WhkR+ToA2ax875ArM
         TNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g4AXKZkVOkKEJvtwQToCZBCJ6LVxp0WMyaajG/+RkQo=;
        b=JRhMZctVZ7aGunxTsj9Qb0Nbsh9QS41G6nAmmjk9ADghaJeM5TEFX3/Ny88cBv61Yo
         BKeH/xgHFAlbDHY0EJ1jsKbZJkCV6/2y3SDJ0APcj6clbk9iPDACY7VrLgAX7VSYv8Vy
         xVKuqOpXam+xew0JenmRSIBTWbiJVLtexa3tunJFwqkSv2D9rbygw+H3nvA4yyCOrP8j
         /lPjTAPHvXMA437IAfhUGIdUbaVTa7AQs6tY/kfbzAIcR8UhHLNfE4kzEhv5UQe5UFTk
         RPtqvaLT2U6wcNLg+g3diT4PlzkvjkZVsD9mVUbJVdWWdVZP8+KxglwysIkIrwXHWOQt
         WJrQ==
X-Gm-Message-State: AJcUukd2Wtv0ujp3eSCpp4Z/69go/fyRwqHudNVvFzcj0DV9UnnvbpUs
        0nHea29xxik7/oKlYNOuyZ3I7Q==
X-Google-Smtp-Source: ALg8bN7ustQxwqBeODurOC2wvTAIbnCx9SJSJU+DeLlRi9ICc25Z+ZBLaTwbYgPl0DW5TCGpVJTh4g==
X-Received: by 2002:a62:1289:: with SMTP id 9mr33803049pfs.102.1548909151080;
        Wed, 30 Jan 2019 20:32:31 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id c7sm4410556pfa.24.2019.01.30.20.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 20:32:30 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] mfd: at91-usart: No need to copy mfd_cell in probe
Date:   Thu, 31 Jan 2019 12:32:13 +0800
Message-Id: <20190131043213.29514-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131043213.29514-1-axel.lin@ingics.com>
References: <20190131043213.29514-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pointer instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/at91-usart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
index 684d3a8db661..6a8351a4588e 100644
--- a/drivers/mfd/at91-usart.c
+++ b/drivers/mfd/at91-usart.c
@@ -27,17 +27,17 @@ static const struct mfd_cell at91_usart_serial_subdev = {
 
 static int at91_usart_mode_probe(struct platform_device *pdev)
 {
-	struct mfd_cell cell;
+	const struct mfd_cell *cell;
 	u32 opmode = AT91_USART_MODE_SERIAL;
 
 	device_property_read_u32(&pdev->dev, "atmel,usart-mode", &opmode);
 
 	switch (opmode) {
 	case AT91_USART_MODE_SPI:
-		cell = at91_usart_spi_subdev;
+		cell = &at91_usart_spi_subdev;
 		break;
 	case AT91_USART_MODE_SERIAL:
-		cell = at91_usart_serial_subdev;
+		cell = &at91_usart_serial_subdev;
 		break;
 	default:
 		dev_err(&pdev->dev, "atmel,usart-mode has an invalid value %u\n",
@@ -45,7 +45,7 @@ static int at91_usart_mode_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, cell, 1,
 			      NULL, 0, NULL);
 }
 
-- 
2.17.1


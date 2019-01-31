Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF4C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F952184D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 04:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="zhHAn9pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfAaEc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 23:32:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40763 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfAaEc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 23:32:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so823109pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 20:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=AoU7IiOI0F4C6TXDnihBLO9O/eqTAwJ2yeZMEsqLwtM=;
        b=zhHAn9pRNGIJfPRf/mAr132Us3pzH3xBryeNW+1+hJ+Ue3s5gaTqJKXxbWJqtM66Cn
         +tGloAyfH7hyFsJB7p5mP+WJ1HG9pxmgPThDXGLwSHEiaG+NksO9KRt/1XMeRC5ZSbO6
         +mxAx7ARL8tZL+qn7WWLVWaFMzhS3NhlfUJC1DH0kTEAUnFMpqKPe0NkNgbBmO7nwMjV
         CUt4Qr/ooFJu0MWQkc1qC4PwnAwTqXmzviLaLeL8kYYa96MMim3mzULltXyzyC7+8Fa+
         SNd8y5edAwL5ao3M6NWQ8AxXsbn64REZD50lh6gCZltOTldPG4NaJuezq0Y22PKF9a+T
         U+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AoU7IiOI0F4C6TXDnihBLO9O/eqTAwJ2yeZMEsqLwtM=;
        b=LPzZze4dAuLS28DY3rD+gbunL7TwWEl8lqJ4BVMnoXlS9Papqi05nQe5dFv6SQt1Z+
         fiZkUNtLZiNJ8cniW+sj+80GeYlY/yf6Rxx2BqryBeQ41RCi+valnqfbRdo/NhUXTG2g
         9u7yNwb3WvNqYThtqmDlds9p85Qj9taaKvhYsT2USBrumkWnT+8uvmOifd07wRDBmRYC
         vR0Juf8vzoZQQEremN5vL86jRqE8Fi/pxlAn/EMx0DoiakVfokAqJb7bln5HijHSzYe+
         7VUP+Tqf+9NpHrUgF1zRxAlTJeABv2aMqiZJB26hfCGLz3l8J26kr0Usc96hDlC/kqLS
         i2sw==
X-Gm-Message-State: AJcUukcVGgqEPH7E2P9SNLi+rZUgoZttvXTHWGGrwfT7tcx64NRisba4
        x7pUp/96kH2CQ3+B5IlfGCbXzg==
X-Google-Smtp-Source: ALg8bN6UON0bWaIGcV5NZoPwtBxDBeCRqae2HRLTk4SSTw1lwM/SFboyfPY2oCOW0o0DWYsc8u1wQA==
X-Received: by 2002:aa7:8286:: with SMTP id s6mr32689413pfm.63.1548909147549;
        Wed, 30 Jan 2019 20:32:27 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id c7sm4410556pfa.24.2019.01.30.20.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 20:32:26 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] mfd: at91-usart: Constify at91_usart_spi_subdev and at91_usart_serial_subdev
Date:   Thu, 31 Jan 2019 12:32:12 +0800
Message-Id: <20190131043213.29514-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are never get changed, make them constant.
While at it, fix indent as well.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/at91-usart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
index d20747f612c1..684d3a8db661 100644
--- a/drivers/mfd/at91-usart.c
+++ b/drivers/mfd/at91-usart.c
@@ -15,15 +15,15 @@
 #include <linux/of.h>
 #include <linux/property.h>
 
-static struct mfd_cell at91_usart_spi_subdev = {
-		.name = "at91_usart_spi",
-		.of_compatible = "microchip,at91sam9g45-usart-spi",
-	};
+static const struct mfd_cell at91_usart_spi_subdev = {
+	.name = "at91_usart_spi",
+	.of_compatible = "microchip,at91sam9g45-usart-spi",
+};
 
-static struct mfd_cell at91_usart_serial_subdev = {
-		.name = "atmel_usart_serial",
-		.of_compatible = "atmel,at91rm9200-usart-serial",
-	};
+static const struct mfd_cell at91_usart_serial_subdev = {
+	.name = "atmel_usart_serial",
+	.of_compatible = "atmel,at91rm9200-usart-serial",
+};
 
 static int at91_usart_mode_probe(struct platform_device *pdev)
 {
-- 
2.17.1


Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B01C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9621872
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="z9ErIdVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfAaVkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:40:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41780 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfAaVkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:40:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so2064272plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=kLPQZAP8sKNPEi/JN93GiHRxgd2Jho3MJQZztOwRylY=;
        b=z9ErIdVyix7DZl5Nzh8SSLTyRUT3q6vyk/4zKvWlpk7Fl5SEhLIlIIl5hnRDIP8svp
         hpU1SWTeWGkIRo2gK+oNAw9ibUz1uHErbt4aSPSsxUeI/w1am8PlA8Z3k0ti/9aoSBRc
         Q5ar3JE9i7+GFZRA71FNE4CAjFJboXMLnxL7xyJzhPDPSzCnR2WZRrSlDSSpHJ/Zfljm
         NrL4Vnl3mP6hviUjONRoEsyIe3PTu8XoZfyuz03DacQs42cNzfJLV+Za22ZL0SQ/DsZi
         2nqMi3Ov1JpHWxngP/Y7zukK9OjS2DHrLErUOtNVSDwEuVTp6tCbCb6XvGZTQriwlUNK
         Xopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kLPQZAP8sKNPEi/JN93GiHRxgd2Jho3MJQZztOwRylY=;
        b=mscByoBqOln9iMgbE5qclPjEDHpzkbMEMOgyidKU++TqDkIus1lJ6BRDj37KaBJL2j
         4aF1Ch7tFweJkGC8QyIcQ1pvDezuqISXhMMEAI4mJH5vYSDGaRsD9xaTsqbCpvj2BVTV
         efGlq9O23lJ+UZ3ak1bQvL12Q+63wG1EtrUCuewXp9lg1BKWePU2rufNYPG6iKOeyx42
         mVNCjVAVB4OA5maCN9rARAF0jV5WLzRlrJiBLh4Kd6bieykAVnsLVGEeBSLSmVGTevSG
         vigq66MQDlHI6Fsl8OM9MiCs7wK2+9HdjaVjT63wd8zHd+A9ePvi7nQmfj0dxPQIS4Mb
         IBaw==
X-Gm-Message-State: AJcUukcwY0VZA4htiY/6pBV4Gr8fb6T8zMdem5zcZayNFiCS4M7MChbz
        Xs/Bll1XCk8l1j1nO65TxROpeQ==
X-Google-Smtp-Source: ALg8bN75qUUcpT7m1NKgdVllNdkzDsj305svI+DIIaH730iYwO9IlGmcA7e8WrdcF7NlXoqwbTCY5w==
X-Received: by 2002:a17:902:680f:: with SMTP id h15mr35953809plk.40.1548970818787;
        Thu, 31 Jan 2019 13:40:18 -0800 (PST)
Received: from localhost.localdomain (cpe-76-176-152-96.san.res.rr.com. [76.176.152.96])
        by smtp.gmail.com with ESMTPSA id 78sm7313495pft.184.2019.01.31.13.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:40:17 -0800 (PST)
From:   alex.williams@ettus.com
To:     mical.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alex Williams <alex.williams@ni.com>
Subject: [PATCH] i2c: cadence: Handle transfer_size rollover
Date:   Thu, 31 Jan 2019 13:39:57 -0800
Message-Id: <20190131213957.11568-1-alex.williams@ettus.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williams <alex.williams@ni.com>

Under certain conditions, Cadence's I2C controller's transfer_size
register will roll over and generate invalid read transactions. Before
this change, the ISR relied solely on the RXDV bit to determine when to
write more data to the user's buffer. The invalid read data would cause
overruns, smashing stacks and worse.

This change stops the buffer writes to the requested boundary and
reports the error. The controller will be reset so normal transactions
may resume.

Signed-off-by: Alex Williams <alex.williams@ni.com>
---
 drivers/i2c/busses/i2c-cadence.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..64e1d9e888c3 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -213,6 +213,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 
 	isr_status = cdns_i2c_readreg(CDNS_I2C_ISR_OFFSET);
 	cdns_i2c_writereg(isr_status, CDNS_I2C_ISR_OFFSET);
+	id->err_status = 0;
 
 	/* Handling nack and arbitration lost interrupt */
 	if (isr_status & (CDNS_I2C_IXR_NACK | CDNS_I2C_IXR_ARB_LOST)) {
@@ -246,10 +247,17 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 			    !id->bus_hold_flag)
 				cdns_i2c_clear_bus_hold(id);
 
-			*(id->p_recv_buf)++ =
-				cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
-			id->recv_count--;
-			id->curr_recv_count--;
+			if (id->recv_count > 0) {
+				*(id->p_recv_buf)++ =
+					cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
+				id->recv_count--;
+				id->curr_recv_count--;
+			} else {
+				dev_err(id->adap.dev.parent,
+					"xfer_size reg rollover. xfer aborted!\n");
+				id->err_status |= CDNS_I2C_IXR_TO;
+				break;
+			}
 
 			if (cdns_is_holdquirk(id, hold_quirk))
 				break;
@@ -347,7 +355,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	}
 
 	/* Update the status for errors */
-	id->err_status = isr_status & CDNS_I2C_IXR_ERR_INTR_MASK;
+	id->err_status |= isr_status & CDNS_I2C_IXR_ERR_INTR_MASK;
 	if (id->err_status)
 		status = IRQ_HANDLED;
 
-- 
2.14.5


Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60044C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D31F21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAyZX/oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D31F21DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeHIO44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:56:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36206 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:56:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so4361236lji.3;
        Thu, 09 Aug 2018 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYMQHpS+ulHgNDarFwwOWWUU4uU/OhY5KlvyT7xGUR4=;
        b=lAyZX/oeCxE3CmWHSDk5Pq7ooJc6ScGzYAR76QV6HPvfSK8qpCp3jkgJjvvlwJ3YO+
         1sxYl8Pq6McO39uOPf8qbKUUYAe+mo1fUddVOmarsQmfbY/1zgG6krvDLs5s1oW0iL5w
         YxC92ujr5j3oi/QLW7y1mbL++Arg6rRg/0bhti+M0TtruZ2QRZXMIrWB8NV08R+bzSw/
         lB1xh+TS1PK7K2t+Y3fbWcO11WETMR1rtXPoJQ9Ry+K5HTTKSxlRakmG0uDGYzSq8uRi
         cnL4nhertO4bFpa0mSkOm8pY3l2WNn7+TxsiL/OArtQaopcFyeR4gbqTtLpX4WA7D0sX
         +nJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zYMQHpS+ulHgNDarFwwOWWUU4uU/OhY5KlvyT7xGUR4=;
        b=K4Exsn5gCGIY7iijj7QQYuJZNHYQl7d6gLSz5jt5x1+sGSzw9V4ELfW6qXm6P0ZbMI
         QXYsjMwnzsLTAXWi27d/4KnfBDShN3RZbBSqaWNg2dh/+lAnNq6aULvCvsWgGEz3Hm9b
         rNE2kETHCAuPia3goGqateMOfxt81QyJkEH9D7iiG1JYwRKHiJwcBXmANfXOUCMWtcGF
         XwF+8YXEWt6Eguj3fcQ9LgQ/y/R33sADaylMLE2Ep3ziDTUSEo8M5tGgqDebBoNAJmwg
         hjsbXaNFZBaTkfNDEvkLmkw2uGqU+MYKtpKd7qeh0FTIhxOQiThQe6YgeN+hBQpC8ZEB
         NkLQ==
X-Gm-Message-State: AOUpUlF2QEYb2a9zpG2SrGeFZT1ykZAHQJYUSgmwEIXPcbVs9Kf6H3XA
        WmY+vlxfF1pY0RTNAgGfBm9IGf6jO6w=
X-Google-Smtp-Source: AA+uWPx8MUUMzi+fKVaITDJlMyx8YU/FQGWrYHlb33hT31hHh6BQhQKZPHWIohEakyGWJr4k0qf8gw==
X-Received: by 2002:a2e:63c5:: with SMTP id s66-v6mr1635956lje.23.1533817933001;
        Thu, 09 Aug 2018 05:32:13 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id b141-v6sm1351698lfb.6.2018.08.09.05.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 05:32:12 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>,
        Wei Jinhua <wei.jinhua1@zte.com.cn>,
        Phil Reid <preid@electromag.com.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] i2c: imx: Fix race condition in dma read
Date:   Thu,  9 Aug 2018 14:32:05 +0200
Message-Id: <20180809123207.9732-2-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809123207.9732-1-esben.haabendal@gmail.com>
References: <20180809123207.9732-1-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

This fixes a race condition, where the DMAEN bit ends up being set after
I2C slave has transmitted a byte following the dummy read.  When that
happens, an interrupt is generated instead, and no DMA request is generated
to kickstart the DMA read, and a timeout happens after DMA_TIMEOUT (1 sec).

Fixed by setting the DMAEN bit before the dummy read.

Signed-off-by: Esben Haabendal <eha@deif.com>
---
 drivers/i2c/busses/i2c-imx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 498c5e891649..f7bd6c21da27 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -668,9 +668,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 	struct imx_i2c_dma *dma = i2c_imx->dma;
 	struct device *dev = &i2c_imx->adapter.dev;
 
-	temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
-	temp |= I2CR_DMAEN;
-	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 
 	dma->chan_using = dma->chan_rx;
 	dma->dma_transfer_dir = DMA_DEV_TO_MEM;
@@ -809,6 +806,8 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	 */
 	if ((msgs->len - 1) || block_data)
 		temp &= ~I2CR_TXAK;
+	if (i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data)
+		temp |= I2CR_DMAEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
 
-- 
2.18.0


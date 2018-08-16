Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F73F20C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJEcDQMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F73F20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbeHPLkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:40:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34814 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbeHPLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:40:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id f8-v6so3038422ljk.1;
        Thu, 16 Aug 2018 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eULjIfRmfvgXeIC3+Ipz8mXH88k4V94uDRkFqE1MVvw=;
        b=rJEcDQMi3nbawq53SJ2NlW4hcqJiYYIZAFFALlPF19q0DLZRORDUtTJiPKjEg6QJuR
         70Lq6tiqxeC26Ovmqo2HCdR8dPW3ZXbWxpNv4KJS7dJm/BU1DQSQincbjWdwMDrWX+BH
         IDXo3xRH8JmhYohU8d9yIJDJIIoTSs/SrtV5um+ZsNLeQJ611mTV1wpj4WXPpZUqE9le
         tVOIlQ08xbWOI0J3VfUGKvb0moNlqXqHFu0/Yg3l4e629CT+yrTYApQDk4OMU7RF+ffb
         apwKn99ZwdixJxjQtEcroy47pRO7EyRTEe+pR/V7vYjXvCqogb5EOtrzdnsvEkKC5cDJ
         n8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eULjIfRmfvgXeIC3+Ipz8mXH88k4V94uDRkFqE1MVvw=;
        b=kh4clPyppo70gsBS2f0GRnUlXhcoFHDB2lSa/Q2Pm9Be6FdfTQ7W+qDDzJjlcQ2Pd9
         +G7kbEB3mO053qJHMX73MhHLr9thjmlgw24apBpbMWKbNz9B1SEVffnHIt9KuE4yZ+h3
         yIOKOL7zRiKqMkw2jfb+vuadw6BCRMlvDNjWuPnuoXPUBSBwXGjAoqdnFORa7hYAcn1R
         gy+GACgZfy0O5Mv0CFjYfG/ST/R/fpt4H+iSFFszQgLX6wPgv5fMkn0PX4kBR/xZonA6
         Azz6icQ59VoQTzCjG2XX79oKShsVmKsQdU+XT6hQZHyxM+QUwtptg7zk0uj3OZ8G3Ks0
         JnYw==
X-Gm-Message-State: AOUpUlGmx7u0vjygsih/zoHzP/HYfvXUKyo6kdfKdq1XmSkJAwZ/sKFf
        gj4jLUobmxYf5XDpJUaYEk8LFoky
X-Google-Smtp-Source: AA+uWPwgA/zUvZ0De37fvmffwfH5+aaCYB1i8bMXt5oVj/1Dv1TFdygH6JF93nIpM7egn2MUuQ1qDg==
X-Received: by 2002:a2e:8185:: with SMTP id e5-v6mr21625135ljg.93.1534409003936;
        Thu, 16 Aug 2018 01:43:23 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id j64-v6sm4946269lfe.56.2018.08.16.01.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 01:43:23 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] i2c: imx: Fix race condition in dma read
Date:   Thu, 16 Aug 2018 10:43:12 +0200
Message-Id: <20180816084315.7857-2-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816084315.7857-1-esben.haabendal@gmail.com>
References: <20180816084315.7857-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 498c5e891649..ad6adefb64da 100644
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
@@ -783,6 +780,7 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	int i, result;
 	unsigned int temp;
 	int block_data = msgs->flags & I2C_M_RECV_LEN;
+	int use_dma = i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data;
 
 	dev_dbg(&i2c_imx->adapter.dev,
 		"<%s> write slave address: addr=0x%x\n",
@@ -809,12 +807,14 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	 */
 	if ((msgs->len - 1) || block_data)
 		temp &= ~I2CR_TXAK;
+	if (use_dma)
+		temp |= I2CR_DMAEN;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
 
-	if (i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data)
+	if (use_dma)
 		return i2c_imx_dma_read(i2c_imx, msgs, is_lastmsg);
 
 	/* read data */
-- 
2.18.0


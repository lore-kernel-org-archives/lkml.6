Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB948C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CAE720C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUn22XEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAE720C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390120AbeHPLk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:40:28 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39922 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbeHPLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:40:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so3018674lji.6;
        Thu, 16 Aug 2018 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4AeQDWslNHt0UI/9pnw6Q8K1DyjjLvo8oOGG+LiX3o=;
        b=XUn22XEL5/N+56LYa1JntDtHbqrueUirtzwnrYErD2JlOaMqHuH46zkAVIM11FfO9y
         5EjTDgZeo0yDdUjuCYaab7ZpnwXgpBVQnP9M+5e9+FO+BMCwvc64tmT31n8SWDuiciHg
         4LpolBHppMD1Mt82N9kPHkOFL+EtgM38yslktomG2SGBfnhyOOxNIn3vyb2rxLyQxsw0
         WoXz5/9dKLgd86WLWQVBnXa36Tl3a0/gIy74E3r6oyZBkZAwEhlBYMCEOwmStCnT73IU
         FaD2vRvNw5Fkq0qdnuuIg/PtJeyGs+1QKUGcjuuBB01OU/sYIlqmnGML20XXp5TyMz8O
         yucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w4AeQDWslNHt0UI/9pnw6Q8K1DyjjLvo8oOGG+LiX3o=;
        b=Wu8cCIFR47WAjuLBjFAFEpq+p7POEe0P9kU5tZyVIel8GF3IADbczPwRAknJUmxHfS
         QHIoHPQK5Ic/GwaqSgApb6IpShiPBE1V71TSTgzgeR93U67/4LnKmlw3luDu/w9eLVQq
         lgD2pOLOwuoIf5H/2fUJeuYfLEcvVXFPFI/gun1ItWe6QdCzJtzZ+BsCuQO5MAjwxlrX
         VSYeMOV4honHtagp8Dlzxj54rfHUZMzECijxbAl6fi61NP/UTWLJ7zDcpm16H2+qxdCM
         c+xSlzYuloBNNDnfPrurCcWKeY50+2XQVsNujvoZUPmLk1i1NDX807UB/cqv7gCPrTdA
         ZB1A==
X-Gm-Message-State: AOUpUlGh3+wY1/ePdl147/iRdBSvkOH93556FQ+8DYoYVghfxkJ/MtkG
        aB1ERm+Zn28pJRdowS+IcCa32UyE
X-Google-Smtp-Source: AA+uWPw/6bF87NLmI6uelkfpRaCQWFzlgaqQ6w+RhezoxloALvazrsZpZm5zYpNwoS6occUSJrHfbg==
X-Received: by 2002:a2e:4d9d:: with SMTP id c29-v6mr19701265ljd.132.1534409006669;
        Thu, 16 Aug 2018 01:43:26 -0700 (PDT)
Received: from localhost ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id d13-v6sm4847738lfi.74.2018.08.16.01.43.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 01:43:26 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Esben Haabendal <eha@deif.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phil Reid <preid@electromag.com.au>,
        Peter Rosin <peda@axentia.se>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] i2c: imx: Simplify stopped state tracking
Date:   Thu, 16 Aug 2018 10:43:13 +0200
Message-Id: <20180816084315.7857-3-esben.haabendal@gmail.com>
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

Always update the stopped state when busy status have been checked.
This is identical to what was done before, with the exception of error
handling.
Without this change, some errors cause the stopped state to be left in
incorrect state in i2c_imx_stop(), i2c_imx_dma_read(), i2c_imx_read() and
i2c_imx_xfer().

Signed-off-by: Esben Haabendal <eha@deif.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ad6adefb64da..c406700789e1 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -421,10 +421,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i2c_imx, int for_busy)
 			return -EAGAIN;
 		}
 
-		if (for_busy && (temp & I2SR_IBB))
+		if (for_busy && (temp & I2SR_IBB)) {
+			i2c_imx->stopped = 0;
 			break;
-		if (!for_busy && !(temp & I2SR_IBB))
+		}
+		if (!for_busy && !(temp & I2SR_IBB)) {
+			i2c_imx->stopped = 1;
 			break;
+		}
 		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
 			dev_dbg(&i2c_imx->adapter.dev,
 				"<%s> I2C bus is busy\n", __func__);
@@ -538,7 +542,6 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_imx)
 	result = i2c_imx_bus_busy(i2c_imx, 1);
 	if (result)
 		return result;
-	i2c_imx->stopped = 0;
 
 	temp |= I2CR_IIEN | I2CR_MTX | I2CR_TXAK;
 	temp &= ~I2CR_DMAEN;
@@ -567,10 +570,8 @@ static void i2c_imx_stop(struct imx_i2c_struct *i2c_imx)
 		udelay(i2c_imx->disable_delay);
 	}
 
-	if (!i2c_imx->stopped) {
+	if (!i2c_imx->stopped)
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
-	}
 
 	/* Disable I2C controller */
 	temp = i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
@@ -724,7 +725,6 @@ static int i2c_imx_dma_read(struct imx_i2c_struct *i2c_imx,
 		temp &= ~(I2CR_MSTA | I2CR_MTX);
 		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 		i2c_imx_bus_busy(i2c_imx, 0);
-		i2c_imx->stopped = 1;
 	} else {
 		/*
 		 * For i2c master receiver repeat restart operation like:
@@ -850,7 +850,6 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 				temp &= ~(I2CR_MSTA | I2CR_MTX);
 				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
 				i2c_imx_bus_busy(i2c_imx, 0);
-				i2c_imx->stopped = 1;
 			} else {
 				/*
 				 * For i2c master receiver repeat restart operation like:
-- 
2.18.0


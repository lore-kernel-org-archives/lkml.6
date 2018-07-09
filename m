Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E2FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F0820854
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abi80z4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F0820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGIJnW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:43:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43943 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754405AbeGIJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:43:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id r13-v6so13587398ljg.10;
        Mon, 09 Jul 2018 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KoC99XQjYMvYaeFlk1wVGqBun0Bm6WwvjfwbDmoYkF8=;
        b=abi80z4zuLEZR1FqD25bFzz3m29Z5cWuqrq12SSooGE/+l7sGFR6wuDV4q/l+2/uiI
         EIOwcu/Su7eOUVSDgpaN9KMJwccelmvx5Os43KG69viR4Fq+V3olFOnV/gwOk3cMfE9B
         Rc4B2JQYHZvALYRE9wn6wjOvJjWKV3/4DGe02TvSyWygHUggKTfaaQ30NZV7RfSp0EDq
         WAlXOzYjcCQgv3woJj18s4nSRdjfrV+37n/s/U3q7n1eu7AqexmoyZJ+VGitrehPb6Vb
         ruuvessCfXpJKjCt3tpyb4hWO3AnqWzKErtLOlHzfHajBjQPXFGtQhA7j2fcRY8J/gq4
         4mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=KoC99XQjYMvYaeFlk1wVGqBun0Bm6WwvjfwbDmoYkF8=;
        b=AxXEYKyC2KPXlzrtwfTU1MZVB+wDufCgS+3eAQGpXWVzLfCv9Lw98+N8Q3HaBONaap
         g5UsEdIFSrEp3fjD5b+a5FqUNL/tw6oAGrN+m6Lxzg0XpaE5giPQLRC09m+CBrhbXieF
         btsRiTNLPO2IurUpwetyaLinkLB4DG19wDdCQ8IWKrtVszxVZagCNnh8tVf9peOav3f6
         abvhwMC7PBiOgK/X4/yVmhi45gbfverNE1asszYlSLPGFTFoD5G+vUUsdW0RRBclyRpq
         6n6sUAcN8JN99N4B22vCsjDbAqyReIiAb3iLyV2jqJvPtL0olfPxsil+4zvJZebzHQZD
         CqHw==
X-Gm-Message-State: APt69E1dQzBH34fFePqx0GageaHvlKVvNV54s3s9Hwj8I2WJbuKky3jV
        JuZFjIxDG79ZJcAW2xVooGcqwoSfYJk=
X-Google-Smtp-Source: AAOMgpfga20h+6xcX96OmzEnrWhQ9fCozSdTWMMXwnbaRvjyVysgUJbKCaYIuj90sq9/fVFODhBxlQ==
X-Received: by 2002:a2e:40c6:: with SMTP id r67-v6mr12632960lje.41.1531129393815;
        Mon, 09 Jul 2018 02:43:13 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id v20-v6sm1496115ljc.94.2018.07.09.02.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 02:43:13 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yuan Yao <yao.yuan@freescale.com>,
        Esben Haabendal <eha@deif.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Phil Reid <preid@electromag.com.au>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] i2c: imx: Fix race condition in dma read
Date:   Mon,  9 Jul 2018 11:43:02 +0200
Message-Id: <20180709094304.8814-3-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709094304.8814-1-esben.haabendal@gmail.com>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
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
 drivers/i2c/busses/i2c-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 39cfd98c7b23..d86f152176a4 100644
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
@@ -810,6 +807,11 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *msgs, bo
 	if ((msgs->len - 1) || block_data)
 		temp &= ~I2CR_TXAK;
 	imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	if (i2c_imx->dma && msgs->len >= DMA_THRESHOLD && !block_data) {
+		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+		temp |= I2CR_DMAEN;
+		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
+	}
 	imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR); /* dummy read */
 
 	dev_dbg(&i2c_imx->adapter.dev, "<%s> read data\n", __func__);
-- 
2.18.0


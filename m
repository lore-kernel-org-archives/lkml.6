Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B781206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXeL45xD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbfAPTw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:52:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42700 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfAPTw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:52:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so8349221wrx.9;
        Wed, 16 Jan 2019 11:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pU5De/zpgHU6ZeUDONuRyzBSjstl6eMJUmrIaCUGIpc=;
        b=PXeL45xDanU5WGmyL91lyrTcHMuYTaEwyTQGTy4ZkokeJ1RisOze0g1oLgMdUWbC48
         Wd0C6G91jHDNcQBSF01O9EOu1Zb4xtsTxVhP/uefJCZZlzBv6pGYCJP6OmEuuIj4Aoo+
         BWonfdDq0Hrk3INDFoLirn7fwbAQrNoY1sIZpKmTBJ/DXyCwSnie7cdm/00+/pIecj2X
         xkPjXZE/4c7n0exMR+Ffm5vrXvTF0NKMUEmboRTtkk+j7yamMF9hNgycb8FQ2cdVcIlN
         ppZFvKK7IPcUoJaERO4qxy5X+/v4MmVCqvUMugkSF2agodC4sEHG4GWd1mXzqX+8lLKn
         o76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=pU5De/zpgHU6ZeUDONuRyzBSjstl6eMJUmrIaCUGIpc=;
        b=p4HeZVed4M1xk+WqXR8MBDb47tXLPsze/x4260nbV1ciHCzPrihGo5PvAzWB2X410A
         hjeyzdoch62twF4AERZSgH2eXMbUsb04jDI3ziHRBrFgH7ku+BjMm/cuG8/onukh+8+r
         b/BAh6P6UvHzDeMF8wICGNhVtdS3ChuNx1EcTJGrnEKtE3kcJbsOo8twAoksunEAtSBr
         /mtHNXwbkd75hyMi3kd/m7ySB65yn4zMaJIVKLJloiwL4VKFhuh5CKEq+xGbVNlKAF1V
         rnSkkmstJOJYxpYw9ODaTxy456QQ6saSeRzpw3xHGPQ79xJI2QGRujSmjYTQ2Tf0VOA6
         jySg==
X-Gm-Message-State: AJcUukcJ08jSE3CHtbajw4Tw9ZBPAYAj90IRe0Q/C+xs8csnlAs349Ya
        1JfDd40JjWWi8OhO3lG3oh2VvgAC
X-Google-Smtp-Source: ALg8bN7U2ER5X2tyriJewNffHvLsu93lUak7QJSM/duNeTKaSB7Ij5+Egtt6Mm0WgSyXj5Mx7u4mqw==
X-Received: by 2002:adf:9205:: with SMTP id 5mr8872160wrj.189.1547668347183;
        Wed, 16 Jan 2019 11:52:27 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id y145sm27699973wmd.30.2019.01.16.11.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:52:26 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 3B3EB11423A3; Wed, 16 Jan 2019 20:52:25 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: Annotate implicit fall through in jz_mmc_irq_worker
Date:   Wed, 16 Jan 2019 20:52:19 +0100
Message-Id: <20190116195219.2897-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1).

This commit removes the following warnings:

  drivers/mmc/host/jz4740_mmc.c:745:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/mmc/host/jz4740_mmc.c:779:3: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mmc/host/jz4740_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 33215d66afa2..a1df8bc0b964 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -743,6 +743,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			break;
 
 		jz_mmc_prepare_data_transfer(host);
+		/* fall through */
 
 	case JZ4740_MMC_STATE_TRANSFER_DATA:
 		if (host->use_dma) {
@@ -777,6 +778,7 @@ static irqreturn_t jz_mmc_irq_worker(int irq, void *devid)
 			break;
 		}
 		jz4740_mmc_write_irq_reg(host, JZ_MMC_IRQ_DATA_TRAN_DONE);
+		/* fall through */
 
 	case JZ4740_MMC_STATE_SEND_STOP:
 		if (!req->stop)
-- 
2.19.2


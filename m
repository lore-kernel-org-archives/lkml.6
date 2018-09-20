Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F95BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1732D21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJDvIfnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1732D21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbeIUE7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:59:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33985 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeIUE7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:59:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id t15so3098686wrx.1;
        Thu, 20 Sep 2018 16:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmtLbbRqubkx46ILsaNOyPfMaB1WUY534ftrb9jooC8=;
        b=aJDvIfnNPeoaLCae8+Gb35Qm2JatqbF7mBPNFanVsLz5LKiaU/mhsdrhO9C7QxqypX
         BacPwU0ziJUIzfPoGgIf+TYI4APM5CWst1SlkhmkTj6txuQolWCkTdKWbDOlRecpXMd4
         58ipdfNv1MTTX9pSjt/7BKN7VyKxe6aMcSZrC2raL3dkLEPsWRHkDcH1h77YHmRnsggs
         UjWw4XKfgZWc6ZYMPvT6FqC2yDXOBF5SL9fal4Q2jYAHuwGF6yUevxHB3W9Y+Kll5BmZ
         YC5zs9sF3RqM9t30KYUcvVgdgTKwqRm4YR/5Yg2UMz3Jpcc647Ra3Iiled+lyw/jdKPN
         q24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RmtLbbRqubkx46ILsaNOyPfMaB1WUY534ftrb9jooC8=;
        b=o/hUASqLjGrqsJXtVqNGmFw4JewlHAVOntwA1fbCWdb0rPftz0FRRRBdwHCBg8inTi
         f1q+2OMyMvlH57snWCjBBNuOooe4iWqzzyjdCK10GLzYVJbbz1W7qTBOqlUC09HcLp4X
         5sIpMF9Umt+RyVAxOGGxbngfI6F1YD8Kpp/ab8AojHVe/xFEcidirzTAszHbu15lkvST
         sgwbUFh+XXhO/1nVQjshwfO10Xvj9sg8ux5cW4f17mCNDGtLyZX1XsYljfbZtaaJiKIE
         4kMZh5y5nO0EpdJD45xZWEJja+ZoK9mMxJmXGkOlxjdhXw+ehTKRT/n8z56b293GPiaL
         kA+A==
X-Gm-Message-State: APzg51C5JtTWyU+QfjPFq6Yyqbp9Jp2HSYWS8iyqGWj3ThOVykF0XfYV
        ff8pU8XyvTkAddd6Q2KHeM8=
X-Google-Smtp-Source: ANB0VdaHF9D2mcQpXNPOq4YxVFHFaCGeD9lxWCbbQbX/fikYSkfLehPEMG5xUQ4c2bILu11Kiu82jw==
X-Received: by 2002:adf:82b4:: with SMTP id 49-v6mr13928690wrc.252.1537485227468;
        Thu, 20 Sep 2018 16:13:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id x204-v6sm3797786wmg.27.2018.09.20.16.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 16:13:46 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] spi: pic32: Use proper enum in dmaengine_prep_slave_rg
Date:   Thu, 20 Sep 2018 16:13:37 -0700
Message-Id: <20180920231337.24603-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is converted implicitly to another:

drivers/spi/spi-pic32.c:323:8: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
                                          DMA_FROM_DEVICE,
                                          ^~~~~~~~~~~~~~~
drivers/spi/spi-pic32.c:333:8: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
                                          DMA_TO_DEVICE,
                                          ^~~~~~~~~~~~~
2 warnings generated.

Use the proper enums from dma_transfer_direction (DMA_FROM_DEVICE =
DMA_DEV_TO_MEM = 2, DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1) to satify Clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/159
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/spi/spi-pic32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 46ff76193ee1..131849adc570 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -320,7 +320,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
 					  xfer->rx_sg.sgl,
 					  xfer->rx_sg.nents,
-					  DMA_FROM_DEVICE,
+					  DMA_DEV_TO_MEM,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx) {
 		ret = -EINVAL;
@@ -330,7 +330,7 @@ static int pic32_spi_dma_transfer(struct pic32_spi *pic32s,
 	desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
 					  xfer->tx_sg.sgl,
 					  xfer->tx_sg.nents,
-					  DMA_TO_DEVICE,
+					  DMA_MEM_TO_DEV,
 					  DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
 		ret = -EINVAL;
-- 
2.19.0


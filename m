Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB2DECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E75206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5IVqiFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E75206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbeIUQSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:18:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37915 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389215AbeIUQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:18:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id j8-v6so8608400wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 03:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UdARNFAJ5ijh3ybSKJa9nmt5Z3EXObF5UVXI5Dvdy0U=;
        b=l5IVqiFVkxNwBH8D6rZ4yW7vQHF2nrHngPB7fBqwU2l2Z2wZ7TzEKBIkoKXX+9eh5x
         8gpxarcftOSGkEWcJhHNwxSncpdKPuhm4k856Bey3h7T0IorgM668Dza+Kiqcib0rZn0
         tpxwWgRO2704hheWRq4UGgwKM+b4XzYmrzOPhFYtUQ4jmlJLgTEIbPvgMEPRljamdQ84
         abttGCgrUchlyi2ZHgDS70KP5TELuvpydOZ1uUYvc6E46oR6pHoDYm0vdE0NUcsRPxSO
         BbZwfn7wyc+Jwv/eIK1+ZvTY58x9veHsCQGASC9GPtaA/BJqN5B7/eJXn9XYNvfcT0ZM
         Yw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UdARNFAJ5ijh3ybSKJa9nmt5Z3EXObF5UVXI5Dvdy0U=;
        b=nStbFiWezH2q+A6MKEjt6qUUBPC8AG4g/S1sJcvlzF8t4/P4+HTHhOjN6Ma4ExFgqP
         Hx22L3tWsbsqvbZcXTnItu5L+4QNC5iHJuUOkbiFIWUQ4fY3aZ9xd+n5P1UTfdRaUW/I
         u2YUAbrwMBSBEbH7h8P4i3CH6WFWgllS2NS5V0UCkibh5sceQ3Pi2DaP+ByjMiFv0mI3
         G9U9YMqGy7+dg81MvXlxJQO1Zogx+VYEMWuOz940UfSmmrsBy1NMyGrC7xdpf1IzYAAd
         HINundv2LdSRxoWvRXMaP5iN33GuyVUxFOodY+d2PXrNevaY7gGBJdQL47Gka8r3PWnU
         K6iQ==
X-Gm-Message-State: ABuFfoh63b2KfRs9xaNUUt+m4Gt7WY7ZtYZQlr35OdBfhdi5Hc3XGmSj
        j2CSKj2zyb50s/v4oPgyTEw=
X-Google-Smtp-Source: ACcGV61KCl9oiWBHDrukWbStlVYAulsJSoOE0BhkZ3EcPb68uSeIPCRbAqz/3E9eKzXC4URsL2sMTg==
X-Received: by 2002:adf:df0f:: with SMTP id y15-v6mr5624919wrl.26.1537525815108;
        Fri, 21 Sep 2018 03:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s2-v6sm31991868wrn.83.2018.09.21.03.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 03:30:14 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mtd: spi-nor: cadence-quadspi: Use proper enum for dma_unmap_single
Date:   Fri, 21 Sep 2018 03:29:45 -0700
Message-Id: <20180921102944.27968-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is converted implicitly to another.

drivers/mtd/spi-nor/cadence-quadspi.c:962:47: warning: implicit
conversion from enumeration type 'enum dma_transfer_direction' to
different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
        dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
./include/linux/dma-mapping.h:428:66: note: expanded from macro
'dma_map_single'
#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
                                   ~~~~~~~~~~~~~~~~~~~~          ^
drivers/mtd/spi-nor/cadence-quadspi.c:997:43: warning: implicit
conversion from enumeration type 'enum dma_transfer_direction' to
different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
./include/linux/dma-mapping.h:429:70: note: expanded from macro
'dma_unmap_single'
#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
                                     ~~~~~~~~~~~~~~~~~~~~~~          ^
2 warnings generated.

Use the proper enums from dma_data_direction to satisfy Clang.

DMA_TO_DEVICE = DMA_MEM_TO_DEV = 1
DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2

Link: https://github.com/ClangBuiltLinux/linux/issues/108
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 8e714fbfa521..d0e57ac81098 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -959,7 +959,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
 		return 0;
 	}
 
-	dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
+	dma_dst = dma_map_single(nor->dev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(nor->dev, dma_dst)) {
 		dev_err(nor->dev, "dma mapping failed\n");
 		return -ENOMEM;
@@ -994,7 +994,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
 	}
 
 err_unmap:
-	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
+	dma_unmap_single(nor->dev, dma_dst, len, DMA_TO_DEVICE);
 
 	return 0;
 }
-- 
2.19.0


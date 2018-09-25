Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2BEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F297C214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOjNXX9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F297C214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbeIYNjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:39:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44992 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeIYNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:39:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so22162655wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AgKsf7PyS3rN5T/qjwIHe3/kYtJ0kT0s83KYOa65QOU=;
        b=pOjNXX9d62cL9hQi+T17VQ8dqEafsYYk2SNtH+qYvzvw3RZX9YeL5D0VpkE681QUGx
         fh3M/U4inpKyZW5vtfXC2kvvnedWLOIeobcEKUC6PsAEyUiUa33T4JSZXYjwSqn3KJUU
         UlF40zpshEn1Gus7k/NUpfEWPIl/TlX0IK9jqB3zstGIQtKZvvUNteyRxR/gT2NyyxlU
         jkkaSk9KT0IpWyseqSdsf+DDpbnMJgDXwOvqcDPJR24xbUHhN0i8F+cQ6HLsFvvb1z+F
         Fn0EHgHBC52PxDZSOKtFRB1fHaaJh9UaSHi88IMhmeCEJ2zcc8RNvUfdmrtiASs/sUVZ
         yp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AgKsf7PyS3rN5T/qjwIHe3/kYtJ0kT0s83KYOa65QOU=;
        b=GiuFPcurEPozG5poS4ziY1/H7RW9AZYU5I1yBjeL50JZBoBMh/oijC0NTRI5kp700q
         0ylXIeveK5nFIDktzz2o9ZIUZ5R3DsIajF8zLa7jPIC/k/SPPb/fnyyyiMs2pHvnshXm
         fiIUj/3NXzhFZp7CIk096lr7CTPPoA9fFLS3PlHF/YeDWGifsWER68us8z2mtexzZvZu
         nxcNxnHDnDP4Lyz8LgSvgXlnO8VwuKZHkONWIu0A38MgIaQKn4LL9gVdZgxaYfPH4Am9
         1tftDYpmYcm9enbVEho1pZdb+vyWEfno+APwTukUfkPwrT1ntBvUbYfQE6aoXq9vn4Iu
         dYMg==
X-Gm-Message-State: ABuFfojY0t82RD8sKRf38/nx/HE5IkUM2GHqZnLGWxj8TrJVtipd/a1J
        27zAse1NSHkTnL3S87fORASN5yYy4n1cjg==
X-Google-Smtp-Source: ACcGV62K3tGKEkrad34EbPC11/GIxctvZoUwea9efixJZ5bSynT4BBpp59Rqio/lGSrXPBWKj3yWIA==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr1683565wrg.230.1537860812112;
        Tue, 25 Sep 2018 00:33:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y206-v6sm1212295wmg.14.2018.09.25.00.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 00:33:31 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] mtd: spi-nor: cadence-quadspi: Use proper enum for dma_unmap_single
Date:   Tue, 25 Sep 2018 00:32:03 -0700
Message-Id: <20180925073202.23945-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921102944.27968-1-natechancellor@gmail.com>
References: <20180921102944.27968-1-natechancellor@gmail.com>
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

DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2

Link: https://github.com/ClangBuiltLinux/linux/issues/108
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix second half of patch (previously incorrectly used DMA_TO_DEVICE),
  thanks to Tudor Ambarus for catching this.

 drivers/mtd/spi-nor/cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 8e714fbfa521..e24db817154e 100644
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
+	dma_unmap_single(nor->dev, dma_dst, len, DMA_FROM_DEVICE);
 
 	return 0;
 }
-- 
2.19.0


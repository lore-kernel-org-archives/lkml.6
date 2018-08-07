Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B38C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA10214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AHpGt3Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA10214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390497AbeHGV53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:57:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42745 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389192AbeHGV52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:57:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id y4-v6so8301143pgp.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=cJYdTOP/lqwDsHAxF8UDrfGAeqPoLuDCk7YQyzrU52s=;
        b=AHpGt3AhilFWVhJNdg18KKB3HXOqkXc1wFe1lY42UeCFUuovGCSsDMzDMulovCt79g
         C/BPFKXTRey/1anJnuAzM5Q6OsSLgnrJXJM77WYDv7ZQLBhZXShaM8FJ6KAQi1qjVmER
         FWMdwG2NDcLAIEOjxf/uD51SmxoIjxCIFPbnNa62Ruk/2oPrJ2kcSP2+vxUvnBqOSTc8
         pcIETcvOeXLlHTqBNgAcDU4AqBf9gDIdmAKfuBS2tIxBfzj2NX1z2cK0COIsOmJrbs2P
         c2iB2p4lZO7uvz7T90udRvBFxeQceFWkklgGc1Rklb5nOySXs+k42KmM3oefLXsm1BaB
         LXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=cJYdTOP/lqwDsHAxF8UDrfGAeqPoLuDCk7YQyzrU52s=;
        b=WZ2XEEP6g5+yA/yqmZTOMdAG8cV8LPTNsrq6d1r6p/+lXeN2BIUgfjt3N3H87uhhk9
         WHls1uJ+XZQupHpzsRtskW8cHusGKdchVczs8K39V7Ea0CYTlIqp+vnYmhriunQ+MGXy
         Oc6kqLK3li1736TSN5Nq7wvPjNeCcHU/5uW13Pp7jhAplJRGtkB3fRHZxrLetnDbIxwA
         iAEmHUHYlkbdiRplWcqFHMH2M93SOacRMwWb5aO457vJWOuCwPqVwz4+mLyzo24Lsmwc
         x6b6uhL5UYhAXWSNS5X/B2dUZsZFQyR0qoILDA43LDstLyGzLCEUolu2wJpKu+FpadYE
         +TdQ==
X-Gm-Message-State: AOUpUlGeJAVdrfbv+u82mFmIGm+E5o8gZ4To+HvKPVFvk+cVvZKXFews
        WqtVi2IQld8HYEFQ1AD6Gy/+sw==
X-Google-Smtp-Source: AAOMgpeZPLkVdWoHsLaB9Dqnq+CCdP2fNVpefWeZL2hcLF6Q2Ya/0gGckuRQtP088ltM5qEC+Hx7tg==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr23301211pfm.254.1533670893342;
        Tue, 07 Aug 2018 12:41:33 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s184-v6sm3451747pfb.56.2018.08.07.12.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 12:41:32 -0700 (PDT)
Subject: [PATCH v2 2/2] spi-nor: add support for is25wp256
Date:   Tue,  7 Aug 2018 12:40:59 -0700
Message-Id: <20180807194059.26348-3-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180807194059.26348-1-palmer@sifive.com>
References: <20180807194059.26348-1-palmer@sifive.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     marek.vasut@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

This is used of the HiFive Unleashed development board, and follows the
pattern of similar ISSI devices already listed.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index aab93463a5e7..f10017b4543d 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1072,6 +1072,8 @@ static const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "is25wp256",  INFO(0x9d7019, 0, 64 * 1024, 512,
+	                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
-- 
2.16.4


Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E7FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CA621533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CA621533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeI0EXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:23:08 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33918 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeI0EXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:23:06 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LBrx3TJGz1qwfC;
        Thu, 27 Sep 2018 00:08:01 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LBrx1P0Vz1qqkx;
        Thu, 27 Sep 2018 00:08:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fFBveWxGRQwl; Thu, 27 Sep 2018 00:07:59 +0200 (CEST)
X-Auth-Info: 4fuGYoV94tzqyna2Ua0QR59XuKTyhqaAwGevCIYuzi8=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Sep 2018 00:07:59 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 1/9] Revert "mtd: fsl-quadspi: Rename SEQID_QUAD_READ to SEQID_READ"
Date:   Thu, 27 Sep 2018 00:07:31 +0200
Message-Id: <20180926220739.620-2-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9b2a34906c917e6dacfa08f2eafa5beb8baff5e1, as
it is misleading to have READ_QSPI only when we do plan to use
READ_DUAL_QSPI.

Lets bring back the old naming (explicitly showing the QUAD operation).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 7d9620c7ff6c..f67f3fa5b9c9 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -193,7 +193,7 @@
 #define QUADSPI_LUT_NUM		64
 
 /* SEQID -- we can have 16 seqids at most. */
-#define SEQID_READ		0
+#define SEQID_QUAD_READ		0
 #define SEQID_WREN		1
 #define SEQID_WRDI		2
 #define SEQID_RDSR		3
@@ -396,8 +396,8 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
 	for (i = 0; i < QUADSPI_LUT_NUM; i++)
 		qspi_writel(q, 0, base + QUADSPI_LUT_BASE + i * 4);
 
-	/* Read */
-	lut_base = SEQID_READ * 4;
+	/* Quad Read */
+	lut_base = SEQID_QUAD_READ * 4;
 
 	qspi_writel(q, LUT0(CMD, PAD1, read_op) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
@@ -478,7 +478,7 @@ static int fsl_qspi_get_seqid(struct fsl_qspi *q, u8 cmd)
 {
 	switch (cmd) {
 	case SPINOR_OP_READ_1_1_4:
-		return SEQID_READ;
+		return SEQID_QUAD_READ;
 	case SPINOR_OP_WREN:
 		return SEQID_WREN;
 	case SPINOR_OP_WRDI:
-- 
2.11.0


Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B548B20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 10:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfBBKal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 05:30:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40182 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfBBKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 05:30:40 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gpsZH-00058b-RS; Sat, 02 Feb 2019 10:30:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mvsas: clean up a few indentation issues
Date:   Sat,  2 Feb 2019 10:30:35 +0000
Message-Id: <20190202103035.16043-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few statements that are not indented correctly,
so fix these. Also add empty line between variable declaration and
first statements in functions. Also remove whitespace between *
and mvi_dev to clean up a cppcheck warning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/mvsas/mv_64xx.c | 3 ++-
 drivers/scsi/mvsas/mv_94xx.c | 3 ++-
 drivers/scsi/mvsas/mv_sas.c  | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_64xx.c b/drivers/scsi/mvsas/mv_64xx.c
index b757d389e32f..2c699bc785a8 100644
--- a/drivers/scsi/mvsas/mv_64xx.c
+++ b/drivers/scsi/mvsas/mv_64xx.c
@@ -678,7 +678,8 @@ static u32 mvs_64xx_spi_read_data(struct mvs_info *mvi)
 static void mvs_64xx_spi_write_data(struct mvs_info *mvi, u32 data)
 {
 	void __iomem *regs = mvi->regs_ex;
-	 iow32(SPI_DATA_REG_64XX, data);
+
+	iow32(SPI_DATA_REG_64XX, data);
 }
 
 
diff --git a/drivers/scsi/mvsas/mv_94xx.c b/drivers/scsi/mvsas/mv_94xx.c
index eb5471bc7263..68b5b5f39a03 100644
--- a/drivers/scsi/mvsas/mv_94xx.c
+++ b/drivers/scsi/mvsas/mv_94xx.c
@@ -946,7 +946,8 @@ static u32 mvs_94xx_spi_read_data(struct mvs_info *mvi)
 static void mvs_94xx_spi_write_data(struct mvs_info *mvi, u32 data)
 {
 	void __iomem *regs = mvi->regs_ex - 0x10200;
-	 mw32(SPI_RD_DATA_REG_94XX, data);
+
+	mw32(SPI_RD_DATA_REG_94XX, data);
 }
 
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 311d23c727ce..e205e4057e6f 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -1422,7 +1422,7 @@ int mvs_I_T_nexus_reset(struct domain_device *dev)
 {
 	unsigned long flags;
 	int rc = TMF_RESP_FUNC_FAILED;
-    struct mvs_device * mvi_dev = (struct mvs_device *)dev->lldd_dev;
+	struct mvs_device *mvi_dev = (struct mvs_device *)dev->lldd_dev;
 	struct mvs_info *mvi = mvi_dev->mvi_info;
 
 	if (mvi_dev->dev_status != MVS_DEV_EH)
-- 
2.20.1


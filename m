Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5173BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189BF2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfA2Moi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:44:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50389 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfA2Moi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:44:38 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1goSkf-0003g1-Vd; Tue, 29 Jan 2019 12:44:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mtd: rawnand: meson:: make several functions static
Date:   Tue, 29 Jan 2019 12:44:29 +0000
Message-Id: <20190129124429.19829-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several functions that are local to the source and do
not need to be in global scope, so make them static.

Cleans up sparse warnings.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index b9c543d1054c..9557bd94dcd2 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -829,14 +829,14 @@ static int meson_nfc_read_oob(struct nand_chip *nand, int page)
 	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
 }
 
-bool meson_nfc_is_buffer_dma_safe(const void *buffer)
+static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
 {
 	if (virt_addr_valid(buffer) && (!object_is_on_stack(buffer)))
 		return true;
 	return false;
 }
 
-void *
+static void *
 meson_nand_op_get_dma_safe_input_buf(const struct nand_op_instr *instr)
 {
 	if (WARN_ON(instr->type != NAND_OP_DATA_IN_INSTR))
@@ -848,7 +848,7 @@ meson_nand_op_get_dma_safe_input_buf(const struct nand_op_instr *instr)
 	return kzalloc(instr->ctx.data.len, GFP_KERNEL);
 }
 
-void
+static void
 meson_nand_op_put_dma_safe_input_buf(const struct nand_op_instr *instr,
 				     void *buf)
 {
@@ -863,7 +863,7 @@ meson_nand_op_put_dma_safe_input_buf(const struct nand_op_instr *instr,
 	kfree(buf);
 }
 
-void *
+static void *
 meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
 {
 	if (WARN_ON(instr->type != NAND_OP_DATA_OUT_INSTR))
@@ -876,7 +876,7 @@ meson_nand_op_get_dma_safe_output_buf(const struct nand_op_instr *instr)
 		       instr->ctx.data.len, GFP_KERNEL);
 }
 
-void
+static void
 meson_nand_op_put_dma_safe_output_buf(const struct nand_op_instr *instr,
 				      const void *buf)
 {
-- 
2.19.1


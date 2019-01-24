Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C68FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7A21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 06:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="S1qOoj3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfAXGa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 01:30:28 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:43944 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXGa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 01:30:28 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x0O6TKaX018654;
        Thu, 24 Jan 2019 15:29:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x0O6TKaX018654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548311362;
        bh=6vOJEvoHPKepsdMtkw/i+dJMGPvqRMfQMpRi1AK3Oc8=;
        h=From:To:Cc:Subject:Date:From;
        b=S1qOoj3yWeAlPgUaxMV+zMMewXqTAXQnGA0T6ZbiqkeGdfXoAbcTsSE6FyWgyXU7c
         eS+Pke4RLZl8DHfemiEDRUWYTxd9JfcZjfaZAmQ9WAxTv0Vg5s8LViWfw07UaJYYBI
         A/eZi7kUoF362qayilqHSQttj/17hO8KljlXQ3wrjMAJC+URU7maIFozA3LJD2+Zzh
         fn+/65vf61fSRxCEb7/vRQvj38SEnm9zNMF0GUuXwv19W+kiOtJl8NEPEK6qipBU2t
         4fOhDrkIxohEXKJfMN+t03AVO2uMHSW/bmiprILP/X+zwdjfQgN2uNk0JJuk+KEVCp
         FtfX1sckA/ocQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH] mtd: rawnand: denali: remove unused dma_addr field from denali_nand_info
Date:   Thu, 24 Jan 2019 15:28:57 +0900
Message-Id: <1548311337-16851-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a leftover of commit 997cde2a2220 ("mtd: nand: denali: skip
driver internal bounce buffer when possible").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index 25c0060..c8c2620 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -304,7 +304,6 @@ struct denali_nand_info {
 	u32 irq_status;			/* interrupts that have happened */
 	int irq;
 	void *buf;			/* for syndrome layout conversion */
-	dma_addr_t dma_addr;
 	int dma_avail;			/* can support DMA? */
 	int devs_per_cs;		/* devices connected in parallel */
 	int oob_skip_bytes;		/* number of bytes reserved for BBM */
-- 
2.7.4


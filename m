Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A4EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2B520835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nPz6UzxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2B520835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJCS2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:28:54 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43894 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJCS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:28:54 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w93BdwO1030338;
        Wed, 3 Oct 2018 20:39:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w93BdwO1030338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538566799;
        bh=/uyZP965orBXsSUVlNYy8IRDProLWoRPb2cckclyGKI=;
        h=From:To:Cc:Subject:Date:From;
        b=nPz6UzxZa94yVNkA6ceSKEjBxquqIiKR/G7dHAtWwxqRouwmN/q3Bg+XIq9TYPW8r
         03iOsXT9z+JRFfzLrmPW2xIjRdUy00lvnC427Cm0dc6w+OEZdnQ1nwy+rwgN+b41LW
         k/cGIoUqqWMKQQ6lxoWPldTWjdVQZLEn77xspzu5MZVAMjAjZNprFrx0Rq+XyJpVZ5
         Hih+XFoQq154FLDC9fCl7ZjiacgklGzVMYMqUdcDg8aq/eqijd1Sjbd6TtDM2xNDGS
         Xp5Tfr7iaL2ApauX5TWPuJohewoTFtUkNlU6W1spY4x20szzH7YuphcC8yNWgbW1o+
         0g1Zb6Zq4ZDrg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: renesas_sdhi: rename DTRAN_MODE_BUS_WID_TH to DTRAN_MODE_BUS_WIDTH
Date:   Wed,  3 Oct 2018 20:39:40 +0900
Message-Id: <1538566780-30794-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Socionext UniPhier SoCs use the almost the same internal DMAC.
My datasheet says 'BUS_WIDTH' instead of 'BUS_WID_TH'.  I suspect
this is a typo.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ca0b439..8d04eea 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -36,7 +36,7 @@
 /* DM_CM_DTRAN_MODE */
 #define DTRAN_MODE_CH_NUM_CH0	0	/* "downstream" = for write commands */
 #define DTRAN_MODE_CH_NUM_CH1	BIT(16)	/* "uptream" = for read commands */
-#define DTRAN_MODE_BUS_WID_TH	(BIT(5) | BIT(4))
+#define DTRAN_MODE_BUS_WIDTH	(BIT(5) | BIT(4))
 #define DTRAN_MODE_ADDR_MODE	BIT(0)	/* 1 = Increment address */
 
 /* DM_CM_DTRAN_CTRL */
@@ -174,7 +174,7 @@ renesas_sdhi_internal_dmac_start_dma(struct tmio_mmc_host *host,
 				     struct mmc_data *data)
 {
 	struct scatterlist *sg = host->sg_ptr;
-	u32 dtran_mode = DTRAN_MODE_BUS_WID_TH | DTRAN_MODE_ADDR_MODE;
+	u32 dtran_mode = DTRAN_MODE_BUS_WIDTH | DTRAN_MODE_ADDR_MODE;
 
 	if (!dma_map_sg(&host->pdev->dev, sg, host->sg_len,
 			mmc_get_dma_dir(data)))
-- 
2.7.4


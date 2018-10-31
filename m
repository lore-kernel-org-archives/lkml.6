Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD41ECDE47
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9093820657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5Vn6/mJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9093820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbeJaTzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34106 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaTzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so13214807eds.1;
        Wed, 31 Oct 2018 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7beONks29Yy+z/C0iTikWiGMQ8xLqtPJiOIUqTiRSA=;
        b=q5Vn6/mJ3iR/IbTdpcr4TnJjAgHUu9x7XUWoy64UZhLXNkNfFmcksfRl29B5UTL5dr
         GhXURV+WPFBL95GamF22r2CNoPz0wgnEZUUQn8fcxP/y5IHFwvw+yRlX7QPCUVCc+rpe
         AOptKQqSTH6I4wVgeP5Gctq6dfAU8q+np+kHbUtmBLpy0LwZDLsnm3FsOzQwO3TDMdDa
         QDZKpPbuub4xny+KiIaOGosfrnzSKiOC2mvGDA97dozeeOKtfDz0j/IC1LHrY/z25xCd
         C47UbvWl3ytC5qiWaNLsbGaXxXn0zbuCXAZgZ4meAk2s8s8+1FUU5a2ZlIj0lmB3+aKB
         OiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t7beONks29Yy+z/C0iTikWiGMQ8xLqtPJiOIUqTiRSA=;
        b=LJmpwvEwpDjjscTMv7UpoBmyICotCvcYdGBeLHsmc79BdM5brek0+xM4iLn3KcjaAh
         Ht2RG1loxja8qkvpLvoHe3e9vFgyg+ygWSb/9IudvEargFLgevggGXst9X36cXy09Alg
         /RP/z1q78X4zTxDDjcqpFKCvyxAeqY2XSpv8NZBbwxd0ArFun6NjBpN2VKoC0Og2hU9C
         MqqMVjEmr9OZW+TLWwpDlTpL3xfDH3T4k4I6q2Z5iSCRqEKoBinAfBwwZGapXyt2G3dE
         Bd4up6bQSRVW8pBakKfn1WM86Uy2hO3+Q+wrXO7mhNzYlWqvvJhWt+Jw1VfEOpxSbxf5
         x7nA==
X-Gm-Message-State: AGRZ1gL9WJ3R1RVrU/xBrTRkldgM0XUKiSgW/dKK00kfLhx+b9j0EGWr
        FJu1a5dqxs3YNpUEkGirmjLtxCBIbjo=
X-Google-Smtp-Source: AJdET5cVUGzTlVbNAyaCA09euIl4fEpIJnyJKHncGX+2NhxQthvUvUBpYKALAeBI5qEY+voWIq+zvQ==
X-Received: by 2002:a50:f110:: with SMTP id w16-v6mr1681654edl.0.1540983492264;
        Wed, 31 Oct 2018 03:58:12 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:11 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/14] spi: rockchip: precompute rx sample delay
Date:   Wed, 31 Oct 2018 11:57:08 +0100
Message-Id: <20181031105711.19575-12-esmil@mailme.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181031105711.19575-1-esmil@mailme.dk>
References: <20181031105711.19575-1-esmil@mailme.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Now that we no longer potentially change spi clock
at runtime we can precompute the rx sample delay
at probe time rather than for each transfer.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index d1b3ba2b1532..5fe6099ff366 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -94,6 +94,7 @@
 #define CR0_BHT_8BIT				0x1
 
 #define CR0_RSD_OFFSET				14
+#define CR0_RSD_MAX				0x3
 
 #define CR0_FRF_OFFSET				16
 #define CR0_FRF_SPI					0x0
@@ -179,7 +180,7 @@ struct rockchip_spi {
 	u32 freq;
 
 	u8 n_bytes;
-	u32 rsd_nsecs;
+	u8 rsd;
 
 	const void *tx;
 	const void *tx_end;
@@ -450,13 +451,13 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		bool use_dma)
 {
 	u32 dmacr = 0;
-	int rsd = 0;
 
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
 	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
 	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
 	        | CR0_EM_BIG   << CR0_EM_OFFSET;
 
+	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (rs->n_bytes << CR0_DFS_OFFSET);
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 
@@ -474,20 +475,6 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 			dmacr |= RF_DMA_EN;
 	}
 
-	/* Rx sample delay is expressed in parent clock cycles (max 3) */
-	rsd = DIV_ROUND_CLOSEST(rs->rsd_nsecs * (rs->freq >> 8),
-				1000000000 >> 8);
-	if (!rsd && rs->rsd_nsecs) {
-		pr_warn_once("rockchip-spi: %u Hz are too slow to express %u ns delay\n",
-			     rs->freq, rs->rsd_nsecs);
-	} else if (rsd > 3) {
-		rsd = 3;
-		pr_warn_once("rockchip-spi: %u Hz are too fast to express %u ns delay, clamping at %u ns\n",
-			     rs->freq, rs->rsd_nsecs,
-			     rsd * 1000000000U / rs->freq);
-	}
-	cr0 |= rsd << CR0_RSD_OFFSET;
-
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
 	if (rs->n_bytes == 1)
@@ -620,8 +607,21 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->freq = clk_get_rate(rs->spiclk);
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
-				  &rsd_nsecs))
-		rs->rsd_nsecs = rsd_nsecs;
+				  &rsd_nsecs)) {
+		/* rx sample delay is expressed in parent clock cycles (max 3) */
+		u32 rsd = DIV_ROUND_CLOSEST(rsd_nsecs * (rs->freq >> 8),
+				1000000000 >> 8);
+		if (!rsd) {
+			dev_warn(rs->dev, "%u Hz are too slow to express %u ns delay\n",
+					rs->freq, rsd_nsecs);
+		} else if (rsd > CR0_RSD_MAX) {
+			rsd = CR0_RSD_MAX;
+			dev_warn(rs->dev, "%u Hz are too fast to express %u ns delay, clamping at %u ns\n",
+					rs->freq, rsd_nsecs,
+					CR0_RSD_MAX * 1000000000U / rs->freq);
+		}
+		rs->rsd = rsd;
+	}
 
 	rs->fifo_len = get_fifo_len(rs);
 	if (!rs->fifo_len) {
-- 
2.19.1


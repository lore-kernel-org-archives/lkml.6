Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F274C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD720685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGx3WDoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAD720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbeJaTzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36838 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id x2-v6so13218675eds.3;
        Wed, 31 Oct 2018 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uG/xPakQDGOY9YPMCZ7pYvd1ZBnUY9UsEppY+TSPajo=;
        b=XGx3WDoM4Rk+WhuH9O40Y4RRg8l3d4hd2P97Pj/GzVe1h189uWhlP6j0Y+NO6AABj+
         DPylhXzQuxhMKu8vvp6HsANUxhBzptPwZhSarcm/s+2bzVEcYoc8sGWjmw8pUYf4k0gV
         5WX/wsc6bL1CU7YrosTAHl2iyQyIXiHKngTUO5GugHFx4PFYfyZBzIwevanifmaziUbP
         cVDnu88e+0+zxbvV03VdeQCBTwRoJYgzIwyCEAs7nu03OmKlG8OysHdouI3Z9fvcv8xE
         3kDJ9xM4+w6QQu913Gbk0IGxo183nFECkd4b2FOmnLdaEnopYYvqnDv6CDe7y9tAa4em
         rm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uG/xPakQDGOY9YPMCZ7pYvd1ZBnUY9UsEppY+TSPajo=;
        b=ecAICR9SAxAwhZDUdeOMzLCoY6MyGew/SapoxOhVdQLWC0fK76htMe6Z6rnUZfjH33
         B2a2OZ79V3QMZVJXLgsBGYRzcmQ/rLn13a1oVFgDAaUreMn+X79giDUB1j2FFx0XCz1V
         C0g4oWKpzJXZjsteu1TOzwUAXHr6hxbGfOxPMZR3tI51TIlONQzlbxAwBDYofrllhf+8
         v7No8PF2VPX84QGnG4HTTsdGLL2GSGEMeLVNEelNVdA9CGQW6mDroeSLxHQfW4CfpQHo
         p6uZhMqWAEMZbb93XDvasbIskMitR5m7VokU0a1Z4b60EKqYBSSUTLBiRNZYla4KeYAM
         fF1Q==
X-Gm-Message-State: AGRZ1gIhknWnYwvFYMW9LRoAHkkMwgnoFPUXWD4L1SqtVhCwLx8HCDd1
        RAZabwTE3cK2uigg8kf4OSKIfm+QWRU=
X-Google-Smtp-Source: AJdET5csXFh0pqMdQhcegMeilGEg2H5FFBGjTwlAS9nYeEVuOQPyDKUJ6nxxIefpGHurU40hWPAwZQ==
X-Received: by 2002:a50:86ac:: with SMTP id r41-v6mr1626897eda.186.1540983489826;
        Wed, 31 Oct 2018 03:58:09 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:09 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/14] spi: rockchip: simplify use_dma logic
Date:   Wed, 31 Oct 2018 11:57:06 +0100
Message-Id: <20181031105711.19575-10-esmil@mailme.dk>
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

We only need to know if we're using dma when setting
up the transfer, so just use a local variable for
that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 45a1479c1a29..ba60cbcd45c2 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -184,8 +184,6 @@ struct rockchip_spi {
 	void *rx_end;
 
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
-
-	bool use_dma;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -450,7 +448,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs,
-		struct spi_device *spi, struct spi_transfer *xfer)
+		struct spi_device *spi, struct spi_transfer *xfer,
+		bool use_dma)
 {
 	u32 div = 0;
 	u32 dmacr = 0;
@@ -471,7 +470,7 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 	else
 		cr0 |= CR0_XFM_TO << CR0_XFM_OFFSET;
 
-	if (rs->use_dma) {
+	if (use_dma) {
 		if (xfer->tx_buf)
 			dmacr |= TF_DMA_EN;
 		if (xfer->rx_buf)
@@ -537,6 +536,7 @@ static int rockchip_spi_transfer_one(
 		struct spi_transfer *xfer)
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
+	bool use_dma;
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
 		(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
@@ -559,15 +559,11 @@ static int rockchip_spi_transfer_one(
 	rs->rx = xfer->rx_buf;
 	rs->rx_end = rs->rx + xfer->len;
 
-	/* we need prepare dma before spi was enabled */
-	if (master->can_dma && master->can_dma(master, spi, xfer))
-		rs->use_dma = true;
-	else
-		rs->use_dma = false;
+	use_dma = master->can_dma ? master->can_dma(master, spi, xfer) : false;
 
-	rockchip_spi_config(rs, spi, xfer);
+	rockchip_spi_config(rs, spi, xfer, use_dma);
 
-	if (rs->use_dma)
+	if (use_dma)
 		return rockchip_spi_prepare_dma(rs, master, xfer);
 
 	return rockchip_spi_pio_transfer(rs);
-- 
2.19.1


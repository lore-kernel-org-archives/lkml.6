Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F311C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097320835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxz8jkli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0097320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=esmil.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJJQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:23:14 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33473 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeJJQXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:23:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so4184682ljz.0;
        Wed, 10 Oct 2018 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ePO3J3Hd1Gc2W0qvUwMkU3g/clFK2S8VRj/cGZ2vxiw=;
        b=Wxz8jkliERYElnGwco0K1Yl3iGzfsXj1A1nhCiMSDG2jJDcmROdr+v1l466HUGXA2b
         T2J5pIYfiR6DmIWam1BCK0O86kUSeG6RvwAS125CFjUdu1cmvowqxjjLgsQvnTqgOLUN
         CDQpo3IETcxu1pHstWUkJEGtKHpppn9OZDhDbqKMpFdAMKv8EYE/4wM5AquM7eUed/bX
         VzEJZvQMAkzwRFTo3RQtSw9AtYpqyIj0Q0LTXl7DU93f2R6pTmFCNQJ0GsTh2IyJOKXY
         lQI7wEMi0PEhqvp7Ma/tutMg7mm9lGEijM6KhuhTW4HFGo4bOc6yDKxrYyRHZj6fQLok
         lSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ePO3J3Hd1Gc2W0qvUwMkU3g/clFK2S8VRj/cGZ2vxiw=;
        b=IveI5eHtDhFc9I9GDG6VLGDSp0UfsYRLxw76Toi/WUevFvzIbsJCCZ9sPqA2vS6ya/
         uAojcdnWtAwlXStNUMudxJm+wxZIHC42b720gqnSRzOfhywwGeKY5N8sCN9ccwZIZHDa
         6LWh8Pb1SKIqKnhUT93j7pwpDmERJSa32pvQvulg+9FGQtEOZX9Ru0BRU1nZpRysIVYi
         lD5SSwU+T5Kqz2C8p3PuoTDQKhyBMfRxRFUGa+wMxjGQcZnh6LCx1NXoyFASKLXMebWW
         QFjxJgp40o5b+UEwRyFKHQiOIW2KBD2IwKoUpOP7Iw92H6jv9K8ik4vASO0CtEu8p1Fs
         BtxQ==
X-Gm-Message-State: ABuFfoigoW7xUCsq7BVpSlEtYmVb/BWC3iRmr0lWGKGaZf6sG55qXuTB
        bbj7gt95yDBpzj/RliDnYcc=
X-Google-Smtp-Source: ACcGV61nKTMOfdCLyjWnbZfNQtan8+VXTMd/XDXAk6gvoVrlKz8lXWMJaK4qzuOaDYpiy96WzPnBCg==
X-Received: by 2002:a2e:5c89:: with SMTP id q131-v6mr21223531ljb.119.1539162118533;
        Wed, 10 Oct 2018 02:01:58 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id q2-v6sm2150078lfc.67.2018.10.10.02.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 02:01:57 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-rockchip@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 7/7] spi: rockchip: simplify spi enable logic
Date:   Wed, 10 Oct 2018 11:00:38 +0200
Message-Id: <20181010090038.20834-8-kernel@esmil.dk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181010090038.20834-1-kernel@esmil.dk>
References: <20181010090038.20834-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the dma/non-dma code paths handle the spi enable
flag themselves. This removes some logic to determine
if the flag should be turned on before or after dma
and also don't leave the spi enabled if the dma path
fails.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1044849a352d..51ef632bca52 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -379,6 +379,8 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 {
 	int remain = 0;
 
+	spi_enable_chip(rs, 1);
+
 	do {
 		if (rs->tx) {
 			remain = rs->tx_end - rs->tx;
@@ -501,6 +503,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
+	spi_enable_chip(rs, 1);
+
 	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
 		rs->state |= TXBUSY;
@@ -509,7 +513,8 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
 
-	return 0;
+	/* 1 means the transfer is in progress */
+	return 1;
 }
 
 static void rockchip_spi_config(struct rockchip_spi *rs)
@@ -592,7 +597,6 @@ static int rockchip_spi_transfer_one(
 		struct spi_device *spi,
 		struct spi_transfer *xfer)
 {
-	int ret = 0;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
 	WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
@@ -636,24 +640,10 @@ static int rockchip_spi_transfer_one(
 
 	rockchip_spi_config(rs);
 
-	if (rs->use_dma) {
-		if (rs->tmode == CR0_XFM_RO) {
-			/* rx: dma must be prepared first */
-			ret = rockchip_spi_prepare_dma(rs);
-			spi_enable_chip(rs, 1);
-		} else {
-			/* tx or tr: spi must be enabled first */
-			spi_enable_chip(rs, 1);
-			ret = rockchip_spi_prepare_dma(rs);
-		}
-		/* successful DMA prepare means the transfer is in progress */
-		ret = ret ? ret : 1;
-	} else {
-		spi_enable_chip(rs, 1);
-		ret = rockchip_spi_pio_transfer(rs);
-	}
+	if (rs->use_dma)
+		return rockchip_spi_prepare_dma(rs);
 
-	return ret;
+	return rockchip_spi_pio_transfer(rs);
 }
 
 static bool rockchip_spi_can_dma(struct spi_master *master,
-- 
2.19.1


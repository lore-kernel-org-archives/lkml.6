Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B801ECDE4B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A6220821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIlkk46m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A6220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeJaTzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45633 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbeJaTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:41 -0400
Received: by mail-ed1-f66.google.com with SMTP id t10-v6so13195134eds.12;
        Wed, 31 Oct 2018 03:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkKJd0JSuBqvelUuvT0eKbShB/FPMqJYghXkfCJEjr4=;
        b=rIlkk46mZZYHMXqa5JyiQSYmoyAwd+TSvUC1GqWgLTgGkOrh0PI/gPxwE/3Wu0SlMB
         eXevNM6DfKWiWNtgTEzABoQLfe+A6eB+HrTK9w5ouB29engMP7sno7LG3BHMJ6odbA9p
         RbCJ83IJCQehbhM0oYbL1LmU5O5syZm++0AQDucbZp8TAsgico40Y2coR8hG5W9621eb
         BdKd69N4YPNtJHxJ5bmGP2z0R3/kzgm3t/GUcbxaueLg8hOcmmv4X2QNquXcMG7Fer4b
         M27INnaYc2cbnH7LoDbn55dNv9jrQ/fmQ1jQ7w367Vs6E+NI2c86ujYBiH/SVO5QBX0c
         no4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kkKJd0JSuBqvelUuvT0eKbShB/FPMqJYghXkfCJEjr4=;
        b=lCmnOLUcNfmM4b1dMTky1pmQ8UbmuGOAQsk6CWdwQlXpAXtFPu9ygz2Xfk7hlbwMTI
         cFIIkh6lfngDENvtIMCsBorJLMJfPGWKJtl6N3KZRNjpwmdCXQPdwZaiRQ6LV6D+NDIl
         YfloLbr+EmCHKsL9XTgPUjzlOwTotgR8ZL30iQGoql5Aw5uoD6/vQi1PzREXAG9jzNQW
         ZSzKnU2h8iwn/mRdVfYovUiOpSdQaerlGiepnhXz9jQzRcnTwgD/wIsgiAY3O2EdPqiR
         P7XdmokrEsexHXGlEoF2hXj8SCCNFARi/IXCspZPktotfH0tu7Sgw38j+/tkZ/Gw4twe
         QQ2Q==
X-Gm-Message-State: AGRZ1gJRXWwnioSk+M3L/B0LPiejvlSqd0OOCyB0grAXl9pApSgQmF3n
        FF+DdeZ7JqIcqdk/6/9Lz8CEAzevrtk=
X-Google-Smtp-Source: AJdET5fCYK/Y6ZbFSkJavviOB11WusoCHlzwimmTYstEu+zsletzjKarN8lAR2HOXJT0o6mmQwYNAA==
X-Received: by 2002:a50:b5a6:: with SMTP id a35-v6mr1632145ede.279.1540983483641;
        Wed, 31 Oct 2018 03:58:03 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:02 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/14] spi: rockchip: use atomic_t state
Date:   Wed, 31 Oct 2018 11:57:01 +0100
Message-Id: <20181031105711.19575-5-esmil@mailme.dk>
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

The state field is currently only used to make sure
only the last of the tx and rx dma callbacks issue
an spi_finalize_current_transfer.
Rather than using a spinlock we can get away
with just turning the state field into an atomic_t.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 75 +++++++++++++-------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 7fac4253075e..1c813797f963 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -142,8 +142,9 @@
 #define RF_DMA_EN					(1 << 0)
 #define TF_DMA_EN					(1 << 1)
 
-#define RXBUSY						(1 << 0)
-#define TXBUSY						(1 << 1)
+/* Driver state flags */
+#define RXDMA					(1 << 0)
+#define TXDMA					(1 << 1)
 
 /* sclk_out: spi master internal logic in rk3x can support 50Mhz */
 #define MAX_SCLK_OUT		50000000
@@ -169,6 +170,9 @@ struct rockchip_spi {
 	struct clk *apb_pclk;
 
 	void __iomem *regs;
+
+	atomic_t state;
+
 	/*depth of the FIFO buffer */
 	u32 fifo_len;
 	/* max bus freq supported */
@@ -187,10 +191,6 @@ struct rockchip_spi {
 	void *rx;
 	void *rx_end;
 
-	u32 state;
-	/* protect state */
-	spinlock_t lock;
-
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool use_dma;
@@ -302,28 +302,21 @@ static int rockchip_spi_prepare_message(struct spi_master *master,
 static void rockchip_spi_handle_err(struct spi_master *master,
 				    struct spi_message *msg)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
 	/*
 	 * For DMA mode, we need terminate DMA channel and flush
 	 * fifo for the next transfer if DMA thansfer timeout.
 	 * handle_err() was called by core if transfer failed.
 	 * Maybe it is reasonable for error handling here.
 	 */
-	if (rs->use_dma) {
-		if (rs->state & RXBUSY) {
-			dmaengine_terminate_async(rs->dma_rx.ch);
-			flush_fifo(rs);
-		}
+	if (atomic_read(&rs->state) & TXDMA)
+		dmaengine_terminate_async(rs->dma_tx.ch);
 
-		if (rs->state & TXBUSY)
-			dmaengine_terminate_async(rs->dma_tx.ch);
+	if (atomic_read(&rs->state) & RXDMA) {
+		dmaengine_terminate_async(rs->dma_rx.ch);
+		flush_fifo(rs);
 	}
-
-	spin_unlock_irqrestore(&rs->lock, flags);
 }
 
 static int rockchip_spi_unprepare_message(struct spi_master *master,
@@ -398,48 +391,36 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 
 static void rockchip_spi_dma_rxcb(void *data)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = data;
+	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
-	rs->state &= ~RXBUSY;
-	if (!(rs->state & TXBUSY)) {
-		spi_enable_chip(rs, false);
-		spi_finalize_current_transfer(rs->master);
-	}
+	if (state & TXDMA)
+		return;
 
-	spin_unlock_irqrestore(&rs->lock, flags);
+	spi_enable_chip(rs, false);
+	spi_finalize_current_transfer(rs->master);
 }
 
 static void rockchip_spi_dma_txcb(void *data)
 {
-	unsigned long flags;
 	struct rockchip_spi *rs = data;
+	int state = atomic_fetch_andnot(TXDMA, &rs->state);
+
+	if (state & RXDMA)
+		return;
 
 	/* Wait until the FIFO data completely. */
 	wait_for_idle(rs);
 
-	spin_lock_irqsave(&rs->lock, flags);
-
-	rs->state &= ~TXBUSY;
-	if (!(rs->state & RXBUSY)) {
-		spi_enable_chip(rs, false);
-		spi_finalize_current_transfer(rs->master);
-	}
-
-	spin_unlock_irqrestore(&rs->lock, flags);
+	spi_enable_chip(rs, false);
+	spi_finalize_current_transfer(rs->master);
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 {
-	unsigned long flags;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
-	spin_lock_irqsave(&rs->lock, flags);
-	rs->state &= ~RXBUSY;
-	rs->state &= ~TXBUSY;
-	spin_unlock_irqrestore(&rs->lock, flags);
+	atomic_set(&rs->state, 0);
 
 	rxdesc = NULL;
 	if (rs->rx) {
@@ -490,9 +471,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 
 	/* rx must be started before tx due to spi instinct */
 	if (rxdesc) {
-		spin_lock_irqsave(&rs->lock, flags);
-		rs->state |= RXBUSY;
-		spin_unlock_irqrestore(&rs->lock, flags);
+		atomic_or(RXDMA, &rs->state);
 		dmaengine_submit(rxdesc);
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
@@ -500,9 +479,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	spi_enable_chip(rs, true);
 
 	if (txdesc) {
-		spin_lock_irqsave(&rs->lock, flags);
-		rs->state |= TXBUSY;
-		spin_unlock_irqrestore(&rs->lock, flags);
+		atomic_or(TXDMA, &rs->state);
 		dmaengine_submit(txdesc);
 		dma_async_issue_pending(rs->dma_tx.ch);
 	}
@@ -716,8 +693,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_spiclk;
 	}
 
-	spin_lock_init(&rs->lock);
-
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-- 
2.19.1


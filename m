Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B3C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EA821A36
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvuHQzBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02EA821A36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeHFVCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:02:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37587 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHFVCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:02:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id n7-v6so6622726pgq.4;
        Mon, 06 Aug 2018 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2K9oR+IT0DFn8RxYtisNE4LnDAHi2eqcOZQEyff6D0Y=;
        b=qvuHQzBmwLghrTzTNDc7jz7HBuVh0D/Pif4SEgN3rQ7G+JfydimYJklkvI+wM1MKC2
         4RQiWOlyvQVlAQmzabxV3sF875HBso85pgOr4EJuq3GL/dLH2UP+aaAganEx85JQFKLy
         GMlfEqAc4gpr29LHG6g7ksViDf4cqtRRI3H2Lp6XNJ9bdELe6PtTAjvVfGv6nNsHo8F6
         JeeKVT2QZta1636sh2+TnhoPdx4T0Jb/FEJypHoVimoEKk89utwnSXIZZSIwscR7+mkO
         61bf7yQ8ufrVxqHq7DhCm4i0uRwd0g6S9KlBl+te+FsdiiFs2aQaLi9FABiNDnvseBrw
         m7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2K9oR+IT0DFn8RxYtisNE4LnDAHi2eqcOZQEyff6D0Y=;
        b=IUouQXGQTL0nYoaONaf2GUXjvpyBs0Fjnso7lkHho/+EiK9JRLTyDQt8wSKxM1dmUQ
         hX/axQNpJ1eVO/e4woTuWxKW8E8JkV42CXjs1QKiZnx5FdvwOzqxy9pyDzklZMKBbmcZ
         xdLpowr1XtzvKXAo0G5PsYQ+uqPvrhGWkEowTIGMVw+Vbh15UiwX7yc3/sUqxVgxLtaX
         t02xuRukNuyYkKqy9L0G87QMdgCVHEr29W7U2lQCDkVDRUSbDbiuSj4VlSVMS0plS40d
         ywiMMXu9a3Ay4BvljtHx5i6SwlujRQ2sSAAK8M8/o3+h2n5SLOh5vfmGljhfGCEN9wIx
         YxFw==
X-Gm-Message-State: AOUpUlGXgl880xDeRnZplnGGtx8JYdnud/8FzFdrstme925o9K05RXPo
        OzQy0OA5zHhjC4HP+uJNQf0=
X-Google-Smtp-Source: AAOMgpeluUGzG/Nm7mlhBpKUBvqHAxzcrKani4McW3nvtvGvyajiYQPnQEWpEvJ5e3V8vpM5LvyIeQ==
X-Received: by 2002:a63:d74f:: with SMTP id w15-v6mr15737009pgi.306.1533581532226;
        Mon, 06 Aug 2018 11:52:12 -0700 (PDT)
Received: from kostamach.yok.int.mrv.com (194-90-138-234.bb.netvision.net.il. [194.90.138.234])
        by smtp.gmail.com with ESMTPSA id h18-v6sm15996726pfa.173.2018.08.06.11.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 11:52:11 -0700 (PDT)
From:   Kosta Zertsekel <zertsekel@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kosta Zertsekel <zertsekel@gmail.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: [PATCH] spi: orion: cosmetics - alias long direct_access variables
Date:   Mon,  6 Aug 2018 21:51:58 +0300
Message-Id: <20180806185158.2382-1-zertsekel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change increases the source code readability.
Instead of using `spi->child[cs].direct_access.XXX` use `dacc->XXX`.
Instead of using `orion_spi->child[cs].direct_access.vaddr` use `vaddr`.

Signed-off-by: Kosta Zertsekel <zertsekel@gmail.com>
---
 drivers/spi/spi-orion.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index d01a6adc726e..1d6272fe5a34 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -430,6 +430,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	int word_len;
 	struct orion_spi *orion_spi;
 	int cs = spi->chip_select;
+	void __iomem *vaddr;
 
 	word_len = spi->bits_per_word;
 	count = xfer->len;
@@ -440,8 +441,9 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	 * Use SPI direct write mode if base address is available. Otherwise
 	 * fall back to PIO mode for this transfer.
 	 */
-	if ((orion_spi->child[cs].direct_access.vaddr) && (xfer->tx_buf) &&
-	    (word_len == 8)) {
+	vaddr = orion_spi->child[cs].direct_access.vaddr;
+
+	if (vaddr && xfer->tx_buf && word_len == 8) {
 		unsigned int cnt = count / 4;
 		unsigned int rem = count % 4;
 
@@ -449,13 +451,11 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 		 * Send the TX-data to the SPI device via the direct
 		 * mapped address window
 		 */
-		iowrite32_rep(orion_spi->child[cs].direct_access.vaddr,
-			      xfer->tx_buf, cnt);
+		iowrite32_rep(vaddr, xfer->tx_buf, cnt);
 		if (rem) {
 			u32 *buf = (u32 *)xfer->tx_buf;
 
-			iowrite8_rep(orion_spi->child[cs].direct_access.vaddr,
-				     &buf[cnt], rem);
+			iowrite8_rep(vaddr, &buf[cnt], rem);
 		}
 
 		return count;
@@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 	/* Scan all SPI devices of this controller for direct mapped devices */
 	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		struct orion_direct_acc *dacc;
 		u32 cs;
 
 		/* Get chip-select number from the "reg" property */
@@ -711,14 +712,13 @@ static int orion_spi_probe(struct platform_device *pdev)
 		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
 		 * support, once this gets implemented.
 		 */
-		spi->child[cs].direct_access.vaddr = devm_ioremap(&pdev->dev,
-							    r->start,
-							    PAGE_SIZE);
-		if (!spi->child[cs].direct_access.vaddr) {
+		dacc = &spi->child[cs].direct_access;
+		dacc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+		if (!dacc->vaddr) {
 			status = -ENOMEM;
 			goto out_rel_axi_clk;
 		}
-		spi->child[cs].direct_access.size = PAGE_SIZE;
+		dacc->size = PAGE_SIZE;
 
 		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
 	}
-- 
2.17.1


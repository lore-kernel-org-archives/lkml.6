Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1747C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE59219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9zwKKX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE59219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732699AbeHFVyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:54:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38557 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbeHFVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:54:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so13463484wro.5;
        Mon, 06 Aug 2018 12:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C6/v07wnqmaeTd4aYvY3zDIu4/H5KgO8k+WoAXJQDKs=;
        b=b9zwKKX1v6Dr/Evbb1Jtae2hzwuowhktAHjmrjyJo3nVz1iN7mkqQ3vzXsxZNuURQf
         mnlmCI+yemhBO6ZituTXIywIUl7OfPOcY3qfhjPpZb7UNausaP8bfdnH41k98b8hYE9a
         OCq91Xb1fu4DrnO5o+fQk9QoPoFjhQ9KZ26S4bxbv/Sxb4NmaDMIXy8lAK7XT/+GbrE7
         mE5VCe3DAfTS9XzUfdsuOvPsACselAcdGNBC7HNYFi85h4N1KRSMlkO+DlCIMyd0B0b7
         /GxFig89ehr2zPUnkLx+so23KEnzrgGlSR93KL/AY5kM4H/mwmMbx2jkL9T2Fipc0sIk
         GhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C6/v07wnqmaeTd4aYvY3zDIu4/H5KgO8k+WoAXJQDKs=;
        b=r5eaayHwHnPJBoWUILZQFTpzOl6nvXnZ0OAKf3VkRGWO4FJcDMLKNnHCCR35Xcm0i9
         ez1pFnE1QkRj0JtHFAqpo96a6byhXDTdRcGiHrsSEWHvBSC5heiX2P6AseVoscz4lJDG
         vtcIFdd6DCHZfaEjFUd7p4HyJtAnWaQ6H38vC8nJggDMYjuuF1LiIvhiKG6ur7fZXr2j
         LGMypUYWt9fATwg4NH0unGNmKg+9cMRK2SPj+yIRUdaqZOvbqmpz3ROL1h6W+kYkwgCT
         sTn42pZuxtT8KWBbgTL34k4SJcaV+2vnDEAMLHKYaeAJuhZXGrusf97prl/5DTF4eG3z
         t3FA==
X-Gm-Message-State: AOUpUlH74xgJSOc5YdPDoQBbD9hA/L9oDCdN1E3FNrqtpom+85PC+UU8
        I+fYdvXZ87viVafUw8JAMhy2bmBY8a0=
X-Google-Smtp-Source: AAOMgpdAGVACPqM3qXvYCHqnJjHRin57dTIMsvW+oIqlHdutwnLjZULAxUtx3yHtW6zgxizDF5/Bxw==
X-Received: by 2002:adf:cd82:: with SMTP id q2-v6mr10998936wrj.118.1533584619272;
        Mon, 06 Aug 2018 12:43:39 -0700 (PDT)
Received: from kostamach.yok.int.mrv.com (194-90-138-234.bb.netvision.net.il. [194.90.138.234])
        by smtp.gmail.com with ESMTPSA id d8-v6sm10613813wrv.68.2018.08.06.12.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 12:43:38 -0700 (PDT)
From:   Kosta Zertsekel <zertsekel@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kosta Zertsekel <zertsekel@gmail.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: [PATCH v2] spi: orion: cosmetics - alias long direct_access variables
Date:   Mon,  6 Aug 2018 22:43:27 +0300
Message-Id: <20180806194327.13389-1-zertsekel@gmail.com>
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
index d01a6adc726e..184ba91abeee 100644
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
+		struct orion_direct_acc *dir_acc;
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
+		dir_acc = &spi->child[cs].direct_access;
+		dir_acc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
+		if (!dir_acc->vaddr) {
 			status = -ENOMEM;
 			goto out_rel_axi_clk;
 		}
-		spi->child[cs].direct_access.size = PAGE_SIZE;
+		dir_acc->size = PAGE_SIZE;
 
 		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
 	}
-- 
2.17.1


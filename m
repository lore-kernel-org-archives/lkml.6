Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65710C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2E121A65
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLdmB7Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2E121A65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbeHFWA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:00:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35144 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeHFWA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:00:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id g1-v6so9992087wru.2;
        Mon, 06 Aug 2018 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C6/v07wnqmaeTd4aYvY3zDIu4/H5KgO8k+WoAXJQDKs=;
        b=dLdmB7CzlbJyBPpd212mn9ZuJkrTiOuWLHpuIT4E7eb7y88o7f86hmGTeeNotUy1el
         ZCd9w/OHXYcm9AfpMsZbTpAlKbswTc07FQH+l5n8jstBAa8+EU/t2oiqnlgZ5UK/z2fO
         vV2aeuKZ2xbzf3xy9BCW3+xTwK0abDWSuFkY7+RoF0MPuXA0fQqU2b6FqksQlWwjeD4c
         FBl+bMdSa/an/CjHa4U0uXxfVHTCLmwZvQlSqiv4euUIIqlNHosSKVMpIQ8Pm4KH8J8c
         MDncIZxQxVDwwBKDIyOmo6QJgDFShE9aNnrADkobn9bXCv+6W+irBkMCTGv7beJOook8
         /wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C6/v07wnqmaeTd4aYvY3zDIu4/H5KgO8k+WoAXJQDKs=;
        b=fhBtagKF/8deachq4szpsq3heND6I+x72d1T20gX/T1xTo4XnInkk2NhFvWkVyvAWm
         4stefRTMkCWJCG1Ynih+sneK/iB9mQOSoEU1AXYaODLX06ddl6V6zcDZLbTeZZFgsy9a
         C7M8KtwlsdrfAlV2SHFIXkWKjPp5veqcjFvgr50J+ISyeyFb60shzquuQYwXJ/zuaNsE
         FWzn17ig/BUt0YHvxTIojJUHGvnNFDTQ4MP6nOWAG7+Dam8rX+DCI0m1M4IyclYFML67
         /jCQMldsDczQ2K1nfj8r+38IYMIv4+qr9Cw3ycM7sk1TZsgL7NHTCi1Ekn1V0i4XXBlJ
         H8+g==
X-Gm-Message-State: AOUpUlHpd/RKPr8lwEXVLGm6yf8VMYc/4lgTZ3QLtihOpYqoZr0IurAK
        kSjPKLoIQODAQxGtn7W/xpU=
X-Google-Smtp-Source: AAOMgpcKhwuxPa0DRp/b3fFY4U7uMpVfCTNRqGOx2iFpCRNqrx04hU2ghfNLTRCF+FTAfiRuzINdyg==
X-Received: by 2002:adf:ec04:: with SMTP id x4-v6mr9934702wrn.245.1533585017859;
        Mon, 06 Aug 2018 12:50:17 -0700 (PDT)
Received: from kostamach.yok.int.mrv.com (194-90-138-234.bb.netvision.net.il. [194.90.138.234])
        by smtp.gmail.com with ESMTPSA id l16-v6sm5359497wme.36.2018.08.06.12.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 12:50:16 -0700 (PDT)
From:   Kosta Zertsekel <zertsekel@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kosta Zertsekel <zertsekel@gmail.com>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Subject: [PATCH v2] spi: orion: cosmetics - alias long direct_access variables
Date:   Mon,  6 Aug 2018 22:50:02 +0300
Message-Id: <20180806195002.15156-1-zertsekel@gmail.com>
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


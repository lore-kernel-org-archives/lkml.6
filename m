Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D89C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF62E2175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZ3E9QS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF62E2175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeHMXix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:38:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42898 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:38:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so15382165wrs.9;
        Mon, 13 Aug 2018 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tXHrZ/DnkhfBXAsjfhROWhBuUxNzSBfxPNO32adlPIU=;
        b=KZ3E9QS/nHr3hK8Zs9UiUVBu06x85JpL7ZsNDq8r1CQEwgu0aWNDw2jhX24CffgaBI
         v5AAXQlk1lfx95mTQ/zGq501Bzrbiw6vxIyu4H01YwCZJU29QWUj9KW6MdqWdxcuW2yA
         GxTXVXRAi/yAnrrNVjbVyFqVkGQLDs0mW1EP2HVfeOiVshmZlWkZ1HLn5fdXhnt3LJho
         LK0W1UhYkOqh7X/AnURxlOvoTGOTTvUeXDNLgq9N/+pzwY9GSZkJXT4oupVPWRn38iWx
         9Sx+0SzSYn89bS1VBC8d7BVidAJZd/xi9mZZqcP4gZLgl5XDVmE2z6snjBiB1Cl/c9gA
         iX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tXHrZ/DnkhfBXAsjfhROWhBuUxNzSBfxPNO32adlPIU=;
        b=HJj4IwvKLOAjOO7/mKKYa5zJ7L+hUSoc299t8nNvzsAMIxYWbYd4UoE3c2Bqf7x9hR
         4xIlaOS1smoTzZiBmxjxm1XfAr+ro5RpObq+w5pEDCfP9z5VVliYSk9uv4PIODT/St+G
         CeqW3OEjuEVkA3rfgpKiQqs6HBB/2ON5KKd8ozHw2VGSRTvAiiW6vowZajZijnCsj42P
         AIoqGqzckIoIOy2YStELgVPjGphtXzyhJ1TO5/4mL/7JFZUEGaV/CWKsecFo8Td3QStz
         2YA2gsATI2s1YbzTbJaTVBS19POxBWTyQW2ffKiG+svbDT5KmKVEh2VSgMJikTIbi6MO
         0agg==
X-Gm-Message-State: AOUpUlFhRkoIAGBRDIhnJA2Ez1v45nIcDPRONvnPiYkA1MHyYhIpdYXX
        N9iiZph0JLQaZVliAjxv6qw=
X-Google-Smtp-Source: AA+uWPyLF7oAF2B1yi6DjZJnAKt6f+CI4RhA9tq2APF4CqSJC+fkwoyGU+K1SjmySImV0KV6lxfNAw==
X-Received: by 2002:a5d:4f82:: with SMTP id d2-v6mr11539350wru.261.1534193698946;
        Mon, 13 Aug 2018 13:54:58 -0700 (PDT)
Received: from kostamach.mynet ([141.226.217.244])
        by smtp.gmail.com with ESMTPSA id t5-v6sm29053154wrm.80.2018.08.13.13.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 13:54:58 -0700 (PDT)
From:   Kosta Zertsekel <zertsekel@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Cc:     Kosta Zertsekel <zertsekel@gmail.com>
Subject: [PATCH v3] spi: orion: cosmetics - alias long direct_access variables
Date:   Mon, 13 Aug 2018 23:54:45 +0300
Message-Id: <20180813205445.17113-1-zertsekel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change increases the source code readability.
Instead of using `spi->child[cs].direct_access.XXX` use `dir_acc->XXX`.
Instead of using `orion_spi->child[cs].direct_access.vaddr` use `vaddr`.

Signed-off-by: Kosta Zertsekel <zertsekel@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


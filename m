Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56001C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6BD21778
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoiRQ2OS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6BD21778
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeHMXef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:34:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38932 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeHMXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:34:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so15376051wre.6;
        Mon, 13 Aug 2018 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AhgU86h27IEO4rQwzTAmilrH43/HX75OFOBZBgiQZcY=;
        b=SoiRQ2OSBgFmS8tEgsQSwPFBnlewqTNAyGiBguZ2LLeJ91nruGz/r1b5Jm4q5bt6rU
         0jR7LPYBaGBkL2tFgtGlOfH4E98xxcWSO3iUXmPxpW/T5s7oupxLCHaZ34Huy4fZ7TXK
         HEWXu/+ltkOaOa3ot0XljY5w9JS7uEYoJWmck4pJbNSLdy1FfZK4L499NXw5biRlpvVp
         JxRZ1D/Qw9uYMnkFaScsrAautst2ZZxtG7cVOK9s1FcYAeaI3em9KxTUNf60NWS7eXzH
         6zHrLeTC+fBK6wjzUTtJrRUINE5yjQcZ3HzYUuhij42MLaatlNdV9+RtscCgWu8bmJx4
         SHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AhgU86h27IEO4rQwzTAmilrH43/HX75OFOBZBgiQZcY=;
        b=C7t6ykTfnvMJkB2I85j56KFbPqiCAWAVffJSndWIZTwxeKEcE9XbyKWaVwEvTaeR5K
         ZV0z3BqfpGC44RWkwpf9xxoqOiWgwfSMi024FXL4nLZ1vtFxAOSGttAEeaZDo2jNlUr4
         NVk76cH5jLIGgjMcjjEhLMbfWcMxThtkr6vqn8anc5nxYWyUZhpPIJM6albJFkwidkgX
         6AjA6hs9Db910VvIUr/MfBKjM9lQ2KfWZre395yZv7K1bw/OAQiom8MaTfEHLe17At2v
         lFDOC5XKapUw6xlOpNbszZ+gsBNER7fLrtYc+dJ8nn1hcUogwMGNnZrddHiyJXC3n9vF
         /Gvw==
X-Gm-Message-State: AOUpUlFRmV1QFpwEstbYHPohBif+CGOn+/0/qOeBDjHKX7I8KV9wVdoE
        JhUsX2neqGWaYnS8WjEReJ4=
X-Google-Smtp-Source: AA+uWPxQmh+d2eQvbmy+BeAotl3U+BAlxF+aDPA2CabAFKWcA2aA/nJsH02ZJQx5sVwhi0PADKvhjw==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr12237744wrq.225.1534193441774;
        Mon, 13 Aug 2018 13:50:41 -0700 (PDT)
Received: from kostamach.mynet ([141.226.217.244])
        by smtp.gmail.com with ESMTPSA id q70-v6sm22447129wmd.39.2018.08.13.13.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 13:50:40 -0700 (PDT)
From:   Kosta Zertsekel <zertsekel@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>,
        Stefan Roese <sr@denx.de>, Ken Wilson <ken.wilson@opengear.com>
Cc:     Kosta Zertsekel <zertsekel@gmail.com>
Subject: [PATCH v3] spi: orion: cosmetics - alias long direct_access variables
Date:   Mon, 13 Aug 2018 23:50:19 +0300
Message-Id: <20180813205019.16214-1-zertsekel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change increases the source code readability.
Instead of using `spi->child[cs].direct_access.XXX` use `dir_acc->XXX`.
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


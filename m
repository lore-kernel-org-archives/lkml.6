Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B2ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801420657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIGNEm1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8801420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJaTzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42472 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbeJaTzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id b7-v6so13199605edd.9;
        Wed, 31 Oct 2018 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pjwfb2BF/70qgjIhna2YK8MxiCLPyVjf8TJQlLJSdpI=;
        b=RIGNEm1i9h63opYfyVzScHF+IHKjgOcsesf98akx+8/ilK1+444Gb201XNwiIjJwRp
         2ipEvv8cj9a0J0BiMCIKOrBaxrAC746dQeoAgA9tz2Yl4zctgeM2Mt9+JESHrHjzqGfW
         YDiKdWUA3Xh7xlRt+GSLp4EDYMQ8FV4TDK5Y5tujsaOBqazxRmRNvHvjE9E1j1OZUpIr
         qT8tdtGnORK/klQQ97Eig9KqKcr0D0SrKO1jhSDMSqanRUcaE/m5P8lxRTLxgwTdQ6oL
         I3/H3uOx3MB1/llTQ3YDzG15CbGNPW/Z71bk87eonR/kuBQuzHl/eFWKeCXfto6rH6Ei
         d4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Pjwfb2BF/70qgjIhna2YK8MxiCLPyVjf8TJQlLJSdpI=;
        b=ZMt+HCGH+S3zQgj3pjgBlKypn8Lgjq4IqIPXgLPABWD46b1xN9Vxc9dGDNIg8tFCMw
         1M/VLUZKSzV/pKj59QV4W5GC7N3ypVa2V8V8GIfiqvglLZDmOrG2kEVVmmsG02AlRV96
         bOaY0S8yigGL47rn36Y6YduSgyz8mTeAENWGz5BXwb87ULKOpVxqw03pkP5wLv1CQ6do
         sXppDdbSfr/b5i/bkLS+nCpjqhpWbN5+dNIp+Udf+knUXvRUq8RolfcxCuo+U7vAaIBI
         n6imcM+KH3K24GXdZt+qwIGsCsU/GhLRZkBNItZpKW41dgEbfzBk4oJB8fFy/lgY3+Fl
         S3kQ==
X-Gm-Message-State: AGRZ1gJMgnPr1zcQRHJ/d8Ujqfii2Gll2K0nT3XcWyJELjTwyHTEZmQt
        OwT7P442LcxWiSC3y8gIesrvgqp6uPE=
X-Google-Smtp-Source: AJdET5e/gROe4Lloc1i20LGEDEz+eNCo4Bq7lCYsPS3Vbucyf8/BqKATu4+CwfsoIk+pBCMvPZajSg==
X-Received: by 2002:a17:906:2cc2:: with SMTP id r2-v6mr1217667ejr.38.1540983479590;
        Wed, 31 Oct 2018 03:57:59 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:57:58 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/14] spi: rockchip: make spi_enable_chip take bool
Date:   Wed, 31 Oct 2018 11:56:58 +0100
Message-Id: <20181031105711.19575-2-esmil@mailme.dk>
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

The spi_enable_chip function takes a boolean
argument. Change the type to reflect that.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 51ef632bca52..7e54e1a69cc8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -208,9 +208,9 @@ struct rockchip_spi {
 	struct rockchip_spi_dma_data dma_tx;
 };
 
-static inline void spi_enable_chip(struct rockchip_spi *rs, int enable)
+static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
 {
-	writel_relaxed((enable ? 1 : 0), rs->regs + ROCKCHIP_SPI_SSIENR);
+	writel_relaxed((enable ? 1U : 0U), rs->regs + ROCKCHIP_SPI_SSIENR);
 }
 
 static inline void spi_set_clk(struct rockchip_spi *rs, u16 div)
@@ -339,7 +339,7 @@ static int rockchip_spi_unprepare_message(struct spi_master *master,
 {
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	return 0;
 }
@@ -379,7 +379,7 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 {
 	int remain = 0;
 
-	spi_enable_chip(rs, 1);
+	spi_enable_chip(rs, true);
 
 	do {
 		if (rs->tx) {
@@ -399,7 +399,7 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 	if (rs->tx)
 		wait_for_idle(rs);
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	return 0;
 }
@@ -413,7 +413,7 @@ static void rockchip_spi_dma_rxcb(void *data)
 
 	rs->state &= ~RXBUSY;
 	if (!(rs->state & TXBUSY)) {
-		spi_enable_chip(rs, 0);
+		spi_enable_chip(rs, false);
 		spi_finalize_current_transfer(rs->master);
 	}
 
@@ -432,7 +432,7 @@ static void rockchip_spi_dma_txcb(void *data)
 
 	rs->state &= ~TXBUSY;
 	if (!(rs->state & RXBUSY)) {
-		spi_enable_chip(rs, 0);
+		spi_enable_chip(rs, false);
 		spi_finalize_current_transfer(rs->master);
 	}
 
@@ -503,7 +503,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 		dma_async_issue_pending(rs->dma_rx.ch);
 	}
 
-	spi_enable_chip(rs, 1);
+	spi_enable_chip(rs, true);
 
 	if (txdesc) {
 		spin_lock_irqsave(&rs->lock, flags);
@@ -705,7 +705,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		goto err_disable_apbclk;
 	}
 
-	spi_enable_chip(rs, 0);
+	spi_enable_chip(rs, false);
 
 	rs->type = SSI_MOTO_SPI;
 	rs->master = master;
-- 
2.19.1


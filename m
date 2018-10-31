Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7BFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853B920685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKRc9Y8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853B920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeJaT4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:56:23 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42484 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbeJaTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id b7-v6so13199999edd.9;
        Wed, 31 Oct 2018 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mc8cm3LzERwLnKMSOFVucQyf/Yt+O2Cfgw2FqcjLLao=;
        b=ZKRc9Y8vWvVPRx8PjqEQGspQ/xb0BQV9xxmeTZ1Ez7pY9y1CbZmo4HGk1DUsKFctEm
         NC8uuvTMA2J0T3MIzfQ1QkPukYzZW0C37YlChlEL3xQiWGmtqAlrrDb/cjlXN3U3gMpj
         uUHs6ZTR00J7Xm5BUEtJyZp7lMJuHpOuf+WCpX9F4hsbDHymbHSM9A5fE7odLvvYNWtG
         yNdJuC1a3bA+pmFuwkyDO6TFuDj0c7QQJ/nKEWOMDzMpfUXOq2FWss3TttEXUJNAzunU
         vFn5852YhdDPq/fGL1gb9k3luBwxDNaEOXoTTteEZYqzyBwxx1SdWVT1p07iQyYizTvo
         AGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Mc8cm3LzERwLnKMSOFVucQyf/Yt+O2Cfgw2FqcjLLao=;
        b=NJx07aXvV5OqUqu5uN9hPCNaWEJCCeQl0tsRZNR9MODIB0T6B1+VlKzmcfQ+Sfyeff
         /okORG6eQxnjy4ioy0polONb+LPHm6U8Uyc1htqgSPilk9MsgMBB4/E5aeSoF8cioMs0
         NBw31MXlYcl/iKYlSPyzzK8GU7n+Q8Z+xeu9gAM/MeZKtiN3QrPFM1ItzZ542aHvxRpD
         a02rHwwycA9+pWW9vf10wz6LE0l51QjZ9e8iWdb0hsImnNj6l6qKsUnpe7H21dUQCqLI
         yahrBcMMAz66Qo+tpw5t5sScrO1c2KTqZ15e2+fCB9pUUWF5JW0AvQCN0edPUUMVOi1p
         tgWg==
X-Gm-Message-State: AGRZ1gIMH8+c/Bp0qnayeudQ7+crArrVv5AY9RnNgj4LNlgg/cVreXMx
        NvkWDtDlJ8xZTc9tPyCAHqJrdc8UzIM=
X-Google-Smtp-Source: AJdET5eEOZaRlLh0oURXycFkTESkH3KQgBOenj0dhs/NKvSojVhcJQf+KbOh4fThPXNgI7UlD1uJ2Q==
X-Received: by 2002:a50:ec9a:: with SMTP id e26-v6mr1665211edr.134.1540983488621;
        Wed, 31 Oct 2018 03:58:08 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:07 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/14] spi: rockchip: remove master pointer from dev data
Date:   Wed, 31 Oct 2018 11:57:05 +0100
Message-Id: <20181031105711.19575-9-esmil@mailme.dk>
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

In almost all cases we already have a pointer to the
spi master structure where we have the driver data.

The only exceptions are the dma callbacks which are
easily fixed by passing them the master and using
spi_master_get_devdata to retrieve the driver data.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index f3fe6d4cf6f6..45a1479c1a29 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -159,7 +159,6 @@
 
 struct rockchip_spi {
 	struct device *dev;
-	struct spi_master *master;
 
 	struct clk *spiclk;
 	struct clk *apb_pclk;
@@ -350,19 +349,21 @@ static int rockchip_spi_pio_transfer(struct rockchip_spi *rs)
 
 static void rockchip_spi_dma_rxcb(void *data)
 {
-	struct rockchip_spi *rs = data;
+	struct spi_master *master = data;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	int state = atomic_fetch_andnot(RXDMA, &rs->state);
 
 	if (state & TXDMA)
 		return;
 
 	spi_enable_chip(rs, false);
-	spi_finalize_current_transfer(rs->master);
+	spi_finalize_current_transfer(master);
 }
 
 static void rockchip_spi_dma_txcb(void *data)
 {
-	struct rockchip_spi *rs = data;
+	struct spi_master *master = data;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
 	int state = atomic_fetch_andnot(TXDMA, &rs->state);
 
 	if (state & RXDMA)
@@ -372,7 +373,7 @@ static void rockchip_spi_dma_txcb(void *data)
 	wait_for_idle(rs);
 
 	spi_enable_chip(rs, false);
-	spi_finalize_current_transfer(rs->master);
+	spi_finalize_current_transfer(master);
 }
 
 static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
@@ -401,7 +402,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 			return -EINVAL;
 
 		rxdesc->callback = rockchip_spi_dma_rxcb;
-		rxdesc->callback_param = rs;
+		rxdesc->callback_param = master;
 	}
 
 	txdesc = NULL;
@@ -426,7 +427,7 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs,
 		}
 
 		txdesc->callback = rockchip_spi_dma_txcb;
-		txdesc->callback_param = rs;
+		txdesc->callback_param = master;
 	}
 
 	/* rx must be started before tx due to spi instinct */
@@ -633,7 +634,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	spi_enable_chip(rs, false);
 
-	rs->master = master;
 	rs->dev = &pdev->dev;
 	rs->max_freq = clk_get_rate(rs->spiclk);
 
@@ -746,9 +746,8 @@ static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	ret = spi_master_suspend(rs->master);
+	ret = spi_master_suspend(master);
 	if (ret < 0)
 		return ret;
 
@@ -773,7 +772,7 @@ static int rockchip_spi_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = spi_master_resume(rs->master);
+	ret = spi_master_resume(master);
 	if (ret < 0) {
 		clk_disable_unprepare(rs->spiclk);
 		clk_disable_unprepare(rs->apb_pclk);
-- 
2.19.1


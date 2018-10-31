Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DECC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB5720657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9cRjOr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB5720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mailme.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbeJaTz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 15:55:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40328 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbeJaTzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 15:55:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id z12-v6so7434082edp.7;
        Wed, 31 Oct 2018 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vFXrdaCnfUcL3JBvZ1D2OFb6nZYiYl1mIe6eBbWMqL8=;
        b=j9cRjOr2Qk6WhMktPZIsjKN9DmT2bAFv2j71YifXQZfLlv6jMXJXphuMSIdq5tz09z
         XnyFE5yxy7icgbkKV3TqtlXk5tzvAjDxiUdvQfK3ULNCfSRYSQTjKtN913oPWw7G9Weg
         mlIBmsUB3UAjfYHcnNMQYz6ZidHqY3i3j43OKrmTQvH3lEDj/CsGUrmoSfeBbhs4chnt
         3eP1y9JQUdoSqg5ez+8vobGWTLn8Su1bma2Bk4KHzZh5RQck8amjTVL3pmzRS2Lbb06m
         gn0wiodTVrlCSUseWHdGN1ILiwLVSEnHF2w73DWDzfW9DLsv+hyfpHNAjvTIwwwki01w
         3uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vFXrdaCnfUcL3JBvZ1D2OFb6nZYiYl1mIe6eBbWMqL8=;
        b=X3kr2pNUi2elMfxteRp7oPH/HMMxXxAe6iDtc0IEVcejAESb1kKk6xVkcjquEOXE8Y
         qEYXT4n/2o9t0TTbOinaZWCfRLnpS5gvBIfgvfoe3dM7HqDyGWW4Gxi1Hg1TrWoC/Nv0
         ZeA35c0el2iPKkn9R30E9aHqndud73SguvYvR3ECeYMmbB3B1CHZ+/tqrUldyQzSYG9T
         zHp9ZJrK4RMlpt9wjpYtT8L1w7lFrp5iMpMF6Ue6wliD5sGN/WGHyRnULfgAjunj+HVC
         lu6od2dIpWELmlUIy2CmJG1Y+2hIr961GQAQ/Fq9mWP/wE1MLTG+9TUzMGqPQKRrLMqT
         gmCA==
X-Gm-Message-State: AGRZ1gIAef3QEz2AFrFtLq/e5YE6jXuhNrKNP04m0r1w+nMLoexeyGAe
        oCRDiMT2EwaLIKb/NFAAJtS2AsD/6WQ=
X-Google-Smtp-Source: AJdET5c/3MYjg/ih6xMnCyOBAPScWHmrMxpeAuKd8a6RB2ZJ/zGqslC4pAvABXSSVUiuBJjhl5r/Kw==
X-Received: by 2002:a17:906:c3c6:: with SMTP id cj6-v6mr171501ejb.178.1540983495888;
        Wed, 31 Oct 2018 03:58:15 -0700 (PDT)
Received: from localhost.localdomain ([5.57.50.195])
        by smtp.gmail.com with ESMTPSA id a40-v6sm9041108edd.61.2018.10.31.03.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 03:58:15 -0700 (PDT)
From:   Emil Renner Berthing <esmil@mailme.dk>
To:     linux-spi@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Addy Ke <addy.ke@rock-chips.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/14] spi: rockchip: support lsb-first mode
Date:   Wed, 31 Oct 2018 11:57:11 +0100
Message-Id: <20181031105711.19575-15-esmil@mailme.dk>
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

Add missing support for lsb-first mode.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 drivers/spi/spi-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 9e47e81553a1..3912526ead66 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -476,6 +476,8 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 
 	cr0 |= rs->rsd << CR0_RSD_OFFSET;
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
+	if (spi->mode & SPI_LSB_FIRST)
+		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
 		cr0 |= CR0_XFM_TR << CR0_XFM_OFFSET;
@@ -681,7 +683,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	master->auto_runtime_pm = true;
 	master->bus_num = pdev->id;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST;
 	master->num_chipselect = ROCKCHIP_SPI_MAX_CS_NUM;
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(16) | SPI_BPW_MASK(8) | SPI_BPW_MASK(4);
-- 
2.19.1


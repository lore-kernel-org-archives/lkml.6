Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C286C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38428208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFtDef4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38428208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFTIdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:33:15 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35430 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeFTIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:33:10 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so3660324lfc.2;
        Wed, 20 Jun 2018 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AE0B2be8YxirzbiKq4cI8ZQ0ikSvHyrLW9ghUVfqyCU=;
        b=SFtDef4V8R3MpG3hoESMavsg7ichUi5gzmKEbo3Q8wn49KXK1EUVs125BSfbI+0TbJ
         HV5DqOlMiQBbGjbKv75tRsEhzGuWBvEe6as93VeH+8bkGfMVGxl8WilAmmAB1+DCFJUo
         sVhS+MTNchQSqicX5iqs/V2Eb2D8QGHw4vsc86wHI1zeC8oplrdPer3JSg7J6P7w1q1M
         3zS8Ba8cMrsYfiEFplFk7PeVLmxGVUg7pugSghE0sHgofsLx2MxaF1/TObVbWH86xJYU
         zKr/dKhz4J+ldobQ7W3A6IoVWt09jH80ffVDsUR0dg7Xw5/As0BAU1up42CkG7EPKhuo
         M0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AE0B2be8YxirzbiKq4cI8ZQ0ikSvHyrLW9ghUVfqyCU=;
        b=Z9dQETm5Pp9ZjF3NsnJaW7PTAVayXgMR9X+aZWuqmOM87tDKY58fRgoAkpuj5F4Af7
         aabTb0AcpRdTQ1qbBcEQJismQaicVs6fYUpHd+cNKGcnzqu6tlcg3OYTHaTpGz7fBWQ/
         o6PqV5Q81N4E1hQ/FYV9hiKxcLa+OIVw7DWXr9TzHgR4EII7wR6W+KlR015EEGHyvmou
         8VlKez9zyyWX+8DwVh95I8QztHErU8yulpzru/OxhtoJKzT1HogGGXuc9OC+t3piTZDK
         g+guL38XIMZb2x6mhdkF8HgGkORx0LNiwMWERJm4E2nH/fPiw6Z16yTOG8GtN2fDQxdY
         CZng==
X-Gm-Message-State: APt69E370ws4u+E/unPi/FWVCr5vTuZRLgmFJLqbotogNruqF8wMrdxs
        TMZCEZBbrfa3bOE46LNPbnGx9DyI
X-Google-Smtp-Source: ADUXVKKsHt5yQvoK1oV0rfuKhkoBOyhSQ5+qbXXmEE6ezI871MAkM+OgZPShrs+U/3ED9bZ9W8XYhw==
X-Received: by 2002:a2e:9789:: with SMTP id y9-v6mr13110813lji.52.1529480110389;
        Wed, 20 Jun 2018 00:35:10 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id p16-v6sm275932lji.20.2018.06.20.00.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:35:09 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 11/12] spi: spi-fsl-dspi: Advertise 32 bit for XSPI mode
Date:   Wed, 20 Jun 2018 09:34:41 +0200
Message-Id: <20180620073442.20913-12-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620073442.20913-1-esben.haabendal@gmail.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 67cd2e901255..eed55491b2c9 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1001,7 +1001,6 @@ static int dspi_probe(struct platform_device *pdev)
 
 	master->cleanup = dspi_cleanup;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
@@ -1033,6 +1032,11 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (dspi->devtype_data->xspi_mode)
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
+	else
+		master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base)) {
-- 
2.17.1


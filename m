Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D6AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F083520869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6D5QHgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F083520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbeKFEh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:37:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43215 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFEh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:37:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so16775522qkr.10;
        Mon, 05 Nov 2018 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IL8R6y1gtaHkaLcJ+ACkXbSV0NqE62Dg14qzw/H8vqE=;
        b=L6D5QHgXEnf7t8DF1KyoKyUyW3HFGh5J9ZoW8f2iQkVTKZDhDurqw3iK4qFOxRvLKo
         pigaQlxQwbK78oFI0/xXoo/tFgXcpUDJPlQ5hPc3DrtZaHH0BnIvqb2b9NobY0xwHSW0
         8uKYLOwCh9J8j0wkVJ/vOIfpqtpM9uwwrQ6W7dVCowKH+IR3GNdmdSEzHybpLv//Nig3
         ZINhpNShw+rFUzqjTDQB/30k3u8BZGMmcfEwedEpz3b/rzAp04QF5W7br7Atc3niGUzF
         xUZd1rQaGwJaRlUy1dahTjn3OJZ04IFQWdQLY6+oSolbLpC7Gf+c9gUNqlDG/PfrQ3Oz
         n7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IL8R6y1gtaHkaLcJ+ACkXbSV0NqE62Dg14qzw/H8vqE=;
        b=aUwtTllq17LtPcskMJA2RhD+g/BuwNZ97a2fniULgGeQjmKxixAUv/oGPmN8k4n0kU
         x11V7ufMYfL3qQNkSTJFFkyE6nXGMDRKn9ixFAAxIEt/1BeOEdiAyDueMAizuq2hCTOc
         X05z6Qfw5/HZvk/J0mMbJRQrIgvQnDj7hBVNqCWTBrkM+V6qv0qDE1PU1JSRhZbxWNU5
         ltPK2pNMQX2RWpir+jMjs0NYbBwzbCzEialr7P5D6VNgfYCNYmznxL6YSO17X8BcUT+E
         oeruFibCPYPGuIGnM3Q4F6Fgge6oa4P1hbI2/MpxiavZVKgwq9CUQ+XPs5xYEsikOIHt
         vP+A==
X-Gm-Message-State: AGRZ1gJmlveGkD7rH82JMdJ+RPNsXpMn8BwIjVjVot+87qJ4Pv63pS+6
        WYQjdXgb+2JqiRGD4JdDgQ0=
X-Google-Smtp-Source: AJdET5fLmKLWWHCr9Orv5JzCnUGklmGdHaWq6nZD3Cczdqt2jPKMd4W+FOzhdDUVzwtSX/bpBgtOhw==
X-Received: by 2002:a37:90c5:: with SMTP id s188-v6mr21684457qkd.104.1541445378692;
        Mon, 05 Nov 2018 11:16:18 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id b9-v6sm7208705qti.4.2018.11.05.11.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:16:18 -0800 (PST)
Date:   Mon, 5 Nov 2018 17:16:14 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 2/2] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Message-ID: <3920d49d888f63b600a4d2f2600921ed2900a470.1541444377.git.renatogeh@gmail.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1541444377.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the unnecessary field int_vref_mv in ad7780_state
referring to the device's voltage.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v3:
	- removed unnecessary int_vref_mv from ad7780_state
Changes in v4:
	- removed voltage reading on probe

 drivers/staging/iio/adc/ad7780.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c7cb05cedbbc..52a914360574 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -42,7 +42,6 @@ struct ad7780_state {
 	struct regulator		*reg;
 	struct gpio_desc		*powerdown_gpio;
 	unsigned int	gain;
-	u16				int_vref_mv;
 
 	struct ad_sigma_delta sd;
 };
@@ -165,7 +164,7 @@ static int ad7780_probe(struct spi_device *spi)
 {
 	struct ad7780_state *st;
 	struct iio_dev *indio_dev;
-	int ret, voltage_uv = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -185,16 +184,10 @@ static int ad7780_probe(struct spi_device *spi)
 		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
 		return ret;
 	}
-	voltage_uv = regulator_get_voltage(st->reg);
 
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	if (voltage_uv)
-		st->int_vref_mv = voltage_uv / 1000;
-	else
-		dev_warn(&spi->dev, "Reference voltage unspecified\n");
-
 	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
-- 
2.19.1


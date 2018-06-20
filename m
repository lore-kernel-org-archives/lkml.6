Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A30C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B3B208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIctjDG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B3B208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeFTIig (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:38:36 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38397 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754619AbeFTIid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:38:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so3666269lfh.5;
        Wed, 20 Jun 2018 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNGcY90aw1jSuFjOhEkiTIFnEdW/74Jil9N8Th72Dv0=;
        b=XIctjDG/wqaFqCoWQQzOJLF8NeV3kMJh0rGxn6FKD+hmgPZz3Uw3eclnNRji7J9M0W
         XJSgtxJJQHYdza6lsnjPkYkhtzyPvZyK8JGOru9IdE8bkpTt0ZQOsvHzSbzDmYOGKqvI
         A7S0Dda37gVqwXxk86msoT1equTl/NhT5v+dC7B2OPyh8Sje5otG5uLbEb6OE3IzFnqX
         ja1Vx0ahIlJNN6YjaKalxDVjEo/oXqvZN0e8yToSguUc5rf4M/uuvxaKByEjNlLIYmNI
         On7PqH7jQG+WsdbWOpmHj8Q7/SVkCe/dRmgkqQi5T0aEgf3HxAdcSRWpUUePGe2Rzo9q
         meUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HNGcY90aw1jSuFjOhEkiTIFnEdW/74Jil9N8Th72Dv0=;
        b=XMFnqxfeBiUHhGmvrkRpKZc7h+sVJsHHxG1rVb94IzOhhgc4So622hKfhmjjYaakEU
         utkuAqk0sriXamCYnoNqcbvGq37CDS44iY7oWe0GsuRUFGyPde6KIO0oFzhYX+t/fdxn
         1Y7h11XF7LOLZ+N9OaJ/JHQ9G0YiW24BmcweuYEK8Gt1Z7AwxktABRObnYoWYww/pG0Y
         sHvK61e77foC5qGDduVGQAVnqYFT/EHjopq4Qrmcp4QSGLFZCbSghIJEoklgbDTzL1AB
         XRNfTBcmLJjC6QeNTfcZPWUqh+4lkqN+YjU26zhBz6ogXrkfWkkFemTnCwkxJ+5DjixY
         fVKQ==
X-Gm-Message-State: APt69E3EtGV8VIR3dtesgPdAen6E79c+0U35DRN52+wmg3IjPPYCBsxi
        7uRElgL8Kk/fJ1msX7t1vFwK8RxI
X-Google-Smtp-Source: ADUXVKL0IuXQXxVBzOZ6MwpmQd3H2mxBVQOdQ3UctVqt0MJ3Qeb39JPOCLnZXB4mXuSoLHwkqUTaeA==
X-Received: by 2002:a2e:2948:: with SMTP id u69-v6mr13008471lje.130.1529480099287;
        Wed, 20 Jun 2018 00:34:59 -0700 (PDT)
Received: from localhost (87-57-30-174-static.dk.customer.tdc.net. [87.57.30.174])
        by smtp.gmail.com with ESMTPSA id f203-v6sm285735lff.27.2018.06.20.00.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 00:34:58 -0700 (PDT)
From:   Esben Haabendal <esben.haabendal@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 06/12] spi: spi-fsl-dspi: Fixup regmap configuration
Date:   Wed, 20 Jun 2018 09:34:36 +0200
Message-Id: <20180620073442.20913-7-esben.haabendal@gmail.com>
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

Mark volatile registers to avoid caching bugs.

Note: SPI_MCR is marked volatile because of CLR_TXF and CLR_RXF bits.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Martin Hundebøll <martin@geanix.com>
---
 drivers/spi/spi-fsl-dspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index df07dd4722fb..5c5905b6509f 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -862,11 +862,23 @@ static int dspi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
+static const struct regmap_range dspi_volatile_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_TCR),
+	regmap_reg_range(SPI_SR, SPI_SR),
+	regmap_reg_range(SPI_PUSHR, SPI_RXFR3),
+};
+
+static const struct regmap_access_table dspi_volatile_table = {
+	.yes_ranges     = dspi_volatile_ranges,
+	.n_yes_ranges   = ARRAY_SIZE(dspi_volatile_ranges),
+};
+
 static const struct regmap_config dspi_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = 0x88,
+	.volatile_table = &dspi_volatile_table,
 };
 
 static void dspi_init(struct fsl_dspi *dspi)
-- 
2.17.1


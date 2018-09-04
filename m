Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C151BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7B920659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5vrvJiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7B920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIEARE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:17:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54714 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbeIEARE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:17:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id c14-v6so5650091wmb.4;
        Tue, 04 Sep 2018 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f9dzvM2SiV7WpDRR5R4BYaIKH+VOP3+svnLMCWdrwTA=;
        b=l5vrvJiEntwHjWc4y5h6PtfKJw4Y4kFAALHP/HDHGSLg+yHDUbSdj21Rgc9n5mU4x4
         2pLUssJkJpJf4wzpkUkL4PI0ICmxTX4tQwPkNuWy52ZX9If9kg2pZtAA7jfi719Q+9P1
         RqoGHRXkQTkMXyacpvJK3xA3bRb7rniBmXA9RBqSq9Fu/vhx0lGisI1rfN5jArXjQr7E
         wbJomJRs/Otn0nTiDA+fAxJ5WPkK4FlGOf4hPJUjmSlHW0kLIQ50YQWZ/2AYIb1KBNMs
         fkNXZOjm4lPo1LgJk7vhUtI6Tf/ddC+86utdWil+DjrhOD565ojfvJ158E0fkf96bIMf
         iyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f9dzvM2SiV7WpDRR5R4BYaIKH+VOP3+svnLMCWdrwTA=;
        b=SVyDIVAaA5PQqFqBCFbG5ZVigVIk2qOYdju/1p7KB/h/kZ/++t0rXMz4taRG1MZ1bJ
         U96cWO93eCpMU63fki7YQboafspQwGwd9stDoYUDZBih0aAVJchZLWc/qal78WT2cKur
         mXBSqVxto3nFt3n7rPsVN6fqLLAf6CBdtC0+f9gbbaCzKMdE1427drFdnPGlq3VLA+t9
         IIhm2jHAmbWIeOr/CFlBMbT6CtsQD0Kk/4p/1aJgze7KjMQH8J7Si4VIXsjqBXIQXyy5
         TSTY9UfM1jYpB306Iby1U17CE7aRIPftyGt0T4DnqEUI5suQZl4IBIFJn77FE0hRoS+F
         WxkQ==
X-Gm-Message-State: APzg51AtnI506NlkAcmrooW/5MaesiTit6MJkkQr+EvLE+7bkaA9sel3
        iHiew43aEiJ/L09jSPTDg2E=
X-Google-Smtp-Source: ANB0VdYdAUFrtmV5C4EfxeDKDxyOZt+FQPLccrzleKVZXM3SIJmLR1/T/+wMmC/yyuGOpxXbSqLatA==
X-Received: by 2002:a1c:1a48:: with SMTP id a69-v6mr3388014wma.43.1536090626361;
        Tue, 04 Sep 2018 12:50:26 -0700 (PDT)
Received: from ubuntu.home ([2a02:8071:6a3:700:e0d3:4061:15a3:10db])
        by smtp.gmail.com with ESMTPSA id o3-v6sm17194998wrn.58.2018.09.04.12.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 12:50:25 -0700 (PDT)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Trent Piepho <tpiepho@impinj.com>
Cc:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH v3] spi: dw: support 4-16 bits per word
Date:   Tue,  4 Sep 2018 21:49:44 +0200
Message-Id: <20180904194944.19721-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
References: <20180817070105.1725-1-simon.k.r.goldschmidt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-dw driver currently only supports 8 or 16 bits per word.

Since the hardware supports 4-16 bits per word, adapt the driver
to also support this.

Tested on socfpga cyclone5 with a 9-bit SPI display.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v3
- remove the check for valid 'bits_per_word' from dw_spi_transfer_one()
- add reviewed-by tag

Changes in v2:
- use DIV_ROUND_UP to calculate number of bytes per word instead of
  if/else range checks

 drivers/spi/spi-dw.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index f693bfe95ab9..58a7caf31d59 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -307,15 +307,10 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		dws->current_freq = transfer->speed_hz;
 		spi_set_clk(dws, chip->clk_div);
 	}
-	if (transfer->bits_per_word == 8) {
-		dws->n_bytes = 1;
-		dws->dma_width = 1;
-	} else if (transfer->bits_per_word == 16) {
-		dws->n_bytes = 2;
-		dws->dma_width = 2;
-	} else {
-		return -EINVAL;
-	}
+
+	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+	dws->dma_width = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
+
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
 	cr0 = (transfer->bits_per_word - 1)
 		| (chip->type << SPI_FRF_OFFSET)
@@ -493,7 +491,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	}
 
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(4, 16);
 	master->bus_num = dws->bus_num;
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
-- 
2.17.1


Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C55C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D43820815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="SH/7FFKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D43820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeKROp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34991 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeKROpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so43872386qka.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1TSPSfPbTrHQYU6brU0H9TGwCLOV4/4bEV+zwplIAXc=;
        b=SH/7FFKFziUtWWLrsr5KjYVbtZpgZ2GLZea3lGjEFbDMFhN7C4zugOtyue6dEDN3KI
         5C6GEjLbaZwFRTXYBfj39PFVGKC/ljEfpUlDx0rZuHLW52yD1k5uJhMVJjViH1x33kmx
         Dfz7pxk2ux0ctvs+Xq53pGXkpsjgpPN/gitwFHrfnSe2dhqdosppZb1/uXTPQGfO9tLt
         CG/u5XamG/FfNlhhf98n27LGJB9v6MoFrWRGMR+WSbqKmZBWhLBOPPZO8spUH2cPsDvV
         CdaIYgXRaV/Bx0EqDgOGU0LsbjnhCkxo1bU1UkDZP5LQjt+9Me7X+BFjraF98eh2NJiB
         qEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1TSPSfPbTrHQYU6brU0H9TGwCLOV4/4bEV+zwplIAXc=;
        b=NcFJfw3Mm4Aa5sqA2427ocdmgODsmIxBmNqRzKTMZKuUjCxJXBTz9GOE9/PLZJcv8I
         MO6P9uTNi6xeliRnQ6JXhRUY5D2FgSjfWPoh39rpEbf/urPf1s4/xEey3B4ILF9gpSEr
         hT7SLMCxJxDK9Z+IC5rEU1RGWyHahVz4BvslWldElXXdxUhp8m9N9FQha0nPU2ljTPmk
         sS6553uCvMTatDA5+doYDf2/3v7+oVcR4MgDCu69e/6jiPFTm3/pgrlW9ZdSeoG9hzVb
         tBF/9BoxDV4BnmpeDAdGwi3WPCVGYtXi//sWeFQhJVAFLkQ4zY58aAqcbOZ4fD6q1Th1
         5GLQ==
X-Gm-Message-State: AGRZ1gLJTCxhL2JUaIgu8ZtRUe3MwvtJ+2bYXbayjz/E+Xxg0Rq5W9uZ
        eOapP/TA40dVFiQbn52kBZu00A==
X-Google-Smtp-Source: AJdET5fnj3tspDjNf4I8oKfqnzGiVqBWXy7Qr9Ym1PqslmPrs6UwvXwJmPKF8xKvqWT2t+lBu5HjyQ==
X-Received: by 2002:a0c:d174:: with SMTP id c49mr16315537qvh.231.1542515183357;
        Sat, 17 Nov 2018 20:26:23 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:22 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v2 3/7] staging:iio:ad2s90: Add max frequency check at probe
Date:   Sun, 18 Nov 2018 02:25:36 -0200
Message-Id: <20181118042540.12697-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

This patch adds a max frequency check at the beginning of ad2s90_probe
function so that when it is set to a value above 0.83Mhz, dev_err is
called with an appropriate message and -EINVAL is returned.

The defined limit is 0.83Mhz instead of 2Mhz, which is the chip's max
frequency as specified in the datasheet, because, as also specified in
the datasheet, a 600ns delay is expected between the application of a
logic LO to CS and the application of SCLK. Since the delay is not
implemented in the spi code, to satisfy it, SCLK's period should be at
most 2 * 600ns, so the max frequency should be 1 / (2 * 6e-7), which
gives roughly 830000Hz.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - Correctly credit Alexandru as the patch's author

 drivers/staging/iio/resolver/ad2s90.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 913d6fad2d4d..fe90f2056bff 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -19,6 +19,12 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
+/*
+ * Although chip's max frequency is 2Mhz, it needs 600ns between CS and the
+ * first falling edge of SCLK, so frequency should be at most 1 / (2 * 6e-7)
+ */
+#define AD2S90_MAX_SPI_FREQ_HZ  830000
+
 struct ad2s90_state {
 	struct mutex lock;
 	struct spi_device *sdev;
@@ -78,6 +84,12 @@ static int ad2s90_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
 
+	if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
+		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds %d Hz\n",
+			spi->max_speed_hz, AD2S90_MAX_SPI_FREQ_HZ);
+		return -EINVAL;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
-- 
2.18.0


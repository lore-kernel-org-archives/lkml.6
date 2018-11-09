Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8F7208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="HGwpQeCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8F7208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbeKJHn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:43:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42701 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbeKJHn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:43:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id m5so4350066qka.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gyA4qzOls2dsDUjH6ST4e0OKCIbB05c/8v+y7nhk1V4=;
        b=HGwpQeCLEUulEQrOBOVKkjGIqghtUITOC0ckE/3SfPwmVOobwnI32YUbh85q0awaBQ
         J+KI1prFWJ98s0gcXVtKOxj/de+HEo+maYiAwDD8g17xuRZQNdZkxqzs55kpE97rWo+R
         bty1WvAgGS70IJlhXRI4rBWBoIhIGbgFn+shZQMIHMIMIcX3w3c+PYtPLUzR0ywXRp9O
         8A2I5r4l0TaCUn1vQn9SufQKeZ3qfBZ5B5tAqvHHwXz10V0O2W+9rvE9tTxKHFDvFZZm
         bOSyjHRrqGomfR7bIZyjpuAqi+9z7iTFc/xqJoknzS50lmtDwjCBynp/Jobvv8swNAWU
         n8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gyA4qzOls2dsDUjH6ST4e0OKCIbB05c/8v+y7nhk1V4=;
        b=fpkEd6iXPXWWIv6o5ZMA8mA8fh17VFRDm6vB2Zu1QhmCxTzAj/tce6EXP1wgO44U/B
         6scHYYwacVk1YfpP9WnHrmXw2JO22KPz23fRrtuNkKGzRXPSpMLfpFZSyMCH1akZoRNA
         KaMaBRLc7aRkNrtFMEcZjtHHNr9OBwWy3IkOwMK+VPwG7zglIJCa2gFtjlxUL0/mu5SM
         Mj0CiXypRAQ12keGHFcoplazAoaro0PXpFq6KgGB5Xd4G5ncZTBnRw/dESssg9ELFzx/
         tmgVev0QjwjIDxW3xFcJeuKD1Y35T/Ci0y/5kJ3m8R0tGke/w7dyH+2lG/wXtEI85X0v
         oB6w==
X-Gm-Message-State: AGRZ1gIDze/I1HxrYmL/NZC4TZS/D1GJhNkVgcRKRoCkghtIJwfD1niO
        h3rlJAvaEWAYM/cvhUlhofQfng==
X-Google-Smtp-Source: AJdET5f/KLCnyHZgNED3vTKjaHsL92kTxzZbo0naegSsvxqoT1sye/7PBziFZKD7fn84V6S3TfMUWQ==
X-Received: by 2002:ac8:2b99:: with SMTP id m25mr7214545qtm.36.1541800885112;
        Fri, 09 Nov 2018 14:01:25 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k6sm6082723qtk.41.2018.11.09.14.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:01:24 -0800 (PST)
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
Subject: [PATCH 3/6] staging:iio:ad2s90: Add max frequency check at probe
Date:   Fri,  9 Nov 2018 20:00:41 -0200
Message-Id: <20181109220044.24843-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
Alex's S-o-B was added because he gave the code suggestion for this
patch.

 drivers/staging/iio/resolver/ad2s90.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 95c118c48400..949ff55ac6b0 100644
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


Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2023DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DFF20672
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Sve25buH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DFF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeKXLKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:10:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36971 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeKXLKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:10:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id z16so12044499qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5hn8QyLV53KfTj8TSZxKFEiF2d3t53n213nmb376iXM=;
        b=Sve25buHyKAXVnsqGlNQdjsWiFBcs4WBwtUm+K7XC/FuWEpfVXHJ9qmR9+mvw0EniD
         WCd05thH3TKNycbEkH9NHiLN+tUEx3QrbbkCKAM8zlXM00wK96XIhZqHFMmFxIrTJzQC
         GgJQC65D41JbgKvUCm7K12WEd2MZeYMdmvnlh2iIR89e9M9pVLkuuoVF7tYzdJ9U1Mhh
         6zVeWQHn3+X/ynGQZyaZij62cTYD8Kk8CpFyBuZg2Eia6AHc+bWp/o+EFbLrf7KO1ID6
         9NRtRbCV4m2eYZB0T1FL3U19Owod4gL1hy2mqC0G0pe8VJwH6so4IuL+rNrCnTK+MHuF
         tqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5hn8QyLV53KfTj8TSZxKFEiF2d3t53n213nmb376iXM=;
        b=RmDeo2vID0Z9zHMy5GWpwCtbBxCoCuwFjquqo5jnMrSJFaNosA7B7cf1dDGqKWddqj
         IyykRcIoOYpdhz9ZOiI8ELcc7WOJ/FCJL/jGxZNGqVvoZNNYeXc1Q/Bl6wCNOPXwGEw8
         ITUMNc394SJVEh6eHwDywYYkDAUMMx1puXoElMtfg20ta2uK/jMcdqYFf57ECDYaIrQl
         e/oc5F6eW3rokPy2mmmgkeUEhFzQ4Ri3xuB4DKExNbU+hIJ5oEHCy2xUZ3Tr2K9mwYyz
         polw9OAhCEMxc074cizvj5bHzNXBRzeeEyBvioxUklbtl+FS8QN7oYwyRV9XTTG6rOz/
         M14Q==
X-Gm-Message-State: AGRZ1gKTopSUK9OTdF82qAl238qf+xrtd28EbAdi56k0UZpbbG2BxG3d
        lS+DBUurj2QQvUYerwmFmzZ22g==
X-Google-Smtp-Source: AJdET5fX6exuYRx/hMZr/sAOy6Fhch0BZ38+A8farzbkOxWnDMsZNFhaS/ME7aJOhAPtYTzjJCx32A==
X-Received: by 2002:ac8:4258:: with SMTP id r24mr16959175qtm.213.1543019018603;
        Fri, 23 Nov 2018 16:23:38 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:38 -0800 (PST)
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
Subject: [PATCH v3 3/7] staging:iio:ad2s90: Add max frequency check at probe
Date:   Fri, 23 Nov 2018 22:23:08 -0200
Message-Id: <20181124002312.6923-4-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
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
Changes in v3:
 - none

Changes in v2:
 - Correctly credit Alexandru as the patch's author

 drivers/staging/iio/resolver/ad2s90.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index abb9b9147ee6..4721e9bbb8b0 100644
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


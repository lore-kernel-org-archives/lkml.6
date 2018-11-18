Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2629C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F1520817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="x5qK3ea1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F1520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeKROpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34021 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeKROpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so43891843qkg.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92hEpUjcQ+pvw5q1KbpaiTWMOvxRsoylduY2Id7AaiU=;
        b=x5qK3ea1E5jWMW7V6NwP1yGgrKzudigz0P1OEY9Hf0MF0XxIJ7ZS/daZlYTGnsy3Mn
         EjBzKnUhj8GaGjv+P9kEGs5O/jM20n0VFCxgiar304c2IljdgmSw/EW1o6RaoLB3vB3x
         GcNPIWPaqnEVTj0ROb8BvxCR2SY1C4d6UlrTI3Gpuv6QTjMiI89+ikvrEtpV2U2m3Jis
         R88iZPYNtQ0fTPmA+QHs2trFruZEW5Orv2J05Z9wL+QSjPcY2sBb4gOTKoQ6OVqy+2wd
         WxP/mh3qKFJVMXdkCijz/SbMcyuI55l+Zp6ETDV3GPyrvWWb6m9zASakp6qJMtde25qu
         hsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92hEpUjcQ+pvw5q1KbpaiTWMOvxRsoylduY2Id7AaiU=;
        b=L6XBDxr4nTy2vBS62qRFrvXJ2+74F78aKQ7TpS4pjL9NWHsyJLW7XfahV70S3phmOS
         E809V2wBLcVmfmUi/VMFfhKwPfEIVyCUxNpyDVTgXCUzKipG+DkzWRfvzPyTMWW4+drU
         X10pUmEtJDndy4lffW7Gf/XZ/v9VqYTwK+KOONYcqTs9oyimu3wvXAMyJ6PozIL2Rpkm
         MGJK3S4aPgKJOngxVQhUcj6v5Y6OpmklG1FB5zzPnLRDBMW9w5ZN1cASqjM333v0cLEb
         5kZwQbejdPilSaYhEheeSMmh0TsPuA5wysruf7mI24glASj+2iMlV3zhWSQ2pukn431E
         fF+g==
X-Gm-Message-State: AGRZ1gL75BdTIO1Z2dpXtX5JezfjCQ28I1aK0ISnVCHr3QKsf/8e5s0k
        BKiFKC17pmevO1v8j+mYSsw9IQ==
X-Google-Smtp-Source: AJdET5fHwCyz1wA4p4NwFIBgj0V57eGPzRJlSIHoWfqJmfj7aOLPK/wSbiT5kwQwrsYrQ4fXRy6qmg==
X-Received: by 2002:a37:d947:: with SMTP id u68mr15782064qki.296.1542515175340;
        Sat, 17 Nov 2018 20:26:15 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:14 -0800 (PST)
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
Subject: [PATCH v2 1/7] staging:iio:ad2s90: Add device tree support
Date:   Sun, 18 Nov 2018 02:25:34 -0200
Message-Id: <20181118042540.12697-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree support to ad2s90 with standard
device tree id table.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2:
 - none

 drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 3e257ac46f7a..6ffbac66b837 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
 	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
+static const struct of_device_id ad2s90_of_match[] = {
+	{ .compatible = "adi,ad2s90", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad2s90_of_match);
+
 static const struct spi_device_id ad2s90_id[] = {
 	{ "ad2s90" },
 	{}
@@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
 static struct spi_driver ad2s90_driver = {
 	.driver = {
 		.name = "ad2s90",
+		.of_match_table = of_match_ptr(ad2s90_of_match),
 	},
 	.probe = ad2s90_probe,
 	.id_table = ad2s90_id,
-- 
2.18.0


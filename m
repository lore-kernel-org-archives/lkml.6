Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A0D205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly2ab+nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A0D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403861AbeKVXdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:33:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39871 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732044AbeKVXdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:33:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so6778684qkh.6;
        Thu, 22 Nov 2018 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=N5BYfhaili1lwXz1KoG3A88TY1sfj7lWYL9UQZ3Q6yw=;
        b=ly2ab+nJXF6i25irz4/YXrerpGuUNWI07zfWfEfQbnuoFI0j7sxqsC3lWUffJ5MAnv
         p0pc7tcJ6zjPXoMEZ/gU/Xpidbqs6FhErZ6bXZn2So6/IL1+2bp9PDOD0+Q7HzLgFUrD
         +UqGErsvm/aDOdIPs/dhNwgGYG90MJfe6DWMGe/1zCdWaVyno4aPsySkzrWpcJGuAaHj
         yi2i3sMn+eX9AR6/l29tUnb5ZqCLkAmkBe+uXKYjSXra770nk7j4scRRT3CJXEiFioDl
         TDXKg+c/m3M5wGlKRLEbXtvLoG0fuHq7qDyC2SEmKFSwqjTqRS1PejxgI+MyAgDmO/nx
         7Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=N5BYfhaili1lwXz1KoG3A88TY1sfj7lWYL9UQZ3Q6yw=;
        b=BMiU5e1GALcYFWZvd3sWKxASkC1zIWD6i3MVG44EyMOpETwRF6F8hBDQreb6jMCqf+
         XSBJCGKbuO97TrMr4ISpFLH17BsmDlU/wfCDg/XWp4VDRnC7KvE5et9Ahk5IP0aJYmul
         p2WI2+TC8bVHSRBzYRlwqFA787yUaac1/z2im4BhLAenZsr+zjCgk+A+jHlel2brrFMd
         G8a1lgAuzfbywwLQ6TOf+Fz7HbcNDShrAs1YwO5jsitO2JVwhnP5MT/OKPitotB/mqe/
         TSNTvPBLRySF5jsT91oiePPeyIIhcei9x853dNJRE2t3SSYf34jBDBeCm+N5bgVdLf74
         s5+A==
X-Gm-Message-State: AA+aEWZcgDKMLWCQoPrh+wtqZRF7Jj7AJEPPPGTMzjhvc+7bR2IGXR9L
        H9S+fjR1kVw3n9jvv5CqM5Q=
X-Google-Smtp-Source: AFSGD/UGLdlwJYFxXuP4pfFUxsu0zoxYCe+mRxhfs/4XIH4vHVhjIPHNA6pfeLF3HX1s8Pki/154Gg==
X-Received: by 2002:a37:52d6:: with SMTP id g205mr9677809qkb.335.1542891233513;
        Thu, 22 Nov 2018 04:53:53 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 24sm46903730qkp.65.2018.11.22.04.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 04:53:52 -0800 (PST)
Date:   Thu, 22 Nov 2018 10:53:47 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad5933: replaced kfifo by triggered_buffer
Message-ID: <20181122125347.sn2oqrw7fyb4corf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, there was an implicit creation of a kfifo which was replaced
by a call to triggered_buffer_setup, which is already implemented in iio
infrastructure.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 .../staging/iio/impedance-analyzer/Kconfig    |  2 +-
 .../staging/iio/impedance-analyzer/ad5933.c   | 25 ++++---------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index dd97b6bb3fd0..d0af5aa55dc0 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -7,7 +7,7 @@ config AD5933
 	tristate "Analog Devices AD5933, AD5934 driver"
 	depends on I2C
 	select IIO_BUFFER
-	select IIO_KFIFO_BUF
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices Impedance Converter,
 	  Network Analyzer, AD5933/4, provides direct access via sysfs.
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index f9bcb8310e21..edb8b540bbf1 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -20,7 +20,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/triggered_buffer.h>
 
 /* AD5933/AD5934 Registers */
 #define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
@@ -615,22 +615,6 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
 	.postdisable = ad5933_ring_postdisable,
 };
 
-static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
-{
-	struct iio_buffer *buffer;
-
-	buffer = iio_kfifo_allocate();
-	if (!buffer)
-		return -ENOMEM;
-
-	iio_device_attach_buffer(indio_dev, buffer);
-
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &ad5933_ring_setup_ops;
-
-	return 0;
-}
-
 static void ad5933_work(struct work_struct *work)
 {
 	struct ad5933_state *st = container_of(work,
@@ -744,7 +728,8 @@ static int ad5933_probe(struct i2c_client *client,
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
-	ret = ad5933_register_ring_funcs_and_init(indio_dev);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, NULL,
+					 &ad5933_ring_setup_ops);
 	if (ret)
 		goto error_disable_reg;
 
@@ -759,7 +744,7 @@ static int ad5933_probe(struct i2c_client *client,
 	return 0;
 
 error_unreg_ring:
-	iio_kfifo_free(indio_dev->buffer);
+	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
 	regulator_disable(st->reg);
 
@@ -772,7 +757,7 @@ static int ad5933_remove(struct i2c_client *client)
 	struct ad5933_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	iio_kfifo_free(indio_dev->buffer);
+	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(st->reg);
 
 	return 0;
-- 
2.17.1


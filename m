Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF60C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12421208A3
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="fffYERGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12421208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeKJHoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:44:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37045 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbeKJHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:44:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so4350892qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MSlin5B0a6rI0+juz072I5/ZS+PXCrHG9HcXDmJFVy0=;
        b=fffYERGGl4klbiOHWvPifaD8udAr7P8XbIpKfhfLedTudN8DLX333DN/2mKfss8Pqz
         MWMp1Y3NzfqHmXfeSAhlivp6wpbdjX8eJ5aZr2LvDaAzBawmUEXbc7q0wo53EopmfjCS
         wFEHEdDc8UwlFLa/vEYpJZYswFW8KwGRIGGEFT7l51seIpfj+GfCGNf3YAMRXvSoIzRZ
         i9nrmiGfq8AA4FrUDvDFAe6eidNRCeew7FZ/A5KvtDRFscLE+Qi8pTJT5urPAYP+syz6
         hbgP5gwA+xVbgVOibqAg4CO0aVqNl8bxssOprj71zNV7O7Wzy+m/8OTeNxvL/cGc6mlP
         TH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MSlin5B0a6rI0+juz072I5/ZS+PXCrHG9HcXDmJFVy0=;
        b=FKVFeZO1bl3dkkBhiwaY12OzUEEfVIJ9Xjiu2hyQ2aN/KdWgacOjYHhsCZZCNfvGmJ
         cjr/we6aeeT3zkqQStr/OMIVR2Q84VJU0WslO9qyox6wtVaMy7qd3HzAYite5PVs7X6j
         H9uhXGtHBoPYl1caz5Vje01r3TFIclcVxZ4sFJ2Q/uOO97fVdYq3GoQvpeWSDlYfP0Kw
         wvP7U7sftZgxcTjmpA4r5+ySbE5CF1lz3NpbgBkFVia2LjvAe9F1AY0/w6ieBHouxO33
         m/hs6rEEGB0enaJGOp3s3aA1jVkqH6x79fxDVYtUYlzl/xCpS4B8Ix3F5deeFNuwYaeF
         mfcQ==
X-Gm-Message-State: AGRZ1gIA8s/QUPagO629aV5ASKU75RHkyzlK72sEAWsXoG0LDEU/TT0i
        irOyx2GjpDv2p3wUmdFeSi/5jw==
X-Google-Smtp-Source: AJdET5c7OjS9+1QzyBibM9oyQ+s23wLvblv+dJDoeja92/0ZbFSUI1ly1SL4hdLRfQudQMwVLK8oOw==
X-Received: by 2002:a37:b405:: with SMTP id d5mr9941364qkf.162.1541800898308;
        Fri, 09 Nov 2018 14:01:38 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id k6sm6082723qtk.41.2018.11.09.14.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:01:37 -0800 (PST)
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
Subject: [PATCH 6/6] staging:iio:ad2s90: Move out of staging
Date:   Fri,  9 Nov 2018 20:00:44 -0200
Message-Id: <20181109220044.24843-7-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181109220044.24843-1-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ad2s90 resolver driver out of staging to the main tree.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
 drivers/iio/resolver/Kconfig                | 10 ++++++++++
 drivers/iio/resolver/Makefile               |  1 +
 drivers/{staging => }/iio/resolver/ad2s90.c |  0
 drivers/staging/iio/resolver/Kconfig        | 10 ----------
 drivers/staging/iio/resolver/Makefile       |  1 -
 5 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/{staging => }/iio/resolver/ad2s90.c (100%)

diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
index 2ced9f22aa70..786801be54f6 100644
--- a/drivers/iio/resolver/Kconfig
+++ b/drivers/iio/resolver/Kconfig
@@ -3,6 +3,16 @@
 #
 menu "Resolver to digital converters"
 
+config AD2S90
+	tristate "Analog Devices ad2s90 driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices spi resolver
+	  to digital converters, ad2s90, provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad2s90.
+
 config AD2S1200
 	tristate "Analog Devices ad2s1200/ad2s1205 driver"
 	depends on SPI
diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
index 4e1dccae07e7..398d82d50028 100644
--- a/drivers/iio/resolver/Makefile
+++ b/drivers/iio/resolver/Makefile
@@ -2,4 +2,5 @@
 # Makefile for Resolver/Synchro drivers
 #
 
+obj-$(CONFIG_AD2S90) += ad2s90.o
 obj-$(CONFIG_AD2S1200) += ad2s1200.o
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/iio/resolver/ad2s90.c
similarity index 100%
rename from drivers/staging/iio/resolver/ad2s90.c
rename to drivers/iio/resolver/ad2s90.c
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 6a469ee6101f..4a727c17bb8f 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -3,16 +3,6 @@
 #
 menu "Resolver to digital converters"
 
-config AD2S90
-	tristate "Analog Devices ad2s90 driver"
-	depends on SPI
-	help
-	  Say yes here to build support for Analog Devices spi resolver
-	  to digital converters, ad2s90, provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad2s90.
-
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
 	depends on SPI
diff --git a/drivers/staging/iio/resolver/Makefile b/drivers/staging/iio/resolver/Makefile
index 8d901dc7500b..b2049f2ce36e 100644
--- a/drivers/staging/iio/resolver/Makefile
+++ b/drivers/staging/iio/resolver/Makefile
@@ -2,5 +2,4 @@
 # Makefile for Resolver/Synchro drivers
 #
 
-obj-$(CONFIG_AD2S90) += ad2s90.o
 obj-$(CONFIG_AD2S1210) += ad2s1210.o
-- 
2.18.0


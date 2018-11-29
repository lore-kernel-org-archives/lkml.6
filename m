Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CF4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAEC20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AnYRycjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAEC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeK3HQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:16:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39410 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3HQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:16:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id n133so3524263wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 12:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Y7iVZLmo1S+LvOPrUEpfhtf75Jii1SvY+XXo5xxEb7o=;
        b=AnYRycjZdtb1VvAuoVyGpR03e2fT/T1Z4kk/hMjDkXpjGOtgdI2HlxVJAoqTcsPh44
         ffVkFfjh3PXnaD8wRzJ9gMqz8PHNPfQVBIaEz6QJneTVnioj/N+Q64faS8z2Exs0EIJ+
         TiT6eJPnatwzYQyAmVCnfHLbh0SqnOsRWNBpd4tzPUgStRd3FCni2gg/13B2lGmuoYr4
         juy4d4IAm1fMVuvd/tqbfyaveelaTiU7JeRzz9Npo308mUmBygDaAzUit5NM9FI159RT
         mTfuOiBOv+4RZLV+GtXEXjkr693HMJycuPag6MuC0UdXWjIBdjQbqVOqwa7BpgmZhjN+
         6hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y7iVZLmo1S+LvOPrUEpfhtf75Jii1SvY+XXo5xxEb7o=;
        b=dMjWb9hU2bjQAwbgWHAQMFkaCekzB9eoEYMtYDIiGmWM2be8oQf120FpvfM6JbBTds
         9pvR1M+8RLTplX78KUeKwJKAr9DA1ypXfCccOVs70IFJmM6Agrc41r3KHmYkp/KZJZ4R
         uhEcyNx3lXvgu8DcnnhbRhjUuyG3s+CUEMWYN+Dh+I9IGwyidxnma+0hCkHaiYTi2uVT
         RC1CGUw+GOSupXsvX6Y2jtM5yvu8SX3lOjtIMQcwPjrY2NAOKI59jW0wMWbPCnUeDAWs
         Lcn54v+7XkGe9S1hZxCehFmLUTkPQcIKWf513pp6nXTZ7XmM/0uRU4tAI6DbuCV99Qpd
         6EjA==
X-Gm-Message-State: AA+aEWba5iNYZWogFCLKynWb/q1QRet3VPtY4PazpdDprG2IeTI0GrhV
        ys079CxoH+ouuhzb5CXe2wfiow==
X-Google-Smtp-Source: AFSGD/W3sclXFlr4Se0Q7MDQyGP1wJMtCnB3OmMQkRbN46rT0xp8t6UFQPh0y8wy7jNQmg4svR9n+Q==
X-Received: by 2002:a1c:d14d:: with SMTP id i74mr2875366wmg.100.1543522166820;
        Thu, 29 Nov 2018 12:09:26 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b131sm3751380wma.21.2018.11.29.12.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 12:09:25 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] hwmon: fix typo build -> built
Date:   Thu, 29 Nov 2018 20:09:14 +0000
Message-Id: <1543522155-17406-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a typo where build is used instead of built.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/hwmon/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 532a0532d01b..100b7fce1412 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -179,7 +179,7 @@ config SENSORS_ADT7X10
 	  This module contains common code shared by the ADT7310/ADT7320 and
 	  ADT7410/ADT7420 temperature monitoring chip drivers.
 
-	  If build as a module, the module will be called adt7x10.
+	  If built as a module, the module will be called adt7x10.
 
 config SENSORS_ADT7310
 	tristate "Analog Devices ADT7310/ADT7320"
@@ -242,7 +242,7 @@ config SENSORS_ADT7475
 	  ADT7473, ADT7475, ADT7476 and ADT7490 hardware monitoring
 	  chips.
 
-	  This driver can also be build as a module.  If so, the module
+	  This driver can also be built as a module.  If so, the module
 	  will be called adt7475.
 
 config SENSORS_ASC7621
@@ -666,7 +666,7 @@ config SENSORS_JZ4740
 	  If you say yes here you get support for reading adc values from the ADCIN
 	  pin on Ingenic JZ4740 SoC based boards.
 
-	  This driver can also be build as a module. If so, the module will be
+	  This driver can also be built as a module. If so, the module will be
 	  called jz4740-hwmon.
 
 config SENSORS_JC42
@@ -1594,7 +1594,7 @@ config SENSORS_AMC6821
 	  If you say yes here you get support for the Texas Instruments
 	  AMC6821 hardware monitoring chips.
 
-	  This driver can also be build as a module.  If so, the module
+	  This driver can also be built as a module.  If so, the module
 	  will be called amc6821.
 
 config SENSORS_INA209
-- 
2.18.1


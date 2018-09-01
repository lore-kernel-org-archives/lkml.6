Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF15C43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF6820837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 19:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THu29iBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF6820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeIBAIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 20:08:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33422 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeIBAIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 20:08:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id m26-v6so12418986lfb.0;
        Sat, 01 Sep 2018 12:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Nu4mG2YEC+XqIZF5dtbE73ECU9uVUNXUTZH3G0MZCes=;
        b=THu29iBTnT7z1kad85yvx/gUzE3dK3NpXfQXBa+wmScqWs9Uuo6Zf1XfNxGs+wOYhM
         3rQYRbG90OyEJEqyHhayv8BBTC5PaVkunvUNSgXbz3Sdqu+x1ZOUQKRt3nps/o4U9L79
         Cn9l/x6OEAX1ONPvZydxKyhpuB1Ax5kzz1k5xTeFYBcGgzs+ml97adKFM/BppSDUNyY2
         BR+W9f9BDIgKXMtIWzBIGdMwp6TcvfceUpBkIzFeXnhawJuQC2/BtYlHoVPyg6nb+9PU
         wuKa4tzsOufZegXdCSn84npGlIiUXMQsqNFNDUl0A65/LeGe0n8gO0HY4iLfATN9Og6H
         LJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nu4mG2YEC+XqIZF5dtbE73ECU9uVUNXUTZH3G0MZCes=;
        b=q7fvMh4L6kVzSr8yQp+agpORNNOW+9y7Im4Cj/5e3Dj7jJ2EkeFxlBmGogwDs1Vrw/
         ORWvrXwfv8CwuGmoGI7fqLKsz7OMB5fsMVaRV3wqpfO4gQUTr8l0D/v4trXvHCEUhvFk
         BVzXohW0VyUHTFzZlDfs6PKL6I9YC8WQNLjA10hJR4wuzURuL4CU2kpmYBkOq5dpFki8
         y0NkWPMglAlR4PFT83hX7+8A3BTcl26LDZ5uIcM1Gi2mRfeAvaBWORWngOnziSeMdiXg
         6nG+oQjBOkT9Nu3Eu9jqknjaqExuCsdBqHwcR3JYVzPKThByzUvy3PsdPuNAKqDIUUXB
         uQOA==
X-Gm-Message-State: APzg51BvQEuFi64O8AEq1Eu2K25uRNVWG2UGQHqsLacQZdcXFQ2lPOAD
        RMPgRdi2C/X+CPbaYbvphiqr223d
X-Google-Smtp-Source: ANB0VdYmltZM2k9krqBu+warGjtviFf3QXbZJ9erTTZnRI0CxJifL5qLPRUp70WgQOxZTH4f9nTMug==
X-Received: by 2002:a19:ce50:: with SMTP id e77-v6mr11778706lfg.81.1535831695972;
        Sat, 01 Sep 2018 12:54:55 -0700 (PDT)
Received: from localhost (89-70-31-6.dynamic.chello.pl. [89.70.31.6])
        by smtp.gmail.com with ESMTPSA id e32-v6sm2605186lfi.12.2018.09.01.12.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 12:54:55 -0700 (PDT)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: ms5611: switch to SPDX identifier
Date:   Sat,  1 Sep 2018 21:52:14 +0200
Message-Id: <20180901195214.11485-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop boilerplate license text and use SPDX identifier instead.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611.h      | 5 +----
 drivers/iio/pressure/ms5611_core.c | 5 +----
 drivers/iio/pressure/ms5611_i2c.c  | 5 +----
 drivers/iio/pressure/ms5611_spi.c  | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index ead9e9f85894..c9dd86de3ade 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MS5611 pressure and temperature sensor driver
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */

 #ifndef _MS5611_H
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index f950cfde5db9..2f598ad91621 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MS5611 pressure and temperature sensor driver
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Data sheet:
  *  http://www.meas-spec.com/downloads/MS5611-01BA03.pdf
  *  http://www.meas-spec.com/downloads/MS5607-02BA03.pdf
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 0469c8ae1134..8089c59adce5 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MS5611 pressure and temperature sensor driver (I2C bus)
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * 7-bit I2C slave addresses:
  *
  * 0x77 (CSB pin low)
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index cd11d022208e..b463eaa799ab 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MS5611 pressure and temperature sensor driver (SPI bus)
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */

 #include <linux/delay.h>
--
2.18.0


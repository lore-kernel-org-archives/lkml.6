Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65890C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0062087B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oMjIXzI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0062087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeIGOsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41015 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbeIGOsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so14361670wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XBcxKh4doOX0pFb3D6b9lBHWHCCUYHWbQQl51CV8SWo=;
        b=oMjIXzI+g3jX1w8LqEXDQYipq1KEZV1+UkCQpXs3M7JyKWb4FYAQCtvH7U5V5gNgLZ
         5Xstco+zLKBqiRuj7W/2TluKUNat/DvRp+pjNzwqLd+ZNeTbW+4JzBPl4bSiExjNCggj
         XpUYA5PAdz/CdxvpPvIvscDwpUkhLD/RRALRBC94Iy/1dlW6urIzFlEB0gwn59tMZ/5f
         ZZkkDME3kfRx4XCn1UGA33NgaZUWaFMhGUNhS6toiYvh9sXIKBEBAqzP/YgVSE6MDrtT
         +O6y1R3stoO69makJNcD7kh7BWFa+04AWe03RBy+H/PYVwyJKdhjKKxPkWjHg/E4VAIp
         UPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XBcxKh4doOX0pFb3D6b9lBHWHCCUYHWbQQl51CV8SWo=;
        b=GvoqaFDGJkfjYmlprbPD1W+2ng2DcPTmLFSOaL8RRJAIQf65ldw8yBCrjTkTqffZdy
         4n0H6A07oWpoEykEPISUqq2bjMbx7MyKV3HOZTpHHLiqhx9i7Z/lMD+/LzFjzMr60/ZJ
         6NDMnqUXYV23NHWACV4GB/AQfXI89mj7qgXcgrWCwUYIVNJvS1/DDQrvXqJPYAGgBKUJ
         zAl0nZpzsjWqRvnmTr+QDztfENzRVMJQrRppIuMvgJPTdPZgiOeyhVXae5xazEEvvzEK
         hDFFWSTnnor1RqSJth1ar6uBOrL1qh3v21XU+3iB6mVjbNAxbyyLz3P94WNPfTgaUqwV
         Xl0A==
X-Gm-Message-State: APzg51CdgyPRDAXUVusIxuNNcQR8gx8BzXGrkvESHpXOFEIz9nL0AZIm
        SCjTxfS5FGpGOWDKNGwHQCB7zg==
X-Google-Smtp-Source: ANB0Vdat07yXQ0BsQoo1LJ2JL8Qc2rVBPfxQ++3IBocgv/4ZMGTvtCrmgxiiAtcWkBo98P3+l59n1g==
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr5155295wre.115.1536314917962;
        Fri, 07 Sep 2018 03:08:37 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:37 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 15/16] nvmem: use SPDX license identifiers
Date:   Fri,  7 Sep 2018 12:07:49 +0200
Message-Id: <20180907100750.14564-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use SPDX license identiefiers to core nvmem files and remove GPL 2.0
license boilerplate.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 10 +---------
 include/linux/nvmem-consumer.h |  5 +----
 include/linux/nvmem-provider.h |  5 +----
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9e2f9c993a07..320b3cc975a0 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * nvmem framework core.
  *
  * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
  * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index be583c4eb2d0..4c146379b9ba 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * nvmem framework consumer.
  *
  * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
  * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef _LINUX_NVMEM_CONSUMER_H
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index d14a577a002d..171fb6caa578 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * nvmem framework provider.
  *
  * Copyright (C) 2015 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
  * Copyright (C) 2013 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef _LINUX_NVMEM_PROVIDER_H
-- 
2.18.0


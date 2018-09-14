Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6D5ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471D5214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OAompkBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471D5214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeINTzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39751 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbeINTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so10880353wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ujFzkuZMMLmXfVfLF2lfmeu9c3YEpE3NecX6O1UeHlg=;
        b=OAompkBlzUe6jIx8tDFhyLc+feF0D6RjhKt+SaoxIJlxgpk1iyFjqtoJrUq/CWKfaV
         xRFWEjUczPc76/xwEWzOU2cPz9x4VL3jZjZi8fVBAIBrtaq5aWIItbfHlZyr1QgOl6e6
         GzSxM/E+QUzAjr/DjI2KcRysFXWs0Y3iGVXAzCtTtD51qEbWVT6YyCnQacaupwI0EV4m
         dzveXvWdNCVn/Yi08U+GefqGndeEkjHqTT5dZEYDOv+wwRvD0Z74Xbeq2TNDbH8Rcrkf
         3NvCgNzaxbQ0BQluKsRjX98CoOwrWrxfDlcQ3eoKRwDDU0Tr4dC4coAtTHGyUgMuaWdA
         VVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ujFzkuZMMLmXfVfLF2lfmeu9c3YEpE3NecX6O1UeHlg=;
        b=Fcox7AP9lIu49IK5zMECXFwTwwxb4XDtY8xCCDinKBhrtBmLToR83p4b+Frm5x/5gG
         fDCZAuxuTjXVSY+1srA1Ivop/HD4esUj1rO9Q3dqmDoA2NbQKxI8iRHnRiSJ44KKGnho
         a7M8T1wkYTk5bnYzBQ6UCRDd02PV+wLDHXXkvYq5FDwJKrV6UiTma7QndlSbWB6yr6hm
         v7kIPVGElgvQDA9EOoacMs7SsbrsgBM2t0XaHu9/EuVljkp35OR0fuXeHHuG7FjbrOt3
         C1RWEDJoaXdN2nVRLw/lT5upRwb1jfGAxio+BkGv2FL9b1u840/sQlnQ9/Nmc6N/Kequ
         5m/A==
X-Gm-Message-State: APzg51CjUCJt4dkE/TX3s3NFJUof9ejnzEbJ3o7EBPPyMupUTIQltW5Y
        2OPdKRjz3GBLZ/cBBUhXcAeGKQ==
X-Google-Smtp-Source: ANB0VdYfKVXK35963rQ3LpNlbAOqtyE1CvvdkM3Q9+pE6Hz4KU0cHlPfk8BBh5Yz3U0lQXahzwcgXw==
X-Received: by 2002:adf:9b9b:: with SMTP id d27-v6mr10131493wrc.240.1536936047662;
        Fri, 14 Sep 2018 07:40:47 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:47 -0700 (PDT)
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
Subject: [PATCH v4 18/22] nvmem: use SPDX license identifiers
Date:   Fri, 14 Sep 2018 16:40:07 +0200
Message-Id: <20180914144011.27614-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
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
index da441019b609..ea05219e60b4 100644
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
index 0326b52e906b..d18caae2f7ac 100644
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
index 5c9f205cac8f..8ae012f6545a 100644
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


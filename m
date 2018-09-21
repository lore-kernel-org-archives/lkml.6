Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65013ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC3821531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="OvbxD4w4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC3821531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbeIUNR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55589 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389592AbeIUNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id f21-v6so1925798wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ujFzkuZMMLmXfVfLF2lfmeu9c3YEpE3NecX6O1UeHlg=;
        b=OvbxD4w48xlLdUjHcuGu7BF18SmgVQUlpff9bmPW0urV3p91CPt//5rIVYaL8so5af
         cvoiwx9KQBgHHLbGTmxLK8xx2iFU1tATNF8vXDwrU4OzIwrp3jEwiIJTjGHGp21rvds2
         EHABchHXxEuk87dLL8WFG42+4rpX3rGwC6AkIkR2VakokgzB6ujhouXbKm6T3K34Zvt8
         QUSLisIBRZEACAFQfYDc8Nj5608CPWpVj63Wnj6e+0hWjGKMaZs4jfqVbaVCoLbXRrfx
         EW16d21kIqtNlU1EcHlOI9DCRqCh3rQeUVNvyVXrUycrKPoEfPQjw9JydehVcwM9+bAW
         8lEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ujFzkuZMMLmXfVfLF2lfmeu9c3YEpE3NecX6O1UeHlg=;
        b=IRdIKn6Zm22SK6FCRdMHMN6lwHCuY2czbjyVI0IVGbKgl5PuAEfrsmvel2wlQCGCAm
         5G97JEfG6nKm0/o6dPro1usPrjLy9dAsIRLDoXDxWFkMYnK2YAnt4kNCe9jsJtlGYGof
         M0sZem3bxqALxfbxD7M1MdYTQxwHIxBdk4ALlZNhqCFTHkSkt9CGox9pT4Lt+t0GHZom
         IcYHIwKD5X29K/x+0nisXcG+8UrE2AtHNwhBTdA5S8WhZrl+8p2zrd8/yJIAsd/w0GGa
         p2B5osKBQpbBfN2I3Q/jR7VE3CMaq/BJTwQM/PWQlz+B1QWOmkzUEZ+1KMQUxaNQ/z/i
         uygw==
X-Gm-Message-State: APzg51DZg6ozGLvwzicQxeOVLaJAwDGbeLOYgfHYpmSDRIxnxjTmo/6d
        UuclYKwy63vtbB10ZF8RaTTYJw==
X-Google-Smtp-Source: ANB0VdazdE6y91UPIGNmhvum39ncgjWGTXJ4b85md0eIb1eh9ts6RljZsZqcWsz+ht99a4CbuWn8Iw==
X-Received: by 2002:a1c:e70b:: with SMTP id e11-v6mr5705782wmh.22.1537514991003;
        Fri, 21 Sep 2018 00:29:51 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:50 -0700 (PDT)
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
Subject: [PATCH v5 18/22] nvmem: use SPDX license identifiers
Date:   Fri, 21 Sep 2018 09:29:17 +0200
Message-Id: <20180921072921.19387-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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


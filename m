Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F3DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F69C20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PikW2ube"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F69C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeILMzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37867 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeILMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so1236410wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2HBpc2YKxYR/tjo9IhbY5O3/7V07JibCmPgWrXK4lkw=;
        b=PikW2ube6WJAvVWGLogrg3XfZycTdrtz6op3nD1Sbv/v8Y6X0Oud57YfsyhfUzMjwf
         bNYejvu9Xgafgej+bcWZFrEkFqPDIuwXM4nEz4/nxqV1tl15kOw33PjDZilW1xPL6HIx
         +01dzgfRoq3/T82x98kI0p3OTxB2mjwX5zZOmZ1K6H44DpyfnGoaqjezNgvIileaU0vq
         dLH2lB/VUGjyXz0Ew70ISr1bfe1xpeD/iC9WgxpggpesYKW2xw6OhSrSMTbQA34AfKn0
         RmaDBnFx9UMKkbcqQeHFLaE0hthEdsiuHEvtaXPPe/90/VmqGosJ1vtNAjwTcOxzqJoZ
         PI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2HBpc2YKxYR/tjo9IhbY5O3/7V07JibCmPgWrXK4lkw=;
        b=EepBF3UHjQvzSVz9tr6jg+Tl2qSLCkVXYJK0YwiOWYHqlAI0kzmQ2xQ46QgO/XdryV
         eZCF1k3xwAbbxr9oSdfjL5JA5W4uFYptKrCS9eJL2+uo44UNDaqkjSs3fjXDqHfCt8u1
         voQv5RMx2CISanWnBaRxfZyPGB9Zomo0asX7THdcPBUY4zVPD8Jnlq1QzfjdpEngDfPJ
         6eN/D+wKJCdUHjOaeQZsS8o7NG6RjhTyZvMz3YxBVHkMsr5uHiT2vEMMYDJ5DQC11ZUH
         Ce70J0R8FrqEu5IUvl0PxvFfmB/u+0Wrye6lNFhRu5LKrsr186VQa/+Di3ubwjhqxohp
         0Spw==
X-Gm-Message-State: APzg51BzyPdTMFrlQEUj7U3Hbp5LtfbOqlLgyZWN/A122FQ5kjCfrPkZ
        j2h22GP8IvQjqOTYn2SO5lyG4A==
X-Google-Smtp-Source: ANB0VdZmEUw0rcCxeV0+WQ2zwolNvHKn5Gj0CqKQIYiRD74eiXi+m/pYWTRnnRgMpWQZltQhlx8DrA==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr759896wmf.43.1536738731380;
        Wed, 12 Sep 2018 00:52:11 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:10 -0700 (PDT)
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
Subject: [PATCH v3 17/21] nvmem: use SPDX license identifiers
Date:   Wed, 12 Sep 2018 09:51:25 +0200
Message-Id: <20180912075129.25185-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
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
index af6f7163cb67..6cdf4f2678f6 100644
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
index df6c102b421e..d37785afd14d 100644
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


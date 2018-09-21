Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F87C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54EC2086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDFbQw6m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54EC2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390374AbeIUT3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43795 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389657AbeIUT3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:53 -0400
Received: by mail-io1-f68.google.com with SMTP id y10-v6so12200613ioa.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1QUCykCd+zPbMYhS3RXT52FLcWJbeQ6yo4GZXbZwr1A=;
        b=hDFbQw6mOibqPkrlpjjf/6dkuwdxVYdllNgBKp4+vJ06ncLmGBIzI5xVjW97HhJQm7
         du2eteRfuzrbJ0OPOlp6LOPEKsk800KOSkNCF/xmElrKP+1z5qqBpQ59tWULcQUEMvAW
         iFfB4+7mNt9ONUt/Wmvcr9PA46cRt44ngpDEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1QUCykCd+zPbMYhS3RXT52FLcWJbeQ6yo4GZXbZwr1A=;
        b=ItyXzRce+1EIgEtfsI6QThMKbseUjZfxhnfmI6W3UwdF9KxwSSdFZ0VXGqg9gWYZrq
         2L/c/NwP9QOSrUqBpwXdHyLJjVUZZaLl5D4s2X6arwQz72PZ+wA9MRV3AfndTNmpihOD
         JjXctVhP0yJ8uFWSf/mwBM07HsDlhd9SC9NrqezR1rU8wbtOmUEHw+A9GJme//cKYJM9
         mbV9KlLpqYFCBUudz+n3hWbjeTpkXArzfLgVubr7CVO22O35MXGqv2W/lvzl5oYildUe
         MmSpBt8VmsTluL9XKWCGjZ4r002mAdeIktClH987LsBrkovWsnugl7/xGjwkrHemS8GZ
         c1+w==
X-Gm-Message-State: APzg51DX1DY6aMHsuCQQcEkdrcrYMfKFvdGvWxZXQx9eidsIv+vNyucE
        R8XQYKy2wWLrTQJOC23HBJG78Q==
X-Google-Smtp-Source: ANB0VdZWCnHCthhqiJP1KbaYlhqY32DlYUGkje5Nh3y4deGXr4rpJHTblgRI+oDxBSptlAiivLs+SQ==
X-Received: by 2002:a02:b690:: with SMTP id i16-v6mr8785127jam.18.1537537257453;
        Fri, 21 Sep 2018 06:40:57 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:56 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 20/26] nvmem: use SPDX license identifiers
Date:   Fri, 21 Sep 2018 06:40:20 -0700
Message-Id: <20180921134026.4596-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use SPDX license identiefiers to core nvmem files and remove GPL 2.0
license boilerplate.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.19.0


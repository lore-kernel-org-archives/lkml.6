Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A226C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438AE20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="tCVILVZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438AE20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIKRHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:07:47 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37161 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeIKRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:07:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20-v6so19047107edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrXQnSirJ4NJmgGLaFMerZuCqF7pw7ztJcA9jNm9mc0=;
        b=tCVILVZCHj3rnts48MyJjcrsokzhyUGOnkv1APxVFNeRDzej9WhT94OPYxGw1AmNk0
         chb4XxM11duEV2AdUwhYIhK81jC2rJ5TvgHMgN9UUNjGiAQeaJT9nco7rIAPTQY6s8Tf
         hSisBlD9TieYfi1GnfBRXx9MzRv89xqk6pJd0UzjYJ3CR7IC81DAyCLPlTSTYtw4+lVT
         dNVBOsTkvfcEtBbejq7kumYaMStU7Q46bRSyXngnyX58Jr8Ccbx82Tyxh+RYv79cTEhy
         TnQEbsS+eQzzQvZMbYon0zFJokYY00wvl3iaQZEuTBRjfveuP4u86ZPcfOrluml0jTge
         LSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrXQnSirJ4NJmgGLaFMerZuCqF7pw7ztJcA9jNm9mc0=;
        b=m9IWjDPR8GU9U9YlN1waC8JHYTZucjAV5qO5fPKFzspCDdjKV9G1SSVZ37OieB6EKN
         +geD6uuU/cLrB8c3uidlmI5fY/e9GoLVrNYY1r15hYNTkXwmMymUR5CH57d0bb/Ztdhx
         LDA59w7fkyN5+Qo622GBhwY8DcAll4sLCy73Hxdynf6PGxaxe8TEJdUmRuGy6E7WABMK
         gnasFWBIHg9cYbWs4Df5ZWf1mo+QYeRuxNFSt8OSyS2Q5RqdxX5CzVUBoIJSclajijEJ
         T56D9ckKgFsgZpQbBJzX3ar714xrTkhgazvkBxAeStDL4rxjNY/pHdnZzT/DoQ5Ikjyx
         fZmg==
X-Gm-Message-State: APzg51BU07Xr8uubZ7PKKydYGw+ad1s8hnDaV6x8P+l/bTD+RX4OGCp1
        K4XSHKOP9hHImC6liBzQeLpu7w==
X-Google-Smtp-Source: ANB0VdZuQPfhVsWFLfC/sjyrPND7J6hoqFKIDYRYEVhESP8KjCPqxfdzLxEIcnJi2PI9gvJ6wIYI3Q==
X-Received: by 2002:a50:8e09:: with SMTP id 9-v6mr27793868edw.101.1536667723063;
        Tue, 11 Sep 2018 05:08:43 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id h24-v6sm12309417edb.43.2018.09.11.05.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 05:08:42 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: add SPDX license tag
Date:   Tue, 11 Sep 2018 14:08:36 +0200
Message-Id: <1536667716-23004-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GLP-2.0 SPDX license tag to all pblk files

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-cache.c    | 1 +
 drivers/lightnvm/pblk-core.c     | 1 +
 drivers/lightnvm/pblk-gc.c       | 1 +
 drivers/lightnvm/pblk-init.c     | 1 +
 drivers/lightnvm/pblk-map.c      | 1 +
 drivers/lightnvm/pblk-rb.c       | 1 +
 drivers/lightnvm/pblk-read.c     | 1 +
 drivers/lightnvm/pblk-recovery.c | 1 +
 drivers/lightnvm/pblk-rl.c       | 1 +
 drivers/lightnvm/pblk-sysfs.c    | 1 +
 drivers/lightnvm/pblk-write.c    | 1 +
 drivers/lightnvm/pblk.h          | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/lightnvm/pblk-cache.c b/drivers/lightnvm/pblk-cache.c
index 77d811962818..74b912ee3c05 100644
--- a/drivers/lightnvm/pblk-cache.c
+++ b/drivers/lightnvm/pblk-cache.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 80f0ec756672..a23e965d32fc 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index e05d06bd5b83..2fa118c8eb71 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 532ee0834dad..caed18fabd35 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.c)
  * Copyright (C) 2016 CNEX Labs
diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
index 070ed53eca07..2f7ce572b29e 100644
--- a/drivers/lightnvm/pblk-map.c
+++ b/drivers/lightnvm/pblk-map.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
index a7648e12f54f..c26eab2ba8bd 100644
--- a/drivers/lightnvm/pblk-rb.c
+++ b/drivers/lightnvm/pblk-rb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
index aa345a4045aa..16294701a748 100644
--- a/drivers/lightnvm/pblk-read.c
+++ b/drivers/lightnvm/pblk-read.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 09015fd8e0f2..c562e1fad243 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index a32790f7b7fc..db55a1c89997 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-sysfs.c b/drivers/lightnvm/pblk-sysfs.c
index e56eeeeb914e..cba83ac43e62 100644
--- a/drivers/lightnvm/pblk-sysfs.c
+++ b/drivers/lightnvm/pblk-sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index a276f25d3931..277abc8633f7 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CNEX Labs
  * Initial release: Javier Gonzalez <javier@cnexlabs.com>
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 5e4cec453a43..127ee99c3efc 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 IT University of Copenhagen (rrpc.h)
  * Copyright (C) 2016 CNEX Labs
-- 
2.7.4


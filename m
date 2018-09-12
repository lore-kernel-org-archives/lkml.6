Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99364ECDFC3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526B220891
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xfyQEbeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526B220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeILMzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33425 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeILMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id r1-v6so9729018wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j5VzygIMcTmrTIR1xvM1gLa6GSilUZBltKq95M6HHPU=;
        b=xfyQEbeSSIOhQjPm2M8xq5IuxCUW5ZE+jrYMUGwP3JswQrO0gUeb/Jv2OpMJbnaKTr
         Z1sdPfWiFUDlfwsZjKmewnL7Q7QXkcUX2Hwv8tOrA0WWcEw+ou7nnkMxzZROeoXlSNoM
         ByaUpxUgEM1kfKM27VGv9yQclzOIs8AObHcJkiQES1Wwd9q0rM4AIFMsq4yoskYLmyeQ
         qWmXU5SfV3WRBLfl/zkMNw/Y8FxrLPFsaadkB06Pbvpw5Szb7SCff+5RaNVfzH0cI4Ek
         HxqFrYTteZ3hrXLDfdADqmu0NjWfF/gP9lIPPLqLtiqzOA5Kc2Ph6GrZYWv5oov2a1aQ
         mCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j5VzygIMcTmrTIR1xvM1gLa6GSilUZBltKq95M6HHPU=;
        b=mcH2CAGzxJ6FiXsMQ992FB0OoGCKIg15j8Y8z1jL7Y5TuB1kHMLsHUS6kz5uFuEPVZ
         WrAlHS5S1O6VimFDO6rVfD29MjvgUI4dDJsgUX0Ektzo5lQFkdl3laBf6UrucxJE9Ctj
         BSkdJ9RZnsxa/PSfXZlE4218/sTVIUmfYtpQQGDaWp4yt9lJ9POMljxWH81T9FzzOp7X
         1+CWeUlr7ccOhbpKxR1oVnnhqxkuitYY4Nux1Ak6iYddgFuAnbnRXwln2Y9cU3KBoLlr
         VM/soLukBw0Tnq4j3Wfkc/kyx/vw1dma5J+Ei7xUVwVZlLv0jKSXOFYriFQvVPrVcSzU
         Qlwg==
X-Gm-Message-State: APzg51A44jpLqJlFBzUZK3RZgj4oZ9mBQuh00OTGug/Ggem/ba/0olbV
        9Zw4EXFt8UOTxm4jNQ0bsY8OhA==
X-Google-Smtp-Source: ANB0Vda8BtBT8qIYWfYEgPeRr6DolxslojMdC1lgwV8UoYlyVe/XBQO0mNTIUzrRxo+dGlXRhXcrUQ==
X-Received: by 2002:a1c:bb85:: with SMTP id l127-v6mr696892wmf.156.1536738705210;
        Wed, 12 Sep 2018 00:51:45 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:51:44 -0700 (PDT)
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
Subject: [PATCH v3 03/21] nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
Date:   Wed, 12 Sep 2018 09:51:11 +0200
Message-Id: <20180912075129.25185-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the provided helper for iterating over list entries without having
to use the list_entry() macro.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 8987da0f7456..b69005367908 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -308,14 +308,11 @@ static void nvmem_cell_drop(struct nvmem_cell *cell)
 
 static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 {
-	struct nvmem_cell *cell;
-	struct list_head *p, *n;
+	struct nvmem_cell *cell, *p;
 
-	list_for_each_safe(p, n, &nvmem_cells) {
-		cell = list_entry(p, struct nvmem_cell, node);
+	list_for_each_entry_safe(cell, p, &nvmem_cells, node)
 		if (cell->nvmem == nvmem)
 			nvmem_cell_drop(cell);
-	}
 }
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
-- 
2.18.0


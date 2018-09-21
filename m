Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190CC2154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="l6jgU5P/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190CC2154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbeIUNRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37139 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389289AbeIUNRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id n11-v6so2050435wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gmEHeYY9IxtEv7acXzK+EsVXEYGbLWE40bwPjEV+sgg=;
        b=l6jgU5P/BpJ7tfErgDdxo+DIvV6gu9MqTS3Nbm+PsliH0m0rSnpXHDG2cflUpFNW/g
         rKrnXWPtAa9y1Ns3jMotD3npuU9EyQvVtSrIxJiSJBm5BLhofb+ezV8ajKXuSiSZnwtG
         G1l+53S3XVKZ0UMippHKLTudbEsycLMD9LcIyAhKE6W/BIHuK5ptkuWHe/YwnHbw7pPQ
         QY5lJ4rkLnb2mrB3cIaSAU+u5bAFLQ7oD9kR16WRRjElHj43GJ4726FBX5m0p8zpnbtQ
         6C15xHkOPLjA4oBk0sAgmE2qOuU1nD2jnEJPkWxR4UFr6zDaonpBgkZhAnc7pcSnstFI
         Pdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gmEHeYY9IxtEv7acXzK+EsVXEYGbLWE40bwPjEV+sgg=;
        b=AtPbDqRqqmBDCii43cFbvrmQwRUgcK1SOhf+87TlmJXWh/XCwTutOjHolauDhSCCFS
         fAkB8wmN1w/l2sK+FuvTndNcIjvX7GtLfCn3wiAdhdnqO2AWJrXgdMyzi71ZA4sVQpn4
         /6fRwCQ6MH44X2CL84o5JK/sO94O6ht9djkBufIlqtBFnJAVo78t3R1NFPZe4za8mcT5
         oTFdizo5j2g2VFk8PDtQv0j6OnkWHpQVrMp0ZJoo4sUabSmSkrt+X2AwXVmXRQBJjVXH
         t3qe87mScz5FG90LeTViGVgetVpw3QEsAFpXjo8MNJdcSnvrc38Kw0NNL4gsxvA1W9qy
         PkLg==
X-Gm-Message-State: ABuFfojQbY2XphFxbKgaNBGi5gD5eJ5p9z/ZOYQko68v5EgesKzResLs
        K0a1Iq6QuMu0Ce1ixlIlWSR6ZA==
X-Google-Smtp-Source: ANB0VdalTkxcVlFQ7DvPAfBjMeQqyt3wRVglDERNsjjncaIP2Ywcu0uwymzJl7B2C3jOdWoTGZT00A==
X-Received: by 2002:a1c:e00a:: with SMTP id x10-v6mr5953217wmg.58.1537514970522;
        Fri, 21 Sep 2018 00:29:30 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:30 -0700 (PDT)
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
Subject: [PATCH v5 03/22] nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
Date:   Fri, 21 Sep 2018 09:29:02 +0200
Message-Id: <20180921072921.19387-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
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
index 72313a1d215f..0e963d83a099 100644
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


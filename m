Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F2AECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AAD2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NuUWQ0eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AAD2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeINT5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:57:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36947 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbeINTzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id n11-v6so2188357wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j5VzygIMcTmrTIR1xvM1gLa6GSilUZBltKq95M6HHPU=;
        b=NuUWQ0egq5rhjpw96ov2rRI14N6D+0MsBMpOYkRNZtSP5snOGM0p0hOHaB5O6RxBMH
         UnChgkAplDVWzwWnmdYoiUN/Oe7vq2SPZTD7/8GHCfvrGE654PuT8T6nYE7PljvqAknR
         FqmA2v39WYp7tPjBST6OL7uuk0Rxk2tqjOiQ3xFbriEEfYepT/ZJJrE0h4+Ov5KX1RdE
         KeLnkxgAPMzY5Fwt/Dqx1EAIY/MbTMIkhutJmW3japw7DI5c+W+X7KE1Xc6pZPOPm1LH
         diS9rHT5V1shii+T12U/vdn2MmgQDFLMBGqGeekoYvZBWXPz59o0ERbhGGUEbdsUuuoF
         qhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j5VzygIMcTmrTIR1xvM1gLa6GSilUZBltKq95M6HHPU=;
        b=eUp2anRuj4+vYVW6v60uxydW3xtr3iU+bLhSKXiTyN1rzVlRzwBb07ZWpuBKGfRd1V
         2uwxsYOQp6p18Mqy4J9Q2ld5YOedOU5/0YAERDkO6f6vJoV7ZkhVS44rufIW8qtLS3bo
         edWJXblntejBP5uJSfXn1sA9JdYrWW29JP02Fhfa8+uwbONswNcaVKTwFFOQ+vscV3Gp
         DzAM5lWyQ1nVW0y0HysYrZx4G/X1LF1pD7bgTImE5DcTO9Ol5CNgNzchMqT/FwEYIgAb
         BZsBJHzH4W+Od0o1a6xXraFHUXGmhWOiBK5A6gn/+fUbcXzyDWmo3jX1VcS82sI9oqvX
         zMBA==
X-Gm-Message-State: APzg51CpBARRbFPHJv4fKTQFbp88dfJp8CliQO1q3X8KO6Wbnz2Vym4N
        qNmiFKrlTBcVpZLX+NJY1/zx4A==
X-Google-Smtp-Source: ANB0VdZlclLE5F7JZ+fJ/2PhQs9vzg3y/gJAwDStgrA06ANeyynHGGfYQpupAayEc+5lWmP4KuUM4w==
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr2681386wmf.115.1536936027782;
        Fri, 14 Sep 2018 07:40:27 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:27 -0700 (PDT)
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
Subject: [PATCH v4 03/22] nvmem: use list_for_each_entry_safe in nvmem_device_remove_all_cells()
Date:   Fri, 14 Sep 2018 16:39:52 +0200
Message-Id: <20180914144011.27614-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
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


Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA90ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6731421523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wedoI0Ga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6731421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbeIUNRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:17:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389528AbeIUNRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:17:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so11787349wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hoddC+Dlb2GKPuc7IWS3Y2zKJ7N6bVfp66wSSHaZPhM=;
        b=wedoI0GaOk1fft9KPdfKQTJatgnlpJOHFZTUwUalyoKaSQUCBVGYntTkK1tnBKaWSO
         p+gqH/SHR5/FSwqMIKvNWyDCjHAU/J5kLIk2wq1tCImmMKLGf1hP3sIxhziv5w17sCdz
         9SqcEDpsrWmeXhE7kiF/j9Vdu2fcW3WoUlsneeRNnXTdNylQ+0P68kF/uA1jSH1UGEKu
         sR353docIKiDGoxykJnF+ZnMr4AYS07UqTjunpSOJutitHZfCrbDAbdpYXlg0Qc2PTcO
         lwaM24IPLlprWSEQFkxNycrRY4EiE3Ql1rre7H9PrxcVIKbGw3RmSjJF6XKLIDljw3+P
         cDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hoddC+Dlb2GKPuc7IWS3Y2zKJ7N6bVfp66wSSHaZPhM=;
        b=QU3id1SDqQEMLU6+V8PCrHVDzLI292f1W3c8tIzQfLWCoZ1oMOhCTuPOCtXMs2bb5z
         cVP/mR7MQ+bcGZk5nzDs2WJFxbymz9pGCwepc60f9Aqj4dYRvQtUEFGLENygptnUKw7u
         PrDGNLMjjAqlJd1tP7XJiqTCw5A7p5Xl9fcvhmFgitddLD98yDavfrsS1Zxue03f7BTE
         g5zANt1we7xHHVHqrIyKaYJCkrCBsMxFoN4u556RGIFKC5hGqqz2/Cs9H54EYioQv2lG
         zy4XxiSXCUNBl3A1UJ2qmq3amTMp2LsIVDvDV/qXS6Xv76zE5OWMYQP7c5je+FMCYjYs
         xciQ==
X-Gm-Message-State: APzg51Dk8IDtjnWVLldp/ZsopmKML7o/NSTAx+ybRejP2dCX3FMO1pjS
        C279GIkyYjuajvkgAQiM3Mwryw==
X-Google-Smtp-Source: ANB0Vdbk3aAH8sCSHOW2+wM9qLH7OlLkBrFJQOtd1JE94haxWdwyJGErlZPPRwswdDj/UHUyKetw2A==
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr33391602wre.115.1537514982750;
        Fri, 21 Sep 2018 00:29:42 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id d18-v6sm2841597wmb.33.2018.09.21.00.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 00:29:42 -0700 (PDT)
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
Subject: [PATCH v5 12/22] nvmem: remove the global cell list
Date:   Fri, 21 Sep 2018 09:29:11 +0200
Message-Id: <20180921072921.19387-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921072921.19387-1-brgl@bgdev.pl>
References: <20180921072921.19387-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Nvmem subsystem keeps a global list of cells that, for non-DT systems,
can only be referenced by cell name, which makes it impossible to have
more than one nvmem device with cells named the same.

This patch makes every nvmem device the owner of the list of its cells.
This effectively removes the support for non-DT systems, but it will
be reintroduced following a different approach in subsequent patches.

This isn't a problem as support for board files in nvmem is currently
broken anyway: any user that would try to get an nvmem cell from the
global cell list would remove the cell after the calling
nvmem_cell_put(). This can cause anything from a subsequent user not
being able to get the cell to double free errors if more users hold
reference to the same cell at the same time.

Fortunately there are no such users which allows us to rework this part.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 64 +++++++++++---------------------------------
 1 file changed, 15 insertions(+), 49 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bd14d04782cd..ee794613024c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -38,6 +38,7 @@ struct nvmem_device {
 	int			flags;
 	struct bin_attribute	eeprom;
 	struct device		*base_dev;
+	struct list_head	cells;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
 	void *priv;
@@ -58,9 +59,6 @@ struct nvmem_cell {
 static DEFINE_MUTEX(nvmem_mutex);
 static DEFINE_IDA(nvmem_ida);
 
-static LIST_HEAD(nvmem_cells);
-static DEFINE_MUTEX(nvmem_cells_mutex);
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -282,28 +280,11 @@ static struct nvmem_device *of_nvmem_find(struct device_node *nvmem_np)
 	return to_nvmem_device(d);
 }
 
-static struct nvmem_cell *nvmem_find_cell(const char *cell_id)
-{
-	struct nvmem_cell *p;
-
-	mutex_lock(&nvmem_cells_mutex);
-
-	list_for_each_entry(p, &nvmem_cells, node)
-		if (!strcmp(p->name, cell_id)) {
-			mutex_unlock(&nvmem_cells_mutex);
-			return p;
-		}
-
-	mutex_unlock(&nvmem_cells_mutex);
-
-	return NULL;
-}
-
 static void nvmem_cell_drop(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
 	list_del(&cell->node);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_unlock(&nvmem_mutex);
 	kfree(cell);
 }
 
@@ -311,16 +292,15 @@ static void nvmem_device_remove_all_cells(const struct nvmem_device *nvmem)
 {
 	struct nvmem_cell *cell, *p;
 
-	list_for_each_entry_safe(cell, p, &nvmem_cells, node)
-		if (cell->nvmem == nvmem)
-			nvmem_cell_drop(cell);
+	list_for_each_entry_safe(cell, p, &nvmem->cells, node)
+		nvmem_cell_drop(cell);
 }
 
 static void nvmem_cell_add(struct nvmem_cell *cell)
 {
-	mutex_lock(&nvmem_cells_mutex);
-	list_add_tail(&cell->node, &nvmem_cells);
-	mutex_unlock(&nvmem_cells_mutex);
+	mutex_lock(&nvmem_mutex);
+	list_add_tail(&cell->node, &cell->nvmem->cells);
+	mutex_unlock(&nvmem_mutex);
 }
 
 static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
@@ -465,6 +445,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	}
 
 	kref_init(&nvmem->refcnt);
+	INIT_LIST_HEAD(&nvmem->cells);
 
 	nvmem->id = rval;
 	nvmem->owner = config->owner;
@@ -626,29 +607,14 @@ static struct nvmem_device *__nvmem_device_get(struct device_node *np,
 {
 	struct nvmem_device *nvmem = NULL;
 
-	mutex_lock(&nvmem_mutex);
-
-	if (np) {
-		nvmem = of_nvmem_find(np);
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-EPROBE_DEFER);
-		}
-	} else {
-		struct nvmem_cell *cell = nvmem_find_cell(cell_id);
-
-		if (cell) {
-			nvmem = cell->nvmem;
-			*cellp = cell;
-		}
-
-		if (!nvmem) {
-			mutex_unlock(&nvmem_mutex);
-			return ERR_PTR(-ENOENT);
-		}
-	}
+	if (!np)
+		return ERR_PTR(-ENOENT);
 
+	mutex_lock(&nvmem_mutex);
+	nvmem = of_nvmem_find(np);
 	mutex_unlock(&nvmem_mutex);
+	if (!nvmem)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	if (!try_module_get(nvmem->owner)) {
 		dev_err(&nvmem->dev,
-- 
2.18.0


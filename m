Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A22DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4678720890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="f0t7ybke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4678720890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeILMzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41469 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeILMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so914392wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iacN5A7LU/wkiibiq8lC1h7AfXkWsMWEAz/JdUQ5Jmo=;
        b=f0t7ybkeDcxsrZtiPfr9XhApUN7VoI75Td7Tg8qUGRyNFEsiabQRh0tLycXKefP8JO
         6W+qqeWf7h3cZxz8ZRXJqnHsO8LCXMFxVXwPe/bff8yrMNDpf73O03JYez2zjFzC4A/i
         cCQPAHzgRBU/B4kEtIfb+lUVg3m8wpkBIYz/KlzxMSKp9FOBFqbWAFYz3br4SvQD/0Qj
         K6xDwu4kqgFh1xC6ggHo/buOiq6QjZVbCz43WKpeABWWWzwpEzlLbtVXIu/RZ1k37ue7
         wRJXOycPo1qZ6qzDE5cRNzf/aG+55tMQCvR9xdkouMVCZv7oi+om+KAKttb0SNg4XVcq
         iuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iacN5A7LU/wkiibiq8lC1h7AfXkWsMWEAz/JdUQ5Jmo=;
        b=R0BBnPQzdbxsXlE/91S/7lfhbm8xzL7pyCsLd0NKG1qqHace2mCwyAX4Cd38g5ZpVB
         CD8WlFNQ7L9fSEIin/09cfBxfl9CNX3zxAQNIgjg9AhiytBxbSNekoG8SxAB0gGEDkQ1
         /KMUzu3fsWOhLMHzsgB03rcHPIsQZyN+ZTW04mBNW1QdxNItij2HBfQ29RAvyqJNZaco
         a4lqNiYqq7biZzMNUugqPzNPTksaif6WrXZV0G3SS7EshVgULUA3bz+v2UN8UPElEXt1
         oodFLD/Q3kdAdBAG51fj/SvPLN0YmmlFZt/ErWEv+CMs/cVsaCiQ0qWy+g4FsYELT02L
         6PMg==
X-Gm-Message-State: APzg51Ditq9uC2JtbK8ZCueQNitCt+xgZlJ9QkttykVjcp3iVVb7pcbM
        kVoYVKxf/Hnm1pYdKYkMPnJUSw==
X-Google-Smtp-Source: ANB0VdYXoUYOsOE7XelM1OGIdQbGWCTRmml+PEc2oh8xUbdPQXf86CZ9VyBSEC131V1xF7jMTerlyQ==
X-Received: by 2002:adf:9c12:: with SMTP id f18-v6mr542703wrc.93.1536738721329;
        Wed, 12 Sep 2018 00:52:01 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:00 -0700 (PDT)
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
Subject: [PATCH v3 11/21] nvmem: remove the global cell list
Date:   Wed, 12 Sep 2018 09:51:19 +0200
Message-Id: <20180912075129.25185-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
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
index c950d54bb69d..585688ea2152 100644
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


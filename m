Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44959C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603A2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1YaFD3CO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E603A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIEO1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:27:46 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41079 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbeIEO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:27:45 -0400
Received: by mail-wr1-f52.google.com with SMTP id z96-v6so6957512wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WJJykhItDGy0gN6YBeA8zfc/w+bKn7To1re4h0kJVQI=;
        b=1YaFD3COT/uRZpNlxRTljza+p4lrXxbbJ6qXxSydu8sqRAOfR1QaEVsiPtP8crDM4p
         Y6a0oY68K6+md1MEwzn8E8Vy/ykydPFewR+6oEkEjb54JGmRCw1ehGnxwJM8CQGOSs3C
         4/fHpj0wLIWZEV6zkwztSyj8DESo27qY98RswMpGytaiebZ29e+1T/g74fGpPKdMomVc
         vDzM8iEaIx3oDcBpX0NqaQFhPXVp/0tsQqQ8fKP0DAwNQsyLnCfPwqx7UimVJFP+YGI8
         39ASaVVTkYQd9ORNUnfHVRTi/kIE7mcfJ5MxTxg1kT4pjRqbrsoc2v8k6DpTaYyCQ5Bd
         9qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WJJykhItDGy0gN6YBeA8zfc/w+bKn7To1re4h0kJVQI=;
        b=JyexpRNzg4VmZ9eX3ZC/lIO5Rd2GbE1aGTTKwKEESIO3XcsFizi3O0v9w/+wfrXU0v
         n/eLuSGP8T49iULeDs75FHWRU0GfubI5Z1JzZ0Cmr7VGRLArRBs5e1+/18l+CwutFH84
         aXDigCSlyS1Bjx3ky/pFR13l82smoHTXi2LRGsAEYA2sRMBaywhv1rEcnn1j1cnlchvA
         3ekLGLAqRK+ZPF0ptBympxTzEWidSzGbGJ/dixpelWHFDYKK8JeTIzwXjKGAOIFhjGIG
         K5oDDbCVQjQxViEK1Oe1VAvxNploER+ILNoAMWxFpsHRxvtsDOy0E12b0u6PS6ylpWyh
         P69g==
X-Gm-Message-State: APzg51B6esE24KzmrURpqGFoPumvVRtvvUD0OGz6dN3e03Chyabj4A8M
        e2sPW8kfZBQ2Bw9pMyhs69ppEw==
X-Google-Smtp-Source: ANB0VdbsDFFAlfbv1kHtkn4uIY2k/tjDBL+bIulOaloMKqjOg3EC1q9ciuXP4HjEl8bGQ6eVfR2jeg==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr25121594wra.110.1536141496711;
        Wed, 05 Sep 2018 02:58:16 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-33-235.w90-86.abo.wanadoo.fr. [90.86.152.235])
        by smtp.gmail.com with ESMTPSA id l12-v6sm2127815wrv.29.2018.09.05.02.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 02:58:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joachim Eastwood <manabian@gmail.com>,
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
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 10/13] nvmem: resolve cells from DT at registration time
Date:   Wed,  5 Sep 2018 11:57:35 +0200
Message-Id: <20180905095738.26406-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905095738.26406-1-brgl@bgdev.pl>
References: <20180905095738.26406-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently we're creating a new cell structure everytime a DT users
calls nvmem_cell_get().

Change this behavior by resolving the cells during nvmem provider
registration and adding all cells to the provider's list. Make
of_nvmem_cell_get() just parse the phandle and look the cell up
in the relevant provider's list.

Don't drop the cell in nvmem_cell_put().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 122 ++++++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 48 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 854baa0559a1..da7a9d5beb33 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -405,6 +405,73 @@ static int nvmem_add_cells_from_list(struct nvmem_device *nvmem)
 	return rval;
 }
 
+static struct nvmem_cell *
+nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
+{
+	struct nvmem_cell *cell = NULL;
+	int i = 0;
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(cell, &nvmem->cells, node) {
+		if (index == i++)
+			break;
+	}
+	mutex_unlock(&nvmem_mutex);
+
+	return cell;
+}
+
+static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+{
+	struct device_node *parent, *child;
+	struct device *dev = &nvmem->dev;
+	struct nvmem_cell *cell;
+	const __be32 *addr;
+	int len;
+
+	parent = dev->of_node;
+
+	for_each_child_of_node(parent, child) {
+		addr = of_get_property(child, "reg", &len);
+		if (!addr || (len < 2 * sizeof(u32))) {
+			dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
+			return -EINVAL;
+		}
+
+		cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+		if (!cell)
+			return -ENOMEM;
+
+		cell->nvmem = nvmem;
+		cell->offset = be32_to_cpup(addr++);
+		cell->bytes = be32_to_cpup(addr);
+		cell->name = child->name;
+
+		addr = of_get_property(child, "bits", &len);
+		if (addr && len == (2 * sizeof(u32))) {
+			cell->bit_offset = be32_to_cpup(addr++);
+			cell->nbits = be32_to_cpup(addr);
+		}
+
+		if (cell->nbits)
+			cell->bytes = DIV_ROUND_UP(
+					cell->nbits + cell->bit_offset,
+					BITS_PER_BYTE);
+
+		if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
+			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
+				cell->name, nvmem->stride);
+			/* Cells already added will be freed later. */
+			kfree(cell);
+			return -EINVAL;
+		}
+
+		nvmem_cell_add(cell);
+	}
+
+	return 0;
+}
+
 /**
  * nvmem_register_notifier() - Register a notifier block for nvmem events.
  *
@@ -514,6 +581,9 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	rval = nvmem_add_cells_from_list(nvmem);
 	if (rval)
 		goto err_teardown_compat;
+	rval = nvmem_add_cells_from_of(nvmem);
+	if (rval)
+		goto err_remove_cells;
 
 	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 	if (rval)
@@ -811,10 +881,8 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 					    const char *name)
 {
 	struct device_node *cell_np, *nvmem_np;
-	struct nvmem_cell *cell;
 	struct nvmem_device *nvmem;
-	const __be32 *addr;
-	int rval, len;
+	struct nvmem_cell *cell;
 	int index = 0;
 
 	/* if cell name exists, find index to the name */
@@ -834,54 +902,13 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	if (IS_ERR(nvmem))
 		return ERR_CAST(nvmem);
 
-	addr = of_get_property(cell_np, "reg", &len);
-	if (!addr || (len < 2 * sizeof(u32))) {
-		dev_err(&nvmem->dev, "nvmem: invalid reg on %pOF\n",
-			cell_np);
-		rval  = -EINVAL;
-		goto err_mem;
-	}
-
-	cell = kzalloc(sizeof(*cell), GFP_KERNEL);
+	cell = nvmem_find_cell_by_index(nvmem, index);
 	if (!cell) {
-		rval = -ENOMEM;
-		goto err_mem;
-	}
-
-	cell->nvmem = nvmem;
-	cell->offset = be32_to_cpup(addr++);
-	cell->bytes = be32_to_cpup(addr);
-	cell->name = cell_np->name;
-
-	addr = of_get_property(cell_np, "bits", &len);
-	if (addr && len == (2 * sizeof(u32))) {
-		cell->bit_offset = be32_to_cpup(addr++);
-		cell->nbits = be32_to_cpup(addr);
-	}
-
-	if (cell->nbits)
-		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
-					   BITS_PER_BYTE);
-
-	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
-			dev_err(&nvmem->dev,
-				"cell %s unaligned to nvmem stride %d\n",
-				cell->name, nvmem->stride);
-		rval  = -EINVAL;
-		goto err_sanity;
+		__nvmem_device_put(nvmem);
+		return ERR_PTR(-ENOENT);
 	}
 
-	nvmem_cell_add(cell);
-
 	return cell;
-
-err_sanity:
-	kfree(cell);
-
-err_mem:
-	__nvmem_device_put(nvmem);
-
-	return ERR_PTR(rval);
 }
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
@@ -978,7 +1005,6 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 	struct nvmem_device *nvmem = cell->nvmem;
 
 	__nvmem_device_put(nvmem);
-	nvmem_cell_drop(cell);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
-- 
2.18.0


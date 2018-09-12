Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7036BECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443920890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wUBOSoAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1443920890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeILMzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:55:25 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40176 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeILMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:55:24 -0400
Received: by mail-wr1-f46.google.com with SMTP id n2-v6so917694wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rZWO4kI7uqrNjBVMdqrBzKtvTAgfrsLuKZ1HGrmrsw8=;
        b=wUBOSoAM+7HznZEvxirpaqVF6BpViFlBP7MMiJTNgLqFX6UfQJkY78C/fyOdQrOKpb
         db4XP1vgOA07V7Z94bNSWYBfc361Wy+WfkwU3VoXXKuRCMzWoVTm1Ki+s+cqDwZXvDBn
         Ag+Q6L77uNpYm11bKCYevFcHNYqIgA1/GmG3KjfTdiJyVQCWGA4MP8kogN8Y7yaZb/t5
         VgHyTwJPP5HlWq11Zfq6RWJcpIGR1QT9XtSbxaSSUMWbCgqqukdbDytbn5YckNiFARZA
         Fh3AA+SZlmvXndv/hTiQNFxP5zFKMPPGuoHgyxMG4q/Zd5pJSiB0mcz3+1HziJyzrM75
         OVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rZWO4kI7uqrNjBVMdqrBzKtvTAgfrsLuKZ1HGrmrsw8=;
        b=sMbBYUPfwHnfyVx8FpX7ZIPy5LgP7M8NPHMODp3ktXGW/myte1HW3Kn+vi9PdtiCeP
         bLfKH97mHkqJi8kN3UiYK7J4sPr1oTX6ev8+WbW/82MZiSPCsSxftbTWKj5ek2u5SBo6
         MTXAY7A0tGcUGyvkHCvSbah4vNC2qKLrUzdfHi/Jirzfjeie/Ct4g1DG4608z8QH81sJ
         WJWTtC6Gxj2YP9c5EpOp6CkDY/X5KsxDSip5OA6Ns2nQaPR7mYfOR9wIlxtNqIJXJfU/
         3DPKTyiR/UVt8aaL6IUSB0zEpC1Ghtu4de9YGs64jhqXEJIGevbpUlXDuXoWHWiQ8FIf
         rQnA==
X-Gm-Message-State: APzg51DUXvYc8eaHVXHQrEGMh7DX1j4dx9nS/WhbiQNzXqcGOw5DzVEZ
        iDhI4iw+58F9XUfRWgZvTJjCdQ==
X-Google-Smtp-Source: ANB0VdaQn2lzT/pZQ+K93Dse2VCsMgjkSsJSR6bYwrxDzJahk3CD9CIJTZF2tsM9RHzlhE1ooLB38w==
X-Received: by 2002:a5d:6908:: with SMTP id t8-v6mr548229wru.170.1536738724333;
        Wed, 12 Sep 2018 00:52:04 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id l7-v6sm169341wrt.67.2018.09.12.00.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:52:03 -0700 (PDT)
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
Subject: [PATCH v3 13/21] nvmem: resolve cells from DT at registration time
Date:   Wed, 12 Sep 2018 09:51:21 +0200
Message-Id: <20180912075129.25185-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently we're creating a new cell structure everytime a DT user
calls nvmem_cell_get().

Change this behavior by resolving the cells during nvmem provider
registration and adding all cells to the provider's list. Make
of_nvmem_cell_get() just parse the phandle and look the cell up
in the relevant provider's list.

Don't drop the cell in nvmem_cell_put().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 123 ++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 48 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9329857f6137..13568e7ad178 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -456,6 +456,73 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
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
  * nvmem_register() - Register a nvmem device for given nvmem_config.
  * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
@@ -546,6 +613,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	rval = nvmem_add_cells_from_of(nvmem);
+	if (rval)
+		goto err_remove_cells;
+
 	return nvmem;
 
 err_remove_cells:
@@ -848,10 +919,8 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
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
@@ -871,54 +940,13 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
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
@@ -1024,7 +1052,6 @@ void nvmem_cell_put(struct nvmem_cell *cell)
 	struct nvmem_device *nvmem = cell->nvmem;
 
 	__nvmem_device_put(nvmem);
-	nvmem_cell_drop(cell);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_put);
 
-- 
2.18.0


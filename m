Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB8FC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F5E214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="RwaakG6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F5E214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeINTzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:55:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53117 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbeINTzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:55:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id y139-v6so2175291wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SWhvTRaZMO6GTmTkXjZ+oIHfexV3W/J/b8cNASj1ylQ=;
        b=RwaakG6bYlcm0lGCS8eOtLIj4Mp8WIvjUCZYaCoWIQDAQ/PObldJHzjc25om3Cq0BP
         p+h89nN9Uh/kmBHn74JEVrjMa6Vi8dzSuCZwopCODbUM0Qo4Xpeig1DHBLkNhXVs+qHQ
         Qrf797f7tJtZ7WqSt1RM1JqAM9lNO85SdHer0g2HNAYzARx80IuMOi7DerD5PHepypT9
         nJFHcFUhCyCOPSgahlpAn21GX94KkxNQ0WO34IYkzTvBhNHrRt8usaCbUmC9HN3jWPyU
         cvFW6LEIWce8EshNQ56s46aOcR7dwPjKQ/7UIsUQcOthctwBA+ZZhDenUKaTtx5nqahm
         P75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SWhvTRaZMO6GTmTkXjZ+oIHfexV3W/J/b8cNASj1ylQ=;
        b=Gw8X3aZv8jzi/AnrONSFshWaFYqtp1sK6pSX2GSI9N5Ndrf5dG7gMELYmkWcb1CRtf
         xKYwtWKUBWYZq80XTFH1SSOQe9gr4QZyKS42IjXWhrzjgXVNznJK4SYtq5Wn2sVZbLDT
         IzxfOyN8hkBid6zTB6xcPuoMf6YLh2DKebCBLTWa/jK4oUzC/8+Hmc1NACQ75eOmNUkL
         HWvXBnIp6FxSgLKjMHechi4LCc4VouPtCRYZejDcC5gyp0UKXB7HJIYZOtn7WV1ocnZr
         sIpcidMWzCldWzJ++klK89wz6XwUgEgo8sm7Zezuhx+n8p587L33G18MtPRNsvnjxPEM
         yZVQ==
X-Gm-Message-State: APzg51DC7f/6ryJL3UI6kWugSnCgxvNpZn0tebHgllM59wAVhyQX9WyS
        6od4EB/MlUZcbJ2f3wl1daVyJw==
X-Google-Smtp-Source: ANB0Vdal0s7pvC2zmwT7gSqdyG8wHbOks9EXb9Vd1c7qhj6dANybj0gDiDT9zmAkh+lZdD+kUCcMNQ==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr2531364wmx.38.1536936049073;
        Fri, 14 Sep 2018 07:40:49 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v46-v6sm10313526wrc.63.2018.09.14.07.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:40:48 -0700 (PDT)
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
Subject: [PATCH v4 19/22] nvmem: make the naming of arguments in nvmem_cell_get() consistent
Date:   Fri, 14 Sep 2018 16:40:08 +0200
Message-Id: <20180914144011.27614-20-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180914144011.27614-1-brgl@bgdev.pl>
References: <20180914144011.27614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The argument representing the cell name in the nvmem_cell_get() family
of functions is not consistend between function prototypes and
definitions. Name it 'id' in all those routines. This is in line with
other frameworks and can represent both the DT cell name from the
nvmem-cell-names property as well as the con_id field from cell
lookup entries.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 27 ++++++++++++++-------------
 include/linux/nvmem-consumer.h | 12 ++++++------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ea05219e60b4..ff21402fbd7d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -977,16 +977,15 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
  * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
  *
  * @np: Device tree node that uses the nvmem cell.
- * @name: nvmem cell name from nvmem-cell-names property, or NULL
- *	  for the cell at index 0 (the lone cell with no accompanying
- *	  nvmem-cell-names property).
+ * @id: nvmem cell name from nvmem-cell-names property, or NULL
+ *      for the cell at index 0 (the lone cell with no accompanying
+ *      nvmem-cell-names property).
  *
  * Return: Will be an ERR_PTR() on error or a valid pointer
  * to a struct nvmem_cell.  The nvmem_cell will be freed by the
  * nvmem_cell_put().
  */
-struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-					    const char *name)
+struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
 {
 	struct device_node *cell_np, *nvmem_np;
 	struct nvmem_device *nvmem;
@@ -994,8 +993,8 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	int index = 0;
 
 	/* if cell name exists, find index to the name */
-	if (name)
-		index = of_property_match_string(np, "nvmem-cell-names", name);
+	if (id)
+		index = of_property_match_string(np, "nvmem-cell-names", id);
 
 	cell_np = of_parse_phandle(np, "nvmem-cells", index);
 	if (!cell_np)
@@ -1025,27 +1024,29 @@ EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
  * nvmem_cell_get() - Get nvmem cell of device form a given cell name
  *
  * @dev: Device that requests the nvmem cell.
- * @cell_id: nvmem cell name to get.
+ * @id: nvmem cell name to get (this corresponds with the name from the
+ *      nvmem-cell-names property for DT systems and with the con_id from
+ *      the lookup entry for non-DT systems).
  *
  * Return: Will be an ERR_PTR() on error or a valid pointer
  * to a struct nvmem_cell.  The nvmem_cell will be freed by the
  * nvmem_cell_put().
  */
-struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
+struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id)
 {
 	struct nvmem_cell *cell;
 
 	if (dev->of_node) { /* try dt first */
-		cell = of_nvmem_cell_get(dev->of_node, cell_id);
+		cell = of_nvmem_cell_get(dev->of_node, id);
 		if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
 			return cell;
 	}
 
-	/* NULL cell_id only allowed for device tree; invalid otherwise */
-	if (!cell_id)
+	/* NULL cell id only allowed for device tree; invalid otherwise */
+	if (!id)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_lookup(dev, cell_id);
+	return nvmem_cell_get_from_lookup(dev, id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index d18caae2f7ac..e17617fa034f 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -55,8 +55,8 @@ enum {
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
-struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *name);
-struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *name);
+struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
+struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
@@ -91,13 +91,13 @@ int nvmem_unregister_notifier(struct notifier_block *nb);
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
-						const char *name)
+						const char *id)
 {
 	return ERR_PTR(-ENOSYS);
 }
 
 static inline struct nvmem_cell *devm_nvmem_cell_get(struct device *dev,
-				       const char *name)
+						     const char *id)
 {
 	return ERR_PTR(-ENOSYS);
 }
@@ -201,12 +201,12 @@ static inline int nvmem_unregister_notifier(struct notifier_block *nb)
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
 struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-				     const char *name);
+				     const char *id);
 struct nvmem_device *of_nvmem_device_get(struct device_node *np,
 					 const char *name);
 #else
 static inline struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
-				     const char *name)
+						   const char *id)
 {
 	return ERR_PTR(-ENOSYS);
 }
-- 
2.18.0


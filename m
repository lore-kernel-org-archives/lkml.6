Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE45C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C782087A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Z4SAuD3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C782087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeIGOs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:48:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50712 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbeIGOsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:48:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so14205019wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 03:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XDlS7q6y/Wy9nWc7nbll/DVBj4MgMyVUhgPfDRtNSjo=;
        b=Z4SAuD3x3tEQXKzMfDOpaftPGNjhzCYi5BaFpqPhhHOW3f5RUnF6gn7xB7N+2Ve+ya
         rQf3Q5h2m1pDjT/RATBOO5DEGo5QoxKGB3lyXZwYHfDWjYIRNLjP1PWQwvu6xya/XJ3Z
         AqBxA/g1pVWpvODIIEs4+IG0KyoNL1zUUVVhfFcyktX5+21FYr+eViKKOfMgop8zu0UJ
         dd+UDvfp4q9r5WlPZrMqB43Mg9B6jqia4NjlWKkd3GIOUWyTcucPicR2k1jX4aGhwSlX
         9wrdUaMjxLvrsBj5ZOaVA0VwWopXMXXzqwkPlHHp1q8XQetTd3wMDHKqTs0JNpuMc6G/
         TblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XDlS7q6y/Wy9nWc7nbll/DVBj4MgMyVUhgPfDRtNSjo=;
        b=WHOedZbWocIABzhzZjkea5kdYGetukv4Ykp7IwatC+aegVCa3eu4xOQKlHxU7P90ae
         WQJCmCKVCiuaLoEAJlcIp7pYKFWXUCOZPpzI/jLVYmJl2ZsK1tv4idbd25oI+mnIeEap
         lHDzYMBXFUtZtW2+Imbhf8yXak72OXn9Wj6maLNPdWaGcByiOH9PkanekUKrlvTZkp5x
         Oaob01aqyeKZ/eK2u91IpfTceYSMZME16IdZ/z0/BX3UEJjpm9SYn1ZHqhOwCj9g1qdf
         degl6Pyc3TC+F3wBK9kE8sWigWnAvIXfbf4PjgDDrhDO2kQNkuGsCh98AcQ/ikTeSutu
         +mRA==
X-Gm-Message-State: APzg51BalhDsAPFhxNhbQMT5rwRH+aba8IcykcWGgSeHV4WiIO+PTTPw
        0MhUA5NPS3X4+B0Mx6C9PZbJzQ==
X-Google-Smtp-Source: ANB0VdZlVGl7ISwf8sv1ihjauPAij7GLIdF/FxZ8mhR0+hZuO5NDSDDPaz5enFXHugngShCmwah/wA==
X-Received: by 2002:a1c:a60e:: with SMTP id p14-v6mr5089493wme.64.1536314919195;
        Fri, 07 Sep 2018 03:08:39 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id 72-v6sm6631619wrb.48.2018.09.07.03.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 03:08:38 -0700 (PDT)
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
Subject: [PATCH v2 16/16] nvmem: make the naming of arguments in nvmem_cell_get() consistent
Date:   Fri,  7 Sep 2018 12:07:50 +0200
Message-Id: <20180907100750.14564-17-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907100750.14564-1-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
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
index 320b3cc975a0..efcc41ba487d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -873,16 +873,15 @@ EXPORT_SYMBOL_GPL(devm_nvmem_device_get);
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
@@ -890,8 +889,8 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 	int index = 0;
 
 	/* if cell name exists, find index to the name */
-	if (name)
-		index = of_property_match_string(np, "nvmem-cell-names", name);
+	if (id)
+		index = of_property_match_string(np, "nvmem-cell-names", id);
 
 	cell_np = of_parse_phandle(np, "nvmem-cells", index);
 	if (!cell_np)
@@ -959,22 +958,24 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
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
 	if (dev->of_node)
-		return of_nvmem_cell_get(dev->of_node, cell_id);
+		return of_nvmem_cell_get(dev->of_node, id);
 
-	/* Only allow empty cell_id for DT systems. */
-	if (!cell_id)
+	/* Only allow empty cell id for DT systems. */
+	if (!id)
 		return ERR_PTR(-EINVAL);
 
-	return nvmem_cell_get_from_lookup(dev, cell_id);
+	return nvmem_cell_get_from_lookup(dev, id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4c146379b9ba..31ff907c7fe7 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -27,8 +27,8 @@ enum {
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
-struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *name);
-struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *name);
+struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *id);
+struct nvmem_cell *devm_nvmem_cell_get(struct device *dev, const char *id);
 void nvmem_cell_put(struct nvmem_cell *cell);
 void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
@@ -54,13 +54,13 @@ int nvmem_unregister_notifier(struct notifier_block *nb);
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
@@ -145,12 +145,12 @@ static inline int nvmem_unregister_notifier(struct notifier_block *nb)
 
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


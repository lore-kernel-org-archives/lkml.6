Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB70C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2C725D88
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oHMsMuVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2C725D88
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755219AbeFYP4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:56:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34568 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbeFYPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:51:20 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so14222524wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M2pBvISezV7UKcYvnKa/lLg3BIe8aDxcoHTMh7WCXlQ=;
        b=oHMsMuVcLbezHzWoWPW3xXfcWIPuVOv4LhSPaLBYHKZfX3SiVTXYGq+nGC6XodtN87
         IQXpv30knXAf6DPRozOKUDfto+GrYBjJ3iqkMAThRMfe2/8t8zio+Z2Q1UbfoM5zGTz/
         itTvCPp+B4PCE2Iv42Bcsz9eGmvARj27olIZOUvPEy/Xh2EO50pkls9W8MgNUPl37So4
         HyOJeCPDH/36zOvwsJX8Eh2tMIlDowH7frC8OwCFrzTpEX2XEkB1gxhQvWgIlQci0p9B
         lhrB+XiQU6H3oVGh193ObouLq7OBAZok6G4NddsoRzVmGmvQJbqdKGTIdSSne2mfNv8E
         bu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M2pBvISezV7UKcYvnKa/lLg3BIe8aDxcoHTMh7WCXlQ=;
        b=tNP8JbtdVVuOo5jyX8GSayp0Mi2P9u3pfdzZNf0puDbODoLBcJ3txzvfPwwPsy5kcM
         VK1AE2LFY7cxSEO1hbje0vOsVhb3A/Vdwsx1kSoElykgiddVd62jW5mA592fpckM04di
         7pmkvrUtcu5/ANh9sTmoMEaZgLQpe+LCmEbJMau1oTYD02h6dixcIvCeHq3NjhwsI0Jm
         oiAkJHncxustaDpAeOqA8f6rSHuQjsr3H2zdlVbz5JbJWTtw9+oBuZB7QmhraTt+ketQ
         5J+NxIMblAGMIvVPsXrsSjLhdMNFG7qLkRZY9stNqubrhL5FVTVBQDjNXPVulbrsG994
         /Y9g==
X-Gm-Message-State: APt69E2C/oBJCFOV7vuUPCov4K3v25ILcUG9v260P8tGI0rAaMrTp3zm
        rYOT7urX5M/X7rwbJUFNQrCisQ==
X-Google-Smtp-Source: AAOMgpfpQLUzcWZreWeTU3vNeA2YJmP0/OX+U8SfrfG1i023yA9CEDyjSodxdlnzYJh/DlEWhvv5lA==
X-Received: by 2002:adf:f40a:: with SMTP id g10-v6mr10522782wro.256.1529941879338;
        Mon, 25 Jun 2018 08:51:19 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id x16-v6sm3523737wro.13.2018.06.25.08.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 08:51:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 01/14] nvmem: add support for cell lookups
Date:   Mon, 25 Jun 2018 17:50:12 +0200
Message-Id: <20180625155025.12567-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625155025.12567-1-brgl@bgdev.pl>
References: <20180625155025.12567-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We can currently only register nvmem cells from device tree or by
manually calling nvmem_add_cells(). The latter options however forces
users to make sure that the nvmem provider with which the cells are
associated is registered before the call.

This patch proposes a new solution inspired by other frameworks that
offer resource lookups (GPIO, PWM etc.). It adds a function that allows
machine code to register nvmem lookup which are later lazily used to
add corresponding nvmem cells.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c           | 57 +++++++++++++++++++++++++++++++++-
 include/linux/nvmem-consumer.h |  6 ++++
 include/linux/nvmem-provider.h |  6 ++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5b0cdc21d01..a2e87b464319 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -62,6 +62,9 @@ static DEFINE_IDA(nvmem_ida);
 static LIST_HEAD(nvmem_cells);
 static DEFINE_MUTEX(nvmem_cells_mutex);
 
+static LIST_HEAD(nvmem_cell_lookups);
+static DEFINE_MUTEX(nvmem_lookup_mutex);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key eeprom_lock_key;
 #endif
@@ -247,6 +250,23 @@ static const struct attribute_group *nvmem_ro_root_dev_groups[] = {
 	NULL,
 };
 
+/**
+ * nvmem_register_lookup() - register a number of nvmem cell lookup entries
+ *
+ * @lookup: array of nvmem cell lookup entries
+ * @nentries: number of lookup entries in the array
+ */
+void nvmem_register_lookup(struct nvmem_cell_lookup *lookup, size_t nentries)
+{
+	int i;
+
+	mutex_lock(&nvmem_lookup_mutex);
+	for (i = 0; i < nentries; i++)
+		list_add_tail(&lookup[i].list, &nvmem_cell_lookups);
+	mutex_unlock(&nvmem_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(nvmem_register_lookup);
+
 static void nvmem_release(struct device *dev)
 {
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
@@ -916,6 +936,37 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np,
 EXPORT_SYMBOL_GPL(of_nvmem_cell_get);
 #endif
 
+static struct nvmem_cell *nvmem_cell_from_lookup(const char *cell_id)
+{
+	struct nvmem_cell *cell = ERR_PTR(-EPROBE_DEFER);
+	struct nvmem_cell_lookup *lookup;
+	struct nvmem_device *nvmem;
+	int rc;
+
+	mutex_lock(&nvmem_lookup_mutex);
+
+	list_for_each_entry(lookup, &nvmem_cell_lookups, list) {
+		if (strcmp(cell_id, lookup->info.name) == 0) {
+			nvmem = nvmem_find(lookup->nvmem_name);
+			if (!nvmem)
+				goto out;
+
+			rc = nvmem_add_cells(nvmem, &lookup->info, 1);
+			if (rc) {
+				cell = ERR_PTR(rc);
+				goto out;
+			}
+
+			cell = nvmem_cell_get_from_list(cell_id);
+			break;
+		}
+	}
+
+out:
+	mutex_unlock(&nvmem_lookup_mutex);
+	return cell;
+}
+
 /**
  * nvmem_cell_get() - Get nvmem cell of device form a given cell name
  *
@@ -936,7 +987,11 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
 			return cell;
 	}
 
-	return nvmem_cell_get_from_list(cell_id);
+	cell = nvmem_cell_get_from_list(cell_id);
+	if (!IS_ERR(cell) || PTR_ERR(cell) == -EPROBE_DEFER)
+		return cell;
+
+	return nvmem_cell_from_lookup(cell_id);
 }
 EXPORT_SYMBOL_GPL(nvmem_cell_get);
 
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4e85447f7860..f4b5d3186e94 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -29,6 +29,12 @@ struct nvmem_cell_info {
 	unsigned int		nbits;
 };
 
+struct nvmem_cell_lookup {
+	struct nvmem_cell_info	info;
+	struct list_head	list;
+	const char		*nvmem_name;
+};
+
 #if IS_ENABLED(CONFIG_NVMEM)
 
 /* Cell based interface */
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..766c0a96c113 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -17,6 +17,7 @@
 
 struct nvmem_device;
 struct nvmem_cell_info;
+struct nvmem_cell_lookup;
 typedef int (*nvmem_reg_read_t)(void *priv, unsigned int offset,
 				void *val, size_t bytes);
 typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
@@ -72,6 +73,8 @@ struct nvmem_config {
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
 int nvmem_unregister(struct nvmem_device *nvmem);
 
+void nvmem_register_lookup(struct nvmem_cell_lookup *lookup, size_t nentries);
+
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
 
@@ -92,6 +95,9 @@ static inline int nvmem_unregister(struct nvmem_device *nvmem)
 	return -ENOSYS;
 }
 
+static inline void
+nvmem_register_lookup(struct nvmem_cell_lookup *lookup, size_t nentries) {}
+
 static inline struct nvmem_device *
 devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 {
-- 
2.17.1


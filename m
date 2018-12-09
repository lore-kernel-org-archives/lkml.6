Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F57CC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B222082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwOW4eOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B222082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeLIUbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34755 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLIUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so6529451lfc.1;
        Sun, 09 Dec 2018 12:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTX3y++j0yuzOQfGcZM+ZpkGPkoc/4Fc3P4h/vDhnhU=;
        b=PwOW4eOxH84dTAPcK9LinSL7WK9NILopnHvJHBRdEzevZekZuRtPja2yhoGWqe0Zn+
         Dgk78aymTSHLiwBQ86uBt2ItRJQRXHkV29M3JXMJZaTSDBbSWOmER13QjN/PC1E9ClRG
         nL6W8HVy6W6gsPJShAm97BA4ZpG6fwkpVS1qvOSEmPsyv03R9txFAjY+M/769D/llUD+
         aEqNgsnhO4eanAOB5PooWb8LAhjDY3L0NuQPWmIFlYX9Ej6AOjV+7Go87oyKR/TFz/Up
         PLCF4vYNjO0CkyXfiJ7ihknXHSL2MiFPcajNRJbIrKJHaXK47qnIx6lvSMFZGbPITozL
         X7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTX3y++j0yuzOQfGcZM+ZpkGPkoc/4Fc3P4h/vDhnhU=;
        b=MhXKtLWe5ugkG+pLLi25kJFn2TeaZ7Kzb1y6eUrdkyKUGoZE9+5M8cv9KmF5IP73mn
         kOOO8SZ1K4HTDLhEX4HIZiCZytZqIWidqZaW5rI5Fel9UF0KMfewqXQNlOBEHXBfejs2
         nwcYMxB2sC5nmXyIer6G11rAQC+sCa2oMqpAFMSOhMOkvn5FIiVZ7sZXMCQgwQ2RHIJN
         /YTR8Kmz7/Hb7IQBpgpNqyMEo5hAYFqaXGDvFj22QYHVS612JsGhwT//UdzgY2Z0OQR3
         nMUbrSWY1mbKIUzPNyrAwsKqneqseMQWnFHeRemKD+gYLWlKwMImjFWWM0MTL2k25Jtc
         toTw==
X-Gm-Message-State: AA+aEWZTu5dpE74iDgZUi+tpGR1VEs3kjXPL8f0wI0om/xDtEM11cD9D
        VEovFxRo7IvfskrWwuBMFg0=
X-Google-Smtp-Source: AFSGD/X8ROvl3TQhQlFaB2t92jR3+4ZJUvLSfOZN5LtTu3mnlHcY2FxQ4OPqud/e4dpKMZGdOTJzMw==
X-Received: by 2002:a19:914b:: with SMTP id y11mr4926814lfj.98.1544387477463;
        Sun, 09 Dec 2018 12:31:17 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 17/21] iommu/tegra: gart: Don't use managed resources
Date:   Sun,  9 Dec 2018 23:29:46 +0300
Message-Id: <20181209202950.31486-18-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART is a part of the Memory Controller driver that is always built-in,
hence there is no benefit from the use of managed resources.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 1be595d15e7e..99afdbf8860c 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -173,7 +173,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	struct gart_client *client, *c;
 	int err = 0;
 
-	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
+	client = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 	client->dev = dev;
@@ -199,7 +199,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 fail:
-	devm_kfree(gart->dev, client);
+	kfree(client);
 	spin_unlock(&gart->client_lock);
 	return err;
 }
@@ -214,7 +214,7 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
-			devm_kfree(gart->dev, c);
+			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
@@ -461,7 +461,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 		return ERR_PTR(-ENXIO);
 	}
 
-	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
+	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
 		return ERR_PTR(-ENOMEM);
@@ -470,7 +470,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ERR_PTR(ret);
+		goto free_gart;
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -508,6 +508,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
+free_gart:
+	kfree(gart);
 
 	return ERR_PTR(ret);
 }
-- 
2.19.1


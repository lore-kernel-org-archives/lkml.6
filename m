Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8333DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439982080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv/MOEQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439982080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeLLUyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:54:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35284 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLUyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:54:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so9163295plo.2;
        Wed, 12 Dec 2018 12:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lXvQwdbHaj44s+GSM9FyQCJ3qWTi2wyKfG/w69V/isE=;
        b=sv/MOEQtCOAjKAsdEJir5wLaL8TNycVxti96zt/VYLAm+4gkGzrR2ycQ9JURflrFrM
         99B3mqO83+ABeSZLZmgHszxmuOW/HTuRWYQKy4PVBpPn3esEdbGVYgEHwH9i1YbkThmV
         DsosZQrnkEzNpIkGGNpxuxyEEi3gncDJ7y5EGT2oHX3e09HSvZJAnhca+r3U5Q6+UblI
         oPQbmLcWPGOygs8Zo1x9mTEweDRB9wRWWTPkotxb+i2vH3xxxlWJWRwIQr43LC8HMgoj
         x2uKZEo1aDYiM4N+jR11aOl9WHgWcpUYpL7F/ZHm4mYeBJoRtrWvrQLfzBFVE9bJK2q4
         V7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lXvQwdbHaj44s+GSM9FyQCJ3qWTi2wyKfG/w69V/isE=;
        b=ORmwK/KduUsCb3EGcm5QXmC7wG4dAZRVK754M7f5GI01m2IlRHA0qo9IG03mit2QnN
         pXccGv0G5J/QMJLYqcIU1aXWyaVYia5mzQm05RkT7iPbnfm4JItrCrMJkTvH3TvqBPJ+
         QIYoVxzr80jt3vW1FTUZNBpec8iUj5WCt10x7zFWStMU4720OKv37xK/qOXtWmbW0AWR
         5huruxiTA0U7BqkJRba7Qbe9RmsfxAAQTi8p0N6sgjpQC1RqvjB1zRT0xfsvwvgFzHoH
         qJPb6KFlbV/leqG6EXpzIlGRGMv/DX6jRJd2MNBxcBq3cdoKZhqJqWP4OArmFyo9a6SC
         ryDA==
X-Gm-Message-State: AA+aEWaWH4VVGF3+2p8T6Ff0AxEzwlxH3W3NURvHIfIkSSN2LTGIBuLQ
        7rAHo9Ku28InReaptBLWTOg=
X-Google-Smtp-Source: AFSGD/V1PctVGVbTIiUMI0XOsAfZiqh40B2tdYxhRkeKWzW0yjwqH+GujxNZOXEZPmTnKyqVC/Kf2Q==
X-Received: by 2002:a17:902:654a:: with SMTP id d10mr20795561pln.324.1544648044429;
        Wed, 12 Dec 2018 12:54:04 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:54:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 20/24] iommu/tegra: gart: Don't use managed resources
Date:   Wed, 12 Dec 2018 23:39:03 +0300
Message-Id: <20181212203907.23461-21-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
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
index 71ff22be9560..2e0e6aff8f70 100644
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
@@ -455,7 +455,7 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 		return ERR_PTR(-ENXIO);
 	}
 
-	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
+	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
 		return ERR_PTR(-ENOMEM);
@@ -464,7 +464,7 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ERR_PTR(ret);
+		goto free_gart;
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -502,6 +502,8 @@ struct gart_device *tegra_gart_probe(struct device *dev, struct tegra_mc *mc)
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
+free_gart:
+	kfree(gart);
 
 	return ERR_PTR(ret);
 }
-- 
2.20.0


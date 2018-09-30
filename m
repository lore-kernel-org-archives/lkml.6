Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F3FC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8ECD206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK8USVC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8ECD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeJAFYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35887 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJAFYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:24:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id v17-v6so8471991lfe.3;
        Sun, 30 Sep 2018 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OX2jk+Hf4sX+ULT/vYJjIv2oSae9Y3iyZxkT+JjBIdo=;
        b=dK8USVC8jd1e0/JbxAcWzAuGH3MSWuH6Zg36pb7JzTF7jblJOFHW8dLYnQHmt6Tul3
         /6JhFl6ZhJczSNKItjM/YNlzzEBvavMfmbi24CwoqLEyPpGSLSbZpmEQXsEAz7rcmHx6
         /PYVGRzGpV+dtkRFwcmPskLWnD8DrIsRwcgR3CVDQ70Ycr1FTBnGA4dnUm7Ngtiha4om
         n0gLzATwpdMpSgg9SXHr9vygSArzO/Wi7HngVHeDRBe0D/+cYV1+AaqbwzfE1EQGfk2T
         7yhlUyxSbmdY1kQVjaAkLUY0uryodZfKK39UiaZFBsR5ShSpn3kq+noyGZBVV+CD/7/u
         VxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OX2jk+Hf4sX+ULT/vYJjIv2oSae9Y3iyZxkT+JjBIdo=;
        b=hpS497CApFMaDr0O2vnGKBrqoswsDZuOgY4HnVPKXgXgj6PHHJ5l1vHta0c72h4v11
         FmS0U8THW5zdgjohIxgtmFWdWLSE2bH0e217jWJHufyaKxZbCZuHgu4bhhcNIjcwOxMu
         mdEUohBXrVcD1jSEL+dCtY2+nFImvh1CRyuPvwWdIMpQP7b20UnBKUf40Gwiy/mfqwRl
         muePT04r7uK/lKqjv+4gHEJrH2LmaHjhnuvL5bFAsDzV/ghcUO8pObIMZe5RnN4eUJ66
         wgafhAf87mo8I7kK36PZ9IXAjEhLb5Pnpw8jC+EaU5COMiJUu3Nfrd6YYCreUmR0H5Ak
         xbVw==
X-Gm-Message-State: ABuFfojLqnH7DPOLpVY+eF/v5n54b39/a6HqbAKDOjbVM8X6TPI3GixO
        k0epHhr7bujfBZQoAqrGsxE=
X-Google-Smtp-Source: ACcGV633HPqBa6GuR3ysW3GlsHsehW3dU8JA4bGvDvycJR+St4AGUUwo6a8A0vjjgZPSVOKXVkqxeA==
X-Received: by 2002:ac2:4159:: with SMTP id c25-v6mr4174274lfi.19.1538347750616;
        Sun, 30 Sep 2018 15:49:10 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:10 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/21] iommu/tegra: gart: Don't use managed resources
Date:   Mon,  1 Oct 2018 01:48:29 +0300
Message-Id: <20180930224833.28809-18-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
index 9f7d3afb686f..d019ae8ecfc9 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -171,7 +171,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	struct gart_client *client, *c;
 	int err = 0;
 
-	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
+	client = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!client)
 		return -ENOMEM;
 	client->dev = dev;
@@ -197,7 +197,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 	return 0;
 
 fail:
-	devm_kfree(gart->dev, client);
+	kfree(client);
 	spin_unlock(&gart->client_lock);
 	return err;
 }
@@ -212,7 +212,7 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 	list_for_each_entry(c, &gart->client, list) {
 		if (c->dev == dev) {
 			list_del(&c->list);
-			devm_kfree(gart->dev, c);
+			kfree(c);
 			if (list_empty(&gart->client))
 				gart->active_domain = NULL;
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
@@ -459,7 +459,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 		return ERR_PTR(-ENXIO);
 	}
 
-	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
+	gart = kzalloc(sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
 		return ERR_PTR(-ENOMEM);
@@ -468,7 +468,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ERR_PTR(ret);
+		goto free_gart;
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -506,6 +506,8 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
+free_gart:
+	kfree(gart);
 
 	return ERR_PTR(ret);
 }
-- 
2.19.0


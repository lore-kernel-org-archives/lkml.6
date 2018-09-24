Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA4ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0FE21477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2ASgkeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0FE21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIXGrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:47:22 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38402 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeIXGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:47:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so3288018pgr.5;
        Sun, 23 Sep 2018 17:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNFyc2oqPrDinMLJ7sRVVOcDAa0uc5ygovDje1DARpA=;
        b=L2ASgkeHbXUVXLNvx2BTumGucvec9M3oCi/94OTlG6ZBE9x8Ui3Zmkv/YXKgT2zrYi
         TNbxxib8aSJDoccSzN8h7jLkVzg6/AUTzc4BJoFeHvJs0CoSByExqqF7tXkFI5/0uoub
         4/eiYJ7WIkmkOPAYTIUZqGOtVmxvpfJaR/hgN73Ngn9cD3GyxKQBkEhKMxD9+piVUySb
         oUgjJcSWl9hwLr8mHcwk0ADHHyWzZhcoIiQg6Zw9rcBMYiMYj5zNUhE+1V8NLYAx8T25
         GQW1B9wWZ2+0tktcQcDRWLZ+lpyq0zWNK1cKHdcJkh9Oum6K4tf/bY32bU3MiJBcneVr
         dcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNFyc2oqPrDinMLJ7sRVVOcDAa0uc5ygovDje1DARpA=;
        b=pygrEMxG99wHyK2wKKGQkLNgzem/9ypG3j0MeQ+mwui25X6E3jjorZH4qkYuQSBDI4
         SmA7UWA0YHIx9Xci4/PSFg1LESKctPBoQxfbvZWl6w0pDGGMACDt0Qkh/GvornuND7jN
         eS3uOOauvkXFhdOuM0sCMxJKHUkp9gwJMQIMer/FsA5Nqupj96K3uaL/KY8YKET6ZHZd
         otY6aLF+ZwAFt5R58cII4YycY4AMHUQwKDpD/oatpn48qyC24A1CLlo7Q2VE/RNTrrFn
         I838XpKmTultnlXSA4fOfg6BSrTRYh68vJcLBopxU/lWV2AKK6qAE3F8KZsZ0HgcUjot
         Eppw==
X-Gm-Message-State: ABuFfohKq3i781vVVm3cYXjDQWaqfX5IwUvdcrQAbKga2NvP1mFoQaku
        GM2CKM/oqNUSciVPaQvUeic=
X-Google-Smtp-Source: ACcGV620eGTU7vKcubt/6jFsduT386tOcDoqVWJt31hEl2SdnBC98fBYs7LCl4HS6EnFk5HEq6PrMw==
X-Received: by 2002:a63:a54f:: with SMTP id r15-v6mr7335727pgu.336.1537750064482;
        Sun, 23 Sep 2018 17:47:44 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:47:44 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/20] iommu/tegra: gart: Don't detach devices from inactive domains
Date:   Mon, 24 Sep 2018 03:41:51 +0300
Message-Id: <20180924004153.8232-19-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be unlimited number of allocated domains, but only one domain
can be active at a time. Hence devices must be detached only from the
active domain.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 284cddf90888..306e9644a676 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -167,7 +167,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	struct gart_client *client, *c;
 	int err = 0;
 
@@ -192,6 +192,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 		goto fail;
 	}
 	gart->active_domain = domain;
+	gart_domain->gart = gart;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
 	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
@@ -214,8 +215,10 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			list_del(&c->list);
 			kfree(c);
-			if (list_empty(&gart->client))
+			if (list_empty(&gart->client)) {
 				gart->active_domain = NULL;
+				gart_domain->gart = NULL;
+			}
 			dev_dbg(gart->dev, "GART: Detached %s\n",
 				dev_name(dev));
 			return;
@@ -253,7 +256,6 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 	if (!gart_domain)
 		return NULL;
 
-	gart_domain->gart = gart;
 	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
 	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-- 
2.19.0


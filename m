Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D92C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB40208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbaT7sFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB40208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeJAFYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:24:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42023 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeJAFYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:24:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id s10-v6so998437lfc.9;
        Sun, 30 Sep 2018 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpFm95RyynCLyx0d+CxgKcXu2ZeP4esDrXorjVLHtgk=;
        b=HbaT7sFu5VDn5rRA/7Ax/RIj5wQzOfGWBWKv8LvqUhGQoXwiyWA9rdAnivoJRL1AdD
         iivVq4F/uWhgdvjXf8wbT2Vcx/14ZYNCpCJ2RN6pDFsVPXWqoYYu657aZgh0ekuEUI4I
         q2/5OjxZ/+t28adQd6kSgiKF/Lbv4k2YKgGeL5u8VV186Zas5Kf/2FWpjARzn4Q8kxVc
         nlxuJ/ATBi/yJgeBKN4w5D5DhGiJMYEoRfHFLJXK314uKKBQB0W0noRprz4KFyAJgPEc
         gdncNXejfnSe3qdq/ESLGbeaSAsbNNQ9euqMps9MNRpq5vB1f4X0UuGwkxqgeVtFBSoV
         PPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpFm95RyynCLyx0d+CxgKcXu2ZeP4esDrXorjVLHtgk=;
        b=AcStuA/LjOOTe4RN8t71/S1XQYQPbphEZDxnxDEzji523LMtAM7VdJ4DEPik+d/oeD
         EUCcNx+Zs/izFYRi5TKYNnQQYA0Oq3GqV5+JWzEcRYrLJMtlTEhm9E8rknB6M7cW1WvW
         ra/JX0kDSlIIf7yrgOz1WVgMLFEDp+Y5p4EtucbVP+RA6A0rlkLwZcZKtpWwx5QYXvgn
         HBl1CkN6sewlZDPWnMuLcxT7TzmueZoeuiQBCjNfWfA55cgC/ihZ24xLdcZ8Q/44Vs/E
         cYTUbk1OH3bxDUDS5Onc7/IdFlH8LmfemXhqoLvZGx4gDiSQwdCxIDEwKjqUDpSjrhXo
         wAlQ==
X-Gm-Message-State: ABuFfohMcSdztjgvZ0jzPDSzF0NF3aMrIsYJQ+Q0eCyx0xs+y99xk8K3
        Hsvg7WcVw8Qv1y0gn3IbwcY=
X-Google-Smtp-Source: ACcGV63MSLEqtNwRkiYXva0mG2H6KQWGu11rsswTzONH/Ely0RgFer/ia8yVaQVZDgXA5nrPcfj4Zg==
X-Received: by 2002:a19:e21c:: with SMTP id z28-v6mr1980186lfg.20.1538347752501;
        Sun, 30 Sep 2018 15:49:12 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/21] iommu/tegra: gart: Don't detach devices from inactive domains
Date:   Mon,  1 Oct 2018 01:48:31 +0300
Message-Id: <20180930224833.28809-20-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 79e364406c40..101ab3b40c2d 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -169,7 +169,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	struct gart_client *client, *c;
 	int err = 0;
 
@@ -193,6 +193,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 		goto fail;
 	}
 	gart->active_domain = domain;
+	gart_domain->gart = gart;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
 	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
@@ -215,8 +216,10 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
 		if (c->dev == dev) {
 			list_del(&c->list);
 			kfree(c);
-			if (list_empty(&gart->client))
+			if (list_empty(&gart->client)) {
 				gart->active_domain = NULL;
+				gart_domain->gart = NULL;
+			}
 			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
 			return;
 		}
@@ -252,7 +255,6 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 	if (!gart_domain)
 		return NULL;
 
-	gart_domain->gart = gart;
 	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
 	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-- 
2.19.0


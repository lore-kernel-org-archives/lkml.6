Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12563C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C194F2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT3yHxTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C194F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbeLIUb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43475 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLIUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so7762957ljf.10;
        Sun, 09 Dec 2018 12:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CDyXCzzCJ8q4lb4wCIqGHfi6dS+V04hC5Lh6johlwDU=;
        b=iT3yHxTIYz10cliQ6PAvHxLv1NaFTMad552TYNDlQduphLBeqrXmGG2oJpPwnDndfW
         tPymPIWfmvgJjaM0mOxznjZB4sZToInrK2YYFxmDqatAPVs/ERVNsx4jkV0Re5PxS9d5
         QKQMevWb5T/5adZqWJUI9rQKojXk9ohcPtR+YqEtqoCTHVPlBQngvd3fUUzAe7/tPJHa
         z9sB71oIst/SKVX3kqAPKJNOrUrm+h5qnVVGnK5wHN8wn9bTDQwKuEdsw9Zvh9Jljr7V
         fDzKMpVRdnjWTNhzURIa8FZPVllvjuK2OXANZjeEIqM5aFiE30EgkXgKU9p/BTLz6938
         mEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CDyXCzzCJ8q4lb4wCIqGHfi6dS+V04hC5Lh6johlwDU=;
        b=Q8PHDsnLIBqOAQ2oP+EAXebVPP/l1jWBPBFS7WU82g2dgqmMMFxMF1UviSdJlvGCvG
         1Awfk74sf4/yp4zuZDaWkSGO8z4OGks+aWV5k3IVZAorsXeGdAd2kxxKl1xTn0BehOxQ
         gUK7Ts8sopE0rg4afP/c+8j+eZ4IkswWjtG7s0zqC9on2yWcnQKSEMtP+eIDNRx9zGtd
         xa4Kn/PK632lt9LY3FqPIOJl/ayCLyL/skseBP98zgbtsG7B7d8brSl+65LKdvxsWH2p
         wemx3XWyiq2G8Pf+6j2cNuQbHNgAzSseJpwVqNkYsjipDIWjvT4M/WU79Vb668zlbw9a
         NVLA==
X-Gm-Message-State: AA+aEWZt9Vc80UN687R2ShBs9XRIKoQSFdvdjPi0dpzWLxmiarI195ob
        1r/0xWdkcr81oabd8BRGpwA=
X-Google-Smtp-Source: AFSGD/UiLfGN5JCqDMvU5GGjZY+V2QTemjwEIio1MArjbrRJojiCJmw0HPlxqLo1/FN78+bujK3Mvw==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr5407324lji.167.1544387480190;
        Sun, 09 Dec 2018 12:31:20 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:19 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/21] iommu/tegra: gart: Don't detach devices from inactive domains
Date:   Sun,  9 Dec 2018 23:29:48 +0300
Message-Id: <20181209202950.31486-20-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
index 9d2df43ce50b..f2dc7e72be80 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -171,7 +171,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	struct gart_client *client, *c;
 	int err = 0;
 
@@ -195,6 +195,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
 		goto fail;
 	}
 	gart->active_domain = domain;
+	gart_domain->gart = gart;
 	list_add(&client->list, &gart->client);
 	spin_unlock(&gart->client_lock);
 	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
@@ -217,8 +218,10 @@ static void __gart_iommu_detach_dev(struct iommu_domain *domain,
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
@@ -254,7 +257,6 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 	if (!gart_domain)
 		return NULL;
 
-	gart_domain->gart = gart;
 	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
 	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-- 
2.19.1


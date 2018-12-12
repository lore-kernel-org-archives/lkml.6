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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AA2C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAB720851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjT2amFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAB720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeLLUyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:54:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34103 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbeLLUyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:54:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so8895308pgg.1;
        Wed, 12 Dec 2018 12:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iR42oOqYi5przQZm71AZ12CGa/gTigN611ZJ7xxK3x8=;
        b=LjT2amFZbkDjL/nUmJ6evYMVE5n4wX4DcbTRFHLukVjjqxmoX71elhgB37rrWko5St
         VP5aFLFs6mKtWXkQa+JQs82zuh3p9ieGzl/fzaAEncKcQBWzmRbSSVwvZNrNbF+1HeSx
         b8Ru308L2D7CLCvpKa9CdcAkwez58+7ad+jb8LmfPPfvMKrQ8VSP1dplmEVx5BBuBkX/
         rqZyH7JAVr04/mGzaTR0zJCU2CsC7yYoJA2KtS4iZX2BnPIe+QFbGA2exPjpBRIqnwg5
         oaI0vRH0xUGts7oDOkJO47h63vmaP3oAPYTJJwiLRYGX+TycawzoadQqEqxnzxOKkBMO
         FVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iR42oOqYi5przQZm71AZ12CGa/gTigN611ZJ7xxK3x8=;
        b=jzDtOO0CB2fqc1V5tiDE+74d8GMjHOplmCJ8v8Gx9ip+qZuUCntXlPWyXq0a5Lm4c4
         K9xkgiYe6JLXGDnPmH4bcK8FoV30LysWIVQ8w6JDgDEvcEY/ksWfOd/Ab49JRkW8S6Tp
         cnrZETmr8r5Xfh07cmuUPjCqC6k9Nr6AZgvm1i2Y7nuI9XDWrezAVBu+JowD99EcJBa3
         5NtbLf3zdQlSFM+/fMz28debgch2WP1bqVLAP5eWnQ8tVL/AdaJDBtrIPU6jwuAn0a3K
         QvSEAIXF0wM4hfIsOAm7JOpFQ7i3Jl1lEZkhIh85Qjsp/zYZg4K/9GWCThfYsrKenJzT
         GZtg==
X-Gm-Message-State: AA+aEWb5bk+5zbzN7Uvbvkp0mw/IlXLZ++6AEYQi8XhS6/nN9mwU4kGI
        czJRo9H1f03RBx1xu+iqhWdrovfL
X-Google-Smtp-Source: AFSGD/WFbC64OAcvt0NyeZDUvsWoOvO0HPm8RFl08C0lBJ+APieq3M4my3bLDAPZJTInHRlHzB2GQQ==
X-Received: by 2002:a62:6204:: with SMTP id w4mr21824210pfb.5.1544648057001;
        Wed, 12 Dec 2018 12:54:17 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:54:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 22/24] iommu/tegra: gart: Don't detach devices from inactive domains
Date:   Wed, 12 Dec 2018 23:39:05 +0300
Message-Id: <20181212203907.23461-23-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
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
index a3ce6918577d..74c9be13f043 100644
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
2.20.0


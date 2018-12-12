Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03685C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA3C2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lavKos1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA3C2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeLLUwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43882 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so8877086pgk.10;
        Wed, 12 Dec 2018 12:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kU2Eh+wKq+ENzmEj80WdRyExzQltslyeqOLAnTZMbZw=;
        b=lavKos1YyP7Q/dEQ12FA7Mylpl7HhrOa+utkSJblEtGSpn4gq0uIwjlvuLN1zkvCO7
         fwdGwhbOG745/Jj4XzV/DFZc5rF32jS/7aHemM0aYjoxmKEjkswPe3UmoMI94mhSnDIJ
         4OMDx/uiGgFzAWo29MrsFRAU6VLWSWu5E3ra8Yv0iVpZqyUdrICazAsGeAhQqhOetrWv
         I0Ej2vrPyZXAI++sDx/fk/0rxHAVn4W26JFeYjvyONfiBEb+PkrX6OMW2GICEUSuP8X7
         5d8s7jXLXDxgkMiRZw8JczSO3/woprOeHk/PqBoxZHKnuaoY1JM4i7f/hn2H/yYEP4aJ
         Onjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kU2Eh+wKq+ENzmEj80WdRyExzQltslyeqOLAnTZMbZw=;
        b=RKxfU5cUIP2N5c+nAttfelzDt4n/1DPQPFL4OC8TRFcX6G3bc3EsZC/aeOZuhZXj7n
         SSfMsM19QbOjLqKeGFwkwrJPVpakpnJjXBYzHg2LzLs2XTdoGJbSgLtDoxbj7QqJxw6q
         m8iiWtnW1L2m1w4Mx4BkgHlzyxJq+BN6HlefVz7q8C5OQWtZ/QMGxzCuwrA5nx0J0Tic
         EUtGQf2RhP0/k1+/Wn/7D53TnFNE1xdYP4jexPzzbMWyrQHsvctc3NM/J9V0cAEb7ohr
         sAKZ4PoLvhAV5sOW0xJOJO13ckOt0ni/CtHACb9NcNTX2PB8LSt0Gly8dh2RWLCzZ9W9
         1Xmw==
X-Gm-Message-State: AA+aEWY+RhAjfSjrr7vpsjMKjvLRt5crF6ztxFUeHFBCttXTVx6J24En
        BNk41zgFVPoKmONmstmDY1g=
X-Google-Smtp-Source: AFSGD/VkiwFEQxGFMkkXJAJS8S0WAORIOXCS6Tc528n0CFUZIv5J2Xd3aaSfLT4J2i9VWDvEN7a3Yw==
X-Received: by 2002:a63:64c:: with SMTP id 73mr19409062pgg.373.1544647950091;
        Wed, 12 Dec 2018 12:52:30 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:29 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/24] iommu/tegra: gart: Optimize mapping / unmapping performance
Date:   Wed, 12 Dec 2018 23:38:48 +0300
Message-Id: <20181212203907.23461-6-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently GART writes one page entry at a time. More optimal would be to
aggregate the writes and flush BUS buffer in the end, this gives map/unmap
10-40% performance boost (depending on size of mapping) in comparison to
flushing after each page entry update.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 37a76388ff7e..835fea461c59 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -290,7 +290,6 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		}
 	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return 0;
 }
@@ -307,7 +306,6 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	gart_set_pte(gart, iova, 0);
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return bytes;
 }
@@ -373,6 +371,14 @@ static int gart_iommu_of_xlate(struct device *dev,
 	return 0;
 }
 
+static void gart_iommu_sync(struct iommu_domain *domain)
+{
+	struct gart_domain *gart_domain = to_gart_domain(domain);
+	struct gart_device *gart = gart_domain->gart;
+
+	FLUSH_GART_REGS(gart);
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
@@ -387,6 +393,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
+	.iotlb_sync_map	= gart_iommu_sync,
+	.iotlb_sync	= gart_iommu_sync,
 };
 
 static int tegra_gart_suspend(struct device *dev)
-- 
2.20.0


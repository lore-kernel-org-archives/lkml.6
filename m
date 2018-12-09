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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB2C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168AF20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnVDUek7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168AF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLIUcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:32:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46489 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLIUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so6465217lfc.13;
        Sun, 09 Dec 2018 12:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kpbVQdi3ZHraVtNMpZOmbkfIijQq1T8JT2z9yI28PUY=;
        b=nnVDUek7S1WqdznHy6x3EbaJlLM3C7ZkkkJyzuHkjx5xbL03fG7k/A8AErDeIpEROo
         6zllwFV8c498/IDOCoCOB3Q3OEeHTLMtFmlobH2Piv1x7A8VvcyNDYLCJk5FPxtz1kR6
         XKySAuPo+M4oVm64oLQllJhqjFyqOBSOKYJak4vrNkXC+5OlacCQ8Jxg3kqy960fP5lc
         nq6PUzJ5rlP4twtipHVOOSDpM4BH4YwYZ0jFVrRT0Hf0siC/RI6IkyygBBfjYo2P+RON
         RoDs2tFBRttTLan2qTpuLgiVhj99X0Wi1fxF5FOklEKKOsiaDu7rf9F9bjR+ULghV0JG
         zcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kpbVQdi3ZHraVtNMpZOmbkfIijQq1T8JT2z9yI28PUY=;
        b=IG06S4TQ6toC//tXehCkZo/+iWD9Ez05gmiXbvg+a1AUXvTQhfM24ZVa3AMI5xEy2q
         6lg+hLhthYkDjf6U/IuPTkB0IpE4JBdZQNACMuU9RlitDXU3Ktyh4yyylX1a7zq86j2j
         oprx+HkNdu5+VDXr9chZSELfjUXpYE/83I7kPvuBgwMf7/T57JH8TS/agRyapfBZEW93
         T60SACds+TVgmavxt5ZXQ48i2OdtuCFOMkgBZfbMZ7I83ujGRBYPAqDI1fXcx/mvZUlf
         KcR3IqprMuZqrxNEyZUqWbYPO7oYtLJx0C50tV1Em5oAx0QxTdkJYpn0MCuS4tHkyy5I
         DOsg==
X-Gm-Message-State: AA+aEWYMRULEqmrJkVOnO6RWnOKZIB2QwW5dOhv7XibPWpvbbthJb6oq
        qJCWt1mkkhLWFVkuxfqGyGE=
X-Google-Smtp-Source: AFSGD/Xcz8tBvamzVy0Zxv6iRXV15iEc0jW1eno8IJ+dwLIglWub6yyqnkZFrPw7dQfmPWh6/QBz5A==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr5742419lfe.73.1544387462571;
        Sun, 09 Dec 2018 12:31:02 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:02 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/21] iommu/tegra: gart: Optimize mapping / unmapping performance
Date:   Sun,  9 Dec 2018 23:29:34 +0300
Message-Id: <20181209202950.31486-6-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
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
2.19.1


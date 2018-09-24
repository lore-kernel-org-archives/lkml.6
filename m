Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31477ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B6521477
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 00:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOUFSx6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B6521477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeIXGqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 02:46:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37099 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeIXGqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 02:46:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id q1-v6so2864193plr.4;
        Sun, 23 Sep 2018 17:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2PKJHjqEhI+l//cZxSKKS1WEBOnDTX7PbZa88wC/DU=;
        b=eOUFSx6/VLOL1XKeCTBujqagN7IgX3JF8hA6z852l26wQXhyyCkI2qmGFVUP6mwPCG
         x/U1skJQZKoHNbQ4vlQtj21RqY+3GuZf0d5pEE04wjaMbtEaoUaSUQ1GqycCjdi9xEkT
         lEyT2YS/GeGOr3sjY2E7GKGWUblQQOZ7dZRtLuVhmElxwPu8nQ2dEqaXk44qWGIO6sTg
         Nu9uuV4zgF3IqEOPsi3j/+dNMBhO0GHnP6VfnYxz2ZPcCy1JsMX43LdSIURGNqMZj108
         qzEMtRLlrrf+UcBB4Cjq/GZxVMnHbKhHqSKEq+XsO5Osd4lCx41kmFFVZkeKGH/JzTjZ
         CkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2PKJHjqEhI+l//cZxSKKS1WEBOnDTX7PbZa88wC/DU=;
        b=rARO6V707Q0E4A2wYxO1PI2RL3jQgXxj7QiTDj22DCogFyIQAzq6n8VyvGo+cyjg29
         SGk1SoU+Ax52XstX2RgsFI8XyeuICoWoTERZQMKNYb/caVcBAyEVT5Z/BDjTfR7MoJu8
         SJhq11xt5Zpsoex0c8So0m1hoYxWUUnczpw4T64xeLplZ/YSWs0fcz1tCfbY+KcxiQ2a
         PLvfeLcYxS/+CQvfyVDLD/kzu+iukH8nz3QhTghVEpICITsRalCIJAEdsl1gRB5jx79M
         7My/E0moOe20NwmrLSqatR82hHPYIt7lhTaM7x61rAqHjuDZyCIq4FISxZZaG8XsDXwy
         m0hw==
X-Gm-Message-State: ABuFfojnNukDSmsBcTC//xwQeKlpA4tMTxu+iuQDhK6h+RxBsu69Ul6Y
        tpLRxqEZAv1n7qWqWn3U8fM=
X-Google-Smtp-Source: ACcGV630EHtLbE9IGVmmVcUmFMcYNZkbxw8L16Z0covYoyg0pbmOjgTQb1iXCSZkKxHV/yv3Ejnhyw==
X-Received: by 2002:a17:902:bf0c:: with SMTP id bi12-v6mr8232719plb.219.1537749987412;
        Sun, 23 Sep 2018 17:46:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm5121839pfr.115.2018.09.23.17.46.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 17:46:26 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/20] iommu/tegra: gart: Optimize mapping / unmapping performance
Date:   Mon, 24 Sep 2018 03:41:38 +0300
Message-Id: <20180924004153.8232-6-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924004153.8232-1-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
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
---
 drivers/iommu/tegra-gart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f6cf5cd5aaca..86a855c0d031 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -287,7 +287,6 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		}
 	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return 0;
 }
@@ -304,7 +303,6 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
 	gart_set_pte(gart, iova, 0);
-	FLUSH_GART_REGS(gart);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
 	return bytes;
 }
@@ -370,6 +368,14 @@ static int gart_iommu_of_xlate(struct device *dev,
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
@@ -384,6 +390,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
 	.of_xlate	= gart_iommu_of_xlate,
+	.iotlb_sync_map	= gart_iommu_sync,
+	.iotlb_sync	= gart_iommu_sync,
 };
 
 static int tegra_gart_suspend(struct device *dev)
-- 
2.19.0


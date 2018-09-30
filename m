Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194C4C64EB1
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4156206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDWxltRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4156206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbeJAFXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45347 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJAFXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id m80-v6so8417086lfi.12;
        Sun, 30 Sep 2018 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUBGQXr9TzzQxupm0eHyVALZGQxk87lchVmr+6ZPQ38=;
        b=bDWxltRQ6YE2b+myBjDn7HDRM+n9QwTznLRM+45gz706H1BwU0tAcBQ25Jy5973uav
         uPBOaVmX7XGNXg8Fbf6JWTAi5C2qu1i5ipwFRCABjWX9idJKUrFb+bbA1S7xeVf5kWpE
         kmUO19FwxtyHK0AUXuGNkhRPLNdT5e4DetxwTkcbJczv55s/Pal3SjanosRrquW2DMu4
         kvt/EO3q9Rr0oc90Qt3eXCSBhRAatGIrQSbijpkH4r/bN1YY6LHs0QpPy4dCnFZzi/ty
         xXQ/kw7jTGgH1OxhSacBshva/hVd1i66/OqJflfWV52cP1LNFkPmFu+KDaxU7e9pQnaz
         SytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUBGQXr9TzzQxupm0eHyVALZGQxk87lchVmr+6ZPQ38=;
        b=Yi5Z7JHPLpcnUyhbbaR4YnkKzAkR+UXgdBjjDwhtfJDVZtMv+QKsbyFqyP/02PxbZE
         21to5scc5QbGMa0g2GpFv0udiJfX9a/ljlnq1h7e5bhH2h0mG9OGcNKBBxgYxiNJdnyA
         KBBpI5UXUQbj5Mm7jjMlTwLIIaPspwP317i/W/goDYOddoawnmo5KdwRdkpp3lzTXQt5
         RMHsnY5lIXXvv02tG4Rx/7YRv+R6BKQWBXsImKWtq9zcFGk8d31NV3eNyQRA8RGIPpdg
         YydjqQi2137jLaUfPl9J9cvWlKydpPiSNJ5sdKhsCOrvftGWiPl0HZJlqpjFwd8sYLIZ
         8N+A==
X-Gm-Message-State: ABuFfohuXcAd0Lg3E/UZ3Ici20e/b/NaIqIWwthqE4ixSHAHc8oYmcq+
        55VZLMES5sAdDMy/d4MbEiw=
X-Google-Smtp-Source: ACcGV60LUUGosdc5g/rb2ZVObIWLJ6rrgtExNXvU5gsVBZ6ec6vqjwxieqh3GtYM0bL5wxzJPmJgfA==
X-Received: by 2002:a19:2a12:: with SMTP id f18-v6mr4106963lfl.28.1538347738697;
        Sun, 30 Sep 2018 15:48:58 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:48:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/21] iommu/tegra: gart: Optimize mapping / unmapping performance
Date:   Mon,  1 Oct 2018 01:48:17 +0300
Message-Id: <20180930224833.28809-6-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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


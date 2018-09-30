Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6EC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB0D206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdIJzIOk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB0D206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJAFXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44993 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeJAFXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id m18-v6so1803298lfl.11;
        Sun, 30 Sep 2018 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTEaimgMLC5itx08UKiy+ogELReEsfmbYnueAAu86WA=;
        b=DdIJzIOkGhthRxR4k4XX7XXVfezkTB+RLdQjtZD7nDdbjfS6zICyB2GCOqmnFy1QzJ
         3PoS1nmaZ23KCGrNkA22jeW/tPx7SeT2JK58za5WjhIVabmMIxTU+tfYbGqv+7UT5ZCg
         uMu6gHWxcEbBz4StoIsYzpkZk63yMtrOYZbLAugorVrZqcckijZRkOvkEZxRXwNweu0I
         7gdEmjzw5okmjP2HABLVthsw5vAGQ/Vm90BwPR/Tr/XcDkn1TGbqPhE09i9Ey1psDW2k
         6yhl6bo5C4xGcrfVFxS7fc3wzO1zozQrBfYqXMUfJ5zdTmW9faakWKbiijbBt4K975Gj
         HzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTEaimgMLC5itx08UKiy+ogELReEsfmbYnueAAu86WA=;
        b=ZB4iSZvsg0i+NbjXQOhCIhCQKAEOXeXssVpfbibqef84cbk9Dy/kaVgyBJgvCLy5+0
         hR3MoggwmjHwtJBIuakI5LVAxbVKNiebizkAyGPypQp3CfZe7FT21cUpnhna8rvm9y4V
         dYZgg6UlZ/H0YTijeE7XDfDjBFQn2dQ5qzS2tEORYk/JjiQ25y3EO3Kpa3hYGdUonHt2
         carupx/kgNmsdMdAUfweljZJhin5Z6h93QLZKL5m+k7BKgt6N5zAVYuv/lKgUyLmbgp1
         x2YBiLLVG+BT0gq7TPNJCdtaAQ7DntoWCd7POI1QejCgghMBBWvbytSO09LB6dGUiCTA
         1yOQ==
X-Gm-Message-State: ABuFfoh/RUUPWyohAA7ui5mbGpbORFIExzdnekR0EWA38Wvq2imGGali
        HbJ6uS2go4KsTMiJbIdRNwc=
X-Google-Smtp-Source: ACcGV614eLZiA8KehXP3HzEe/Ln38CAkFSQ3BCO6Cw/2quubMq7CB2wMWKyvP9Cig/OiBAtccQCyEg==
X-Received: by 2002:a19:d824:: with SMTP id p36-v6mr3844656lfg.23.1538347736905;
        Sun, 30 Sep 2018 15:48:56 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:48:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/21] iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
Date:   Mon,  1 Oct 2018 01:48:15 +0300
Message-Id: <20180930224833.28809-4-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART can't handle all devices, hence ignore devices that aren't related
to GART. IOMMU phandle must be explicitly assign to devices in the device
tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index e9524ed264cf..f6cf5cd5aaca 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -342,8 +342,12 @@ static bool gart_iommu_capable(enum iommu_cap cap)
 
 static int gart_iommu_add_device(struct device *dev)
 {
-	struct iommu_group *group = iommu_group_get_for_dev(dev);
+	struct iommu_group *group;
 
+	if (!dev->iommu_fwspec)
+		return -ENODEV;
+
+	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
@@ -360,6 +364,12 @@ static void gart_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(&gart_handle->iommu, dev);
 }
 
+static int gart_iommu_of_xlate(struct device *dev,
+			       struct of_phandle_args *args)
+{
+	return 0;
+}
+
 static const struct iommu_ops gart_iommu_ops = {
 	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
@@ -373,6 +383,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
+	.of_xlate	= gart_iommu_of_xlate,
 };
 
 static int tegra_gart_suspend(struct device *dev)
@@ -438,6 +449,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
+	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-- 
2.19.0


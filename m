Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA36C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7658F215EB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQdonk2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7658F215EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeHRTDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:03:51 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41695 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeHRTDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:03:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so6110329edr.8;
        Sat, 18 Aug 2018 08:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ptf8gnYc/0ZhN76ToXP1EAN9E1bddmt41o9VjobpoBA=;
        b=OQdonk2TmlmXTgyymOY6XDvatjQK1aQ0U6g4ZtX10vg82i/hwT/NvJK98fTgWpfl+W
         AvFgyjx7T8aTJzebFb6pQYG5tBGTcSHllj2fao7RunkCb4aAREaKGK5CErXq4aISe1NJ
         DlQsD466c50PO2SQFSSmfM3RYvWaPSVpFDQjhaoeRTxF5TyHE/9uuSsaffv5qpdFwyP4
         sCkXXyapFs4ndaMH2GHLSI2+wDlCrF6hClghwqQ5xMXGlbIL40NiBEJypZ+y4E+6puAk
         lcpygMrbofopXzPQvJsz2reRgIsZeNDbqMHFS2j77aiPon/RmIV8ZkOatXT+635IxiN2
         YbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ptf8gnYc/0ZhN76ToXP1EAN9E1bddmt41o9VjobpoBA=;
        b=aZ4Ht4VvND5ue4cnc2C9bHWArgYZ6g6HKVmQrvynKyh7y2z/doThkBh5uj/u0gy46B
         enwxSGfD3lSsLzQZOIiKA/2AMsXCN03Mx49p+xbpSO0v3jOO19qdrMzSvllBhM/0eVha
         e4o31luUNzdNYI8IzZ4CC1DWdqM8F4LjIYTkvJA7NSDPsiiI2UjRjN4TcpqlGgBwTYvu
         NHeYtonhg8vhbQElCMrz5PEAxc8jvC4CjMv82OBkgsTN0N1S/xkvL2S/YX9AAUT+6I4O
         CECetXbT3Kd4htgVCk1LuE/hWKcS2IcdUVvIHkzP726bzAJ59h3GBlmfPkomBTVf403F
         E6cA==
X-Gm-Message-State: AOUpUlFFNs7R/K89kXL826Q5S+J8uD6Z79xXj886zN4LvQ97gO+5Wbiv
        2hRJNplka/W4gSpE7z6E+sY=
X-Google-Smtp-Source: AA+uWPxX9XkuvRMtqfMbd865RSqef8z30mgZT2twVKLFBG2D5o5mz9x+4+GSjyWg2sqioY2xjKNTOA==
X-Received: by 2002:a50:a93c:: with SMTP id l57-v6mr45539846edc.229.1534607740370;
        Sat, 18 Aug 2018 08:55:40 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/19] iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
Date:   Sat, 18 Aug 2018 18:54:14 +0300
Message-Id: <20180818155430.5586-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART can't handle all devices, hence ignore devices that aren't related
to GART. IOMMU phandle must be explicitly assign to devices in the device
tree.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
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
2.18.0


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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCFEC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAD72080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5RmiOiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAD72080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeLLUwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeLLUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so8886036pgp.7;
        Wed, 12 Dec 2018 12:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvZF4Cwn2c8hVYMCApGqp+umeo8NNVKrUr+shTKYQ9M=;
        b=I5RmiOiWnSD5upJYiAC2be5GBtZc5iXSf5nXQsyuAhHYiVERF0xPHAeFVH0TZzJ3SH
         /D11Shu2344PAZYMRmhIoXIc51GWr3waKj/XJ346J55A5Z/7eyh6pEdT2bNKSqbgLEpP
         WtlynAkGsowXyRnpHQT3d5fRFUv6Cj1gegH0+O7RRUuO5F5OWzt5GjaybLeqYbiDPX2I
         uS0LyzrJlYTHwYdqWDjCxkEzZ/4b5CstMatKf8PyFYR7P6UKCmiVZrQB8ZizMGF4K8Vd
         eotM6x+Y7DYL/wEDbZWGplryusfn3IaNOCEM6lO0V8x9sOkaMcdbDaxd9bMqS7SigFn9
         xdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvZF4Cwn2c8hVYMCApGqp+umeo8NNVKrUr+shTKYQ9M=;
        b=oIGjRosdqWo6jhnke0rYY3H9/LBMh0b3BMVQkalWreOjoE+de6TBOdzoM8vigTIQlI
         cBBx826a4IPvu6+JcYNo8GMC2+/GDIyo871zP1wNuMXX6JnPkUPrh+6s6WT1mbVgqcE8
         Rvn6AeA3TlWajpBm3GfN14qWEmh2UCL8rMAgGdZwdm7UWCxl8FnkFvlFPwBWSP2cSVNI
         WUdDvc6plf+wcUznMSavWBdb0AwzIJHSj+PaDIhz3+8/rhzYbRF5qEE7ps8ugNP65dLr
         wgmnLl7PQVkuj/WupEqCCRBt1TiF10jIGukxzqfxbx5MgZbOsX7134HDEgGjbac8y494
         U8rw==
X-Gm-Message-State: AA+aEWZW5AtEG6u5/FzVfE/AAjKXJd21in2BNMqdIWs9CGjziDz+JRdP
        XpI2LkMnFmegYqsklpgxr2s=
X-Google-Smtp-Source: AFSGD/WCE9yLC+qPf556+bKf9N9jMpoJhTj3d/W9VPuiP6v3tNTaSB0YjaLvuT6HJ1C4LphPrGv05Q==
X-Received: by 2002:a63:1d59:: with SMTP id d25mr5696761pgm.180.1544647937635;
        Wed, 12 Dec 2018 12:52:17 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/24] iommu/tegra: gart: Ignore devices without IOMMU phandle in DT
Date:   Wed, 12 Dec 2018 23:38:46 +0300
Message-Id: <20181212203907.23461-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
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
index 1cd470b2beea..37a76388ff7e 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -345,8 +345,12 @@ static bool gart_iommu_capable(enum iommu_cap cap)
 
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
 
@@ -363,6 +367,12 @@ static void gart_iommu_remove_device(struct device *dev)
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
@@ -376,6 +386,7 @@ static const struct iommu_ops gart_iommu_ops = {
 	.unmap		= gart_iommu_unmap,
 	.iova_to_phys	= gart_iommu_iova_to_phys,
 	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
+	.of_xlate	= gart_iommu_of_xlate,
 };
 
 static int tegra_gart_suspend(struct device *dev)
@@ -441,6 +452,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
+	iommu_device_set_fwnode(&gart->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&gart->iommu);
 	if (ret) {
-- 
2.20.0


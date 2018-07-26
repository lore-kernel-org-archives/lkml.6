Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5BFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2412C20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcWfIrt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2412C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbeG0Aln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:41:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40452 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbeG0Alj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:41:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id y200-v6so2318790lfd.7;
        Thu, 26 Jul 2018 16:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YsF1u6cwuswajjItOnEio+bYuXWqZ7MdrcNXfIyrhOQ=;
        b=KcWfIrt8MSz4wOrwLUhq8FZSo+Mzi2ajd3Xn3LqPldGhbDDbosJpRynrGOuWwKEmuq
         aIb1hRoAseniLk0xVMGuqfeTqf8YFL76cr6DU7jqX6GxnJi13MWIuMiy/Yvmnn62697v
         NJEXQ2UDR/i8UiiAwd/vvf0jwmldCatGXn6/GOrDCL9uycQ7ViSX8reqONueZl1a7fZH
         wakunkkD+ORQY7rMVNcUpNrw2tDIC1hhwR+di+7513/mQ/BF/X5gx5T5CY3e3uq9zmLp
         nh8OKmWdWSEHbs33W7qYyoY5a91am7bmGFs95VhbrpDDZYr/+ydd39kW06dpwubHcs3X
         zSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YsF1u6cwuswajjItOnEio+bYuXWqZ7MdrcNXfIyrhOQ=;
        b=SqrKjPZ5dpPIJf3xYvbuBNNJmkDkqtuKacmY6mY6nhf8OCW9onIUZv6W8TdywaopsQ
         pCSEqLLQlEnW3OnCE9qJM+izXMYmj0ewUYN18vYM0tmlQHr+HNKybMc7RHgdEHvrInzG
         9cKrRNW2JVbrv8Mw5mAWbdGrwINjqWEJogRzplnNh4d9HsPnPMCp5OWvh826/psJOvvw
         ZbUQb4VUJCqyuto6eqhRRntBQIOdj2AXayfNG9gR4utr198o33nCGDL5gSKQmygkToKy
         n4MuvvjrFffLHpMdHgADPpdRfH7xauTqFjWAYJMKlDL3rpZ7HOKWTHND0Rh7xVV0k0AE
         xkJg==
X-Gm-Message-State: AOUpUlHGWpZ6dfluUgy9OxJ87tRITEf6qITAVAgzYhz230fvmxrQlZ2f
        OcvGyPIVHO37DcEt44HBl+M=
X-Google-Smtp-Source: AAOMgpe/Gc024UMbZEYD3WzKRM4xr9za3LAVRiDjLr1q7WjgxjWy/in+ICNoR8al4smefmWWOCFSzA==
X-Received: by 2002:a19:f70d:: with SMTP id z13-v6mr2490269lfe.33.1532647357016;
        Thu, 26 Jul 2018 16:22:37 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q15-v6sm411541ljg.62.2018.07.26.16.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:22:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 6/6] Revert "drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping"
Date:   Fri, 27 Jul 2018 02:16:24 +0300
Message-Id: <20180726231624.21084-7-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improper DMA backing with IOMMU has been resolved now using the new
drivers core option that allows to avoid the implicit backing, hence
detaching isn't necessary anymore.

This reverts commit b59fb482b52269977ee5de205308e5b236a03917.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 0e372a190d3f..78597da6313a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -23,10 +23,6 @@
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 #include "priv.h"
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-#include <asm/dma-iommu.h>
-#endif
-
 static int
 nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
 {
@@ -109,15 +105,6 @@ nvkm_device_tegra_probe_iommu(struct nvkm_device_tegra *tdev)
 	unsigned long pgsize_bitmap;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
-	if (dev->archdata.mapping) {
-		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-
-		arm_iommu_detach_device(dev);
-		arm_iommu_release_mapping(mapping);
-	}
-#endif
-
 	if (!tdev->func->iommu_bit)
 		return;
 
-- 
2.18.0


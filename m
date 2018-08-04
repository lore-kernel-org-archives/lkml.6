Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADDAC4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872CB21840
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvoYM3ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872CB21840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeHDQgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33909 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbeHDQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so3146811eds.1;
        Sat, 04 Aug 2018 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XFX8eCBkoh/K6Ft+7LTRupJGBHBMFyrAhkrYXfUANkY=;
        b=fvoYM3maUUevZiT6OWE/08tE60kwUPhUVodrhceT4+XFzNhh7y7m6HTsVAOJahF/Wc
         3KgFl1Vidlqao90E719TZVF70rjmaozl1XIz71CMWIL2IX0y7aegy1BwR4hrI4l5YJEt
         pC+ldAbP6YjStS/dTqaGLAqjuDp+HEThA4p22XbvnqqyWkE+DC51ElYb6enbhJYhEEB9
         nUHIogiKheHqYi0QVRxbcUktzg+b+yuKVpfgvaJChWy2/jbH/qbPQbeRM3ypZn9Vdcf2
         n9joVThO39n8IvQ8vnHbE8B2+xo7AUk+sYNg3ifyY9gceO5+Cp5l7jWm8WufZ8mEMDiA
         ELKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XFX8eCBkoh/K6Ft+7LTRupJGBHBMFyrAhkrYXfUANkY=;
        b=B7dXGpnuyJr7Ov7Pc7FH9ZRBXY7YgPN7vag+HkbBZm+zFTWck+DOgcdFQ5/4phFPaN
         QkWlu840t0pCTLoICjq8Vok7XKSdaAEvba2mQQlpC/n5BZb6kpFvSgkv8llxN4dyIV5T
         nPhazsCTVgNCeEDt6HM9jPM5k0ZYQ3tZLSDsCdx/MDNxRedyOp8IWOdjn18NNSRgf6iL
         5GvyX/mUVqrD2yn93LUPhSpuSOU/kpusHSOfhiElsCO3fwwNeUtg/EJSm861cMtl9tyU
         4iLkN7wxU9mgszorM7vxZBJY0PtUl4ljoZto+Nx+yAiMPwODWT5s1ARz+hFh11z8nsUl
         URnw==
X-Gm-Message-State: AOUpUlGE+mZ4GwmycJPLKE3s1K313LGtx+kRNsSfZh0TGztEKUu9SVx0
        3APZ2Tulho+d6NtYZRMGqdk=
X-Google-Smtp-Source: AAOMgpdkySK7K6s/Hf2Jha5jvWuq4Qcw23WM/Bv4mOhW4/+n7uYtZdaVByyI3W46dTkfI0kaLOXRKg==
X-Received: by 2002:a50:9226:: with SMTP id i35-v6mr10923436eda.27.1533393329724;
        Sat, 04 Aug 2018 07:35:29 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] iommu/tegra: gart: Provide access to Memory Controller driver
Date:   Sat,  4 Aug 2018 17:29:57 +0300
Message-Id: <20180804143003.15817-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART contain registers needed by the Memory Controller driver, provide
access to the MC driver by utilizing its GART-integration facility.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index a004f6da35f2..f8b653e25914 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -31,6 +31,8 @@
 #include <linux/iommu.h>
 #include <linux/of.h>
 
+#include <soc/tegra/mc.h>
+
 #include <asm/cacheflush.h>
 
 /* bitmap of the page sizes currently supported */
@@ -41,6 +43,8 @@
 #define GART_ENTRY_ADDR		(0x28 - GART_REG_BASE)
 #define GART_ENTRY_DATA		(0x2c - GART_REG_BASE)
 #define GART_ENTRY_PHYS_ADDR_VALID	(1 << 31)
+#define GART_ERROR_REQ		(0x30 - GART_REG_BASE)
+#define GART_ERROR_ADDR		(0x34 - GART_REG_BASE)
 
 #define GART_PAGE_SHIFT		12
 #define GART_PAGE_SIZE		(1 << GART_PAGE_SHIFT)
@@ -63,6 +67,8 @@ struct gart_device {
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
+
+	struct tegra_mc_gart_handle mc_gart_handle;
 };
 
 struct gart_domain {
@@ -408,6 +414,20 @@ static int tegra_gart_resume(struct device *dev)
 	return 0;
 }
 
+static u32 tegra_gart_error_addr(struct tegra_mc_gart_handle *handle)
+{
+	struct gart_device *gart = container_of(handle, struct gart_device,
+						mc_gart_handle);
+	return readl_relaxed(gart->regs + GART_ERROR_ADDR);
+}
+
+static u32 tegra_gart_error_req(struct tegra_mc_gart_handle *handle)
+{
+	struct gart_device *gart = container_of(handle, struct gart_device,
+						mc_gart_handle);
+	return readl_relaxed(gart->regs + GART_ERROR_REQ);
+}
+
 static int tegra_gart_probe(struct platform_device *pdev)
 {
 	struct gart_device *gart;
@@ -464,6 +484,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	gart->regs = gart_regs;
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
 	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
+	gart->mc_gart_handle.error_addr = tegra_gart_error_addr;
+	gart->mc_gart_handle.error_req = tegra_gart_error_req;
 
 	gart->savedata = vmalloc(array_size(sizeof(u32), gart->page_count));
 	if (!gart->savedata) {
@@ -475,6 +497,7 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	do_gart_setup(gart, NULL);
 
 	gart_handle = gart;
+	tegra_mc_register_gart(&gart->mc_gart_handle);
 
 	return 0;
 }
-- 
2.18.0


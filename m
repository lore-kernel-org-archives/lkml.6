Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7383AC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E91B20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 20:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3KAC+Se"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E91B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeLIUbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 15:31:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46413 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeLIUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 15:31:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so7733442ljh.13;
        Sun, 09 Dec 2018 12:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jVgWBH8Ms13CbWDpHLyPY3XEHphsp/c5H1K55U5XS8=;
        b=u3KAC+SelbzjTy+oDln03bESgCY7XrCsCM5/yZbcADNVapEMG9PnC6aWXfgBbMJw9S
         kDeTQ4vccQnod4aA79NyopFOVhldYMkztW8KpMSxmDFzY82J/szmwxogKEw3ybtAfGXu
         N4lOeo5joGKy4YyvPNv8dAajkQEhezGfFkwl+nFwIuomUss95XUp693Vthm3ASd6hT3A
         MO4uFDkiBlSVCL01Rl32yfYtur8xfCgMR6ogroG61rI2OY8y/hnyXKU9DwPOhUB9QpWN
         mNOp1hhAuHcKuvhtFUi+Ylg5O2jw6vQC1GeWBDCjgoPLnFCcAnkI7maaTw1IpTL3Pr4D
         UN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jVgWBH8Ms13CbWDpHLyPY3XEHphsp/c5H1K55U5XS8=;
        b=qNE5i+eMp56a0fM/zllRPUVzIhNx6TJMxcpokeP7RbGgZRheaaGkkWhfawrrB13X/G
         NYPOI4V9Eixp7zUxx9nXxhoBxQEPse1h3FY9pLtxEoFxm7xhzrlY4m+ayq/BH/uIhAVP
         m2yMb2bNZ6oCYXyza+lzwDEjdZoenB+V7G7qXngnSNoFPf0gX+rpLeTiEPrebYVjIL6d
         wi4m9/rkpaCrN9j0xmXXamBilyC3waLyl8C7hck/TMBGmou3wwWSzwVHge9ro2hwoZtN
         +FYWuThnzUXpVWq6cIQ1Fr7o4f4nprunUKIcfB0aRxcBz0erA+Oq3fRr2o5+ZUXVm8sk
         KqOw==
X-Gm-Message-State: AA+aEWYPC++BJ5IseXzIibRTIXH0q3TufHHweiXp7BoVXYHU4KeGK41B
        sIioXSMaiSKUqD/34rmk1MM=
X-Google-Smtp-Source: AFSGD/VooiZq8Ta30M6UZCjRkzN+O1bq+HzZ4M3+yTu6bkH2rPPryNSeUWY5G1jImLedOlwQvVC2lA==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr5388710lje.117.1544387472565;
        Sun, 09 Dec 2018 12:31:12 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-165-221.pppoe.mtu-net.ru. [91.79.165.221])
        by smtp.gmail.com with ESMTPSA id c20sm1708346lfj.67.2018.12.09.12.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 12:31:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/21] iommu/tegra: gart: Integrate with Memory Controller driver
Date:   Sun,  9 Dec 2018 23:29:42 +0300
Message-Id: <20181209202950.31486-14-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181209202950.31486-1-digetx@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device-tree binding has been changed. There is no separate GART device
anymore, it is squashed into the Memory Controller. Integrate GART module
with the MC in a way it is done for the SMMU of Tegra30+.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/Kconfig      |  1 +
 drivers/iommu/tegra-gart.c | 77 ++++++++++++--------------------------
 drivers/memory/tegra/mc.c  | 41 ++++++++++++++++++++
 include/soc/tegra/mc.h     | 27 +++++++++++++
 4 files changed, 93 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9a25715650e..83c099bb7288 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -282,6 +282,7 @@ config ROCKCHIP_IOMMU
 config TEGRA_IOMMU_GART
 	bool "Tegra GART IOMMU Support"
 	depends on ARCH_TEGRA_2x_SOC
+	depends on TEGRA_MC
 	select IOMMU_API
 	help
 	  Enables support for remapping discontiguous physical memory
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 835fea461c59..0a72b6afa842 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -19,16 +19,17 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/moduleparam.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 
+#include <soc/tegra/mc.h>
+
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
@@ -397,9 +398,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iotlb_sync	= gart_iommu_sync,
 };
 
-static int tegra_gart_suspend(struct device *dev)
+int tegra_gart_suspend(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long iova;
 	u32 *data = gart->savedata;
 	unsigned long flags;
@@ -411,9 +411,8 @@ static int tegra_gart_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_gart_resume(struct device *dev)
+int tegra_gart_resume(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
@@ -422,41 +421,39 @@ static int tegra_gart_resume(struct device *dev)
 	return 0;
 }
 
-static int tegra_gart_probe(struct platform_device *pdev)
+struct gart_device *tegra_gart_probe(struct device *dev,
+				     const struct tegra_smmu_soc *soc,
+				     struct tegra_mc *mc)
 {
 	struct gart_device *gart;
-	struct resource *res, *res_remap;
+	struct resource *res_remap;
 	void __iomem *gart_regs;
-	struct device *dev = &pdev->dev;
 	int ret;
 
 	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
 
+	/* Tegra30+ has an SMMU and no GART */
+	if (soc)
+		return NULL;
+
 	/* the GART memory aperture is required */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	res_remap = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res || !res_remap) {
+	res_remap = platform_get_resource(to_platform_device(dev),
+					  IORESOURCE_MEM, 1);
+	if (!res_remap) {
 		dev_err(dev, "GART memory aperture expected\n");
-		return -ENXIO;
+		return ERR_PTR(-ENXIO);
 	}
 
 	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
 	if (!gart) {
 		dev_err(dev, "failed to allocate gart_device\n");
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 
-	gart_regs = devm_ioremap(dev, res->start, resource_size(res));
-	if (!gart_regs) {
-		dev_err(dev, "failed to remap GART registers\n");
-		return -ENXIO;
-	}
-
-	ret = iommu_device_sysfs_add(&gart->iommu, &pdev->dev, NULL,
-				     dev_name(&pdev->dev));
+	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
 	if (ret) {
 		dev_err(dev, "Failed to register IOMMU in sysfs\n");
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
@@ -468,7 +465,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		goto remove_sysfs;
 	}
 
-	gart->dev = &pdev->dev;
+	gart->dev = dev;
+	gart_regs = mc->regs + GART_REG_BASE;
 	spin_lock_init(&gart->pte_lock);
 	spin_lock_init(&gart->client_lock);
 	INIT_LIST_HEAD(&gart->client);
@@ -483,46 +481,19 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		goto unregister_iommu;
 	}
 
-	platform_set_drvdata(pdev, gart);
 	do_gart_setup(gart, NULL);
 
 	gart_handle = gart;
 
-	return 0;
+	return gart;
 
 unregister_iommu:
 	iommu_device_unregister(&gart->iommu);
 remove_sysfs:
 	iommu_device_sysfs_remove(&gart->iommu);
 
-	return ret;
-}
-
-static const struct dev_pm_ops tegra_gart_pm_ops = {
-	.suspend	= tegra_gart_suspend,
-	.resume		= tegra_gart_resume,
-};
-
-static const struct of_device_id tegra_gart_of_match[] = {
-	{ .compatible = "nvidia,tegra20-gart", },
-	{ },
-};
-
-static struct platform_driver tegra_gart_driver = {
-	.probe		= tegra_gart_probe,
-	.driver = {
-		.name	= "tegra-gart",
-		.pm	= &tegra_gart_pm_ops,
-		.of_match_table = tegra_gart_of_match,
-		.suppress_bind_attrs = true,
-	},
-};
-
-static int __init tegra_gart_init(void)
-{
-	return platform_driver_register(&tegra_gart_driver);
+	return ERR_PTR(ret);
 }
-subsys_initcall(tegra_gart_init);
 
 module_param(gart_debug, bool, 0644);
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 55ecfb2d8cfd..4cae1c3a853b 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -702,13 +702,54 @@ static int tegra_mc_probe(struct platform_device *pdev)
 				PTR_ERR(mc->smmu));
 	}
 
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART)) {
+		mc->gart = tegra_gart_probe(&pdev->dev, mc->soc->smmu, mc);
+		if (IS_ERR(mc->gart))
+			dev_err(&pdev->dev, "failed to probe GART: %ld\n",
+				PTR_ERR(mc->gart));
+	}
+
+	return 0;
+}
+
+static int tegra_mc_suspend(struct device *dev)
+{
+	struct tegra_mc *mc = dev_get_drvdata(dev);
+	int err;
+
+	if (mc->gart) {
+		err = tegra_gart_suspend(mc->gart);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
+static int tegra_mc_resume(struct device *dev)
+{
+	struct tegra_mc *mc = dev_get_drvdata(dev);
+	int err;
+
+	if (mc->gart) {
+		err = tegra_gart_resume(mc->gart);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra_mc_pm_ops = {
+	.suspend = tegra_mc_suspend,
+	.resume = tegra_mc_resume,
+};
+
 static struct platform_driver tegra_mc_driver = {
 	.driver = {
 		.name = "tegra-mc",
 		.of_match_table = tegra_mc_of_match,
+		.pm = &tegra_mc_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 	.prevent_deferred_probe = true,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index db5bfdf589b4..5da42e3fb801 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -77,6 +77,7 @@ struct tegra_smmu_soc {
 
 struct tegra_mc;
 struct tegra_smmu;
+struct gart_device;
 
 #ifdef CONFIG_TEGRA_IOMMU_SMMU
 struct tegra_smmu *tegra_smmu_probe(struct device *dev,
@@ -96,6 +97,31 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
 }
 #endif
 
+#ifdef CONFIG_TEGRA_IOMMU_GART
+struct gart_device *tegra_gart_probe(struct device *dev,
+				     const struct tegra_smmu_soc *soc,
+				     struct tegra_mc *mc);
+int tegra_gart_suspend(struct gart_device *gart);
+int tegra_gart_resume(struct gart_device *gart);
+#else
+static inline struct gart_device *
+tegra_gart_probe(struct device *dev, const struct tegra_smmu_soc *soc,
+		 struct tegra_mc *mc)
+{
+	return NULL;
+}
+
+static inline int tegra_gart_suspend(struct gart_device *gart)
+{
+	return -ENODEV;
+}
+
+static inline int tegra_gart_resume(struct gart_device *gart)
+{
+	return -ENODEV;
+}
+#endif
+
 struct tegra_mc_reset {
 	const char *name;
 	unsigned long id;
@@ -144,6 +170,7 @@ struct tegra_mc_soc {
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
+	struct gart_device *gart;
 	void __iomem *regs;
 	struct clk *clk;
 	int irq;
-- 
2.19.1


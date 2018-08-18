Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D13BC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B689C21788
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx0b5TZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B689C21788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeHRTEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 15:04:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44739 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbeHRTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 15:04:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id f23-v6so6101086edr.11;
        Sat, 18 Aug 2018 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EMO2e8efjOhNrR8bHMZwE0pFpZ/qVf74q0uveIYFmpE=;
        b=Vx0b5TZf20xMPnQHs7ko68+yEwTSj1RG4Ozywl8i4YKF2KnFWXIqkekHX+KwNC6BlL
         wugwIeSmke77d3O8G+XzOSAWAB/sf9+gqVZjnJeGWeZ8ehO1WfccOmDnhbWvSiWSn8gz
         QUL8OLh5eiHKI1VmtzuwQthsp4+kvDxKrEHbDziZvx4d8ZS98SwxQphgbrF2+EZN5o8V
         67/7AC5q+opIBJo6/AAlT5HxS02JZgbVFlZJRW18qxEje3MT7D40B+Xw25QjncYODrcM
         WBsHX6F3fD8kW/ubph/VUDRr4Z/K5XbWRnPMKgDTEYSy/i0qSl+OCS3KelOBC8C4FS/P
         Mi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EMO2e8efjOhNrR8bHMZwE0pFpZ/qVf74q0uveIYFmpE=;
        b=t/x/4obauHZEwxQ9z++aKqHHwixCyRIZv+ffM1X8Hot3kTdC+f1SEL00yMugLaIcld
         py7k1vcgl8Pc2RzB83Tbn5q6SYc3Xm2Oyk0+ToNv5JnnV4NJV+6iaz+bDkkMbpJnPEHS
         stMqwgEdnL8C41dZyhabmdDuJ1v4a+hZuZN8JrNq3BPaUIukLb4CnR8B31HauWPlv+Ep
         fQKjk5ZnIe2BuVIh0cg1iO5eL35MsZNWpf7IOfsTuCiE91k8+pxtgu3xQaKURavBKxzv
         //fWcxMZ21EaPZr5p/l2gOa5C8eF3F6jsA11QMZ2G9QZbe0uMuTkcqRl0L9egvLR/2Vo
         +4cg==
X-Gm-Message-State: AOUpUlFHPdAnK/n++f5KKtIrJIHeiO6GRVeIh51mL+sY9DdO8Diqv3Ez
        AVp89E3MX3vyO2CW/ByyMWE=
X-Google-Smtp-Source: AA+uWPxATraazfMw2vPy16f6zzWTRf7x5g5CA4EreYLwe49liyc/i83KK7fz3u3fnqOFxeyHJis7fQ==
X-Received: by 2002:a50:e249:: with SMTP id o9-v6mr47045146edl.253.1534607750418;
        Sat, 18 Aug 2018 08:55:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id v8-v6sm2784014edr.48.2018.08.18.08.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 08:55:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/19] iommu/tegra: gart: Integrate with Memory Controller driver
Date:   Sat, 18 Aug 2018 18:54:22 +0300
Message-Id: <20180818155430.5586-12-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180818155430.5586-1-digetx@gmail.com>
References: <20180818155430.5586-1-digetx@gmail.com>
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
 drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
 drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
 include/soc/tegra/mc.h     | 27 +++++++++++
 4 files changed, 93 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c60395b7470f..33f97e5f07ca 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -269,6 +269,7 @@ config ROCKCHIP_IOMMU
 config TEGRA_IOMMU_GART
 	bool "Tegra GART IOMMU Support"
 	depends on ARCH_TEGRA_2x_SOC
+	depends on TEGRA_MC
 	select IOMMU_API
 	help
 	  Enables support for remapping discontiguous physical memory
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 86a855c0d031..1c89b20ba4bb 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -21,11 +21,13 @@
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 
+#include <soc/tegra/mc.h>
+
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
@@ -394,9 +396,8 @@ static const struct iommu_ops gart_iommu_ops = {
 	.iotlb_sync	= gart_iommu_sync,
 };
 
-static int tegra_gart_suspend(struct device *dev)
+int tegra_gart_suspend(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long iova;
 	u32 *data = gart->savedata;
 	unsigned long flags;
@@ -408,9 +409,8 @@ static int tegra_gart_suspend(struct device *dev)
 	return 0;
 }
 
-static int tegra_gart_resume(struct device *dev)
+int tegra_gart_resume(struct gart_device *gart)
 {
-	struct gart_device *gart = dev_get_drvdata(dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&gart->pte_lock, flags);
@@ -419,41 +419,39 @@ static int tegra_gart_resume(struct device *dev)
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
@@ -465,7 +463,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 		goto remove_sysfs;
 	}
 
-	gart->dev = &pdev->dev;
+	gart->dev = dev;
+	gart_regs = mc->regs + GART_REG_BASE;
 	spin_lock_init(&gart->pte_lock);
 	spin_lock_init(&gart->client_lock);
 	INIT_LIST_HEAD(&gart->client);
@@ -480,72 +479,23 @@ static int tegra_gart_probe(struct platform_device *pdev)
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
-static int tegra_gart_remove(struct platform_device *pdev)
-{
-	struct gart_device *gart = platform_get_drvdata(pdev);
-
-	iommu_device_unregister(&gart->iommu);
-	iommu_device_sysfs_remove(&gart->iommu);
-
-	writel(0, gart->regs + GART_CONFIG);
-	if (gart->savedata)
-		vfree(gart->savedata);
-	gart_handle = NULL;
-	return 0;
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
-MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
-
-static struct platform_driver tegra_gart_driver = {
-	.probe		= tegra_gart_probe,
-	.remove		= tegra_gart_remove,
-	.driver = {
-		.name	= "tegra-gart",
-		.pm	= &tegra_gart_pm_ops,
-		.of_match_table = tegra_gart_of_match,
-	},
-};
-
-static int tegra_gart_init(void)
-{
-	return platform_driver_register(&tegra_gart_driver);
-}
-
-static void __exit tegra_gart_exit(void)
-{
-	platform_driver_unregister(&tegra_gart_driver);
+	return ERR_PTR(ret);
 }
 
-subsys_initcall(tegra_gart_init);
-module_exit(tegra_gart_exit);
 module_param(gart_debug, bool, 0644);
 
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
 MODULE_DESCRIPTION("IOMMU API for GART in Tegra20");
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
-MODULE_ALIAS("platform:tegra-gart");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index ab383d7a7842..f2ace46d951d 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -706,13 +706,54 @@ static int tegra_mc_probe(struct platform_device *pdev)
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
2.18.0


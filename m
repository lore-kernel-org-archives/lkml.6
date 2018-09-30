Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C454EC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F312089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 22:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBnE6tKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F312089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeJAFX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:23:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43561 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJAFX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:23:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id p34-v6so1134829lfg.10;
        Sun, 30 Sep 2018 15:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nz6Kx+wMnoWWX/lU/E6wunO8pnGhbvs+K7XhMJCQyrU=;
        b=XBnE6tKhTD9q0dEIltlsuFdN63NHSLOXAJyCMKuHJQ4KRtINkZVjRCUepVPPwBXpnR
         pYd3joGJ6UsE4TuDwGzmCiJla4JFRXlXIIhW4y3eHwPIZuNoRjRaWwqX4KjeRmPkGzYU
         UqPfAbOEC8Awl59krDKlWvFP7dAQkEB8TYX7XWEoMStbSACZC9KmYTsn8V2UReuJl5f4
         18Mj1YmsxlOrWiquC55L8hBz/ENqCaF5FGl6UIkY7Oip/Sj7OVwP+zDsFh1RHZyfoEX+
         WY4MbVgWVPn+4y2OxCONcjGpFnp6/QJGrhcD9x8k396XuOycyrWNzi3ZaET93J25w5fs
         HkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nz6Kx+wMnoWWX/lU/E6wunO8pnGhbvs+K7XhMJCQyrU=;
        b=O+M/GCYAMxxUE1lIk8tOT+nkKOKcLZTskGT+GH1QQa0D+bfNzAiCQMDh/T6ZMGiqBj
         4rZ2SlCt9ew10lPaJnh4FF1R0qaatnkinl1mmYGu0wLalGnj9+yf7zOZP9fPOO5eByIT
         +FTI9ZLljCIeJSPkh5hoSfF6ryzizMFyFYigNL+rLRc3Ugx/Njf2KzSOB/IlfwtvY5bV
         E/717qaHl7xLxaaOQRyVtwRzFmZp4iprL4FQTtH6KBHAGUKTArd/AQ3qr/OSqyCy48fn
         dgV6RKSrH76gK3UrO2h2nNrFoLytIbt9r3Y91ALCdPleSs2/jTAedog/VehgHjhAQvBU
         SfCA==
X-Gm-Message-State: ABuFfohiaDh+l7bb72/0PUlHrKSOHvdds6N9ZH7ShqZsvleEzX8mIDe0
        8nn8KW6T94MkmxMJVV8epnE=
X-Google-Smtp-Source: ACcGV63OtDlES9TxrYN7elq8ZdsGNydFz6JWoRIAvG+R9PgjIwcBcroby2Izwf26CVDpejP5A7i+6g==
X-Received: by 2002:a19:6381:: with SMTP id v1-v6mr3846976lfi.136.1538347746524;
        Sun, 30 Sep 2018 15:49:06 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2356829lji.88.2018.09.30.15.49.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 15:49:06 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/21] iommu/tegra: gart: Integrate with Memory Controller driver
Date:   Mon,  1 Oct 2018 01:48:25 +0300
Message-Id: <20180930224833.28809-14-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
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
 drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
 drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
 include/soc/tegra/mc.h     | 27 +++++++++++
 4 files changed, 93 insertions(+), 74 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 51ba19c8847b..4b24a4b74168 100644
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
index bb45cbd3d5de..cee24ff8f59e 100644
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
2.19.0


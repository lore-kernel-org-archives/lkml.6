Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93166C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343EA20673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343EA20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeHVPiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:38:09 -0400
Received: from mx.socionext.com ([202.248.49.38]:50748 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728634AbeHVPiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:38:08 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 22 Aug 2018 21:13:25 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8AE7518020D;
        Wed, 22 Aug 2018 21:13:25 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Aug 2018 21:13:25 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 2EB8C1A0E11;
        Wed, 22 Aug 2018 21:13:25 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 1/3] ata: add an extra argument to ahci_platform_get_resources()
Date:   Wed, 22 Aug 2018 21:13:01 +0900
Message-Id: <1534939983-16264-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1534939983-16264-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extra argument to ahci_platform_get_resources(), that is
for the bitmap representing the resource to get in this function.

Currently there is no resources to be defined, so all the callers set
'0' to the argument.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/ata/ahci_brcm.c        | 2 +-
 drivers/ata/ahci_ceva.c        | 2 +-
 drivers/ata/ahci_da850.c       | 2 +-
 drivers/ata/ahci_dm816.c       | 2 +-
 drivers/ata/ahci_imx.c         | 2 +-
 drivers/ata/ahci_mtk.c         | 2 +-
 drivers/ata/ahci_mvebu.c       | 2 +-
 drivers/ata/ahci_platform.c    | 2 +-
 drivers/ata/ahci_qoriq.c       | 2 +-
 drivers/ata/ahci_seattle.c     | 2 +-
 drivers/ata/ahci_st.c          | 2 +-
 drivers/ata/ahci_sunxi.c       | 2 +-
 drivers/ata/ahci_tegra.c       | 2 +-
 drivers/ata/ahci_xgene.c       | 2 +-
 drivers/ata/libahci_platform.c | 4 +++-
 include/linux/ahci_platform.h  | 2 +-
 16 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index ea43081..f3d5577 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -425,7 +425,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 
 	brcm_sata_phys_enable(priv);
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 	hpriv->plat_data = priv;
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 5ecc9d4..dc78c98 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -213,7 +213,7 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 	cevapriv->ahci_pdev = pdev;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 9b34dff..ebaa657 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -171,7 +171,7 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	u32 mpy;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
index fbd827c..89509c3 100644
--- a/drivers/ata/ahci_dm816.c
+++ b/drivers/ata/ahci_dm816.c
@@ -148,7 +148,7 @@ static int ahci_dm816_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 6822e2f..b00799d 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1127,7 +1127,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index 0ae6971..8bc1a26 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -142,7 +142,7 @@ static int mtk_ahci_probe(struct platform_device *pdev)
 	if (!plat)
 		return -ENOMEM;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 72d90b4..f9cb51b 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -158,7 +158,7 @@ static int ahci_mvebu_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 99f9a89..5709273 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -43,7 +43,7 @@ static int ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index cfdef4d..ce59253 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -250,7 +250,7 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 	struct resource *res;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 1d31c0c..e57b6f9 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -164,7 +164,7 @@ static int ahci_seattle_probe(struct platform_device *pdev)
 	int rc;
 	struct ahci_host_priv *hpriv;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index bc345f2..21c5c44 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -156,7 +156,7 @@ static int st_ahci_probe(struct platform_device *pdev)
 	if (!drv_data)
 		return -ENOMEM;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 	hpriv->plat_data = drv_data;
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index b264374..631610b 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -181,7 +181,7 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 64d8484..004f260 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -494,7 +494,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	int ret;
 	unsigned int i;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index ad58da7..7e157e1 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -759,7 +759,7 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 					      &xgene_ahci_v2_port_info };
 	int rc;
 
-	hpriv = ahci_platform_get_resources(pdev);
+	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 30cc8f1..6abc1cd 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -332,6 +332,7 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
 /**
  * ahci_platform_get_resources - Get platform resources
  * @pdev: platform device to get resources for
+ * @flags: bitmap representing the resource to get
  *
  * This function allocates an ahci_host_priv struct, and gets the following
  * resources, storing a reference to them inside the returned struct:
@@ -345,7 +346,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
  * RETURNS:
  * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
  */
-struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
+struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
+						   unsigned int flags)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 1b0a17b..6490be1 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -30,7 +30,7 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
 struct ahci_host_priv *ahci_platform_get_resources(
-	struct platform_device *pdev);
+	struct platform_device *pdev, unsigned int flags);
 int ahci_platform_init_host(struct platform_device *pdev,
 			    struct ahci_host_priv *hpriv,
 			    const struct ata_port_info *pi_template,
-- 
2.7.4


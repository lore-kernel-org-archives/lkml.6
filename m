Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53709C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CD9217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XquUNXvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CD9217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeHEJ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:56:59 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45826 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeHEJ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:56:59 -0400
Received: by mail-qt0-f194.google.com with SMTP id y5-v6so10566293qti.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jCDfoXZLwDfPSOmSRTVs/H7CVQWUKVaXXsHa9Bn+BEI=;
        b=XquUNXvOiZGxra+C+Irig5k7JHfFgz9e7nYHfQsAi1744kfIqtu7f3JjEnUZuo8j5m
         aduvQLvraETh2PushJsRE4WytzWnLT/s9EiSoc8MRKWR8xdF8itjiCajx/jYxymF3AZ0
         MJeFFUklCb8lFd4qEsMTZJItAaxQmtvok44fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jCDfoXZLwDfPSOmSRTVs/H7CVQWUKVaXXsHa9Bn+BEI=;
        b=Lvfhtabm/FCJs4uh9/3gqUWZlNZ9E1dKK970lX2SNLAFpzb6ZTMEwVIQSjGe/vlmU3
         Ek31Ot2FqgqsPS4wCw7z4diEV6Gy/74NDUBVmXJXL7XRHJ3Zt1Ka5Ij3igxKRAnQV2/N
         cnFS05E8jERGJN92SqXHFMLtaWc+FpAYPXmrwHwIOqEI05Fvaekrkcwdua/4jBXvufE8
         o1pxEm2PkZnHyZhftqri6Z6WvTr8rZtie3Om3Dg4fi8Z7T80BlgV44v5RW0xCmYNL1Vz
         hsHmXWk4COFqvtcOMHR318EWfdcjjAe1jPBEsQg+DI1GPnvrC8wnlnzN00ouzLfDVdPR
         jRaA==
X-Gm-Message-State: AOUpUlH764YxBCq2sFbavgvkWLDouCT0lapCsTvmj/AKMifU/7EiCe63
        FUjIJafA4GqmcLD5d/HEUjWFnA==
X-Google-Smtp-Source: AAOMgpfjF8o+hrARIsEkewp664h/gB4WIC2BrBezQG12TQvHZ1mSOsUChLXoK+G3acvTleTBSsnHDg==
X-Received: by 2002:ac8:218d:: with SMTP id 13-v6mr10193542qty.122.1533455598115;
        Sun, 05 Aug 2018 00:53:18 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q18-v6sm6363905qtg.82.2018.08.05.00.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Aug 2018 00:53:17 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        vikram.prakash@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] mmc: sdhci-pltfm: Convert DT properties to generic device properties
Date:   Sun,  5 Aug 2018 13:22:51 +0530
Message-Id: <1533455572-22012-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
References: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Convert DT properties to generic device properties
so that drivers can get properties from DT or ACPI.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
 drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 02bea61..b231c9a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -30,6 +30,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/of.h>
 #ifdef CONFIG_PPC
 #include <asm/machdep.h>
@@ -51,11 +52,10 @@ static const struct sdhci_ops sdhci_pltfm_ops = {
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-#ifdef CONFIG_OF
-static bool sdhci_of_wp_inverted(struct device_node *np)
+static bool sdhci_wp_inverted(struct device *dev)
 {
-	if (of_get_property(np, "sdhci,wp-inverted", NULL) ||
-	    of_get_property(np, "wp-inverted", NULL))
+	if (device_property_present(dev, "sdhci,wp-inverted") ||
+	    device_property_present(dev, "wp-inverted"))
 		return true;
 
 	/* Old device trees don't have the wp-inverted property. */
@@ -66,52 +66,64 @@ static bool sdhci_of_wp_inverted(struct device_node *np)
 #endif /* CONFIG_PPC */
 }
 
-void sdhci_get_of_property(struct platform_device *pdev)
+#ifdef CONFIG_OF
+static void sdhci_get_compatibility(struct platform_device *pdev)
 {
+	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+
+	if (!np)
+		return;
+
+	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
+	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
+	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+}
+#else
+void sdhci_get_compatibility(struct platform_device *pdev) {}
+#endif /* CONFIG_OF */
+
+void sdhci_get_property(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	u32 bus_width;
 
-	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+	if (device_property_present(dev, "sdhci,auto-cmd12"))
 		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
-	if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
-	    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
+	if (device_property_present(dev, "sdhci,1-bit-only") ||
+	    (device_property_read_u32(dev, "bus-width", &bus_width) == 0 &&
 	    bus_width == 1))
 		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
-	if (sdhci_of_wp_inverted(np))
+	if (sdhci_wp_inverted(dev))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
-	if (of_get_property(np, "broken-cd", NULL))
+	if (device_property_present(dev, "broken-cd"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
-	if (of_get_property(np, "no-1-8-v", NULL))
+	if (device_property_present(dev, "no-1-8-v"))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
-	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
-
-	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
-	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
-	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
-		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	sdhci_get_compatibility(pdev);
 
-	of_property_read_u32(np, "clock-frequency", &pltfm_host->clock);
+	device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
 
-	if (of_find_property(np, "keep-power-in-suspend", NULL))
+	if (device_property_present(dev, "keep-power-in-suspend"))
 		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
 
-	if (of_property_read_bool(np, "wakeup-source") ||
-	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
+	if (device_property_read_bool(dev, "wakeup-source") ||
+	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
-#else
-void sdhci_get_of_property(struct platform_device *pdev) {}
-#endif /* CONFIG_OF */
-EXPORT_SYMBOL_GPL(sdhci_get_of_property);
+EXPORT_SYMBOL_GPL(sdhci_get_property);
 
 struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 				    const struct sdhci_pltfm_data *pdata,
@@ -184,7 +196,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	sdhci_get_of_property(pdev);
+	sdhci_get_property(pdev);
 
 	ret = sdhci_add_host(host);
 	if (ret)
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 1e91fb1..6109987 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -90,7 +90,12 @@ static inline void sdhci_be32bs_writeb(struct sdhci_host *host, u8 val, int reg)
 }
 #endif /* CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER */
 
-extern void sdhci_get_of_property(struct platform_device *pdev);
+void sdhci_get_property(struct platform_device *pdev);
+
+static inline void sdhci_get_of_property(struct platform_device *pdev)
+{
+	return sdhci_get_property(pdev);
+}
 
 extern struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 					  const struct sdhci_pltfm_data *pdata,
-- 
2.7.4


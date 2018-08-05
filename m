Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F332CC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4787217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 07:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ebb7/z8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4787217C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeHEJ5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 05:57:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43185 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHEJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 05:57:04 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so10581051qtp.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Od4Ktv+DFv+gTHIM86UVVozZYJ3S/xsfPyxKwWbFz+I=;
        b=Ebb7/z8OQ1QtmGNbuyEMu2oMeUmvvfzzzmh70nyno3aYEvZBoO8DKD4EzjE3sBwtix
         nwzS6iQmWEhO2Wj9KNeWjkhm2Yb7Ak7x0eaKWFCAj7N5baC8Zex9l4JOKiLgWoP6JDAn
         j4wS6IDQ8bjh00H/NyGaee1i+y7/tNG/r5eLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Od4Ktv+DFv+gTHIM86UVVozZYJ3S/xsfPyxKwWbFz+I=;
        b=haZq2NkpnJEQEcHpoXibda0gIBFhcMrzoxqEEqnp7w7ly0WqtbD5DTale7RX8OkzGG
         N1XDMZ9PYTOQlW38hWtw8gptf5y3ld6MqpEfDGv6fUkis3sRxXD0BPcJ9SXhD78rr9t9
         O3PprIaWg05WChTHs5lzWQeMJ5fUjbiUPK3SCuoKQeXqnSYloW12QQTu/Ktw7Sia6TcG
         b54FKpRY12Qcyc1N8+mYjLql3zTaPX/zvt2hpUsK/ItMibn77/G01TRZei66YXxX5EFw
         dAHSakgqTyAuPq5mSL4nikH9rqIehpeg92HOJt/cAOKtnnnnB0qfE1XI+00Y1EsF3zrh
         TWLQ==
X-Gm-Message-State: AOUpUlFN7kjkjOR2qy2isnohJJSnLPXer3rzemB0uc2FwE9a00YP6MOv
        7bypW/LEIMHpWn3Kwk7Oafx6/g==
X-Google-Smtp-Source: AAOMgpcY5MS/6CwA/tZvo2BCfqdB5O3jgb7l0jtoxw+G0zort3OJQffd/xMhocz/u2k52iGzRa0M+w==
X-Received: by 2002:ac8:8d3:: with SMTP id y19-v6mr10531112qth.112.1533455603709;
        Sun, 05 Aug 2018 00:53:23 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q18-v6sm6363905qtg.82.2018.08.05.00.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Aug 2018 00:53:23 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        vikram.prakash@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 2/2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
Date:   Sun,  5 Aug 2018 13:22:52 +0530
Message-Id: <1533455572-22012-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
References: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support to all IPROC SDHCI varients

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
---
 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci-iproc.c | 59 ++++++++++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0581c19..bc6702e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -334,6 +334,7 @@ config MMC_SDHCI_IPROC
 	tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
 	depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
+	depends on OF || ACPI
 	default ARCH_BCM_IPROC
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index d0e83db..0db9905 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -15,6 +15,7 @@
  * iProc SDHCI platform driver
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
@@ -162,9 +163,19 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
 	sdhci_iproc_writel(host, newval, reg & ~3);
 }
 
+static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	if (pltfm_host->clk)
+		return sdhci_pltfm_clk_get_max_clock(host);
+	else
+		return pltfm_host->clock;
+}
+
 static const struct sdhci_ops sdhci_iproc_ops = {
 	.set_clock = sdhci_set_clock,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = sdhci_iproc_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -178,7 +189,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 	.write_w = sdhci_iproc_writew,
 	.write_b = sdhci_iproc_writeb,
 	.set_clock = sdhci_set_clock,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = sdhci_iproc_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -256,19 +267,25 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
 
+static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
+	{ .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
+	{ .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
+
 static int sdhci_iproc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
-	const struct sdhci_iproc_data *iproc_data;
+	struct device *dev = &pdev->dev;
+	const struct sdhci_iproc_data *iproc_data = NULL;
 	struct sdhci_host *host;
 	struct sdhci_iproc_host *iproc_host;
 	struct sdhci_pltfm_host *pltfm_host;
 	int ret;
 
-	match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
-	if (!match)
-		return -EINVAL;
-	iproc_data = match->data;
+	iproc_data = device_get_match_data(dev);
+	if (!iproc_data)
+		return -ENODEV;
 
 	host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
 	if (IS_ERR(host))
@@ -280,19 +297,21 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	iproc_host->data = iproc_data;
 
 	mmc_of_parse(host->mmc);
-	sdhci_get_of_property(pdev);
+	sdhci_get_property(pdev);
 
 	host->mmc->caps |= iproc_host->data->mmc_caps;
 
-	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pltfm_host->clk)) {
-		ret = PTR_ERR(pltfm_host->clk);
-		goto err;
-	}
-	ret = clk_prepare_enable(pltfm_host->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable host clk\n");
-		goto err;
+	if (dev->of_node) {
+		pltfm_host->clk = devm_clk_get(dev, NULL);
+		if (IS_ERR(pltfm_host->clk)) {
+			ret = PTR_ERR(pltfm_host->clk);
+			goto err;
+		}
+		ret = clk_prepare_enable(pltfm_host->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable host clk\n");
+			goto err;
+		}
 	}
 
 	if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
@@ -307,7 +326,8 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk:
-	clk_disable_unprepare(pltfm_host->clk);
+	if (dev->of_node)
+		clk_disable_unprepare(pltfm_host->clk);
 err:
 	sdhci_pltfm_free(pdev);
 	return ret;
@@ -317,6 +337,7 @@ static struct platform_driver sdhci_iproc_driver = {
 	.driver = {
 		.name = "sdhci-iproc",
 		.of_match_table = sdhci_iproc_of_match,
+		.acpi_match_table = ACPI_PTR(sdhci_iproc_acpi_ids),
 		.pm = &sdhci_pltfm_pmops,
 	},
 	.probe = sdhci_iproc_probe,
-- 
2.7.4


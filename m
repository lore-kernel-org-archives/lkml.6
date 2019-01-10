Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691C6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8342064C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="auDn7acO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbfAJWqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:46:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5880 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAJWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:46:09 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c37cb220000>; Thu, 10 Jan 2019 14:45:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 14:46:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Jan 2019 14:46:07 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 22:46:07 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 22:46:06 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 22:46:07 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c37cb2e0002>; Thu, 10 Jan 2019 14:46:06 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 3/3] mmc: tegra: SDMMC pads auto-calibration
Date:   Thu, 10 Jan 2019 14:46:03 -0800
Message-ID: <1547160363-25323-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
References: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547160354; bh=l8ylXVApvfz/NljI+JgYgZ2AZJxio88pEbpvgslJdck=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=auDn7acOsvSPU1s4cgDY5lPrucj6AllgmRyBhF+lq+F1ZBar/aow6d1tGGZgFMiyf
         2UJHyOCw8edbcJhzNWdEe6bDF1/ioPJb/6LS+rpPeioRncPvQL83JnVil+5emNIcjj
         Hhih2wjmWo9sqINRsz/h87Pnf+yUyxFkItThEndQzrkjQYc06cBgT8fA4xYRmov66o
         J1EG4ZA2h75Swq1AjG/bTa9c+/8giW1zIPRqHzbku88uoFwzO3YClaKrzVHN/Hji/U
         K/z/1s6BMZT7O9A+seKJREn2+uXkkI5TJN8FR8dUjNMf3oxc+VcsppxE+9UMK4QHPE
         lQjq3Dvmz/S/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Program initial drive code offsets which will be used by auto
calibration process.

Program fixed drive strengths for SDMMC pads in pad control
register when auto cal timeouts.
Fixed settings are based on Pre-SI analysis of the pad design.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 160 ++++++++++++++++++++++++++++++-----------
 1 file changed, 119 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e6ace31e2a41..7d681a8fa4ba 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -75,6 +75,7 @@
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
+#define SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK		0x07FFF000
 
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
@@ -121,6 +122,8 @@ struct sdhci_tegra {
 	struct pinctrl *pinctrl_sdmmc;
 	struct pinctrl_state *pinctrl_state_3v3;
 	struct pinctrl_state *pinctrl_state_1v8;
+	struct pinctrl_state *pinctrl_state_3v3_drv;
+	struct pinctrl_state *pinctrl_state_1v8_drv;
 
 	struct sdhci_tegra_autocal_offsets autocal_offsets;
 	ktime_t last_calib;
@@ -411,6 +414,76 @@ static void tegra_sdhci_set_pad_autocal_offset(struct sdhci_host *host,
 	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 }
 
+static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage,
+				   bool state_drvupdn)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_tegra_autocal_offsets *offsets =
+						&tegra_host->autocal_offsets;
+	struct pinctrl_state *pinctrl_drvupdn = NULL;
+	int ret = 0;
+	u8 drvup = 0, drvdn = 0;
+	u32 reg;
+
+	if (!state_drvupdn) {
+		/* PADS Drive Strength */
+		if (voltage == MMC_SIGNAL_VOLTAGE_180) {
+			if (tegra_host->pinctrl_state_1v8_drv) {
+				pinctrl_drvupdn =
+					tegra_host->pinctrl_state_1v8_drv;
+			} else {
+				drvup = offsets->pull_up_1v8_timeout;
+				drvdn = offsets->pull_down_1v8_timeout;
+			}
+		} else {
+			if (tegra_host->pinctrl_state_3v3_drv) {
+				pinctrl_drvupdn =
+					tegra_host->pinctrl_state_3v3_drv;
+			} else {
+				drvup = offsets->pull_up_3v3_timeout;
+				drvdn = offsets->pull_down_3v3_timeout;
+			}
+		}
+
+		if (pinctrl_drvupdn != NULL) {
+			ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+							pinctrl_drvupdn);
+			if (ret < 0)
+				dev_err(mmc_dev(host->mmc),
+					"failed pads drvupdn, ret: %d\n", ret);
+		} else if ((drvup) || (drvdn)) {
+			reg = sdhci_readl(host,
+					SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+			reg &= ~SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK;
+			reg |= (drvup << 20) | (drvdn << 12);
+			sdhci_writel(host, reg,
+					SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+		}
+
+	} else {
+		/* Dual Voltage PADS Voltage selection */
+		if (!tegra_host->pad_control_available)
+			return 0;
+
+		if (voltage == MMC_SIGNAL_VOLTAGE_180) {
+			ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+						tegra_host->pinctrl_state_1v8);
+			if (ret < 0)
+				dev_err(mmc_dev(host->mmc),
+					"setting 1.8V failed, ret: %d\n", ret);
+		} else {
+			ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+						tegra_host->pinctrl_state_3v3);
+			if (ret < 0)
+				dev_err(mmc_dev(host->mmc),
+					"setting 3.3V failed, ret: %d\n", ret);
+		}
+	}
+
+	return ret;
+}
+
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -437,6 +510,7 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 			pdpu = offsets.pull_down_3v3 << 8 | offsets.pull_up_3v3;
 	}
 
+	/* Set initial offset before auto-calibration */
 	tegra_sdhci_set_pad_autocal_offset(host, pdpu);
 
 	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
@@ -460,19 +534,15 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 	if (ret) {
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 
-		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
-			pdpu = offsets.pull_down_1v8_timeout << 8 |
-			       offsets.pull_up_1v8_timeout;
-		else
-			pdpu = offsets.pull_down_3v3_timeout << 8 |
-			       offsets.pull_up_3v3_timeout;
-
-		/* Disable automatic calibration and use fixed offsets */
+		/* Disable automatic cal and use fixed Drive Strengths */
 		reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 		reg &= ~SDHCI_AUTO_CAL_ENABLE;
 		sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 
-		tegra_sdhci_set_pad_autocal_offset(host, pdpu);
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, false);
+		if (ret < 0)
+			dev_err(mmc_dev(host->mmc),
+				"Setting drive strengths failed: %d\n", ret);
 	}
 }
 
@@ -511,26 +581,46 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-3v3-timeout",
 			&autocal->pull_up_3v3_timeout);
-	if (err)
+	if (err) {
+		if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
+			(tegra_host->pinctrl_state_3v3_drv == NULL))
+			pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
+				mmc_hostname(host->mmc));
 		autocal->pull_up_3v3_timeout = 0;
+	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-down-offset-3v3-timeout",
 			&autocal->pull_down_3v3_timeout);
-	if (err)
+	if (err) {
+		if (!IS_ERR(tegra_host->pinctrl_state_3v3) &&
+			(tegra_host->pinctrl_state_3v3_drv == NULL))
+			pr_warn("%s: Missing autocal timeout 3v3-pad drvs\n",
+				mmc_hostname(host->mmc));
 		autocal->pull_down_3v3_timeout = 0;
+	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-1v8-timeout",
 			&autocal->pull_up_1v8_timeout);
-	if (err)
+	if (err) {
+		if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
+			(tegra_host->pinctrl_state_1v8_drv == NULL))
+			pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
+				mmc_hostname(host->mmc));
 		autocal->pull_up_1v8_timeout = 0;
+	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-down-offset-1v8-timeout",
 			&autocal->pull_down_1v8_timeout);
-	if (err)
+	if (err) {
+		if (!IS_ERR(tegra_host->pinctrl_state_1v8) &&
+			(tegra_host->pinctrl_state_1v8_drv == NULL))
+			pr_warn("%s: Missing autocal timeout 1v8-pad drvs\n",
+				mmc_hostname(host->mmc));
 		autocal->pull_down_1v8_timeout = 0;
+	}
 
 	err = device_property_read_u32(host->mmc->parent,
 			"nvidia,pad-autocal-pull-up-offset-sdr104",
@@ -743,32 +833,6 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return mmc_send_tuning(host->mmc, opcode, NULL);
 }
 
-static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
-	int ret;
-
-	if (!tegra_host->pad_control_available)
-		return 0;
-
-	if (voltage == MMC_SIGNAL_VOLTAGE_180) {
-		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
-					   tegra_host->pinctrl_state_1v8);
-		if (ret < 0)
-			dev_err(mmc_dev(host->mmc),
-				"setting 1.8V failed, ret: %d\n", ret);
-	} else {
-		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
-					   tegra_host->pinctrl_state_3v3);
-		if (ret < 0)
-			dev_err(mmc_dev(host->mmc),
-				"setting 3.3V failed, ret: %d\n", ret);
-	}
-
-	return ret;
-}
-
 static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
 						   struct mmc_ios *ios)
 {
@@ -778,7 +842,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
 	int ret = 0;
 
 	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
-		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
 		if (ret < 0)
 			return ret;
 		ret = sdhci_start_signal_voltage_switch(mmc, ios);
@@ -786,7 +850,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
 		ret = sdhci_start_signal_voltage_switch(mmc, ios);
 		if (ret < 0)
 			return ret;
-		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
 	}
 
 	if (tegra_host->pad_calib_required)
@@ -805,6 +869,20 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
 		return -1;
 	}
 
+	tegra_host->pinctrl_state_1v8_drv = pinctrl_lookup_state(
+				tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");
+	if (IS_ERR(tegra_host->pinctrl_state_1v8_drv)) {
+		if (PTR_ERR(tegra_host->pinctrl_state_1v8_drv) == -ENODEV)
+			tegra_host->pinctrl_state_1v8_drv = NULL;
+	}
+
+	tegra_host->pinctrl_state_3v3_drv = pinctrl_lookup_state(
+				tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");
+	if (IS_ERR(tegra_host->pinctrl_state_3v3_drv)) {
+		if (PTR_ERR(tegra_host->pinctrl_state_3v3_drv) == -ENODEV)
+			tegra_host->pinctrl_state_3v3_drv = NULL;
+	}
+
 	tegra_host->pinctrl_state_3v3 =
 		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
 	if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
-- 
2.7.4


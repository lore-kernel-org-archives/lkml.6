Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033697AbeBOOyy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 09:54:54 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14860 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033572AbeBOOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 09:53:17 -0500
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 15 Feb 2018 06:53:56 -0800
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 2/7] soc/tegra: Add Tegra194 SoC configuration option
Date: Thu, 15 Feb 2018 16:52:01 +0200
Message-ID: <20180215145206.24775-3-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215145206.24775-1-mperttunen@nvidia.com>
References: <20180215145206.24775-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the configuration option to enable support for the Tegra194
system-on-chip, and enable it by default in the arm64 defconfig.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/configs/defconfig |  1 +
 drivers/soc/tegra/Kconfig    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 78f669a21a9b..5a8f15baa850 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -537,6 +537,7 @@ CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
+CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 89ebe22a3e27..fe4481676da6 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -104,6 +104,16 @@ config ARCH_TEGRA_186_SOC
 	  multi-format support, ISP for image capture processing and BPMP for
 	  power management.
 
+config ARCH_TEGRA_194_SOC
+	bool "NVIDIA Tegra194 SoC"
+	select MAILBOX
+	select TEGRA_BPMP
+	select TEGRA_HSP_MBOX
+	select TEGRA_IVC
+	select SOC_TEGRA_PMC
+	help
+	  Enable support for the NVIDIA Tegra194 SoC.
+
 endif
 endif
 
-- 
2.16.1

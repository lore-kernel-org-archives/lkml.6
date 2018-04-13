Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeDMLgO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:36:14 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32899 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeDMLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:36:09 -0400
X-Google-Smtp-Source: AIpwx4/QaZplr2FaHAM/IcOzS8vfY3esTjC796KmV8JImfUYg0rFT4KgbEXzzPRv3dslXWRxMUYDhQ==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/15] memory: tegra: Add Tegra210 memory controller hot resets
Date: Fri, 13 Apr 2018 14:33:50 +0300
Message-Id: <f064d034477537bfb5473c1277da07d772b0d4b5.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <b063a7d44509189495825e73942329aca51e9e69.1523301400.git.digetx@gmail.com>
References: <b063a7d44509189495825e73942329aca51e9e69.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Define the table of memory controller hot resets for Tegra210.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/memory/tegra/tegra210.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index b729f49ffc8f..d00a77160407 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1080,6 +1080,48 @@ static const struct tegra_smmu_soc tegra210_smmu_soc = {
 	.num_asids = 128,
 };
 
+#define TEGRA210_MC_RESET(_name, _control, _status, _bit)	\
+	{							\
+		.name = #_name,					\
+		.id = TEGRA210_MC_RESET_##_name,		\
+		.control = _control,				\
+		.status = _status,				\
+		.bit = _bit,					\
+	}
+
+static const struct tegra_mc_reset tegra210_mc_resets[] = {
+	TEGRA210_MC_RESET(AFI,       0x200, 0x204,  0),
+	TEGRA210_MC_RESET(AVPC,      0x200, 0x204,  1),
+	TEGRA210_MC_RESET(DC,        0x200, 0x204,  2),
+	TEGRA210_MC_RESET(DCB,       0x200, 0x204,  3),
+	TEGRA210_MC_RESET(HC,        0x200, 0x204,  6),
+	TEGRA210_MC_RESET(HDA,       0x200, 0x204,  7),
+	TEGRA210_MC_RESET(ISP2,      0x200, 0x204,  8),
+	TEGRA210_MC_RESET(MPCORE,    0x200, 0x204,  9),
+	TEGRA210_MC_RESET(NVENC,     0x200, 0x204, 11),
+	TEGRA210_MC_RESET(PPCS,      0x200, 0x204, 14),
+	TEGRA210_MC_RESET(SATA,      0x200, 0x204, 15),
+	TEGRA210_MC_RESET(VI,        0x200, 0x204, 17),
+	TEGRA210_MC_RESET(VIC,       0x200, 0x204, 18),
+	TEGRA210_MC_RESET(XUSB_HOST, 0x200, 0x204, 19),
+	TEGRA210_MC_RESET(XUSB_DEV,  0x200, 0x204, 20),
+	TEGRA210_MC_RESET(A9AVP,     0x200, 0x204, 21),
+	TEGRA210_MC_RESET(TSEC,      0x200, 0x204, 22),
+	TEGRA210_MC_RESET(SDMMC1,    0x200, 0x204, 29),
+	TEGRA210_MC_RESET(SDMMC2,    0x200, 0x204, 30),
+	TEGRA210_MC_RESET(SDMMC3,    0x200, 0x204, 31),
+	TEGRA210_MC_RESET(SDMMC4,    0x970, 0x974,  0),
+	TEGRA210_MC_RESET(ISP2B,     0x970, 0x974,  1),
+	TEGRA210_MC_RESET(GPU,       0x970, 0x974,  2),
+	TEGRA210_MC_RESET(NVDEC,     0x970, 0x974,  5),
+	TEGRA210_MC_RESET(APE,       0x970, 0x974,  6),
+	TEGRA210_MC_RESET(SE,        0x970, 0x974,  7),
+	TEGRA210_MC_RESET(NVJPG,     0x970, 0x974,  8),
+	TEGRA210_MC_RESET(AXIAP,     0x970, 0x974, 11),
+	TEGRA210_MC_RESET(ETR,       0x970, 0x974, 12),
+	TEGRA210_MC_RESET(TSECB,     0x970, 0x974, 13),
+};
+
 const struct tegra_mc_soc tegra210_mc_soc = {
 	.clients = tegra210_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra210_mc_clients),
@@ -1090,4 +1132,7 @@ const struct tegra_mc_soc tegra210_mc_soc = {
 	.intmask = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
 		   MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
 		   MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM,
+	.reset_ops = &terga_mc_reset_ops_common,
+	.resets = tegra210_mc_resets,
+	.num_resets = ARRAY_SIZE(tegra210_mc_resets),
 };
-- 
2.17.0

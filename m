Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeBTQhv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:37:51 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37486 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeBTQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:36:50 -0500
X-Google-Smtp-Source: AH8x227yLYFt5A8DMdTlAhDTUHMJUl18t8JzGEtOcyZpg3nPuxF/q313P46HhRbZiYdLiWeTWjIuFw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/15] memory: tegra: Add Tegra114 memory controller hot resets
Date: Tue, 20 Feb 2018 19:36:30 +0300
Message-Id: <89e9cf16ce60e426ff1b47f921be621311c09c70.1519141896.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <c8edcd52ec69afcca6007d8c2a1045aae7333bb4.1519141896.git.digetx@gmail.com>
References: <c8edcd52ec69afcca6007d8c2a1045aae7333bb4.1519141896.git.digetx@gmail.com>
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the table of memory controller hot resets for Tegra114.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra114.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index 7560b2f558a7..e317a1836ce6 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -938,6 +938,36 @@ static const struct tegra_smmu_soc tegra114_smmu_soc = {
 	.num_asids = 4,
 };
 
+#define TEGRA114_MC_RESET(_name, _control, _status, _bit)	\
+	{							\
+		.name = #_name,					\
+		.id = TEGRA114_MC_RESET_##_name,		\
+		.control = _control,				\
+		.status = _status,				\
+		.bit = _bit,					\
+	}
+
+static const struct tegra_mc_reset tegra114_mc_resets[] = {
+	TEGRA114_MC_RESET(AFI,      0x200, 0x204,  0),
+	TEGRA114_MC_RESET(AVPC,     0x200, 0x204,  1),
+	TEGRA114_MC_RESET(DC,       0x200, 0x204,  2),
+	TEGRA114_MC_RESET(DCB,      0x200, 0x204,  3),
+	TEGRA114_MC_RESET(EPP,      0x200, 0x204,  4),
+	TEGRA114_MC_RESET(2D,       0x200, 0x204,  5),
+	TEGRA114_MC_RESET(HC,       0x200, 0x204,  6),
+	TEGRA114_MC_RESET(HDA,      0x200, 0x204,  7),
+	TEGRA114_MC_RESET(ISP,      0x200, 0x204,  8),
+	TEGRA114_MC_RESET(MPCORE,   0x200, 0x204,  9),
+	TEGRA114_MC_RESET(MPCORELP, 0x200, 0x204, 10),
+	TEGRA114_MC_RESET(MPE,      0x200, 0x204, 11),
+	TEGRA114_MC_RESET(3D,       0x200, 0x204, 12),
+	TEGRA114_MC_RESET(3D2,      0x200, 0x204, 13),
+	TEGRA114_MC_RESET(PPCS,     0x200, 0x204, 14),
+	TEGRA114_MC_RESET(SATA,     0x200, 0x204, 15),
+	TEGRA114_MC_RESET(VDE,      0x200, 0x204, 16),
+	TEGRA114_MC_RESET(VI,       0x200, 0x204, 17),
+};
+
 const struct tegra_mc_soc tegra114_mc_soc = {
 	.clients = tegra114_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra114_mc_clients),
@@ -947,4 +977,7 @@ const struct tegra_mc_soc tegra114_mc_soc = {
 	.smmu = &tegra114_smmu_soc,
 	.intmask = MC_INT_INVALID_SMMU_PAGE | MC_INT_SECURITY_VIOLATION |
 		   MC_INT_DECERR_EMEM,
+	.resets_ops = &terga_mc_resets_ops_common,
+	.resets = tegra114_mc_resets,
+	.num_resets = ARRAY_SIZE(tegra114_mc_resets),
 };
-- 
2.16.1

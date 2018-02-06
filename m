Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeBFH23 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:28:29 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12579 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeBFH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:28:10 -0500
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Feb 2018 23:28:10 -0800
From: Mikko Perttunen <mperttunen@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <talho@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 3/7] soc/tegra: pmc: Add Tegra194 compatibility string
Date: Tue, 6 Feb 2018 09:22:33 +0200
Message-ID: <1517901757-15353-4-git-send-email-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
References: <1517901757-15353-1-git-send-email-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra194 PMC is mostly compatible with Tegra186, including in all
currently supported features. As such, add a new compatibility string
but point to the existing Tegra186 SoC data for now.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ce62a47a6647..a2df230bf51a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1920,6 +1920,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
+	{ .compatible = "nvidia,tegra194-pmc", .data = &tegra186_pmc_soc },
 	{ .compatible = "nvidia,tegra186-pmc", .data = &tegra186_pmc_soc },
 	{ .compatible = "nvidia,tegra210-pmc", .data = &tegra210_pmc_soc },
 	{ .compatible = "nvidia,tegra132-pmc", .data = &tegra124_pmc_soc },
-- 
2.1.4

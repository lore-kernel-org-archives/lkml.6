Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9341C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F81F21566
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NgkD6fnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F81F21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeI1UhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:37:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8749 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeI1UhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:37:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bae36fa0000>; Fri, 28 Sep 2018 07:13:14 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 07:13:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Sep 2018 07:13:07 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:13:07 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:13:07 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 14:13:06 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bae36f10000>; Fri, 28 Sep 2018 07:13:06 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Jon Hunter" <jonathanh@nvidia.com>
Subject: [PATCH V2 4/5] soc/tegra: pmc: Don't power-up XUSB power-domains
Date:   Fri, 28 Sep 2018 15:11:49 +0100
Message-ID: <1538143910-24400-5-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538143994; bh=qy5cYZy2tUNDZUCDXLLRF30Px9H2650Lc8nDv7ApZRE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=NgkD6fnKoZJDv9idfRykO8SBoZP/IUwTf+od+1fc9C6Dp8ix6knVWF03kvsRGQio0
         Y/4ZSymEFkJH3D/4i7EnkAsGprKcZ3bfwo0q+INx2fCQUAmb5+JghcuAygWSQVtbcD
         qPj5Z+ashbBqx5weDeBm9zugtiQZb3CfbAFhkob1uOLW1nGL+rhYaVfDi3gFk0e8nm
         VK7EbGYxsSLKRdTPRu8SgJBHMfb1bpQgJKRGHHksK4Kjaj7AW67wPyw56jf28UuU6u
         uKfptKTOnrDjgrHrTK+kNa/f42rDcKBQARvnBqgUYTt42erNvHYDSX/U07TyOsBGhj
         n+c70LmvmTQwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the Tegra xHCI driver manages the XUSB power-domains itself,
remove the code to power-up the power-domains used by the xHCI device
from the PMC driver on boot.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index ab719fa90150..a68b4476b4ee 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -847,22 +847,6 @@ static void tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto remove_resets;
 	}
 
-	/*
-	 * FIXME: If XHCI is enabled for Tegra, then power-up the XUSB
-	 * host and super-speed partitions. Once the XHCI driver
-	 * manages the partitions itself this code can be removed. Note
-	 * that we don't register these partitions with the genpd core
-	 * to avoid it from powering down the partitions as they appear
-	 * to be unused.
-	 */
-	if (IS_ENABLED(CONFIG_USB_XHCI_TEGRA) &&
-	    (id == TEGRA_POWERGATE_XUSBA || id == TEGRA_POWERGATE_XUSBC)) {
-		if (off)
-			WARN_ON(tegra_powergate_power_up(pg, true));
-
-		goto remove_resets;
-	}
-
 	err = pm_genpd_init(&pg->genpd, NULL, off);
 	if (err < 0) {
 		pr_err("failed to initialise PM domain %s: %d\n", np->name,
-- 
2.7.4


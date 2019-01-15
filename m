Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDBC20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfAOQ3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:29:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57931 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731498AbfAOQ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:29:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 531C320A7D; Tue, 15 Jan 2019 17:29:00 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1EC3120A85;
        Tue, 15 Jan 2019 17:28:50 +0100 (CET)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Date:   Tue, 15 Jan 2019 17:28:36 +0100
Message-Id: <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHCI core is know properly checking for the state of a WP GPIO,
so there is no longer any need for the sdhci-omap code to implement
->get_ro() using mmc_gpio_get_ro().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
Note: this patch has only been compiled tested, as I don't have the
hardware to test it.
---
 drivers/mmc/host/sdhci-omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index d264391616f9..c2a28930086f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -987,7 +987,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 		goto err_put_sync;
 	}
 
-	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
 	host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_omap_start_signal_voltage_switch;
 	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
-- 
2.20.1


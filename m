Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514A1C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055C22183A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX11N8Cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055C22183A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeHDQg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 12:36:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42457 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeHDQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 12:36:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4-v6so3124880edp.9;
        Sat, 04 Aug 2018 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ARFNLcqbSOTKJmBSxpabm7kLQpdaLr0L+JzIeC7lego=;
        b=kX11N8Cd99Tk8CckRY5C4DNgLjHT0l8yfDnSuzkF9nXZI/0X5zNDkZUOxpEyka0QbJ
         xCE+Y71TPqFUq0B9DNDNX/mVqdnjIey6thCkWKWAY/MF8ViZbf44cQeYio3/rCOa4mdV
         xVzS2jUcrnCOiJWhIAzdtg2DyF7Jsor45pCgfywTb8KZGgYcGAIUmJdugrMTLstI56xB
         MlQi4K6Wa91osVSLWDjQnN803/XpPO3g7voYBM9WpVwEK1u5hFivp0hjP/WGFaMVyBlJ
         kl2f+xCjs6lMGwK3KgcdQHdaX5SFRo6MD6LjIq/B2c29SM/7qjMefA8UsxsG1+6Yxwjw
         X2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ARFNLcqbSOTKJmBSxpabm7kLQpdaLr0L+JzIeC7lego=;
        b=B1cSRlO6USwD6hmWCkNyP/x4GhiuJ0FdFNbhadZ5XTmgbg8jNQiuXZHHb8XhV4vdft
         1e3tzLOL2+S65qIopQGpXjwSMMzOpfuYi3G3wlO9WZ+xijbfhGTuCbTP6npIa/DFoHvf
         Kc+GH59whxJkx/svrfAYLrIQgXeI72RNRcNz7ZK228A4t+2VaSVfnDP+XgFZAL9P/yyk
         ZXbyzbGmZhxQpHvqCpVSKu5MTezF+maGWgrrMoEL6bC0u88pqM/qEZitNGGDQZ19OuRJ
         dFSwcqrqEk4+r8yrJ3hkyWHO8dqCCcuXrG6WKq+1jGfzk+ip0JmXuRi+KqwtC6MaJbYU
         ml4A==
X-Gm-Message-State: AOUpUlEciYpp5R+9nnaJw9JbPUcxl9Homtq2iXDmOfTq5b47CnY007vO
        j7MjyHE2RtogXigEdyfF38oNaxVM
X-Google-Smtp-Source: AAOMgpeQXbk4Y5hfuEw3zqylI+w/U0O1WM9dObUbj03XHm8SdthxLmWOXHsEC+YQ8wuDVRfX43hqFQ==
X-Received: by 2002:a50:9286:: with SMTP id k6-v6mr11239231eda.66.1533393330831;
        Sat, 04 Aug 2018 07:35:30 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.13])
        by smtp.gmail.com with ESMTPSA id y20-v6sm589379edq.55.2018.08.04.07.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 07:35:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] iommu/tegra: gart: Clean up drivers module code
Date:   Sat,  4 Aug 2018 17:29:58 +0300
Message-Id: <20180804143003.15817-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804143003.15817-1-digetx@gmail.com>
References: <20180804143003.15817-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART driver is built-in, hence it can't be unloaded and the module removal
code is never used. This patch merely removes the dead code and makes
GART driver explicitly built-in by dropping the drivers bind/unbind sysfs
attributes. Lastly disallow to defer drivers probing, since it's a core
driver and actually nothing should cause the deferred probe.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index f8b653e25914..141ff0c79ee4 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -502,20 +502,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra_gart_remove(struct platform_device *pdev)
-{
-	struct gart_device *gart = platform_get_drvdata(pdev);
-
-	iommu_device_unregister(&gart->iommu);
-	iommu_device_sysfs_remove(&gart->iommu);
-
-	writel(0, gart->regs + GART_CONFIG);
-	if (gart->savedata)
-		vfree(gart->savedata);
-	gart_handle = NULL;
-	return 0;
-}
-
 static const struct dev_pm_ops tegra_gart_pm_ops = {
 	.suspend	= tegra_gart_suspend,
 	.resume		= tegra_gart_resume,
@@ -529,26 +515,21 @@ MODULE_DEVICE_TABLE(of, tegra_gart_of_match);
 
 static struct platform_driver tegra_gart_driver = {
 	.probe		= tegra_gart_probe,
-	.remove		= tegra_gart_remove,
 	.driver = {
 		.name	= "tegra-gart",
 		.pm	= &tegra_gart_pm_ops,
 		.of_match_table = tegra_gart_of_match,
+		.suppress_bind_attrs = true,
 	},
+	.prevent_deferred_probe = true,
 };
 
-static int tegra_gart_init(void)
+static int __init tegra_gart_init(void)
 {
 	return platform_driver_register(&tegra_gart_driver);
 }
-
-static void __exit tegra_gart_exit(void)
-{
-	platform_driver_unregister(&tegra_gart_driver);
-}
-
 subsys_initcall(tegra_gart_init);
-module_exit(tegra_gart_exit);
+
 module_param(gart_debug, bool, 0644);
 
 MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
-- 
2.18.0


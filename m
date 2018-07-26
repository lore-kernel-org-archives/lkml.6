Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5322C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C66A20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iADdKXyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C66A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeG0Alh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:41:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40450 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732000AbeG0Alg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:41:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id y200-v6so2318733lfd.7;
        Thu, 26 Jul 2018 16:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gWulCqaqXR15Jcn4BTz7nY1Dimo7wlyI3fOTGoNV13g=;
        b=iADdKXykWMU+Y13VmGdlp/cWQXgqU4Ht7ZMo/ynfzxJu2aRfWXbAdfP6K57Hn7VS9A
         n3ZUZQLI6UFUYQlulSHoWim1KG44a2/chH22ECZO9FbBvMZrN7quSJkwFGDaUKttfJWY
         CU6gNKSVaHdw2nrpTlFkM/dsw2qjGSqs3vbMihVMg12saJJtdETB3JhDqLWcMJCZI14+
         V+8GZ9Aqu5pEzmaVNIm7RdTNl4+9D/77IoI3Ncumy1V9DKK6o+sqHAaiielSnnC1qAUH
         oAl/ApZscMB/Kz7W5iKvnl3uQH4fnqac5TeBMALz6YniKoMG/XKsg2uhDXjN373zTY2Q
         nTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gWulCqaqXR15Jcn4BTz7nY1Dimo7wlyI3fOTGoNV13g=;
        b=byzLleIx6tbfodQFMIFSrPyLsk+i8LwaqAhQD5O2PmdLFk0z4DKba1ikb7HNVz8yx1
         2+MQVO6mh9Hq4QwAewprJ1SEltpmDwESHGySdO7XLVIG4T/SE5hUoOFxqFc9erR7KCgD
         xmAzy8baR3Znxu6m3gJ7bRBNGRBv80LS/Gt81PgnhH++7o7jgs/TdfykuwTjPN+3EHSO
         siFc7gwzp7TaSnk4Sll+U4E9FT/2pdP8iDP5hBASgt65twUbhvWwttAA0ZI1ykCz8q6B
         ILKlsfGGjVY+mh4rivAhUCM/aYypYxLkGLQ2uDrUPWcdTEkHl4QGvGmKfBrx7TEjDQeO
         3OdQ==
X-Gm-Message-State: AOUpUlHzYrI34yd9o2EuAMEicgof9jz1IrvW4GZuyDvl5Haag5EM4+lY
        +CtsqieyMtpyxrP5jsJECrE=
X-Google-Smtp-Source: AAOMgpdsARcWGyY3rphCjfZTnRFuC/De1O2rpsI6GtgezCrd4WZFT4r0IMyB5kZY06je67KyodA0Zw==
X-Received: by 2002:a19:501e:: with SMTP id e30-v6mr2449667lfb.71.1532647353445;
        Thu, 26 Jul 2018 16:22:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q15-v6sm411541ljg.62.2018.07.26.16.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:22:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/6] drm/tegra: Avoid implicit DMA backing with IOMMU
Date:   Fri, 27 Jul 2018 02:16:21 +0300
Message-Id: <20180726231624.21084-4-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra DRM manages IOMMU by itself, backing DMA with IOMMU by the drivers
core breaks the Tegra driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c   | 1 +
 drivers/gpu/drm/tegra/gr2d.c | 1 +
 drivers/gpu/drm/tegra/gr3d.c | 1 +
 drivers/gpu/drm/tegra/vic.c  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index eb9bb83f8f5d..4827770939e3 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2675,6 +2675,7 @@ static const struct dev_pm_ops tegra_dc_pm_ops = {
 struct platform_driver tegra_dc_driver = {
 	.driver = {
 		.name = "tegra-dc",
+		.no_implicit_iommu = true,
 		.of_match_table = tegra_dc_of_match,
 		.pm = &tegra_dc_pm_ops,
 	},
diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 3c5503f1bf3d..e427585ef5cc 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -327,6 +327,7 @@ static int gr2d_remove(struct platform_device *pdev)
 struct platform_driver tegra_gr2d_driver = {
 	.driver = {
 		.name = "tegra-gr2d",
+		.no_implicit_iommu = true,
 		.of_match_table = gr2d_match,
 	},
 	.probe = gr2d_probe,
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 651e697ccbba..f54710c36afb 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -481,6 +481,7 @@ static int gr3d_remove(struct platform_device *pdev)
 struct platform_driver tegra_gr3d_driver = {
 	.driver = {
 		.name = "tegra-gr3d",
+		.no_implicit_iommu = true,
 		.of_match_table = tegra_gr3d_match,
 	},
 	.probe = gr3d_probe,
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 0e6642bb8524..4ecc466ee490 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -402,6 +402,7 @@ static const struct dev_pm_ops vic_pm_ops = {
 struct platform_driver tegra_vic_driver = {
 	.driver = {
 		.name = "tegra-vic",
+		.no_implicit_iommu = true,
 		.of_match_table = vic_match,
 		.pm = &vic_pm_ops
 	},
-- 
2.18.0


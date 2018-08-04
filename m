Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD60C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD5A2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYDznb1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD5A2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeHDCEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:04:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40669 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbeHDCEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:04:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id x5-v6so3544040pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SaSEMJhztCx4+OzbPsdgRi8XbeXf6VD4gQdmaadiG10=;
        b=TYDznb1sqvK/wtRwqeI9dosgH2VTwgJQlffHAOtO4h0tyHUgtASXLZR+vO7HuB9Sow
         W+wfZr9M0flP+YIlOizgH39Cw3GeYQEHyTzCy6c1Oy+wsa3PLGG5Sinulxpu6h40hpLs
         bPDT7QggLu6+3Wr2Ufa/Um1biDNKM3s6+UwSprQW/ddOK3A5y/mHN+9Wjd10T2X8/Df7
         X4oc3VXFsuw7mlwK3bunMgaMiG6qaXYcTxX/NGz6KQ++y+E2M97JhXagrXfKVhXMlzQO
         w2xCsUTKTIF2LI62k6a1EoKt+E//e0q27U3B7LgR9fpE59eFwwpSs/CZMazvjcNwmQOA
         zQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SaSEMJhztCx4+OzbPsdgRi8XbeXf6VD4gQdmaadiG10=;
        b=hIirKexCpdETO0gYntgI7c1BNtCVtLsZMbfRfwf6/tPL4vYKOgN+G96r3LY00ShOah
         TouUkiJfrerRgJz5+aJZgHqJ+ZUuXJzfFqZplDjRiRfGzN4Jl8QXZyAqQkKDTl6u5Ldp
         vCkZ8I+XOXm6BJdmWhkokF/m85QUfjbUX/7bQY6IPwfNiKCy4J27Td6xXEX1GOg4OhV7
         TtzgB7jJL3cmWx46oFjoeo3L2bbqlgc890PeMlGi7pSgvgEKFhJAHm6cNdGFfH2D2SBj
         gqj8T8sJY1aLDyh9YcnPaTxvGK2fqrClOjV3QSq2iBeFaq3jNKGNNhvQVVLtk/fAXg+h
         +2SQ==
X-Gm-Message-State: AOUpUlF2iVinzU3jHPCUITxkqw1GX9iM2LP+xGs0YppEZRwCFMVKBNRE
        nZ/AAy3BSHBQDIGPv8dDwj4=
X-Google-Smtp-Source: AAOMgpe5lJ/5g9MrUSIKnKd6NOh4ZwjQG6fWoqkvLPas83eXHiKqE1w1ogtJ/zQu9nb34nYyWA9m1g==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr5638034pgq.174.1533341160960;
        Fri, 03 Aug 2018 17:06:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id g15-v6sm9425986pfg.98.2018.08.03.17.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:06:00 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: rs600: Replace mdelay() with msleep() and usleep_range() in rs600_asic_reset()
Date:   Sat,  4 Aug 2018 08:05:52 +0800
Message-Id: <20180804000552.17886-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rs600_asic_reset() is never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/rs600.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index f16af119c688..1a97f5fd719b 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -472,30 +472,30 @@ int rs600_asic_reset(struct radeon_device *rdev, bool hard)
 	pci_save_state(rdev->pdev);
 	/* disable bus mastering */
 	pci_clear_master(rdev->pdev);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	/* reset GA+VAP */
 	WREG32(R_0000F0_RBBM_SOFT_RESET, S_0000F0_SOFT_RESET_VAP(1) |
 					S_0000F0_SOFT_RESET_GA(1));
 	RREG32(R_0000F0_RBBM_SOFT_RESET);
-	mdelay(500);
+	msleep(500);
 	WREG32(R_0000F0_RBBM_SOFT_RESET, 0);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	status = RREG32(R_000E40_RBBM_STATUS);
 	dev_info(rdev->dev, "(%s:%d) RBBM_STATUS=0x%08X\n", __func__, __LINE__, status);
 	/* reset CP */
 	WREG32(R_0000F0_RBBM_SOFT_RESET, S_0000F0_SOFT_RESET_CP(1));
 	RREG32(R_0000F0_RBBM_SOFT_RESET);
-	mdelay(500);
+	msleep(500);
 	WREG32(R_0000F0_RBBM_SOFT_RESET, 0);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	status = RREG32(R_000E40_RBBM_STATUS);
 	dev_info(rdev->dev, "(%s:%d) RBBM_STATUS=0x%08X\n", __func__, __LINE__, status);
 	/* reset MC */
 	WREG32(R_0000F0_RBBM_SOFT_RESET, S_0000F0_SOFT_RESET_MC(1));
 	RREG32(R_0000F0_RBBM_SOFT_RESET);
-	mdelay(500);
+	msleep(500);
 	WREG32(R_0000F0_RBBM_SOFT_RESET, 0);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	status = RREG32(R_000E40_RBBM_STATUS);
 	dev_info(rdev->dev, "(%s:%d) RBBM_STATUS=0x%08X\n", __func__, __LINE__, status);
 	/* restore PCI & busmastering */
-- 
2.17.0


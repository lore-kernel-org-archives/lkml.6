Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8477C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807462176D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjcpegYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807462176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeHDCRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:17:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35380 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbeHDCRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:17:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so3233323plq.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZukhOIu0CUod2Wi4pWyIZv0ruQ09mhO1Pq4jRI44TKM=;
        b=SjcpegYaUU5vEiVQPTfq0KOudd4sn3K+eqbl6BsmquRoX2a0D4u5NLX70fCKV1tv2+
         0/os8twjRmGvO1mAweRgXgjyed7Taq6WY9emzH5f7nO4sMmv8zbb8ZU8nDO6/Cp5a2VN
         2+8ZpwG468PYg3s9gP5sh5o+E98FcsAkkD2hcv2u7Lq591VVFZELL6GGx3nYMNNp0M3J
         bMvxhdPeY21sHSVS+EWxfVExEmSIAPz+pzihoPry4Q24FXmRbfjy1gbH+IwW5hIgTNx3
         aVZwL5/mJ8mZ6nTip8ZDQ3G9gIZq+g7mmVDnZMxZ/Wru3M7CoZ8wkh7tvGCOpRWbJabc
         f4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZukhOIu0CUod2Wi4pWyIZv0ruQ09mhO1Pq4jRI44TKM=;
        b=biGX9Axzfw3Fe7MW/Bb4SS5h+17M25yNmI1YAAtGpsYbR54+Ydjq5QMKb9b5XqlS/3
         Yp6RZLZZ/+E7vL7NnDGs/0K5u4zWcCrKb78xA7ZdLEd8XipiaqnrfnagMDcIZtS6At89
         X6kSE61FN1LzQxt0dCDw/KLtK9CvnXMz7YXaBFG2TdclIt+VCfDoQK+0tHfL3NTIziY3
         M+A7fopZ1sP2g7KeIeq0cVmi08kGs0PC2PDfq4xkBhY2keM3Q/+WmLJ/wEJMky1niz6R
         8eMS1gTH3AX12j7sXCvdk04aM8rVTsv8Q7Qe6O1QdCoeix6OrctlsW1Hi99b++pfAy58
         U6wQ==
X-Gm-Message-State: AOUpUlGas59n0X8C4VlANgkQmaAW3d3jWiUPuSE6dTCw+vOl/wf2zFN2
        V1GYuT/ea9N8Fo/yuWP0HYE=
X-Google-Smtp-Source: AAOMgpcC1CDJew2vDPDZeviDGJBpvfI2FUHThkhIhq39qrEhJ4esvdAJZsq4siam7hmbuVFgUyrNAw==
X-Received: by 2002:a17:902:7009:: with SMTP id y9-v6mr5545179plk.249.1533341928638;
        Fri, 03 Aug 2018 17:18:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id k1-v6sm5944812pfi.62.2018.08.03.17.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:18:48 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: r100: Replace mdelay() with msleep() and usleep_range() in r100_asic_reset()
Date:   Sat,  4 Aug 2018 08:18:40 +0800
Message-Id: <20180804001840.18105-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r100_asic_reset() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/r100.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 7d39ed63e5be..09c418113d9a 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -2576,17 +2576,17 @@ int r100_asic_reset(struct radeon_device *rdev, bool hard)
 					S_0000F0_SOFT_RESET_PP(1) |
 					S_0000F0_SOFT_RESET_RB(1));
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
 	/* restore PCI & busmastering */
-- 
2.17.0


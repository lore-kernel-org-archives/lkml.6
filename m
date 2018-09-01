Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0227AC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924E120843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofTEIfGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924E120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbeIAQco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 12:32:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33482 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIAQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 12:32:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id y3-v6so5403885pgv.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WtPEWrt9G9eyil6yu+3BOjNXbguLNPBLA+11spTOCHU=;
        b=ofTEIfGzwMVvBgnVmpbN6Tsg8TfuT6p3pAW4ZVmuMwurdrrZEi0s3RCwbfKcMqfgtr
         9QAbUqa4ECScTjuTc92jGd6v+R8bhtESEPpGmzCxf4Y0MYS3GtuEpuYL0khY9B2QVAYt
         NoiSiFpNm3ILGdqoQwF7qWadR9/VCWIkC98brOh1bG/gKthdhU3/jf8IdLMPyGzs5Y2q
         fRgKeZ5+GDpcrPwZj5UvgOZxUKnw4ZluCJSIbi8FieItFty7a5UzcLex1jp6X6QoeexZ
         M+ucvMv+XUcVW9E8FMxHtQ3sgFhd6TaVETg4OApW4xMd96IRRyg4jMQ/wrBiZzINqGfs
         9Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WtPEWrt9G9eyil6yu+3BOjNXbguLNPBLA+11spTOCHU=;
        b=sh5YhF5aUWypCCSUrAk3XiaRmfFUp4T7d4Fm/pi7brXm2WGT+PRZIO7qDH0apfarkf
         YPfwFS0o0s/XY9mP+/C81Rrhj5tKdFwYpdO9mAs8tur4TmrQW2leGmJrWkGcT/xlqhjr
         +XVgq6lm32U+iBzcmCS6tewLPrWV8FXjifJYmagdSCAXtfAd5DTSJA52/lMoTrSulJff
         y4R1LpOIBmlcR8SgcmGqdgC68mnFzZCG28K90l/bGli5MLy9HNQ3T5U+ALFCTVEMRwSI
         CHb+rp/iAjUl8V9QCvUjShnzrhyLDUaR7RwIA0CuPAkSAUzLs6BDcbhFwnPBD9GeTWNT
         xalA==
X-Gm-Message-State: APzg51BLxhZRYNGzyUFof0gkC+6gf5ad6ZLHgQEQUKry5hUAJ7RVEg6A
        5q8y6nO+HNOrqlz5UyWt7zI=
X-Google-Smtp-Source: ANB0Vda/n/G1j8emWjQitJJsL1pXqdxCJ3CnKlHPM+sWAhgBuL8PsTVplA9TWW5eGW8IjE1Ujyo4FA==
X-Received: by 2002:a62:b0b:: with SMTP id t11-v6mr16630632pfi.36.1535804451889;
        Sat, 01 Sep 2018 05:20:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id r81-v6sm18441435pfa.18.2018.09.01.05.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 05:20:51 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: drm_mm: Fix a sleep-in-atomic-context bug in show_leaks()
Date:   Sat,  1 Sep 2018 20:20:41 +0800
Message-Id: <20180901122041.2357-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kmalloc(GFP_KERNEL)
drivers/gpu/drm/drm_mm.c, 130: 
	kmalloc in show_leaks
drivers/gpu/drm/drm_mm.c, 913: 
	show_leaks in drm_mm_takedown
drivers/gpu/drm/drm_vma_manager.c, 107: 
	drm_mm_takedown in drm_vma_offset_manager_destroy
drivers/gpu/drm/drm_vma_manager.c, 106: 
	_raw_write_lock in drm_vma_offset_manager_destroy

[FUNC] kmalloc(GFP_KERNEL)
drivers/gpu/drm/drm_mm.c, 130: 
	kmalloc in show_leaks
drivers/gpu/drm/drm_mm.c, 913: 
	show_leaks in drm_mm_takedown
drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 71: 
	drm_mm_takedown in amdgpu_vram_mgr_fini
drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c, 70: 
	spin_lock in amdgpu_vram_mgr_fini

[FUNC] kmalloc(GFP_KERNEL)
drivers/gpu/drm/drm_mm.c, 130: 
	kmalloc in show_leaks
drivers/gpu/drm/drm_mm.c, 913: 
	show_leaks in drm_mm_takedown
drivers/gpu/drm/ttm/ttm_bo_manager.c, 128: 
	drm_mm_takedown in ttm_bo_man_takedown
drivers/gpu/drm/ttm/ttm_bo_manager.c, 126: 
	spin_lock in ttm_bo_man_takedown

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/drm_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 3166026a1874..2486121a78d4 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -127,7 +127,7 @@ static void show_leaks(struct drm_mm *mm)
 	unsigned long entries[STACKDEPTH];
 	char *buf;
 
-	buf = kmalloc(BUFSZ, GFP_KERNEL);
+	buf = kmalloc(BUFSZ, GFP_ATOMIC);
 	if (!buf)
 		return;
 
-- 
2.17.0


Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459D1C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D794E2178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NteLC9av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D794E2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeHDCLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 22:11:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44544 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbeHDCLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 22:11:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so3541163pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X1vteZSWKJf1WloY/XceYOPMjMFxG8CKOfWN46xrO6M=;
        b=NteLC9avtmhHY9JMliuT9yOoAuBlccLEiUvAcrxymu+hwghNITrtGjrwn6yCQB1NnZ
         0MTkjH3W855/0Of6ePpjLCZRRUoHp8fYgr0x9bLXt8oPWS5T9rLBo0qUxfaYozKwlFHc
         cRK9MhTLU5xZg4NbxknTUmml4vjCCRxLClpz92MFM2DkiyBhQdhXRgdIvRhS5+EfRLiL
         GMyBXsnsqvACX9XWy2siwYWa9olrEV3oCIZua+NR3xJqstRJlJpnM+fKB1pHIO3MZXXF
         Al51J/NQ+iEuMtzvmFFjB1Ca3GamewVNRZnsas2tN7lzNhFdSWB0KWI8WHopc0PoURWs
         L54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X1vteZSWKJf1WloY/XceYOPMjMFxG8CKOfWN46xrO6M=;
        b=iwi0e24+Xmch0k/RbclcNt/FNRbdPqT/Sy2S8F01jHJZDMmESi4VqpvLSmrKs5GEpx
         2UNbzkMCR/QgaYh/nLSxYgB8khO++JRJmC2w9gSl8sLul2uIBV0bnI3SW9fKoWYgW3N0
         /1c8K1DmNiYlW07bzx6z55jdm79T4AiYr+tSwtMxwdQt7tADul+PXXZZfhGk/GN+zzqZ
         SE6IarT9DodD61rySP3b9zsEEQ5lB2PHkoLary5SZnbtJK/juGA5zQAo8wF+LgsFaNUt
         kFto3QXLMHFg6aU/BFx7J1M0k2R90prdW83x6BZ7M81AaZB0+hG8nmvlLo8DoQHUaCws
         mk7w==
X-Gm-Message-State: AOUpUlE2Dal12D+xaSVLeIV0lA5Bp+31qhi/q/62BAky6zDUnm2sYqPC
        5lAKQ44Be2Q3P1cjvbjh/mQ=
X-Google-Smtp-Source: AAOMgpcbNzNWPyjbL5fi3yzOIFFD+J+3uerwWC5sIz71JXpajtne7l1hgSzGjMyqF2az5o+z2M24wA==
X-Received: by 2002:a62:c00c:: with SMTP id x12-v6mr6781956pff.216.1533341585915;
        Fri, 03 Aug 2018 17:13:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id g11-v6sm12162560pgi.90.2018.08.03.17.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:13:05 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: r600: Replace mdelay() and udelay() with msleep() and usleep_range()
Date:   Sat,  4 Aug 2018 08:12:52 +0800
Message-Id: <20180804001252.17995-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r600_gpu_soft_reset() and r600_gpu_pci_config_reset() are never
called in atomic context.
They call mdelay() and udelay() to busily wait, which is not necessary.
mdelay() and udelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/r600.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index e06e2d8feab3..de5f6d9f251e 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -1705,7 +1705,7 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 		WREG32(DMA_RB_CNTL, tmp);
 	}
 
-	mdelay(50);
+	msleep(50);
 
 	rv515_mc_stop(rdev, &save);
 	if (r600_mc_wait_for_idle(rdev)) {
@@ -1782,7 +1782,7 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 		WREG32(R_008020_GRBM_SOFT_RESET, tmp);
 		tmp = RREG32(R_008020_GRBM_SOFT_RESET);
 
-		udelay(50);
+		usleep_range(50, 100);
 
 		tmp &= ~grbm_soft_reset;
 		WREG32(R_008020_GRBM_SOFT_RESET, tmp);
@@ -1796,7 +1796,7 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 		WREG32(SRBM_SOFT_RESET, tmp);
 		tmp = RREG32(SRBM_SOFT_RESET);
 
-		udelay(50);
+		usleep_range(50, 100);
 
 		tmp &= ~srbm_soft_reset;
 		WREG32(SRBM_SOFT_RESET, tmp);
@@ -1804,10 +1804,10 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 	}
 
 	/* Wait a little for things to settle down */
-	mdelay(1);
+	usleep_range(1000, 2000);
 
 	rv515_mc_resume(rdev, &save);
-	udelay(50);
+	usleep_range(50, 100);
 
 	r600_print_gpu_status_regs(rdev);
 }
@@ -1835,7 +1835,7 @@ static void r600_gpu_pci_config_reset(struct radeon_device *rdev)
 	tmp &= ~DMA_RB_ENABLE;
 	WREG32(DMA_RB_CNTL, tmp);
 
-	mdelay(50);
+	msleep(50);
 
 	/* set mclk/sclk to bypass */
 	if (rdev->family >= CHIP_RV770)
@@ -1857,12 +1857,12 @@ static void r600_gpu_pci_config_reset(struct radeon_device *rdev)
 
 	/* reset */
 	radeon_pci_config_reset(rdev);
-	mdelay(1);
+	usleep_range(1000, 2000);
 
 	/* BIF reset workaround.  Not sure if this is needed on 6xx */
 	tmp = SOFT_RESET_BIF;
 	WREG32(SRBM_SOFT_RESET, tmp);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	WREG32(SRBM_SOFT_RESET, 0);
 
 	/* wait for asic to come out of reset */
-- 
2.17.0

